# Synchronizing Artifacts in a Gateway Cluster

In a API-M Gateway cluster, artifact synchronization is critical to maintain consistency among the nodes. WSO2 API-M provides three mechanisms for artifact synchronization. 

1. [Shared file system (e.g.NFS)]({{base_path}}/install-and-setup/setup/distributed-deployment/synchronizing-artifacts-in-a-gateway-cluster/#artifact-synchronization-with-a-shared-file-system)
2. [Inbuilt artifact synchronizer]({{base_path}}/install-and-setup/setup/distributed-deployment/synchronizing-artifacts-in-a-gateway-cluster/#inbuilt-artifact-synchronization) 
3. [rsync]({{base_path}}/install-and-setup/setup/distributed-deployment/synchronizing-artifacts-in-a-gateway-cluster/#artifact-synchronization-with-rsync)

## Artifact Synchronization with a Shared File System

To enable synchronization for runtime artifacts of the two all in one WSO2 API-M instances, it is recommended to have a
shared file system. Configure a shared file system as the content synchronization mechanism. You can use a common shared file 
system such as Network File System (NFS) or any other shared file system that is available. 

You need to mount the `<API-M_HOME>/repository/deployment/server` directory of the two nodes to the shared file system, 
in order to share all APIs and throttling policies between all the nodes.

## Inbuilt Artifact Synchronization

#### Overview

Currently, in a multi gateway environment, synapse artifacts such as sequences, local entries, endpoints are saved at the `<APIM_HOME>/repository/deployment/server/synapse-configs/default` directory as XMLs. These artifacts has to be synced between all the gateway nodes using a artifact synchronizing mechanism. 
When using NFS we need to manage additional components which brings in changes to the current architecture. Thus, an inbuilt artifact synchronization solution is introduced. This inbuilt artifact synchronizer can be configurable to store these synapse artifacts to an extension point(configured persistent storage) .

The behaviour of the inbuilt artifact synchronizer in different scenarios, is described below.

#### Artifact Synchronization When The API Gateway is Running

  [![]({{base_path}}/assets/img/learn/artifact-synchronizer-architecture.png)]({{base_path}}/assets/img/learn/artifact-synchronizer-architecture.png)

1. In the event an API is published, edited, or removed, the synapse artifact corresponding to the API will be stored/updated in the configured extension point.. 
2. Then an event will be sent to Traffic Manager(TM) using event notifiers with API Name, UUID, and the gateway label
 for the API.
3. In a distributed deployment, gateways are subscribed to the Traffic Manager topics. API Gateway will filter out the events by the Gateway label. It will also sort the APIs that has the gateway label. 
4. Then it will fetch the artifacts associated with the API from the storage (Database or Github) and load it to the
 memory.

An extension point needs to be configured in the publisher profile to store the synapse artifacts in a persistent storage other than the default API-M database. When an API is published, edited, or removed, an event will be sent to Traffic Manager using Event Notifiers with API Name, UUID, and the gateway label for the API.


#### Artifact Synchronization at API Gateway startup


  [![]({{base_path}}/assets/img/learn/gateway-startup.png)]({{base_path}}/assets/img/learn/gateway-startup.png)
  
At startup, the gateway will look for the APIs with labels which it is subscribed to, in the configured extension, and fetch the synapse artifacts of those APIs. Those synapse artifacts will get deployed in the gateway.

Gateways are subscribed to the traffic manager. There is an extension in the gateway to get the synapse artifacts and deploy them in the memory. Gateways can subscribe to multiple labels.

###Configuring the Inbuilt Artifact Synchronizer

Configure the Gateway and Publisher profiles as below to enable artifact synchronization and retrieval from confgured extension points.

####Publisher Profile 

1. Stop the Publisher node if it running.
2. Open the file  `<API-M_HOME>/repository/conf/deployment.toml` and update as follows.
    ```
    [apim.sync_runtime_artifacts.publisher]
    artifact_saver = "DBSaver"
    publish_directly_to_gateway = "true"
    ```
    
    | Configuration                                    | Description                          |
    | -------------------------------------------------| ------------------------------------ |
    |apim.sync_runtime_artifacts.publisher            | configuration element then all the artifacts will be saved to the storage via  the extension point. In default they will get stored in database|
    |artifact_saver|specify the extension point. The default is `DBSaver` where the artifacts are saved in the database.|
    |publish_directly_to_gateway| If `publish_directly_to_gateway = true` then the artifacts will be published to the gateway directly. If `publish_directly_to_gateway = false` then the published API details will be notified to TM through events.|
       
  
    We can add the gateways as environments. For more information see 
   [Adding gateways as Environments]({{base_path}}/learn/api-gateway/maintaining-separate-production-and-sandbox-gateways/).

####Gateway Profile Configuration

1. Stop the Gateway node(s) if it is running.
2. Open the file  `<API-M_HOME>/repository/conf/deployment.toml` and update as follows.
   
    ```
    [apim.sync_runtime_artifacts.gateway]
    gateway_labels =["Production and Sandbox","Label1","Label2"]
    artifact_retriever = "DBRetriever"
    deployment_retry_duartion = 15000
    data_retrieval_mode = "sync"
    save_artifacts_locally = false
    ```
 
    |Configuration| Description|
    |--------------------------------------------------|------------------------------------------------|
    |gateway_labels|specify the labels which the gateway is going to subscribe to. Only the APIs with these labels will be pulled from the extension point and deployed.|
    |artifact_retriever|  we can specify the extension point. The default is `DBRetriever` where the artifacts are pulled from the database.|
    |deployment_retry_duartion|We can specify the retry duration in milliseconds to deploy artifacts, if there is a failure in pulling them from the  extension through `deployment_retry_duartion`. The retry duration specified here will be exponentially increased by a progression factor of 2. That means the duration will be progressed as 15s, 30s, 60s, 120s……. if there are continuous failures. And retry duration is bounded with 1 hr.<html><div class="admonition note"><p class="admonition-title">Note</p><p> This`deployment_retry_duartion` is  applicable only in Asynchronous deployment (`data_retrieval_mode ="async"` )where the server will try todeploy the artifacts after it is started. </p></div></html>|
    |data_retrieval_mode|Through `data_retrieval_mode = “sync” ` we can specify the mode of deployment of artifacts from the extension point. By default gateway Startup will be in a Synchronous manner. Here the server will wait until all the APIs have been deployed. If there is any failure in the deployment, it will again be triggered for n times where n is the maximum retry count. If the APIs are not deployed even in n retries then the server will start with un deployed API artifacts. If the user wants to switch the startup mode to an Asynchronous mode then he needs to specify it in the configs as `data_retrieval_mode = "async"`. Here the server will be up, independent of the deployment of synapse artifacts in gateway.|
     |save_artifacts_locally|If we add the config `save_artifacts_locally = true` or remove `save_artifacts_locally` config  then synapseartifacts will be stored in the file system. (Saved in `<APIM_HOME>/repository/deployment/server/synapse-configs/default/`) . When `save_artifacts_locally = false` then the artifacts from extension point will not be stored in the file system.|
    
 3. If the gateway profile is running with an port offset add the following configuration.
     ```
     [apim.event_hub]
     enable = true
     service_url = "https://traffic-manager:9443"  
     ```

     - If you are not running gateway as an all in one pack and it runs with a port offset, or when it's in a different
  node, we have to specify event_hub service_url as well .

####Database Configurations

By default, the data related to the synapse artifacts will be stored in WSO2AM_DB. This is configurable. Follow the steps below to configure a database to store the synapse artifacts.
 Only the data related to the synapse artifacts will be saved in this database.

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
    For more information on other parameters that can be defined in the 
    `<APIM_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).


Add the tables of *AM_GW_API_ARTIFACTS* and *AM_GW_PUBLISHED_API_DETAILS* to this new database that you are specifying. 
The scripts to create these tables are in `<APIM_HOME>/dbscripts/apimgt/` folder.


## Artifact Synchronization with rSync

Deployment synchronization can be done using [rsync](https://download.samba.org/pub/rsync/rsync.html), which is a file copying tool. These changes must be done in the manager node and in the same directory.

1.  Create a file named `workers-list.txt` , somewhere in your machine, that lists all the worker nodes in the deployment. The following is a sample of the file where there are two worker nodes.

    !!! tip
        Different nodes are separated by new lines.

    **workers-list.txt**

    ``` java
    ubuntu@192.168.1.1:~/setup/192.168.1.1/as/as_worker/repository/deployment/server
    ubuntu@192.168.1.2:~/setup/192.168.1.2/as/as_worker/repository/deployment/server
    ```

    !!! note
        If you have configured tenants in worker nodes, you need to add the `repository/tenants` directory of the worker node to the list to synchronize tenant space. For example, if the node `ubuntu@192.168.1.1` needs to be synced with both the super tenant and the tenant space, the following two entries should be added to the `workers-list.txt` file.

        **workers-list.txt**

        ``` java
        ubuntu@192.168.1.1:~/setup/192.168.1.1/apim/apim_worker/repository/deployment/server
        ubuntu@192.168.1.1:~/setup/192.168.1.1/apim/apim_worker/repository/tenants
        ```

2.  Create a file to synchronize the `<API-M_HOME>/repository/deployment/server` folders between the manager and all worker nodes.

    !!! note
        You must create your own SSH key and define it as the `pem_file` . Alternatively, you can use an existing SSH key. For information on generating and using the SSH Keys, go to the [SSH documentation](https://www.ssh.com/ssh/keygen/) . Specify the `manager_server_dir` depending on the location in your local machine. Change the `logs.txt` file path and the lock location based on where they are located in your machine.

    **rsync-for-carbon-depsync.sh**

    ``` java
    #!/bin/sh
    manager_server_dir=~/wso2as-5.2.1/repository/deployment/server/
    pem_file=~/.ssh/carbon-440-test.pem


    #delete the lock on exit
    trap 'rm -rf /var/lock/depsync-lock' EXIT 

    mkdir /tmp/carbon-rsync-logs/


    #keep a lock to stop parallel runs
    if mkdir /var/lock/depsync-lock; then
      echo "Locking succeeded" >&2
    else
      echo "Lock failed - exit" >&2
      exit 1
    fi

    #get the workers-list.txt
    pushd `dirname $0` > /dev/null
    SCRIPTPATH=`pwd`
    popd > /dev/null
    echo $SCRIPTPATH


    for x in `cat ${SCRIPTPATH}/workers-list.txt`
    do
    echo ================================================== >> /tmp/carbon-rsync-logs/logs.txt;
    echo Syncing $x;
    rsync --delete -arve "ssh -i  $pem_file -o StrictHostKeyChecking=no" $manager_server_dir $x >> /tmp/carbon-rsync-logs/logs.txt
    echo ================================================== >> /tmp/carbon-rsync-logs/logs.txt;
    done
    ```

3.  Create a Cron job that executes the above file every minute for deployment synchronization. Do this by running the following command in your command line.

    !!! note
        You can only run the Cron job on one given node (master) at a given time. If you switch the Cron job to another node, you must stop the Cron job on the existing node and start a new Cron job on the new node after updating it with the latest files.


    ``` java
    *   *  *   *   *     /home/ubuntu/setup/rsync-for-depsync/rsync-for-depsync.sh
    ```
