# admin\_Enabling HostName Verification

The possibility to configure hostname verification is available for WSO2 products from Carbon 4.4.6 onwards. If hostname verification is disabled for your product, the hostnames (that are accessed by a particular client) will not be verified against the hostnames specified in the product's SSL certificate. If hostname verification is enabled, you will be able to configure how hostnames are filtered during the verification process.

See the following topics for details:

-   [Prerequisites](#admin_EnablingHostNameVerification-Prerequisites)
-   [Configuring hostname verification (Carbon 4.4.6 to Carbon 4.4.16)](#admin_EnablingHostNameVerification-Configuringhostnameverification(Carbon4.4.6toCarbon4.4.16))
-   [Configuring hostname verification (Carbon 4.4.17 onwards)](#admin_EnablingHostNameVerification-hostname_verification_newConfiguringhostnameverification(Carbon4.4.17onwards))

!!! note
**Important!**

Be sure to enable hostname verification for your production environment. This is necessary to avoid security issues in production. See the full list of [security recommendations for production](https://docs.wso2.com/display/ADMIN44x/Security+Guidelines+for+Production+Deployment) environments.


### Prerequisites

Note that this configuration is **only** available as a [WUM update](https://docs.wso2.com/display/updates/Using+WSO2+Update+Manager) for the following product versions:

-   **WSO2 Enterprise Integrator** (WSO2 EI) version **6.1.1** can use this feature with WUM updates obtained after the 4th of February, 2018.
-   **WSO2 API Manager** (WSO2 AM) versions **2.0.0** and **2.1.0** can use this feature with WUM updates obtained after the 28th of July, 2017.
-   **WSO2 Identity Server** (WSO2 IS) version **5.2.0** can use this feature with WUM updates obtained after the 28th of July, 2017.
-   **WSO2 Enterprise Service Bus** version 5.0.0 can use this feature with WUM updates obtained after the 2nd of October, 2017.

See [Getting Started with WUM](https://docs.wso2.com/display/updates/Getting+Continuous+Updates) for more instructions on how to get updates. If you have already got the WUM updates, see the topic below on [Configuring hostname verification (Carbon 4.4.17 onwards)](#admin_EnablingHostNameVerification-hostname_verification_new) for instructions on how to apply this configuration.

For all other product versions (that are not listed above), this configuration will apply based on the Carbon version. Therefore, check the [Carbon version of your WSO2 product](https://wso2.com/products/carbon/release-matrix/) , and then following the instructions given below.

### Configuring hostname verification (Carbon 4.4.6 to Carbon 4.4.16)

!!! info
Before you begin, be sure to check the [prerequisites](#admin_EnablingHostNameVerification-Prerequisites) .


If you are using a WSO2 product that is based on a Carbon version between 4.4.6 and 4.4.16,  hostname verification is **disabled** by default. This setting is disabled using the `org.wso2.ignoreHostnameVerification` property in the product startup script ( `wso2server.sh` for Linux, or `wso2server.bat` for Windows) that is stored in the `<PRODUCT_HOME>/bin/` directory.

``` java
    -Dorg.wso2.ignoreHostnameVerification=true
```

### Configuring hostname verification (Carbon 4.4.17 onwards)

!!! info
Before you begin, be sure to check the [prerequisites](#admin_EnablingHostNameVerification-Prerequisites) .


If you are using a WSO2 product that is based on Carbon 4.4.17 or a later version, hostname verification is **enabled** by default. This is done using the `httpclien` t `.hostnameVerifier` property in the product's startup script ( `wso2server.sh` for Linux and `wso2server.bat` for Windows) as shown below. The product startup script is stored in the `<PRODUCT_HOME>/bin` directory. This property will be effective during server startup.

``` java
    -Dhttpclient.hostnameVerifier="DefaultAndLocalhost"
```

The values you can use with this property are explained below. Note that these values will behave the same as synapse hostname verification options.

-   **DefaultAndLocalhost:** This is the value that is enabled, by default. This means that all hostnames, except the ones listed below, will be verified against the hostnames specified in the product's SSL certificate. That is, the following hostnames will be allowed regardless of the server's certificate.

    -   localhost

    -   localhost.localdomain

    -   127.0.0.1

    -   ::1

    Note that if the wildcard symbol is used to specify a hostname in the SSL certificate (such as \*. [foo.com](http://foo.com/) ), all the subdomains of \*. [foo.com](http://foo.com/) are also included. That is, a hostname that matches a subdomain of \*. [foo.com](http://foo.com/) will also be allowed access.

-   **Strict:** When this mode is enabled, hostnames will be strictly verified against the hostname specified in the product's SSL certificate. For example, if "\*. [foo.com](http://foo.com/) " is specified as the hostname in the certificate, only the hostnames at the same level will be authorized by the server. That is, subdomains such as " [a.b.foo.com](http://a.b.foo.com/) " will **not** be authorized.

-   **AllowAll:** This option turns off hostname verification for the server. Note that this is not recommended in a production setup and should only be used for demonstrations and testing.

        !!! note
    **Important!**

    If you are disabling hostname verification for **WSO2 AM 2.0.0** or **2.1.0** , you need to use both system properties listed below.

    ``` java
        -Dorg.wso2.ignoreHostnameVerification=true \
        -Dhttpclient.hostnameVerifier=AllowAll \
    ```

    If you are disabling hostname verification for **WSO2 EI 6.1.1** , you need to use both system properties listed below.

    ``` java
            -Dhttpclient.hostnameVerifier=AllowAll \
            -Dorg.opensaml.httpclient.https.disableHostnameVerification=true \
    ```

    If you are disabling hostname verification for **WSO2 IS** , use the following system properties.

    ``` java
            -Dorg.opensaml.httpclient.https.disableHostnameVerification=true \
            -Dhttpclient.hostnameVerifier="AllowAll" \
    ```



