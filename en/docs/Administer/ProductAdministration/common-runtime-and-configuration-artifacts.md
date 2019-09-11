# Common Runtime and Configuration Artifacts

The following are the artifacts used commonly in a WSO2 API Manager and API Manager Analytics deployment.

**Persistent Runtime Artifacts -** directories in API Manager which includes deployable files  which are valid from a specified date and time at runtime.

**Persistent Configuration Artifacts** - directories in API Manager where the configuration files are included which are used for configurations.

!!! info
Persistent runtime artifacts could be updated at the runtime, and are expected to be available across instance restarts, VM re-creation or container re-spawning. Persistent file storage systems should be used to ensure this.

Ex.: In a Kubernetes based container environment, its possible to use Persistent Volumes to persist these artifacts.


-   [API Manager](#CommonRuntimeandConfigurationArtifacts-APIManager)
    -   [Persistent Runtime Artifacts](#CommonRuntimeandConfigurationArtifacts-PersistentRuntimeArtifacts)
    -   [Persistent Configuration Artifacts](#CommonRuntimeandConfigurationArtifacts-PersistentConfigurationArtifacts)
-   [APIM Analytics](#CommonRuntimeandConfigurationArtifacts-APIMAnalytics)
    -   [Persistent Runtime Artifacts](#CommonRuntimeandConfigurationArtifacts-PersistentRuntimeArtifacts.1)
    -   [Persistent Configuration Artifacts](#CommonRuntimeandConfigurationArtifacts-PersistentConfigurationArtifacts.1)

### API Manager

##### Persistent Runtime Artifacts

-`<API-M_HOME>/repository/deployment/server` - Contains webapps that are related to customizing WSO2 API Manager during a deployment. Required for delpoying a super tenant

-`<API-M_HOME>/repository/tenants` - This is only used when the deployment involves multi-tenancy. For more information, see [Configuring Multiple Tenants](https://docs.wso2.com/display/AM210/Configuring+Multiple+Tenants)

-`<API-M_HOME>/solr` - Contains files for Apache solr indexing. For additional information, see [Add Apache Solr-Based Indexing](https://docs.wso2.com/display/AM210/Add+Apache+Solr-Based+Indexing)

-`<API-M_HOME>/repository/database` - H2 database (For solr indexing)

!!! info
Shared Artifacts

The following artifacts can be shared among API Manager nodes

-`<API-M_HOME>/repository/deployment/server`
-`<API-M_HOME>/repository/tenants`


##### Persistent Configuration Artifacts

-`<API-M_HOME>/repository/resources` - This folder/artifact contains such as keystores, templates, scripts, synapse configurations and custom sequences etc.

-`<API-M_HOME>/repository/conf` - This folder contains the configuration files related to servers, datasources, registry, user management, etc.

-`<API-M_HOME>/bin` - Contains files for JVM changes, profile changes, etc.

### APIM Analytics

##### Persistent Runtime Artifacts

-`<API-M_ANALYTICS_HOME>/repository/deployment/server` - Contains webapps, execution plans, event receivers, etc that are related to customizing WSO2 APIM Analytics during a deployment. Required for deploying a super tenant.

-`<API-M_ANALYTICS_HOME>/repository/data` - Contains the indexing files

-`<API-M_ANALYTICS_HOME>/repository/conf/analytics/` - My node id and shard allocation related data are stored in this directory.

!!! info
Shared Artifacts

The following artifacts can be shared among API Manager nodes

-`<API-M_ANALYTICS_HOME>/repository/deployment/server`


##### Persistent Configuration Artifacts

-`<API-M_ANALYTICS_HOME>/repository/resources` - Resources such as key stores, templates, etc.

-`<API-M_ANALYTICS_HOME>/repository/conf` - This folder contains the configuration files related to servers, datasources, registry, user management, etc.

-`<API-M_ANALYTICS_HOME>/bin` - Contains files for JVM changes, profile changes, etc.


