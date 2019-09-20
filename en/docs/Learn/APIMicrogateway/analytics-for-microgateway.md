# Analytics for Microgateway

The following sections explain how to configure the WSO2 API-M Analytics server to work with the Microgateway.

-   [Architecture](#AnalyticsforMicrogateway-Architecture)
-   [How Analytics works with the Microgateway](#AnalyticsforMicrogateway-HowAnalyticsworkswiththeMicrogateway)
-   [Configuring Analytics for the Microgateway](#AnalyticsforMicrogateway-ConfiguringAnalyticsfortheMicrogateway)

### Architecture

The current architecture depicting the connection between the API Microgateway and the Analytics server is shown below.

![](/assets/attachments/103333771/103333776.png)
### How Analytics works with the Microgateway

The Microgateway receives the requests from the API. To process the requests, there are two main tasks that run in the Microgateway.

When an API is invoked through the Microgateway, the subsequent events related to the invocations are populated and written in a file. To avoid the files attaining a large size,  the following tasks are executed at particular time intervals.

-   [File rotating task](#AnalyticsforMicrogateway-Filerotatingtask)
-   [File uploading task](#AnalyticsforMicrogateway-Fileuploadingtask)

##### File rotating task

-   This task creates large files by rotating them at particular time intervals. The size of the files depends on the TPS (Transactions Per Second) of the environment in which the microgateway is running. Once the file is rotated, it is compressed into a zipped file. The `rotatingPeriod` can be configured as shown in the [following section](http://docs.wso2.com#config) .

##### File uploading task

-   This task uploads the zipped file created by the previous task, to a microservice running on the Analytics Server. This zip file is then persisted in the `WSO2AM_STATS_DB` database in the Analytics server node. A task running in the Analytics server processes the persisted data and sends it to the event stream. The time interval in which the zipped files are uploaded can be configured by setting the `uploadingTimeSpanInMillis` parameter.

After successfully completing the upload and persistence is achieved, the corresponding files are deleted from the Microgateway filesystem.

### Configuring Analytics for the Microgateway

The following sections describe how to configure the WSO2 API-M Analytics Server for Microgateway.

#### Step 1 - Configuring the API-M Analytics Server

!!! note
Before you begin...

Configure API Manager Analytics using the **Standard Setup** . For instructions, see [Configuring APIM Analytics](https://docs.wso2.com/display/AM250/Configuring+APIM+Analytics) .


1.  Create the `AM_USAGE_UPLOADED_FILES` table in the `WSO2AM_STATS_DB` database. A sample MySQL script to create the table is given below.

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
    Make sure that you correctly configured the `WSO2AM_STATS_DB` between WSO2 API Manager and WSO2 API-M Analytics.


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
<td><code>             -Dusage.publishing.frequency=20000            </code></td>
<td><code>             300000            </code> (5 minutes)</td>
<td>The frequency in which the database is read by the event source. This parameter is defined in milliseconds.</td>
</tr>
<tr class="even">
<td><code>             -Dusage.cleanup.frequency=36000            </code></td>
<td><code>             1800000            </code> (30 minutes)</td>
<td><div class="content-wrapper">
<p>The frequency in which the cleanup task is run, to remove the processed files. This parameter is defined in milliseconds.</p>
<p><br />
</p>
</div></td>
</tr>
<tr class="odd">
<td><code>             -Dfile.retention.days=5            </code></td>
<td>N/A</td>
<td><div class="content-wrapper">
<p>The allowed duration for files to remain in the database. This parameter is defined in days</p>
</div></td>
</tr>
<tr class="even">
<td><code>             -Dusage.publishing.thread.count=3            </code></td>
<td>3</td>
<td>The number of worker threads used to read data from the database. Each thread will read from a single file.</td>
</tr>
</tbody>
</table>

**Example**

``` java
    -Dusage.cleanup.frequency=48000  -Dusage.publishing.frequency=20000 -Dfile.retention.days=3
```


#### Step 2 - Configuring the Microgateway for Analytics

To do the configurations for Microgateway analytics, open the `<MICROGW_HOME>/conf/micro-gw.conf` file. The sample below shows the analytics-related configurations.

``` java
    enable=false
    uploadingTimeSpanInMillis=600000
    uploadingEndpoint="https://localhost:9444/micro-gateway-analytics/v0.10/usage/upload-file"
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
<td>Set this to true to enable Microgateway analytics. When enabled, the Microgateway starts persisting files with the analytics data in the <code>             &lt;MICROGW_HOME&gt;/api-usage-data            </code> folder.</td>
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
<p>To avoid creating large files, we recommend setting a low <code>               rotatingPeriod              </code> if your environment has a higher TPS.</p>

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
<p>In a distributed setup, the analytics data is uploaded to a shared location from multiple Microgateway nodes. To avoid multiple nodes competing to upload the same file, we recommend enabling the <code>               task.uploadFiles              </code> property in <strong>only one node</strong> . Make sure that you disable this in the rest of the Microgateway nodes.</p>
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


