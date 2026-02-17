# Migrating MCP Servers to Different Environments

**WSO2 API Controller (apictl)** allows you to maintain multiple environments running on the same WSO2 API Manager (WSO2 API-M) version. This allows you to import and export MCP Servers between your environments. For example, if you have an MCP Server running in the development environment, you can export it and import it to the production environment. Thereby, MCP Servers do not have to be created from scratch in different environments.

!!! info
    **Before you begin** 

    -   Make sure apictl is initialized and setup, if not follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -  Make sure to add an environment before you start working with the following apictl commands, because all MCP Servers need to be imported or exported to/from a specific environment.      
    For more information, visit [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).

!!! tip
    A user with `Internal/devops` role or `admin` role are allowed to import/export MCP Servers. To create a custom user who can import/export MCP Servers, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

### Export an MCP Server

1.  Log in to the WSO2 API-M in the exporting environment by following steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys or the access-token are (is) already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys or a token exist(s) for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to export an MCP Server as a `.zip` archive.  

    -   **Command**
     
        ```go
        apictl export mcp-server -n <MCP-Server-name> -v <version> --rev <revision-number> -r <provider> -e <environment>  
        ``` 
        ```go
        apictl export mcp-server --name <MCP-Server-name> --version <version> --provider <provider> --environment <environment>  
        ```

        ```go
        apictl export mcp-server -n <MCP-Server-name> -v <version> --rev <revision-number> -r <provider> -e <environment> --preserve-status=<preserve-status> --format <export-format>  
        ``` 

        !!! info
            **Flags:**  
            
            -    Required :  
                `--name` or `-n` : Name of the MCP Server to be exported      
                `--version` or `-v` : Version of the MCP Server to be exported  
                `--environment` or `-e` : Environment from which the MCP Server should be exported  
            -    Optional :   
                `--rev` : Revision Number of the MCP Server. If not provided, working copy of the MCP Server will be exported.     
                `--provider` or `-r` : Provider of the MCP Server.    
                `--preserve-status` : Preserve MCP Server status when exporting. Otherwise, the MCP Server will be exported in the CREATED status. The default value is true.    
                `--latest` : Export the latest revision of the MCP Server.  
                `--format` : File format of exported archive (JSON or YAML). The default value is YAML. 
            
        !!! example
            ```go
            apictl export mcp-server -n ChatGPTServer -v 1.0.0 -e dev 
            ```
            ```go
            apictl export mcp-server -n ModelContextServer -v 1.0.0 --rev 2 -r admin -e production --preserve-status=true --format JSON 
            ```            

    -   **Response**

        === "Response Format"
            ``` bash
            Successfully exported MCP Server!
            Find the exported MCP Server at <USER_HOME>/.wso2apictl/exported/mcp-servers/<envrionment-name>/<MCP-Server-name>_<version>.zip
            ```

        === "Example Response"
            ``` bash
            Successfully exported MCP Server!
            Find the exported MCP Server at /Users/kim/.wso2apictl/exported/mcp-servers/dev/ChatGPTServer_1.0.0.zip
            ```

The exported ZIP file has the following structure:

``` java
<MCPServerName>-version
├── mcp_server.yaml
├── mcp_server_meta.yaml
├── backends.yaml
├── Client-certificates
│   ├── Alias1.crt
│   ├── Alias2.crt
│   └── client_certificates.yaml
├── Definitions
|    └── swagger.yaml
├── Docs
│   ├── Doc1
│   │   ├── document-file.pdf
│   │   └── document.yaml
│   ├── Doc2
│   │   ├── Doc2
│   │   └── document.yaml
│   ├── Doc3
│   │   ├── Doc3
│   │   └── document.yaml
│   └── Doc4
│       └── document.yaml
└── Image
     └── <imageName>.extension 
```

The structure of an exported MCP Server ZIP file is explained below:

