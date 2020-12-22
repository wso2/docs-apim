# Synchronizing Artifacts in a Gateway Cluster

In an API-M Gateway cluster, artifact synchronization is critical to maintain consistency among the nodes. WSO2 API-M provides three mechanisms for artifact synchronization.

1. [Shared file system (e.g., NFS)]({{base_path}}/install-and-setup/setup/distributed-deployment/synchronizing-artifacts-in-a-gateway-cluster/#artifact-synchronization-with-a-shared-file-system)
2. [Inbuilt artifact synchronizer]({{base_path}}/install-and-setup/setup/distributed-deployment/synchronizing-artifacts-in-a-gateway-cluster/#inbuilt-artifact-synchronization) 

## Artifact synchronization with a shared file system

To enable synchronization for runtime artifacts of two all-in-one WSO2 API-M instances, it is recommended to have a
shared file system. Configure a shared file system as the content synchronization mechanism. You can use a common shared file 
system such as Network File System (NFS) or any other shared file system that is available. 

You need to mount the following directories of the two nodes to the shared file system, in order to share all the APIs and throttling policies between all the nodes.

1. `<API-M_HOME>/repository/deployment/server/synapse-configs`
2. `<API-M_HOME>/repository/deployment/server/executionplans`

## Inbuilt artifact synchronization

#### Overview

Currently, in a multi-gateway environment, Synapse artifacts such as sequences, local entries, and endpoints are saved in the `<API-M_HOME>/repository/deployment/server/synapse-configs/default` directory as XMLs. These artifacts have to be synced between all the gateway nodes using an artifact synchronizing mechanism. 

When using NFS, you need to manage additional components that bring in changes to the current architecture. Therefore, an inbuilt artifact synchronization solution has been introduced. This inbuilt Artifact Synchronizer can be configured to store these Synapse artifacts to an extension point (configured persistent storage).

The behaviour of the inbuilt Artifact Synchronizer in different scenarios is described as follows.

#### Artifact synchronization when the API Gateway is running

[![artifact synchronizer architecture]({{base_path}}/assets/img/learn/artifact-synchronizer-architecture.png)]({{base_path}}/assets/img/learn/artifact-synchronizer-architecture.png)

1. In the event an API is published, edited, or removed, the Synapse artifact corresponding to the API will be stored/updated in the configured extension point.
2. An event will be sent to Traffic Manager (TM) using event notifiers with the API Name, UUID, and the Gateway label of the API.
3. In a distributed deployment, Gateways are subscribed to the Traffic Manager topics. The API Gateway will filter out the events by the Gateway label. It will also sort the APIs that have the Gateway label. 
4. It will fetch the artifacts associated with the API from the storage (Database or GitHub) and load it to the
 memory.

An extension point needs to be configured in the Publisher profile to store the Synapse artifacts in a persistent storage other than the default API-M database. When an API is published, edited, or removed, an event will be sent to the Traffic Manager using Event Notifiers with the API Name, UUID, and the Gateway label of the API.


#### Artifact synchronization at API Gateway startup

[![Gateway startup]({{base_path}}/assets/img/learn/gateway-startup.png)]({{base_path}}/assets/img/learn/gateway-startup.png)
  
At startup, the Gateway will look for the APIs with labels that it is subscribed to in the configured extension, and fetch the Synapse artifacts of those APIs. Those Synapse artifacts will get deployed in the Gateway.

Gateways are subscribed to the Traffic Manager. There is an extension in the Gateway to get the Synapse artifacts and deploy them in the memory. Gateways can subscribe to multiple labels.

### Configuring the inbuilt Artifact Synchronizer

Configure the Gateway and Publisher profiles as explained below to enable artifact synchronization and retrieval from configured extension points.

#### Publisher profile configurations

1. Stop the Publisher node if it is running.
2. Open the `<API-M_HOME>/repository/conf/deployment.toml` file  and update it as follows:

     ```
     [apim.sync_runtime_artifacts.publisher]
     artifact_saver = "DBSaver"
     publish_directly_to_gateway = "true"
     ```
    
    | **Configuration**                                    | **Description**                          |
    | -------------------------------------------------| ------------------------------------ |
    |apim.sync_runtime_artifacts.publisher            | The configuration element that all the artifacts will be saved to the storage via the extension point. By default, they will get stored in the database.|
    |artifact_saver|Specify the extension point. The default is `DBSaver` where the artifacts are saved in the database.|
    |publish_directly_to_gateway| If `publish_directly_to_gateway = true`, then the artifacts will be published to the Gateway directly. If `publish_directly_to_gateway = false`, then the Published API details will be notified to the Traffic Manager through events.|
       
  
   You can add the Gateways as environments. For more information, see 
   [Adding Gateways as Environments]({{base_path}}/learn/api-gateway/maintaining-separate-production-and-sandbox-gateways/).

#### Gateway profile configurations

1. Stop the Gateway node(s) if it is running.
2. Open the `<API-M_HOME>/repository/conf/deployment.toml` file and update it as follows:
   
     ```
     [apim.sync_runtime_artifacts.gateway]
     gateway_labels =["Production and Sandbox","Label1","Label2"]
     artifact_retriever = "DBRetriever"
     deployment_retry_duration = 15000
     data_retrieval_mode = "sync"
     event_waiting_time = 5000
     ```
 
    |**Configuration**| **Description**|
    |--------------------------------------------------|------------------------------------------------|
    |gateway_labels|Specify the labels that the Gateway is going to subscribe to. Only the APIs with these labels will be pulled from the extension point and deployed.|
    |artifact_retriever|  Specify the extension point. The default is `DBRetriever` where the artifacts are pulled from the database.|
    |deployment_retry_duration| Specify the retry duration in milliseconds to deploy artifacts if there is a failure in pulling them from the  extension through `deployment_retry_duration`. The retry duration specified here will be exponentially increased by a progression factor of 2. Thereby, the duration will be progressed as 15s, 30s, 60s, 120s and so on if there are continuous failures. The retry duration is bounded by 1 hr.<html><div class="admonition note"><p class="admonition-title">Note</p><p> This`deployment_retry_duration` is  applicable only in Asynchronous deployment (`data_retrieval_mode ="async"`) where the server will try to deploy the artifacts after it is started. </p></div></html>|
    |data_retrieval_mode| You can use the `data_retrieval_mode = “sync” ` element to specify the mode of deployment of artifacts from the extension point. By default, Gateway Startup will be in a Synchronous manner where the server will wait until all the APIs have been deployed. If there are any failures in the deployment process, it will be triggered again for "n" times where "n" is the maximum retry count. If the APIs are not deployed even in "n" retries, then the server will start with undeployed API artifacts. <br/>If you need to switch the startup mode to an Asynchronous mode, then you need to specify it in the configuration as `data_retrieval_mode = "async"`. In an Asynchronous mode, the server will be up and independent of the deployment of the Synapse artifacts in the Gateway.|
     |event_waiting_time| You can use this  element to specify an event waiting time in milliseconds (ms) for Gateway. The Gateway will wait for the time specified in this configuration after receiving an event. This ensures that artifact retrieval is not ahead of artifact updates in the Publisher; thereby, avoiding inconsistencies. The default waiting time will be 1 ms.|
    
 3. If the Gateway profile is running with a port offset, add the following configuration.
     
     ```
     [apim.event_hub]
     enable = true
     service_url = "https://traffic-manager:9443"  
     ```

     - If you are not running the Gateway as an all-in-one pack and it runs with a port offset, or when it's in a different
  node, you have to define the `event_hub service_url` element as well.

#### Database configurations

By default, the data related to the Synapse artifacts will be stored in the `WSO2AM_DB`. However, this is configurable. 

Follow the instructions below to configure a database to store the Synapse artifacts.

!!! note
    Only the data related to the Synapse artifacts will be saved in this database.

Add the `[database.sync_runtime_artifacts_db]` configuration element and thereafter, update the URL pointing to your database, the username, and password required to access the database and the driver details as shown below.

   | **Element**                       | **Description**                                                 |
    |-------------------------------|-------------------------------------------------------------|
    | **type**                      | The database type used.                                      |
    | **url**                       | The URL of the database. The default port for MySQL is 3306. |
    | **username** and **password** | The name and password of the database user.                  |
    | **driverClassName**           | The class name of the database driver.                       |

The following sample configuration is for MySQL. If you are using any other database, update the type and URL accordingly.

``` tab="Format"
[database.sync_runtime_artifacts_db]
type = "mysql"
url = "jdbc:mysql://localhost:3306/<DATABASE_NAME>"
username = "<USER_NAME>"
password = "<PASSWORD>"
```

``` tab="Example"
[database.sync_runtime_artifacts_db]
type = "mysql"
url = "jdbc:mysql://localhost:3306/WSO2AS_DB"
username = "wso2carbon"
password = "wso2carbon"
```

!!! info
    For more information on the other parameters that can be defined in the 
    `<API-M_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC connection pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).

Add the tables of the `AM_GW_API_ARTIFACTS` and `AM_GW_PUBLISHED_API_DETAILS` to this new database that you are specifying. 
The scripts to create these tables are in the `<API-M_HOME>/dbscripts/apimgt/` directory.
