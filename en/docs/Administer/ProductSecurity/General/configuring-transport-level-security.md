# admin\_Configuring Transport Level Security

Given below are the various transport-level security configurations that are required for WSO2 products. See the following topics for instructions.

-   [Enabling TLS and disabling SSL support](#admin_ConfiguringTransportLevelSecurity-EnablingTLSanddisablingSSLsupport)
-   [Enabling SSL protocols and ciphers in ThriftAuthenticationService](#admin_ConfiguringTransportLevelSecurity-EnablingSSLprotocolsandciphersinThriftAuthenticationService)
-   [Enabling TLSv1.1/TLSv1.2 for products with JDK 1.7](#admin_ConfiguringTransportLevelSecurity-EnablingTLSv1.1/TLSv1.2forproductswithJDK1.7)
-   [Disabling weak ciphers](#admin_ConfiguringTransportLevelSecurity-disablingweakciphersDisablingweakciphers)
-   [Changing the server name in HTTP response headers](#admin_ConfiguringTransportLevelSecurity-ChangingtheservernameinHTTPresponseheaders)

### Enabling TLS and disabling SSL support

The transport-level security protocol of the Tomcat server is configured in the `<PRODUCT_HOME>/repository/conf/tomcat/catalina-server.xml` file. By default, "TLS" is configured as the SSL protocol for HTTPS communication by setting the sslProtocol="TLS" attribute in the `catalina-server.xml` file. Specifying TLS as the SSL protocol ensures that all TLS versions, as well as SSL protocol versions, are supported. However, due to the [Poodle Attack](https://www.openssl.org/~bodo/ssl-poodle.pdf) , it is necessary to make sure that only TLS protocol versions are enabled.

Note that in some WSO2 products, such as WSO2 Enterprise Integrator (ESB profile) and WSO2 API Manager, pass-thru transports are enabled. Therefore, to disable SSL in such products, the `axis2.xml` file stored in the `<PRODUCT_HOME>/repository/conf/axis2/` directory should also be configured.

!!! info
Poodle Attack:


#### Disabling SSL support for products with JDK 1.8

Follow the steps given below to disable SSL support for the Tomcat layer.

1.  Open the `<PRODUCT_HOME>/repository/conf/tomcat/catalina-server.xml` file.
2.  Make a backup of the `catalina-server.xml` file and stop the product server.
3.  Find the Connector configuration corresponding to TLS (usually, this connector has the port set to 9443 and the `sslProtocol` as TLS). Remove the `sslProtocol="TLS"` attribute and replace it with `sslEnabledProtocols="TLSv1,TLSv1.1,TLSv1.2"` as shown below.

    ``` java
        <Connector protocol="org.apache.coyote.http11.Http11NioProtocol"
                        port="9443"
                        bindOnInit="false"
                        sslEnabledProtocols="TLSv1,TLSv1.1,TLSv1.2" 
    ```

4.  Start the server.

5.  To verify that the configurations are all set correctly, download and run the [TestSSLServer.jar]({{base_path}}/assets/attachments/126562683/126562684.jar) .

    ``` java
            java -jar TestSSLServer.jar localhost 9443
    ```

    The output of the command after disabling SSL is shown below.

    ``` java
            Supported versions: TLSv1.0
            Deflate compression: no
            Supported cipher suites (ORDER IS NOT SIGNIFICANT):
              TLSv1.0
                 RSA_EXPORT_WITH_RC4_40_MD5
                 RSA_WITH_RC4_128_MD5
                 RSA_WITH_RC4_128_SHA
                 RSA_EXPORT_WITH_DES40_CBC_SHA
                 RSA_WITH_DES_CBC_SHA
                 RSA_WITH_3DES_EDE_CBC_SHA
                 DHE_RSA_EXPORT_WITH_DES40_CBC_SHA
                 DHE_RSA_WITH_DES_CBC_SHA
                 DHE_RSA_WITH_3DES_EDE_CBC_SHA
                 RSA_WITH_AES_128_CBC_SHA
                 DHE_RSA_WITH_AES_128_CBC_SHA
                 RSA_WITH_AES_256_CBC_SHA
                 DHE_RSA_WITH_AES_256_CBC_SHA
    ```

If you have enabled the PassThrough transport, do the following:

!!! note
This is applicable for WSO2 Enterprise Integrator (ESB profile) and WSO2 API Manager products.


1.  Stop the server.

2.  Open the `<PRODUCT_HOME>/repository/conf/axis2/axis2.xml` file and add the specified parameter under the `<transportReceiver name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpSSLListener">` element as well as under the `<transportSender name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpSSLSender">` element. If you are using JDK 1.8, you can add the following parameter:

    ``` java
        <parameter name="HttpsProtocols">TLSv1,TLSv1.1,TLSv1.2</parameter> 
    ```

        !!! info
    -   If you are using JDK 1.6, add the following parameter:

        ``` java
                <parameter name="HttpsProtocols">TLSv1</parameter> 
        ```

    <!-- -->

    -   If you are using JDK 1.7, add the following parameter:

        ``` java
                    <parameter name="HttpsProtocols">TLSv1,TLSv1.1,TLSv1.2</parameter> 
        ```

    -   If you are using JDK 1.8, add the following parameter:

        ``` java
                    <parameter name="HttpsProtocols">TLSv1,TLSv1.1,TLSv1.2</parameter> 
        ```


3.  Start the server.

4.  Test the pass-through transport using the following command with the corresponding port:

    ``` java
        $ java -jar TestSSLServer.jar localhost 8243
    ```

### Enabling SSL protocols and ciphers in ThriftAuthenticationService

Do the following to enable SSL protocols and ciphers in the `ThriftAuthenticationService.        `

1.  Add the following configurations in the `<CARBON_SERVER>/repository/conf/identity/thrift-authentication.xml` file as sub-elements of the root `<Server>` element.

    ``` java
            <SSLEnabledProtocols>TLSv1,TLSv1.1,TLSv1.2</SSLEnabledProtocols
            <Ciphers>TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256</Ciphers>
    ```

        !!! tip
    **Tip:** You can also add the following additional cipher suites to the `<Ciphers>` property if JCE Unlimited Strength Jurisdiction Policy is enabled in Java.

    ``` java
        TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,TLS_DHE_RSA_WIT
    ```

    If you wish to remove `TLSv1` or `TLSv1.1` , you can do so by removing them as values from the `<SSLEnabledProtocols>` property.


2.  Restart the server.

### Enabling TLSv1.1/TLSv1.2 for products with JDK 1.7

The TLS protocol is set to TLSv1.0 (by default), in WSO2 products running on JDK 1.7. You cannot configure this using the `catalina` - `server.` xml file or the `axis2.` xml file as we do with products based on JDK 1.7. Therefore, you need to enable TLSv1.1 and TLSv1.2 globally by setting a system property.

1.  Download the following artifacts:
    -   [wso2-ssl-socket-factory-provider-1.0.0.jar]({{base_path}}/assets/attachments/126562683/126562685.jar)
    -   [wso2-ssl-security]({{base_path}}/assets/attachments/126562683/126562686)
2.  Copy the `wso2-` ssl `-socket-factory-provider-1.0.0.jar` file to the `<PRODUCT_HOME>/lib/endorsed` directory.
3.  Copy the `wso2-ssl-security` file to the `<PRODUCT_HOME>/repository/conf/` directory.
4.  Open the product startup script ( `wso2server.sh` for Linux, or `wso2server.bat` for Windows), which is stored in the `<PRODUCT_HOME>/bin` directory.

5.  Add the following system properties to the script:

    ``` java
        -Djdk.tls.client.protocols="TLSv1.1,TLSv1.2" \
        -Djava.security.properties="$CARBON_HOME/repository/conf/wso2-ssl-security" \
    ```

6.  Start the server.

### Disabling weak ciphers

A cipher is an algorithm for performing encryption or decryption. When you set the `sslprotocol` of your server to TLS, the TLS and the default ciphers get enabled without considering the strength of the ciphers. This is a security risk as weak ciphers, also known as EXPORT ciphers, can make your system vulnerable to attacks such as the Logjam attack on Diffie-Hellman key exchange. The Logjam attack is also called the Man-in-the-Middle attack. It downgrades your connection's encryption to a less-secured level (e.g., 512 bit) that can be decrypted with sufficient processing power.

To prevent these types of security attacks, it is encouraged to disable the weak ciphers. You can enable only the ciphers that you want the server to support in a comma-separated list in the `ciphers` attribute. Also, if you do not add this cipher attribute or keep it blank, the browser will support all the SSL ciphers by JSSE. This will enable the weak ciphers.

#### Disabling weak ciphers for the Tomcat transport

1.  Open the `<PRODUCT_HOME>/repository/conf/tomcat/catalina-server.xml` file.
2.  Make a backup of the `catalina-server.xml` file and stop the WSO2 product server.
3.  Add the `cipher` attribute to the existing configuration in the `catalina-server.xml` file by adding the list of ciphers that you want your server to support as follows: `ciphers="<cipher-name>,<cipher-name>"` . See the example given below.

    ``` java
            For Tomcat version 7.0.59 and JDK version 1.7:
            ciphers="TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA"  
    For Tomcat version 7.0.59 and JDK version 1.8:
    ciphers="TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256"
    ```
    See the list of [supported cipher suites](https://docs.wso2.com/display/ADMIN44x/Supported+Cipher+Suites) .

4.  Start the server.
5.  To verify that the configurations are all set correctly, download and run the [TestSSLServer.jar]({{base_path}}/assets/attachments/126562683/126562684.jar) .

    ``` java
        $ java -jar TestSSLServer.jar localhost 9443
    ```

        !!! note
    Note the following when you run `TestSSLServer.jar` :

    -   The "Supported cipher suites" section in the output does not contain any EXPORT ciphers.

    -   When you use the supported cipher suites listed [here](https://docs.wso2.com/display/ADMIN44x/Supported+Cipher+Suites) , the BEAST attack status will be shown as vulnerable. Note that this is a client-side vulnerability caused by the TLSv1 protocol. You can make the BEAST status protected by removing TLSv1, which will make clients with TLSv1 unusable. Therefore, it is recommended tofixed this from the client side.


#### Disables weak ciphers for the PassThrough transport

Remove any weak ciphers from the PassThrough transport and ensure that the server does not accept connections using those weak ciphers. The PassThrough transport is configured using the axis2. xml file (stored in the `<PRODUCT_HOME>/repository/conf/axis2/` directory).

1.  Open the `<PRODUCT_HOME>/repository/conf/axis2/axis2.xml` file.
2.  Make a backup of the `axis2.xml` file and stop the WSO2 product server.
3.  You need to add the `PreferredCiphers` parameter under the "Transport Ins (Listeners)" section along with the list of relevant cipher suites.

    ``` java
        <parameter name="PreferredCiphers">TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256</parameter>
    ```

4.  Start the server.
5.  Test the pass-through transport using the following command with the corresponding port:

    ``` java
            $ java -jar TestSSLServer.jar localhost 8243
    ```

!!! info
From **Firefox** 39.0 onwards, the browser does not allow to access Web sites that support DHE with keys less than 1023 bits (not just DHE\_EXPORT). 768/1024 bits are considered to be too small and vulnerable to attacks if the hacker has enough computing resources.
!!! tip
To use AES-256, the Java JCE Unlimited Strength Jurisdiction Policy files need to be installed. Download them from [http://www.oracle.com/technetwork/java/javase/downloads/index.html](index) .
!!! tip
From Java 7, you must set the `jdk.certpath.disabledAlgorithms` property in the `<JAVA_HOME>/jre/lib/security/java.security` file to `jdk.certpath.disabledAlgorithms=MD2, DSA, RSA keySize < 2048` . It rejects all algorithms that have key sizes less than 2048 for MD2, DSA and RSA.

### Changing the server name in HTTP response headers

By default, all WSO2 products pass "WSO2 Carbon Server" as the server value in HTTP headers when sending HTTP responses. This means that information about the WSO2 product stack will be exposed through HTTP responses. It is recommended to change this by configuring the server name in the catalina `-server.` xml file.

1.  Open the `<PRODUCT_HOME>/repository/conf/tomcat/catalina-server.xml` file.
2.  Add a new server name using the `server` property (under the relevant Tomcat connector configuration):

    ``` java
        server="WSO2 Carbon Server"
    ```

!!! info
See the [Security Guidelines for Production Deployment](https://docs.wso2.com/display/ADMIN44x/Security+Guidelines+for+Production+Deployment) for the full list of security-related recommendations for WSO2 products.


