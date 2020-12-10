# Supported Cipher Suites

Given below are the cipher suites that are functional in Tomcat (Tomcat version 9 with the JSSE provider 11) for the TLSv1.2 protocols. 

See [Configuring Transport-Level Security]({{base_path}}/install-and-setup/setup/security/configuring-transport-level-security) for instructions on how to enable the required ciphers and to disable the weak ciphers in API Manager.

## Cipher suites supported by Tomcat 9 and  Oracle JDK 11

-    TLS_DHE_RSA_WITH_AES_256_GCM_SHA384

-    TLS_DHE_RSA_WITH_AES_128_GCM_SHA256

-    TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384

-    TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256

-    TLS_DHE_RSA_WITH_AES_256_CBC_SHA256

-    TLS_DHE_RSA_WITH_AES_128_CBC_SHA256

-    TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384

-    TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256

-    TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256

-    TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384

-    TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256

-    TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384


## Weak ciphers

!!! Attention 

    Listed below are the relatively weaker cipher suites (which use DES/3DES, RC4 and MD5). It is not recommended to use these cipher suites for the following reasons:

    -   DES/3DES are deprecated and should not be used. (e.g., TLS_RSA_WITH_3DES_EDE_CBC_SHA, DES-CBC3-SHA)

    -   MD5 should not be used, due to known collision attacks.

    -   RC4 should not be used due to crypto-analytical attacks. 

    -   DSS is limited to 1024 bit key size.

    -   Cipher-suites that do not provide Perfect Forward Secrecy/ Forward Secrecy (PFS/FS).

    -   Never use even more INSECURE or older ciphers based on RC2, MD4, EXP, EXP1024, AH, ADH, aNULL, eNULL, SEED nor IDEA.

The following cipher suites are weak for Tomcat version 9 and JDK version 11:

-   TLS_ECDHE_ECDSA_WITH_RC4_128_SHA

-   TLS_ECDHE_RSA_WITH_RC4_128_SHA

-   SSL_RSA_WITH_RC4_128_SHA

-   TLS_ECDH_ECDSA_WITH_RC4_128_SHA

-   TLS_ECDH_RSA_WITH_RC4_128_SHA

-   SSL_RSA_WITH_RC4_128_MD5

-   TLS_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA

-   TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA

-   SSL_RSA_WITH_3DES_EDE_CBC_SHA

-   TLS_ECDH_ECDSA_WITH_3DES_EDE_CBC_SHA

-   TLS_ECDH_RSA_WITH_3DES_EDE_CBC_SHA

-   SSL_DHE_RSA_WITH_3DES_EDE_CBC_SHA

-   SSL_DHE_DSS_WITH_3DES_EDE_CBC_SHA