<table>
    <thead>
        <tr class="header">
            <th>Sub Directory/File</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd">
            <td><code>mcp_server.yaml</code></td>
            <td>Contains all the basic information required for an MCP Server to be imported to another environment.</td>
        </tr>
        <tr class="even">
            <td><code>mcp_server_meta.yaml</code></td>
            <td>The meta-information file of the source artifact (This includes the name and the version of the MCP Server.).</td>
        </tr>
        <tr class="odd">
            <td><code>backends.yaml</code></td>
            <td>Contains backend configuration information for the MCP Server, including endpoint configurations and API definitions.
            <pre><code>
type: backends
version: v4.6.0
data:
 -
  id: 14366c3a-db8a-4691-b130-6da391228ef4
  name: Default Backend
  endpointConfig: "{\"endpoint_type\":\"http\",\"sandbox_endpoints\":{\"url\":\"https://petstore3.swagger.io/api/v3\"},\"production_endpoints\":{\"url\":\"https://petstore3.swagger.io/api/v3\"}}"
  definition: "{\"openapi\":\"3.0.4\",\"info\":{\"title\":\"Swagger Petstore - OpenAPI 3.0\",\"description\":\"This is a sample Pet Store Server based on the OpenAPI 3.0 specification...\"}}"
            </code></pre>
            </td>
        </tr>
        <tr class="even">
            <td>Client-certificates</td>
            <td>If the MCP Server is secured using MutualSSL, this folder will contain the information related to the MCP Server.
                <ul>
                    <li>
                        <code>client_certificates.yaml</code>: Contains the information such as alias, certificate file name, tier name and the MCP Server Identifier (with the MCP Server name, version which is 1.0.0 by default and the provider name). 
                    </li>
                </ul>
            Apart from the above <code>client_certificates.yaml</code> file, this folder contains the certificate files (.crt). These file names should be included in the  <code>client_certificates.yaml</code> by mapping to the corresponding alias name. Below is an example file for a  <code>client_certificates.yaml</code> file which has mapped the certificates Alias1.crt and Alias2.crt to the corresponding aliases Alias1 and Alias2 accordingly. 
            <pre><code>
type: client_certificates
version: v4.6.0
data:
-
alias: Alias1
certificate: Alias1.crt
tierName: Bronze
mcpServerIdentifier:
    providerName: admin
    mcpServerName: ChatGPTServer
    version: 1.0.0
    id: 0
-
alias: Alias2
certificate: Alias2.crt
tierName: Gold
mcpServerIdentifier:
    providerName: admin
    mcpServerName: ChatGPTServer
    version: 1.0.0
    id: 0
            </code></pre>
            </td>
        </tr>
        <tr class="odd">
            <td>Definitions</td>
            <td> This folder will contain the definition file associated to a particular MCP Server.
                <ul>
                    <li><code>swagger.yaml</code>: It contains the MCP Server specification definition.</li>
                </ul>
            </td>
        </tr>
        <tr class="even">
            <td>Docs</td>
            <td> This folder will contain documentation attached to a particular MCP Server. Each document will have a separate folder by its name. Each folder will contain a file named <code>document.yaml</code> which will contain the meta information related to a document. Example for a <code>document.yaml</code> file is shown below.
            <pre><code>
type: document
version: v4.6.0
data:
  documentId: 7be89b14-6b7c-4e1f-8bee-f72295dd65cb
  name: Doc1
  type: HOWTO
  summary: This is the sample summary
  sourceType: FILE
  fileName: document-file.pdf
  visibility: MCP_SERVER_LEVEL
            </pre></code>
            The above example denotes a document for a <b>FILE</b> named <code>document-file.pdf</code>. The corresponding file will be inside the individual folder of the <b>Docs</b> directory. 
            <br>If the you have attached an <b>INLINE</b> document, the <code>sourceType</code> will be changed to <b>INLINE</b> and the field named <code>fileName</code> will not be available. The inline content of that particular document will be included in the same individual document directory named by the document name (E.g., <code>Doc2</code>).
            <br> Similarly if you have attached a <b>MARKDOWN</b> document, the <code>sourceType</code> will be changed to <b>MARKDOWN</b> and there will not be a field named <code>fileName</code>. The markdown content of that particular document will be included in the same individual document directory named by the document name (E.g., <code>Doc3</code>).
            <br> If the document is just a URL, the <code>sourceType</code> will be changed to <b>URL</b> and a field named <code>sourceURL</code> will be there which will consist the URL of the document.
            </td>
        </tr>
        <tr class="odd">
            <td>Image</td>
            <td>Thumbnail image of the MCP Server.</td>
        </tr>
    </tbody>
