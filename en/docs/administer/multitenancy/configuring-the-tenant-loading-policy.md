# Configuring the Tenant Loading Policy

In WSO2 products based on Carbon 4.4.0 or later versions, you have the option of setting the required tenant loading policy by enabling either **Lazy Loading** or **Eager Loading** of tenants.

!!! note
    By default, **Lazy Loading** is enabled for tenants in all WSO2 products.


First, read the following descriptions to understand how Lazy loading and Eager loading work:

-   **Lazy Loading:** Lazy loading of tenants ensures that all tenants are not loaded at the time the server starts. Instead, the tenants are loaded on demand (upon a request sent to a particular tenant). When a tenant receives a request, the particular tenant and all tenant-specific artifacts, except **web applications** and **axis2 services** , get loaded.
    Tenants (including the tenant-specific artifacts) are **unloaded** from memory if the tenant remains idle for a specified amount of time. You can configure the allowed tenant idle time. See [Configuring Lazy Loading](#configuring-lazy-loading) for instructions.
-   **Eager Loading:** Unlike lazy loading, eager loading ensures that tenants will be initialized when the server starts (without any delays). You can switch to eager loading if required. Note that you also have the option of enabling eager loading for specific tenants so that only the required tenants will be loaded when the server starts. 

    When eager loading is enabled, tenants (and the tenant-specific artifacts) are expected to remain in memory without unloading until the server shuts down. 

Now, see the instructions given below to configure the required tenant loading policy for your system.

-   [Configuring Lazy Loading](#configuring-lazy-loading)
    -   [Configuring the tenant unloading time (for Lazy Loading)](#configuring-the-tenant-unloading-time-for-lazy-loading)
    -   [Improved artifacts synchronization for Lazy loading](#improved-artifacts-synchronization-for-lazy-loading)
-   [Configuring Eager Loading](#configuring-eager-loading)

### Configuring Lazy Loading

As explained above, Lazy Loading (for tenants) is enabled as the loading policy in WSO2 products, by default. 

#### Configuring the tenant unloading time (for Lazy Loading)

If you have Lazy loading enabled, you can configure the allowed tenant idle time. For example, if you set the idle time to 30 minutes, tenants that are idle for more than 30 minutes will be unloaded automatically in your system. You can configure this value using two methods.

-   Specify the tenant idle time when you configure the tenant loading policy:
    1.  Open the `deployment.toml` file.

    2.  Set the tenant idle time by adding the configuration shown below.

        ``` java
        [tenant_mgt]
        tenant_idle_timeout='30'
        ```

-   Alternatively, you can specify the tenant idle time when you start the server:

    1.  Open the product startup script (. `/api-manager.sh` file for Linux and `api-manager.bat` for Windows), which is stored in the `<PRODUCT_HOME>/bin` directory.
    2.  Add the following system property.

        ``` java
        $JAVA_OPTS \ 
             -Dtenant.idle.time=<value_in_minutes>. \
        ```

    3.  Restart the server.
    
#### Improved artifacts synchronization for Lazy loading

Starting with API Manager version 3.2.0, an in-memory artifacts synchronization mechanism has been introduced, replacing the file-based artifacts management used in earlier versions. This new approach leverages a database to manage artifacts more efficiently.

Following are the key changes introduced by the above mechanism : 

1. **Artefact Storage**
        
    Artifacts are now stored in memory and synchronized via a database, moving away from the file-based system.</br>

2. **Dynamic Tenant Unloading**
     
    When a tenant is unloaded, its API artifacts are also removed from memory. As a result, if a request is received during the tenant's unloading process, the initial request may fail until the tenant is fully loaded. Once loaded, the gateway can serve the APIs for that tenant seamlessly. 
    </br></br>Recommended solution for this is to address this limitation and ensure smooth API requests during tenant unloading or loading, you should enable on-demand loading. Add the following configuration to your deployment.toml file:
        
        [apim.sync_runtime_artifacts.gateway]
        gateway_labels = ["Default"]
        enable_on_demand_loading = true
    
    For example, in a multi-tenancy scenario with lazy loading enabled, a user attempting to invoke a tenant's API for the first time after a server restart might encounter a 404 error. This occurs because the corresponding tenant data has not yet been loaded.
    
    When the mentioned configuration is enabled, the system synchronously verifies whether the API is deployed (i.e., the data is loaded). If the data is not loaded, it ensures the loading process is completed. As a result, subsequent requests will not return a 404 error due to resource unavailability.

    By enabling on-demand loading, the system dynamically loads tenant-specific artifacts only when required, reducing the likelihood of request failures.


### Configuring Eager Loading

Follow the instructions given below to change the tenant loading policy to eager loading.

!!! note 
    **Before you enable eager loading** , note the following:

    -   The server startup time may increase depending on the number of tenants and artifacts you have.

    -   The server's memory footprint will increase depending on the number of tenants and artifacts that are loaded.


1.  Open the `deployment.toml` file from the `<PRODUCT_HOME>/repository/conf/` directory.

2.  Add the following configuration

    ``` java
    [tenant_mgt]
    eager_loading_tenants="*,!foo.com ,!bar.com"
    ```

3.  You can then list the specific tenant domains to which eager loading should apply.
    -   If the setting should apply to all tenants, add `"*"` .
    -   If the setting should apply to all tenants, except [foo.com](http://foo.com/) and [bar.com](http://bar.com/) , add `" *,!foo.com ,!bar.com"`.
    -   If the setting should apply only to [foo.com](http://foo.com/) and [bar.com](http://bar.com/) , add `"foo.com,bar.com"` .



