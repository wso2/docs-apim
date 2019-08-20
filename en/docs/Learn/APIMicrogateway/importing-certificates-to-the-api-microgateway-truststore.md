# Importing Certificates to the API Microgateway Truststore

For signature validation of JWTs, you need to add the public certificate of the Identity Provider to the truststore of the API Microgateway. Follow the steps given below to import the certificate.

1.  Convert the public certificate to a PEM format. For example,

    ``` java
        openssl x509 -inform der -in public_certificate.cert -out certificate.pem
    ```

2.  Import the certificate to the truststore. The `           ballerinaTruststore.p12          ` resides in the generated distribution of the API Microgateway at `           <MICROGW_HOME>/runtime/bre/security          ` .

    ``` java
            keytool -import -keystore <MICROGW_HOME>/runtime/bre/security/ballerinaTruststore.p12 -alias wso2carbonjwt -file certificate.pem
    ```

        !!! note
    Use the keytool that comes in JDK 8u60 or later.


3.  Update the `           certificateAlias          ` configuration in the `           micro-gw.conf          ` file residing in the `           <MICROGW_HOME>/conf          ` directory.
    The `           certificateAlias          ` value is `           wso2carbonjwt          ` , which is also used in step 2.

    ``` java
        [jwtTokenConfig]
        issuer="https://localhost:8243/token"
        audience="http://org.wso2.apimgt/gateway"
        certificateAlias="wso2carbonjwt"
        trustStore.path="${ballerina.home}/bre/security/ballerinaTruststore.p12"
        trustStore.password="ballerina"
    ```


