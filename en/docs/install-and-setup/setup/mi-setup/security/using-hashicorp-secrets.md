# Using HashiCorp Secrets 

!!! Info
    This feature is available as a product update from 27/10/2020 onwards. If you don't already have this update, you can [get the latest updates](https://updates.docs.wso2.com/en/latest/updates/overview/) now.

By default, the Micro Integrator is configured to use [WSO2 secure vault for encrypting secrets]({{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text). However, you may encounter certain limitations with WSO2 secure vault if you use secrets with a large number of characters. You can overcome this issue by using HashiCorp secrets.

!!! Note
    HashiCorp secrets are only applicable to synapse configurations. For server configurations, you need to use [WSO2 secure vault]({{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text).

## Before you begin

-   Generate the required secrets in your HashiCorp vault. 
-   Select the server authentication method that you want to use when connecting the Micro Integrator with HashiCorp. There are two authentication methods available for HashiCorp:

    -   [Static Token](https://learn.hashicorp.com/tutorials/vault/tokens?in=vault/auth-methods) authentication
    -   [AppRole Pull](https://learn.hashicorp.com/tutorials/vault/approle) authentication

    If you select <b>Static Token</b> authentication, you need to generate a tokenID from HashiCorp. If you select <b>AppRole Pull</b> authentication, you need to generate a secret ID and role ID. See the HashiCorp documentation for details and instructions.

Copy the [vault-java-driver](https://github.com/BetterCloud/vault-java-driver) to the `lib` folder of your Micro Integrator distribution (`<MI_HOME>/lib`). 

!!! Note
    Vault driver version 5.1.0 is tested with the Micro Integrator.

## Connecting MI to the HashiCorp server

Once you have set up the HashiCorp server, you can configure the Micro Integrator to connect with HashiCorp.

Add the following configurations to the `deployment.toml` file (stored in the `<MI_HOME>/conf` folder) of the Micro Integrator.

!!! Tip
    Be sure to apply the security tokens relevant to the [authentication method](#before-you-begin) you are using. 

```toml
[[external_vault]]
name = "hashicorp"
address = "http://127.0.0.1:8200"
# If Static Token authentication is used, apply the rootToken:
rootToken = "ROOT_TOKEN"
# If AppRole Pull authentication is used, apply the roleId and secretId:
roleId = "ROLE_ID"
secretId = "SECRET_ID"
cachableDuration = 15000
engineVersion = 2
namespace = "NAMESPACE"
trustStoreFile = "${carbon.home}/repository/resources/security/client-truststore.jks"
keyStoreFile = "${carbon.home}/repository/resources/security/wso2carbon.jks"
keyStorePassword = "KEY_STORE_PASSWORD"
```

<table>
    <tr>
        <th>
            Parameter
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            name
        </td>
        <td>
            Specify 'hashicorp' as the external vault name.
        </td>
    </tr>
    <tr>
        <td>
            address
        </td>
        <td>
            The address URL of the HashiCorp server where the secrets are stored.
        </td>
    </tr>
    <tr>
        <td>
            rootToken
        </td>
        <td>
            Only applicable if static token authentication is used when connecting the Micro Integrator to the HashiCorp server.</br></br>
            Use the root token generated from the HashiCorp server.</br></br> See the HashiCorp documentation for instructions on generating this token.
        </td>
    </tr>
    <tr>
        <td>
            roleId
        </td>
        <td colspan="2">
            Only applies if <b>AppRole Pull</b> authentication is used when connecting the Micro Integrator to the HashiCorp server.</br></br> 
            Instead of specifying the rootToken, specify the role ID and secret ID generated from HashiCorp. The secret ID and role ID will internally generate a token and authenticate the HashiCorp server connection.</br></br> 
            See the HashiCorp documentation for instructions on generating these values.</br></br> 
            <b>Note</b>: The secret ID you generate in HashiCorp may expire. If that happens, you can <a href="#renewing-security-token-approle-pull-authentication">renew the security token</a>. 
        </td>
    </tr>
    <tr>
        <td>
            secretId
        </td>
    </tr>
    <tr>
        <td>
            cachableDuration
        </td>
        <td>
            All resources fetched from the HashiCorp vault are cached for this number of milliseconds.</br>
            The default value is 15000. 
        </td>
    </tr>
    <tr>
        <td>
            engineVersion
        </td>
        <td>
            The version of the HashiCorp secret engine. 
        </td>
    </tr>
    <tr>
        <td>
            namespace
        </td>
        <td>
            Namespace support is available only in the Enterprise edition of HashiCorp.
            The namespace value specified here applies globally to HashiCorp secrets in all synapse configurations. 
        </td>
    </tr>
    <tr>
        <td>
            trustStoreFile
        </td>
        <td>
            The keystore file (trust store) that is used to store the digital certificates that the Micro Integrator trusts for SSL communication.</br></br>
            To use the default truststore file in the Micro Integrator, specify '&#36;{carbon.home}/repository/resources/security/client-truststore.jks' as the value.
        </td>
    </tr>
    <tr>
        <td>
            keyStoreFile
        </td>
        <td>
            The keystore used for SSL handshaking when the Micro Integrator communicates with the HashiCorp server. To use the default keystore file in the Micro Integrator, specify '&#36;{carbon.home}/repository/resources/security/wso2carbon.jks' as the value.
        </td>
    </tr>
    <tr>
        <td>
            keyStorePassword
        </td>
        <td>
            The password of the keystore file that is used for SSL communication.</br></br>
            If you are using the default keystore file in the Micro Integrator, the default password is 'wso2carbon'.
        </td>
    </tr>
</table>

## Accessing HashiCorp secrets in synapse configurations

Once your Micro Integrator is connected to HashiCorp, you can point to the secrets stored in the HashiCorp vault from your synapse configurations.

Given below is a sample synapse property that uses a HashiCorp secret:

```xml
<property name="HashiCorpSecret" expression="hashicorp:vault-lookup('path-name', 'field-name') />
```

## Renewing security token (AppRole Pull authentication)

When you generate the secret token from HashiCorp (for enabling AppRole Pull authentication), you have the option of limiting the number of times the secret ID token can be used. This is done using the `secret_id_num_uses` parameter in HashiCorp. In this case, the secret ID will expire after it is used for the specified number of times. 

In such situations, you need to regenerate a secret token from HashiCorp and apply it to the Micro Integrator. You can directly apply the new secret token to the `deployment.toml` file and restart the Micro Integrator. However, note that there will be a downtime due to server restart. 

If you want to update the secret token dynamically without restarting the server, you can use the management API of the Micro Integrator. As shown below, you can send a request to the given URL with the new secret ID (specified in the sample payload).

-   Management API URL: `https://HOST:9164/management/external-vaults/hashicorp`
-   Payload:
    ```json
    {
      "secretId" : "new_secret_id" 
    }
    ```

!!! Tip
    You can use the WSO2 API Controller (APICTL) to update the secret token dynamically. For more information, see [Update HashiCorp AppRole Pull secret ID]({{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl/#update-hashicorp-approle-pull-secret-id).

## Using Namespaces for the HashiCorp connection

Namespace support is available only in the Enterprise edition of HashiCorp. 

You can add a global namespace value in the `deployment.toml` file. See the instructions on [connecting the Micro Integrator with HashiCorp](#connecting-mi-to-the-hashicorp-server). You can also use namespace values per request in synapse configurations as shown below.

```xml
 <property name="HashiCorpSecret" expression="hashicorp:vault-lookup('namespace', 'path-name', 'field-name') />
```