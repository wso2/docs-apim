# Securing APIs with Mutual SSL

In contrast to the usual one-way SSL authentication where a client verifies the identity of the server, in mutual SSL the server validates the identity of the client so that both parties trust each other. This builds a system that has very tight security and avoids any requests made to the client with regard to providing its username/password, as long as the server is aware of the certificates that belong to the client.

The following section explains as to how the APIs in WSO2 API Manager can be secured using mutual SSL in addition to OAuth2.

!!! note
      Mutual SSL/TLS is a security protocol that ensures both the client and the server authenticate with each other. It builds on the standard SSL/TLS protocol used in HTTPS to add an additional layer of security. Hence from APIM 4.0.0 onwards, when using Mutual SSL to invoke APIs, **it is a must to use HTTPS as the transport**.

## Create an API secured with Mutual SSL

1.  [Create an API]({{base_path}}/manage-apis/design/create-api/create-rest-api/create-a-rest-api/).
2.  Click **Develop -> API Configurations -> Runtime**.
3.  Select **Mutual SSL**.
    
     [![Enable mutual SSL]({{base_path}}/assets/img/learn/enable-mutual-ssl.png)]({{base_path}}/assets/img/learn/enable-mutual-ssl.png)

    !!! note
          HTTP transport will be disabled for an API if it has Mutual SSL enabled.

4.  Click **Add Certificate** to upload a new client certificate.
    
    !!! note
        This feature currently supports only the `.crt` format for certificates.

        If you need to use a certificate in any other format, you can convert it using a standard tool before uploading it.


5.  Select the key type for which the certificate is uploaded.
    
    !!! note
        When Transport Level Security and OAuth2 as Application Level Security are set to mandatory with MTLS enabled and gateway endpoint is invoked providing a valid certificate, it may verify only the existence of the certificate. 
        Authentication may happen with OAuth2.


6. Provide an alias and public certificate. Select the tier that should be used to throttle out the calls using this particular client certificate and click **Upload**.
    
     [![Upload Certificate]({{base_path}}/assets/img/learn/upload-certificate.png)]({{base_path}}/assets/img/learn/upload-certificate.png)
    
6.  **Save and Deploy** the API.

!!! note
     If you are on a Windows environment, the HTTPS listener would have started on a host address of 0:0:0:0:0:0:0:0. You can verify that from the Carbon logs.
     In that case, you need to define 0:0:0:0:0:0:0:0 as the bindAddress in `<APIM_HOME>/repository/resources/security/listenerprofiles.xml`

### Invoke an API secured with Mutual SSL using Postman

You can invoke the Production or Sandbox endpoint based on the client certificate you upload.
For example, if you have uploaded example.crt as a `Production` type certificate in the Runtime Configurations for the API and you invoke the API using the same certificate here, the Production endpoint will be invoked.

Import the certificate and private key to Postman.

1. Navigate to the certificates tab in Postman settings.
    
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

### Using MTLS Header to invoke APIs secured with Mutual SSL

By default, the WSO2 API Manager retrieves the client certificate from the **X-WSO2-CLIENT-CERTIFICATE** HTTP header.

Follow the instructions below to change the header:

1.  Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.
2.  Configure the `certificate_header` under the `[apimgt.mutual_ssl]` configuration.

    === "Format"
          ```toml
          [apimgt.mutual_ssl]
          certificate_header = "<Header Name>"
          # This property needs to be true if the MutualSSL connection is established between the load balancer and the Gateway.
          enable_client_validation = false
          # This property needs to be true if the certificate should be decoded when it is passed from the load balancer to the Gateway.
          client_certificate_encode = false
          # This property needs to be true if the certificate chain needed to be validated.
          enable_certificate_chain_validation = false
          ```

    === "Example"
          ```toml
          [apimgt.mutual_ssl]
          certificate_header = "SSL-CLIENT-CERT"
          enable_client_validation = false
          client_certificate_encode = false
          enable_certificate_chain_validation = false
          ```

