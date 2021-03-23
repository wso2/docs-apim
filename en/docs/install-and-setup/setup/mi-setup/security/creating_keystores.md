# Creating New keystores

There are two ways to create new [keystores for the Micro Integrator]({{base_path}}/reference/mi-security-reference/using_keystores): 

* Create  the keystore with a new (self-signed) public key certificate.
* Generate a keystore using an already existing [CA-signed]({{base_path}}/reference/mi-security-reference/using_keystores) public key certificate.

## Creating a new keystore using a new certificate
You can follow the steps in this section to create a new keystore with a private key and a new public key certificate. We will be using the keytool that is available with your JDK installation. 

!!! Note
    The pubic key certificate we generate for the new keystore is self-signed. If you need a public key certificate that is CA-signed, you can [generate a CA-signed certificate and import it to the keystore]({{base_path}}/install-and-setup/setup/mi-setup/security/importing_ssl_certificat) later. Alternatively, you can follow the instructions to [create a new keystore using a CA-signed public certificate](#creating-a-keystore-using-an-existing-certificate).

1. Open a command prompt and go to the MI_HOME/repository/resources/security/ directory. All keystores should be stored here.
2. Create the keystore that includes the private key by executing the following command:

    ```bash
    keytool -genkey -alias newcert -keyalg RSA -keysize 2048 -keystore newkeystore.jks -dname "CN=<testdomain.org>, OU=Home,O=Home,L=SL,S=WS,C=LK" -storepass mypassword -keypass mypassword
    ```
    This command will create a keystore with the following details:

    * Keystore name: `newkeystore.jks`
    * Alias of public certificate: `newcert`
    * Keystore password: `mypassword`
    * Private key password: `mypassword` (this is required to be the same as the keystore password)

    !!! Note
        If you did not specify values for the '-keypass' and the '-storepass' in the above command, you will be asked to give a value for the '-storepass' (password of the keystore). As a best practice, use a password generator to generate a strong password. You will then be asked to enter a value for -keypass. Click **Enter** because we need the same password for both the keystore and the key. Also, if you did not specify values for -dname, you will be asked to provide those details individually.

3. Open the `MI_HOME/repository/resources/security/` directory and check if the new keystore file is created. Make a backup of it and move it to a secure location. This is important as it is the only place with your private key.

You now have a keystore (.jks file) with a private key and a self-signed public key certificate.

## Creating a keystore using an existing certificate
You can use an already existing CA-signed certificate to generate your keystore for SSL by using **OpenSSL** and **Java keytool**. As SSL is widely used in many systems, certificates may already exist that can be reused. 

1. First, you must export certificates to the  PKCS12/PFX  format. Give strong passwords whenever required. In WSO2 products, it is a must to have the same password for both the keystore and private key.

    Execute the following command to export the entries of a trust chain into a keystore of .pfx format:

    ```bash
    openssl pkcs12 -export -in <certificate file>.crt -inkey <private>.key -name "<alias>" -certfile <additional certificate file> -out <pfx keystore name>.pfx
    ```

2. Convert the PKCS12/PFX formatted keystore to a Java keystore using the following command:

    ```bash
    keytool -importkeystore -srckeystore <pkcs12 file name>.pfx -srcstoretype pkcs12 -destkeystore <JKS name>.jks -deststoretype JKS
    ```

## What's next?
- [Configure the Micro Integrator]({{base_path}}/install-and-setup/setup/mi-setup/security/configuring_keystores) to use new keystores.
- If required, [add SSL certificates]({{base_path}}/install-and-setup/setup/mi-setup/security/importing_ssl_certificat) to your keystore.
- If required, [renew the CA-signed certificate]({{base_path}}/install-and-setup/setup/mi-setup/security/renewing_ca_signed_certificate_in_keystore) in your keystore.
