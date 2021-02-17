# Mutual SSL Between API Gateway and Backend

In contrast to the usual one-way SSL authentication where a client verifies the identity of the server, in mutual SSL the server validates the identity of the client so that both parties trust each other. This builds a system that has very tight security and avoids any requests made to the client to provide the username/password, as long as the server is aware of the certificates that belong to the client.

This section explains how to secure your backend by enabling mutual SSL between the API Gateway and your backend. To establish a  secure connection with the backend service, API Manager needs to have the public key of the backend service in the truststore. Similarly, the backend service should have the public key of API Manager in the truststore.

## Export the certificates

1.  Generate the keys for the backend. A sample command is given below.

    ``` java
    keytool -keystore backend.jks -genkey -alias backend 
    ```

    The keystore will be generated in your target folder.

2.  Export the certificate from the keystore. A sample command is given below.

    ``` java
    keytool -export -keystore backend.jks -alias backend -file backend.crt 
    ```

3.  Import the generated backend certificate to the API Manager truststore file as shown below

    ``` java
    keytool -import -file backend.crt -alias backend -keystore <APIM_HOME>/repository/resources/security/client-truststore.jks
    ```

4.  Export the public certificate from API Manager's keystore. The `<APIM_HOME>/repository/resources/security/wso2carbon.jks` file which is the default keystore shipped with WSO2 API Manager is used in this example. Use the command below to generate the certificate for the default keystore. Give the default password `wso2carbon` when prompted.

    ``` java
    keytool -export -keystore wso2carbon.jks -alias wso2carbon -file wso2PubCert.crt
    ```

    !!! info
        To change the default keystore, generate a keystore file and copy it to the `<APIM_HOME>/repository/resources/security` folder. After copying the keystore, generate the certificate as shown in step 2.


5.  Import the generated certificate to your backend truststore.

    ``` java
    keytool -import -file wso2PubCert.crt -alias wso2carbon -keystore backend-truststore.jks
    ```

You have now successfully exported the certificates for mutual SSL.

## Configure API Manager to enable dynamic SSL profiles

To configure APIM for Dynamic SSL Profiles for HTTPS transport Sender, you need to create a new XML file `<APIM_HOME>/repository/deployment/server/multi_ssl_profiles.xml` (this path is configurable) and copy the below configuration into it. This will configure client-truststore.jks as Trust Store for all connections to &lt;localhost:port&gt; .

``` java
<parameter name="customSSLProfiles">
<!-- For SSL Handshake configure only trust store--> 
    <profile>
    <servers>localhost:port</servers>
    <TrustStore>
    <Location>repository/resources/security/client-truststore.jks
    </Location>
    <Type>JKS</Type>
    <Password>wso2carbon</Password>
    </TrustStore>
</profile>
<!-- For Mutual SSL Handshake configure both trust store and key store-->  
    <profile>
        <servers>10.100.5.130:9444</servers>
        <TrustStore>
        <Location>repository/resources/security/client-truststore.jks
        </Location>
        <Type>JKS</Type>
    <Password>wso2carbon</Password>
        </TrustStore>
    <KeyStore>
        <Location>repository/resources/security/wso2carbon.jks</Location>
        <Type>JKS</Type>
        <Password>xxxxxx</Password>
        <KeyPassword>xxxxxx</KeyPassword>
    </KeyStore>
</profile>
</parameter>
```
To enable dynamic loading of this configuration, add the below configurations to the `<API-M_HOME>/repository/conf/deployment.toml` file (Make sure to set the above file’s path as the value for the `file_path` field under `[transport.passthru_https.sender.ssl_profile]`).

``` toml
[transport.passthru_https.sender.ssl_profile]
file_path = "repository/deployment/server/mutual_ssl_profiles.xml"
interval = 3600000

[transport.passthru_https.sender.parameters]
HostnameVerifier = "AllowAll"
```

Now both the backend service and ESB is configured to use default key stores and API Manager is configured to load dynamic SSL profiles. Restart API Manager.

!!! note
     It is recommended to configure the hostname as the server when configuring custom SSL profiles. If an IP address is required to be configured as the server, the IP address needs to be mapped to a hostname in the Host file, and the hostname can be provided as the server.

!!! tip
    You can start API Manager using the following options, to see the SSI debug logs.
    ``` java
    -Djavax.net.debug=ssl:handshake
    -Djavax.net.debug=all
    -Djavax.net.debug=all:handshake:verbose
    ```


## Test Mutual SSL between API Gateway and backend

You can do the following to test your mutual SSL configurations

1.  [Create an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api)
2.  [Publish the API]({{base_path}}/learn/design-api/publish-api/publish-an-api)
3.  [Subscribe to the API]({{base_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api)
4.  [Invoke the API]({{base_path}}/learn/consume-api/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console)