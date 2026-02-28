# Tenant Sharing between WSO2 API Manager and WSO2 Identity Server 7.x

When migrating to WSO2 Identity Server 7.x versions (WSO2 IS 7.x), users may notice that tenant synchronization via a shared database is no longer supported. To avoid disrupting the user experience due to this change, this feature was introduced. This mode is disabled by default and must be explicitly enabled through a configuration.
Tenant sharing can be configured in either direction: from API Manager to Identity Server or from Identity Server to API Manager

!!! important
    It is important to note that this feature must not be enabled on both products simultaneously, as it is designed to work in only one direction per deployment.

## Setting up Configuration for Mutual SSL

By default, authentication between WSO2 API Manager and WSO2 Identity Server 7.x is performed via Mutual SSL. Therefore, it is necessary to configure a certificate that is trusted by both components during deployment.

**1\.  Exchange and import certificates**

   *   Import the public certificate of WSO2 IS 7.x into the truststore of WSO2 API Manager.

   *   Import the public certificate of WSO2 API Manager into the truststore of WSO2 IS 7.x.

   *   For detailed instructions, refer to the [Importing certificates to the truststore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore) guide.

**2\. Enable client certificate-based authentication** 

Add the following configuration to the `<Product-Home>/repository/conf/deployment.toml` of WSO2 IS 7.x to globally enable client certificate-based authentication.

```toml
[client_certificate_based_authentication]
enable = true
log_client_cert_info = true # optional
```

**3\. Configure Mutual SSL for accessing REST APIs** 

Since by default the Key Manager use case in WSO2 API Manager communicates with WSO2 IS 7.x REST APIs over Mutual SSL using the `WSO2-Identity-User` header, add the following configuration to `<Product-Home>/repository/conf/deployment.toml` of WSO2 IS 7.x.

When configuring WSO2 IS 7.x as a Key Manager in the API Manager Admin Portal with Mutual SSL authentication, you must provide a username that is listed under the `allowed_username` field here.

```toml
[[client_certificate_based_authentication.user_thumbprint_mapping]]
trusted_issuer   = "<DN_of_the_Issuer>"
cert_thumbprint  = "<thumbprint_of_trusted_certificate>"
allowed_username = ["*"]
```

!!! info
    `trusted_issuer` : Name of the cert issuer of API Manager's certificate

    `cert_thumbprint` : SHA256 thumbprint. Wildcard (*) is allowed

    `allowed_username` : Which user this certificate is mapped to. You need to add a username which is available in IS. Wildcard (*) is allowed.

    You could use `openssl x509 -noout -in <cert_file> -issuer -fingerprint -sha256` to get certificate information

## Tenant Synchronization from WSO2 IS 7.x to WSO2 API Manager

!!! note 
    Starting from WSO2 Identity Server 7.2.0, it is possible to create tenant domains without a mandatory dot extension (e.g., abc instead of abc.com). If you intend to support tenant domains in this format, please add the following configuration to the `<Product-Home>/repository/conf/deployment.toml` file of API Manager to avoid errors during tenant synchronization: : 
    ```toml
    [multi_tenancy]
    stratos.public_cloud_setup = false
    ```

If you want to sync the tenant create/ update/ tenant enable or disable status update events made in WSO2 IS 7.x to API Manager, you have to enable this config in the `<Product-Home>/repository/conf/deployment.toml` file of the WSO2 IS 7.x. 
```toml
[[event_listener]]
id = "tenant_creation"
type = "org.wso2.carbon.user.core.listener.UserOperationEventListener"
name = "org.wso2.carbon.identity.mgt.listener.TenantSyncListener"
order = 1
[event_listener.properties]
notification_endpoint = "https://localhost:9443/internal/data/v1/notify"
username = "<username>"
password = "<password>”
'header.X-WSO2-KEY-MANAGER' = "TENANT_MANAGEMENT"
```

!!! note
    The user in API Manager, whose credentials are provided above, must have the modify/tenant permission of the super admin.

## Tenant Synchronization from WSO2 API Manager to WSO2 IS 7.x

To enable tenant sharing from API Manager to WSO2 IS 7.x, add the following configuration to the `<Product-Home>/repository/conf/deployment.toml` file in API Manager.
This setup ensures that whenever a new tenant is created in API Manager, the same tenant will automatically be created in WSO2 IS 7.x. The same behavior applies to tenant updates, activations, and deactivations.

```toml
[[apim.tenant_sharing]]
type = "WSO2-IS-7"
[apim.tenant_sharing.properties]
enable_tenant_sync= true
username= "admin"
password= "admin"
identity_server_base_url= "https://localhost:9444"
auto_configure_key_manager=true
```

!!! info
    Please find the definitions of configuration parameters as follows :

    `type` : Specifies the identity provider type. For this setup, use WSO2 IS 7.x.


    `enable_tenant_sync` : Set this value to `true` if you want API Manager to synchronize tenants with WSO2 IS 7.x. By default, this is set to `false`.


    `username`, `password` : Provide the credentials of a user in WSO2 IS 7.x who has the necessary permissions to create, update, activate, and deactivate tenants.


    `identity_server_base_url` : Specify the base URL of the WSO2 IS 7.x instance with which tenants should be synchronized.


    `auto_configure_key_manager` : Whether to configure a key manager of the provided type (in this case WSO2-IS-7), as the default key manager. This is set to `false` by default.

## Configuring WSO2 IS 7.x as the default key manager
Enabling WSO2 IS 7.x as the default Key Manager is only applicable for the newly created tenants.

!!! note
    Since the super tenant is created initially, WSO2 IS 7.x cannot be automatically registered as the default Key Manager for the super tenant. In this case, you must configure a Key Manager for the super tenant manually. 


For configuring WSO2 IS 7.x as the default key manager you have to add the following configurations to the `<Product-Home>/repository/conf/deployment.toml`:

````toml
[apim.tenant_sharing.properties]
skip_create_resident_key_manager = true
auto_configure_key_manager=true
````
By setting `skip_create_resident_key_manager` = `true`, the default Resident Key Manager will not be created for any tenant, including the super tenant.

By enabling `auto_configure_key_manager` = `true`, WSO2 IS 7.x will be automatically configured as the Key Manager for any newly created tenant.


!!! important
    If you ever set `auto_configure_key_manager=true` you must set `skip_create_resident_key_manager = true` under `apim.key_manager` configuration, to avoid facing errors when it's trying to add another key manager on top of the resident key manager in API Manager.


Now the WSO2 IS 7.x as the  default key manager will be created with the name `Resident Key Manager` and its type would be `WSO2-IS-7` .


!!! info

    Enabling tenant sharing and auto configuring a key manager of the provided type, instead of the resident key manager which is created by default, are two **orthogonal features**.
    Which means users can disable tenant sharing and still use the following configuration to avoid creating default resident key manager and allow creating **WSO2 IS 7.x as a third party key manager** as the default key manager.
    
    ````toml
    [apim.tenant_sharing.properties]
    skip_create_resident_key_manager = true
    auto_configure_key_manager=true
    ````

[//]: # ( <image>)

## Configuring WSO2 IS 7.x as a third party key manager
Please refer [this]({{base_path}}/administer/key-managers/configure-wso2is7-connector/) guide to configure WSO2 IS 7.x as a Key Manager in API Manager.
