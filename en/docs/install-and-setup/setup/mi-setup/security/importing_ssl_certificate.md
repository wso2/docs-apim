# Adding SSL Certificates to Keystores

Follow the steps given below to add a new [CA-signed certificate]({{base_path}}/reference/mi-security-reference/using_keystores) to your [keystores]({{base_path}}/reference/mi-security-reference/using_keystores). Note that you do not need to create a new keystore everytime you need a CA-signed certificate.

## Generating SSL certificates for keystores

Follow the steps given below.

> Be sure to update the keystore name before executing the given commands.

1. Execute the following command to generate a certificate signing request (CSR) for your keystore:
    ```bash
    keytool -certreq -alias certalias -file newcertreq.csr -keystore newkeystore.jks
    ```
    As mentioned before, use the same alias that you used during the keystore creation process. You will be asked to give the keystore password. Once the password is given, the command will output the newcertreq.csr file to the MI_HOME/repository/resources/security/ directory. This is the CSR that you must submit to a CA.

2. You must provide this CSR file to the Certification Authority (CA) for certification. For testing purposes, try the 90 days trial SSL certificate from Comodo.

    !!! Note
        It is preferable to have a wildcard certificate or multiple domain certificates if you wish to have multiple subdomains like gateway.sampledomain.org , publisher.sampledomain.org , identity.sampledomain.org , etc., for the deployment. For such requirements, you must modify the CSR request by adding subject alternative names. Most of the SSL providers give instructions to generate the CSR in such cases.

3. After accepting the request, a signed certificate is provided along with a root certificate and several intermediate certificates (depending on the CA) as a bundle (.zip file).

    !!! Info
        **Sample certificates provided by the CA (Comodo)**:
        -   Root certificate of the CA: AddTrustExternalCARoot.crt  
        -   Intermediate certificates:  COMODORSAAddTrustCA.crt, COMODORSADomainValidationSecureServerCA.crt  
        -   SSL Certificate signed by CA: test_sampleapp_org.crt

## Importing SSL certificates to a keystore

Follow the steps given below to import the CA-signed certificate to your keystore.

> Be sure to update the keystore name and passwords before executing the given commands.

1. Before importing the CA-signed certificate to the keystore, you must add the root CA certificate and the two (related) intermediate certificates by executing the commands given below. Note that the sample certificates given above are used as examples.
    ```bash
    keytool -import -v -trustcacerts -alias ExternalCARoot -file AddTrustExternalCARoot.crt -keystore newkeystore.jks -storepass mypassword
    keytool -import -v -trustcacerts -alias TrustCA -file COMODORSAAddTrustCA.crt -keystore newkeystore.jks -storepass mypassword
    keytool -import -v -trustcacerts -alias SecureServerCA -file COMODORSADomainValidationSecureServerCA.crt -keystore newkeystore.jks -storepass mypassword
    ```
    Optionally we can append the `-storepass keystore_password` option to avoid having to enter the password when prompted later in the interactive mode.

2. After you add the root certificate and all other intermediate certificates, add the CA-signed SSL certificate to the keystore by executing the following command:
    ```bash
    keytool -import -v -alias newcert -file <test_sampleapp_org.crt> -keystore newkeystore.jks -keypass mypassword -storepass mypassword
    ```
    In this command, use the same alias (i.e., 'newcert') that you used while creating the keystore

Now you have a Java keystore, which includes a CA-signed public key certificate that can be used for SSL in a production environment. Next, you may need to [import the CA-signed public key certificate to the trust store](#importing-ssl-certificates-to-a-truststore), which is client-truststore.jks by default. This will provide security and trust for backend communication and inter-system communication of WSO2 products via SSL.

## Importing SSL certificates to a truststore

Follow the steps given below to import the CA-signed public key certificate into the Micro Integrator's trust store.

!!! Note
    Be sure to update the trust store name and passwords before executing the given commands.

1. Get a copy of the trust store file from the MI_HOME/repository/resources/security/ directory.
2. Export the public key from your .jks file using the following command.
    ```bash
    keytool -export -alias certalias -keystore newkeystore.jks -file <public key name>.pem
    ```
3. Import the public key you extracted in the previous step to your trust store using the following command.
    ```bash
    keytool -import -alias certalias -file <public key name>.pem -keystore client-truststore.jks -storepass wso2carbon
    ```

## What's next?

If required, [renew the CA-signed certificate]({{base_path}})({{base_path}}/install-and-setup/setup/mi-setup/security/renewing_ca_signed_certificate_in_keystore) in your keystore and trust store.
