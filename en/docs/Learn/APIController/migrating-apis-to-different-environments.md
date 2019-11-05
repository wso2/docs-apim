# Migrating APIs to Different Environments

WSO2 API Controller, **apictl** allows you to maintain multiple environments running on the same WSO2 API-M version. This allows you to import and export APIs between your environments. For example, if you have an API running in the development environment, you can export it and import it to the production environment. Thereby, APIs do not have to be created from scratch in different environments.

-   [Export an API](#export-an-api)
-   [Import an API](#import-an-api)
-   [Import/Export an API in Tenanted Environments](#importexport-apis-in-tenanted-environments)

!!! info
    **Before you begin...** 

    -   Make sure WSO2 API CTL Tool is initialized and running, if not follow the steps in [Download and Initialize the CTL Tool](../getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

    -  Make sure to add an environment before you start working with the following CTL commands, because all APIs need to be imported or exported to/from a specific environment.      
    For more information, visit [Add an Environment](../getting-started-with-wso2-api-controller#add-an-environment).
    
!!! warning
    -  Only the following types of users are allowed to export and import APIs.  
        -   A user with the `admin` role.
        -   A user with a role having `apim:api_import_export` Admin REST API scope.

### Export an API

1.  Log in to the API Manager in exporting the environment by following steps in [Login to an Environment](../getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys already available in `$HOME/.wso2apictl/keys.json`, you can skip following above step 1. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in `$HOME/.wso2apictl/keys.json`, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following CTL commands to export an API as a `.zip` archive.  

    -   **Command**
     
        ```go
        apictl export-api -n <API-name> -v <version> -r <provider> -e <environment> -k 
        ``` 
        ```go
        apictl export-api --name <API-name> --version <version> --provider <provider> --environment <environment> -k 
        ```

        ```go
        apictl export-api -n <API-name> -v <version> -r <provider> -e <environment> --preserveStatus=<preserve-status> --format <export-format> -k 
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
            apictl export-api -n PizzaShackAPI -v 1.0.0 -r Alice -e dev --preserveStatus=true --format JSON -k
            ```            

    -   **Response**

        ``` bash tab="Response Format"
        Successfully exported API!
        Find the exported API at <USER_HOME>/.wso2apictl/exported/apis/<envrionment-name>/<API-name>_<version>.zip
        ```

        ``` bash tab="Example Response"
        Successfully exported API!
        Find the exported API at /Users/kim/.wso2apictl/exported/apis/dev/PhoneVerification_1.0.0.zip
        ```

The exported ZIP file has the following structure:

``` java
<APIName>-version
├── Meta-information
│    ├── api.yaml
│    |── swagger.yaml
|    |── endpoint_certificates.yaml
|    └── schema.graphql 
├── Docs
|    |── FileContents
│    |── InlineContents
|    └── docs.yaml
├── Image
|    └── icon.extension
├── WSDL   
|    └── <APIName>-<version>.wsdl  
└── Sequences
    ├── fault-sequence
    |    |── Custom 
    |    |    └── <custom-sequence-name.xml>      
    |    └── <sequence-name.xml> 
    ├── in-sequence
    |    |── Custom
    |    |    └── <custom-sequence-name.xml>   
    |    └── <sequence-name.xml> 
    └── out-sequence
         |── Custom
         |    └── <custom-sequence-name.xml>
         └── <sequence-name.xml> 
```

The structure of an exported API ZIP file is explained below:
                                                                                                                  
| Sub Directory/File | Description                                                                                                                                                                                                                                                                                                                                                                       |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Meta-information   | **api.yaml**: Contains all the basic information required for an API to be imported to another environment <br/> **swagger.yaml**: Contains the API swagger definition <br/> **endpoint_certificates.yaml**: If API is secured using backend certificates, this file contains all endpoint certificates information. <br> **schema.graphql**: If API is a GraphQL API, this contains the GraphQL schema definition |
| Docs               | **docs.yaml**: Contains the summary of all the documents available for the API <br/> **FileContents**: Contains the uploaded file type documents available for the API <br/> **InlineContents**: Contains inline and markdown type documents available for the API                                                                                                                                        |
| Image              | Thumbnail image of the API                                                                                                                                                                                                                                                                                                                                                        |
| WSDL               | WSDL file of the API                                                                                                                                                                                                                                                                                                                                                              |
| Sequences          | **fault-sequence**: Contains the API specific fault sequence <br/> **in-sequence**: Contains the API specific in sequence <br/> **out-sequence**: Contains the API specific out sequence                                                                                                                                                                                                                  |        

### Import an API

You can use the API archive exported from the previous section and import it to the API Manager instance in the target environment. When importing the API, you can either **deploy the API as a new API** or **seamlessly update an existing API** in the environment with it.   

!!! warning
    **For Secure Endpoint Enabled APIs:**

    If you have enabled secure endpoints when creating the API and your username or/and password differs in the two environments, please follow the steps below before importing the API.    

    1. Unzip the .zip archive created in the previous section.
    2. Go to the `<API-name-version>/Meta-information` directory and open the `api.<json/yaml>` file.  
    For example, go to `PhoneVerification_1.0.0/Meta-information` directory and open the `api.yaml` file.  
    3. Modify the `endpointUTPassword` with your endpoint password and save the `api.yaml` file.
    4. Compress the `<API-name-version>` directory.  
    For example, compress the `PhoneVerification_1.0.0` directory.

1.  Log in to the API Manager in importing environment by following steps in [Login to an Environment](../getting-started-with-wso2-api-controller#login-to-an-environment).
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys already available in `$HOME/.wso2apictl/keys.json`, you can skip following above step 1. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in `$HOME/.wso2apictl/keys.json`, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following CTL commands to import an API.

    -   **Command**
        ``` bash
        apictl import-api -f <path-to-API-archive> -e <environment> -k
        ```
        ``` bash
        apictl import-api --file <path-to-API-archive> --environment <environment> -k
        ```
        ``` bash
        apictl import-api --file <path-to-API-archive> --environment <environment> --preserve-provider=<preserve_provider> --update=<update_api> --skipCleanup=<skip-cleanup> --params <environment-params-file>  -k
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--file` or `-f` : The file path of the API to import.  
                `--environment` or `-e` : Environment to which the API should be exported   
            -   Optional :  
                `--preserve-provider` : Preserve existing provider of API after importing. Default value is true  
                `--update` : Update an existing API or create a new API in the importing environment  
                `--params` : Provide a API Manager environment params file (default "api_params.yaml")  
                `--skipCleanup` : Leave all temporary files created in the CTL during import process. Default value is false.  

        !!! example
            ```bash
            apictl import-api -f dev/PhoneVerification_1.0.0.zip -e production -k
            ```
            ```bash
            apictl import-api --file /home/user/apis/PhoneVerification_1.0.0.zip --environment production -k
            ```    
            ``` go
            apictl import-api -f dev/PhoneVerification_1.0.0.zip -e production --preserve-provider=false --update=true --params dev/api_params.yaml -k 
            ```
        !!! tip
            If your file path is `/Users/kim/.wso2apictl/exported/apis/dev/PhoneVerification\_1.0.0.zip.`, then you need to enter `dev/PhoneVerification_1.0.0.zip` as the value for `--file` or `-f` flag.

        !!! tip
            When using `--update` flag with `import-api` command, the CTL tool will check if the given API exists in the targeted environment. If then, it will update the existing API. If not, it will create a new API in the imported environment. 

       
     -   **Response**
        
        ``` bash
        Successfully imported API!
        ```

    !!! note
        **Preserving Provider while Importing API**  

        The `--preserve-provider` flag is used to decide whether to keep the actual provider as the provider of the API or change the provider to the user who is importing the API to a different environment.  

        As an example, If `--preserve-provider` is set to true, when importing an API created by user-1 in environment-1 will be preserved with user-1 as the provider when and after importing that API to environment-2 by user-2. If `--preserve-provider` is set to false, when importing that API created by user-1 to the environment-2, the provider will be changed (not preserved) to user-2 who is importing the API.    

        !!! tip
            You must add the flag `--preserve-provider` to the CTL command and set its value to false if the API is imported to a different domain than its exported one. So it sets the provider of the imported API to the user who is issuing the CTL command. 

    !!! note
        **Configuring Environment Specific Details while Importing API**

        When the importing and exporting environments are different, before importing the API, you may need to update the exported API with details relevant to the importing environment. For example, the production and sandbox URLs, the timeout configurations, the backend certificates of your endpoints might differ between the dev and production environments.

        To allow easily configuring environment-specific details, by default CTL tool supports an additional parameter file named `api_params.yaml`. Following is the structure of the parameter file.

        ```go
        environments:
            - name: <environment_name>
              endpoints:
                production:
                  url: <production_endpoint_url>
                  config:
                    retryTimeOut: <no_of_retries_before_suspension>
                    retryDelay: <retry_delay_in_ms>
                    factory: <suspension_factor>
                sandbox:
                  url: <sandbox_endpoint_url>
                  config:
                    retryTimeOut: <no_of_retries_before_suspension>
                    retryDelay: <retry_delay_in_ms>
                    factor: <suspension_factor>
              gatewayEnvironments:
                - <gateway_environment_name>           
              certs:
                - hostName: <endpoint_url>
                  alias: <certificate_alias>
                  path: <certificate_file_path>
        ```
        When running the `import-api` command, CTL tool will lookup the `api_params.yaml` file in the current location of archive. If not present, it will lookup the file in the current working directory. 

        Instead of the default `api_params.yaml`, you can a provide custom parameter file using `--params` flag. A sample command will be as follows.
        ```go
        apictl import-api -f dev/PhoneVerification_1.0.zip -e production --params /home/user/custom_params.yaml 
        ```

        **Add Dynamic Data to Environment Configs**

        The above parameter file supports detecting environment variables during the API import process. You can use the usual notation. For eg: `url: $DEV_PROD_URL`.  If an environment variable is not set, the tool will fail and request a set of required environment variables on the system.

        In runtime, the CTL look will inject the environment variable values and merge the related environment configs in the parameter file with the API artifact.

    !!! info
        Tiers and sequences are provider-specific. If an exported tier is not already available in the importing environment, that tier is not added to the new environment. However, if an exported API sequence is not available in the importing environment, it is added.

    !!! tip
        **Troubleshooting**  
            
        After importing, if the APIs are not visible in the API Publisher UI, do the following to re-index the artifacts in the registry.

        1.  Shut down the API Manager 3.0.0, backup and delete the `<API-M_3.0.0_HOME>/solr` directory
            
        2.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_3.0.0_HOME>/repository/conf/registry.xml` file. If you use a **distributed API Manager setup**, change the file in the API Publisher node. For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1 `

        3.  Restart API Manager 3.0.0 server.

### Import/Export APIs in Tenanted Environments 
The environments that you create will be common to the admin and the tenants. Therefore, you do not need to create environments again when exporting and importing APIs between tenanted environments.

!!! warning
    When exporting and importing an API across tenanted environments, the `--preserve-provider` flag value should be set to `false` as the original provider username in exporting environment does not exist in importing environment.
