# Verifying Certificate Revocation

The default HTTPS transport listener (Secured Pass-Through) can verify with the certificate authority whether a certificate is still trusted before it completes an SSL connection. If the certificate authority has revoked the certificate, a connection will not be completed.

When this feature is enabled, the transport listener verifies client
certificates when a client tries to make an HTTPS connection with the server. Therefore, the client needs to send its public certificate along with the requests to the server.

After this feature is enabled, the server attempts to
use the Online Certificate Status Protocol (OCSP) to verify with the
certificate authority at the handshake phase of the SSL protocol. If the
OCSP is not supported by the certificate authority, the server uses Certified Revocation Lists (CRL) instead. The verification
process checks all the certificates in a certificate chain.

To enable this feature for the HTTP Pass-Through, add the following parameters in the ```<WSO2_APIM_HOME>/repository/conf/deployment.toml``` file. and set ```enable``` as ```true```.
This will add these parameters to the Passthrough HTTP Multi SSL Listener in ```<WSO2_APIM_HOME>/repository/conf/axis2/axis2.xml``` file.
Other configurations can be changed according to the requirement. The default configurations are mentioned below.

```toml
[transport.passthru_https.listener.cert_revocation_validation]
enable = false
cache_size = 1024
cache_delay = 1000
allow_full_cert_chain_validation = true
allow_cert_expiry_validation = false
```

When ```allow_full_cert_chain_validation``` is set to ```true``` it is required to send the complete certificate chain in the request.
The ```allow_cert_expiry_validation``` can be set to ```true``` if the certificate expiry validation is required.

If the ```allow_full_cert_chain_validation``` is set to ```false``` a single client certificate is expected in the request and the revocation validation will be done for that certificate. For this to happen it is required to add the immediate issuer of the client certificate in the server's trust store.
Same as above, the ```allow_cert_expiry_validation``` can be set to ```true``` if the certificate expiry validation is required.

In the instances of custom listener profiles are added, following configuration can be used to configure the custom ```<WSO2_APIM_HOME>/repository/resources/security/listenerprofiles.xml``` file.

```
<CertificateRevocationVerifier>
    <Enable>true</Enable>
    <CacheSize>1024</CacheSize>
    <CacheDelay>1000</CacheDelay>
    <FullChainValidation>false</FullChainValidation>
    <ExpiryValidation>true</ExpiryValidation>
</CertificateRevocationVerifier>
```