</table>

### Import an MCP Server

You can use the MCP Server archive exported from the previous section (or you can extract it and use the extracted folder) and import it to the WSO2 API-M instance in the target environment. When importing the MCP Server, you can either **create the MCP Server as a new MCP Server** or **seamlessly update an existing MCP Server** in the environment with it.
If the MCP Server archive contains information about deployment environments in the `deployment_environments.yaml` file, 
once the MCP Server is successfully created or updated, a **new revision will be created** and that revision will be deployed in the
mentioned gateway environments. If the **deployment environments are not provided, only the working copy will be updated**.  

1.  Log in to the WSO2 API-M in the importing environment by following steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys or the access-token are (is) already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys or a token exist(s) for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to import an MCP Server.

    -   **Command**
        ``` bash
        apictl import mcp-server -f <path-to-MCP-Server-archive> -e <environment>
        ```
        ``` bash
        apictl import mcp-server --file <path-to-MCP-Server-archive> --environment <environment> 
        ```
        ``` bash
        apictl import mcp-server --file <path-to-MCP-Server-archive> --environment <environment> --update-mcp-server=<update_mcp_server> 
        ```
        ``` bash
        apictl import mcp-server --file <path-to-MCP-Server-archive> --environment <environment> --preserve-provider=<preserve_provider> --skip-cleanup=<skip-cleanup> --params <environment-params-file> --rotate-revision
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--file` or `-f` : The file path of the MCP Server to import.  
                `--environment` or `-e` : Environment to which the MCP Server should be imported.  
            -   Optional :  
                `--preserve-provider` : Preserve existing provider of MCP Server after importing. Default value is `true`.  
                `--rotate-revision` : If the maximum revision limit reached, delete the oldest revision and create a new revision.  
                `--skip-deployments` : Skip the deployment environments specified in the project and only update the working copy of the MCP Server.  
                `--update-mcp-server` : Update an existing MCP Server or create a new MCP Server in the importing environment. Default value is `false`.  
                `--params` : Define the API Manager environment params file.  
                `--skip-cleanup` : Leave all temporary files created in the apictl during import process. Default value is `false`.  

        !!! example
            ```bash
            apictl import mcp-server -f dev/ChatGPTServer_1.0.0.zip -e production
            ```
            ```bash
            apictl import mcp-server -f dev/ChatGPTServer_1.0.0.zip -e production --rotate-revision
            ```
            ```bash
            apictl import mcp-server --file /home/user/mcp-servers/ChatGPTServer_1.0.0.zip --environment production 
            ``` 
            ```bash
            apictl import mcp-server --file /home/user/mcp-servers/ChatGPTServer_1.0.0.zip --environment production --rotate-revision
            ``` 
            ```bash
            apictl import mcp-server --file /home/user/mcp-servers/ChatGPTServer_1.0.0.zip --environment production --update-mcp-server=true 
            ```    
            ``` go
            apictl import mcp-server -f dev/ChatGPTServer_1.0.0.zip -e production --preserve-provider=false  
            ```
            ``` go
            apictl import mcp-server -f dev/ChatGPTServer_1.0.0.zip -e production --preserve-provider=false --params dev/mcp_server_params.yaml  
            ```

        !!! tip
            If your file path is `/Users/kim/.wso2apictl/exported/mcp-servers/dev/ChatGPTServer_1.0.0.zip.`, then you need to enter `dev/ChatGPTServer_1.0.0.zip` as the value for `--file` or `-f` flag.

        !!! tip
            When using `--update-mcp-server` flag with `import mcp-server` command, the apictl tool will check if the given MCP Server exists in the targeted environment. If the MCP Server exists, it will update the existing MCP Server. If not, it will create a new MCP Server in the imported environment. 

       
     -   **Response**
        
        ``` bash
        Successfully imported MCP Server!
        ```

    
    !!! note
        **Changes to the import command with the revision support for MCP Servers**  
        
        - From WSO2 API-M 4.0.0 onwards, you have to create a new revision in order to deploy MCP Servers in a 
            gateway environment and **only a revision can be deployed in a gateway environment**.
        - With the import command of the apictl, if the MCP Server project has specified the deployment environments, import 
            will first **update the working copy of the MCP Server**.
        - If the number of revisions created for that MCP Server **does not exceed the max revision limit of 5**, a new revision
            of that MCP Server will be created and that revision will be deployed in the specified gateway environments.
        - If the max revision numbers is reached, imported MCP Server will **only update the working copy** and not be deployed 
            in the specified gateway environments.
        - You can use `--rotate-revision` flag with the import command and if the max revision limit reached, import
            operation will **delete the earliest revision for that MCP Server and create a new revision**. This new revision will be
            deployed in the specified gateway environments.  
            

    !!! note
        **Preserving Provider while Importing MCP Server**  

        The `--preserve-provider` flag is used to decide whether to keep the actual provider as the provider of the MCP Server or change the provider to the user who is importing the MCP Server to a different environment.  

        As an example, If `--preserve-provider` is set to `true`, when importing an MCP Server created by user-1 in environment-1 will be preserved with user-1 as the provider when and after importing that MCP Server to environment-2 by user-2. If `--preserve-provider` is set to `false`, when importing that MCP Server created by user-1 to the environment-2, the provider will be changed (not preserved) to user-2 who is importing the MCP Server.

        !!! tip
            You must add the flag `--preserve-provider` to the apictl command and set its value to `false` if the MCP Server is imported to a different domain than its exported one. So it sets the provider of the imported MCP Server to the user who is issuing the apictl command. 

