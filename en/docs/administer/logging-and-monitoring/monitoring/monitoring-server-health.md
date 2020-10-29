# Monitoring Server Health

**Health Check API** is used to validate and verify the status of the APIM server and its dependencies
It is a REST service which returns the operational status, performance information of the configured endpoints with appropriate HTTP return code and a JSON object
There are two health checkers available by default:

1.  **Data sources health checker** - This checker goes through the data sources that are configured in the `<API-M_HOME>/repository/conf/deployment.toml` file and checks if the active connection count surpasses a healthy percentage limit (e.g., 80%) of the maximum allowed connections count. This checker also tests the connection from each data source to see whether the connection is successful.
2.  **User store health checker** - This checker iterates through configured user stores of the super tenant domain and attempts to invoke the `isExistingUser` method to check whether a failure occurs.

!!! note
    This API is only supported for WSO2 API Manager that runs on Java 8 or a later version.

### Deploying the API

This section guides you through deploying the Carbon Health Check components in WSO2 API Manager

1. Fork the following GitHub repository.

     ```https://github.com/wso2/carbon-health-check```
     
2. Navigate to the place where you want to clone the repo and clone the forked repository. 

     ```git clone https://github.com/[git-username]/carbon-health-check```  
   
3. Forked Repository is referred to as `<HEALTH_CHECK_HOME>` in this document. Navigate to `<HEALTH_CHECK_HOME>` and build the product.
    
      ```mvn clean install -Dmaven.test.skip=true```
      
4.  Rename `org.wso2.carbon.healthcheck.api.core-<version-number>-SNAPSHOT.jar` found in the `<HEALTH_CHECK_HOME>/components/org.wso2.carbon.healthcheck.api.core/target` directory as `org.wso2.carbon.healthcheck.api.core-<version-number>.jar`  and paste it in the `<APIM_HOME>/repository/components/dropins` directory.

5.  Copy the webapp `api#health-check#v1.0.war` found in the `<HEALTH_CHECK_HOME>//components/org.wso2.carbon.healthcheck.api.endpoint/target/` directory and paste it in the the `<APIM_HOME>/repository/deployment/server/webapps` directory.

### Configuring and invoking the API

This feature is disabled by default. To enable the API open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file and update it as follows:.
    
```
[carbon_health_check]
enable = true
```

This is an open API that should ideally be blocked at the load balancer level. To invoke it, start the WSO2 product and send a GET request to the health check API. A sample cURL command is shown below.

``` java
    curl -k -v https://{hostname}:{port}/api/health-check/v1.0/health
```  
   
Data sources health checker and User store health checker will get enabled when you enable health checkers using above global configuration. 
The properties configured under each health checker will be available for each health checker at runtime.

#### DataSource Health Checker

This health checker returns the status of the data sources available in the system.
To indicate the data source connection pool usage and specify the order, use the following configurations to the `/repository/conf/deployment` file.

```
    [carbon_health_check.health_checker.data_source_health_checker]
    enable = true
    pool_usage_limit_percentage = "80"
    order = "97"

    [carbon_health_check.health_checker.data_source_health_checker.properties]
    'monitored.datasources' = "jdbc/WSO2CarbonDB,jdbc/WSO2AM_DB,jdbc/SHARED_DB"
```   

| **Configuration**                               | **Description**                          |
    | ---------------------------------------------| ------------------------------------ |
    |enable                                        | The configuration element is to enable DataSource Health Checker. When `carbon_health_check` is enabled this config will get enabled by default.  |
    |pool_usage_limit_percentage                   | This config is used to specify a healthy percentage limit of the maximum allowed connections count. Data health checker checks if the active connection count surpasses the given healthy percentage limit. The default value is `80`. |
    |order                                         | The execution order in which the Data Source Health checker is executed. The default value is `97`.|
    |monitored.datasources                         | This config is used to specify the Data Sources to be monitored as comma-separated values.|
 

