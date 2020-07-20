#Publish an API with Artifact Synchronization

Currently, in a Multi Gateway setup, synapse artifacts such as sequences, local entries, endpoints are saved in
` <APIM_HOME>/repository/deployment/server/synapse-configs/default` directory as XMLs and have to be synced between all the gateway nodes using NFS or rsync. 
When using NFS we need to manage additional components that result in a considerable amount of changes in the current architecture.

Thus, a solution with an extension point which can be configurable to store these synapse artifacts is introduced.


##API Publish/ Update / Remove when the API Gateway is running

  [![]({{base_path}}/assets/img/learn/artifact-synchronizer-architecture.png)]({{base_path}}/assets/img/learn/artifact-synchronizer-architecture.png)

1. When an API gets Published, Edited, or removed, the synapse artifacts corresponding to that API will be Stored or
 updated  in the extension point. 
2. Then an event will be sent to Traffic Manager(TM) using Event Notifiers with API Name, UUID, and the gateway label
 for the API.
3. Gateways are subscribed to the TM. Gateway will filter out the events by the Gateway label and APIs that have the
 gateway's label will be sorted. 
4. Then it will fetch the artifacts associated with the API from the storage (Database or Github) and load it to the
 memory.


There will be an extension in the publisher profile to store the synapse artifacts in a persistence storage. The default implementation uses the API Manager Database itself. Once the API is Published, Edited, or removed, an event will be sent to Traffic Manager using Event Notifiers with API Name, UUID, and the gateway label for the API. 


##API Gateway at the startup


  [![]({{base_path}}/assets/img/learn/gateway-startup.png)]({{base_path}}/assets/img/learn/gateway-startup.png)
  
At startup, the gateway will look on the APIs with labels which it is subscribed to, in the extension, and fetch the synapse artifacts of those APIs. Those synapse artifacts will get deployed in the gateway.

Gateways are subscribed to the traffic manager. There is an extension in the gateway to get the synapse artifacts and deploy them in the memory. Gateways can subscribe to multiple labels.

##Configuration Related to Artifact Synchronizer

You need to configure Gateway and Publisher node as given below to save artifacts and retrieve artifacts through
corresponding extensions

###Publisher Profile 

Update `<API-M_HOME>/repository/conf/deployment.toml` file as follows, and change the default values according to your
 need. 

```
[apim.sync_runtime_artifacts.publisher]
artifact_saver = "DBSaver"
publish_directly_to_gateway = "true"
```

 - Through artifact_saver we can specify the extension point. The default is `DBSaver` where the artifacts are saved in
 the database.
 - If `publish_directly_to_gateway = true` then the artifacts will be published to the gateway directly. If
 `publish_directly_to_gateway = false` then the published API details will be notified to TM through events.
 - If we have **apim.sync_runtime_artifacts.publisher** configuration element then all the artifacts will be saved to
  the storage via the extension point. In default they will get stored in Database.
  
  We can add the gateways as environments. For more information see 
   [Adding gateways as Environments]({{base_path}}/learn/api-gateway/maintaining-separate-production-and-sandbox-gateways/).

###Gateway Profile Configuration

Update `<API-M_HOME>/repository/conf/deployment.toml` file as follows, and change the default values according to your
 need. 

```
[apim.sync_runtime_artifacts.gateway]
gateway_labels =["Production and Sandbox","Label1","Label2"]
artifact_retriever = "DBRetriever"
deployment_retry_duartion = 15000
data_retrieval_mode = "sync"
save_artifacts_locally = false
```

 - Through artifact_retriever we can specify the extension point. The default is `DBRetriever` where the artifacts are
  pulled from the database.
  
 - In gateway_labels we can specify the labels which the gateway is going to subscribe to. Only the APIs with these
  labels will be pulled from the extension point and deployed.
  
 - If we add the config `save_artifacts_locally = true` or remove `save_artifacts_locally` config  then synapse
  artifacts will be stored in the file system. (Saved in
   `<APIM_HOME>/repository/deployment/server/synapse-configs/default/`) . When `save_artifacts_locally = false`  
   then the artifacts from extension point will not be stored in the file system.
   
 - Through `data_retrieval_mode = “sync” ` we can specify the mode of deployment of artifacts from the extension point
 . By default gateway Startup will be in a Synchronous manner. Here the server will wait until all the APIs have been
  deployed. If there is any failure in the deployment, it will again be triggered for n times where n is the maximum
   retry count. If the APIs are not deployed even in n retries then the server will start with un deployed API artifacts.
   If the user wants to switch the startup mode to an Asynchronous mode then he needs to specify it in the configs as
  `data_retrieval_mode = "async"`. Here the server will be up, independent of the deployment of synapse artifacts in
   gateway.
   
 - We can specify the retry duration in milliseconds to deploy artifacts, if there is a failure in pulling them from the
  extension through `deployment_retry_duartion`. The retry duration specified here will be exponentially increased by a 
  progression factor of 2. That means the duration will be progressed as 15s, 30s, 60s, 120s……. if there are continuous
  failures. And retry duration is bounded with 1 hr.
  
  <html><div class="admonition note">
  <p class="admonition-title">Note</p>
  <p> This `deployment_retry_duartion` is  applicable only in Asynchronous deployment
  ( `data_retrieval_mode = "async"` ) 
   where the server will try to deploy the artifacts after it is started. </p>
  </div>
  </html>
   
```
[apim.event_hub] 
enable = true
service_url = "https://traffic-manager:9443"
```

 - If you are not running gateway as an all in one pack and it runs with a port offset, or when it's in a different
  node, we have to specify event_hub service_url as well .

###Database Configurations

By default, the data related to synapse artifacts will be stored in WSO2AM_DB. But you can specify a separate database 
for this feature. Only the data related to the synapse artifacts will be saved in this database.

First you need to add a configuration element of `[database.sync_runtime_artifacts_db]` . And simply have to update
the URL pointing to your database, the username, and password required to access the 
database and the driver details as shown below.

   | Element                       | Description                                                 |
    |-------------------------------|-------------------------------------------------------------|
    | **type**                      | The database type used                                      |
    | **url**                       | The URL of the database. The default port for MySQL is 3306 |
    | **username** and **password** | The name and password of the database user                  |
    | **driverClassName**           | The class name of the database driver                       |

Sample configuration for MYSQL is shown below. If you are using any other Database update the type and url
accordingly:

``` tab="Format"
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
    For more information on other parameters that can be defined in the 
    `<APIM_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).


Add the tables of *AM_GW_API_ARTIFACTS* and *AM_GW_PUBLISHED_API_DETAILS* to this new database that you are specifying. 
The scripts to create these tables are in `<APIM_HOME>/dbscripts/apimgt/` folder.
