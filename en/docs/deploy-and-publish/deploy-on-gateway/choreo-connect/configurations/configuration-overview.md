# Configurations

The following are the Choreo Connect related configuration files.

| **File** | **Description** |
|---------------|---------------------|
| Configuration File </br> E.g. `config.toml` | This file defines all the adapter, enforcer, router, security, control plane and analytics configurations.     | 
| Log Configuration File </br> E.g. `log_config.toml` | This file defines the logging configurations for the Adapter and Router.  | 
| Log4j2 Configuration File </br> E.g. `log4j2.properties` | This file defines the logging configurations for the Enforcer.  |

Each of the above files can be found in the locations given below depending on the Choreo Connect deployment.

??? info "**For Docker Compose**"

    | **File** | **File Name** |
    |----------|---------------|
    | Configuration File   | `config.toml` |
    | Log Configuration File  | `log_config.toml` |
    | Log4j2 Configuration File  | `log4j2.properties` |

    | **Mode** | **Directory (File path)** |
    |----------|---------------------------|
    | [Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/) | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf` |
    | [Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/) |  `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf` |

??? info "**For Kubernetes**"

    | **File**                |   **File Name**    |
    |-------------------------|--------------------|
    | Configuration File      | For [Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/), <ul><li> `config-toml-configmap.yaml`</li></ul>   For [Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/), <ul><li> `config-toml-configmap-for-eventhub.yaml`</li></ul> |
    | Log Configuration File  | `logconfig-toml-configmap.yaml` |
    | Log4j2 Configuration File      | `log4j2-configmap.yaml` |

    | **Mode** | **Directory (File path)** |
    |----------|---------------------------|
    | [Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/) | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect` |
    | [Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/) | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/choreo-connect` |

??? info "**For Kubernetes with Helm Charts**"

    You may update the configurations in the following ways, when deploying with Helm Charts and the resources from the [Choreo Connect Helm Chart Git repository](https://github.com/wso2/kubernetes-microgateway/tree/{{choreo_connect.helm_chart.git_tag}}/helm/choreo-connect). 

    - By updating [values.yaml](https://github.com/wso2/kubernetes-microgateway/blob/{{choreo_connect.helm_chart.git_tag}}/helm/choreo-connect/values.yaml). [Click here for the steps.](https://apim.docs.wso2.com/en/latest/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-kubernetes-with-apim-as-control-plane-helm-artifacts/#step-2-update-the-deployment-configurations)
    - By using --set with the Helm command. [Click here for an example.](https://apim.docs.wso2.com/en/latest/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-kubernetes-with-apim-as-control-plane-helm-artifacts/#step-2-install-chart)

    You can find the [complete list of parameters here](https://github.com/wso2/kubernetes-microgateway/blob/master/helm/choreo-connect/README.md#configuration).

    These configuration parameters are based on the [templates available in here](https://github.com/wso2/kubernetes-microgateway/tree/{{choreo_connect.helm_chart.git_tag}}/helm/choreo-connect/templates). The `values.yaml` file and the templates are common to both of the modes, [Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/) and [Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/). The mode itself can be updated as given below.

    ```
    wso2:
      deployment:
        mode: "APIM_AS_CP"
    ```

    ```
    wso2:
      deployment:
        mode: "STANDALONE"
    ```

    You may find the template file for the main Choreo Connect configuration and logging in the following names.

    | **File** | **File Name** |
    |----------|---------------|
    | Configuration File   | `config-toml-configmap.yaml` |
    | Log Configuration File  | `logconfig-toml-configmap.yaml` |
    | Log4j2 Configuration File  | `enforcer-log4j2-configmap.yaml` |


    If you have advanced configurations that are not templated, you can have your own templated configuration file and set it in the Helm Chart as follows. Make sure to include the templates already provided within the default templated configuration files, otherwise you may lose configurations set with the values.yaml file.

    ```    
    --set-file wso2.deployment.adapter.configToml=<FILE_PATH_FOR_TEMPLATED_CONFIG_TOML>
    --set-file wso2.deployment.adapter.logConfigToml=<FILE_PATH_FOR_TEMPLATED_LOG_CONFIG_TOML>
    ``` 


## Configurations Overview

Only the Adapter component reads the ***Configuration File***. Then the Enforcer and Router components fetches the relevant configurations via XDS caches. 

!!! note

    The Enforcer component fetches the relevant configurations only once from the Adapter in its lifetime. If the Adapter is restarted with a configuration change which contains changes related to Enforcer, the Enforcer also needs to be restarted again.


## Overriding configuration values with environment variables

The configurations provided within the ***Configuration File*** can be overridden with environment variables. As this file is processed within Adapter first, the environment variables should be assigned
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
