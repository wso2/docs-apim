# Securing APIs with Mutual SSL

In contrast to the usual one-way SSL authentication where a client verifies the identity of the server, in mutual SSL the server validates the identity of the client so that both parties trust each other. This builds a system that has very tight security and avoids any requests made to the client with regard to providing its username/password, as long as the server is aware of the certificates that belong to the client.

The following section explains as to how the APIs in WSO2 API Manager can be secured using mutual SSL in addition to OAuth2.

## Create an API secured with Mutual SSL

1.  [Create an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api).
2.  Click **Runtime Configurations**.
3.  Select **Mutual SSL**.
    
     [![Enable mutual SSL]({{base_path}}/assets/img/learn/enable-mutual-ssl.png)]({{base_path}}/assets/img/learn/enable-mutual-ssl.png)

4.  Click **Add Certificate** to upload a new client certificate.
    
    !!! note
        This feature currently supports only the `.crt` format for certificates.

        If you need to use a certificate in any other format, you can convert it using a standard tool before uploading it.


5.  Provide an alias and public certificate. Select the tier that should be used to throttle out the calls using this particular client certificate and click **Upload**.
    
     [![]({{base_path}}/assets/img/learn/upload-certificate.png)]({{base_path}}/assets/img/learn/upload-certificate.png)
    
6.  **Save** the API.
    
### Invoke an API secured with Mutual SSL using Postman

Import the certificate and private key to Postman.

1. Click **Certificates** in Postman settings.
    
     [![Add the certificate to Postman]({{base_path}}/assets/img/learn/add-certificate-to-postman.png)]({{base_path}}/assets/img/learn/add-certificate-to-postman.png)
    
2. Add the certificate and private key.

     [![Provide certificate and private key]({{base_path}}/assets/img/learn/provide-crt-and-private-key.png)]({{base_path}}/assets/img/learn/provide-crt-and-private-key.png)
    
3.  Invoke the API from Postman.

### Limitations

Listed below are the known limitations for this feature.

-   Application subscription is not permitted for APIs that are only protected with Mutual SSL. Therefore, subscription or application-level throttling is not applicable to these types of APIs.

-   Resource-level throttling is not applicable to the APIs that are only protected with Mutual SSL.

-   Resource-level security will not be applicable to the APIs that are only protected with Mutual SSL.

-   Scope-level security will not be applicable to the APIs that are only protected with Mutual SSL.

### Handling MTLS when SSL is terminated by the Load Balancer or Reverse Proxy

When SSL termination of API requests takes place at the Load Balancer or Reverse Proxy, the following prerequisites need to be met by the Load Balancer.

-   Terminate the mutual SSL connection from the client.
-   Pass the client SSL certificate to the Gateway in an HTTP Header. 

     For more information, see the [Nginx documentation](https://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_client_certificate).

The following diagram illustrates how Mutual SSL works in such an environment.

[![MTLS Load Balancer]({{base_path}}/assets/img/learn/mtls-loadbalancer.png)]({{base_path}}/assets/img/learn/mtls-loadbalancer.png)

By default, the WSO2 API Manager retrieves the client certificate from the **X-WSO2-CLIENT-CERTIFICATE** HTTP header. In order to change the header,

1.  Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.
2.  Configure the `certificate_header` under the `[apimgt.mutual_ssl]` configuration.

     ```
     [apimgt.mutual_ssl]
     certificate_header = "<Header Name>"
     # This property needs to be true if the MutualSSL connection is established between the load balancer and the gateway.
     enable_client_validation = false
     ```

3.  Start the Server.
