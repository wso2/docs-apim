# Encrypting Secrets with apictl

**WSO2 API Controller (apictl)** allows you to encrypt plain-text secrets. You can use this feature to export secrets as environment variables, system properties, Docker secrets, or Kubernetes secrets.

`apictl secret` supports two encryption modes:

- **Symmetric encryption** using an AES-256 encryption key. You must initialize the key first with `apictl secret init symmetric`.
- **Asymmetric encryption** using a keystore initialized with `apictl secret init`.

!!! note
    Use the same encryption mode and algorithm that the target runtime uses to decrypt secrets.

## Choose the encryption mode

<table>
    <tr>
        <th>Mode</th>
        <th>When to use</th>
        <th>Initialization</th>
        <th>Supported cipher values</th>
    </tr>
    <tr>
        <td>Symmetric</td>
        <td>When the target runtime is configured to use AES-based secret encryption.</td>
        <td>Requires <code>apictl secret init symmetric</code>.</td>
        <td>Defaults to <code>AES/GCM/NoPadding</code>. <code>AES256</code> is also accepted as an alias.</td>
    </tr>
    <tr>
        <td>Asymmetric</td>
        <td>When the target runtime uses RSA and a keystore for secret encryption.</td>
        <td>Requires <code>apictl secret init</code>.</td>
        <td><code>RSA/ECB/OAEPWithSHA1AndMGF1Padding</code> or <code>RSA/ECB/PKCS1Padding</code></td>
    </tr>
</table>

## Encrypt secrets with symmetric encryption

Symmetric encryption uses an AES-256 encryption key that must be initialized before creating secrets.

!!! note
    Run `apictl secret init symmetric` before `apictl secret create symmetric`. apictl prompts for the symmetric key once, validates it, stores it in `encryption-key/encryption_key.yaml`, and uses `AES/GCM/NoPadding` as the default symmetric algorithm during secret creation. 

!!! note
    It is recommended to use a 64-character hexadecimal AES-256 key. For example:

    ```bash
    openssl rand -hex 32
    ```

Run the following commands for symmetric encryption:

-   **Initialization**

    ```bash
    apictl secret init symmetric
    ```

-   **Create encrypted secrets**

    ```bash
    apictl secret create symmetric
    ```

    !!! info
        **Flags:**

        -   Optional :  
            `--cipher` or `-c`        : Optional algorithm override for symmetric encryption. The default is `AES/GCM/NoPadding`. `AES256` is also accepted as an alias  
            `--output` or `-o`        : Get the output in yaml (`k8`) or properties (`file`) format. By default the output is printed to the console  
            `--from-file` or `-f`     : Path to the properties file which contains secrets to be encrypted

    -   Encrypt a secret and get output on console

        !!! example

            ```bash
            apictl secret create symmetric
            Enter plain alias for secret: db_password
            Enter plain text secret:
            Repeat plain text secret:
            ```

    -   Encrypt secrets defined in a properties file

        !!! example

            ```bash
            apictl secret create symmetric -f ./keys/secrets.properties
            ```

    -   Encrypt secrets defined in a properties file and get a `.properties` file

        !!! example

            ```bash
            apictl secret create symmetric -o file -f ./keys/secrets.properties
            ```

    -   Encrypt secrets defined in a properties file and get a `.yaml` file

        !!! example

            ```bash
            apictl secret create symmetric -o k8 -f ./keys/secrets.properties
            ```

-   **Response**

    The encrypted value is printed to the console by default. If `-o file` or `-o k8` is used, apictl generates the output file in the `security` directory of the current working directory.

## Encrypt secrets with asymmetric encryption

Asymmetric encryption uses the public key from a keystore. The initialized keystore details are stored in `keystore/keystore_info.yaml`. Before creating secrets, initialize apictl with the keystore used by the target runtime.

### Initialize apictl with a keystore

!!! note
    Secret encryption supports only JKS keystores for this flow.

!!! note
    The keystore used in this step must be the same keystore that the target runtime uses to decrypt secrets.

Run the following command to initialize apictl with the keystore used to encrypt secrets. It prompts you to enter the following values:

<table>
    <tr>
        <td>Key Store location</td>
        <td>Path to the keystore used by the target runtime to decrypt secrets</td>
    </tr>
    <tr>
        <td>Key Store password</td>
        <td>The password of the keystore</td>
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

    ```bash
    apictl secret init
    ```

    !!! example
        ```bash
        apictl secret init
        Enter Key Store location: <APIM-HOME>/repository/resources/security/wso2carbon.jks
        Enter Key Store password:
        Enter Key alias: wso2carbon
        Enter Key password:
        ```

-   **Response**

    ```bash
    Key Store initialization completed.
    ```

### Create encrypted secrets with asymmetric encryption

Run the following command to encrypt secrets with the initialized keystore:

-   **Command**

    ```bash
    apictl secret create
    ```

    !!! info
        **Flags:**

        -   Optional :  
            `--cipher` or `-c`        : Encryption algorithm. Use `RSA/ECB/OAEPWithSHA1AndMGF1Padding` or `RSA/ECB/PKCS1Padding` for asymmetric encryption  
            `--output` or `-o`        : Get the output in yaml (`k8`) or properties (`file`) format. By default the output is printed to the console  
            `--from-file` or `-f`     : Path to the properties file which contains secrets to be encrypted

    -   Encrypt a secret and get output on console

        !!! example

            ```bash
            apictl secret create
            Enter plain alias for secret: db_password
            Enter plain text secret:
            Repeat plain text secret:
            ```

    -   Response

        ```text
        db_password : <encrypted-secret>
        ```

    -   Encrypt secrets defined in a properties file

        !!! example

            ```bash
            apictl secret create -f ./keys/secrets.properties
            ```

    -   Encrypt secrets defined in a properties file and get a `.yaml` file

        !!! example

            ```bash
            apictl secret create -o k8 -f ./keys/secrets.properties
            ```
