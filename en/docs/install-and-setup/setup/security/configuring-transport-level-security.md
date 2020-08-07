# Configuring Transport Level Security

Given below are the various transport-level security configurations that are required for WSO2 products. See the following topics for instructions.

-   [Enabling SSL protocols and ciphers in ThriftAuthenticationService](#enabling-ssl-protocols-and-ciphers-in-thriftauthenticationservice)
-   [Disabling weak ciphers](#disabling-weak-ciphers)
-   [Changing the server name in HTTP response headers](#changing-the-server-name-in-http-response-headers)

### Enabling SSL protocols and ciphers in ThriftAuthenticationService

Do the following to enable SSL protocols and ciphers in the `ThriftAuthenticationService.        `

1.  Add the following configurations in the `<CARBON_SERVER>/repository/conf/identity/thrift-authentication.xml` file as sub-elements of the root `<Server>` element.

    ``` java
    <SSLEnabledProtocols>TLSv1,TLSv1.1,TLSv1.2</SSLEnabledProtocols>
    <Ciphers>TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256</Ciphers>
    ```

!!! tip
    You can also add the following additional cipher suites to the `<Ciphers>` property if JCE Unlimited Strength Jurisdiction Policy is enabled in Java.

    ``` java
    TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,TLS_DHE_RSA_WIT
    ```

    If you wish to remove `TLSv1` or `TLSv1.1` , you can do so by removing them as values from the `<SSLEnabledProtocols>` property.

2.  Restart the server.

### Disabling weak ciphers

A cipher is an algorithm for performing encryption or decryption. When you set the `sslprotocol` of your server to TLS, the TLS and the default ciphers get enabled without considering the strength of the ciphers. This is a security risk as weak ciphers, also known as EXPORT ciphers, can make your system vulnerable to attacks such as the Logjam attack on Diffie-Hellman key exchange. The Logjam attack is also called the Man-in-the-Middle attack. It downgrades your connection's encryption to a less-secured level (e.g., 512 bit) that can be decrypted with sufficient processing power.

To prevent these types of security attacks, it is encouraged to disable the weak ciphers. You can enable only the ciphers that you want the server to support in a comma-separated list in the `ciphers` attribute. Also, if you do not add this cipher attribute or keep it blank, the browser will support all the SSL ciphers by JSSE. This will enable the weak ciphers.

#### Disabling weak ciphers for the Tomcat transport

1.  Open the `<PRODUCT_HOME>/repository/conf/deployment.toml` file.
2.  Take a backup of the `deployment.toml` file and stop the Carbon server.
3.  Add the following configuration to the `deployment.toml` file by adding the list of ciphers that you want your server to support as follows: `ciphers=","`.

    ``` toml
    [transport.https.sslHostConfig.properties]
    ciphers="TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384, TLS_ECDH_ECDSA_WITH_AES_256_GCM_SHA384, TLS_DHE_DSS_WITH_AES_256_GCM_SHA384, TLS_ECDH_RSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256, TLS_ECDH_ECDSA_WITH_AES_128_GCM_SHA256, TLS_ECDH_RSA_WITH_AES_128_GCM_SHA256, TLS_DHE_DSS_WITH_AES_128_GCM_SHA256, TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384, TLS_ECDH_ECDSA_WITH_AES_256_CBC_SHA384, TLS_ECDH_RSA_WITH_AES_256_CBC_SHA384, TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384, TLS_DHE_DSS_WITH_AES_256_CBC_SHA256, TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA, TLS_ECDH_ECDSA_WITH_AES_256_CBC_SHA, TLS_ECDH_RSA_WITH_AES_256_CBC_SHA, TLS_DHE_DSS_WITH_AES_256_CBC_SHA, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256, TLS_ECDH_ECDSA_WITH_AES_128_CBC_SHA256, TLS_ECDH_RSA_WITH_AES_128_CBC_SHA256, TLS_DHE_DSS_WITH_AES_128_CBC_SHA256, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA, TLS_ECDH_ECDSA_WITH_AES_128_CBC_SHA, TLS_ECDH_RSA_WITH_AES_128_CBC_SHA, TLS_DHE_DSS_WITH_AES_128_CBC_SHA, TLS_ECDHE_ECDSA_WITH_RC4_128_SHA, TLS_ECDH_ECDSA_WITH_RC4_128_SHA, TLS_ECDH_RSA_WITH_RC4_128_SHA, TLS_EMPTY_RENEGOTIATION_INFO_SCSVF"
    ```
     See the list of [supported cipher suites](https://docs.wso2.com/display/ADMIN44x/Supported+Cipher+Suites) .

4.  Start the server.
5.  To verify that the configurations are all set correctly, download and run the [TestSSLServer.jar]({{base_path}}/assets/attachments/administer/TestSSLServer.jar).

    ``` java
    $ java -jar TestSSLServer.jar localhost 9443
    ```

!!! note
    Note the following when you run `TestSSLServer.jar` :

    -   The "Supported cipher suites" section in the output does not contain any EXPORT ciphers.

    -   When you use the supported cipher suites listed [here](https://docs.wso2.com/display/ADMIN44x/Supported+Cipher+Suites) , the BEAST attack status will be shown as vulnerable. Note that this is a client-side vulnerability caused by the TLSv1 protocol. You can make the BEAST status protected by removing TLSv1, which will make clients with TLSv1 unusable. Therefore, it is recommended tofixed this from the client side.

!!! info
    From **Firefox** 39.0 onwards, the browser does not allow to access Web sites that support DHE with keys less than 1023 bits (not just DHE\_EXPORT). 768/1024 bits are considered to be too small and vulnerable to attacks if the hacker has enough computing resources.
!!! tip
    To use AES-256, the Java JCE Unlimited Strength Jurisdiction Policy files need to be installed. Download them from [http://www.oracle.com/technetwork/java/javase/downloads/index.html](index) .
!!! tip
    From Java 7, you must set the `jdk.certpath.disabledAlgorithms` property in the `<JAVA_HOME>/jre/lib/security/java.security` file to `jdk.certpath.disabledAlgorithms=MD2, DSA, RSA keySize < 2048` . It rejects all algorithms that have key sizes less than 2048 for MD2, DSA and RSA.

### Changing the server name in HTTP response headers

By default, all WSO2 products pass "WSO2 Carbon Server" as the server value in HTTP headers when sending HTTP responses. This means that information about the WSO2 product stack will be exposed through HTTP responses. It is recommended to change this by configuring the server name in the `deployment.toml` file.

1.  Open the `<PRODUCT_HOME>/repository/conf/deployment.toml` file.
2.  Add a new server name using the `server` property (under the relevant Tomcat connector configuration):

    ``` toml
    [transport.https.properties]
    server="WSO2 Carbon Server"
    
    [transport.http.properties]
    server="WSO2 Carbon Server"
    ```

!!! info
    See the [Security Guidelines for Production Deployment](https://docs.wso2.com/display/ADMIN44x/Security+Guidelines+for+Production+Deployment) for the full list of security-related recommendations for WSO2 products.


