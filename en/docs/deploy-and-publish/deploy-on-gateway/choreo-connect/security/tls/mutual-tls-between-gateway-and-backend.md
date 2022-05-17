# Mutual TLS Between Choreo Connect and Backend

In Mutual TLS, in addition to the client verifying the server, the server also verifies the client. By having Mutual TLS between Choreo Connect and the backend, both of the following security measures are applied.

- The router in Choreo Connect only creates connections with a verified set of backend servers.
- Backend servers would only accept connections by a previously introduced set of router instances.

## Export the Certificates

!!! Info
    **Before you begin**

    For TLS, if the backend certificate has not been added to the Choreo Connect Router truststore already, use the following commands to create a key and a certificate for the backend, and add the certificate to the Router truststore.

    1. Generate a private key for the backend.

        ```
        openssl genpkey -out backend.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048
        ```

    2. Create the certificate.

        The following command creates a self-signed certificate for the backend. Note the CN and SAN values. Having both in the backend certificate is necessary for the router to complete hostname verification when creating a connection with the backend. 

        ```
        openssl req -x509 -new -key backend.key -out backend.pem -subj "/CN=example.com" -reqexts SAN -extensions SAN -config <(cat /etc/ssl/openssl.cnf <(printf "[SAN]\nsubjectAltName=DNS:example.com,DNS:www.example.com")) 
        ```

    3. Add the certificate in `backend.pem` to the router as described in [Adding Certificates to Specific Clusters]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/tls/transport-security/#adding-certificates-to-specific-clusters).

    Important: The ciphers configured [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/tls/transport-security/#configuration) must match the ciphers supported by your backend.

For Mutual TLS, in addition to the [configurations done for TLS]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/tls/transport-security/#adding-certificates-to-specific-clusters), the certificate of the router must also exist in the backend truststore.
### Add the Router Certificate to the Backend Truststore

- If the backend truststore is in `.jks` format, use:

    ```
    keytool -import -file mg.pem -alias router -keystore backend-truststore.jks
    ```

- If the backend truststore is the usual `/etc/ssl/certs/ca-certificates.crt`, append the content in `mg.pem` to `ca-certificates.crt`

The certificate for router keystore can be found in `<distribution>/docker-compose/resources/router/security/keystore/mg.pem`.

## Test Mutual TLS between Choreo Connect and Backend

1. [Create an API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/)
2. [Test the API]({{base_path}}/design/create-api/create-rest-api/test-a-rest-api/)
