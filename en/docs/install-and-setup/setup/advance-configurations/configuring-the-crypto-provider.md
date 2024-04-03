# Configure the Crypto Provider

## What is a Crypto Provider?

Java Cryptographic Service Providers (Crypto Providers) are software modules that offer cryptographic algorithms and services for Java applications. They enable developers to implement various security functionalities such as encryption, decryption, digital signatures, and key management.

## What is the Crypto Provider used in WSO2 API Manager by default?

WSO2 API Manager uses [Bouncy Castle](https://www.bouncycastle.org/) as the default crypto provider for its cryptography related functionalities such as encryption and decryption.

## How to configure the Crypto Provider in APIM?

APIM supports the configuration of crypto provider to either Bouncy Castle (default) or Bouncy Castle FIPS which is a crypto provider and depdencies from Bouncy Castle adhering to the FIPS 140-2 compliance.

### Change the crypto provider to BCFIPS (Bouncy Castle FIPS)

1. Run the script fips.sh or fips.bat in the <APIM-HOME>/bin directory before starting the server.

    === "Linux/Mac OS"
        ``` bash
        cd <API-M_HOME>/bin/
        sh fips.sh
        ```

    === "Windows"
        ``` bash
        cd <API-M_HOME>\bin\
        fips.bat
        ```

2. Verify whether the required changes are done by running the following command.

    === "Linux/Mac OS"
        ``` bash
        cd <API-M_HOME>/bin/
        sh fips.sh VERIFY
        ```

    === "Windows"
        ``` bash
        cd <API-M_HOME>\bin\
        fips.bat VERIFY
        ```

3. Start the APIM server with the following system property.

    === "Linux/Mac OS"
        ``` java
        cd <API-M_HOME>/bin/
        sh api-manager.sh -Dsecurity.jce.provider=BCFIPS
        ```

    === "Windows"
        ``` java
        cd <API-M_HOME>\bin\
        api-manager.bat -Dsecurity.jce.provider=BCFIPS
        ```

### Change the crypto provider to BC (Bouncy Castle)

1. Run the following command before starting the server.

    === "Linux/Mac OS"
        ``` bash
        cd <API-M_HOME>/bin/
        sh fips.sh DISABLE
        ```

    === "Windows"
        ``` java
        cd <API-M_HOME>\bin\
        fips.bat DISABLE
        ```

2. Start the APIM server as usual.

    === "Linux/Mac OS"
        ``` bash
        cd <API-M_HOME>/bin/
        sh api-manager.sh
        ```

    === "Windows"
        ``` bash
        cd <API-M_HOME>\bin\
        api-manager.bat
        ```
