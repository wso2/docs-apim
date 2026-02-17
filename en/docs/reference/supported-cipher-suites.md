# Supported Cipher Suites

For a list of cipher suites that are secure and are functional in Tomcat (Tomcat version 9 with the JSSE provider 11) for the TLSv1.2 and TLSv1.3 protocols, see the list of ciphers provided in the [secure configuration generator](https://ssl-config.mozilla.org/#server=tomcat&version=9.0.30&config=intermediate&guideline=5.6), which is provided by the Mozilla Foundation.

For instructions on how to enable the required ciphers and to disable the weak ciphers in API Manager, see [Configuring Transport-Level Security]({{base_path}}/install-and-setup/setup/security/configuring-transport-level-security/).

!!! Attention 

    It is not recommended to use relatively weaker cipher suites, which use DES/3DES, RC4 and MD5, for the following reasons:

    -   DES/3DES are deprecated and should not be used. (e.g., TLS_RSA_WITH_3DES_EDE_CBC_SHA, DES-CBC3-SHA)

    -   MD5 should not be used, due to known collision attacks.

    -   RC4 should not be used due to crypto-analytical attacks. 

    -   DSS is limited to 1024 bit key size.

    -   Cipher-suites that do not provide Perfect Forward Secrecy/ Forward Secrecy (PFS/FS).

    -   Never use even more INSECURE or older ciphers based on RC2, MD4, EXP, EXP1024, AH, ADH, aNULL, eNULL, SEED nor IDEA.
