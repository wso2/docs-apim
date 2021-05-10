# Setting up EI Analytics for Observability

Follow the instructions given below to enable observability for your Micro Integrator deployment using <b>EI Analytics</b>. 

![EI-Analytics Observability]({{base_path}}/assets/img/integrate/monitoring-dashboard/classic-observability-architecture.png)

EI Analytics consists of two components: **Server** and **Portal**. The server processes the data streams that are sent from the Micro Integrator and publishes the statistics to a database. The portal reads the statistics published by the worker and displays the statistics. The server and portal are connected through the database.

This solution is more suitable if you already have an observability stack such as ELK,  or if you want more business analytics and less operational observability. To select the most appropriate observability solution for your deployment, see [Observability Deployment Strategy]({{base_path}}/install-and-setup/setup/mi-setup/observability/observability-deployment-strategy).

## System requirements

You will be running three servers (EI Analytics server, EI Analytics portal, and the Micro Integrator) for this solution. Be sure that you have the required system specifications to run each server.

-   For the Analytics **Server**:

    <table>
    <tbody>
    <tr class="odd">
    <th>Memory</th>
    <td><p><ul><li>~ 4 GB per worker node<li>It is recommended to allocate 4 cores.</li></li><li>~ 2 GB is the initial heap (-Xms)  required for the server startup. The maximum heap size is 4 GB (-Xmx)</li></ul></p></td>
    </tr>
    <tr class="even">
    <th>Disk</th>
    <td><p><li>~ 480 MB, excluding space allocated for log files and databases.</li></p></td>
    </tr>
    </tbody>
    </table>

-   For the Analytics **Portal**:

    <table>
    <tbody>
    <tr class="odd">
    <th>Memory</th>
    <td><p><ul><li>~ 2 GB minimum, 4 GB Maximum<li>2 CPU cores minimum. It is recommended to allocate 4 cores.</li></li><li>~ 512 MB heap size. This is generally sufficient to process typical SOAP messages but the requirements vary with larger message sizes and  the number of messages processed concurrently.</li></ul></p></td>
    </tr>
    <tr class="even">
    <th>Disk</th>
    <td><p><li>~ 480 MB, excluding space allocated for log files and databases.</li></p></td>
    </tr>
    </tbody>
    </table>

-   For the Micro Integrator, see the [installation prerequsites]({{base_path}}/install-and-setup/install/installation-prerequisites).

## Download the servers

-   To download EI Analytics:
    1.  Go to the WSO2 Enterprise Integrator <a href="https://wso2.com/integration/">product page</a>, click <b>Download</b>, and then go to the <b>Other Resources</b> section.
    2.  Click <b>Integration Analytics</b> to download the distribution.

        <img src="{{base_path}}/assets/img/integrate/observability/download-ei-analytics.png">

    !!! Info
        The location of your Analytics installation will be referred to as `<EI_ANALYTICS_HOME>`.

-   Download and [install the Micro Integrator]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi).

## Configuring the Micro Integrator
    
### Enabling statistics monitoring

To enable statistics monitoring for the Micro Integrator, add the following parameters in the `deployment.toml` file of your Micro Integrator. This file is stored in the `MI_HOME/conf`.

```toml
[mediation]
flow.statistics.enable=true
stat.tracer.collect_payloads=true
stat.tracer.collect_mediation_properties=true
```
### Configuring the Micro Integrator to publish data to EI Analytics

Analytics publishing can be configured in the `[monitoring]` section of the `<MI_HOME>/conf/deployment.toml` file as shown below.

!!! Note
    By default, the Micro Integrator is internally configured (with the following) to connect with an EI Analytics server running on the same VM. To change the default setup, you need to add the following to the `deployment.toml` file and update the values.

```toml
[monitoring]
ei_analytics.server_url = "tcp://localhost:7612"
ei_analytics.auth_server_url = "ssl://localhost:7712"
ei_analytics.username = "admin"
ei_analytics.password = "admin"        
```

