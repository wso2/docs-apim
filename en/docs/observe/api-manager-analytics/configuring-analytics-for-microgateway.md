# Analytics for Microgateway

WSO2 API Microgateway provides the capability to publish events to a configured analytics server, in order to generate analytics. The Microgateway is also capable of generating a usage report to gain insights of the analytics generated. This page describes the feature and explains how the feature could be used to generate useful analytics in order to gain important insights into the APIs deployed on the Microgateway.

### Overview

WSO2 API Microgateway supports publishing events to an analytics server in one of the two following methods.

1.  [Periodically publishing events (file-based)](#periodically-publishing-events-file-based)
2.  [Real-time publishing events (gRPC-based)](#real-time-publishing-gRPC-based)

The Following topics introduce and explain the difference between the two methods, as well as provide instructions on how to use them in the Microgateway to generate analytics.

### Periodically Publishing Events (file-based)

API Microgateway is capable of publishing events periodically to an analytics server.  The period in which the data is published can be configured.  A file-based approach is used in this method.

Periodical data publishing has the following advantages:

1.  A persistent connection to the analytics server is not a mandatory requirement (lossless publishing)
2.  No backpressure to the Gateway if the analytics server is loaded, allowing the gateway to operate smoothly.

#### Architecture

The current architecture depicting the connection between the API Microgateway and the Analytics server is shown below.

![ Connection between API Microgateway and Analytics server]({{base_path}}/assets/img/how-tos/connection-api-mg-and-analytics-server.png)

#### How periodical publishing works

The Microgateway receives the requests from the API. To process the requests, there are two main tasks that run in the Microgateway.

When an API is invoked through the Microgateway, the subsequent events related to the invocations are populated and written in a file. To avoid the files attaining a large size,  the following tasks are executed at particular time intervals.

##### File rotating task

-   This task creates large files by rotating them at particular time intervals. The size of the files depends on the TPS (Transactions Per Second) of the environment in which the Microgateway is running. Once the file is rotated, it is compressed into a zipped file. The `rotatingPeriod` can be configured as described [below](#using-periodical-data-publishing-file-based)) .

##### File uploading task

-   This task uploads the zipped file created by the previous task, to a microservice running on the Analytics Server. This zip file is then persisted in the `WSO2AM_STATS_DB ` database in the Analytics server node. A task running in the Analytics server processes the persisted data and sends it to the event stream. The time interval in which the zipped files are uploaded can be configured by setting the `uploadingTimeSpanInMillis` parameter.

After successfully completing the upload and persistence is achieved, the corresponding files are deleted from the Microgateway filesystem.

### Real-Time Publishing Events (gRPC based)

The Micorgateway is capable of publishing events in real-time to an analytics server using gRPC.

Real-Time data publishing has the following advantages:

-   Transferring analytics data over a secure HTTPS connection.
-   Efficient, fast and reliable end to end communication.
-   Lower communication payload for analytics data transferring.
-   Server-fail detection and failure recovery mechanisms.
-   Real-Time analytics data viewing capability.

<!--- TODO: #### Architecture --->

<!--- TODO: #### How real-time publishing works --->

### Configuring Analytics for the Microgateway

The following sections describe how to configure the WSO2 API-M Analytics Server for Microgateway.

#### Using periodical data publishing (file-based)

##### Step 1 - Configuring the WSO2 API-M Analytics Server

!!! note
    Before you begin...
    Configure API Manager Analytics using the **Quick setup** or **Standard Setup** . For instructions, see [Configuring APIM Analytics]({{apim_path}}/learn/analytics/configuring-apim-analytics/) .
1.  Create the `              AM_USAGE_UPLOADED_FILES             ` table in the APIM\_ANALYTICS\_DB . A sample MySQL script to create the table is given below (This step is only required if you followed the **Standard setup** when configuring API Manager Analytics).

    ``` java
    CREATE TABLE IF NOT EXISTS AM_USAGE_UPLOADED_FILES (
    FILE_NAME varchar(255) NOT NULL,
    FILE_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FILE_PROCESSED tinyint(1) DEFAULT 0,
    FILE_CONTENT MEDIUMBLOB DEFAULT NULL,
    PRIMARY KEY (FILE_NAME, FILE_TIMESTAMP)
    );
    ```

    !!! warning
        Make sure that you correctly configured the APIM\_ANALYTICS\_DB between WSO2 API Manager and WSO2 API-M Analytics.

!!! info
    Java system properties
    The following system properties can be passed to the server if the default values need to be changed.
    <table>
    <thead>
    <tr class="header">
    <th>Property</th>
    <th>Default value</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><code>                -Dusage.publishing.frequency=20000               </code></td>
    <td><code>                300000               </code> (5 minutes)</td>
    <td>The frequency in which the database is read by the event source. This parameter is defined in milliseconds.</td>
    </tr>
    <tr class="even">
    <td><code>                -Dusage.cleanup.frequency=36000               </code></td>
    <td><code>                1800000               </code> (30 minutes)</td>
    <td><div class="content-wrapper">
    <p>The frequency in which the cleanup task is run, to remove the processed files. This parameter is defined in milliseconds.</p>
    <p><br />
    </p>
    </div></td>
    </tr>
    <tr class="odd">
    <td><code>                -Dfile.retention.days=5               </code></td>
    <td>N/A</td>
    <td><div class="content-wrapper">
    <p>The allowed duration for files to remain in the database. This parameter is defined in days</p>
    </div></td>
    </tr>
    <tr class="even">
    <td><code>                -Dusage.publishing.thread.count=3               </code></td>
    <td>3</td>
    <td>The number of worker threads used to read data from the database. Each thread will read from a single file.</td>
    </tr>
    </tbody>
    </table>
    **Example**
``` java
    -Dusage.cleanup.frequency=48000  -Dusage.publishing.frequency=20000 -Dfile.retention.days=3
```

##### Step 2 - Configuring the Microgateway for Analytics

To do the configurations for Microgateway analytics, open the `<MICROGW_HOME>/conf/micro-gw.conf` file. The sample below shows the analytics-related configurations.

``` java
enable=true
uploadingTimeSpanInMillis=600000
uploadingEndpoint="https://localhost:9444/analytics/v1.0/usage/upload-file"
rotatingPeriod=60000
task.uploadFiles=true
username="admin"
password="admin"
```

The configurations are described in the table below.

<table>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>enable</code></pre></td>
<td>Set this to true to enable Microgateway analytics. When enabled, the Microgateway starts persisting files with the analytics data in the <code>                &lt;MICROGW_HOME&gt;/api-usage-data               </code> folder.</td>
</tr>
<tr class="even">
<td><pre><code>uploadingTimeSpanInMillis</code></pre></td>
<td>The time interval in which the uploading task runs.</td>
</tr>
<tr class="odd">
<td><pre><code>uploadingEndpoint</code></pre></td>
<td>The endpoint URL of the web application, to which the file has to be uploaded. This web app is deployed in the Analytics server, to retrieve files containing analytics data.</td>
</tr>
<tr class="even">
<td><pre><code>rotatingPeriod</code></pre></td>
<td><div class="content-wrapper">
<p>The time interval, after which the file is rotated and compressed. This depends on the TPS (Transactions Per Second) capacity of the environment.</p>
!!! tip
<p>Best Practice</p>
<p>To avoid creating large files, we recommend setting a low <code>                  rotatingPeriod                 </code> if your environment has a higher TPS.</p>

</div></td>
</tr>
<tr class="odd">
<td><pre><code>task.uploadFiles</code></pre></td>
<td><div class="content-wrapper">
<p>Set this to true to enable the file upload task.</p>
!!! note
    <p>If this property is disabled, the analytics files are not uploaded to the analytics server, although the files are persisted in the Microgateway system.</p>
!!! tip
    <p>Best Practice</p>
    <p>In a distributed setup, the analytics data is uploaded to a shared location from multiple Microgateway nodes. To avoid multiple nodes competing to upload the same file, we recommend enabling the <code>                  task.uploadFiles                 </code> property in <strong>only one node</strong> . Make sure that you disable this in the rest of the Microgateway nodes.</p>
    <p>You can also opt to have your own design as a workaround.</p>

</div></td>
</tr>
<tr class="even">
<td><pre><code>username</code></pre></td>
<td>Username used in the Analytics server.</td>
</tr>
<tr class="odd">
<td><pre><code>password</code></pre></td>
<td>Password for the corresponding username.</td>
</tr>
</tbody>
</table>

#### Using real-time data publishing (gRPC-based)

##### **Step 1 - Configuring the WSO2 API-M Analytics Server**

1.  Open the &lt;APIM-ANALYTICS-HOME&gt;/ conf / worker / deployment .yaml file
2.  Locate the `siddhi → refs → ref → name → grpcSource` parameter section. Change the IP and port of the receiver.url to point to the Microgateway. 
    
    ```toml
    siddhi:
      refs:
        - ref:
            name: 'grpcSource'
            type: 'grpc'
            properties:
              receiver.url : grpc://localhost:9806/org.wso2.analytics.mgw.grpc.service.AnalyticsSendService/sendAnalytics
    ```
    
3.  The SSL configurations for the connection can be defined under `siddhi → extensions → extension → grpc` as follows. 
    
    ```toml
    -
      extension:
        name: 'grpc'
        namespace: 'source'
        properties:
          keyStoreFile : ${sys:carbon.home}/resources/security/wso2carbon.jks
          keyStorePassword : wso2carbon
          keyStoreAlgorithm : SunX509
          trustStoreFile : ${sys:carbon.home}/resources/security/client-truststore.jks
          trustStorePassword : wso2carbon
          trustStoreAlgorithm : SunX509
    ```

##### **Step 2 - Configuring the Microgateway for Analytics**

1.  Open the &lt;MICRO\_GW\_HOME&gt;/conf/default-micro-gw.conf.template. Locate `analytics.gRPCAnalytics` located under the `analytics` section.
2.  Copy the `analytics.gRPCAnalytics` and paste it under the `analytics` section in the &lt;MICRO\_GW\_HOME&gt;/conf/micro-gw.conf file.
3.  Configure the following parameters in the copied section.

    ```toml
      [analytics.gRPCAnalytics]
        enable = false
        # APIM Analytics endpoint configured to accept gRPC analytics
        endpointURL = "https://localhost:9806"
        # Time interval in milliseconds for gRPC connection recovery task
        reconnectTimeInMillies = 6000
    ```
    
<table>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Description</th>
<th>Mandatory</th>
<th>Acceptable Values</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>enable</td>
<td>Enables or disables gRPC based real-time data publishing in the API Microgateway</td>
<td><br />
</td>
<td><p><strong>True</strong> - Enables gRPC based real-time analytics</p>
<p><strong>False</strong> - Disables gRPC based real-time analytics</p></td>
</tr>
<tr class="even">
<td>reconnectTimeInMillies</td>
<td>Defines the time interval for the gRPC reconnect task. It will try to connect to the gRPC supported analytics server according to the time interval defined in milliseconds.</td>
<td><br />
</td>
<td>Integers between -9,223,372,036,854,775,808 and 9,223,372,036,854,775,807</td>
</tr>
</tbody>
</table>

### Generating a Microgateway usage report

A report containing the number of requests served by the Microgateway can be generated using the following steps

!!! note
    Before you begin...
    Configure API Manager Analytics using the **Quick setup** or **Standard Setup** . For instructions, see [Configuring APIM Analytics]({{apim_path}}/learn/analytics/configuring-apim-analytics/) .

1.  Start the analytics dashboard in the analytics setup.

1.  Login to the analytics dashboard (https://localhost:9643/analytics-dashboard/) and navigate to the Reports dashboard.

    ![]({{base_path}}/assets/img/how-tos/analytics-dashboard.png)
    
2.  Select a year and a month to generate the report for the respective month.

    ![]({{base_path}}/assets/img/how-tos/useage-reports-320.png)
    
3.  Select 'Download' button to get the generated pdf with the usage information.

    ![]({{base_path}}/assets/img/how-tos/request-summary-320.png)


