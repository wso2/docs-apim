# Enabling Metrics and Storage Types

Given below are the configurations that should be in place for your API Manager server in order to use the metrics feature. You need to first enable metrics for your server and then enable the required storage types (reporters) that are used for storing the metrics data. See the following topics for instructions:

-   [Enabling metrics](#EnablingMetricsandStorageTypes-Enablingmetrics)
-   [Configuring the storage of metrics](#EnablingMetricsandStorageTypes-Configuringthestorageofmetrics)
-   [Sample configuration](#EnablingMetricsandStorageTypes-Sampleconfiguration)

### Enabling metrics

To enable metrics for your product, set the `Enabled` parameter under the `Metrics` element to `true` in the `<APIM_HOME>/repository/conf/metrics.xml` file. Alternatively, you can enable metrics at the time of starting the API Manager server by using the following command:

``` java
    -Dmetrics.enabled=true
```

### Configuring the storage of metrics

WSO2 API Manager is configured by default to store the information from metrics in the following reporters: JMX, CSV and JDBC. These reporters are configured in the `metrics.xml` file (stored in the `<APIM_HOME>/repository/conf` directory). You can disable metrics for individual reporters by setting the `Enabled` parameter to `false` .

!!! note
If you set the  the `Enabled` parameter under the `metrics` element to `false` in the `metrics.xml` file, metrics is disabled for all the reporters and it is not possible to enable metrics for individual reporters.


See the following topics for information on configuring each of the available storage types.

-   [JMX](#EnablingMetricsandStorageTypes-JMX)
-   [CSV](#EnablingMetricsandStorageTypes-CSV)
-   [JDBC](#EnablingMetricsandStorageTypes-JDBC)

#### JMX

The following parameters in the `metrics.xml` file can be used to configure a JMX storage for metrics data.

| Element Name | Description                                                                   | Type    | Default Value | Mandatory/Optional |
|--------------|-------------------------------------------------------------------------------|---------|---------------|--------------------|
| **Enabled**  | This parameter specifies whether metics monitoring is enabled for JMX or not. | Boolean | true          | Mandatory          |

#### CSV

The following parameters in the `metrics.xml` file can be used to configure a CSV storage for metrics data.

<table>
<thead>
<tr class="header">
<th>Element Name</th>
<th>Description</th>
<th>Type</th>
<th>Default Value</th>
<th>Mandatory/Optional</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Enabled</strong></td>
<td>This parameter specifies whether metrics monitoring is enabled for CSV or not.</td>
<td>Boolean</td>
<td>false</td>
<td>Mandatory</td>
</tr>
<tr class="even">
<td><strong>Location</strong></td>
<td>The location where the CSV files are stored.</td>
<td>String</td>
<td>${carbon.home}/repository/logs/metrics/</td>
<td><br />
</td>
</tr>
<tr class="odd">
<td><strong>PollingPeriod</strong></td>
<td>The time interval between polling activities that are carried out to update the metrics dashboard based on latest information. For example, if the polling period is 60 , polling would be carried out every 60 milliseconds.</td>
<td>Integer</td>
<td>60</td>
<td><br />
</td>
</tr>
</tbody>
</table>

#### JDBC

The following parameters in the `metrics.xml` file can be used to configure a JDBC storage for metrics data.

<table>
<thead>
<tr class="header">
<th>Element Name</th>
<th>Description</th>
<th>Type</th>
<th>Default Value</th>
<th>Mandatory/Optional</th>
<th>Notes</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Enabled</strong></td>
<td>This parameter specifies whether metrics monitoring is enabled for JDBC or not.</td>
<td>Boolean</td>
<td>true</td>
<td>Mandatory</td>
<td><br />
</td>
</tr>
<tr class="even">
<td><strong>DataSourceName</strong></td>
<td>The name of the datasource used.</td>
<td>String</td>
<td><code>             jdbc/WSO2MetricsDB            </code></td>
<td><br />
</td>
<td><br />
</td>
</tr>
<tr class="odd">
<td><strong>PollingPeriod</strong></td>
<td>The time interval between polling activities that are carried out to update the metrics dashboard based on latest information. For example, if the polling period is 60 , polling would be carried out every 60 seconds.</td>
<td>Integer</td>
<td>60</td>
<td><br />
</td>
<td>This value is specified in seconds.</td>
</tr>
<tr class="even">
<td><strong>ScheduledCleanup</strong></td>
<td>This element contains parameters relating to scheduled cleanup. The possible values are <code>             Enabled            </code> , <code>             ScheduledCleanupPeriod            </code> and <code>             DaysToKeep            </code> . Scheduled cleanup involves scheduling a task to clear metric data in the database after a specified time interval. This is done to avoid excessive memory usage.</td>
<td><br />
</td>
<td><br />
</td>
<td><br />
</td>
<td><br />
</td>
</tr>
<tr class="odd">
<td><strong>ScheduledCleanup/Enabled</strong></td>
<td>This parameter specifies whether scheduled cleanup is enabled or not.</td>
<td>Boolean</td>
<td>true</td>
<td><br />
</td>
<td><br />
</td>
</tr>
<tr class="even">
<td><strong>ScheduledCleanup/ScheduledCleanupPeriod</strong></td>
<td>The number of seconds that should elapse after a cleanup task before the next clean-up task is carried out.</td>
<td>Integer</td>
<td>86400</td>
<td><br />
</td>
<td><br />
</td>
</tr>
<tr class="odd">
<td><strong>ScheduledCleanup/DaysToKeep</strong></td>
<td>The number of days during which the scheduled clean-up task should be carried out.</td>
<td>Integer</td>
<td>7</td>
<td><br />
</td>
<td><br />
</td>
</tr>
</tbody>
</table>

If you have enabled JDBC, then you also need to specify a datasource configuration to be used to create the connection between WSO2 API Manager and the JDBC data storage system. The `metrics-datasources.xml` file is used for configuring this datasource for metrics.

Parameters that can be configured for a datasource are as follows:

<table>
<thead>
<tr class="header">
<th>XML element</th>
<th>Attribute</th>
<th>Description</th>
<th>Data type</th>
<th>Default value</th>
<th>Mandatory/Optional</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>             &lt;datasources-configuration&gt;            </code></td>
<td><code>             xmlns            </code></td>
<td><p>The root element. The namespace is specified as: <code>              xmlns:svns=&quot;http://org.wso2.securevault/configuration&quot;             </code></p></td>
<td><br />
</td>
<td><br />
</td>
<td>Mandatory</td>
</tr>
<tr class="even">
<td><code>             &lt;providers&gt;            </code></td>
<td><br />
</td>
<td>The container element for the datasource providers.</td>
<td><br />
</td>
<td><br />
</td>
<td>Mandatory</td>
</tr>
<tr class="odd">
<td><p><code>              &lt;provider&gt;             </code></p></td>
<td><br />
</td>
<td>The datasource provider, which should implement <code>             org.wso2.carbon.ndatasource.common                          .spi.DataSourceReader            </code> . The datasources follow a pluggable model in providing datasource type implementations using this approach.</td>
<td>Fully qualified Java class</td>
<td><br />
</td>
<td>Optional</td>
</tr>
<tr class="even">
<td><code>             &lt;datasources&gt;            </code></td>
<td><br />
</td>
<td>The container element for the datasources.</td>
<td><br />
</td>
<td><br />
</td>
<td>Mandatory</td>
</tr>
<tr class="odd">
<td><code>             &lt;datasource&gt;            </code></td>
<td><br />
</td>
<td>The root element of a datasource.</td>
<td><br />
</td>
<td><br />
</td>
<td>Mandatory</td>
</tr>
<tr class="even">
<td><code>             &lt;name&gt;            </code></td>
<td><br />
</td>
<td>Name of the datasource.</td>
<td>String</td>
<td><br />
</td>
<td>Mandatory</td>
</tr>
<tr class="odd">
<td><code>             &lt;description&gt;            </code></td>
<td><br />
</td>
<td>Description of the datasource.</td>
<td>String</td>
<td><br />
</td>
<td>Optional</td>
</tr>
<tr class="even">
<td><code>             &lt;jndiConfig&gt;            </code></td>
<td><br />
</td>
<td>The container element that allows you to expose this datasource as a JNDI datasource.</td>
<td><br />
</td>
<td><br />
</td>
<td>Optional</td>
</tr>
<tr class="odd">
<td><code>             &lt;name&gt;            </code></td>
<td><br />
</td>
<td>The JNDI resource name to which this datasource should be bound.</td>
<td>String</td>
<td><br />
</td>
<td>Mandatory if specifying JNDI configuration</td>
</tr>
<tr class="even">
<td><code>             &lt;environment&gt;            </code></td>
<td><br />
</td>
<td><p>The container element in which you specify the following JNDI properties:</p>
<ul>
<li><code>               java.naming.factory.initial              </code> :  Selects the registry service provider as the initial context.</li>
<li><code>               java.naming.provider.url              </code> : Specifies the location of the registry when the registry is being used as the initial context.</li>
</ul></td>
<td>Fully qualified Java class</td>
<td><br />
</td>
<td>Optional</td>
</tr>
<tr class="odd">
<td><code>             &lt;definition&gt;            </code></td>
<td><code>             type            </code></td>
<td>The container element for the data source definition. Set the type attribute to RDBMS, or to custom if you're creating a custom type. The &quot;RDBMS&quot; data source reader expects a &quot;configuration&quot; element with the sub-elements listed below.</td>
<td>String</td>
<td><br />
</td>
<td>Mandatory</td>
</tr>
<tr class="even">
<td><code>             &lt;configuration&gt;            </code></td>
<td><br />
</td>
<td>The container element for the RDBMS properties.</td>
<td><br />
</td>
<td><br />
</td>
<td>Mandatory if definition type is RDBMS</td>
</tr>
<tr class="odd">
<td><code>             &lt;url&gt;            </code></td>
<td><br />
</td>
<td>The connection URL to pass to the JDBC driver to establish the connection.</td>
<td>URL</td>
<td><br />
</td>
<td>Mandatory</td>
</tr>
<tr class="even">
<td><code>             &lt;username&gt;            </code></td>
<td><br />
</td>
<td>The connection user name to pass to the JDBC driver to establish the connection.</td>
<td>String</td>
<td><br />
</td>
<td>Optional</td>
</tr>
<tr class="odd">
<td><code>             &lt;password&gt;            </code></td>
<td><br />
</td>
<td>The connection password to pass to the JDBC driver to establish the connection.</td>
<td>String</td>
<td><br />
</td>
<td>Optional</td>
</tr>
<tr class="even">
<td><code>             &lt;driverClassName&gt;            </code></td>
<td><br />
</td>
<td>The class name of the JDBC driver to use.</td>
<td>Fully qualified Java class</td>
<td><br />
</td>
<td>Mandatory</td>
</tr>
<tr class="odd">
<td><code>             &lt;maxActive&gt;            </code></td>
<td><br />
</td>
<td>The maximum number of active connections that can be allocated from this pool at the same time.</td>
<td>Integer</td>
<td>100</td>
<td>Optional</td>
</tr>
<tr class="even">
<td><code>             &lt;maxWait&gt;            </code></td>
<td><br />
</td>
<td>Maximum number of milliseconds that the pool waits (when there are no available connections) for a connection to be returned before throwing an exception.</td>
<td>Integer</td>
<td>30000 (30 seconds)</td>
<td>Optional</td>
</tr>
<tr class="odd">
<td><code>             &lt;testOnBorrow&gt;            </code></td>
<td><br />
</td>
<td>Specifies whether objects are validated before being borrowed from the pool. If the object fails to validate, it is dropped from the pool, and we will attempt to borrow another.<br />
When set to true, the <code>             validationQuery            </code> parameter must be set to a non-null string.</td>
<td>Boolean</td>
<td>false</td>
<td>Optional</td>
</tr>
<tr class="even">
<td><code>             &lt;validationQuery&gt;            </code></td>
<td><br />
</td>
<td>The SQL query used to validate connections from this pool before returning them to the caller. If specified, this query does not have to return any data, it just can't throw a SQLException. The default value is null. Example values are SELECT 1(mysql), select 1 from dual(oracle), SELECT 1(MS Sql Server).</td>
<td>String</td>
<td>null</td>
<td>Mandatory when <code>             testOnBorrow            </code> is set to true</td>
</tr>
<tr class="odd">
<td><code>             &lt;validationInterval&gt;            </code></td>
<td><br />
</td>
<td>To avoid excess validation, only run validation at most at this frequency (interval time in milliseconds). If a connection is due for validation, but has been validated previously within this interval, it will not be validated again. The default value is 30000 (30 seconds).</td>
<td>Long</td>
<td>30000 (30 seconds)</td>
<td>Optional</td>
</tr>
</tbody>
</table>

### Sample configuration

Shown below is a sample `metrics.xml` file with the default configurations specifying the types of storages enabled for metrics data. See the above topics for instructions.

![](images/icons/grey_arrow_down.png){.expand-control-image} The default configurations in the metrics.xml file

``` xml
    -->
<!--
    This is the main configuration file for metrics
-->

<Metrics xmlns="http://wso2.org/projects/carbon/metrics.xml">

    <!--
        Enable Metrics
    -->
    <Enabled>false</Enabled>
    <!--
        Metrics reporting configurations
    -->

    <Reporting>
        <JMX>
            <Enabled>true</Enabled>
        </JMX>
        <CSV>
            <Enabled>false</Enabled>
            <Location>${carbon.home}/repository/logs/metrics/</Location>
            <!-- Polling Period in seconds -->
            <PollingPeriod>60</PollingPeriod>
        </CSV>
        <JDBC>
            <Enabled>true</Enabled>
            <!-- Source of Metrics, which will be used to
                identify each metric in database -->
            <!-- Commented to use the hostname
                <Source>Carbon</Source>
            -->
            <!--
                JNDI name of the data source to be used by the JDBC Reporter.
                This data source should be defined in a *-datasources.xml
                file in conf/datasources directory.
            -->
            <DataSourceName>jdbc/WSO2MetricsDB</DataSourceName>
            <!-- Polling Period in seconds -->
            <PollingPeriod>60</PollingPeriod>
            <ScheduledCleanup>
                <!--
                    Schedule regular deletion of metrics data older than a set number of days.
                    It is strongly recommended that you enable this job to ensure your metrics tables do not get extremely
                    large. Deleting data older than seven days should be sufficient.
                -->
                <Enabled>true</Enabled>
                <!-- This is the period for each cleanup operation in seconds -->
                <ScheduledCleanupPeriod>86400</ScheduledCleanupPeriod>
                <!-- The scheduled job will cleanup all data older than the specified days -->
                <DaysToKeep>7</DaysToKeep>
            </ScheduledCleanup>
        </JDBC>
    </Reporting>
</Metrics>
```
