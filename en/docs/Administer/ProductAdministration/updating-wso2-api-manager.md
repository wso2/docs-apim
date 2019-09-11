# Updating WSO2 API Manager

WSO2 introduces the [WSO2 Update Manager (WUM)](http://wso2.com/update/) , which is a command-line utility that allows you to get the latest updates that are available for a particular product release. These updates include the latest bug fixes and security fixes that are released by WSO2 after a particular product version is released. Therefore, you do not need to wait and upgrade to the next product release to get these bug fixes. For information on updating WSO2 API Manager with the latest available patches (issued by WSO2) using the WUM tool, see Getting Started with WUM in the WSO2 Administration Guide.

!!! note
**Persisting Index data**

The indexing related information of WSO2 API Manager is stored in the `<API-M_HOME>/solr/data` directory. Once the data is indexed, it is stored in the index directory. Refer [Add Apache Solr-Based Indexing](https://docs.wso2.com/display/AM210/Add+Apache+Solr-Based+Indexing) for more information.

!!! tip
Before you discard the old API Manager instance,

You must take a backup of the `<API-M_HOME>/repository/data` directory and copy it to the API Manager binary pack in the `<API-M_HOME>/repository/data` directory that is updated with the WUM updates.


**Persisting WSO2CarbonDB**

To avoid conflicts that can be occurred in the update process, it is recommended to persist the local H2 databases as well.

!!! tip
Before you discard the old API Manager instance,

Take a backup of `<API-M_HOME>/repository/database/WSO2CARBON_DB.h2.db` and replace it to the API Manager binary pack in the `<API-M_HOME>/repository/database` directory that is updated with the WUM updates.

If you are using the existing local H2 database for WSO2MetricsDB as well,

Take a backup of `<API-M_HOME>/repository/database/WSO2METRICS_DB.h2.db` and replace it to the API Manager binary pack in the `<API-M_HOME>/repository/database` directory that is updated with the WUM updates.


For more information on run time and configuration artefact directories of API Manager refer [Common Runtime and Configuration Artifacts](https://docs.wso2.com/display/AM260/Common+Runtime+and+Configuration+Artifacts) .


Refer [Updating WSO2 API Manager Analytics](https://docs.wso2.com/display/AM260/Updating+WSO2+API+Manager+Analytics) in order to update WSO2 API Manager Analytics binary distribution .
