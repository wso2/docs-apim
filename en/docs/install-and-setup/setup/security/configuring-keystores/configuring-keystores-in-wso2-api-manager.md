# Configuring Keystores in WSO2 API Manager

WSO2 products use asymmetric cryptography by default for the purposes of authentication and data encryption. In asymmetric cryptography, keystores (with key pairs and certificates) are created and stored for the product. Keystore is a repository where private keys and certificates can be stored. It is possible to have multiple keystores so that the keys used for different use cases are kept unique. For more information about keystores and its concepts, see [About Asymmetric Cryptography]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/about-asymetric-cryptography) .

In WSO2 API Manager, there are three different keystores in use.

1. Primary Keystore
2. Secondary Keystore (TLS Connections)
3. Internal Keystore

Primary Keystore is used for sigining and encryption for the data which is externally exposed. Example use cases are signing SAML response, OAuth ID Token Signing and signing JWTs.

Secondary Keystore is used for authenticating communication over SSL/TLS. This is used in various transports used by WSO2 API Manager including servlet transport (used for webapps), Synapse transport (used in gateway), thrift, binary and JMS.

Internal Keystore is used for encrypting internal critical data including passwords and other confidential information in configuration files. 

The `wso2carbon.jks` keystore file, which is shipped with all WSO2 products, is used as the default keystore for all functions. However, in a production environment, it is recommended to [create new keystores]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores) with new keys and certificates. If you have created a new keystore and updated the `client-truststore.jks` file, you must update the `<API-M_HOME>/repository/conf/deployment.toml` file in order to make the keystore work.

!!! info
    If you want to change the default truststore details, you can do it by adding the configurations under `[truststore]` field in the `<API-M_HOME>/repository/conf/deployment.toml`. Refer the below example which defines the `type` of the truststore as "JKS" (Java KeyStore), the `file_name` of the trustore as "modified-client-truststore.jks" and the `password` as "modified_password".

    ```toml
    [truststore]
    type= "JKS"
    file_name = "modified-client-truststore.jks"
    password= "modified_password"
    ```

## Configuring the Primary Keystore

By default, the primary keystore is configured with `wso2carbon.jks`. In order to configure the primary keystore, open `<API-M_HOME>/repository/conf/deployment.toml` and add below configurations. 

```toml
[keystore.primary]
file_name =  "keystore.jks"
type =  "JKS"
password =  "passwd12#"
alias =  "mydomain"
key_password =  "passwd12#"
```

The elements in the above configuration are described below:

| Element           | Description                                                      |
|-------------------|------------------------------------------------------------------|
| **file_name**     | Name of the keystore file. **The file must be located in `<API-M_HOME>/repository/resources/security`** |
| **type**          |Type of the keystore. Supported keystore types are JKS and PKCS12 |
| **password**      | Keystore password                                                |
| **alias**         | Private key alias                                                |
| **key_password**  | Private key password                                             |

!!! Important
    Your private key password (**key_password**) and keystore password (**password**) should be the same. This is due to a limitation of some of the internal 3rd party components used by WSO2 API Mananger.

By default, the primary keystore configured as above is used for internal data encryption (encrypting data in internal data stores and configuration files) as well as for signing messages that are communicated with external parties. In other words, if we define the primary keystore only, it will be used as both Secondary Keystore (TLS) and Internal Keystore. However, it is sometimes a common requirement to have separate keystores for SSL/TSL connections, communicating messages with external parties (such as JWT, SAML, OIDC id\_token signing) and for encrypting information in internal data stores. This is because, for signing messages and external communications, the keystore certificates need to be frequently renewed. However, for encrypting information in internal data stores, the keystore certificates should not be changed frequently because the data that is already encrypted will become unusable every time the certificate changes.

## Configuring the Secondary Keystore for TLS connections

In order to configure a seperate keystore as the secondary keystore, add below configurations to `deployment.toml`.

```toml
[keystore.tls]
file_name =  "tls_keystore.jks"
type =  "JKS"
password =  "passwd12#"
alias =  "mydomain"
key_password =  "passwd12#"
```

