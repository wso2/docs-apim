# Advanced Configurations

This section explains how to configure scope to role mappings for API Manager REST APIs.

##Changing Default Roles

Certain resources of the REST API are protected using OAuth 2.0 scopes. Each tenant has a `tenant-conf.json` configuration file with a section for RESTAPIScopes that contain a mapping between all the scopes that are available with API Manager REST APIs, and a set of roles. 

When a user requires access to a resource protected by an OAuth 2.0 scope, an access token associated with that particular scope needs to be provided as the Bearer token in the Authorization header. In order to retrieve the token, the user has to invoke the Token API and request for that scope. For more information, see the Authorization section in REST API documents. When issuing such an access token, the Token API validates the eligibility of the user for that particular scope using the RESTAPIScopes configuration. An access token with the particular scope is issued for the user only if that user has been assigned one or more of the roles specified in the RESTAPIScopes configuration for that scope.

You can modify the default roles defined in RESTAPIScopes configuration according to your requirements via the Admin Portal UI. For more information, refer [Managing Permissions]({{base_path}}/administer/managing-users-and-roles/managing-permissions/#adding-role-based-permissions). 

!!! note
    Restart the server for the RESTAPIScopes configuration changes to take effect.

##Additional Fine-Grained REST API Scopes

In addition to the default scopes listed in the `tenant-conf.json` file, the Publisher, Admin, and Governance REST APIs support a set of fine-grained OAuth 2.0 scopes that enable verb-level (Create / Read / Update / Delete) access control per functional area. These scopes are useful when building customized portals or assigning narrow, task-specific permissions to users.

These additional scopes are declared on the relevant REST API operations in the OAS definitions but are **not** included in the default `tenant-conf.json` shipped with the product. To use any of them, a tenant administrator must add a corresponding entry to the `RESTAPIScopes` section of the target tenant's `tenant-conf.json` with the role mappings required for the deployment. A scope that is not registered in `tenant-conf.json` will not be issued in access tokens for that tenant, and will not grant access to the associated operations.

The full list of supported fine-grained scopes and the operations they protect can be found in the REST API documents:

- [Publisher REST API]({{base_path}}/reference/product-apis/publisher-apis/publisher-v4/publisher-v4/)
- [Admin REST API]({{base_path}}/reference/product-apis/admin-apis/admin-v4/admin-v4/)
- [Governance REST API]({{base_path}}/reference/product-apis/governance-apis/governance-v1/governance-v1/)

**Available fine-grained scopes**

| API | Functional Area | Scopes |
|-----|-----------------|--------|
| Publisher | APIs | `apim:api_metadata_view`, `apim:api_create_only`, `apim:api_update`, `apim:api_definition_view`, `apim:api_definition_update`, `apim:api_version_create` |
| Publisher | API Revisions & Deployments | `apim:api_revision_create`, `apim:api_revision_delete`, `apim:api_deploy`, `apim:api_deploy_view` |
| Publisher | API Lifecycle | `apim:api_lifecycle_view`, `apim:api_lifecycle_manage` |
| Publisher | API Products | `apim:api_product_metadata_view`, `apim:api_product_create`, `apim:api_product_update`, `apim:api_product_delete`, `apim:api_product_version_create` |
| Publisher | API Product Revisions & Deployments | `apim:api_product_revision_create`, `apim:api_product_revision_delete`, `apim:api_product_deploy`, `apim:api_product_deploy_view` |
| Publisher | API Product Lifecycle | `apim:api_product_lifecycle_view`, `apim:api_product_lifecycle_manage` |
| Publisher | MCP Servers | `apim:mcp_server_metadata_view`, `apim:mcp_server_create_only`, `apim:mcp_server_update`, `apim:mcp_server_version_create` |
| Publisher | MCP Server Revisions & Deployments | `apim:mcp_server_revision_create`, `apim:mcp_server_revision_delete`, `apim:mcp_server_deploy`, `apim:mcp_server_deploy_view` |
| Publisher | MCP Server Lifecycle | `apim:mcp_server_lifecycle_view`, `apim:mcp_server_lifecycle_manage` |
| Publisher | Documents | `apim:document_view`, `apim:document_update`, `apim:document_delete` |
| Publisher | Shared Scopes | `apim:shared_scope_view`, `apim:shared_scope_create`, `apim:shared_scope_update`, `apim:shared_scope_delete` |
| Publisher | Common Operation Policies | `apim:common_operation_policy_create`, `apim:common_operation_policy_delete` |
| Publisher | Gateway Policies | `apim:gateway_policy_create`, `apim:gateway_policy_update`, `apim:gateway_policy_delete` |
| Publisher | Publisher Organization | `apim:publisher_organization_read` |
| Admin | Gateway Environments | `apim:environment_create`, `apim:environment_update`, `apim:environment_delete` |
| Admin | API Categories | `apim:api_category_view`, `apim:api_category_create`, `apim:api_category_update`, `apim:api_category_delete` |
| Admin | Throttling Policies | `apim:admin_tier_create`, `apim:admin_tier_update`, `apim:admin_tier_delete` |
| Admin | Deny Policies | `apim:bl_create`, `apim:bl_update`, `apim:bl_delete` |
| Admin | Key Managers | `apim:keymanagers_view`, `apim:keymanagers_create`, `apim:keymanagers_update`, `apim:keymanagers_delete` |
| Admin | Organizations | `apim:organization_create`, `apim:organization_update`, `apim:organization_delete` |
| Admin | AI/LLM Providers | `apim:llm_provider_view`, `apim:llm_provider_create`, `apim:llm_provider_update`, `apim:llm_provider_delete` |
| Admin | Labels | `apim:label_view`, `apim:label_create`, `apim:label_update`, `apim:label_delete` |
| Governance | Governance Rulesets | `apim:gov_rule_create`, `apim:gov_rule_update`, `apim:gov_rule_delete` |
| Governance | Governance Policies | `apim:gov_policy_create`, `apim:gov_policy_update`, `apim:gov_policy_delete` |

The existing broad scopes (such as `apim:api_create`, `apim:api_publish`, `apim:api_manage`) continue to grant access to the same operations as before. The fine-grained scopes are added alongside them, so a token carrying any one matching scope grants access — adopting them is opt-in and fully backward compatible.

**Activating a fine-grained scope for a tenant**

To enable a new scope for users in a particular tenant, add an entry like the following to that tenant's `tenant-conf.json` under `RESTAPIScopes.Scope` via the Admin Portal **Advanced Configurations → Tenant Configurations** page:

```json
{
  "Name": "apim:api_update",
  "Roles": "admin,Internal/creator"
}
```

Replace the `Roles` value with the comma-separated list of role names that should be allowed to obtain the scope. Restart the server (or invalidate the tenant-conf cache) for the change to take effect. Once registered, the scope is issued in OAuth tokens for users with any of the listed roles and is honoured by the REST API on the operations where it is declared.

##Configuring Allowed Origins

By default, each of the Product REST APIs (except Admin v2 REST API) allows requests from all origins. If only a specific set of origins should be allowed to access a Product REST API, the allowed origins for that particular REST API should be configured as a system parameter. The defined system parameters are as follows.

-   For Publisher REST APIs : rest.api.publisher.allowed.origins
-   For Developer Portal REST APIs : rest.api.devportal.allowed.origins
-   For Gateway REST APIs : rest.api.gateway.allowed.origins
-   For Service Catalog REST APIs : rest.api.service.catalog.allowed.origins

The allowed origins for a particular REST API can be configured as a system parameter as follows.

!!! Note

    - The origin will have the following syntax.

    === "Format"
        ```bash
        <scheme>://<hostname>[ :<port> ]
        ```

    === "Example"
        ```bash
        https://myorg1.publisher.example.com
        ```

### Method 1- Specify the allowed origins in the deployment.toml file under [system.parameter]

 1.  Open the `<API-M_HOME>/repository/deployment.toml` file and specify the allowed origins for the REST APIs under `[system.parameter]`.

    === "Format"
        ```toml
        [system.parameter]
        'rest.api.publisher.allowed.origins' = "<comma-separated-origins>"
        'rest.api.devportal.allowed.origins' = "<comma-separated-origins>"
        'rest.api.gateway.allowed.origins' = "<comma-separated-origins>"
        'rest.api.service.catalog.allowed.origins' = "<comma-separated-origins>"
        ```

    === "Example"
        ```toml
        [system.parameter]
        'rest.api.publisher.allowed.origins' = "https://myorg1.publisher.example.com"
        'rest.api.devportal.allowed.origins' = "https://myorg1.devportal.example.com,https://myorg2.devportal.example.com"
        'rest.api.gateway.allowed.origins' = "https://myorg1.gateway.example.com,https://myorg3.gateway.example.com"
        'rest.api.service.catalog.allowed.origins' = "https://myorg1.service.catalog.example.com"
        ```

 2.  Start the server to apply the changes.

      * On Linux/Mac OS: `./api-manager.sh`
      * On Windows: `api-manager.bat`

### Method 2- Specify the allowed origins when starting the server

This can be done in one of two ways.

**Option 1**: Specifying the allowed origins in the server startup script

   1. Specify the allowed origins for the REST APIs in the server startup script stored in the `<PRODUCT_HOME>/bin` directory. (`api-manager.sh` for Linux/Mac OS and `api-manager.bat` for Windows)

    === "Format"
        ```bash
        -Drest.api.publisher.allowed.origins=<comma-separated-origins> \
        -Drest.api.devportal.allowed.origins=<comma-separated-origins> \
        -Drest.api.gateway.allowed.origins=<comma-separated-origins> \
        -Drest.api.service.catalog.allowed.origins=<comma-separated-origins>
        ```

    === "Example"
        ```bash
        -Drest.api.publisher.allowed.origins=https://myorg1.publisher.example.com \
        -Drest.api.devportal.allowed.origins=https://myorg1.devportal.example.com,https://myorg2.devportal.example.com \
        -Drest.api.gateway.allowed.origins=https://myorg1.gateway.example.com,https://myorg3.gateway.example.com \
        -Drest.api.service.catalog.allowed.origins=https://myorg1.service.catalog.example.com
        ```

   2. Start the server.

      * On Linux/Mac OS: `./api-manager.sh`
      * On Windows: `api-manager.bat`

**Option 2**: Specify the allowed origins during server startup

Start the API-M server by specifying the allowed origins for the REST APIs as system parameters.

   - Linux/Mac OS

    === "Format"
        ```bash
        ./api-manager.sh \
        -Drest.api.publisher.allowed.origins=<comma-separated-origins> \
        -Drest.api.devportal.allowed.origins=<comma-separated-origins> \
        -Drest.api.gateway.allowed.origins=<comma-separated-origins> \
        -Drest.api.service.catalog.allowed.origins=<comma-separated-origins>
        ```

    === "Example"
        ```bash
        ./api-manager.sh \
        -Drest.api.publisher.allowed.origins=https://myorg1.publisher.example.com \
        -Drest.api.devportal.allowed.origins=https://myorg1.devportal.example.com,https://myorg2.devportal.example.com \
        -Drest.api.gateway.allowed.origins=https://myorg1.gateway.example.com,https://myorg3.gateway.example.com \
        -Drest.api.service.catalog.allowed.origins=https://myorg1.service.catalog.example.com
        ```

   - Windows

    === "Format"
        ```bash
        api-manager.bat \
        -Drest.api.publisher.allowed.origins=<comma-separated-origins> \
        -Drest.api.devportal.allowed.origins=<comma-separated-origins> \
        -Drest.api.gateway.allowed.origins=<comma-separated-origins> \
        -Drest.api.service.catalog.allowed.origins=<comma-separated-origins>
        ```

    === "Example"
        ```bash
        api-manager.bat \
        -Drest.api.publisher.allowed.origins=https://myorg1.publisher.example.com \
        -Drest.api.devportal.allowed.origins=https://myorg1.devportal.example.com,https://myorg2.devportal.example.com \
        -Drest.api.gateway.allowed.origins=https://myorg1.gateway.example.com,https://myorg3.gateway.example.com \
        -Drest.api.service.catalog.allowed.origins=https://myorg1.service.catalog.example.com
        ```
