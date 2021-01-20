# Working with Keystores

A keystore is a repository that stores the cryptographic keys and
certificates that are used for various security purposes, such as
encrypting sensitive information and for establishing trust between your
server and outside parties that connect to your server. The usage of
keys and certificates contained in a keystore are explained below.

**Key pairs** : According to public-key cryptography, a key pair
(private key and the corresponding public key) is used for encrypting
sensitive information and for authenticating the identity of parties
that communicate with your server. For example, information that is
encrypted in your server using the public key can only be decrypted
using the corresponding private key. Therefore, if any party wants to
decrypt this encrypted data, they should have the corresponding private
key, which is usually kept as a secret (not publicly shared).

**Digital certificate** : When there is a key pair, it is also necessary
to have a digital certificate to verify the identity of the keys.
Typically, the public key of a key pair is embedded in this digital
certificate, which also contains additional information such as the
owner, validity, etc. of the keys. For example, if an external party
wants to verify the integrity of data or validate the identity of the
signer (by validating the digital signature), it is necessary for them
to have this digital certificate.

**Trusted certificates** : To establish trust, the digital certificate
containing the public key should be signed by a trusted certifying
authority (CA). You can generate self-signed certificates for the public
key (thereby creating your own certifying authority), or you can get the
certificates signed by an external CA. Both types of trusted
certificates can be effectively used depending on the sensitivity of the
information that is protected by the keys. When the certificate is
signed by a reputed CA, all the parties who trust this CA also trust the
certificates signed by them.

!!!info "Identity and Trust"
    The key pair and the CA-signed certificates in a keystore establishes
    two security functions in your server: The key pair with the digital
    certificate is an indication of identity and the CA-signed certificate
    provides trust to the identity. Since the public key is used to encrypt
    information, the keystore containing the corresponding private key
    should always be protected, as it can decrypt the sensitive information.
    Furthermore, the privacy of the private key is important as it
    represents its own identity and protects the integrity of data. However,
    the CA-signed digital certificates should be accessible to outside
    parties that require to decrypt and use the information.

    To facilitate this requirement, the certificates must be copied to a
    separate keystore (called a Truststore), which can then be shared with
    outside parties. Therefore, in a typical setup, you have one
    keystore for identity (containing the private key) that is protected,
    and a separate keystore for trust (containing CA certificates) that is
    shared with outside parties.


## Setting up keystores in the Streaming Integrator

The Streaming Integrator uses keystores mainly for the following purposes:

- Authenticating the communication over Secure Sockets Layer (SSL)/Transport Layer Security (TLS) protocols.

- Communication over Secure Sockets Layer (SSL) when invoking Rest APIs.

- Protecting sensitive information via Cipher Tool.

## Default keystore settings in WSO2 products

The Streaming Integrator is shipped with the following default keystore files stored in the `<SI_HOME>|<SI_TOOLING_HOME>/resources/security` directory.

- `wso2carbon.jks`: This keystore contains a key pair and is used by default in your Streaming Integrator and Streaming Integrator Tooling servers for all of the purposes explained above, except protecting sensitive information via Cipher tool.

- `securevault.jks`: This is the default keystore used by the secure vault to protect sensitive information via Cipher tool.

- `client-truststore.jks`: This is the default trust store that contains the trusted certificates of the keystore used in SSL communication.

By default, the following files provide paths to these keystores:

