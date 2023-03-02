# Mutual SSL Authentication

Certificate-based authentication on the Choreo Connect is authenticating a request based on a digital certificate, before granting access to the backend. By way of certificate-based authentication, the Choreo Connect supports mutual SSL. In mutual SSL, both parties the client and the server identifies themselves in order to create a successful SSL connection. Mutual SSL allows a client to make a request without a username and password, provided that the server is aware of the client's certificate.

### Prerequisites

- Navigate to the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect(-with-apim)/conf/config.toml` file.
- Configure the `mTLSAPIsEnabled` to `true` under the `[router.downstream.tls]` configuration to enable the mTLS APIs in the Choreo Connect.

     ```
      [router.downstream.tls]
         trustedCertPath = "/etc/ssl/certs/ca-certificates.crt"  # Default path for client ca-certificates
         mTLSAPIsEnabled = true
     ```

    !!! important
        Make sure to **close** the **HTTP** port when using this feature, and leave only the **HTTPS** port open. This would prevent any attempts to bypass the mTLS authentication. You may close the port by following one of the steps given below.

        <table>
          <tr>
            <th>Deployment</th>
            <th>Configuration</th>
          </tr>
          <tr>
            <td>Docker Compose</td>
            <td>Set `router.listenerPort` to `0` in the `config.toml` file.</td>
          </tr>
          <tr>
            <td>Kubernetes</td>
            <td>Set `router.listenerPort` to `0` in the `config-toml-configmap` file.</td>
          </tr>
          <tr>
            <td>Kubernetes with Helm Charts</td>
            <td>
            Remove the following section from the `templates/router-service.yaml` file.
            ```yaml
            - name: "http-router"
              port: 9090
              targetPort: 9090
              protocol: TCP
            ```
            Or else, set `router.listenerPort` to `0` in a new `config-toml-configmap.yaml` file and use this file during deployment with the flag `--set-file wso2.deployment.adapter.configToml=<FILE_PATH_FOR_TEMPLATED_CONFIG_TOML>`. Make sure that the other values are also set correctly in the new Configuration file.
            </td>
          </tr>
        </table>
          

{!includes/design/create-mtls-api.md!}

!!! Important
    To invoke mTLS enabled APIs that deployed in Choreo Connect, the CA certificates of the client's public certificates should be added as trusted certificates to the router.

      - [Add a Certificate to Choreo Connect Router as a Trusted Certificate]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/tls/backend-certificates/#add-a-certificate-to-choreo-connect-router-as-a-trusted-certificate)

    If you need to change the location of the volume mount, the `trustedCertPath` value under the `[router.downstream.tls]` in config.toml should also be changed.

{!includes/design/invoke-mtls-api-using-postman.md!}

### Invoke an API secured with Mutual SSL using cURL

-   

     ``` tab="Format"
      curl -k --location -X GET "<API_URL>" -H  "accept: application/json" -H  "Authorization: Bearer <access-token>" --key <client_private_key> --cert <client_public_certificate>
     ```

     ``` tab="Example"
      curl -k --location -X GET 'https://localhost:9095/test/1.0/foo' -H 'accept: applicaition/json' -H 'Authorization: Bearer  0ee9aa70-d631-3401-b152-521b431036ca' --key privateKey.key --cert example.pem
     ```

!!!Note
    `enableClientValidation` configuration should be `true` for sending the client certificates directly to the Choroe Connect. No need to add this configuration to the `config.toml` file since this is the default configuration. If you have added this and changed this to `false`, then the client certificates should be sent within a header.
    ```
     [enforcer.security.mutualSSL]
         enableClientValidation = true
    ```

### Limitations

Listed below are the known limitations for this feature.

-   Application subscription is not permitted for APIs that are only protected with Mutual SSL. Therefore, subscription or application-level throttling is not applicable to these types of APIs.

-   Resource-level throttling is not applicable to the APIs that are only protected with Mutual SSL.

-   Resource-level security will not be applicable to the APIs that are only protected with Mutual SSL.

-   Scope-level security will not be applicable to the APIs that are only protected with Mutual SSL.

{!includes/handling-mtls-ssl-termination.md!}

### Using mTLS Header to invoke APIs secured with Mutual SSL

By default, the Choreo Connect retrieves the client certificate from the **X-WSO2-CLIENT-CERTIFICATE** HTTP header.

Follow the instructions below to enable the mTLS Header and some properties:

1.  Navigate to the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect(-with-apim)/conf/config.toml` file.
2.  Configure the `enableClientValidation` to `false` under the `[enforcer.security.mutualSSL]` configuration to enable the mTLS Header.

    ``` tab="Format"
     [enforcer.security.mutualSSL]
        certificateHeader = "<Header Name>"      # This will give a custom header name for the mTLS header
        enableClientValidation = false           # This should be false to check the header value for the client certificate
        clientCertificateEncode = false          # This should be true if the client certificate in the header is encoded
        enableOutboundCertificateHeader = false  # This should be true if the client certificate is needed to be sent to the backend
    ```

    ``` tab="Example"
     [enforcer.security.mutualSSL]
        certificateHeader = "SSL-CLIENT-CERT"
        enableClientValidation = false
        clientCertificateEncode = false
        enableOutboundCertificateHeader = false
    ```

