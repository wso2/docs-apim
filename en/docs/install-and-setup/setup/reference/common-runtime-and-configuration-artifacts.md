# Common Runtime and Configuration Artifacts

The following are the artifacts used commonly in a WSO2 API Manager deployment.

!!! info
        Persistent runtime artifacts could be updated at the runtime, and are expected to be available across instance restarts, VM re-creation or container re-spawning. Persistent file storage systems should be used to ensure this.

    Example: In a Kubernetes based container environment, its possible to use Persistent Volumes to persist these artifacts.

### Persistent Runtime Artifacts

These are directories in API Manager that includes deployable files, which are valid from a specified date and time at runtime.

-   `<API-M_HOME>/repository/deployment/server` -  Contains webapps that are related to customizing WSO2 API Manager during deployment. Required for deploying a super tenant. Also contains Synapse configurations and custom sequences, throttling execution plans.

-   `<API-M_HOME>/repository/tenants` - This is only used when the deployment involves multi-tenancy. For more information, see [Configuring Multiple Tenants]({{base_path}}/administer/multitenancy/introduction-to-multitenancy).

-   `<API-M_HOME>/solr` - Contains files for Apache solr indexing. For additional information, see [Add Apache Solr-Based Indexing]({{base_path}}/design/api-documentation/search-documentation/add-new-search-keyword).

-   `<API-M_HOME>/repository/database` - H2 database (For solr indexing)

!!! info
    Shared Artifacts

    The following artifacts can be shared among API Manager nodes

    1. `<API-M_HOME>/repository/deployment/server/synapse-configs`
    2. `<API-M_HOME>/repository/deployment/server/executionplans`
    3. `<API-M_HOME>/repository/deployment/server/userstores` (Optional)
    4. `<API-M_HOME>/repository/tenants`


### Persistent Configuration Artifacts

These are directories in API Manager where the configuration files are stored.

-   `<API-M_HOME>/repository/resources` - This folder/artifact contains keystores, templates, scripts, etc.

-   `<API-M_HOME>/repository/conf` - This folder contains the configuration files related to servers, datasources, registry, user management, etc.

-   `<API-M_HOME>/bin` - Contains files for JVM changes, profile changes, etc.
