# Importing Certificates to the API Microgateway Truststore

For signature validation of JWTs, you need to add the public certificate of the Identity Provider to the truststore of the API Microgateway. Follow the steps given below to import the certificate.

1.  Convert the public certificate to a PEM format. For example,

    ``` java
    openssl x509 -inform der -in public_certificate.cert -out certificate.pem
    ```

2.  Import the certificate to the truststore. The `           ballerinaTruststore.p12          ` resides in the generated distribution of the API Microgateway runtime and toolkit in the following locations.

    ``` java
    keytool -import -keystore <MGW_TOOLKIT_HOME>/lib/platform/bre/security/ballerinaTruststore.p12 -alias wso2carbonjwt -file certificate.pem
    ```
    
    !!! note
        Do not unzip the platform.zip in <MGW_TOOLKIT_HOME>/lib/ manually. After you use any toolkit command such as `micro-gw init petstore`, it will be automatically unzipped with necessary contents.

    ``` java
    keytool -import -keystore <MGW_RUNTIME_HOME>/runtime/bre/security/ballerinaTruststore.p12 -alias wso2carbonjwt -file certificate.pem
    ```

    !!! note
        Use the keytool that comes in JDK 8u60 or later.

### Default Certificates and aliases in WSO2 Microgateway 3.2.0 Truststore

The default truststore of WSO2 Microgateway ballerinaTruststore.p12 already contains default public certificates of the following products under the following aliases.

| Product default certificate | Alias         |
|-----------------------------|---------------|
| WSO2 API Manager 2.6.0      | wso2apim      |
| WSO2 API Manager 3.0.0      | wso2carbonnew |
| WSO2 API Manager 3.1.0      | wso2apim310   |
| WSO2 API Manager 3.2.0      | wso2apim310   |
| WSO2 Analytics 3.0.0        | wso2sp        |


