# Updating WSO2 API Manager

WSO2 introduces [WSO2 Updates](https://updates.docs.wso2.com/en/latest/) , which is a command-line utility that allows you to get the latest updates that are available for a particular product release. These updates include the latest bug fixes and security fixes that are released by WSO2 after a particular product version is released. Therefore, you do not need to wait and upgrade to the next product release to get these bug fixes.

##WSO2 Updates 2.0
The WSO2 updates 2.0 tool allows you to update your currently used product by fetching updates from the server. While you should manually merge the updated configuration files or use a tool like Puppet, you can store backups with the custom configurations in your system, in case you have to restore later.

For more information, see [Using WSO2 Updates 2.0](https://updates.docs.wso2.com/en/latest/updates/update-tool/)

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

!!! warning "Re-optimization requirement for profiled deployments"

    **Re-run profile optimization after applying updates**

    If you are using a distributed API Manager deployment with product profiles (Control Plane, Gateway, Traffic Manager, or Key Manager), you must re-run the profile optimization after applying WSO2 Updates 2.0. Updates apply fixes and changes across all profiles, so re-optimization ensures your profiled distribution remains correctly configured.

    To re-optimize a profile, run the profile setup script with the appropriate profile flag:

    === "Linux/Solaris/MacOS"
        ``` bash
        sh <PRODUCT_HOME>/bin/profileSetup.sh -Dprofile=<profile-name>
        ```

    === "Windows"
        ``` bash
        <PRODUCT_HOME>/bin/profileSetup.bat -Dprofile=<profile-name>
        ```

    Replace `<profile-name>` with the appropriate profile: `control-plane`, `gateway-worker`, `traffic-manager`, or `key-manager`.
