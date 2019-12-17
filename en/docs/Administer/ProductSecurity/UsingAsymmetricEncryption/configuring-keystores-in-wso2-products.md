# admin\_Configuring Keystores in WSO2 Products

After you have [created a new keystore and updated the `client-truststore.jks` file](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) , you must update a few configuration files in order to make the keystores work. Note that keystores are used for multiple functions in WSO2 products, which includes authenticating communication over SSL/TLS, encrypting passwords and other confidential information in configuration files etc. Therefore, you must update the specific configuration files with the updated keystore information. For example, you may have separate keystores for the purpose of encrypting passwords in configuration files, and for authenticating communication over SSL/TLS.

The `wso2carbon.jks` keystore file, which is shipped with all WSO2 products, is used as the default keystore for all functions. However, in a production environment, it is recommended to create new keystores with new keys and certificates.

!!! note
Please note that in WSO2 IoT Server and WSO2 Enterprise Integrator the `<PRODUCT_HOME>/repository/conf` directory is in the following location: `<PRODUCT_HOME>/conf`

!!! tip
If you want an easy way to locate all the configuration files that have references to keystores, you can use the `grep` command as follows:

1.  Open a command prompt and navigate to the `<PRODUCT_HOME>/repository/conf/` directory where your product stores all configuration files.
2.  Execute the following command: `grep -nr ".jks"` .

The configuration files and the keystore files referred to in each file are listed out. See an example of this below.

``` java
    ./axis2/axis2.xml:260:                <Location>repository/resources/security/wso2carbon.jks</Location>
    ./axis2/axis2.xml:431:                <Location>repository/resources/security/wso2carbon.jks</Location>
    ./carbon.xml:316:            <Location>${carbon.home}/repository/resources/security/wso2carbon.jks</Location>
    ./carbon.xml:332:            <Location>${carbon.home}/repository/resources/security/wso2carbon.jks</Location>
    ./identity.xml:180:             <Location>${carbon.home}/repository/resources/security/wso2carbon.jks</Location>
    ./security/secret-conf.properties:21:#keystore.identity.location=repository/resources/security/wso2carbon.jks
```


See the following for details:

