# Updating WSO2 API Manager

WSO2 introduces [WSO2 Updates](https://updates.docs.wso2.com/en/latest/) , which is a command-line utility that allows you to get the latest updates that are available for a particular product release. These updates include the latest bug fixes and security fixes that are released by WSO2 after a particular product version is released. Therefore, you do not need to wait and upgrade to the next product release to get these bug fixes.

##WSO2 in-place updates
The WSO2 in-place updates tool allows you to update your currently used product by fetching updates from the server and merging all configurations and files. The tool also gives backup and restore capability.

For more information, see [Using WSO2 In-Place Updates](https://wso2docs.atlassian.net/wiki/spaces/updates100/pages/37388299/Using+WSO2+In-Place+Updates)

!!! note
    WSO2 recommends all users to shift to the new WSO2 Updates 2.0 model to alleviate from future updates challenges. For more information, see [WUM/In-place updates decommission plan](https://updates.docs.wso2.com/en/latest/updates/wum-decommission/).

##WSO2 Updates 2.0
You should manually merge the updated configuration files or use a tool like Puppet. You should store backups with the custom configurations in your system, in case you have to restore later.

For more information, see [Using WSO2 Updates 2.0](https://updates.docs.wso2.com/en/latest/updates/update-tool/)

!!! warning "Re-optimization requirement for distributed deployments"

    **Important for profiled deployments (Control Plane, Gateway, Traffic Manager)**

    When you apply WSO2 Updates 2.0 (U2) to a distributed API Manager deployment that uses product profiles, you **must** re-run the profile optimization after applying the updates. This is because U2 updates apply fixes and updates across all profiles, which can introduce files that are not relevant to the active profile.

    Failure to re-optimize profiles after applying updates may cause server startup issues or unexpected behavior.

    To re-optimize a profile after applying updates, run the profile optimization script again:

    ```bash
    sh <API-M_HOME>/bin/profileSetup.sh -Dprofile=<preferred-profile>
    ```

    For more information on profile optimization, see [Running the API-M Profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles/)

!!! warning

    **Persisting Index data**

    The indexing related information of WSO2 API Manager is stored in the `<API-M_HOME>/solr/data` directory. Once the data is indexed, it is stored in the index directory.
    
    !!! tip
        Before you discard the old API Manager instance,
        
        You must take a backup of the `<API-M_HOME>/solr/data` directory and copy it to the API Manager binary pack in the `<API-M_HOME>/solr/data` directory that is updated.
    
    **Persisting WSO2CarbonDB**
    
    To avoid conflicts that can be occurred in the update process, it is recommended to persist the local H2 databases as well.
    
    !!! tip
        Before you discard the old API Manager instance,
        
        Take a backup of `<API-M_HOME>/repository/database/WSO2CARBON_DB.h2.db` and replace it to the API Manager binary pack in the `<API-M_HOME>/repository/database` directory that is updated.
        
        If you are using the existing local H2 database for WSO2MetricsDB as well,
        
        Take a backup of `<API-M_HOME>/repository/database/WSO2METRICS_DB.h2.db` and replace it to the API Manager binary pack in the `<API-M_HOME>/repository/database` directory that is updated.
        
    
    For more information on run time and configuration artifact directories of API Manager refer [Common Runtime and Configuration Artifacts]({{base_path}}/administer/product-configurations/common-runtime-and-configuration-artifacts/) .
