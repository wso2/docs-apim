# Supported Cipher Suites

Given below are the cipher suites that are functional in Tomcat ( Tomcat
version 7.0.59 with the JSSE providers 7/8) for the following SSL
protocols: TLSv1, TLSv1.1 and TLSv1.2. See [Configuring Transport-Level
Security](../../setup/configuring-transport-level-security) for instructions on
how to enable the required ciphers and to disable the weak ciphers for
your WSO2 server.

See the following topics:  

### Cipher suites supported by Tomcat 7.0.59 and Oracle JDK 1.8

The following cipher suites are supported by Tomcat version 7.0.59 and
Oracle JDK 1.8:

-   `          TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256         `
-   `          TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256         `
-   `          TLS_DHE_RSA_WITH_AES_128_CBC_SHA256         `
-   `          TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA         `
-   `          TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA         `
-   `          TLS_DHE_RSA_WITH_AES_128_CBC_SHA         `
-   `          TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256         `
-   `          TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256         `
-   `          TLS_DHE_RSA_WITH_AES_128_GCM_SHA256         `

The following additional cipher suites will be supported if JCE
Unlimited Strength Jurisdiction Policy is used with Tomcat 7.0.59 and
Oracle JDK 1.8:

-   `          TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384         `
-   `          TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384         `
-   `          TLS_DHE_RSA_WITH_AES_256_CBC_SHA256         `
-   `          TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA         `
-   `          TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA         `
-   `          TLS_DHE_RSA_WITH_AES_256_CBC_SHA         `
-   `          TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384         `
-   `          TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384         `
-   `          TLS_DHE_RSA_WITH_AES_256_GCM_SHA384         `

### Weak ciphers

!!! note
    Listed below are the relatively weaker cipher suites (which use
    DES/3DES, RC4 and MD5). It is not recommended to use these cipher suites
    for the following reasons:
    
    -   DES/3DES are deprecated and should not be used.
    
    -   MD5 should not be used due to known collision attacks.
    
    -   RC4 should not be used due to crypto-analytical attacks.
    -   DSS is limited to 1024 bit key size.
    
    -   Cipher-suites that do not provide Perfect Forward Secrecy/ Forward
        Secrecy (PFS/FS).
    

The following cipher suites are weak for Tomcat version 7.0.59 when
either JDK version (7/8) is used. The same applies if JCE Unlimited
Strength Jurisdiction Policy is used.

-   `          TLS_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA         `
-   `          TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA         `
-   `          SSL_RSA_WITH_3DES_EDE_CBC_SHA         `
-   `          TLS_ECDH_ECDSA_WITH_3DES_EDE_CBC_SHA         `
-   `          TLS_ECDH_RSA_WITH_3DES_EDE_CBC_SHA         `
-   `          SSL_DHE_RSA_WITH_3DES_EDE_CBC_SHA         `
-   `          SSL_DHE_DSS_WITH_3DES_EDE_CBC_SHA         `

The following cipher suites are weak for Tomcat version 7.0.59 and JDK
version 1.7:

-   `          TLS_ECDHE_ECDSA_WITH_RC4_128_SHA         `
-   `          TLS_ECDHE_RSA_WITH_RC4_128_SHA         `
-   `          SSL_RSA_WITH_RC4_128_SHA         `
-   `          TLS_ECDH_ECDSA_WITH_RC4_128_SHA         `
-   `          TLS_ECDH_RSA_WITH_RC4_128_SHA         `
-   `          SSL_RSA_WITH_RC4_128_MD5         `
