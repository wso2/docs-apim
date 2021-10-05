# Securing APIs with Certificate Bound Access Tokens

While OAuth 2.0 relies on bearer tokens for securing access to protected resources, bearer tokens require Transport Layer Security between an OAuth client and the resource server when presenting the access token to get access to a resource. In this security model, it is crucial to prevent access token leakage. Therefore, access token storage and transfer have to be done with care.

APIs in WSO2 API Manager can be secured using Certificate Bound Access Tokens, also known as Holder of Key Tokens. The following section explains as to how the APIs in WSO2 API Manager can be secured using Certificate Bound Access Tokens.

## Import client certificate to the truststore

 Follow the steps given below to import the CA-signed public key certificate into API Manager's default truststore (client-truststore.jks).
 
1.  Get a copy of the `client-truststore.jks` file from the `<API-M_HOME>/repository/resources/security/` directory.
2.  Export the public key from your .jks file using the following command.

    ``` bash
    keytool -export -alias certalias -keystore newkeystore.jks -file <public key name>.pem
    ```

3.  Import the public key you extracted in the previous step to the `client-truststore.jks` file using the following command.

    ``` bash
    keytool -import -alias certalias -file <public key name>.pem -keystore client-truststore.jks -storepass wso2carbon
    ```

    !!! Note
    
        `wso2carbon` is the keystore password of the default `client-truststore.jks` file.

## Enable the Certificate Bound Access Token

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file.

2. Configure the `enable_outbound_auth_header` under the `[apim.oauth_config]` configuration.

    ``` tab="Format"
    [apim.oauth_config]
    enable_certificate_bound_access_token = <true|false>
    ```

    ``` tab="Example"
    [apim.oauth_config]
    enable_certificate_bound_access_token = true
    ```
 
3. Restart the server if it is already running.    
     
## Create an API secured with OAuth 2.0

1. Sign in to the Publisher.

     `https://<hostname>:9443/publisher`

2. [Create an API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api).     
    
### Invoke an API secured with Certificate Bound Access Token using Postman

Import the certificate and private key to Postman.

1. Navigate to the certificates tab in Postman settings.
    
     [![Add the certificate to Postman]({{base_path}}/assets/img/learn/add-certificate-to-postman.png)]({{base_path}}/assets/img/learn/add-certificate-to-postman.png)
    
2. Add the certificate and private key.

     [![Provide certificate and private key]({{base_path}}/assets/img/learn/provide-crt-and-private-key.png)]({{base_path}}/assets/img/learn/provide-crt-and-private-key.png)
    
3. Set the Certificate Bound Access Token as the Bearer token.
   
     The token comprises of client certificate thumbprint as the cnf claim.
   
    ```
    "cnf", "{"x5t#S256": "9a0c3570ac7392bee14a408ecb38978852a86d38cbc087feeeeaab2c9a07b9f1"}"
    ```

4. Invoke the API from Postman.

### Validate Certificate Bound Access Tokens when SSL is terminated by the Load Balancer or Reverse Proxy

When the SSL termination of API requests takes place at the Load Balancer or Reverse Proxy, the following prerequisites need to be met by the Load Balancer.

