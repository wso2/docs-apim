# Managing MCP Servers

## Add MCP Servers in an environment

You can add MCP Servers via the Publisher Portal.
However, **WSO2 API Controller (apictl)** allows you to create and deploy MCP Servers without using the Publisher Portal. For more information on adding MCP Servers, see [Importing MCP Servers Via Dev First Approach]({{base_path}}/install-and-setup/setup/api-controller/managing-mcp-servers/importing-mcp-servers-via-dev-first-approach).

## Get MCP Servers in an environment

Follow the instructions below to display a list of MCP Servers in an environment using apictl:

1.  Make sure that the WSO2 API Manager is started and the apictl is set up.   
     For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get (list) MCP Servers in an environment.

    -   **Command**
        ``` bash
        apictl get mcp-servers -e <environment>
        ```
        ``` bash
        apictl get mcp-servers --environment <environment>
        ```
        ``` bash
        apictl get mcp-servers --environment <environment> --query <MCP Server search query>
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : Environment to be searched  
            -   Optional :  
                `--query` or `-q` : Search query pattern  
                `--limit` or `-l` : Maximum number of MCP Servers to return
                `--format` : pretty-print MCP Servers using Go templates

        !!! example
            ```bash
            apictl get mcp-servers -e dev 
            ```
            ```bash
            apictl get mcp-servers --environment production 
            ```    
            ```go
            apictl get mcp-servers --environment production --query provider:Alice name:ChatGPTServer context:"/chatgpt" --limit 25 
            ```  

    -   **Response**

        ```go
        ID                                     NAME                  VERSION        CONTEXT              STATUS              PROVIDER
        c39e08d7-caa9-40d0-a430-b8e840dd7c31   ChatGPTServer         1.0.0          /chatgpt             PUBLISHED           admin
        cb422af2-b19e-4e6a-a34b-8f45c50db0d5   ClaudeServer          2.1.0          /claude              PUBLISHED           Alice
        ```

## Get all revisions created for an MCP Server in an environment

Follow the instructions below to display a list of revisions created for an MCP Server in an environment using apictl:

1.  Make sure that the WSO2 API-M is started and the apictl is set up.   
     For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get (list) revisions for the required MCP Server in an environment.

    -   **Command**
        ``` bash
        apictl get mcp-server-revisions -n <MCP-Server-name> -v <version> -e <environment> 
        ```
        ``` bash
        apictl get mcp-server-revisions --name <MCP-Server-name> --version <version> --environment <environment>
        ```
        ``` bash
        apictl get mcp-server-revisions --name <MCP-Server-name> --version <version> --provider <provider> --environment <environment> --query <deployment-search-query>
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--name` or `-n` : Name of the MCP Server to get the revisions 
                `--version` or `-v` : Version of the MCP Server to get the revisions    
                `--environment` or `-e` : Environment to be searched  
            -   Optional :  
                `--provider` or `-r` : Provider of the MCP Server
                `--query` or `-q` : Search query pattern  
                `--format` : pretty-print MCP Server revisions using Go templates

        !!! example
            ```bash
            apictl get mcp-server-revisions -n ChatGPTServer -v 1.0.0 -e dev 
            ```
            ```bash
            apictl get mcp-server-revisions --name ChatGPTServer --version 1.0.0 --environment production
            ```    
            ```go
            apictl get mcp-server-revisions -n ChatGPTServer -v 1.0.0 -q deployed:true -e dev 
            ```  

    -   **Response**

        ```go
        ID                                     REVISION            DESCRIPTION         GATEWAY_ENVS
        86ae2e4f-59b4-45a8-8693-0edb64a7fd6a   1                   Initial Revision    [Default Label1]
        cbabfcca-7e53-4d9a-b07b-e5fc67768e0e   2                   Updated endpoints   [Label2 Label3]
        ```

!!! note
    When using the `get mcp-server-revisions` command, `-q` or `--query` optional 
    flag can be used to filter out the revisions based on whether they are deployed in a gateway environment or not.
    ```--query deployed:true``` can be used to filter out the revisions that are already deployed in at least one
    gateway environment. Without the ```query``` flag, revisions will be displayed irrespective of the deployment.

!!! note
    Output of the `get mcp-server-revisions` command can be formatted with Go Templates. For more information on formatting the get commands, see [Formatting the outputs of get commands]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/formatting-the-output-of-get-command).

## Delete an MCP Server in an environment

Follow the instructions below to delete an MCP Server in an environment using apictl:

1.  Make sure that the WSO2 API-M is started and the apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to delete an MCP Server in an environment.

    -   **Command**
        ``` bash
        apictl delete mcp-server -n <MCP Server name> -v <MCP Server version> -e <environment> 
        ```
        ``` bash
        apictl delete mcp-server --name <MCP Server name> --version <MCP Server version> --environment <environment> 
        ```
        ``` bash
        apictl delete mcp-server --name <MCP Server name> --version <MCP Server version> --environment <environment> --provider <MCP Server provider> 
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : Environment from which the MCP Server should be deleted  
                `--name` or `-n` : Name of the MCP Server to be deleted   
                `--version` or `-v` : Version of the MCP Server to be deleted  
            -   Optional :  
                `--provider` or `-r` : Provider of the MCP Server to be deleted  

        !!! example
            ```bash
            apictl delete mcp-server -n ChatGPTServer -v 1.0.0 -e dev 
            ```
            ```bash
            apictl delete mcp-server --name ChatGPTServer --version 1.0.0 --environment production 
            ```    
            ```go
            apictl delete mcp-server --name ChatGPTServer --version 1.0.0 --environment production --provider Alice 
            ```  

    -   **Response**

        ```go
        ChatGPTServer MCP Server deleted successfully!
        ```

