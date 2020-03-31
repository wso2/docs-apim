# Securing APIs with Mutual SSL

In contrast to the usual one-way SSL authentication where a client verifies the identity of the server, in mutual SSL the server validates the identity of the client so that both parties trust each other. This builds a system that has a very tight security and avoids any requests made to the client to provide the username/password, as long as the server is aware of the certificates that belong to the client.

This section explains how to APIs in WSO2 API Manager can be secured using mutual SSL in addition to OAuth2.

-   [Create an API Secured with Mutual SSL](#SecuringAPIswithMutualSSL-CreateanAPISecuredwithMutualSSL)
-   [Invoke an API Secured with Mutual SSL from the Developer Portal](#SecuringAPIswithMutualSSL-InvokeanAPIsecuredwithMutualSSLfromtheDeveloperPortal)

### Create an API Secured with Mutual SSL

1.  [Create an API](/learn/design-api/create-api/create-a-rest-api) .
2.  Navigate to the **Runtime Configurations** tab.
3.  Select **Mutual SSL**.
    ![]({{base_path}}/assets/img/learn/enable-mutual-ssl.png)

4.  Click **Upload Certificate** to upload a new client certificate.
    
    !!! note
        This feature currently supports only the `.crt` format for certificates.

        If you need to use a certificate in any other format, you can convert it using a standard tool before uploading.




5.  Provide an alias and public certificate. Select the tier that should be used to throttle out the calls using this particular client certificate and click **Upload** .
    ![]({{base_path}}/assets/img/learn/upload-certificate.png)
    
6.  **Save** the API
    
### Invoke an API secured with Mutual SSL using Postman

1.  Import the certificte and private key to Postman. Navigate to certificates tab in Postman settings.
    
    ![]({{base_path}}/assets/img/learn/add-certificate-to-postman.png)
    
    Add the certificate and private key.
    ![]({{base_path}}/assets/img/learn/provide-crt-and-private-key.png)
    
2.  Invoke the API from Postman.

#### Limitations

Listed below are the known limitations for this feature.

-   Application subscription is not permitted for APIs that are only protected with mutual SSL. Hence, subscription/application level throttling is not applicable for these type of APIs.

-   Resource level throttling is not applicable for the APIs that are only protected with mutual SSL.

-   Resource level security will not be applicable for the APIs that are only protected with mutual SSL.

-   Scope level security will not be applicable for the APIs that are only protected with mutual SSL.
