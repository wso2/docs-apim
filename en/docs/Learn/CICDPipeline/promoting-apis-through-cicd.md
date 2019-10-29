# Promoting APIs Through CI/CD

WSO2 API Manager provides a clean and elegant solution to address automating API deployment. It automates from environment migration to lifecycle management and solves many issues regarding the manual process.

As shown in the above diagram, the pipeline could be integrated with any existing version control system and to support any available CI/CD automation server. The pipeline was designed to be flexible and provides maximum productivity for developers.

Although the diagram shows three parties, there could be more or less, depending on the organization’s structure.

-   API Developers: Develop APIs and related services
-   API Publishers: Publish APIs to users
-   DevOps: Control the deployment process

API Developers and Publishers work with a version control system, which acts as a single source of truth for the pipeline. API Developers can use WSO2 API Manager Publisher to create APIs. To continue with developed CI/CD APIs, they need to be accessible from a version control system.

WSO2 API Manager provides the following two approaches for organizations to select when promoting APIs through a CI/CD pipeline.

-   [Initializing API Projects and Promoting APIs](#) 
-   [Migrating APIs to Different Environments](#)

### Initializing API Projects and Promoting APIs

WSO2 API Manager’s CLI tool, **apimctl** allows to create and deploy APIs without using WSO2 API Publisher Portal. You
can use this feature to **create an API from scratch** or **using an existing Swagger or Open API specification** of your API and deploy it to the desired API Manager environment.

### Migrating APIs to Different Environments

WSO2 API Manager’s CLI tool, **apimctl** allows you to maintain multiple environments running on the same WSO2 API-M version. This allows you to import and export APIs between your environments. For example, if you have an API running in the development environment, you can import it and export to the test(QA) environment. Thereby, APIs do not have to be created from scratch in different environments.

-   [Exporting an API](#PromotingAPIsThroughCICD-ExportinganAPI)
-   [Importing an API](#PromotingAPIsThroughCICD-ImportinganAPI)
-   [Importing/Exporting an API in a Tenanted Environment](#PromotingAPIsThroughCICD-Importing/exportinganAPIinatenantedenvironment)

!!! warning
    When running the CLI tool, make sure to add an environment before you start working with the following CLI commands, because all APIs and applications need to be imported or exported to/from a specific environment.  
    For more information, visit [Adding an Environment](#)

#### Exporting an API

1.  Make sure that WSO2 API Manager is started and the CLI tool is running.   
For more information on running the CLI tool, visit [Downloading and Initializing the CLI Tool](#) 

    !!! tip
        If you have already logged-in with the same credentials for the environment, and if those keys exist in `$HOME/.wso2apictl/keys.json`, you can skip the following **step 2**.

2.  Login to the API Manager in exporting environment by following steps in [Login into an Environment](#)

    !!! info
        If you do not login and if no keys exist for the environment in `$HOME/.wso2apictl/keys.json`, you will prompt to login to the enviroment when running the command in **step 3**.

3.  Run the following CLI command to export an existing API as a `.zip` archive.

    -   **Command**
     
        ```go
        apictl export-api -n <API-name> -v <version> -r <provider> -e <environment> -k 
        ``` 

        !!! info
            **Flags:**  
            
            -    Required :  
                `--name` or `-n` : Name of the API to be exported  
                `--version` or `-v` : Version of the API to be exported  
                `--provider` or `-r` : Provider of the API         
                `--environment` or `-e` : Environment to which the API should be exported  
            -   Optional :  
                `--preserveStatus` : Preserve API status when exporting. Otherwise API will be exported in CREATED status. Default value is true  
                `--format` : File format of exported archive (JSON or YAML) . Default value is YAML.

        !!! example
            ```go
            apictl export-api -n PhoneVerification -v 1.0.0 -r admin -e dev -k
            ```
            ```go
            apictl export-api -n PizzaShackAPI -v 1.0.0 -r Alice -e production --preserveStatus=true --format JSON -k
            ```            

    -   **Response**

        ``` bash tab="Response Format"
        Succesfully exported API!
        Find the exported API at <USER_HOME>/.wso2apictl/exported/apis/<envrionment-name>/<API-name>_<version>.zip
        ```

        ``` bash tab="Example Response"
        Succesfully exported API!
        Find the exported API at /Users/kim/.wso2apictl/exported/apis/dev/PhoneVerification_1.0.0.zip
        ```

#### Importing an API

You can use the archive exported from the previous section to import APIs to an API Manager instance in the target environment. When importing the API, you can either **deploy the API as a new API** to the environment or **update an already existing API** in the environment with it.   

1.  Make sure that WSO2 API Manager is started and the CLI tool is running.  
    For more information on running the CLI tool, visit [Downloading and Initializing the CLI Tool](#) 

    !!! warning
        **For Secure Endpoint Enabled APIs:**

        If you have enabled secure endpoints when creating the API and your username or/and password differs in the two environments, please follow the steps below before importing the API.

        1. Unzip the .zip archive created in the previous section.

        2. Go to the `<API-name-version>/Meta-information` directory and open the `api.<json/yaml>` file.
        For example, `PhoneVerification_1.0.0/Meta-information` directory and open the `api.yaml` file.

        3. Modify the `endpointUTPassword` with your endpoint password and save the `api.yaml` file.

        4. Compress the `PhoneVerification_1.0.0` folder. 

    !!! tip
        If you have already logged-in with the same credentials for the environment, and if those keys exist in `$HOME/.wso2apictl/keys.json`, you can skip the following **step 2**.

2.  Login to the API Manager in importing environment by following steps in [Login into an Environment](#)

    !!! info
        If you do not login and if no keys exist for the environment in `$HOME/.wso2apictl/keys.json`, you will prompt to login to the enviroment when running the command in **step 3**.

3.  Run any of following CLI command to import an API.

    -   **Command**
        ``` bash
        apictl import-api -f <environment>/<file> -e <environment> -k
        ```
        ``` bash
        apictl import-api -file <environment>/<file> -environment <environment> -k
        ```
        ``` bash
        apictl import-api -f <environment>/<file> -e <environment> --preserve-provider <preserve_provider> -k
        ```
        ``` go
        apictl import-api -f <environment>/<file> -e <environment> --update <update_api> -k
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--file` or `-f` : The file path of the API to import.  
                `--environment` or `-e` : Environment to which the API should be exported   
            -   Optional :  
                `--preserve-provider` : Preserve existing provider of API after importing. Default value is true  
                `--update` : Update an existing API or create a new API in the importing environment  
                `--params` : Provide a API Manager params file (default "api_params.yaml")  
                `--skipCleanup` : Leave all temporary files created in the CLI during import process  

        !!! tip
            If your file path is `/Users/kim/.wso2apictl/exported/apis/dev/PhoneVerification\_1.0.0.zip.`, then you need to enter `dev/PhoneVerification_1.0.0.zip` as the value for `--file` flag. 

        !!! example
            ```bash
            apimcli import-api -f dev/PhoneVerification_1.0.0.zip -e production -k
            ```
            ```bash
            apictl import-api --file dev/PhoneVerification_1.0.0.zip --environment production -k
            ```    
            ```bash
            apictl import-api -k -f dev/PhoneVerification_1.0.0.zip -e production -u admin -p admin --preserve-provider=false
            ```
            ``` go
            apimcli import-api -f dev/PhoneVerification_1.0.0.zip -e production --update=true -k
            ```
        !!! tip
            When using `--update` flag with `import-api` command, CLI tool will check if the given API exists in the
            targeted environment. If then, it will update the existing API. If not, it will create a new API in the 
            imported environment.      

    -   **Response**
        
        ``` bash
        Succesfully imported API!
        ```

    !!! note
        **Preservig Provider while Importing API**  

        The `--preserve-provider` flag is used to decide whether to keep the actual Provider as the provider of the API or change the provider to the user who is importing the API to a different environment.  

        As an example, If `--preserve-provider` is set to true, when importing an API created by user-1 in environment-1 will be preserved as the provider when and after importing that API to environment-2 by user-2. If `--preserve-provider` is set to false, when importing that API created by user-1 to the environment-2, the provider will be changed (not preserved) to user-2 who is importing the API.    

        !!! tip
            You must add a parameter named `--preserve-provider` to the CLI command and set its value to false if the API is imported to a different domain than its exported one. So it sets the provider of the imported API to the user who is issuing the CLI command.    


    !!! tip
        **Troubleshooting**  
            
        After importing, if the APIs are not visible in the API Publisher UI, do the following to re-index the artifacts in the registry.

        1.  Shut down the API Manager 3.0.0, backup and delete the `<API-M_3.0.0_HOME>/solr` directory
            
        2.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_3.0.0_HOME>/repository/conf/registry.xml` file. If you use a **distributed API Manager setup**, change the file in the API Publisher node. For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1 `

        3.  Restart API Manager 3.0.0 server.

#### Importing/Exporting an API in a Tenanted Environment

!!! info
    The environments that you create will be common to the admin and the tenants. Therefore, you do not need to create environments again when exporting and importing APIs between tenanted environments.

1. To export/import an API from/to a tenant, first follow the steps in [Login into API Manager Environment](#PromotingAPIsThroughCICD-LoginintoAPIManagerEnvironment) by providing tenant specific credentials. 
2. Then follow the steps in [Export an API](#PromotingAPIsThroughCICD-ExportanAPI) and [Import an API](#PromotingAPIsThroughCICD-ImportanAPI).


!!! warning
    When exporting and importing an API across tenanted environments, the `--preserve-provider` flag value should be set to `false` as the original provider username in exporting environment does not exists in importing environment.



### Getting Started with WSO2 API Manager CLI Tool

-   [Downloading and Initilazing the CLI Tool](#)
-   [Adding an Environment](#PromotingAPIsThroughCICD-AddinganEnvironment)
-   [Removing an Environment](#PromotingAPIsThroughCICD-RemovinganEnvironment)
-   [List Environments](#PromotingAPIsThroughCICD-ListEnvironments)
-   [Login into Environment](#PromotingAPIsThroughCICD-LoginintoEnvironment)
-   [Logout from Environment](#PromotingAPIsThroughCICD-LoginintoEnvironment)
-   [List APIs of an Environment](#) 

-   [Reset user](#PromotingAPIsThroughCICD-Resetuser)
-   [Check the version of the CLI](#PromotingAPIsThroughCICD-ChecktheversionoftheCLI)
-   [Set HTTP request timeout](#PromotingAPIsThroughCICD-SetHTTPrequesttimeout)
-   [Set export directory](#PromotingAPIsThroughCICD-Setexportdirectory)
-   [Understanding the API Import Export CLI ](#PromotingAPIsThroughCICD-UnderstandingtheAPIimport/exporttool)



#### Downloading and Initializing the CLI Tool

1.  Navigate to the API Management Tooling page - <https://wso2.com/api-management/tooling/>
2.  Click **Download** under **CLI** .
3.  Select a generated archive suitable for your platform (i.e., Mac, Windows, Linux) and extract it the CLI tool that you downloaded to a desired location and `cd` into it.

4.  Navigate to the working directory where the executable CLI Tool resides.

5.  Execute the following command to start the CLI tool.

    ``` go
    ./apictl
    ```

6.  Add the location of the extracted folder to your system's `$PATH` variable to be able to access the executable from anywhere.


    !!! Tip    
        For further instructions execute the following command.
        ``` go
        apictl --help
        ```


##### Global Flags for CLI Tool

The following are some global flags that you can use with the CLI tool.

``` go
--verbose
    Enable verbose logs (Provides more information on execution)
--insecure, -k
    Allow connections to SSL sites without certs
--help, -h
    Display information and example usage of a command
```

#### Adding an Environment

You can add environments by either manually editing the `$HOME/.wso2apictl/main_config.yaml` file or by running the following CLI command.

``` go
apictl add-env
```

The directory structure for the configuration files ( `$HOME/.wso2apictl` ) will be created upon execution of the `apictl` command.

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to add an environment.

    -   **Command**

        ``` bash tab="Linux"
        apictl add-env -e <environment-name> \
                        --registration <registration-endpoint> \
                        --apim <API-Manager-endpoint> \
                        --token <token-endpoint> \
                        --admin <admin-REST-API-endpoint> \
                        --api_list <API-listing-REST-API-endpoint> \
                        --app_list <application-listing-REST-API-endpoint>
        ```

        ``` bash tab="Mac"
        apictl add-env -e <environment-name> --registration <registration-endpoint> --apim <API-Manager-endpoint> --token <token-endpoint> --admin <admin-REST-API-endpoint> --api_list     <API-listing-REST-API-endpoint> --app_list <application-listing-REST-API-endpoint>
        ```

        !!! info
            **Flags:**  
            
            -    Required :     
                `--environment` or `-e` : Name of the environment to be added  
                `--registration` : Registration endpoint for the environment  
                `--token` : Token endpoint for the environment  
                `--apim` : API Manager endpoint for the environments  

            -   Optional :      
                `--admin` : Admin endpoint for the environment  
                `--api_list` : API List endpoint for the environment  
                `--app_list` : Application List endpoint for the environment  
            
        !!! tip
            When adding an environment, when the optional flags are not given, CLI will automatically derive those from `--apim` flag value.      

        !!! example

            ``` bash tab="Linux"
            apictl add-env -e production \
                        --registration https://localhost:9443/client-registration/v0.15/register \
                        --apim https://localhost:9443 \
                        --token https://localhost:8243/token \
                        --admin https://localhost:9443/api/am/admin/v0.15 \
                        --api_list https://localhost:9443/api/am/publisher/v0.15/apis \
                        --app_list https://localhost:9443/api/am/store/v0.15/applications
            ```

            ``` bash tab="Mac"
            apictl add-env -e production --registration https://localhost:9443/client-registration/v0.15/register --apim https://localhost:9443 --token https://localhost:8243/token --admin https://localhost:9443/api/am/admin/v0.15 --api_list https://localhost:9443/api/am/publisher/v0.15/apis --app_list https://localhost:9443/api/am/store/v0.15/applications
            ```  
    
        !!! example
   
            ``` bash tab="Linux"
            apictl add-env -e dev \
                        --registration https://localhost:9444/client-registration/v0.15/register \
                        --apim https://localhost:9444 \
                        --token https://localhost:8244/token \
            ``` 

            ``` bash tab="Mac"
            ./apictl add-env -e dev --registration https://localhost:9444/client-registration/v0.15/register --apim https://localhost:9444 --token https://localhost:8244/token
            ```

    -   **Response**
    
        ``` bash tab="Response Format"
        Successfully added environment '<environment-name>'
        ```

        ``` bash tab="Example Response"
        Successfully added environment 'production'
        ```

#### Removing an Environment

1.  Make sure that WSO2 API Manager is started and the CLI tool is running.
2.  Run the following CLI command to remove an environment.

    -   **Command**

        ```bash
        apictl remove-env -e <environment-name> 
        ``` 

        !!! info
            **Flags:**  
            
            -    Required :     
                `--environment` or `-e` : Name of the environment to be removed  
  
        !!! example
            ```bash
            apictl remove-env --environment production
            ```

    -   **Response**

        ``` bash tab="Response Format"
        Successfully removed environment '<environment-name>'
        Execute 'apictl add-env --help' to see how to add a new environment
        ```

        ``` bash tab="Example Response"
        Successfully removed environment 'production'
        Execute 'apictl add-env --help' to see how to add a new environment
        ```

#### List Environments

1.  Make sure that WSO2 API Manager is started and the CLI tool is running.
2.  Run the following CLI command to list the environments.  

    -   **Command**

        ```bash
        apictl list envs
        ``` 

        !!! info
            **Flags:**  
            
            -    Optional :     
                `--format` : Pretty-print environments using templates 

    -   **Response**

        ``` bash tab="Response Format"
        NAME                  API MANAGER ENDPOINT      REGISTRATION ENDPOINT      TOKEN ENDPOINT
        <environment-name>    <API-Manager-endpoint>    <registration-endpoint>    <token-endpoint>
        ```

        ```bash tab="Example Response"
        NAME         API MANAGER ENDPOINT     REGISTRATION ENDPOINT                                       TOKEN ENDPOINT
        dev          https://localhost:9443   https://localhost:9443/client-registration/v0.15/register   https://localhost:8243/token
        production   https://localhost:9444   https://localhost:9444/client-registration/v0.15/register   https://localhost:8244/token   

        ```

#### Login into an Environment

After adding an environment, you can login to the API Manager instance in that environment using credentials.

1.  Make sure that WSO2 API Manager is started and the CLI tool is running. 
2.  Run any of the following CLI commands to login to the environment.

    -   **Command**

        ```go
        apictl login <environment-name> -k
        ```

        ```go
        apictl login <environment-name> -u <username> -k
        ```

        ```go
        apictl login <environment-name> -u <username> -p <password> -k
        ``` 

        !!! tip
            If you run `apictl login <environment-name>` you are prompt to provide both username and password.  
            If you run `apictl login <environment-name> --username <username>`, you are prompt to provide password.

        !!! info
            **Flags:**  
            
            -    Optional :     
                `--username` or `-u` : Username for login  
                `--password` or `-p` : Password for login     
                `--password-stdin` : Get password from stdin  

        !!! example
            ```bash
            apictl login dev -u admin -p admin -k
            ```
            
            ```bash
            apictl login dev -username admin -password admin -k
            ```
                 
    -   **Response**

        ``` bash tab="Response Format"
        Logged into '<environment-name>' environment 
        ```

        ```bash tab="Example Response"
        Logged into dev environment
        ```

    !!! warning
        Using -`-password` in CLI is not secure. You can use `--password-stdin` instead. For example,
        ```bash
        cat ~/.mypassword | ./apictl login dev --username admin --password-stdin -k
        ```          

#### Logout from an Environment

Run the following command to logout the currently logged-in user from the API Manager environment.

-   **Command** 

    ```go
    apictl logout <environment-name>
    ```

    !!! example
        ```go
        apictl logout dev
        ```

#### List APIs of an Environment
By following the below steps, you can display a list of APIs in an environment using CLI.

1.  Make sure that WSO2 API Manager is started and the CLI tool is running.
2.  Login to the API Manager in the environment by following steps in [Login into an Environment](#)
3.  Run any of the following CLI commands to list the APIs.

    -   **Command**
        ``` bash
        apictl list apis -e <environment> -k
        ```
        ``` bash
        apictl list apis --environment <environment> --insecure
        ```
        ``` bash
        apictl list apis --environment <environment> --query <API search query> --insecure
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : Environment to be searched  
            -   Optional :  
                `--query` or `q` : Search query pattern 

        !!! example
            ```bash
            apictl list apis -e dev -k
            ```
            ```bash
            apictl list apis --environment production --insecure
            ```    
            ```go
            apictl list apis --environment production --query "provider:Alice name:PizzaShackAPI" --insecure
            ```  

    -   **Response**

        ```go
        ID                                     NAME                VERSION             CONTEXT             STATUS              PROVIDER
        12d6e73c-778d-45ac-b57d-117c6c5092a4   PhoneVerification   1.0                 /phoneverify        PUBLISHED           admin
        91fe87c3-f0d7-4c35-81f5-0e0e42d8e19f   PizzaShackAPI       2.0.0               /pizzashack         CREATED             Alice
        ```
 
#### Check the version of the CLI

1.  Make sure that WSO2 API Manager is started and that CLI tool is running.
2.  Run the following CLI command to check the version of the CLI.

    -   **Command**
        ```bash
        apictl version
        ```
    -   **Response**

        ```bash
        Version: 1.0.0
        ```

#### Set HTTP request timeout

1.  Make sure that WSO2 API Manager is started and the CLI tool is running.
2.  Run the following CLI command to set the HTTP request timeout.

    -   **Command**
        ``` bash
        apictl set --http-request-timeout <http-request-timeout>
        ```

        !!! example
            ```bash
            apictl set --http-request-timeout 10000
            ```
        !!! info

            **Flags:** 

            - Required :   
                  `--http-request-timeout` : Timeout for HTTP Client (default 10000)

#### Set Export Directory

1.  Make sure that WSO2 API Manager is started and the CLI tool is running.
2.  Run the following CLI command to the change the default location of the export directory.

    -   **Command**
        ``` go
        apictl set --export-directory <export-directory-path>
        ```

        !!! example

            ``` go tab="Linux/Mac"
            apictl set --export-directory /home/user/exported-apis
            ```

            ``` go tab="Windows"
            apictl set --export-directoty C:\Documents\exported
            ```

        !!! info

            **Flags:** 

            - Required :   
                  `--export-directory` : Timeout for HTTP Client (default 10000)

------------------------------------------------------------------------

### Understanding the API import/export tool

The API import/export CLI tool uses Admin RESTful API, protected by OAuth2 authentication.

!!! info
    Only the following types of users are allowed to access the API import/export tool.  
    
    -   A user with the `admin` role.
    -   A user with a role having `apim:api_import_export` Admin REST API scope.

#### The Export Functionality

The API export functionality retrieves the information required for the requested API from the registry and databases and generates a ZIP file, which the exporter can download. This exported ZIP file has the following structure:

![Structure of the exported ZIP file]({{base_path}}/assets/attachments/126563297/126563296.png)

The structure of the ZIP file is explained below:

                                                                                                                    
| Sub Directory/File | Description                                                                                                                                                                                                                                                                                                                                                                       |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Meta-information   | **api.yaml**: Contains all the basic information required for an API to be imported to another environment <br/> **swagger.yaml**: Contains the API swagger definition <br/> **endpoint_certificates.yaml**: If API is secured using backend certificates, this file contains all endpoint certificates information. <br> **schema.graphql**: If API is a GraphQl API, this contains the GraphQl schema definition |
| Documents          | **docs.yaml**: Contains the summary of all the documents available for the API <br/> **FileContents**: Contains the uploaded file type documents available for the API <br/> **InlineContents**: Contains inline and markdown type documents available for the API                                                                                                                                        |
| Image              | Thumbnail image of the API                                                                                                                                                                                                                                                                                                                                                        |
| WSDL               | WSDL file of the API                                                                                                                                                                                                                                                                                                                                                              |
| Sequences          | **fault-sequence**: Contains the API specific fault sequence <br/> **in-sequence**: Contains the API specific in sequence <br/> **out-sequence**: Contains the API specific out sequence                                                                                                                                                                                                                  |

#### The Import Functionality

The API import functionality uploads the exported ZIP file of the API to the target environment. It creates a new API with all the registry and database resources exported from the source environment. 

!!! note
    -   Tiers and sequences are provider-specific. If an exported tier is not already available in the imported environment, that tier is not added to the new environment. However, if an exported sequence is not available in the imported environment, it is added.
    -   The importer can decide whether to keep the original provider’s name or replace it. Set the `--preserve-provider` flag to true to keep it. If you set it to false, the original provider is replaced by the user who is sending the CLI command.
    -   Cross-tenant imports are not allowed by preserving the original provider. For example, if an API is exported from tenant A and imported to tenant B, the value of the `--preserve-provider` flag must always be `false` .

