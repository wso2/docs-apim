# Configuring the keyStore and client trustStore for a Selected Pattern

The [WSO2 API-M GitHub repository](https://github.com/wso2/puppet-apim) includes a custom keyStore and client trustStore in the `<API-M_HOME>/repository/resources/security` directory for the initial setup (i.e., testing) purpose. The same files are copied into the `wso2am_analytics` module and `wso2is_prepacked` module as well. This `wso2carbon.jks` keyStore is created for `CN=*.dev.wso2.org` , and its self-signed certificate is imported into the `client-truststore.jks` .

!!! note
In production environments, it is recommended to replace these with your own keyStores and trustStores with certification authority (CA) signed certificates. In addition, if you also change the hostnames given by default in these patterns, you have to create your own hostnames. For more information, see [Creating New Keystores](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) .


Follow the steps below to create a new keystore and client-truststore with self-signed certificates.

1.  Generate a Java keyStore and key pair with a self-signed certificate.

    -   [**Format**](#keyStore-format)
    -   [**Example**](#example1)

    ``` java
        keytool -genkey -alias <alias-name> -keyalg RSA -keysize 2048 -keystore <keystore-name> -dname "CN=*.dev.wso2.org,OU=Home,O=Home,L=SL,S=WS,C=LK" -storepass <password> -keypass <password> -validity <validity-period>
    ```

    ``` java
            keytool -genkey -alias wso2carbon -keyalg RSA -keysize 2048 -keystore wso2carbon.jks -dname "CN=*.dev.wso2.org,OU=Home,O=Home,L=SL,S=WS,C=LK" -storepass wso2carbon -keypass wso2carbon -validity 2000
    ```

2.  Export the certificate from the latter mentioned keyStore.

    -   [**Format**](#CertFromKeyStore)
    -   [**Example**](#example2)

    ``` java
            keytool -export -keystore <keystore-name> -alias <alias-of-the-certificate> -file <output-file-name>.cer
    ```

    ``` java
            keytool -export -keystore wso2carbon.jks -alias wso2carbon -file wso2carbon.cer
    ```

3.  Import the latter mentioned certificate into a trustStore.

    -   [**Format**](#ImportKeyStore)
    -   [**Example**](#example3)

    ``` java
            keytool -import -alias <alias-of-the-certificate> -file <input-file-name>.cer -keystore <client-truststore-name> -storepass <trust-store-password>
    ```

    ``` java
            keytool -import -alias wso2carbon -file wso2carbon.cer -keystore client-truststore.jks -storepass wso2carbon
    ```


