# Importing MCP Servers Via Dev First Approach

**WSO2 API Controller (apictl)** allows you to create and deploy MCP (Model Context Protocol) Servers without using the Publisher Portal of the WSO2 API Manager (WSO2 API-M). You can use this feature to create an MCP Server **using an existing MCP specification** and then deploy it to the desired WSO2 API-M environment.

!!! info
    **Before you begin** 

    -   Make sure that the apictl is downloaded and initialized, if not, follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -   Make sure you already have added an environment using the apictl for the WSO2 API-M environment you plan to import the MCP Server to. 

        If not, follow the steps in [Add an Environment]({{base_path}}/install-and-setup/setup//api-controller/getting-started-with-wso2-api-controller#add-an-environment).

To help you get started quickly, you can set up a sample MCP Server project.

-   **Sample MCP Server Project** - Follow the same folder and file structure as the sample projects below to create your own local directory:
    -   [SampleMCP](https://github.com/wso2/product-apim-tooling/tree/master/import-export-cli/integration/testdata/MCPFromOpenAPI) - For creating an MCP Server from an OpenAPI specification.
    -   [ProxyExistingMCP](https://github.com/wso2/product-apim-tooling/tree/master/import-export-cli/integration/testdata/ProxyExistingMCP) - For proxying an existing MCP Server.

You can use these sample projects as reference for creating your own MCP Server project before importing it to your environment.

## Import an MCP Server project

!!! info
    **Before you begin...** 

    -   Make sure you have already created an environment to which you are planning to import the MCP Server. If not, follow steps in [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).
    
    -   Make sure you have logged-in to the importing environment. If not, follow steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment). 


!!! tip
    A user with `Internal/devops` role or `admin` role are allowed to import MCP Servers. To create a custom user who can import MCP Servers, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

You can import the MCP Server to an environment using any of the following commands.  

-   **Command**
    ``` bash
    apictl import mcp-server -f <path to MCP Server Project> -e <environment> 
    ```
    ``` bash
    apictl import mcp-server --file <path to MCP Server Project> --environment <environment> --rotate-revision
    ```
    ``` bash
    apictl import mcp-server --file <path to MCP Server Project> --environment <environment> --params=<environment params file> 
    ```

    !!! info
        **Flags:**  
           
        -   Required :  
            `--file` or `-f` : The file path of the MCP Server project to import.  
            `--environment` or `-e` : Environment to which the MCP Server should be imported.   
        -   Optional :  
            `--rotate-revision` : If the maximum revision limit reached, delete the oldest revision and create a new revision.  
            `--skip-deployments` : Skip the deployment environments specified in the project and only update the current MCP Server.   
            `--preserve-provider` : Preserve the existing provider of MCP Server after importing. The default value is `true`.   
            `--update` : Update an existing MCP Server or create a new MCP Server in the importing environment.    
            `--params` : Provide a API Manager environment params file. For more information, see [Configuring Environment Specific Parameters]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters).    
            `--skip-cleanup` : Leave all temporary files created in apictl during import process. The default value is `false`.    
    
    !!! note
    **Importing versions of an MCP Server**

        -   When importing versions of an MCP Server, you are not allowed to change the MCP Server provider. 
        -   If the preserve-provider value was set to `true` when importing the initial MCP Server, the value should be set to `true` when importing all its' versions.
        -   If the preserve-provider value was set to `false` when importing the initial MCP Server, the value should be set to `false` when importing all its' versions.

    !!! example
        ```bash
        apictl import mcp-server -f ~/mymcpserver -e production 
        ```
        ```bash
        apictl import mcp-server --file ~/mymcpserver --environment production --rotate-revision
        ```    
        ``` go
        apictl import mcp-server --file ~/mymcpserver --environment production --params prod/params.yaml  
        ```
        
    !!! tip
        When using the `--update` flag with the `import mcp-server` command, apictl will check if the given MCP Server exists in the targeted environment. If the MCP Server exists, it will update the existing MCP Server. If not, it will create a new MCP Server in the imported environment. 
        
    !!! note
        **Changes to the import command with the revision support for MCP Servers**  
        
        - From WSO2 API-M 4.0.0 onwards, you have to create a new revision in order to deploy an MCP Server in a Gateway environment and 
            **only a revision can be deployed in a Gateway environment**. 
        - With the import command of the apictl, if the MCP Server project has specified the deployment environments, the import 
            will first **update the current MCP Server**.
        - If the number of revisions created for that MCP Server **do not exceed the max revision limit of 5**, a new revision
            of that MCP Server will be created and that revision will be deployed in the specified Gateway environments.
        - If the max revision numbers are reached, the imported MCP Server will **only update the current MCP Server** and not be deployed 
            in the specified Gateway environments.
        - You can use the `--rotate-revision` flag with the import command and if the max revision limit is reached, the import
            operation will **delete the earliest revision for that MCP Server and create a new revision**. This new revision will be
            deployed in the specified Gateway environments.

    !!!note
        `apictl import-mcp-server` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl import mcp-server` as shown above.
       
-   **Response**
    ``` bash
    Successfully imported MCP Server!
    ```
