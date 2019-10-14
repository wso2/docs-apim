# admin\_Monitoring Server Health

!!! warning
This document is work in progress!


The Carbon Health Check API can be used to check the health of a Carbon server. The sections below guide you through using this API.

-   [Deploying the API](#admin_MonitoringServerHealth-DeployingtheAPI)
-   [Configuring the API](#admin_MonitoringServerHealth-ConfiguringtheAPI)
-   [Invoking the API](#admin_MonitoringServerHealth-InvokingtheAPI)
-   [Error responses](#admin_MonitoringServerHealth-Errorresponses)
-   [Adding new health checkers](#admin_MonitoringServerHealth-Addingnewhealthcheckers)

!!! note
**Note:** This API is only supported for WSO2 Carbon products that are running on Java 8 or a later version.


There are three health checkers available by default:

1.  **Data sources health checker** - This checker goes through the data sources that are configured in the `master-datasources.xml` file and checks if the active connection count surpasses a healthy percentage limit (e.g., 80%) of the maximum allowed connections count. This checker also tests the connection from each data source to see whether the connection is successful.
2.  **Server startup health checker** - This checker uses the ServerAdmin service to check if the server status is RUNNING.
3.  **Super tenant user store health checker** - This checker iterates through configured user stores of the super tenant domain and attempts to invoke the `isExistingUser` method to check whether a failure occurs.

### Deploying the API

!!! warning
This API is supported by default from WSO2 Identity Server 5.7.0 onwards. It is available by default for WSO2 IS versions 5.5.0 and 5.6.0 only as a WUM update. For more information on how to update using WUM, see [Getting WSO2 Updates](https://docs.wso2.com/display/ADMIN44x/Getting+WSO2+Updates) documentation.

**If you are using a WSO2 product version that supports this feature by default (either in a fresh pack or via a WUM update), skip the instructions in this section and proceed **to the [configuring the API](#admin_MonitoringServerHealth-ConfiguringtheAPI) section.**



This section guides you through deploying the Carbon Health Check components in a WSO2 Carbon product that does not support this feature by default.

1.  Download the [org.wso2.carbon.healthcheck.server.feature-&lt;version-number&gt;.zip]({{base_path}}/assets/attachments/126562954/126562955.zip) and extract it. This folder is reffered to as `<API_HOME>` in this document.
2.  Copy the `org.wso2.carbon.healthcheck.api.core-<version-number>.jar` found in the `<API_HOME>/plugins` directory and paste it in the `<PRODUCT_HOME>/repository/components/dropins` directory.
3.  Copy the webapp `api#health-check#v1.0.war` found in the `<API_HOME>/features/org.wso2.carbon.healthcheck.server_1.0.0` directory and paste it in the the `<PRODUCT_HOME>/repository/deployment/server/webapps` directory.
4.  **(Optional step)** Copy the `health-check.config.xml` configuration file found in the `<API_HOME>/features/org.wso2.carbon.healthcheck.server_1.0.0` directory to your `<PRODUCT_HOME>/repository/conf/` directory.

### Configuring the API

This feature is disabled by default. To enable the API, set the `<Enable>` property in the `health-check-config.xml` file to **true** .

!!! tip
If the feature has not been enabled successfully , a request to the API will only return a 200 OK response.


**Sample health-check-config.xml file**

``` java
    <CarbonHealthCheckConfigs>
        <Enable>true</Enable>
        <HealthCheckers>
            <HealthChecker name="DataSourceHealthChecker" orderId="97" enable="true">
                <!--<Property name="monitored.datasources">jdbc/WSO2CarbonDB,jdbc/WSO2MetricsDB,jdbc/WSO2UMDB</Property>-->
                <Property name="pool.usage.limit.percentage">80</Property>
            </HealthChecker>
            <HealthChecker name="SuperTenantUSHealthChecker" orderId="98" enable="true">
                <!--<Property name="monitored.user.stores">primary,sec</Property>-->
            </HealthChecker>
        </HealthCheckers>
    </CarbonHealthCheckConfigs>
```

-   A health checker can be enabled or disabled using the **`enable`** attribute.
-   The execution order in which the health checkers are executes can be configured using the **`orderId`** attribute.
-   The properties configured under each health checker will be available for each heath checker at runtime.

### Invoking the API

This is an open API which should ideally be blocked at the load balancer level. To invoke it, start the WSO2 product and send a GET request to the health check API. A sample cURL command is shown below.

``` java
    curl -k -v https://{hostname}:{port}/api/health-check/v1.0/health
```

If the request is successful, you will recieve a 200 OK response (similar to the one shown below) with a list of health check results.

``` java
    {  
       "health":[  
          {  
             "key":"jdbc/WSO2CarbonDB.active.connection.count",
             "value":"1"
          },
          {  
             "key":"bpsds.active.connection.count",
             "value":"1"
          },
          {  
             "key":"jdbc/WSO2MetricsDB.connectivityTime.ms",
             "value":"81"
          },
          {  
             "key":"jdbc/WSO2MetricsDB.active.connection.count",
             "value":"1"
          },
          {  
             "key":"jdbc/WSO2CarbonDB.connectivityTime.ms",
             "value":"0"
          },
          {  
             "key":"bpsds.connectivityTime.ms",
             "value":"0"
          }
       ]
    }
```

-   The `active.connection.count` parameter reflects the number of connections that are active.

-`ConnectivityTime` refers to the the duration of the connection.

### **Error responses**

The following responses are possible error responses that you may receive.

The code block below shows a sample 503 Unavailable response with an array of errors.

``` java
    {  
       "errors":[  
          {  
             "code":"HC_00001",
             "message":"Error while getting database connection for datasource: jdbc/DISCONNECTED",
             "description":"Network is unreachable (connect failed)"
          },
          {  
             "code":"HC_00003",
             "message":"Error while checking health of USM with domain: SEC",
             "description":"Access denied for user 'roott'@'localhost' (using password: YES)"
          }
       ]
    }
```

| Error Code | Description                                                                                                       |
|------------|-------------------------------------------------------------------------------------------------------------------|
| HC\_00001  | Data source connectivity error.                                                                                   |
| HC\_00002  | Number of connections in data source exceeds the healthy percentage.                                              |
| HC\_00003  | Error while testing connectivity to the user store using the `isExistingUser` operation. |
| HC\_00004  | Server status is not running.                                                                                     |
| HC\_00005  | Error listing user stores.                                                                                        |

### Adding new health checkers

To add a new health checker, you can implement the HealthChecker API and register the health checker as an OSGI service.
To deploy it, copy the `.jar` file to the `<PRODUCT_HOME>/repository/component/lib/` directory or the OSGI bundle and paste it in the `<PRODUCT_HOME>/repository/component/dropins/` directory.