!!! note
    **Configuring Environment Specific Parameters**

    When the importing and exporting environments are different, before importing the MCP Server, you may need to update the exported MCP Server with details relevant to the importing environment. For example, the subscription policies, MutualSSL certificates and deployment environments of an MCP Server might differ between the dev and production environments. Furthermore, the production and sandbox URLs, the timeout configurations, the backend certificates of your endpoints might differ between environments as well. To allow easily configuring environment-specific details, by default apictl supports an additional parameter file. For more information on using an environment parameter file for MCP Servers, see [Defining the params file for an MCP Server]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#defining-the-params-file-for-an-mcp-server).

    **Add dynamic data to environment configs**

    The above parameter file supports detecting environment variables during the MCP Server import process. For more information on using dynamic data, see [Add dynamic data to environment configs]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/using-dynamic-data-in-api-controller-projects/#add-dynamic-data-to-environment-configs).

!!! info
    Tiers are provider-specific. If an exported tier is not already available in the importing environment, that tier is not added to the new environment.

!!! tip
    **Troubleshooting**  
        
    After importing, if the MCP Servers are not visible in the WSO2 API-M Publisher UI, do the following to re-index the artifacts in the registry.

    1.  Shut down the WSO2 API-M, backup and delete the `<API-M_HOME>/solr` directory.
        
    2.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_HOME>/repository/conf/registry.xml` file. If you use a **distributed WSO2 API-M setup**, change the file in the API Publisher node. For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1 `

    3.  Restart WSO2 API-M server.

### Import/Export MCP Servers in tenanted environments 
The environments that you create will be common to the admin and the tenants. Therefore, you do not need to create environments again when exporting and importing MCP Servers between tenanted environments.

!!! warning
    When exporting and importing an MCP Server across tenanted environments, the `--preserve-provider` flag value should be set to `false` as the original provider username in the exporting environment does not exist in the importing environment.
