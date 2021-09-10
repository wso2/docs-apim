# Configuring the Log Provider

Logs of a system can be stored in many ways. For example, they can be stored in a file system, an SQL server such as MySQL, a no-sql server like Cassandra, etc. According to the default configurations in a Carbon product, the logs are stored in the `<PRODUCT_HOME>/repository/logs/` directory as `.log` files.

To [view and download the logs](https://docs.wso2.com/display/ADMIN44x/View+and+Download+Logs) using the management console, the following configurations are required: the [Logging Management](https://docs.wso2.com/display/ADMIN44x/Monitoring+Logs+using+Management+Console) feature should be installed, [the log4j properties should be configured](https://docs.wso2.com/display/ADMIN44x/Configuring+Log4j+Properties) and the LogProvider and LogFileProvider interfaces should be implemented and configured for the server as described below.

-   [Implementing the LogProvider interface](#ConfiguringtheLogProvider-ImplementingtheLogProviderinterface)
-   [Implementing the LogFileProvider interface](#ConfiguringtheLogProvider-ImplementingtheLogFileProviderinterface)
-   [Configuring Carbon to plug the log provider](#ConfiguringtheLogProvider-ConfiguringCarbontoplugthelogprovider)

### Implementing the LogProvider interface

This `org.wso2.carbon.logging.service.provider.api.LogProvider` interface is used for viewing logs in the management console. It is introduced as an extension point to provide logs to the "Log Viewer" (in the management console). Any log provider can implement this interface to fetch logs from any mechanism, and the Log Viewer will use this interface to retrieve and show logs in the management console.

The `LogProvider` interface has the following methods:

-`init(LoggingConfig loggingConfig)` - Initialize the log provider by reading the properties defined in the [logging configuration](#ConfiguringtheLogProvider-ConfigureLogProvidersinCarbonProducts) file. This will be called immediately after creating a new instance of LogProvider.
-   getApplicationNames(String tenantDomain, String serverKey) - Return list of all application names deployed under provided tenant domain and server key.
-   getSystemLogs() - Return a list of system LogEvents.
-   getAllLogs(String tenantDomain, String serverKey) - Return list of all the logs available under given domain and server key
-   getLogsByAppName(String appName, String tenantDomain, String serverKey) - Return list of all the LogEvents belonging to the application, which is deployed under given tenant domain and server key.
-   getLogs(String type, String keyword, String appName, String tenantDomain, String serverKey) - Returns list of all LogEvents related to the given application, which match to given type and LogEvent message has given key word with it. User can use this API for search operations.
-   logsCount(String tenantDomain, String serverKey) - Return LogEvent count
-   clearLogs() - Clear operation. For example, if it is an "in memory" log provider, this method can be used to clear the memory.

### Implementing the LogFileProvider interface

The `org.wso2.carbon.logging.service.provider.api.LogFileProvider` interface is used to list and download the archived log files using the management console. It is introduced as an extension point providing the list of log file names and the ability to download these logs to the "Log Viewer".

The `LogFileProvider` interface has the following methods:

-   init(LoggingConfig loggingConfig)-  Initialize the file log provider by reading the properties defined in the [logging configuration](#ConfiguringtheLogProvider-ConfigureLogProvidersinCarbonproducts) file. This will be called immediately after creating a new instance of LogFileProvider.
-   getLogFileInfoList(String tenantDomain, String serviceName) - Return information about the log files, which is available under given tenant domain and serviceName. For example, info about logs: log name, log date, log size.
-   downloadLogFile(String logFile, String tenantDomain, String serviceName) - Download the file.

!!! info
Default log provider in Carbon products

A default "in memory" log provider, which implements the `LogProvider` interface has been created both as a sample and as the default log provider option in carbon. Main task of this class is to read the carbon logs available in the `<PRODUCT_HOME>/repository/logs/` directory to a buffer stored in memory and enable the LogViewer to fetch and view these logs in the management console.

A default log file provider that implements the `LogFileProvider` interface has also been implemented as a sample and as the default log file provider option in carbon. The main task of this class is to read the log file names (including the size and date of these files) from the `<PRODUCT_HOME>/repository/logs/` directory and to enable the download of these logs.


### Configuring Carbon to plug the log provider

After implementing the above interfaces, update the `logging-config.xml` file stored in the `<PRODUCT_HOME>/repository/conf/etc/` directory.

-   Shown below is the configuration for the the default log provider and the default log file provider of a Carbon product:

    ``` java
        <loggingConfig xmlns="http://wso2.org/projects/carbon/carbon.xml">
        <!-- Default log provider -->
        <logProviderConfig class="org.wso2.carbon.logging.service.provider.InMemoryLogProvider">
            <properties/>
        </logProviderConfig>

        <!-- Default log file provider -->
        <logFileProviderConfig class="org.wso2.carbon.logging.service.provider.FileLogProvider">
            <properties/>
        </logFileProviderConfig>
    </loggingConfig>
    ```
        !!! note
    The default "InMemoryLogProvider" uses the CarbonMemoryAppender. Therefore the log4j.properties file stored in &lt;PRODUCT\_HOME&gt;/repository/conf/ directory should be updated with the following log4j.appender.CARBON\_MEMORY property:

    ``` java
        log4j.appender.CARBON_MEMORY=org.wso2.carbon.logging.service.appender.CarbonMemoryAppender]
    ```


    If the implemented class requires additional properties to initialise the class, the `<properties>` element in the `logging-config.xml` file can be used. For example, a cassandra based log provider may need information on keyspace, column family, etc. You can configure these details in the `logging-config.xml` file and access them at runtime using the `LoggingConfig` class, which contains all configuration parameters. For a Cassandra based log provider, the following properties can be defined in the `logging-config.xml` file and later used in the implementation using the `LoggingConfig` class, which is assigned when initializing the class.

-   The following properties can be configured in the `logging-config.xml` file for a Cassandra based log provider:

    ``` java
        <logProviderConfig xmlns="http://wso2.org/projects/carbon/carbon.xml" class="org.wso2.carbon.logging.service.provider.CassandraLogProvider">
                <properties>
                    <property name="userName" value="admin"/>
                    <property name="password" value="admin"/>
                    <property name="archivedHost" value="http://127.0.0.1/logs/stratos/0/WSO2%20Stratos%20Manager/"/>
                    <property name="archivedHDFSPath" value="/stratos/logs"/>
                    <property name="archivedUser" value="admin"/>
                    <property name="archivedPassword" value="admin"/>
                    <property name="archivedPort" value="80"/>
                    <property name="archivedRealm" value="Stratos"/>
                    <property name="cassandraHost" value="localhost:9160"/>
                    <property name="isDataFromCassandra" value="false"/>
                    <property name="cassandraConsistencyLevel" value="ONE"/>
                    <property name="cassandraAutoDiscovery.enable" value="false"/>
                    <property name="cassandraAutoDiscovery.delay" value="1000"/>
                    <property name="retryDownedHosts.enable" value="true"/>
                    <property name="retryDownedHosts.queueSize" value="10"/>
                    <property name="columnFamily" value="log"/>
                    <property name="cluster" value="admin"/>
                    <property name="keyspace" value="EVENT_KS"/>
                </properties>
        </logProviderConfig>
    ```


