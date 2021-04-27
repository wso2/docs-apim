# Importing Certificates to the API Choreo Connect Truststore

Follow the steps given below to import the certificate.

1.  Convert the public certificate to a PEM format. For example,

    ``` java
    openssl x509 -inform der -in public_certificate.cert -out certificate.pem
    ```

2.  Add the certificate to the relevant components resource folder `<CHOREO-CONNECT_HOME>/docker-compose/resources/<component>/security/truststore` directory.

!!! note
    For signature validation of JWTs, you need to add the public certificate of the Identity Provider to the truststore of the API Choreo Connect. 
    Therefore add public certificate of identity provider in PEM format to `<CHOREO-CONNECT_HOME>/docker-compose/resources/enforcer/security/truststore` directory.
    
3.  Restart the component.