-   [Before you begin](#admin_ConfiguringKeystoresinWSO2Products-Beforeyoubegin)
-   [Configuring the primary keystore](#admin_ConfiguringKeystoresinWSO2Products-ConfiguringtheprimarykeystoreConfiguringtheprimarykeystore)
-   [Configuring a separate keystore for encrypting data in internal data stores](#admin_ConfiguringKeystoresinWSO2Products-second_keystore_internal_dataConfiguringaseparatekeystoreforencryptingdataininternaldatastores)
-   [Configuring a secondary keystore (for SSL connections)](#admin_ConfiguringKeystoresinWSO2Products-ConfiguringakeystoreforSSLconnectionsConfiguringasecondarykeystore(forSSLconnections))
-   [Configuring a keystore for Java permissions](#admin_ConfiguringKeystoresinWSO2Products-ConfiguringakeystoreforJavapermissionsConfiguringakeystoreforJavapermissions)
-   [Configuring keystores for WS-Security](#admin_ConfiguringKeystoresinWSO2Products-ConfiguringkeystoresforWS-SecurityConfiguringkeystoresforWS-Security)
-   [What's next?](#admin_ConfiguringKeystoresinWSO2Products-What'snext?)

### Before you begin

-   Be sure to go through the [recommendations for setting up keystores in WSO2 products](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption#UsingAsymmetricEncryption-recommendations) to understand the various keystores you will need.
-   If you haven't already created the keystores required for your system, see the instructions for [creating new keystores](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) .

### Configuring the primary keystore

The primary keystore of WSO2 products are configured by the `Keystore` element in the `carbon.xml` file (stored in the &lt; `PRODUCT_HOME>/repository/conf/` directory). This keystore is used for the following functions in WSO2 products by default.

-   **Encrypting/decrypting** passwords and other confidential information, which are maintained in various configuration files as well as internal data stores. Note that you also have the option of [separating the keystore for encrypting information in internal data stores](#admin_ConfiguringKeystoresinWSO2Products-second_keystore_internal_data) .
-   **Signing messages** when the WSO2 product communicates with external parties (such SAML, OIDC id\_token signing).

The default configuration is shown below.

``` java
    <KeyStore>
        <Location>${carbon.home}/resources/security/wso2carbon.jks</Location>
        <Type>JKS</Type>
        <Password>wso2carbon</Password>
        <KeyAlias>wso2carbon</KeyAlias>
        <KeyPassword>wso2carbon</KeyPassword>
    </KeyStore>
     
    <TrustStore>
        <!-- trust-store file location -->
        <Location>${carbon.home}/repository/resources/security/client-truststore.jks</Location>
        <!-- trust-store type (JKS/PKCS12 etc.) -->
        <Type>JKS</Type> 
        <!-- trust-store password -->
        <Password>wso2carbon</Password>
    </TrustStore>
```

### Configuring a separate keystore for encrypting data in internal data stores

!!! info
This feature is available via the WUM update 2792 released on the 8th of July 2018 for the following product versions:

-   WSO2 Identity Server 5.5.0
-   WSO2 API Manager 2.2.0
-   WSO2 Data Analytics Server 3.2.0
-   WSO2 Enterprise Integrator 6.2.0

This is available as part of the newly introduced Crypto Service. It is an extensible framework that facilitates the cryptography needs of WSO2 products.


Currently, the primary keystore configured by the `<Security>/<KeyStore>` element in the `<PRODUCT_HOME>/repository/conf/carbon.xml` file is used for internal data encryption (encrypting data in internal data stores and configuration files) as well as for signing messages that are communicated with external parties. However, it is sometimes a common requirement to have separate keystores for communicating messages with external parties (such SAML, OIDC id\_token signing) and for encrypting information in internal data stores. This is because, for the first scenario of signing messages, the keystore certificates need to be frequently renewed. However, for encrypting information in internal data stores, the keystore certificates should not be changed frequently because the data that is already encrypted will become unusable every time the certificate changes.

This feature allows you to create a separate keystore for encrypting data in internal data stores. Follow the instructions given below.

!!! warning
**Warning** : Using a totally new keystore for internal data encryption in an existing deployment will make already encrypted data unusable. In such cases, an appropriate data migration effort is needed.


1.  Enable the Crypto Service by adding the following configuration block to the `<PRODUCT_HOME>/repository/conf/carbon.xml` file.

    ``` xml
        <CryptoService>
          <Enabled>true</Enabled>
          <InternalCryptoProviderClassName>org.wso2.carbon.crypto.provider.KeyStoreBasedInternalCryptoProvider</InternalCryptoProviderClassName>
          <ExternalCryptoProviderClassName>org.wso2.carbon.core.encryption.KeyStoreBasedExternalCryptoProvider</ExternalCryptoProviderClassName>
          <KeyResolvers>
            <KeyResolver className="org.wso2.carbon.crypto.defaultProvider.resolver.ContextIndependentKeyResolver" priority="-1"/>
          </KeyResolvers>
        </CryptoService>
    ```

2.  Configure the new keystore by adding the following configuration block inside the `<Security>` tag in the `<PRODUCT_HOME>/repository/conf/carbon.xml` file.

        !!! note
    **Note** : The values of the properties such as passwords must be changed based on the keystore.


    ``` xml
        <InternalKeyStore>
          <Location>${carbon.home}/repository/resources/security/internal.jks</Location>
          <Type>JKS</Type>
          <Password>wso2carbon</Password>
          <KeyAlias>wso2carbon</KeyAlias>
          <KeyPassword>wso2carbon</KeyPassword>
        </InternalKeyStore>
    ```

### Configuring a secondary keystore (for SSL connections)

The `catalina-server.xml` file stored in the `<PRODUCT_HOME>/repository/conf/tomcat/` directory should be updated with the keystore used for certifying SSL connections to Carbon servers. Given below is the default configuration in the `catalina-server.xml` file, which points to the default keystore in your product.

``` java
    keystoreFile="${carbon.home}/repository/resources/security/wso2carbon.jks"
    keystorePass="wso2carbon"
```

If you are using WSO2 API Manager (WSO2 APIM) or the ESB of WSO2 Enterprise Integrator (WSO2 EI), you need to update the keystore information in the `axis2.xml` file (in addition to the `catalina-server.xml` file explained above). **Note** that the `axis2.xml` file is stored in the `<APIM_HOME>/repository/conf/axis2/` directory for APIM, and the `<EI_HOME>/conf/axis2/` directory for the ESB of WSO2 EI.

-   [**Transport Listener**](#7848ac9b6b384afa8e2fcd8034afb6a0)
-   [**Transport Sender**](#fe05d3e8d9134604befb2f70ac59ea14)

``` java
    <transportReceiver name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpSSLListener">
            <parameter name="keystore" locked="false">
                <KeyStore>
                    <Location>repository/resources/security/wso2carbon.jks</Location>
                    <Type>JKS</Type>
                    <Password>wso2carbon</Password>
                    <KeyPassword>wso2carbon</KeyPassword>
                </KeyStore>
            </parameter>       
    </transportReceiver>
```

``` java
    <transportSender name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpSSLSender">
            <parameter name="keystore" locked="false">
                <KeyStore>
                    <Location>repository/resources/security/newkeystore.jks</Location>
                    <Type>JKS</Type>
                    <Password>mypassword</Password>
                    <KeyPassword>mypassword</KeyPassword>
                </KeyStore>
            </parameter>
    </transportSender>
```

### Configuring a keystore for Java permissions

The [Java Security Manager](https://docs.wso2.com/display/ADMIN44x/Enabling+Java+Security+Manager) is used for defining various security policies that prevent untrusted code from manipulating your system. Enabling the Java Security Manager for WSO2 products will activate the Java permissions that are in the `<PRODUCT_HOME>/repository/conf/sec.policy` file. Administrators can modify this file to change the Java security permissions as required and grant various application-level permissions to the signed and trusted code using Java.

If you are granting specific Java-level permissions to some signed code, you should import the public key certificate of the signer as a trusted certificate to one of your keystores. You must then update the `sec.policy` file with the keystore path and the alias of the certificate as shown below.

``` java
    keystore "file:${user.dir}/repository/resources/security/wso2carbon.jks", "JKS";
```

Following is the default keystore configuration in the sec.policy file, which grants all Java-level permissions to the code signed by the certificate that uses the “wso2carbon” alias.

``` java
    grant signedBy "wso2carbon" {
      permission java.security.AllPermission;
    };
```

### Configuring keystores for WS-Security

If there are WS-Security scenarios implemented in your WSO2 product, you can use separate keystores for these scenarios. WS-Security is used for proxy services and data services in the ESB. See the documentation of [WSO2 Enterprise Integrator (WSO2 EI)](https://wso2.com/integration) for instructions on applying security policies for proxy services, and data services.

### What's next?

Some WSO2 products will use keystore for more use cases than the ones listed above. See the [documentation for your WSO2 product](https://docs.wso2.com/dashboard.action) for instructions.
