# Mutual SSL Authentication

Certificate-based authentication on the Microgateway is authenticating a request based on a digital certificate, before granting access to the backend. By way of certificate-based authentication, the Microgateway supports mutual SSL. In mutual SSL, both parties the client and the server identifies themselves in order to create a successful SSL connection. Mutual SSL allows a client to make a request without a username and password, provided that the server is aware of the client's certificate.

### Enabling Mutual SSL Authentication for an API

You can use the x-wso2-transports extension to enable mutual SSL client verification for the API. By default, Mutual SSL is optional.

**API definition**

``` yml
x-wso2-mutual-ssl: "mandatory" # can be "mandatory" or "optional"
```

|value| Description|
|-----|------------|
|mandatory| Enable mutual SSL and make **mutual SSL mandatory**. The client should be verified and the mutual SSL handshake must be passed. the API request will be unauthorized if the handshake is failed.|
|optional| Enable mutual SSL but make **mutual SSL optional**. Even if the mutual SSL handshake failed, the API request is not necessarily unauthenticated. If the mutual SSL handshake is passed, the request will be filtered by the mutual SSL handler.|


### Support Mutual SSL Authentication for an API

The Microgateway supports mutual SSL at the API level. It validates the certificate against per API by the name, version, and alias. There are two scenarios in Mutual SSL, the first one is Client directly connects with Microgateway and the second one is the load balancer in front of the Microgateway.

![Mutual SSL overview]({{base_path}}/assets/img/publish/mutualssl.png)

1. <b> Mutual SSL configuration without Load Balancer.</b>
   
    Update the mutual SSL configuration in the micro-gw.conf file residing in the <MICROGW_HOME>/conf directory. Here name is Swagger Petstore, version is 1.0.5, and aliasList is ballerina and wso2apim310.
```
    [mutualSSLConfig]
      [[mutualSSLConfig.api.certificates]]
        name = "Swagger Petstore"
        version = "1.0.5"
        aliasList = ["ballerina", "wso2apim310"]
```

2. <b> Mutual SSL configuration with Load Balancer. </b>
    
    If you are using a load balancer in front of Microgateway then you have to add additional configuration inside the mutualSSLConfig file. Here certificateHeadername is the header name which is appended by the load balancer to store the certificate. Here certificate header name is X-SSL-CERT.
```
    [mutualSSLConfig]
      [[mutualSSLConfig.api.certificates]]
        name = "Swagger Petstore"
        version = "1.0.5"
        aliasList = ["ballerina", "wso2apim310"]
        certificateHeadername = "X-SSL-CERT"
``` 
   
!!! note
    If you do not need to validate the MTSL between the load balancer and the Micro gateway then you need to add an additional configuration other than the above. isClientCertificateValidationEnabled is set to true by default in the Microgateway which means it always validates the MTSL between the microgateway and Load balancer. 
``` 
    [mutualSSLConfig]
     isClientCertificateValidationEnabled = false   
```
### Configure Client and WSO2 Microgateway for Mutual SSL

Add the client's public certificate to the WSO2 Microgateway's trustStorePath in listenerConfig configuration. Also, configure Microgateway's public certificate on the client-side. For more information [importing certificates to the WSO2 Microgateway Truststore]({{base_path}}/publish/security/importing-certificates-to-the-api-microgateway-truststore/)

``` yml tab="micro-gw.conf"
[listenerConfig]
    keyStorePath = "${mgw-runtime.home}/runtime/bre/security/ballerinaKeystore.p12"
    keyStorePassword = "ballerina"
    trustStorePath = "${mgw-runtime.home}/runtime/bre/security/ballerinaTruststore.p12"
    trustStorePassword = "ballerina"
```

!!! note
    Mutual SSL authentication is currently supporting only HTTP 1.1 . Therefore the following
    configuration should be added to the micro-gw.conf file.
    ```yml
    [http2]
        enable = false
    ```

### Invoking an API using certificate-based authentication

When invoking an API, you can pass the certificate to the API Microgateway as follows.

!!! note
    In this tutorial, a self-signed certificate is added into the already available ballerina truststore.

!!! note
    The instructions below are based on Firefox 65.0.1.

1.  Navigate to the browsers certificate management section. on Firefox, navigate to Preferences &gt; Privacy & Security &gt; Certificates
    ![browser certificates]({{base_path}}/assets/img/publish/mutual-ssl-browse-certs.png){width="700"}
2.  Add the certificate used for the SSL connection.
    ![add certificate]({{base_path}}/assets/img/publish/mutual-ssl-add-cert.png){width="650"}
3.  Invoke the REST API using a REST API client from the browser.
    ![invoke rest API]({{base_path}}/assets/img/publish/invoke-rest-api.png)
4.  The browser will present a user identification request, to select a certificate in order to use for the SSL connection. Select the certificate you added and click OK.
    ![user identification request]({{base_path}}/assets/img/publish/mutual-ssl-user-identification-request.png)


