# Encrypting Secrets with apictl

**WSO2 API Controller (apictl)** allows you to encrypt a plain-text secret. You can use this feature to export secrets as environment variables, system properties, Docker secrets, or Kubernetes secrets. For more information on using dynamic secrets refer [Dynamic secrets]({{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text/#dynamic-secrets).


## Initialize apictl with a key store

!!! Note    
    Secret encryption supports only JKS Key Stores.

!!! Note    
    Key Store used in this step needs to be the same Key Store which is used by the WSO2 API Manager (WSO2 API-M) or WSO2 Micro Integrator (WSO2 MI) to decrypt secrets.

Run the following command to initialize the apictl with the Key Store used to encrypt the secrets. It will prompt you to input the following,

<table>
    <tr>
        <td>Key Store location</td>
        <td>Path to the Key Store used by the WSO2 API-M or WSO2 MI to decrypt secrets</td>
    </tr>
    <tr>
        <td>Key Store password</td>
        <td>The password of the Key Store</td>
    </tr>
    <tr>
        <td>Key alias</td>
        <td>The alias of the key used to encrypt the secrets</td>
    </tr>
    <tr>
        <td>Key password</td>
        <td>The password of the key used to encrypt the secrets</td>
    </tr>
</table>

-   **Command** 

    ```go
    apictl secret init
    ```

    !!! example
        ```go
        apictl secret init
        Enter Key Store location: /home/wso2mi-4.3.0/repository/resources/security/wso2carbon.jks
        Enter Key Store password: 
        Enter Key alias: wso2carbon
        Enter Key password: 
        ```

-   **Response**

    ``` bash
    Key Store initialization completed
    ```

## Encrypt secrets

!!! Note    
    Secret encryption supports only **RSA/ECB/OAEPWithSHA1AndMGF1Padding** (default) or **RSA/ECB/PKCS1Padding** as encryption algorithm.

!!! Note    
    Encrypting algorithm used in this step needs to be the same algorithm used by the WSO2 API-M or WSO2 MI to decrypt secrets.

!!! Warning
    apictl's default encryption algorithm (`RSA/ECB/OAEPWithSHA1AndMGF1Padding`) does **not** match the WSO2 API-M / WSO2 MI runtime's own default decrypt algorithm, which is `RSA/ECB/PKCS1Padding`. If you encrypt with apictl's default and leave the runtime at its default, secret decryption will fail at startup. Choose one of the following:

    -   **Recommended:** encrypt with `apictl secret create -c RSA/ECB/PKCS1Padding` to match the runtime's default. This requires no server-side configuration change.
    -   **Alternative:** keep apictl's OAEP default, and explicitly set `secretRepositories.file.algorithm=RSA/ECB/OAEPwithSHA1andMGF1Padding` in `secret-conf.properties` (or the equivalent Kubernetes configuration for your deployment) to align the runtime's decrypt algorithm. This setting applies to the **entire** file secret repository, not to a single secret — use it only if every secret in that repository was encrypted with apictl. It will break decryption of any secret that was instead encrypted with `ciphertool`, which defaults to (and self-aligns on) `RSA/ECB/PKCS1Padding`.

Run the following command to encrypt secrets with the apictl,

-   **Command**
    ``` bash
    apictl secret create
    ```

    !!! info
        **Flags:**

        -   Optional :  
            `--cipher` or `-c`        : Encryption algorithm (default is RSA/ECB/OAEPWithSHA1AndMGF1Padding)    
            `--output` or `-o`        : Get the output in yaml (k8) or properties (file) format. By default the output is printed to the console    
            `--from-file` or `-f`     : Path to the properties file which contains secrets to be encrypted

    
    -   Encrypt a secret and get output on console

        !!! example

            ``` bash
            apictl secret create
            Enter plain alias for secret:db_password
            Enter plain text secret:
            Repeat plain text secret:
            ```

    -   Response

        ```go
        db_password : eKALmLVA+HFVl7vqLUUhm6o0Vwsap+L6czwyEKWKomX+AcRmOCAHmiujPXPAZUboWJlZi4k0CwZYAvwD4BflbU8j5CCrtESzOlOrkJaJPormf/ViixRbftae2RqaDozPSEp9zSnfDKlKDXRq==
        ```

    -   Encrypt secrets defined in a properties file

        !!! example

            ``` bash
            apictl secret create -f ./keys/secrets.properties
            ```

    -   Response

        ```go
        db_password : JVlyw8j9TQqoPFTQUnKxNoGJn9p4+gGCHkkyHt2jXGVZoe60xndi2GjBJ1roR6667dlynhABXbcv434DFjz3ZI0iRjg1QhJLoXNtttSFl7KtyNDk5VtRMPDqAckheJAJe02KjWgdZXszEzjtBd6o2mY1nipsWBat3cOq0kt==
        admin_password : gPImOAX1zwHu3malMHm0+Zy5WEcfKpUSmxJ2ZXfI3bi1yIZbHjrHUxiY+MKurTWRN8GJ6+EVL==
        ```

    -   Encrypt secrets defined in a properties file and get a .yaml file

        !!! example

            ``` bash
            apictl secret create -o k8 -f ./keys/secrets.properties
            ```

    -   Response

        ```go
        Kubernetes secret file created in apictl/security/wso2-secrets.yaml with default name and namespace
        You can change the default values as required before applying.
        ```
