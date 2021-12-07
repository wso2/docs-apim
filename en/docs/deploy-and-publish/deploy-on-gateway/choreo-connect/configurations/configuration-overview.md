# Configurations

The following are the Choreo Connect related configuration files.

| **File name**            | **Description**                                                                                              | **Directory (File path)**                                              |
|--------------------------|--------------------------------------------------------------------------------------------------------------|----------------------------------------------------------- |
| `config.toml`            | This file defines all the adapter, enforcer, router, security, control plane and analytics configurations.   | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf` |
| `log_config.toml`        | This file defines the logging configurations for control plane.                                              | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf` |
| `log4j2.properties`      | This file governs how logging is performed by the server.                                                    | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf` |


## Configurations Overview

Only the Adapter component reads the `config.toml` file. Then the Enforcer and Router components fetches the relevant configurations via XDS caches. 

!!! note

    The Enforcer component fetches the relevant configurations only once from the Adapter in its lifetime. If the Adapter is restarted with a configuration change which contains changes related to Enforcer, the Enforcer also needs to be restarted again.


## Overriding configuration values with environment variables

The configurations provided within `config.toml` can be overridden with environment variables. As 
the `config.toml` file is processed within Adapter first, the environment variables should be assigned
to the Adapter environment. The variables are case-insensitive.

- To override a configuration value like the following, the user needs to declare the environment variable
`CC_Adapter_Server_Port`. The value could be a boolean, a float, a string or an integer value.

    ```
    [Adapter]
    [Adapter.Server]
    Port = 9843
    ```

    To change the above configuration, the following environment variable needs to be assigned.

    ```
    CC_Adapter_Server_Port=9844
    ```

- If the property to be overridden is a property of an array, the array index should also be appended to the 
environment variable. (Index will depend on the order you define in the .toml file).

    ```
    [[Adapter.Server.Users]]
    username = "John"
    ```

    To change the above configuration, the following environment variable needs to be assigned.

    ```
    CC_Adapter_Server_Users_0_Username=Ann
    ```


- If the TOML key contains a dot, those characters should be replaced with underscore for the relevant 
environment variable.

    ```
    [analytics.enforcer.configProperties]
        "publisher.reporter.class" = "org.wso2.choreo.connect.tests.CustomMetricReporter"
    ```            

    To change the above configuration, the following environment variable needs to be assigned.

    ```
    CC_Analytics_Enforcer_ConfigProperties_Publisher_Reporter_Class="org.example.CustomMetricReporter"
    ```

- If the value of the configuration is a string, float, or an integer array, those values needs to be provided as
a single string where the values are separated with a comma. 

    ```
    [category]
    stringArray = ["foo"]
    ```

    You need to execute the following command to override the above configuration.

    ```
    CC_Category_StringArray="foo, bar"
    ```


## Resolving configuration values from the environment using the $env{variable} assignment

In addition to the previously mentioned approach, the choreo-connect configuration values can be resolved via the environment by assigning the property with the value "$env{variable_name}". For example, see the following code snippet.

```
 [enforcer.throttling.publisher]
    username = "admin"
    password = "$env{tm_admin_pwd}"
```    

In this case, the resolution of the `env_variable` is different compared to previous approach. The Enforcer environment variables are used to resolve the `enforcer` and `analytics.enforcer` configurations. For other configurations, the environment variable assignment should happen in the Adapter environment.

For the above example, the user should assign the environment variable `tm_admin_pwd` to the Enforcer.

```
tm_admin_pwd=passwd
```

!!! Note

    The environment variable is case-sensitive here.
    

!!! Note

    This approach can be used only if the configuration property is a String. 
