# Using Keystores

WSO2 products use asymmetric encryption by default for the
authentication and protection of data. Asymmetric encryption uses
keystores (with private keys and public key certificates) and
truststores (with only public key certificates).

## Understanding keystores and truststores

A keystore is a repository (protected by a password) that holds the keys
and certificates of a trust chain. There may be multiple trust chains
(i.e., multiple keys with corresponding certificates) in one keystore.
You use these artifacts for security purposes such as protecting
sensitive information and establishing trust between your server and
outside parties that connect to the server. The usage of keys and
certificates contained in a keystore are explained below.

### Keys
According to public-key cryptography, the concept of a key
pair (public key and the corresponding private key) is used for
protecting sensitive information and for authenticating the identity of
external parties that communicate with your server. For example, the
information that is encrypted in your server using the public key can
only be decrypted using the corresponding private key. Therefore, if any
party wants to decrypt this encrypted data, they should have the
corresponding private key, which is usually kept as a secret (not
publicly shared).

###Digital certificates
When there is a key pair, it is also necessary
to have a digital certificate to verify the identity of the keys.
Typically, the public key of a key pair is embedded in this digital
certificate, which also contains additional information such as the
owner, validity, etc. of the keys. For example, if an external party
wants to verify the integrity of data or validate the identity of the
signer (by validating the digital signature), it is necessary for them
to have this digital certificate of the signer. 

### Trust and certification authorities 
To establish trust, the digital certificate containing the public key
should be signed by a trusted certificate signing authority (CA). You
can generate self-signed certificates for the public key (thereby
creating your own certifying authority), or you can get the certificates
signed by the digital certificate of an external CA. When the
certificate is signed by a reputed CA, all the parties that trust this
CA will also trust the certificates signed by them. To establish maximum
trust, it is important to have a root CA directly sign your public key
certificate, or else, you can have an intermediate CA certificate (which
is already signed by a root CA) sign your certificate. Therefore, in the
later case, there can be a chain of CAs involved in signing your public
key certificate. However, note that both types of public key
certificates (self-signed or CA-signed) can be effectively used
depending on the sensitivity of the information that is protected by the
keys.

In summary, each trust chain entry in a keystore contains the
following:

-   A private key protected by a password.
-   A digital certificate in which the public key (corresponding to the
    private key) is embedded.
-   Additionally, If this public key certificate is not self-signed but
    signed by a Certificate Signing Authority (CA), an additional set of
    certificates (of the CAs involved in the signing process) will also
    be included. This may be just one additional certificate if the
    immediate CA certificate that was used to sign the public key
    certificate is of a Root CA. If the immediate certificate is not of
    a root CA, all the certificates of the intermediate CAs should also
    be included in the keystore.  

### Trust store
The usage of a truststore in WSO2 products aligns with the concept of
trust explained above. A truststore is just another repository that is
protected by a password (similar to a keystore), which stores digital
certificates. These certificates can be either of the following:

-   Certificates of trusted third parties with which the WSO2 server
    intends to communicate directly.
-   Certificates of reputed certificate signing authorities (CA) that
    can be used to validate the identity of untrusted third parties that
    are being contacted. For example, consider a scenario where the
    exact certificate of the third party that the WSO2 server is
    attempting to contact is not in the truststore. In this scenario, if
    the third party has a CA-signed certificate and one of the
    certificates of its trust chain is already included in the WSO2
    server's truststore, the trust is automatically granted and a
    successful SSL connection is established between the WSO2 server and
    the third party.

## Related topics

* [Configure keystores for the Micro Integrator]({{base_path}}/install-and-setup/setup/mi-setup/security/configuring_keystores)
* [Create new keystores]({{base_path}}/install-and-setup/setup/mi-setup/security/creating_keystores)
* [Import new SSL certificates to keystores]({{base_path}}/install-and-setup/setup/mi-setup/setup/security/importing_ssl_certificate)
* [Renewing existing SSL certificates in keystores]({{base_path}}/install-and-setup/setup/mi-setup/security/renewing_ca_signed_certificate_in_keystore)
* [Product deployment guidelines]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deployment_checklist)
