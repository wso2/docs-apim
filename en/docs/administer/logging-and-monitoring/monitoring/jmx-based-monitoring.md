# JMX-Based Monitoring

Java Management Extensions (JMX) is a technology that lets you implement management interfaces for Java applications. A management interface, as defined by JMX, is composed of named objects called MBeans (Management Beans). MBeans are registered with a name (an ObjectName) in an MBeanServer. To manage a resource or many resources in your application, you can write an MBean defining its management interface and register that MBean in your MBeanServer. The content of the MBeanServer can then be exposed through various protocols, implemented by protocol connectors, or protocol adaptors.

## Configuring JMX in a WSO2 product

JMX is enabled in WSO2 products by default, which ensures that the JMX server starts automatically when you start a particular product.  Additionally, you can enable JMX separately for the various datasources that are used by the product. Once JMX is enabled, you can log in to the JConsole tool and monitor your product as explained in the [next section](#monitoring-a-wso2-product-with-jconsole).

### Configuring JMX ports for the server

The default JMX ports (RMIRegistryPort and the RMIServerPort) can be changed by adding the below config into 
`<PRODUCT_HOME>/repository/conf/deployment.toml` file as shown below. Following are the default values and you can 
update them as required.

````
 [monitoring.jmx]
 rmi_registry_port = 9999
 rmi_server_port = 11111
````

### Disabling JMX for the server

You can disable the JMX server for your product by adding the `rmi_server_start` property with value `false` into 
`<PRODUCT_HOME>/repository/conf/deployment.toml` file as shown below.
````
 [monitoring.jmx]
 rmi_server_start=false
````

### Enabling JMX for a datasource

You can enable JMX for a datasource by adding the `<jmxEnabled>true</jmxEnabled>` element to the datasource configuration file. For example, to enable JMX for the default Carbon datasource in your product, add the following property to the `master-datasources.` xml file (stored in the `<PRODUCT_HOME>/repository/conf/datasources` directory).

TODO: Update with toml config with jmxEnabled=true
 
``` java
<datasource>
    <name>WSO2_CARBON_DB</name>
    <description>The datasource used for registry and user manager</description>
    <jndiConfig>
        <name>jdbc/WSO2CarbonDB</name>
    </jndiConfig>
    <definition type="RDBMS">
        <configuration>
            <url>jdbc:h2:./repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000</url>
            <username>wso2carbon</username>
            <password>wso2carbon</password>
            <driverClassName>org.h2.Driver</driverClassName>
            <maxActive>50</maxActive>
            <maxWait>60000</maxWait>
            <testOnBorrow>true</testOnBorrow>
            <validationQuery>SELECT 1</validationQuery>
            <validationInterval>30000</validationInterval>
            <defaultAutoCommit>false</defaultAutoCommit>
            <jmxEnabled>true</jmxEnabled>
        </configuration>
    </definition>
</datasource>
```

## Monitoring a WSO2 product with JConsole

Jconsole is a JMX-compliant monitoring tool, which comes with the Java Development Kit (JDK) 1.5 and newer versions. You can find this tool inside your `<JDK_HOME>/bin` directory. 

### Starting the WSO2 product with JMX

First, start the WSO2 product:

1.  Open a command prompt and navigate to the `<PRODUCT_HOME>/bin` directory.
2.  Execute the product startup script (`api-manager.sh` for Linux and `api-manager.bat` for Windows) to start the server.

    !!! info
        If [JMX is enabled](#configuring-jmx-in-a-wso2-product), the **JMX server URL** will be published on the console when the server starts as shown below.

    ``` java
    INFO {org.wso2.carbon.core.init.CarbonServerManager} -  JMX Service URL  : service:jmx:rmi://<your-ip>:11111/jndi/rmi://<your-ip>:9999/jmxrmi
    ```


Once the product server is started, you can start the jConsole tool as follows:

1.  Open a command prompt and navigate to the `<JDK_HOME>/bin` directory.
2.  Execute the j `console` command to open the log-in screen of the **Java Monitoring & Management Console** as shown below.

     [![log screen]({{base_path}}/assets/img/administer/log-screen.png)]({{base_path}}/assets/img/administer/log-screen.png)
    
3.  Enter the connection details in the above screen as follows:
    
     1.  Enter the **JMX server URL** in the **Remote Process** field. This URL is published on the command prompt when you start the WSO2 server as explained [above](#starting-the-wso2-product-with-jmx).

        !!! info
            If you are connecting with a remote IP address instead of localhost, you need to bind the JMX service to the externally accessible IP address by adding the following system property to the product startup script stored in the `<PRODUCT_HOME>/bin` directory (`api-manager.sh` for Linux and `api-manager.bat` for Windows). For more information, read [Troubleshooting Connection Problems in JConsole](https://blogs.oracle.com/jmxetc/entry/troubleshooting_connection_problems_in_jconsole).

        ``` java
        -Djava.rmi.server.hostname=<IP_ADDRESS_WHICH_YOU_USE_TO_CONNECT_TO_SERVER>
        ```

        Be sure to restart the server after adding the above property.


     2.  Enter values for the **Username** and **Password** fields to log in. If you are logging in as the administrator, you can use the same administrator account that is used to log in to the product's management console: admin/admin.

        !!! info
            Make sure that the user ID you are using for JMX monitoring is assigned a role that has the **Server Admin** permission. See [Configuring Roles]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-roles) for further information about configuring roles assigned to users. Any user assigned to the **admin** role can log in to JMX.


4.  Click **Connect** to open the **Java Monitoring & Management Console**. The following tabs will be available:

     **Overview**

     See the Oracle documentation on [using JConsole](http://docs.oracle.com/javase/7/docs/technotes/guides/management/jconsole.html) for more information on these tabs.

     [![Overview]({{base_path}}/assets/img/administer/overview.png)]({{base_path}}/assets/img/administer/overview.png)


     **Memory**

     See the Oracle documentation on [using JConsole](http://docs.oracle.com/javase/7/docs/technotes/guides/management/jconsole.html) for more information on these tabs.

     [![Memory]({{base_path}}/assets/img/administer/memory.png)]({{base_path}}/assets/img/administer/memory.png)
   

     **Threads**

     See the Oracle documentation on [using JConsole](http://docs.oracle.com/javase/7/docs/technotes/guides/management/jconsole.html) for more information on these tabs.

     [![Threads]({{base_path}}/assets/img/administer/threads.png)]({{base_path}}/assets/img/administer/threads.png)
    

     **Classes**

     See the Oracle documentation on [using JConsole](http://docs.oracle.com/javase/7/docs/technotes/guides/management/jconsole.html) for more information on these tabs.

     [![Classes]({{base_path}}/assets/img/administer/classes.png)]({{base_path}}/assets/img/administer/classes.png)
    
    
     **VM**

     See the Oracle documentation on [using JConsole](http://docs.oracle.com/javase/7/docs/technotes/guides/management/jconsole.html) for more information on these tabs.

     [![VM]({{base_path}}/assets/img/administer/vmsummary.png)]({{base_path}}/assets/img/administer/vmsummary.png)


     **MBeans**

     See the Oracle documentation on [using JConsole](http://docs.oracle.com/javase/7/docs/technotes/guides/management/jconsole.html) for more information on these tabs.

     [![MBeans]({{base_path}}/assets/img/administer/mbeans.png)]({{base_path}}/assets/img/administer/mbeans.png)

### Using the ServerAdmin MBean

When you go to the **MBeans** tab in the JConsole, the **ServerAdmin** MBean will be listed under the "org.wso2.carbon" domain as shown below.

[![Server admin]({{base_path}}/assets/img/administer/server-admin.png)]({{base_path}}/assets/img/administer/server-admin.png)

The **ServerAdmin** MBean is used for administering the product server instance. There are several server attributes such as "ServerStatus", "ServerData" and "ServerVersion". The "ServerStatus" attribute can take any of the following values:

-   RUNNING
-   SHUTTING\_DOWN
-   RESTARTING
-   IN\_MAINTENANCE

[![Attributes]({{base_path}}/assets/img/administer/attributes.png)]({{base_path}}/assets/img/administer/attributes.png)

The **ServerAdmin** MBean has the following operations:

| Operation              | Description                                                                                                 |
|------------------------|-------------------------------------------------------------------------------------------------------------|
| **shutdown**           | Forcefully shut down the server.                                                                            |
| **restart**            | Forcefully restart the server.                                                                              |
| **restartGracefully**  | Wait till all current requests are served and then restart.                                                 |
| **shutdownGracefully** | Wait till all current requests are served and then shutdown.                                                |
| **startMaintenance**   | Switch the server to maintenance mode. No new requests will be accepted while the server is in maintenance. |
| **endMaintenance**     | Switch the server to normal mode if it was switched to maintenance mode earlier.                            |

[![Operations]({{base_path}}/assets/img/administer/operations.png)]({{base_path}}/assets/img/administer/operations.png)

### Using the ServiceAdmin MBean

This MBean is used for administering services deployed in your product. Its attributes are as follows:

| Attribute                    | Description                                                          |
|------------------------------|----------------------------------------------------------------------|
| **NumberOfActiveServices**   | The number of services that can currently serve requests.           |
| **NumberOfInactiveServices** | The number of services which have been disabled by an administrator. |
| **NumberOfFaultyServices**   | The number of services which are faulty.                             |

[![Number of active services]({{base_path}}/assets/img/administer/number-of-active-services.png)]({{base_path}}/assets/img/administer/number-of-active-services.png)

The operations available in the ServiceAdmin MBean:

| Operation                                          | Description                                                                                      |
|----------------------------------------------------|--------------------------------------------------------------------------------------------------|
| **startService** ( [p1:string](http://p1string/) ) | The p1 parameter is the service name. You can activate a service using this operation.           |
| **stopService** ( [p1:string](http://p1string/) )  | The p1 parameter is the service name. You can deactivate/disable a service using this operation. |

![Operation invocation]({{base_path}}/assets/img/administer/operation-invocation.png)]({{base_path}}/assets/img/administer/operation-invocation.png)

### Using the StatisticsAdmin MBean

This MBean is used for monitoring system and server statistics. Its attributes are as follows:

| Attributes                | Description                                                                                                                                      |
|---------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| **AvgSystemResponseTime** | The average response time for all the services deployed in the system. The beginning of the measurement is the time at which the server started. |
| **MaxSystemResponseTime** | The maximum response time for all the services deployed in the system. The beginning of the measurement is the time at which the server started. |
| **MinSystemResponseTime** | The minimum time for all the services deployed in the system. The beginning of the measurement is the time at which the server started.          |
| **SystemFaultCount**      | The total number of faults that occurred in the system since the server was started.                                                             |
| **SystemRequestCount**    | The total number of requests that has been served by the system since the server was started.                                                    |
| **SystemResponseCount**   | The total number of response that has been sent by the system since the server was started.                                                      |

[![System request count]({{base_path}}/assets/img/administer/system-request-count.png)]({{base_path}}/assets/img/administer/system-request-count.png)

Operations available in the **Statistics** MBean:

| Operation                                                                                         | Description                                                                                                                                                                                                         |
|---------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **getServiceRequestCount** ( [p1:string](http://p1string/) )                                      | The p1 parameter is the service name. You can get the total number of requests received by this service since the time it was deployed, using this operation.                                                       |
| **getServiceResponseCount** ( [p1:string](http://p1string/) )                                     | The p1 parameter is the service name. You can get the total number of responses sent by this service since the time it was deployed, using this operation.                                                          |
| **getServiceFaultCount** ( [p1:string](http://p1string/) )                                        | The p1 parameter is the service name. You can get the total number of fault responses sent by this service since the time it was deployed, using this operation.                                                    |
| **getMaxServiceResponseTime** ( [p1:string](http://p1string/) )                                   | The p1 parameter is the service name. You can get the maximum response time of this service since deployment.                                                                                                       |
| **getMinServiceResponseTime** ( [p1:string](http://p1string/) )                                   | The p1 parameter is the service name. You can get the minimum response time of this service since deployment.                                                                                                       |
| **getAvgServiceResponseTime** ( [p1:string](http://p1string/) )                                   | The p1 parameter is the service name. You can get the average response time of this service since deployment.                                                                                                       |
| **getOperationRequestCount** ( [p1:string](http://p1string/), [p2:string](http://p2string/) )    | The p1 parameter is the service name. The p2 parameter is the operation name. You can get the total number of requests received by this operation since the time its service was deployed, using this operation.    |
| **getOperationResponseCount** ( [p1:string](http://p1string/), [p2:string](http://p2string/) )   | The p1 parameter is the service name. The p2 parameter is the operation name. You can get the total number of responses sent by this operation since the time its service was deployed, using this operation.       |
| **getOperationFaultCount** ( [p1:string](http://p1string/), [p2:string](http://p2string/) )      | The p1 parameter is the service name. The p2 parameter is the operation name. You can get the total number of fault responses sent by this operation since the time its service was deployed, using this operation. |
| **getMaxOperationResponseTime** ( [p1:string](http://p1string/), [p2:string](http://p2string/) ) | The p1 parameter is the service name. The p2 parameter is the operation name. You can get the maximum response time of this operation since deployment.                                                             |
| **getMinOperationResponseTime** ( [p1:string](http://p1string/), [p2:string](http://p2string/) ) | The p1 parameter is the service name. The p2 parameter is the operation name. You can get the minimum response time of this operation since deployment.                                                             |
| **getAvgOperationResponseTime** ( [p1:string](http://p1string/), [p2:string](http://p2string/) ) | The p1 parameter is the service name. The p2 parameter is the operation name. You can get the average response time of this operation since deployment.                                                             |

[![Statistics mbean]({{base_path}}/assets/img/administer/statistics-mbean.png)]({{base_path}}/assets/img/administer/statistics-mbean.png)

### Using the DataSource MBean

If you have [JMX enabled for a datasource connected to the product](#JMX-BasedMonitoring-EnablingJMXforadatasource), you can monitor the performance of the datasource using this MBean. The **DataSource** MBean will be listed as shown below.

[![Datasource mbean]({{base_path}}/assets/img/administer/datasource-mbean.png)]({{base_path}}/assets/img/administer/datasource-mbean.png)

**Example:** If you have JMX enabled for the default Carbon datasource in the `master-datasources.xml.` file, the [JDBC connection pool parameters](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html) that are configured for the Carbon datasource will be listed as attributes as shown below. See the [performance tuning guide]({{base_path}}/install-and-setup/perfromance-tuning-and-test-results/tuning-performance) for instructions on how these parameters are configured for a datasource.

[![Attributes mbeans]({{base_path}}/assets/img/administer/attributes-mbeans.png)]({{base_path}}/assets/img/administer/attributes-mbeans.png)

### Using product-specific MBeans

The WSO2 product that you are using may have product-specific MBeans enabled for monitoring and managing specific functions. See the documentation for your product for detailed instructions on such product-specific MBeans.

## Monitoring a WSO2 product with Jolokia

[Jolokia](https://jolokia.org) is a JMX-HTTP bridge, which is an alternative to JSR-160 connectors. It is an agent-based approach that supports many platforms. In addition to basic JMX operations, it enhances JMX monitoring with unique features like bulk requests and fine-grained security policies.

Follow the steps below to use Jolokia to monitor a WSO2 product.

1.  Download [Jolokia OSGi Agent](https://jolokia.org/download.html). (These instructions are tested with the Jolokia OSGI Agent version 1.3.6 by downloading the `jolokia-osgi-1.3.6.jar` file.)
2.  Add it to the `<PRODUCT-HOME>/repository/components/dropins/` directory.

    !!! tip
        In the Micro Integrator, add it to the `<MI-HOME>/dropins/` directory.


3.  Start the WSO2 product server.

Once the server starts, you can read MBeans using Jolokia APIs. The following are a few examples.

-   List all available MBeans: <http://localhost:9763/jolokia/list> (Change the appropriate hostname and port accordingly.)
-   WSO2 ESB MBean: <http://localhost:9763/jolokia/read/org.apache.synapse:Name=https-sender,Type=PassThroughConnections/ActiveConnections>
-   Reading Heap Memory: <http://localhost:9763/jolokia/read/java.lang:type=Memory/HeapMemoryUsage>

For more information on the JMX MBeans that are available in WSO2 products, see [Monitoring a WSO2 product with JConsole](#using-the-serviceadmin-mbean).
