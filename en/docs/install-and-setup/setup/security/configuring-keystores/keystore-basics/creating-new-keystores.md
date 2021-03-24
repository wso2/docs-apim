# Creating New Keystores

WSO2 API Manager is shipped with a default keystore named **wso2carbon.jks** , which is stored in the `<API-M_HOME>/repository/resources/security` directory. This keystore comes with a private/public key pair that is used for all purposes, such as encrypting sensitive information, communicating over SSL. You can either use one new keystore for all purposes, or you can create multiple keystores for each purpose.

Let's get started with creating new keystores.

## Before you begin

Be sure to go through the [Recommendations for setting up keystores]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#recommendations-for-setting-up-keystores) to understand the types of keystores you need.

## Creating a new keystore

There are two ways to create keystores for WSO2 API Manager. You can either generate a keystore using an already existing public key certificate (CA-signed), or you can create the public key certificate at the time of generating the keystore. See the instructions given below.

### Creating a keystore using an existing certificate

Secure Sockets Layer (SSL) is a protocol that is used to secure communication between systems. This protocol uses a public key, a private key and a random symmetric key to encrypt data. As SSL is widely used in many systems, certificates may already exist that can be reused. In such situations, you can use an already existing CA-signed certificate to generate your keystore for SSL by using OpenSSL and Java keytool.