-   Terminate the mutual SSL connection from the client.
-   Pass the client SSL certificate to the Gateway in an HTTP Header. 

     For more information, see the [Nginx documentation](https://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_client_certificate).

### Using MTLS Header to invoke APIs secured with Certificate Bound Access Tokens

By default, the WSO2 API Manager retrieves the client certificate from the **X-WSO2-CLIENT-CERTIFICATE** HTTP header.

Follow the instructions below to change the header:

1.  Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.

2.  Configure the `certificate_header` under the `[apimgt.mutual_ssl]` configuration.

    ``` tab="Format"
     [apimgt.mutual_ssl]
     certificate_header = "<Header Name>"
     # This property needs to be true if the MutualSSL connection is established between the load balancer and the Gateway.
     enable_client_validation = false
     #This property needs to be true if the certificate should be decoded when it is passed from the load balancer to the Gateway.
     client_certificate_encode = false
    ```

    ``` tab="Example"
     [apimgt.mutual_ssl]
     certificate_header = "SSL-CLIENT-CERT"
     enable_client_validation = false
     client_certificate_encode = false
    ```

3.  Start the server.

4.  Invoke the API  with the custom header.

     ``` bash tab="Format"
     curl -k --location -X GET "<API_URL>" -H  "accept: application/json" -H  "Authorization: Bearer <access-token>" -H "<MTSL_Header_name>:<Certificate_Key>"
     ```

     ``` bash tab="Example"
     curl -k --location -X GET 'https://localhost:8243/test/1.0/foo' -H 'accept: applicaition/json' -H 'Authorization: Bearer 0ee9aa70-d631-3401-b152-521b431036ca' -H 'SSL-CLIENT-CERT: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURsakNDQW40Q0NRRDc2MUpWekluMGNUQU5CZ2txaGtpRzl3MEJBUXNGQURDQmpERUxNQWtHQTFVRUJoTUMKVTB3eEVEQU9CZ05WQkFnTUIxZGxjM1JsY200eEVEQU9CZ05WQkFjTUIwTnZiRzl0WW04eERUQUxCZ05WQkFvTQpCRmRUVHpJeEN6QUpCZ05WQkFzTUFrTlRNUkl3RUFZRFZRUUREQWxzYjJOaGJHaHZjM1F4S1RBbkJna3Foa2lHCjl3MEJDUUVXR25kaGRHaHpZV3hoYTI5eVlXeGxaMlZBWjIxaGFXd3VZMjl0TUI0WERUSXhNREV4TkRBME16VXoKTlZvWERUSXlNREV4TkRBME16VXpOVm93Z1l3eEN6QUpCZ05WQkFZVEFsTk1NUkF3RGdZRFZRUUlEQWRYWlhOMApaWEp1TVJBd0RnWURWUVFIREFkRGIyeHZiV0p2TVEwd0N3WURWUVFLREFSWFUwOHlNUXN3Q1FZRFZRUUxEQUpEClV6RVNNQkFHQTFVRUF3d0piRzlqWVd4b2IzTjBNU2t3SndZSktvWklodmNOQVFrQkZocDNZWFJvYzJGc1lXdHYKY21Gc1pXZGxRR2R0WVdsc0xtTnZiVENDQVNJd0RRWUpLb1pJaHZjTkFRRUJCUUFEZ2dFUEFEQ0NBUW9DZ2dFQgpBTWMrRjhJblZmMzAwZ2FraTh2QUZ6cUFTSGNQV0xZalQ4dmMwOUs1TzZHRjgzaXpUa2F0UDFtYW1ydWlKL2VRCk1KL2VLVGhJdzR3MWEzS3Y4cjJwc3d2bWRjdjAzZnhRNis2aFh3Ykh5VUtHWFFwbVhtL3d5VE01NzRlR1cybXAKM2toTjlIdFV0SU5uS3BzSENLcFI3MFhGKzNrTTZleHJJNnRJUUpxdTdKM2t1OEdqRVI3R1Vma2trYXI1OGs3eApibEpIWG5URkdjWXJNSXAvcS9YUENqR0pGajhub2tNbjhnL0dWTExCVGFXSWJVa3E2ejRJYjk1dHNOd2thU1dhCnh6U2t3K3JIVkZLWnpPTlV1WTdKTk16Zkp6RkllZG5lY0U3c2Y0WnFIRlF6aUpVbW9qWklDMXp5bFdZdzQ4OEUKNUZvaU9xTWpHYTlUMXhXMUpOWTBab01DQXdFQUFUQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFSZTdrcWZlbwpjd1htazRLWlBKMmlnaGY2VU9jc2dYSEZqMnVpQTNhSWMrd2xwREJpdkdCbDJHM2gxQXl6UFNtcVpYaUcvTGttCkg1dm43VUpGQXlQRVBlQ25HdWduTk5kZGpnSFp0SEdJLzdXcm1LTHdIOEU3TWdmSWJ6dk5Hd3ZXWmRrZi9DblcKNjNDYzhhTzJQMDhYd0dHU25JSDg2cWF6NEtvZUF1aFlCdHZyekNObERraTFjZ1E1bHczU0djU3dxMlB0eEd4cApvS0xWOUJYUzlVdUNJRDRrYjFqRUo3YlplTis0Z0pDbTVGTldUbWdhWXFDcjdERWIwRkhpWitLVnBsZzJZZ3ZYCkM2Z2ZrRm9NYTVJREwvWGVja0J0dFlITzFKcWUyMElRKy9kVHB4ZWE4RjE5aDVmeDRZWVlsRFhLWS8wRmxiRXoKZ1l2UGFIUnVKWnFlV1E9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=='
     ```
!!! note
     The Certificate Bound Access Token validation flow described above uses the **Nginx** load balancer. When using a different Elastic Load Balancer (ELB) to configure the MTSL with SSL termination, make sure to refer the service provider's documentation and the feature catalog to do the necessary configurations.    
