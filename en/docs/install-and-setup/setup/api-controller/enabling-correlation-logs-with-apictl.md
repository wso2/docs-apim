# Enabling Correlation Logs with apictl

**WSO2 API Controller (apictl)** allows you to enable/disable correlation logs in WSO2 API Manager (WSO2 API-M) without a server restart. (For more information on correlation logs support in WSO2 API-M, see [Monitoring Correlation Logs]({{base_path}}/observe/api-manager/monitoring-correlation-logs)) 

## Get the correlation logging components in an environment

Follow the instructions below to get the correlation logging components in an environment using apictl:

1.  Make sure that the WSO2 API-M 4.2.0 version is started and that the 4.2.0 version of apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get the correlation logging components in an environment.

    1. Get the correlation logging components in an environment.

        -   **Command**
            ``` bash
            apictl get correlation-logging -e <environment>
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : The environment that the command is executed on  
                -   Optional :  
                    `--format` : pretty-print correlation logging components using Go templates    

            !!! example
                ```bash
                apictl get correlation-logging -e dev 
                ```

        -   **Response**

            ```bash
            COMPONENT_NAME      ENABLED             PROPERTIES
            http                false               -
            jdbc                false               deniedThreads : MessageDeliveryTaskThreadPool, HumanTaskServer, BPELServer, CarbonDeploymentSchedulerThread
            ldap                false               -
            synapse             true                -
            method-calls        false               -

            ```

    !!! Info
        - The `get correlation-logging` command can be executed only with a user who has super admin permissions.


## Set the correlation configs for a correlation logging component in an environment

Follow the instructions below to set the correlation configs for a correlation logging component in an environment using apictl:

1.  Make sure that the WSO2 API-M 4.2.0 version is started and that the 4.2.0 version of apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to set the correlation configs for a correlation logging component in an environment.

    1. Set the correlation configs for a correlation logging component in an environment.

        -   **Command**
            ``` bash
            apictl set correlation-logging --component-name <component-name> --enable <true-or-false> --environment <environment>
            ```
            ``` bash
            apictl set correlation-logging -i <component-name> --enable <true-or-false> -e <environment>
            ```
            ``` bash
            apictl set correlation-logging --component-name <component-name> --enable <true-or-false> --denied-threads <denied-threads> --environment <environment>
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : The environment that the command is executed    
                    `--component-name` or `-i` : Component name  
                    `--enable`  : Enable (can be true or false)    
                -   Optional :  
                    `--denied-threads`  : Denied threads    

            !!! example
                ``` bash
                apictl set correlation-logging --component-name http --enable true -e dev
                ```
                ``` bash
                apictl set correlation-logging --component-name jdbc --enable true --denied-threads MessageDeliveryTaskThreadPool,HumanTaskServer,BPELServer -e dev
                ```

        -   **Response**

            ```bash
            Correlation component http is successfully enabled.
            ```

    !!! Info
        - Supported component name values : `http`, `jdbc`, `ldap`, `synapse` or `method-calls`.
        - Supported values for enable: `true` or `false`.
        - The `set correlation-logging` command can be executed only with a user who has super admin permissions.