## Change status of an MCP Server in an environment

Follow the instructions below to change the status of an MCP Server in an environment using apictl:

1.  Make sure that the WSO2 API-M is started and the apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to change the status of an MCP Server in an environment.

    -   **Command**
        ``` bash
        apictl change-status mcp-server -a <Action> -n <MCP Server name> -v <MCP Server version> -e <environment> 
        ```
        ``` bash
        apictl change-status mcp-server --action <Action> --name <MCP Server name> --version <MCP Server version> --environment <environment> 
        ```
        ``` bash
        apictl change-status mcp-server --action <Action> --name <MCP Server name> --version <MCP Server version> --environment <environment> --provider <MCP Server provider> 
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : The environment that the command is executed on  
                `--name` or `-n` : The name of the respective MCP Server   
                `--version` or `-v` : The version of the respective MCP Server   
                `--action` or `-a` : The action to be taken to change the status of the MCP Server
            -   Optional :  
                `--provider` or `-r` : The provider of the respective MCP Server 

        !!! example
            ```bash
            apictl change-status mcp-server -a Publish -n ChatGPTServer -v 1.0.0 -e dev 
            ```
            ```bash
            apictl change-status mcp-server --action "Publish" --name ChatGPTServer --version 1.0.0 --environment production 
            ```    
            ```go
            apictl change-status mcp-server --action "Demote to Created" --name ChatGPTServer --version 1.0.0 --environment production --provider Alice 
            ```  

    -   **Response**

        ```go
        MCP Server state changed successfully!
        ```

!!! Info
    Supported action values : `Publish`, `Deploy as a Prototype`, `Demote to Created`, `Demote to Prototyped`, `Block`, `Deprecate`, `Re-Publish`, `Retire`.
    Note that the `Re-Publish` action is available only after calling Block action.

## Undeploy a revision of an MCP Server from all or specific deployment environments

Follow the instructions below to undeploy a revision of an MCP Server from a selected gateway environment using apictl:

1.  Make sure that the WSO2 API-M is started and the apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to undeploy the revision from a gateway environment.

    -   **Command**
        ``` bash
        apictl undeploy mcp-server -n <MCP Server name> -v <MCP Server version> --rev <Revision number> -e <environment>
        ```
        ``` bash
        apictl undeploy mcp-server -n <MCP Server name> -v <MCP Server version> --rev <Revision number> -g <gateway environment> -e <environment> 
        ```
        ``` bash
        apictl undeploy mcp-server --name <MCP Server name> --version <MCP Server version> --rev <Revision number> --environment <environment> --provider <MCP Server provider>   
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : The environment that the command is executed on   
                `--name` or `-n` : The name of the respective MCP Server    
                `--version` or `-v` : The version of the respective MCP Server  
                `--rev`  : Revision number of the respective MCP Server   
            -   Optional :  
                `--provider` or `-r` : The provider of the respective MCP Server    
                `--gateway-env` or `-g` : The gateway environment which the revisions needs to be undeployed    
           
        !!! example
            ```bash
            apictl undeploy mcp-server -n ChatGPTServer -v 1.0.0 --rev 1 -e dev 
            ```
            ```bash
            apictl undeploy mcp-server -n ChatGPTServer -v 1.0.0  --rev 2 -g Label1 -g Label2 -g Label3 -e production 
            ```    
            ```go
            apictl undeploy mcp-server --name ChatGPTServer --version 1.0.0 --provider Alice --rev 3 --gateway-env Label1 --gateway-env Default --environment production 
            ```  
     
    -   **Response**

        ```go
        Revision 2 of MCP Server ChatGPTServer successfully undeployed from the specified gateway environments
        ```

