# Enabling Hostname Verification

If hostname verification is disabled for your product, the hostnames (that are accessed by a particular client) will not be verified against the hostnames specified in the product's SSL certificate. If hostname verification is enabled, you will be able to configure how hostnames are filtered during the verification process.

!!! note
    **Important!**
    
    Be sure to enable hostname verification for your production environment. This is necessary to avoid security issues in production. See the full list of [security recommendations for production]({{base_path}}/install-and-setup/deploying-wso2-api-manager/security-guidelines-for-production-deployment/) environments.

### Configuring hostname verification

The hostname verification is **disabled** by default. This is done using the `org.opensaml.httpclient.https.disableHostnameVerification` and `httpclient.hostnameVerifier` properties in the product's startup script ( `api-manager.sh` for Linux and `api-manager.bat` for Windows) as shown below. The product startup script is stored in the `<PRODUCT_HOME>/bin` directory. This property will be effective during server startup.

```  
    -Dorg.opensaml.httpclient.https.disableHostnameVerification=true \
    -Dhttpclient.hostnameVerifier=AllowAll \
```

!!! note
    The values you can use with this `httpclient.hostnameVerifier` property are explained below. Note that these values will behave the same as synapse hostname verification options.
    
    -   **DefaultAndLocalhost:** This is the value that is enabled, by default. This means that all hostnames, except the ones listed below, will be verified against the hostnames specified in the product's SSL certificate. That is, the following hostnames will be allowed regardless of the server's certificate.
    
        -   localhost
    
        -   localhost.localdomain
    
        -   127.0.0.1
    
        -   ::1
    
        Note that if the wildcard symbol is used to specify a hostname in the SSL certificate (such as \*. [foo.com](http://foo.com/) ), all the subdomains of \*. [foo.com](http://foo.com/) are also included. That is a hostname that matches a subdomain of \*. [foo.com](http://foo.com/) will also be allowed for access.
    
    -   **Strict:** When this mode is enabled, hostnames will be strictly verified against the hostname specified in the product's SSL certificate. For example, if "\*. [foo.com](http://foo.com/) " is specified as the hostname in the certificate, only the hostnames at the same level will be authorized by the server. That is subdomains such as " [a.b.foo.com](http://a.b.foo.com/) " will **not** be authorized.
    
    -   **AllowAll:** This option turns off hostname verification for the server. Note that this is not recommended in a production setup and should only be used for demonstrations and testing.


