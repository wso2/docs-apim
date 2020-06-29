# Migrating APIs to Different Environments

WSO2 API Controller, **apictl** allows you to maintain multiple environments running on the same WSO2 API-M version. This allows you to import and export APIs between your environments. For example, if you have an API running in the development environment, you can export it and import it to the production environment. Thereby, APIs do not have to be created from scratch in different environments.

!!! info
    **Before you begin** 

    -   Make sure WSO2 API CTL Tool is initialized and running, if not follow the steps in [Download and Initialize the CTL Tool]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

    -  Make sure to add an environment before you start working with the following CTL commands, because all APIs need to be imported or exported to/from a specific environment.      
    For more information, visit [Add an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller#add-an-environment).
    
!!! tip
    A user with `admin` role is allowed to import/export APIs. To create a custom user who can import/export APIs, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/learn/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

### Export an API

1.  Log in to the API Manager in exporting the environment by following steps in [Login to an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

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
                `--environment` or `-e` : Environment from which the API should be exported  
            -    Optional :  
                `--provider` or `-r` : Provider of the API   
                `--preserveStatus` : Preserve API status when exporting. Otherwise, the API will be exported in the `CREATED` status. The default value is `true`.  
                `--format` : File format of exported archive (JSON or YAML). The default value is YAML.
            
        !!! example
            ```go
            apictl export-api -n PhoneVerification -v 1.0.0 -e dev -k
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
| Meta-information   | **api.yaml**: It contains all the basic information required for an API to be imported to another environment. <br/> **swagger.yaml**: It contains the API Swagger definition. <br/> **endpoint_certificates.yaml**: If the API is secured using backend certificates, this file contains all endpoint certificates information. <br> **schema.graphql**: If API is a GraphQL API, this contains the GraphQL schema definition. |
| Docs               | **docs.yaml**: It contains the summary of all the documents available for the API <br/> **FileContents**: It contains the uploaded file type documents available for the API <br/> **InlineContents**: It contains inline and Markdown type documents available for the API.                                                                                                                                        |
| Image              | Thumbnail image of the API                                                                                                                                                                                                                                                                                                                                                        |
| WSDL               | WSDL file of the API                                                                                                                                                                                                                                                                                                                                                              |
| Sequences          | **fault-sequence**: It contains the specific API fault sequence. <br/> **in-sequence**: It contains the specific API in sequence. <br/> **out-sequence**: It contains the specific API out sequence.                                                                                                                                                                                                                  |    

### Export all the APIs of a tenant at once

You can use the below command to export all the APIs belong to the currently logged in user's tenant at once.

- **Command**

    ``` go
    apictl export-apis --environment <environment-from-which-artifacts-should-be-exported> -k
    ```
    ``` go
    apictl export-apis --environment <environment-from-which-artifacts-should-be-exported> --force -k
    ```
    ``` go
    apictl export-apis --environment <environment-from-which-artifacts-should-be-exported> --format <export-format> --preserveStatus --force -k
    ```

    !!! info
        **Flags:**  
        
        -    Required :      
            `--environment` or `-e` : Environment from which the APIs should be exported  
        -    Optional :  
            `--force` : Clean all the previously exported APIs of the given target tenant, in the given environment if any, and to export APIs from beginning  
            `--preserveStatus` : Preserve API status when exporting. Otherwise, the APIs will be exported in the `CREATED` status. The default value is `true`.  
            `--format` : File format of exported archive (JSON or YAML). The default value is YAML.

    !!! example
        ```go
        apictl export-apis -e production -k
        ```
        ```go
        apictl export-apis --environment production --format json  --preserveStatus --force -k
        ```

- **Response**

    ``` go tab="Response Format"
    Exporting APIs for the migration...
    Cleaning all the previously exported APIs of the given target tenant, in the given environment if any, and prepare to export APIs from beginning
    Batch of <number-of-APIs> APIs exported successfully..!

    Total number of APIs exported: <number-of-APIs>
    API export path: <USER_HOME>/.wso2apictl/exported/migration/<environment-name>/tenant-default/apis

    Command: export-apis execution completed !
    ```

    ``` go tab="Example Response"
    Exporting APIs for the migration...
    Cleaning all the previously exported APIs of the given target tenant, in the given environment if any, and prepare to export APIs from beginning
    Batch of 5 APIs exported successfully..!

    Total number of APIs exported: 5
    API export path: /Users/kim/.wso2apictl/exported/migration/<environment-name>/tenant-default/apis

    Command: export-apis execution completed !
    ```

### Import an API

You can use the API archive exported from the previous section (or you can extract it and use the extracted folder) and import it to the API Manager instance in the target environment. When importing the API, you can either **deploy the API as a new API** or **seamlessly update an existing API** in the environment with it.   

!!! warning
    **For Secure Endpoint Enabled APIs:**

    If you have enabled secure endpoints when creating the API and your username or/and password differs in the two environments, please follow the steps below before importing the API.    

    1. Unzip the .zip archive created in the previous section.
    2. Go to the `<API-name-version>/Meta-information` directory and open the `api.<json/yaml>` file.  
    For example, go to `PhoneVerification_1.0.0/Meta-information` directory and open the `api.yaml` file.  
    3. Modify the `endpointUTPassword` with your endpoint password and save the `api.yaml` file.
    4. Compress the `<API-name-version>` directory. (or you can import the extracted folder)
    For example, compress the `PhoneVerification_1.0.0` directory.

1.  Log in to the API Manager in the importing environment by following steps in [Login to an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

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
                `--environment` or `-e` : Environment to which the API should be exported.  
            -   Optional :  
                `--preserve-provider` : Preserve existing provider of API after importing. Default value is `true`.  
                `--update` : Update an existing API or create a new API in the importing environment.  
                `--params` : Define the API Manager environment params file (default "api_params.yaml").   
                `--skipCleanup` : Leave all temporary files created in the CTL during import process. Default value is `false`.  

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
            If your file path is `/Users/kim/.wso2apictl/exported/apis/dev/PhoneVerification_1.0.0.zip.`, then you need to enter `dev/PhoneVerification_1.0.0.zip` as the value for `--file` or `-f` flag.

        !!! tip
            When using `--update` flag with `import-api` command, the CTL tool will check if the given API exists in the targeted environment. If the API exists, it will update the existing API. If not, it will create a new API in the imported environment. 

       
     -   **Response**
        
        ``` bash
        Successfully imported API!
        ```

    !!! note
        **Preserving Provider while Importing API**  

        The `--preserve-provider` flag is used to decide whether to keep the actual provider as the provider of the API or change the provider to the user who is importing the API to a different environment.  

        As an example, If `--preserve-provider` is set to `true`, when importing an API created by user-1 in environment-1 will be preserved with user-1 as the provider when and after importing that API to environment-2 by user-2. If `--preserve-provider` is set to `false`, when importing that API created by user-1 to the environment-2, the provider will be changed (not preserved) to user-2 who is importing the API.    

        !!! tip
            You must add the flag `--preserve-provider` to the CTL command and set its value to `false` if the API is imported to a different domain than its exported one. So it sets the provider of the imported API to the user who is issuing the CTL command. 

!!! note
    **Configuring Environment Specific Parameters**

    When the importing and exporting environments are different, before importing the API, you may need to update the exported API with details relevant to the importing environment. For example, the production and sandbox URLs, the timeout configurations, the backend certificates of your endpoints might differ between the dev and production environments. To allow easily configuring environment-specific details, by default CTL tool supports an additional parameter file named `api_params.yaml`. For more information on using an environment parameter file, see [Configuring Environment Specific Parameters]({{base_path}}/learn/api-controller/advanced-topics/configuring-environment-specific-parameters).

    **Add Dynamic Data to Environment Configs**

    The above parameter file supports detecting environment variables during the API import process. For more information on using dynamic data, see [Add Dynamic Data to Environment Configs]({{base_path}}/learn/api-controller/advanced-topics/using-dynamic-data-in-api-controller-projects/#add-dynamic-data-to-environment-configs).

!!! info
    Tiers and sequences are provider-specific. If an exported tier is not already available in the importing environment, that tier is not added to the new environment. However, if an exported API sequence is not available in the importing environment, it is added.

!!! tip
    **Troubleshooting**  
        
    After importing, if the APIs are not visible in the API Publisher UI, do the following to re-index the artifacts in the registry.

    1.  Shut down the API Manager 3.2.0, backup and delete the `<API-M_3.2.0_HOME>/solr` directory.
        
    2.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_3.2.0_HOME>/repository/conf/registry.xml` file. If you use a **distributed API Manager setup**, change the file in the API Publisher node. For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1 `

    3.  Restart API Manager 3.2.0 server.

!!! warning
    If you have enabled Secure Endpoint (Refer [Configuring Environment Specific Parameters]({{base_path}}/learn/api-controller/advanced-topics/configuring-environment-specific-parameters) for more information), the endpoint password will be removed when exporting an API causing an error when you try to import the same API to an environment. There are 2 solutions for this.

    1.  If Secure Endpoint is enabled and if the endpoint password should be exposed;
    `ExposeEndpointPassword` should be set to `true` in the `/_system/config/apimgt/applicationdata/tenant-conf.json` in the registry so that the exported API will contain the endpoint password.

    2.  Or else, if Secure Endpoint is enabled and if the endpoint password should not be exposed;
    `ExposeEndpointPassword` should be set to `false` in the `/_system/config/apimgt/applicationdata/tenant-conf.json` in the registry (by default this is set to `false`). Here, the secure endpoint password is removed while exporting the API, since it may cause security issues. Hence, the password needs to be added manually when importing the API.

### Import/Export APIs in Tenanted Environments 
The environments that you create will be common to the admin and the tenants. Therefore, you do not need to create environments again when exporting and importing APIs between tenanted environments.

!!! warning
    When exporting and importing an API across tenanted environments, the `--preserve-provider` flag value should be set to `false` as the original provider username in the exporting environment does not exist in the importing environment.