- `<SI_HOME>|<SI_TOOLING_HOME>/wso2/server/bin/carbon.sh` file
      
    This script is run when you start an Streaming Integrator server. It contains the following parameters, and makes references to the two files mentioned above by default.

    | Parameter            | Default Value                                               | Description                                                                                        |
    |----------------------|-------------------------------------------------------------|----------------------------------------------------------------------------------------------------|
    | `keyStore`           | `"$CARBON_HOME/resources/security/wso2carbon.jks" \`        | This specifies the path to the keystore to be used when running the Streaming Integrator server on a secure network. |
    | `keyStorePassword`   | `"wso2carbon" \`                                            | The password to access the keystore.                                                               |
    | `trustStore`         | `"$CARBON_HOME/resources/security/client-truststore.jks" \` | This specifies the path to the trust store to be used when running the server on a secure network. |
    | `trustStorePassword` | `"wso2carbon" \`                                            | The password to access the trust store.                                                            |

- `<SI_HOME>|<SI_TOOLING_HOME>/conf/server/deployment.yaml` file refers to the above keystore and trust store by default for the following configurations:

   - Listener configurations

    This specifies the key store to be used when the Streaming Integrator is receiving events via a secure network, and the password to access the key store.

   - Databridge configurations

    This specifies the key store to be used when the Streaming Integrator is publishing events via databrige using a secure network, and the password to access the key store.

   - Secure vault configurations

    This specifies the key store to be used when you are configuring a secure vault to protect sensitive information.

!!!note
    It is recommended to replace this default keystore with a new keystore that has self-signed or CA signed certificates when the products are deployed in production environments. This is because `wso2carbon.jks` is available with open source WSO2 products, which means anyone can have access to the private key of the default keystore.

  

## Managing keystores

You can view the default keystores and truststores in the `<SI_HOME>|<SI_TOOLING_HOME>/resources/security` directory. Once you create your own keystore, you can delete the default keystores, but you need to ensure that they are no longer referenced  in the `<SI_HOME>|<SI_TOOLING_HOME>/wso2/server/bin/carbon.sh` file or the `<SI_HOME>|<SI_TOOLING_HOME>/conf/server/deployment.yaml` file.


## Creating new keystores

The Streaming Integrator is shipped with two default keystores named `wso2carbon.jks` and `securevault.jks`. These keystores are stored in the `<SI_HOME>|<SI_TOOLING_HOME>/resources/security` directory. They come with a private/public key pair that is used to encrypt sensitive information for communication over SSL and for encryption/signature purposes in WS-Security. However, note that because these keystores are available with open source WSO2 products, anyone can have access to the private keys of the default keystores. It is therefore recommended to replace these with keystores that have self-signed or CA signed certificates when the Streaming Integrator is deployed in production environments.

### Creating a keystore using an existing certificate

Secure Sockets Layer (SSL) is a protocol that is used to secure communication between systems. This protocol uses a public key, a private key and a random symmetric key to encrypt data. As SSL is widely used in many systems, certificates may already exist that can be reused. In such situations, you can use the CA-signed certificates to generate a Java keystore using OpenSSL and the Java keytool.

1. First, export certificates to the [PKCS12/PFX](https://en.wikipedia.org/wiki/PKCS_12) format. Give strong passwords whenever required.

    !!!info
        It is required to have same password for both the keystore and key.

    Execute the following command to export the certificates:

    `openssl pkcs12 -export -in <certificate file>.crt -inkey <private>.key -name "<alias>" -certfile <additional certificate file> -out <pfx keystore name>.pfx`


2. Convert the PKCS12 to a Java keystore using the following command:

    `keytool -importkeystore -srckeystore <pkcs12 file name>.pfx -srcstoretype pkcs12 -destkeystore <JKS name>.jks -deststoretype JKS`

    Now you have a keystore with CA-signed certificates.

### Creating a keystore using a new certificate

If there are no certificates signed by a Certification Authority, you can follow the steps in this section to create a keystore with keys and a new certificate. In the following steps, you are using the keytool that is available with your JDK installation.

**Step 1: Creating keystore with private key and public certificate**

1. Open a command prompt and go to the `<SI_HOME>|<SI_TOOLING_HOME>/resources/security` directory. All the keystores should be stored here.

2. Create the keystore that includes the private key by executing the following command:

    `keytool -genkey -alias certalias -keyalg RSA -keysize 2048 -keystore newkeystore.jks -dname "CN=<testdomain.org>,OU=Home,O=Home,L=SL,S=WS,C=LK" -storepass mypassword -keypass mypassword`

    This command creates a keystore with the following details:

    - **Keystore name**: `newkeystore.jks`

    - **Alias of public certificate**: `certalias`

    - **Keystore password**: `mypassword`

    - **Private key password**: `mypassword` (this is required to be the same as keystore password)

    !!!tip
        If you did not specify values for the `'-keypass'` and the `'-storepass'` in the above command, you are requested to give a value for the `'-storepass'` (password of the keystore). As a best practice, use a password generator to generate a strong password. You are then asked to enter a value for `-keypass`. Click **Enter**, because we need the same password for both the keystore and the key. Also, if you did not specify values for `-dname`, you will be asked to provide those details individually.

3. Open the `<SI_HOME>|<SI_TOOLING_HOME>/resources/security` directory and check if the new keystore file is created. Make a backup of it and move it to a secure location. This is important because if not your private key is available only on one location.


**Step 2: Creating CA-signed certificates for public key**

Now we have a `.jks` file. This keystore (`.jks` file) can be used to generate a certificate signing request (CSR). This CSR file must be certified by a certificate authority or certification authority (CA), which is an entity that issues digital certificates. These certificates can certify the ownership of a public key.

1. Execute the following command to generate the CSR:

    `keytool -certreq -alias certalias -file newcertreq.csr -keystore newkeystore.jks`

    !!!tip
        As mentioned before, use the same alias that you used during the keystore creation process.

    You are asked to give the keystore password. Once the password is given, the command outputs the `newcertreq.csr` file to the `<SI_HOME>|<SI_TOOLING_HOME>/resources/security` directory. This is the CSR that you must submit to a CA.


2. You must provide this CSR file to the CA. For testing purposes, try the [90 days trial SSL certificate from Comodo](https://www.instantssl.com/).

    !!!info
        It is preferable to have a wildcard certificate or multiple domain certificates if you wish to have multiple sub-domains like *gateway.sampledomain.org*, *publisher.sampledomain.org*, *identity.sampledomain.org*, etc., for the deployment. For such requirements you must modify the CSR request by adding subject alternative names. Most of the SSL providers give instructions to generate the CSR in such cases.

3. After accepting the request, a signed certificate is provided along with several intermediate certificates (depending on the CA) as a bundle (.zip file).

    !!!info "The following is a sample certificate by the CA (Comodo)

        ```text
        The Root certificate of the CA: AddTrustExternalCARoot.crt
        Intermediate certificates:  COMODORSAAddTrustCA.crt , COMODORSADomainValidationSecureServerCA.crt
        SSL Certificate signed by CA: test_sampleapp_org.crt
        ```
  
**Step 3: Importing CA-signed certificates to keystore**

1. Before importing the CA-signed certificate to the keystore, add the root CA certificate and the two intermediate certificates by executing the commands given below. Note that the sample certificates given above are used as examples.

    ```
    keytool -import -v -trustcacerts -alias ExternalCARoot -file AddTrustExternalCARoot.crt -keystore newkeystore.jks -storepass mypassword
    keytool -import -v -trustcacerts -alias TrustCA -file COMODORSAAddTrustCA.crt -keystore newkeystore.jks -storepass mypassword
    keytool -import -v -trustcacerts -alias SecureServerCA -file COMODORSADomainValidationSecureServerCA.crt -keystore newkeystore.jks -storepass mypassword
    ```

    !!!info
        Optionally, you can append the `-storepass <keystore password>` option to avoid having to enter the password when prompted later in the interactive mode.

2. After you add the root certificate and all other intermediate certificates, add the CA-signed SSL certificate to the keystore by executing the following command:

    `keytool -import -v -alias <certalias> -file <test_sampleapp_org.crt> -keystore newkeystore.jks -keypass myppassword -storepass mykpassword`

    !!!tip
        In this command, use the same alias that you used when you created the keystore.

Now you have a Java keystore including a CA-signed certificate that can be used in a production environment. Next, you must add its public key to the `client-truststore.jks` file to enable backend communication and inter-system communication via SSL.

**Adding the public key to client-truststore.jks**

In SSL handshake, the client needs to verify the certificate presented by the server. For this purpose, the client usually stores the certificates it trusts in a trust store. The Streaming Integrator is shipped with the trust store named `client-truststore.jks` that resides in the same directory as the keystore (i.e., `<SI_HOME>|<SI_TOOLING_HOME>/resources/`). Therefore, you need to import the new public certificate into this trust store for front-end and backend communication of the Streaming Integrator to take place in the required manner over SSL.

!!!tip
    In this example, you are using the default `client-truststore.jks` file in the Streaming Integrator as the trust store.

To add the public key of the signed certificate to the client trust store:

1. Get a copy of the `client-truststore.jks` file from the `<SI_HOME>|<SI_TOOLING_HOME>/resources/security` directory.

2. Export the public key from your `.jks` file using the by issuing the following command.

    `keytool -export -alias certalias -keystore newkeystore.jks -file <public key name>.pem`

3. Import the public key you extracted in the previous step to the `client-truststore.jks` file by issuing the following command.

    `keytool -import -alias certalias -file <public key name>.pem -keystore client-truststore.jks -storepass wso2carbon`

    !!!tip
        `wso2carbon` is the keystore password of the default `client-truststore.jks` file.

Now, you have an SSL certificate stored in a Java keystore and a public key added to the `client-truststore.jks` file. Note that both these files should be placed in the `<SI_HOME>|<SI_TOOLING_HOME>/resources/security` directory. You can now replace the default `wso2carbon.jks` keystore in your product with the newly created keystore by updating the relevant configuration files in your product. For more information, see [Configuring Keystores](#configuring-keystores).



## Configuring keystores

Once you have created a new key store and updated the `<SI_HOME>|<SI_TOOLING_HOME>/resources/security/client-truststore.jks` file, you must update the `<SI_HOME>|<SI_TOOLING_HOME>/conf/<PROFILE/deployment.yaml` file to make that keystore work for the required functions. Keystores are used for multiple functions in the Streaming Integrator including securing the servlet transport, databridge communication, encrypting confidential information in configuration files etc.

!!!tip
    - The `wso2carbon.jks` keystore file that is shipped with the Streaming Integrator is used as the default keystore for all functions. However, in a production environment, it is recommended to create new keystores with keys and certificates because the Streaming Integrator is an open source integrator, and anyone who downloads it has access to the default keystore.
    - To find all the functions that require a keystore, you can search for `.jks` in the deployment.yaml file.

e.g., If you want to secure the listener configured for the Streaming Integrator using a keystore, you can enter details relating to the keystore as shown below. In this example, the details of the default key is used.

```
listenerConfigurations:
-
id: "msf4j-https"
host: "0.0.0.0"
port: 9743
scheme: https
keyStoreFile: "${carbon.home}/resources/security/wso2carbon.jks"
keyStorePassword: wso2carbon
certPass: wso2carbon
```

| **Parameter**         | **Description**                                                           |
|-----------------------|---------------------------------------------------------------------------|
|**`keyStoreFile`**     |The path to the keystore file.                                             |
|**`keyStorePassword`** |The password with which the keystore can be accessed.                      |
|**`certPass`**         |The alias of the public certificate issued by the certification authority. |


  
