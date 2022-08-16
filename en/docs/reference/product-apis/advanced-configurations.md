# Advanced Configurations

This section explains how to configure scope to role mappings for API Manager REST APIs.

##Changing Default Roles

Certain resources of the REST API are protected using OAuth 2.0 scopes. Each tenant has a `tenant-conf.json` configuration file with a section for RESTAPIScopes that contain a mapping between all the scopes that are available with API Manager REST APIs, and a set of roles. 

When a user requires access to a resource protected by an OAuth 2.0 scope, an access token associated with that particular scope needs to be provided as the Bearer token in the Authorization header. In order to retrieve the token, the user has to invoke the Token API and request for that scope. For more information, see the Authorization section in REST API documents. When issuing such an access token, the Token API validates the eligibility of the user for that particular scope using the RESTAPIScopes configuration. An access token with the particular scope is issued for the user only if that user has been assigned one or more of the roles specified in the RESTAPIScopes configuration for that scope.

You can modify the default roles defined in RESTAPIScopes configuration according to your requirements via the Admin Portal UI. For more information, refer [Managing Permissions]({{base_path}}/administer/managing-users-and-roles/managing-permissions/#adding-role-based-permissions). 

!!! note
    Restart the server for the RESTAPIScopes configuration changes to take effect.

##Configuring Allowed Origins

By default, each of the Product REST APIs (except Admin v2 REST API) allows requests from all origins. If only a specific set of origins should be allowed to access a Product REST API, the allowed origins for that particular REST API should be configured as a system parameter. The defined system parameters are as follows.

-   For Publisher REST APIs : rest.api.publisher.allowed.origins
-   For Developer Portal REST APIs : rest.api.devportal.allowed.origins
-   For Gateway REST APIs : rest.api.gateway.allowed.origins
-   For Service Catalog REST APIs : rest.api.service.catalog.allowed.origins

The allowed origins for a particular REST API can be configured as a system parameter as follows.

!!! Note

    - The origin will have the following syntax.

    ```bash tab="Format"
    <scheme>://<hostname>[ :<port> ]
    ```

    ```bash tab="Example"
    https://myorg1.publisher.example.com
    ```

### Method 1- Specify the allowed origins in the deployment.toml file under [system.parameter]

 1.  Open the `<API-M_HOME>/repository/deployment.toml` file and specify the allowed origins for the REST APIs under `[system.parameter]`.

    ```toml tab="Format"
    [system.parameter]
    'rest.api.publisher.allowed.origins' = "<comma-separated-origins>"
    'rest.api.devportal.allowed.origins' = "<comma-separated-origins>"
    'rest.api.gateway.allowed.origins' = "<comma-separated-origins>"
    'rest.api.service.catalog.allowed.origins' = "<comma-separated-origins>"
    ```

    ```toml tab="Example"
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

    ```bash tab="Format"
    -Drest.api.publisher.allowed.origins=<comma-separated-origins> \
    -Drest.api.devportal.allowed.origins=<comma-separated-origins> \
    -Drest.api.gateway.allowed.origins=<comma-separated-origins> \
    -Drest.api.service.catalog.allowed.origins=<comma-separated-origins>
    ```

    ```bash tab="Example"
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

```bash tab="Format"
./api-manager.sh \
-Drest.api.publisher.allowed.origins=<comma-separated-origins> \
-Drest.api.devportal.allowed.origins=<comma-separated-origins> \
-Drest.api.gateway.allowed.origins=<comma-separated-origins> \
-Drest.api.service.catalog.allowed.origins=<comma-separated-origins>
```

```bash tab="Example"
./api-manager.sh \
-Drest.api.publisher.allowed.origins=https://myorg1.publisher.example.com \
-Drest.api.devportal.allowed.origins=https://myorg1.devportal.example.com,https://myorg2.devportal.example.com \
-Drest.api.gateway.allowed.origins=https://myorg1.gateway.example.com,https://myorg3.gateway.example.com \
-Drest.api.service.catalog.allowed.origins=https://myorg1.service.catalog.example.com
```

   - Windows

```bash tab="Format"
api-manager.bat \
-Drest.api.publisher.allowed.origins=<comma-separated-origins> \
-Drest.api.devportal.allowed.origins=<comma-separated-origins> \
-Drest.api.gateway.allowed.origins=<comma-separated-origins> \
-Drest.api.service.catalog.allowed.origins=<comma-separated-origins>
```

```bash tab="Example"
api-manager.bat \
-Drest.api.publisher.allowed.origins=https://myorg1.publisher.example.com \
-Drest.api.devportal.allowed.origins=https://myorg1.devportal.example.com,https://myorg2.devportal.example.com \
-Drest.api.gateway.allowed.origins=https://myorg1.gateway.example.com,https://myorg3.gateway.example.com \
-Drest.api.service.catalog.allowed.origins=https://myorg1.service.catalog.example.com
```