1.  First, you must export certificates to the **[PKCS12/PFX](http://en.wikipedia.org/wiki/PKCS_12)** format. Give strong passwords whenever required.

    !!! Important
        In WSO2 products, it is a must to have the same password for both the keystore and private key.


    Execute the following command to export the entries of a trust chain into a keystore of .pfx format:

    ``` bash
    openssl pkcs12 -export -in <certificate file>.crt -inkey <private>.key -name "<alias>" -certfile <additional certificate file> -out <pfx keystore name>.pfx
    ```

2.  Convert the **PKCS12/PFX** formatted keystore to a Java keystore using the following command:

    ``` bash
    keytool -importkeystore -srckeystore <pkcs12 file name>.pfx -srcstoretype pkcs12 -destkeystore <JKS name>.jks -deststoretype JKS
    ```

    Now you have a keystore with a CA-signed certificate.

    !!! Important

        If you are creating a new keystore for data encryption, be sure to acquire a public key certificate that contains the **Data Encipherment** key usage as explained in [Recommendations for setting up keystores]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#recommendations-for-setting-up-keystores). Otherwise, the following error can occur when you attempt data encryption:

        ``` java
            Exception in thread "main" org.wso2.ciphertool.CipherToolException: Error initializing Cipher 
                at org.wso2.ciphertool.CipherTool.handleException(CipherTool.java:861) 
                at org.wso2.ciphertool.CipherTool.initCipher(CipherTool.java:202) 
                at org.wso2.ciphertool.CipherTool.main(CipherTool.java:80) 
            Caused by: java.security.InvalidKeyException: Wrong key usage 
                at javax.crypto.Cipher.init(DashoA13..) 
                at javax.crypto.Cipher.init(DashoA13..) 
                at org.wso2.ciphertool.CipherTool.initCipher(CipherTool.java:200) 
                ... 1 more
        ```

### Creating a keystore using a new certificate

You can follow the steps in this section to create a new keystore with a private key and a new public key certificate. We will be using the keytool that is available with your JDK installation. Note that the pubic key certificate we generate for the keystore is **self-signed** . Therefore, if you need a public key certificate that is CA-signed, you need to generate a CA-signed certificate and import it to the keystore as explained in the [next section](#adding-ca-signed-certificates-to-keystores). Alternatively, you can choose the option of generating a new keystore using a CA-signed public certificate as explained [previously](#creating-a-keystore-using-an-existing-certificate) .

1.  Open a command prompt and go to the `<API-M_HOME>/repository/resources/security/` directory. All keystores should be stored here.
2.  Create the keystore that includes the private key by executing the following command:

    ``` bash
    keytool -genkey -alias newcert -keyalg RSA -keysize 2048 -keystore newkeystore.jks -dname "CN=<testdomain.org>, OU=Home,O=Home,L=SL,S=WS,C=LK" -storepass mypassword -keypass mypassword 
    ```

    This command will create a keystore with the following details:

    <table>
        <tbody>
            <tr class="odd">
                <th>Keystore name</th>
                <td>newkeystore.jks</td>
            </tr>
            <tr class="even">
                <th>Alias of public certificate</th>
                <td>newcert</td>
            </tr>
            <tr class="odd">
                <th>Keystore password</th>
                <td>mypassword</td>
            </tr>
            <tr class="odd">
                <th>Private key password</th>
                <td>mypassword</td>
            </tr>
        </tbody>
    </table>

    !!! Note
        Note that if you did not specify values for the '-keypass' and the '-storepass' in the above command, you will be asked to give a value for the '-storepass' (password of the keystore). As a best practice, use a password generator to generate a strong password. You will then be asked to enter a value for -keypass. Click **Enter** because we need the same password for both the keystore and the key. Also, if you did not specify values for \-dname, you will be asked to provide those details individually.


3.  Open the `<API-M_HOME>/repository/resources/security/` directory and check if the new keystore file is created. Make a backup of it and move it to a secure location. This is important as it is the only place with your private key.

You now have a keystore (.jks file) with a private key and a self-signed public key certificate.

## Adding CA-signed certificates to keystores

Now, let's look at how you can get a CA-signed certificate for your keystores. **Note** that you do not need to create a new keystore everytime you need add a CA-signed certificate.

### Step 1: Generating a CA-signed certificate

First, you need to generate a certificate signing request (CSR) for your keystore (.jks file). This CSR file can then be certified by a certification authority (CA), which is an entity that issues digital certificates. These certificates certify the ownership of a public key.

1.  Execute the following command to generate the CSR:

    ``` bash
    keytool -certreq -alias certalias -file newcertreq.csr -keystore newkeystore.jks
    ```

    !!! Note
        As mentioned before, use the same alias that you used during the keystore creation process.

    You will be asked to give the keystore password. Once the password is given, the command will output the newcertreq.csr file to the `<API-M_HOME>/repository/resources/security/` directory. This is the CSR that you must submit to a CA.

2.  You must provide this CSR file to the CA. For testing purposes, try the [90 days trial SSL certificate from Comodo](https://www.comodo.com/e-commerce/ssl-certificates/free-ssl-certificate.php) .

    !!! Note
        It is preferable to have a wildcard certificate or multiple domain certificates if you wish to have multiple subdomains like *[gateway.sampledomain.org](http://gateway.sampledomain.org/)* , *[publisher.sampledomain.org](http://publisher.sampledomain.org/)* , *[identity.sampledomain.org](http://identity.sampledomain.org/)* , etc., for the deployment. For such requirements, you must modify the CSR request by adding subject alternative names. Most of the SSL providers give instructions to generate the CSR in such cases.

3.  After accepting the request, a signed certificate is provided along with a root certificate and several intermediate certificates (depending on the CA) as a bundle (.zip file).

    **Sample certificates provided by the CA (Comodo)**
    <table>
        <tbody>
            <tr class="odd">
                <th>The Root certificate of the CA</th>
                <td>AddTrustExternalCARoot.crt</td>
            </tr>
            <tr class="even">
                <th>Intermediate certificates</th>
                <td>COMODORSAAddTrustCA.crt ,COMODORSADomainValidationSecureServerCA.crt</td>
            </tr>
            <tr class="odd">
                <th>SSL Certificate signed by CA</th>
                <td>test_sampleapp_org.crt PRODUCT</td>
            </tr>
        </tbody>
    </table>

### Step 2: Importing certificates to the keystore

Follow the steps given below to import the CA-signed certificate to your keystore.

1.  Before importing the CA-signed certificate to the keystore, you must add the root CA certificate and the two (related) intermediate certificates by executing the commands given below. Note that the sample certificates given above are used as examples.

    ``` bash
    keytool -import -v -trustcacerts -alias ExternalCARoot -file AddTrustExternalCARoot.crt -keystore newkeystore.jks -storepass mypassword

    keytool -import -v -trustcacerts -alias TrustCA -file COMODORSAAddTrustCA.crt -keystore newkeystore.jks -storepass mypassword
    
    keytool -import -v -trustcacerts -alias SecureServerCA -file COMODORSADomainValidationSecureServerCA.crt -keystore newkeystore.jks -storepass mypassword 
    ```

    !!! Note
        Optionally we can append the `-storepass <keystore password>` option to avoid having to enter the password when prompted later in the interactive mode.


2.  After you add the root certificate and all other intermediate certificates, add the CA-signed SSL certificate to the keystore by executing the following command:

    ``` bash
    keytool -import -v -alias newcert -file <test_sampleapp_org.crt> -keystore newkeystore.jks -keypass mypassword -storepass mypassword
    ```

    !!! Note
        In this command, use the same alias (i.e., 'newcert') that you used while creating the keystore


Now you have a Java keystore, which includes a CA-signed public key certificate that can be used for SSL in a production environment. Next, you may need to add the same CA-signed public key certificate to the `client-truststore.jks` file. This will provide security and trust for backend communication/inter-system communication of WSO2 products via SSL.

### Step 3: Importing certificates to the truststore

In SSL handshake, the client needs to verify the certificate presented by the server. For this purpose,the client usually stores the certificates it trusts, in a truststore. To enable secure and trusted backend communication, all WSO2 products are shipped with a truststore named client-truststore.jks, which resides in the same directory as the default keystore ( `<API-M_HOME>/repository/resources/security/` ).

Follow the steps given below to import the same CA-signed public key certificate (which you obtained in the previous step) into API Manager's default truststore ( `client-truststore.jks` ).

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
        `wso2carbon` is the keystore password of the default client-truststore.jks file.

    Now, you have an SSL certificate stored in a Java keystore and a public key added to the `client-truststore.jks` file. Note that both these files should be in the `<API-M_HOME>/repository/resources/security/` directory. You can now replace the default wso2carbon.jks keystore in your product with the newly created keystore by updating the configuration. 

For information on the concepts of keystores and about how keystores are used in WSO2 API Manager, see [About Asymmetric Cryptography]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/about-asymetric-cryptography).

## What's next?

Once you have created a new keystore in your product as explained above, update the configuration as explained in [Configuring Keystores in API Manager]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager).