When you invoke the API and User Stores are healthy you can see a response as below:

```
    {
       "health":[
          {
             "key":"jdbc/SHARED_DB.connectivity.time.ms",
             "value":"0"
          },
          {
             "key":"WSO2MBStoreDB.connectivity.time.ms",
             "value":"0"
          },
          {
             "key":"jdbc/WSO2CarbonDB.connectivity.time.ms",
             "value":"0"
          },
          {
             "key":"jdbc/WSO2AM_DB.connectivity.time.ms",
             "value":"0"
          },
          {
             "key":"jdbc/WSO2CarbonDB.active.connection.count",
             "value":"1"
          },
          {
             "key":"jdbc/WSO2MetricsDB.active.connection.count",
             "value":"1"
          },
          {
             "key":"jdbc/WSO2MetricsDB.connectivity.time.ms",
             "value":"33"
          },
          {
             "key":"jdbc/WSO2AM_DB.active.connection.count",
             "value":"1"
          },
          {
             "key":"jdbc/SHARED_DB.active.connection.count",
             "value":"1"
          },
          {
             "key":"WSO2MBStoreDB.active.connection.count",
             "value":"1"
          }
       ]
    }
```

-   The `active.connection.count` parameter reflects the number of connections that are active.

-   `ConnectivityTime` refers to the duration of the connection.

#### User Store Health Checker

This health checker returns the status of the user stores available in the system. You can configure the user stores to be monitored by adding the following configuration.

```
    [carbon_health_check.health_checker.data_source_health_checker]
    enable =false
    order = 98

    [carbon_health_check.health_checker.super_tenant_health_checker.properties]
    'monitored.user.stores' = "primary" 
```

| **Configuration**                               | **Description**                          |
    | ---------------------------------------------| ------------------------------------ |
    |enable                                        | The configuration element is to enable DataSource Health Checker. When `carbon_health_check` is enabled this config will get enabled by default.  |
    |order                                         | The execution order in which the User Store Health checker is executed. The default value is `98`.|
    |monitored.user.stores                         | This config is used to specify the user stores as comma-separated values. The default value is `PRIMARY`. |


When you invoke the API and User Stores are healthy you can see a response as below:

```
    {
       "health":[
          {
             "key":"PRIMARY.userstore.health",
             "value":"healthy"
          }
       ]
    }
```

### Error responses

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
             "message": "Error while checking the health of USM with domain: SEC",
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
To deploy it, copy the `.jar` file to the `<APIM_HOME>/repository/component/lib/` directory or the OSGI bundle and paste it in the `<APIM_HOME>/repository/component/dropins/` directory.

Then register the new health checker as shown below in the 'deployment.toml' file if needed.

```
    [[health_checker]]
    name = "customChecker" 
    order="87" 
    [health_checker.properties] 
    property1 = "property-1-value"
    property2 = "property-2-value" 
```

!!! tip
    A sample configuration section of `deployment.toml` which is configured to monitor Data sources health checker, User Store Health Checker, and a custom health checker is shown below. 
    
    ```
        [carbon_health_check] 
        enable = true
        
        [carbon_health_check.health_checker.data_source_health_checker]
        enable = true
        pool_usage_limit_percentage = "80"
        order = "97"
    
        [carbon_health_check.health_checker.data_source_health_checker.properties]
        'monitored.datasources' = "jdbc/WSO2CarbonDB,jdbc/WSO2AM_DB,jdbc/SHARED_DB"
        
        [carbon_health_check.health_checker.data_source_health_checker]
        enable =false
        order = 98
    
        [carbon_health_check.health_checker.super_tenant_health_checker.properties]
        'monitored.user.stores' = "primary" 
        
        [[health_checker]] 
        name = "customChecker" 
        order = "87"
        [health_checker.properties] 
        property1 = "property-1-value" 
        property2 = "property-2-value" 
    ```