## Configuring the Internal Keystore

Configuring a seperate internal keystore facilitates you to keep the certificate used for those encryptions unchanged while the certificate used for signing are changed. For that, add below configurations to `deployment.toml`. 

```toml
[keystore.internal]
file_name =  "internal_keystore.jks"
type =  "JKS"
password =  "passwd12#"
alias =  "mydomain"
key_password =  "passwd12#"
```

!!! warning
    Using a totally new keystore for internal data encryption in an existing deployment will make already encrypted data unusable. In such cases, an appropriate data migration effort is needed.
    Hence, if you have already been using the same keystore for both primary and internal keystores for sometime and later decided to use a seperate internal keystore, use the current keystore for internal keystore and use the new keystore for primary keystore instead. This avoids unnecessary data migration.


    ```toml
    [keystore.primary]
    file_name =  "new_keystore.jks"
    type =  "JKS"
    password =  "passwd12#"
    alias =  "mydomain"
    key_password =  "passwd12#"

    [keystore.internal]
    file_name =  "existing_keystore.jks"
    type =  "JKS"
    password =  "passwd12#"
    alias =  "mydomain"
    key_password =  "passwd12#"
    ```

## Recommendations for setting up keystores

Follow the recommendations given below when you set up your keystores. 

-   Maintain one primary keystore for encrypting sensitive internal data such as admin passwords and any other sensitive information found at both product-level and product feature-level configurations/configuration files. Note that the primary keystore will also be used for signing messages when the product communicates with external parties (such SAML, OIDC id_token signing).

-   Have separate keystores for encrypting sensitive internal data/information as a recommended practice.

-   Maintain another secondary keystore, containing the server’s public key certificate for authenticating communication over SSL/TLS (for both Tomcat and Axis2 level HTTP connections).

-   If your deployment contains multiple products, instances of the same product must use the same keystore for SSL. Different products can use different keystores for SSL, but it is not mandatory.

-   It is recommended to use a CA-signed keystore for SSL communication; however, this is not mandatory. Even a self-signed certificate may suffice if it can be trusted by the clients.

-   The keystore used for SSL must contain the same password for the Keystore and private key.

-   The internal keystore can be a self-signed one. There is no value added by using a CA-signed keystore for this purpose as it is not used for any external communication.

-   The primary keystore's public key certificate must have the Data Encipherment key usage to allow direct encipherment of raw data using its public key. This key usage is already included in the self-signed certificate that is included in the default wso2carbon.jks keystore. If the Data Encipherment key usage is not included in your public key certificate, the following error can occur when you attempt data encryption:

    ``` java
        Exception in thread "main" org.wso2.ciphertool.CipherToolException: Error initializing Cipher at org.wso2.ciphertool.CipherTool.handleException(CipherTool.java:861) 
            at org.wso2.ciphertool.CipherTool.initCipher(CipherTool.java:202) 
            at org.wso2.ciphertool.CipherTool.main(CipherTool.java:80) 
        Caused by: java.security.InvalidKeyException: Wrong key usage 
            at javax.crypto.Cipher.init(DashoA13..)     
            at javax.crypto.Cipher.init(DashoA13..) 
            at org.wso2.ciphertool.CipherTool.initCipher(CipherTool.java:200) 
            ... 1 more
    ```

-   If you already have the required keystores for your product, you can generate CA-signed certificates and import them into the keystores. It is not recommended to create new keystores for the purpose of replacing the certificates in the keystore. See [Adding CA-signed certificates to keystores](../keystore-basics/creating-new-keystores/#adding-ca-signed-certificates-to-keystores) for instructions.

-   If you encounter the following error after changing the default keystore, log in to the carbon console and navigate to `/_system/config/repository/esb/inbound` registry location and remove the `inbound-endpoints` resource. Once it is removed, restart the server. 
    ```
    FATAL - ServiceBusInitializer Couldn't initialize the ESB...
    java.lang.IllegalArgumentException: KeyStore File repository/resources/security/xxxx.jks not found
    ```