3.  Start the Server.
4.  Invoke the API  with the custom header.

     ``` bash tab="Format"
     curl -k --location -X GET "<API_URL>" -H  "accept: application/json" -H  "Authorization: Bearer <access-token>" -H "<MTSL_Header_name>:<Certificate_Key>"
     ```

     ``` bash tab="Example"
     curl -k --location -X GET 'https://localhost:9095/test/1.0/foo' -H 'accept: applicaition/json' -H 'Authorization: Bearer 0ee9aa70-d631-3401-b152-521b431036ca' -H 'SSL-CLIENT-CERT: -----BEGIN CERTIFICATE-----LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURsakNDQW40Q0NRRDc2MUpWekluMGNUQU5CZ2txaGtpRzl3MEJBUXNGQURDQmpERUxNQWtHQTFVRUJoTUMKVTB3eEVEQU9CZ05WQkFnTUIxZGxjM1JsY200eEVEQU9CZ05WQkFjTUIwTnZiRzl0WW04eERUQUxCZ05WQkFvTQpCRmRUVHpJeEN6QUpCZ05WQkFzTUFrTlRNUkl3RUFZRFZRUUREQWxzYjJOaGJHaHZjM1F4S1RBbkJna3Foa2lHCjl3MEJDUUVXR25kaGRHaHpZV3hoYTI5eVlXeGxaMlZBWjIxaGFXd3VZMjl0TUI0WERUSXhNREV4TkRBME16VXoKTlZvWERUSXlNREV4TkRBME16VXpOVm93Z1l3eEN6QUpCZ05WQkFZVEFsTk1NUkF3RGdZRFZRUUlEQWRYWlhOMApaWEp1TVJBd0RnWURWUVFIREFkRGIyeHZiV0p2TVEwd0N3WURWUVFLREFSWFUwOHlNUXN3Q1FZRFZRUUxEQUpEClV6RVNNQkFHQTFVRUF3d0piRzlqWVd4b2IzTjBNU2t3SndZSktvWklodmNOQVFrQkZocDNZWFJvYzJGc1lXdHYKY21Gc1pXZGxRR2R0WVdsc0xtTnZiVENDQVNJd0RRWUpLb1pJaHZjTkFRRUJCUUFEZ2dFUEFEQ0NBUW9DZ2dFQgpBTWMrRjhJblZmMzAwZ2FraTh2QUZ6cUFTSGNQV0xZalQ4dmMwOUs1TzZHRjgzaXpUa2F0UDFtYW1ydWlKL2VRCk1KL2VLVGhJdzR3MWEzS3Y4cjJwc3d2bWRjdjAzZnhRNis2aFh3Ykh5VUtHWFFwbVhtL3d5VE01NzRlR1cybXAKM2toTjlIdFV0SU5uS3BzSENLcFI3MFhGKzNrTTZleHJJNnRJUUpxdTdKM2t1OEdqRVI3R1Vma2trYXI1OGs3eApibEpIWG5URkdjWXJNSXAvcS9YUENqR0pGajhub2tNbjhnL0dWTExCVGFXSWJVa3E2ejRJYjk1dHNOd2thU1dhCnh6U2t3K3JIVkZLWnpPTlV1WTdKTk16Zkp6RkllZG5lY0U3c2Y0WnFIRlF6aUpVbW9qWklDMXp5bFdZdzQ4OEUKNUZvaU9xTWpHYTlUMXhXMUpOWTBab01DQXdFQUFUQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFSZTdrcWZlbwpjd1htazRLWlBKMmlnaGY2VU9jc2dYSEZqMnVpQTNhSWMrd2xwREJpdkdCbDJHM2gxQXl6UFNtcVpYaUcvTGttCkg1dm43VUpGQXlQRVBlQ25HdWduTk5kZGpnSFp0SEdJLzdXcm1LTHdIOEU3TWdmSWJ6dk5Hd3ZXWmRrZi9DblcKNjNDYzhhTzJQMDhYd0dHU25JSDg2cWF6NEtvZUF1aFlCdHZyekNObERraTFjZ1E1bHczU0djU3dxMlB0eEd4cApvS0xWOUJYUzlVdUNJRDRrYjFqRUo3YlplTis0Z0pDbTVGTldUbWdhWXFDcjdERWIwRkhpWitLVnBsZzJZZ3ZYCkM2Z2ZrRm9NYTVJREwvWGVja0J0dFlITzFKcWUyMElRKy9kVHB4ZWE4RjE5aDVmeDRZWVlsRFhLWS8wRmxiRXoKZ1l2UGFIUnVKWnFlV1E9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==-----END CERTIFICATE-----'
     ```

!!! note
     The MTLS flow described above uses the **Nginx** load balancer. When using a different ELB to configure the MTSL with SSL termination, refer the service provider's documentation and feature catalog to do the necessary configurations.
