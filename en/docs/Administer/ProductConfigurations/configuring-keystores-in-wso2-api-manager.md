# Configuring Keystores in WSO2 API Manager

WSO2 products use asymmetric encryption by default for the purposes of authentication and data encryption. In asymmetric encryption, keystores (with key pairs and certificates) are created and stored for the product. It is possible to have multiple keystores so that the keys used for different use cases are kept unique. For more information about creating and configuring keystores, see [Using Asymmetric Encryption](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption) .

After you have [created a new keystore and updated the `client-truststore.jks` file](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) , you must update a few configuration files in order to make the keystore work.

!!! info
For instructions on the default carbon keystore configurations, see [Configuring Keystores in WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Configuring+Keystores+in+WSO2+Products) in the WSO2 Product Administration Guide.

The following common configurations should be completed before you begin the configurations given in this page.

-   [Configuring the primary keystore](https://docs.wso2.com/display/ADMIN44x/Configuring+Keystores+in+WSO2+Products#Configuring%20the%20primary%20keystore)
-   [Configuring a keystore for SSL connections](https://docs.wso2.com/display/ADMIN44x/Configuring+Keystores+in+WSO2+Products#Configuring%20keystores%20for%20SSL%20connections)
-   [Configuring a keystore for java permissions](https://docs.wso2.com/display/ADMIN44x/Configuring+Keystores+in+WSO2+Products#Configuring%20a%20keystore%20for%20java%20permissions)
-   [Configuring keystores for WS-Security](https://docs.wso2.com/display/ADMIN44x/Configuring+Keystores+in+WSO2+Products#Configuring%20keystores%20for%20WS-Security)


Make sure you do the configurations below to configure a keystore in WSO2 API Manager.

-   [Configuring keystores for AMQP and MQTT transports](#ConfiguringKeystoresinWSO2APIManager-ConfiguringkeystoresforAMQPandMQTTtransports)
-   [Configuring keystores for Jaggery Apps SSO configuration](#ConfiguringKeystoresinWSO2APIManager-ConfiguringkeystoresforJaggeryAppsSSOconfiguration)
-   [Configuring keystores for security](#ConfiguringKeystoresinWSO2APIManager-Configuringkeystoresforsecurity)
-   [Configuring keystores for endpoints](#ConfiguringKeystoresinWSO2APIManager-Configuringkeystoresforendpoints)
-   [Configuring keystores for advanced transport handling](#ConfiguringKeystoresinWSO2APIManager-Configuringkeystoresforadvancedtransporthandling)
-   [Configuring keystores for Analytics](#ConfiguringKeystoresinWSO2APIManager-ConfiguringkeystoresforAnalytics)

### Configuring keystores for AMQP and MQTT transports

To configure AMQP and MQTT transports, open the `<API-M_HOME>/repository/conf/broker.xml` file. The values for the `location` and `password` parameters under `keyStore` and `trustStore` must be updated. The code below shows the default values.

``` java
    <sslConnection enabled="true" port="8672">
        <keyStore>
            <location>repository/resources/security/wso2carbon.jks</location>
            <password>wso2carbon</password>
        </keyStore>
        <trustStore>
            <location>repository/resources/security/client-truststore.jks</location>
            <password>wso2carbon</password>
        </trustStore>
    </sslConnection>
```

### Configuring keystores for Jaggery Apps SSO configuration

Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/publisher/site/conf/site.json` file. Update the values for `keyStoreName` and `keyStorePassword` as shown below.

``` java
    "ssoConfiguration" : {
            "enabled" : "true",
            "issuer" : "API_PUBLISHER",
            "identityProviderURL" : "https://localhost:9444/samlsso",
            "keyStorePassword" : "wso2carbon",
            "identityAlias" : "wso2carbon",
            "responseSigningEnabled":"true",
            "assertionSigningEnabled":"true",
            "keyStoreName" :"wso2carbon.jks",
        },
```

### Configuring keystores for security

Open the `<API-M_HOME>/repository/conf/identity/identity.xml` file and update the values for `Location` and `Password` under the `KeyStore` section. The default configurations are shown below.

``` java
    <EntitlementSettings>
        <ThirftBasedEntitlementConfig>
            <EnableThriftService>false</EnableThriftService>
            <ReceivePort>${Ports.ThriftEntitlementReceivePort}</ReceivePort>
            <ClientTimeout>10000</ClientTimeout>
            <KeyStore>
                <Location>${carbon.home}/repository/resources/security/wso2carbon.jks</Location>
                <Password>wso2carbon</Password>
            </KeyStore>
            <ThriftHostName>${carbon.host}</ThriftHostName>
        </ThirftBasedEntitlementConfig>
    </EntitlementSettings>
```

### 
Configuring keystores for endpoints

Open the `<API-M_HOME>/repository/conf/identity/EndpointConfig.properties` file and update `client.keyStore` and `client.trustStore` with the location of the keystore and truststore respectively. The default configurations are shown below.

``` java
    tenantListEnabled=false
    hostname.verification.enabled=true
    mutual.ssl.username=admin
    client.keyStore=./repository/resources/security/wso2carbon.jks
    Carbon.Security.KeyStore.Password=wso2carbon
    client.trustStore=./repository/resources/security/client-truststore.jks
    Carbon.Security.TrustStore.Password=wso2carbon
    #identity.server.serviceURL=https://localhost:9443/services/
    username.header=UserName
    key.manager.type=SunX509
    trust.manager.type=SunX509
    tls.protocol=TLSv1.2
```

### Configuring keystores for advanced transport handling

To have more advanced transport handling functions using keystores, you must update the `<APIM_HOME>/repository/conf/tomcat/catalina-server.xml` file and the `<API-M_HOME>/repository/conf/axis2/axis2.xml` file.

### Configuring keystores for Analytics

Open the `<API-M_HOME>/repository/conf/data-bridge/data-bridge-config.xml` file and update keyStoreLocation and keyStorePassword with the location of the keystore and its password respectively. The default configurations are shown below.

``` java
    <keyStoreLocation>${carbon.home}/repository/resources/security/wso2carbon.jks</keyStoreLocation>
     <keyStorePassword>wso2carbon</keyStorePassword>
```

!!! note
The &lt;API-M\_HOME&gt;/repository/conf/data-bridge/data-agent-config.xml file is used by the publishing client. Therefore, a trustore with the public cert of the server is required here. The `<API-M_HOME>/repository/conf/data-bridge/data-bridge-config.xml` file is used by the listening server. This needs to include a keystore with the public and private certs to support SSL.