3.  Start the Server.
4.  Invoke the API  with the custom header.

    === "Format"
          ``` bash
          curl -k --location -X GET "<API_URL>" -H  "accept: application/json" -H  "Authorization: Bearer <access-token>" -H "<MTSL_Header_name>:<Certificate_Key>"
          ```

    === "Example"
          ``` bash
          curl -k --location -X GET 'https://localhost:8243/test/1.0/foo' -H 'accept: applicaition/json' -H 'Authorization: Bearer 0ee9aa70-d631-3401-b152-521b431036ca' -H 'SSL-CLIENT-CERT: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURsakNDQW40Q0NRRDc2MUpWekluMGNUQU5CZ2txaGtpRzl3MEJBUXNGQURDQmpERUxNQWtHQTFVRUJoTUMKVTB3eEVEQU9CZ05WQkFnTUIxZGxjM1JsY200eEVEQU9CZ05WQkFjTUIwTnZiRzl0WW04eERUQUxCZ05WQkFvTQpCRmRUVHpJeEN6QUpCZ05WQkFzTUFrTlRNUkl3RUFZRFZRUUREQWxzYjJOaGJHaHZjM1F4S1RBbkJna3Foa2lHCjl3MEJDUUVXR25kaGRHaHpZV3hoYTI5eVlXeGxaMlZBWjIxaGFXd3VZMjl0TUI0WERUSXhNREV4TkRBME16VXoKTlZvWERUSXlNREV4TkRBME16VXpOVm93Z1l3eEN6QUpCZ05WQkFZVEFsTk1NUkF3RGdZRFZRUUlEQWRYWlhOMApaWEp1TVJBd0RnWURWUVFIREFkRGIyeHZiV0p2TVEwd0N3WURWUVFLREFSWFUwOHlNUXN3Q1FZRFZRUUxEQUpEClV6RVNNQkFHQTFVRUF3d0piRzlqWVd4b2IzTjBNU2t3SndZSktvWklodmNOQVFrQkZocDNZWFJvYzJGc1lXdHYKY21Gc1pXZGxRR2R0WVdsc0xtTnZiVENDQVNJd0RRWUpLb1pJaHZjTkFRRUJCUUFEZ2dFUEFEQ0NBUW9DZ2dFQgpBTWMrRjhJblZmMzAwZ2FraTh2QUZ6cUFTSGNQV0xZalQ4dmMwOUs1TzZHRjgzaXpUa2F0UDFtYW1ydWlKL2VRCk1KL2VLVGhJdzR3MWEzS3Y4cjJwc3d2bWRjdjAzZnhRNis2aFh3Ykh5VUtHWFFwbVhtL3d5VE01NzRlR1cybXAKM2toTjlIdFV0SU5uS3BzSENLcFI3MFhGKzNrTTZleHJJNnRJUUpxdTdKM2t1OEdqRVI3R1Vma2trYXI1OGs3eApibEpIWG5URkdjWXJNSXAvcS9YUENqR0pGajhub2tNbjhnL0dWTExCVGFXSWJVa3E2ejRJYjk1dHNOd2thU1dhCnh6U2t3K3JIVkZLWnpPTlV1WTdKTk16Zkp6RkllZG5lY0U3c2Y0WnFIRlF6aUpVbW9qWklDMXp5bFdZdzQ4OEUKNUZvaU9xTWpHYTlUMXhXMUpOWTBab01DQXdFQUFUQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFSZTdrcWZlbwpjd1htazRLWlBKMmlnaGY2VU9jc2dYSEZqMnVpQTNhSWMrd2xwREJpdkdCbDJHM2gxQXl6UFNtcVpYaUcvTGttCkg1dm43VUpGQXlQRVBlQ25HdWduTk5kZGpnSFp0SEdJLzdXcm1LTHdIOEU3TWdmSWJ6dk5Hd3ZXWmRrZi9DblcKNjNDYzhhTzJQMDhYd0dHU25JSDg2cWF6NEtvZUF1aFlCdHZyekNObERraTFjZ1E1bHczU0djU3dxMlB0eEd4cApvS0xWOUJYUzlVdUNJRDRrYjFqRUo3YlplTis0Z0pDbTVGTldUbWdhWXFDcjdERWIwRkhpWitLVnBsZzJZZ3ZYCkM2Z2ZrRm9NYTVJREwvWGVja0J0dFlITzFKcWUyMElRKy9kVHB4ZWE4RjE5aDVmeDRZWVlsRFhLWS8wRmxiRXoKZ1l2UGFIUnVKWnFlV1E9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=='
          ```   