If the Analytics nodes run in cluster mode or in different VMs, you can configure the ei_analytics.server_url and the ei-analytics.auth_server_url parameters in a load balancing manner. For more information, see, [Load balancing among multiple Analytics servers](#load-balancing-among-multiple-analytics-servers).

### Enabling statistics for ALL artifacts

If you want to collect statistics for **all** your integration artifacts, be sure to add the following parameter under the `[mediation]` header in the `deployment.toml` file in addition the [parameters explained above](#configuring-the-micro-integrator):

```toml
flow.statistics.capture_all=true
```

Alternatively, you can enable statistics for selected artifacts as explained below.

### Enabling statistics for specific artifacts

Let's use the integration artifacts from the [service chaining]({{base_path}}/tutorials/integration-tutorials/exposing-several-services-as-a-single-service) tutorial.

!!! Warning
    It is not recommended to enable **tracing** in production environments as it generates a large number of events that reduces the performance of the analytics profile. Therefore, tracing should only be enabled in development environments.

If you did not try the [service chaining]({{base_path}}/tutorials/integration-tutorials/exposing-several-services-as-a-single-service) tutorial yet:

1.  Download the [pre-packaged project](https://github.com/wso2-docs/WSO2_EI/blob/master/Integration-Tutorial-Artifacts/Integration-Tutorial-Artifacts-EI7.1.0/service-orchestration-tutorial.zip) for the **service chaining** use case.
2.  [Open WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio) and [import the pre-packaged project]({{base_patgh}}/integrate/develop/importing-projects).

Follow the steps below to enable statistics and tracing for the **REST API** artifact:

1.  Select `HealthcareAPI` in the canvas of WSO2 Integration Studio to open the **Properties** tab.
2.  Select **Statistics Enabled** and (if required) **Trace Enabled** as shown below.

    <img src="{{base_path}}/assets/img/integrate/ei-analytics/restapi-properties.png" alt="rest api properties" width="500">

Follow the steps below to enable statistics for the **endpoint** artifacts:

1.  Select the required endpoint artifacts from the project explorer. 
2.  Select **Statistics Enabled** and (if required) **Trace Enabled** as shown below.
     ![endpoint properties]({{base_path}}/assets/img/integrate/ei-analytics/endpoint-properties.png)
     
### Load balancing among multiple Analytics servers

You can send events to multiple Analytics servers either by sending the same event to many Analytics servers or by load balancing events among a set of servers. This handles the failover problem. When events are load balanced within a set of servers and if one receiver cannot be reached, events are automatically sent to the other available and active Analytics servers. The following scenarios are covered in this section.

#### Load balancing across a group of servers 

To configure this setup, configure the Analytics receiver URL specified in the Micro Integrator as a comma-separated list of Analytics servers. 

The format of the receiver URL should be as follows: `tcp://<Analytics-1>:<port>,tcp://<Analytics-2>:<port>,tcp://<Analytics-3>:<port>`

Example configuration in the `deployment.toml` file of the Micro Integrator:

```toml
[monitoring]
ei_analytics.server_url = "tcp://10.100.2.32:7611, tcp://10.100.2.33:7611, tcp://10.100.2.34:7611"
ei_analytics.auth_server_url = "tcp://10.100.2.32:7612, tcp://10.100.2.33:7612, tcp://10.100.2.34:7612"
ei_analytics.username = "admin"
ei_analytics.password = "admin"  
```  

![lb events to servers]({{base_path}}/assets/img/integrate/ei-analytics/ob-lb-events-to-servers.png)

This handles failover as follows: If Analytics Receiver-1 is marked as down, then the Micro Integrator will send the data only to Analytics Receiver-2 and Analytics Receiver-3 in a round robin manner. When the Analytics Receiver-1 becomes active after some time, the Micro Integrator automatically detects it, adds it to the operation, and again starts to load balance between all three receivers. This functionality significantly reduces the loss of data and provides more concurrency.

#### Load balancing across multiple groups of servers  

In this setup, there are two sets of servers that are referred to as set-A and set-B. 
You can send events to both the sets. You can also carry out load balancing for both sets as mentioned in [Load balancing across a group of servers](#load-balancing-across-a-group-of-servers). 
This scenario is a combination of load balancing between a set of servers and sending an event to several receivers. 
An event is sent to both set-A and set-B. Within set-A, it is sent either to Analytics A1 or Analytics A2. 
Similarly within set-B, it is sent either to Analytics B1 or Analytics B2. 
In the setup, you can have any number of sets and any number of servers as required.
    ![lb events to set of servers]({{base_path}}/assets/img/integrate/ei-analytics/ob-lb-to-sets-of-servers.png)
    
Similar to the other scenarios, you need to describe the server URLs as the receiver URL in the Micro Integrator configuration. The sets should be specified within curly braces separated by commas. Furthermore, each receiver that belongs to the set should be within the curly braces and with the receiver URLs in a comma-separated format. 

The format of the receiver URL should be as follows: `{tcp://Analytics-A1:port, tcp://Analytics-A2:port},{tcp://Analytics-B1:port, tcp://Analytics-B2:port}`

Example configuration in the deployment.toml file of the Micro Integrator:

```toml
[monitoring]
ei_analytics.server_url = "{tcp://10.100.2.32:7611, tcp://10.100.2.33:7611}, {tcp://10.100.2.34:7611, tcp://10.100.2.35:7611}"
ei_analytics.auth_server_url = "{tcp://10.100.2.32:7612, tcp://10.100.2.33:7612}, {tcp://10.100.2.34:7612, tcp://10.100.2.35:7612}"
ei_analytics.username = "admin"
ei_analytics.password = "admin"  
```

#### Sending all events to several analytics servers

This setup involves sending all the events to more than one Analytics server. 
This approach is useful when you want to have multiple Analytics servers to analyze the same events simultaneously. 
For example, as shown below, you can configure the Micro Integrator to publish the same event to both Analytics servers at the same time. 

 ![all events to all servers]({{base_path}}/assets/img/integrate/ei-analytics/ob-all-events-to-all-servers.png)

The Analytics receiver URL should be configured with the following format in the Micro Integrator: `{tcp://Analytics-1>:<port>}, {tcp://Analytics-2>:<port>}, {tcp://<Analytics-3>:<port>}`

Example configuration in the `deployment.toml` file of the Micro Integrator:

```toml
[monitoring]
ei_analytics.server_url = "{tcp://10.100.2.32:7611},{ tcp://10.100.2.33:7611}, {tcp://10.100.2.34:7611}"
ei_analytics.auth_server_url = "{tcp://10.100.2.32:7612},{ tcp://10.100.2.33:7612}, {tcp://10.100.2.34:7612}"
ei_analytics.username = "admin"
ei_analytics.password = "admin"  
```

#### Failover configuration

When using the failover configuration in publishing events to Analytics, events are sent to multiple Analytics servers in a sequential order based on priority. 
You can specify multiple Analytics servers so that events can be sent to the next server in the specified sequence (in a situation where they were not successfully sent to the first server). 
In the scenario depicted in the above image, the events are first sent to Analytics-1. 
If it is unavailable, then events are sent to Analytics-2. 
If Analytics-2  is also unavailable, then the events are sent to Analytics-3.
    
![fail over]({{base_path}}/assets/img/integrate/ei-analytics/ob-fail-over.png)

The Analytics receiver URL should be configured with the following format in the Micro Integrator: `tcp://<Analytics-1>:<port>|tcp://<Analytics-2>:<port>|tcp://<Analytics-3>:<port>`

```toml
[monitoring]
ei_analytics.server_url = "tcp://10.100.2.32:7611|tcp://10.100.2.33:7611|tcp://10.100.2.34:7611"
ei_analytics.auth_server_url = "tcp://10.100.2.32:7612|tcp://10.100.2.33:7612|tcp://10.100.2.34:7612"
ei_analytics.username = "admin"
ei_analytics.password = "admin"  
```
## What's Next?

If you have successfully set up your anlaytics deployment, see the instructions on [using the analytics portal]({{base_path}}observe/mi-observe/using-the-analytics-dashboard).