!!! Info
    - If ```--gateway-env``` or ```-g``` flag not provided, revision will be undeployed from all the gateway environments it is already deployed.
    - If there are multiple gateway environments, provide them one by one by specifying the flag ```--gateway-env``` or ```-g```. If a label has more than one words,
    wrap the entire label name with quotes.

## Get the log level of MCP Servers or an MCP Server in an environment

Follow the instructions below to get the logging details of MCP Servers or an MCP Server in an environment using apictl:

1.  Make sure that the WSO2 API-M is started and the apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get the logging details of MCP Servers or an MCP Server in an environment.

    -   **Command**
        ``` bash
        apictl get mcp-server-logging -e <environment>
        ```
        ``` bash
        apictl get mcp-server-logging -e <environment> --tenant-domain <tenant domain> 
        ```
        ``` bash
        apictl get mcp-server-logging --environment <environment> --tenant-domain <tenant domain> 
        ```
        ``` bash
        apictl get mcp-server-logging  -e <environment> --mcp-server-id <mcp-server-id> 
        ```
        ``` bash
        apictl get mcp-server-logging  -e <environment> --mcp-server-id <mcp-server-id> --tenant-domain <tenant domain> 
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : The environment that the command is executed on  
            -   Optional :  
                `--tenant-domain` : The tenant domain which you need to get the logging details of MCP Servers or an MCP Server. If the flag is not provided, carbon.super will be used as the default value when executing the command    
                `--mcp-server-id` : The UUID of the MCP Server which you need to get the logging details

        !!! example
            ```bash
            apictl get mcp-server-logging -e dev 
            ```
            ``` bash
            apictl get mcp-server-logging -e dev --tenant-domain wso2.com
            ```
            ``` bash
            apictl get mcp-server-logging --environment dev --tenant-domain wso2.com
            ```
            ``` bash
            apictl get mcp-server-logging  -e dev --mcp-server-id Bf36ca3a-0332-49ba-abce-e9992228ae06 
            ```
            ``` bash
            apictl get mcp-server-logging  -e dev --mcp-server-id Bf36ca3a-0332-49ba-abce-e9992228ae06 --tenant-domain wso2.com 
            ```   

    -   **Response**

        ```go
        MCP_SERVER_ID 	                         MCP_SERVER_CONTEXT         	LOG_LEVEL
        Bf36ca3a-0332-49ba-abce-e9992228ae06     chatgpt/1.0.0	            FULL
        Af66fa7a-0546-49ba-adfe-a8976522ea96     claude/1.1.0	            BASIC
        ```

!!! Info
    - The `get mcp-server-logging` command can be executed only with a user who has super admin permissions.
    - Use the tenant-domain flag to get the logging details of the MCP Servers in another tenant other than carbon.super tenant while you are logged in as a super admin user.

## Set the log level of an MCP Server in an environment

Follow the instructions below to add/change/remove the log level of an MCP Server in an environment using apictl:

1.  Make sure that the WSO2 API-M is started and the apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to set the log level of an MCP Server in an environment.

    -   **Command**
        ``` bash
        apictl set mcp-server-logging --mcp-server-id <mcp-server-id> --log-level <log level> --environment <environment>
        ```
        ``` bash
        apictl set mcp-server-logging --mcp-server-id <mcp-server-id> --log-level <log level> -e <environment>
        ```
        ``` bash
        apictl set mcp-server-logging --mcp-server-id <mcp-server-id> --log-level <log level> --environment <environment> --tenant-domain <tenant domain> 
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : The environment that the command is executed    
                `--log-level`  : The log level of the MCP Server which you need to add/change/remove  
                `--mcp-server-id`  : The UUID of the MCP Server which you need to add/change/remove the log level
            -   Optional :  
                `--tenant-domain` : The tenant domain which you need to add/change/remove the log level of an MCP Server. If the flag is not provided, carbon.super will be used as the default value when executing the command

        !!! example
            ``` bash
            apictl set mcp-server-logging --mcp-server-id Bf36ca3a-0332-49ba-abce-e9992228ae06 --log-level full --environment dev
            ```
            ``` bash
            apictl set mcp-server-logging --mcp-server-id Bf36ca3a-0332-49ba-abce-e9992228ae06 --log-level full -e dev
            ```
            ``` bash
            apictl set mcp-server-logging --mcp-server-id Bf36ca3a-0332-49ba-abce-e9992228ae06 --log-level full --environment dev --tenant-domain wso2.com 
            ```   

    -   **Response**

        ```go
        Log level FULL is successfully set to the MCP Server.
        ```

!!! Info
    - Supported log-level values : `FULL`, `BASIC`, `STANDARD`, `OFF`.
    - When you need to disable logging for an MCP Server, set the log level to OFF.
