# Mutual TLS Between Choreo Connect and Backend

In Mutual TLS, in addition to the client verifying the server, the server also verifies the client. By having Mutual TLS Between Choreo Connect and Backend, both of the following security measures are applied.

- The router in Choreo Connect only creates connections with a verified set of Servers
- Servers would only accept connections by a previously introduced set of router instanaces

For this to work, in additon to the configurations done for [TLS]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/tls/transport-security/#add-a-certificate-to-choreo-connect-router-as-a-trusted-certificate), the cert of the router must also exist in the backend truststore.

!!! Info

    For usual TLS, if the backend cert has not been added to the Choreo Connect Router truststore already, use these commands below to create a key cert pair and add it to the Router truststore.

    1. Generate a private key for the backend

    ```
    openssl genpkey -out server.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048
    ```

    2. Create the certificate

    ```
    openssl req -x509 -new -key server.key -out server.pem -subj "/CN=example.com" -reqexts SAN -extensions SAN -config <(cat /etc/ssl/openssl.cnf <(printf "[SAN]\nsubjectAltName=DNS:example.com,DNS:www.example.com")) 
    ```
    
    The above command is to create a self-signed certificate for the backend. Note the CN and SAN values. Having both in the backend cert is necessary for the router to complete hostname verification when creating a connection with the backend. 

    3. Add the cert in `server.pem` to the router as decribed in [Add a Certificate to Choreo Connect Router as a Trusted Certificate]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/tls/transport-security/#add-a-certificate-to-choreo-connect-router-as-a-trusted-certificate).


For Mutual TLS, to add the router (client) certificate to the backend (server):

- If the backend truststore is in `.jks` format use:

    ```
    keytool -import -file mg.pem -alias router -keystore backend-truststore.jks
    ```
    pem file for router keystore can be found in `<distribution>/docker-compose/resources/router/security/keystore`

- If it is the usual `/etc/ssl/certs/ca-certificates.crt` append the content in `mg.pem` to `ca-certificates.crt`

