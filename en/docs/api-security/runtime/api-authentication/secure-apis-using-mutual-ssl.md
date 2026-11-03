# Securing APIs with Mutual SSL

In contrast to the usual one-way SSL authentication where a client verifies the identity of the server, in mutual SSL the server validates the identity of the client so that both parties trust each other. This builds a system that has very tight security and avoids any requests made to the client with regard to providing its username/password, as long as the server is aware of the certificates that belong to the client.

The following section explains as to how the APIs in WSO2 API Manager can be secured using mutual SSL in addition to OAuth2.

!!! note
      Mutual SSL/TLS is a security protocol that ensures both the client and the server authenticate with each other. It builds on the standard SSL/TLS protocol used in HTTPS to add an additional layer of security. Hence from APIM 4.0.0 onwards, when using Mutual SSL to invoke APIs, **it is a must to use HTTPS as the transport**.

## Create an API secured with Mutual SSL

1.  [Create an API]({{base_path}}/api-design-manage/design/create-api/create-rest-api/create-a-rest-api/).
2.  Click **Develop -> API Configurations -> Runtime**.
3.  Select **Mutual SSL**.
    
     [![Enable mutual SSL]({{base_path}}/assets/img/learn/enable-mutual-ssl.png)]({{base_path}}/assets/img/learn/enable-mutual-ssl.png)

    !!! note
          HTTP transport will be disabled for an API if it has Mutual SSL enabled.

4.  Click **Add Certificate** to upload a new client certificate.
    
    !!! note
        This feature currently supports `.crt` and `.cer` formats for certificates.

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

#### Understanding the trust model for header-based mutual SSL

When the API Gateway is deployed behind a load balancer that terminates TLS, the gateway receives the client certificate through an HTTP header (by default, `X-WSO2-CLIENT-CERTIFICATE`) rather than directly from the TLS handshake. In this configuration, the load balancer is responsible for all cryptographic validation, including proof of possession of the private key, certificate chain validation, and revocation checking. The gateway trusts the certificate that the load balancer provides in the header and matches it against the certificates uploaded to the API.

**What is `enable_client_validation`?**

The `enable_client_validation` parameter controls whether the gateway verifies that the certificate header comes from a trusted source. When set to `true` (the product default), the gateway accepts the certificate header only if the load balancer-to-gateway connection itself presents a client certificate that exists in the gateway listener truststore. This prevents untrusted callers from injecting arbitrary certificate headers.

When `enable_client_validation` is set to `false`, the gateway accepts the certificate header from any caller that can reach it, without verifying the source of the header. This creates a security risk where anyone who has seen a client's public certificate can replay it by setting the header.

**Recommended secure configuration for load balancer deployments**

To ensure secure mutual SSL authentication when using a load balancer, follow these recommendations:

1. Use mutual TLS between the load balancer and the gateway:
   - Set `enable_client_validation = true` in the `[apimgt.mutual_ssl]` configuration.
   - Configure the load balancer to present a client certificate when connecting to the gateway.
   - Import the load balancer's client certificate into the gateway listener truststore.

2. Configure the load balancer to strip any client-supplied certificate header and set it only from a verified TLS handshake. This prevents header injection attacks.

3. If mutual TLS between the load balancer and gateway is not feasible, use TLS passthrough mode so the gateway performs the handshake directly with the client. In passthrough mode, the `cert_revocation_validation` setting is available on the listener.

!!! warning
    Setting `enable_client_validation = false` should only be used in environments where the gateway cannot be reached by anything except the load balancer, such as when the gateway is in a private network segment with network-level access controls. In other deployments, this configuration allows certificate header replay attacks.

**Certificate matching and validation**

The gateway matches the presented certificate against the API's uploaded certificates using the following criteria:

- Certificates are compared by serial number and subject distinguished name (DN), not by the full certificate content.
- Uploaded certificates are deployed to the gateway listener truststore (`client-truststore.jks` by default, configured in `listenerprofiles.xml`).
- When `enable_certificate_chain_validation` is set to `true`, the gateway resolves issuer certificates from the same listener truststore.
- The gateway HTTPS listener's `SSLVerifyClient` parameter defaults to `optional` and must remain `optional` if any API on that listener uses Optional mutual SSL.

### Transport level security mandatory and optional modes

When you enable mutual SSL for an API, you can configure whether transport level security is mandatory or optional. This setting controls how mutual SSL authentication works together with application-level security mechanisms such as OAuth2, Basic Auth, and API Key.

The following table describes the authentication behavior for different combinations of mutual SSL and OAuth2 security settings:

| Mutual SSL mode | OAuth2 mode | Authentication behavior |
|-----------------|-------------|------------------------|
| Mandatory       | Mandatory   | Both a matching certificate and a valid token are required. |
| Mandatory       | Optional    | A matching certificate is required. The request is not rejected due to a missing or invalid token. |
| Optional        | Mandatory   | A valid token is required. A missing or non-matching certificate does not cause rejection. |
| Optional        | Optional    | A request without a matching certificate is rejected, even with a valid token. |

**Additional authentication rules**

- When mutual SSL is not enabled for an API, application-level security is always mandatory.
- When no application-level security is enabled, mutual SSL is always mandatory.
