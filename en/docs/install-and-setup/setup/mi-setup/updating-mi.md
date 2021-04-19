# Updating WSO2 Micro Integrator

WSO2 introduces the [WSO2 Update Manager (WUM)](http://wso2.com/update/) , which is a command-line utility that allows you to get the latest updates that are available for a particular product release. These updates include the latest bug fixes and security fixes that are released by WSO2 after a particular product version is released. Therefore, you do not need to wait and upgrade to the next product release to get these bug fixes.

##WSO2 in-place updates
The WSO2 in-place updates tool allows you to update your currently used product by fetching updates from the server and merging all configurations and files. The tool also gives backup and restore capability.

For more information, see [Using WSO2 In-Place Updates](https://docs.wso2.com/display/updates100/Using+WSO2+In-Place+Updates)


##WSO2 update manager (WUM)
You should manually merge the updated configuration files or use a tool like Puppet. You should store backups with the custom configurations in your system, in case you have to restore later.

For more information, see [Using WSO2 Update Manager](https://docs.wso2.com/display/updates100/Using+WSO2+Update+Manager)