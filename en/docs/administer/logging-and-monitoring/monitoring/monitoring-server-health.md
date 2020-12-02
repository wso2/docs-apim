# Monitoring Server Health

**Health Check API** is used to validate and verify the status of the API-M server and its dependencies. It is a REST service that returns the operational status, performance information of the configured endpoints with appropriate HTTP return code and a JSON object. There are two health checkers available by default:

-  **Data Sources Health Checker** - This checker goes through the data sources that are configured in the `<API-M_HOME>/repository/conf/deployment.toml` file and checks if the active connection count surpasses a healthy percentage limit (e.g., 80%) of the maximum allowed connections count. This checker also tests the connection from each data source to see whether the connection is successful.
-  **User Store Health Checker** - This checker iterates through configured user stores of the super tenant domain and attempts to invoke the `isExistingUser` method to check whether a failure occurs.

!!! note
    This API is only supported for WSO2 API Manager that runs on Java 8 or a later version.

## Enabling health checkers

### Step 1 - Deploy the health checker

This section guides you through deploying the Carbon Health Check components in WSO2 API Manager

1. Fork the following GitHub repository.

     `https://github.com/wso2/carbon-health-check`
     
2. Navigate to the place where you want to clone the repo and clone the forked repository.

     The forked repository is referred to as `<HEALTH_CHECK_HOME>` in this document. 

     `git clone https://github.com/[git-username]/carbon-health-check`
   
3. Navigate to `<HEALTH_CHECK_HOME>` and build the product.
    
      `mvn clean install`
      
4. Rename `org.wso2.carbon.healthcheck.api.core-<version-number>-SNAPSHOT.jar`, which is found in the `<HEALTH_CHECK_HOME>/components/org.wso2.carbon.healthcheck.api.core/target` directory, as `org.wso2.carbon.healthcheck.api.core-<version-number>.jar` and paste it in the `<API-M_HOME>/repository/components/dropins` directory.

5. Copy the webapp `api#health-check#v1.0.war`, which is found in the `<HEALTH_CHECK_HOME>/components/org.wso2.carbon.healthcheck.api.endpoint/target/` directory and paste it in the `<API-M_HOME>/repository/deployment/server/webapps` directory.

### Step 2 - Configure the health checker global configurations

1. Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` configuration file.

2. Enable the health checker.
    
     Add the following global configuration to enable the DataSource Health Checker and the User Store Health Checker.
    
    ```
    [carbon_health_check]
    enable = true
    ```

### Step 3 - Optionally, update the health checker specific configurations

!!! note
    This step is only needed if you wish to change the default values for the health checkers.

The properties configured under each health checker will be available for each health checker at runtime.

#### Step 3.1 - Optionally, configure the User Store Health Checker

!!! note
    Skip this step if you wish to use the default values for the User Store Health Checker.

This health checker returns the status of the user stores available in the system. You can configure the user stores to be monitored by adding the following configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file.

```
[carbon_health_check.health_checker.data_source_health_checker]
enable =false
order = 98

[carbon_health_check.health_checker.super_tenant_health_checker.properties]
'monitored.user.stores' = "primary" 
```

| **Configuration**                               | **Description**                          |
| ---------------------------------------------| ------------------------------------ |
| enable                                        | The configuration element is to enable DataSource Health Checker. When `carbon_health_check` is enabled this config will get enabled by default.  |
| order                                         | The execution order in which the User Store Health Checker is executed. The default value is `98`. The lowest value is given priority. |
| monitored.user.stores                         | This config is used to specify the user stores as comma-separated values. The default value is `PRIMARY`. |

!!! example "Response"
    When you invoke the API and the User Stores are healthy, you can see a response similar to the following:

    ``` java
    {
        "health":[
            {
                "key":"PRIMARY.userstore.health",
                "value":"healthy"
            }
        ]
    }
    ```

#### Step 3.2 - Optionally, configure the DataSource Health Checker

!!! note
    Skip this step if you wish to use the default values for the DataSource Health Checker.

This health checker returns the status of the data sources available in the system.

To indicate the data source connection pool usage and specify the order, add the following configurations to the `<API-M_HOME>/repository/conf/deployment.toml` file.

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
| enable                                        | The configuration element is to enable DataSource Health Checker. When `carbon_health_check` is enabled this config will get enabled by default.  |
| pool_usage_limit_percentage                   | This config is used to specify a healthy percentage limit of the maximum allowed connections count. The Data Health Checker checks if the active connection count surpasses the given healthy percentage limit. The default value is `80`. |
| order                                         | The execution order in which the DataSource Health Checker is executed. The default value is `97`.|
| monitored.datasources                         | This configuration is used to specify the Data Sources to be monitored as comma-separated values.|

!!! example "Response"
    When you invoke the API and the User Stores are healthy, you can see a response similar to the following:

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

### Step 4 - Invoke the health checker API

1. Start WSO2 API Manager.

2. Send a GET request to the health check API. 

     A sample cURL command is shown below.

    ``` java
    curl -k -v https://{hostname}:{port}/api/health-check/v1.0/health
    ```

## Adding a custom health checker

Follow the instructions below to add a custom health checker:

1. Add a new custom health checker.

    You can use the WSO2 [carbon-health-check repo](https://github.com/wso2/carbon-health-check) to implement your custom health checkers.

    Follow the instructions below to extend the base classes of current health checker implementation and formulate a logic.

    1. Extend the [HealthChecker method](https://github.com/wso2/carbon-health-check/blob/3f8e1cc064acc56e15c28e4d692edd10fda7eac2/components/org.wso2.carbon.healthcheck.api.core/src/main/java/org/wso2/carbon/healthcheck/api/core/HealthChecker) to write your custom health checker.

    2. Write your logic for that implementation in the `checkHealth()` method.

    3. Register your custom health checker as an OSGi component in the [HealthMonitorServiceComponent.java](https://github.com/wso2/carbon-health-check/blob/3f8e1cc064acc56e15c28e4d692edd10fda7eac2/components/org.wso2.carbon.healthcheck.api.core/src/main/java/org/wso2/carbon/healthcheck/api/core/internal/HealthMonitorServiceComponent.java) file.

2. Deploy the health checker using one of the following methods.
     
     - If you are working with a JAR, copy the `.jar` file to the `<API-M_HOME>/repository/component/lib/` directory.
     - If you are working with an OSGI bundle, paste it in the `<API-M_HOME>/repository/component/dropins/` directory.

3. Register the new health checker as shown below in the `deployment.toml` file.

    ```
    [[health_checker]]
    name = "customChecker" 
    order="87" 
    [health_checker.properties] 
    property1 = "property-1-value"
    property2 = "property-2-value" 
    ```

!!! example "Sample configuration"
    A sample configuration section of the `deployment.toml` file, which is configured to monitor the DataSources Health Checker, User Store Health Checker, and a custom health checker is shown below. 
    
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

## Error responses

The following responses are possible error responses that you may receive when monitoring the health of the server.

!!! Example
    The code block below shows a sample **503 Unavailable** response with an array of errors.

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
                "description":"Access denied for user 'root'@'localhost' (using password: YES)"
            }
        ]
    }
    ```

| **Error Code** | **Description**                                                                                                       |
|------------|-------------------------------------------------------------------------------------------------------------------|
| HC\_00001  | Data source connectivity error.                                                                                   |
| HC\_00002  | Number of connections in data source exceeds the healthy percentage.                                              |
| HC\_00003  | Error while testing connectivity to the user store using the `isExistingUser` operation. |
| HC\_00004  | Server status is not running. |
| HC\_00005  | Error listing user stores. |
