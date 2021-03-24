# Renewing a CA-Signed Certificate in a Keystore

The [digital certificates]({{base_path}}/reference/mi-security-reference/using_keystores) that are used for SSL handshaking has a validity period. Once a certificate expires, it can cause the client-server communication to fail at the SSL handshake level. 

!!! Note
    It is required to renew the certificates before the expiration date.

## Before you begin

Note the following:

-   Use the same certificate authority that you used when you first got
    the public certificate. If you use a different certificate authority
    for certificate renewal, you will have to import the new
    CA-certificate as well as the intermediate certificates to the
    keystore and the client’s trust store.
-   If the certificate authority’s certificate is not in the keystore,
    you will get the following error when you try to import the
    CA-signed certificate to the keystore:

    ```bsh
    keytool error: java.lang.Exception: Failed to establish chain from reply
    ```
    
    To overcome the above error, be sure to first import the CA-signed certificate as well as the intermediate certificates to the keystore in the correct order.

Now let's take a look at each high level step in detail .

## Step 1: Check the validity period of the certificate

Follow one of the steps below to view the validity period of a
certificate:

1. If you have a public hostname, go to
    <https://www.sslshopper.com/ssl-checker.html> and specify the
    hostname of your server. SSL hopper lists all the information about
    the server certificate.
2. If you have a java keystore, execute the following keytool command
    to view the certificate information:

    ```bash
    keytool -list -keystore <keystore_name.jks> -alias <cert_alias> -v
    ```

    This prompts for the keystore password. Once you specify the
    password, you can view the certificate information in a human
    readable format where the validity period is displayed as follows:

    ```bash
    Valid from: Sun Jun 18 19:26:25 IST 2017 until: Sat Jun 19 19:26:25 IST 2027
    ```

3. If you have the certificate file, execute the following openssl
    command:

    ```bash
    x509 -in <certname.cer> -text -noout
    ```

    This displays the validity as follows:

    ```bash
    Validity
      Not Before: Jun 18 13:56:25 2017 GMT
      Not After : Jun 19 13:56:25 2027 GMT
    ```

4. If it is a website, you can view the certificate information via the browser. All major browsers provide the capability to view certificate information.

Once you view the validity period of a certificate and if it says that
the certificate is about to expire or has already expired, the next step
you should generate a Certificate Signing Request (CSR) and get a new
certificate generated from the CA.

## Step 2: Generate a certificate signing request

Depending on the type of keystore you have, follow one of the steps
below to generate a CSR:

1. If you have a java keystore, execute the following command:

    ```bash
    keytool -certreq -alias <cert_alias> -file <CSR.csr> -keystore <keystore_name.jks>
    ```
    !!! Note
        If you want generate a CSR with a subject alternative name (SAN), be sure to use the -ext attribute in the keytool command to specify required SAN.

    Following is a sample keytool command that includes a SAN:

    ```bash
    keytool -certreq -alias test -file test.csr -keystore test.jks -ext SAN=dns:test.example.com
    ```

2. If you have the private key and public key, execute the following command:

    ```bash
    openssl x509 -x509toreq -in <cert_name.crt> -out <CSR.csr> -signkey <private_key.key>
    ```

Once you generate the CSR, you need to submit the CSR to your certificate authority to get a new CA-signed certificate. For testing purposes you can go to <http://www.getacert.com/signacert.html> and submit your CSR to obtain a new CA-signed certificate for free.

After you obtain a new certificate, you have to import the new certificate to a keystore if you are using a java keystore.

## Step 3: Import the new certificate to a keystore

Execute the following command to import a new certificate to a keystore:

```bash
keytool -import -v -trustcacerts -alias <current_alias> -file <ca_signed_cert.cer> -keystore <keystore_name.jks>
```

!!! Note
    If you want to view information related to the renewed certificate,execute the following keytool command:

```bash
keytool -list -keystore <keystore_name.jks> -alias <cert_alias> -v
```