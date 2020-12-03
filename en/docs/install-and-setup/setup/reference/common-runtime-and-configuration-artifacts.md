# Common Runtime and Configuration Artifacts

The following are the artifacts used commonly in a WSO2 API Manager and API Manager Analytics deployment.

**Persistent Runtime Artifacts -** directories in API Manager which includes deployable files which are valid from a specified date and time at runtime.

**Persistent Configuration Artifacts** - directories in API Manager where the configuration files are included which are used for configurations.

!!! info
        Persistent runtime artifacts could be updated at the runtime, and are expected to be available across instance restarts, VM re-creation or container re-spawning. Persistent file storage systems should be used to ensure this.

    E.g.,: In a Kubernetes based container environment, its possible to use Persistent Volumes to persist these artifacts.


1. [API Manager](##api-manager)
    1. [Persistent Runtime Artifacts](#persistent-runtime-artifacts)
    2. [Persistent Configuration Artifacts](#persistent-configuration-artifacts)
2. [APIM Analytics](#apim-analytics)
    1. [Persistent Runtime Artifacts](#persistent-runtime-artifacts_1)
    2. [Persistent Configuration Artifacts](#persistent-configuration-artifacts_1)

## API Manager

### Persistent Runtime Artifacts

1. `<API-M_HOME>/repository/deployment/server` - Contains webapps that are related to customizing WSO2 API Manager during deployment. Required for deploying a super tenant

2. `<API-M_HOME>/repository/tenants` - This is only used when the deployment involves multi-tenancy. For more information, see [Configuring Multiple Tenants](https://docs.wso2.com/display/AM210/Configuring+Multiple+Tenants)

3. `<API-M_HOME>/solr` - Contains files for Apache solr indexing. For additional information, see [Add Apache Solr-Based Indexing](https://docs.wso2.com/display/AM210/Add+Apache+Solr-Based+Indexing)

4.  `<API-M_HOME>/repository/database` - H2 database (For solr indexing)

!!! info
    Shared Artifacts

    The following artifacts can be shared among API Manager nodes

    1. `<API-M_HOME>/repository/deployment/server/synapse-configs`
    2. `<API-M_HOME>/repository/deployment/server/executionplans`
    3. `<API-M_HOME>/repository/tenants`


### Persistent Configuration Artifacts

1. `<API-M_HOME>/repository/resources` - This folder/artifact contains such as keystores, templates, scripts, Synapse configurations and custom sequences etc.

2. `<API-M_HOME>/repository/conf` - This folder contains the configuration files related to servers, datasources, registry, user management, etc.

3. `<API-M_HOME>/bin` - Contains files for JVM changes, profile changes, etc.

## APIM Analytics

### Persistent Runtime Artifacts

1. `<API-M_ANALYTICS_HOME>/repository/deployment/server` - Contains webapps, execution plans, event receivers, etc that are related to customizing WSO2 APIM Analytics during a deployment. Required for deploying a super tenant. It is sufficient to only share the Synapse configurations and execution plans between the nodes.

2. `<API-M_ANALYTICS_HOME>/repository/data` - Contains the indexing files

3. `<API-M_ANALYTICS_HOME>/repository/conf/analytics/` - My node id and shard allocation related data are stored in this directory.

!!! info
        Shared Artifacts

    The following artifact can be shared among API Manager nodes

    1. `<API-M_HOME>/repository/deployment/server/synapse-configs`
    2. `<API-M_HOME>/repository/deployment/server/executionplans`


### Persistent Configuration Artifacts

1. `<API-M_ANALYTICS_HOME>/repository/resources` - Resources such as key stores, templates, etc.

2. `<API-M_ANALYTICS_HOME>/repository/conf` - This folder contains the configuration files related to servers, datasources, registry, user management, etc.

3. `<API-M_ANALYTICS_HOME>/bin` - Contains files for JVM changes, profile changes, etc.