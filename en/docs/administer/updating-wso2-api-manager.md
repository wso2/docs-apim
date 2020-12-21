# Updating WSO2 API Manager

WSO2 introduces the [WSO2 Update Manager (WUM)](http://wso2.com/update/) , which is a command-line utility that allows you to get the latest updates that are available for a particular product release. These updates include the latest bug fixes and security fixes that are released by WSO2 after a particular product version is released. Therefore, you do not need to wait and upgrade to the next product release to get these bug fixes.

##WSO2 in-place updates
The WSO2 in-place updates tool allows you to update your currently used product by fetching updates from the server and merging all configurations and files. The tool also gives backup and restore capability.

For more information, see [Using WSO2 In-Place Updates](https://docs.wso2.com/display/updates100/Using+WSO2+In-Place+Updates)


##WSO2 update manager (WUM)
You should manually merge the updated configuration files or use a tool like Puppet. You should store backups with the custom configurations in your system, in case you have to restore later.

For more information, see [Using WSO2 Update Manager](https://docs.wso2.com/display/updates100/Using+WSO2+Update+Manager)

!!! warning

    **Persisting Index data**

    The indexing related information of WSO2 API Manager is stored in the `<API-M_HOME>/solr/data` directory. Once the data is indexed, it is stored in the index directory. Refer [Add New Search Keyword]({{base_path}}/learn/design-api/api-documentation/search-documentation/add-new-search-keyword) for more information.
    
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
        
    
    For more information on run time and configuration artifact directories of API Manager refer [Common Runtime and Configuration Artifacts]({{base_path}}/administer/product-configurations/common-runtime-and-configuration-artifacts/) .
