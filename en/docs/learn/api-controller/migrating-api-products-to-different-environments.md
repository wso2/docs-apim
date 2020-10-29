# Migrating API Products (with or without dependent APIs) to Different Environments

WSO2 API Controller, **apictl** allows you to maintain multiple environments running on the same WSO2 API-M version. This allows you to import and export API Products between your environments. For example, if you have an API Product running in the development environment, you can export it and import it to the production environment. Thereby, API Products do not have to be created from scratch in different environments.

!!! info
    **Before you begin** 

    -   Make sure WSO2 API CTL Tool is initialized and running, if not follow the steps in [Download and Initialize the CTL Tool]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

    -  Make sure to add an environment before you start working with the following CTL commands, because all API Products need to be imported or exported to/from a specific environment.      
    For more information, visit [Add an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller#add-an-environment).
    
!!! tip
    -  Only the following types of users are allowed to export and import API Products.  
        -   A user with the `admin` role.
        -   A user with a role having `apim:api_product_import_export` Admin REST API scope with `API Create` and `API Publish` permissions.
    - Refer [Creating Custom Users to Perform API Controller Operations]({{base_path}}/learn/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations) for more information.

### Export an API Product

1.  Log in to the API Manager in exporting the environment by following steps in [Login to an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following CTL commands to export an API Product as a `.zip` archive.  

    -   **Command**
     
        ```go
        apictl export api-product -n <API Product-name> -r <provider> -e <environment> -k 
        ``` 
        ```go
        apictl export api-product --name <API Product-name> --provider <provider> --environment <environment> -k 
        ```

        ```go
        apictl export api-product -n <API Product-name> -r <provider> -e <environment> --format <export-format> -k 
        ``` 

        !!! info
            **Flags:**  
            
            -    Required :  
                `--name` or `-n` : Name of the API Product to be exported      
                `--environment` or `-e` : Environment from which the API Product should be exported  
            -    Optional :      
                `--provider` or `-r` : Provider of the API Product    
                `--format` : File format of exported archive (JSON or YAML). The default value is YAML.
            
        !!! example
            ```go
            apictl export api-product -n LeasingAPIProduct -e dev -k
            ```
            ```go
            apictl export api-product -n CreditAPIProduct -r admin -e production --format JSON -k
            ```            

    -   **Response**

        ``` bash tab="Response Format"
        Successfully exported API Product!
        Find the exported API Product at <USER_HOME>/.wso2apictl/exported/api-products/<envrionment-name>/<API Product-name>_1.0.0.zip
        ```

        ``` bash tab="Example Response"
        Successfully exported API Product!
        Find the exported API Product at /Users/kim/.wso2apictl/exported/api-products/dev/LeasingAPIProduct_1.0.0.zip
        ```

The exported ZIP file has the following structure:

``` java
<APIProductName>-version
├── APIs
│    ├── <1stAPIName>_version
│    |── <2ndAPIName>_version
|    |── 
|    └── <NthAPIName>_version
├── Meta-information
│    ├── api.yaml
|    └── swagger.yaml
├── Docs
|    |── FileContents
│    |── InlineContents
|    └── docs.yaml
└── Image
     └── icon.extension   
```

The structure of an exported API Product ZIP file is explained below:
                                                                                                                  
| Sub Directory/File | Description                                                                                                                                                                                                                                                                                                                                                                       |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| APIs   | Dependent APIs (the APIs which the resources of the API Product belong to) will be exported into subfolders with the name format <APIName\>_version. |
| Meta-information   | **api.yaml**: It contains all the basic information required for an API Product to be imported to another environment. <br/> **swagger.yaml**: It contains the API Product Swagger definition. |
| Docs               | **docs.yaml**: It contains the summary of all the documents available for the API Product <br/> **FileContents**: It contains the uploaded file type documents available for the API Product <br/> **InlineContents**: It contains inline and Markdown type documents available for the API Product.                                                                                                                                        |
| Image              | Thumbnail image of the API Product                                                                                                                                                                                                   |    

### Import an API Product

You can use the API Product archive exported from the previous section (or you can extract it and use the extracted folder) and import it to the API Manager instance in the target environment. When importing the API Product, you can either **deploy the API Product as a new API Product** or **seamlessly update an existing API Product** in the environment with it.

1.  Log in to the API Manager in the importing environment by following steps in [Login to an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following CTL commands to import an API Product.

    -   **Command**
        ``` bash
        apictl import api-product -f <path-to-API-Product-archive> -e <environment> -k --import-apis
        ```
        ``` bash
        apictl import api-product -f <path-to-API-Product-archive> -e <environment> -k
        ```
        ``` bash
        apictl import api-product --file <path-to-API-Product-archive> --environment <environment> -k
        ```
        ``` bash
        apictl import api-product --file <path-to-API-Product-archive> --environment <environment> --update-api-product=<update_api_product> -k
        ```
        ``` bash
        apictl import api-product --file <path-to-API-Product-archive> --environment <environment> --preserve-provider=<preserve_provider> --update-apis=<update_apis> --skipCleanup=<skip-cleanup> -k
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--file` or `-f` : The file path of the API Product to import.  
                `--environment` or `-e` : Environment to which the API Product should be exported.  
            -   Optional :  
                `--preserve-provider` : Preserve existing provider of API Product after importing. Default value is `true`.  
                `--import-apis` : Import depedent APIs to the environment along with the API Product. Default value is `false`.  
                `--update-api-product` : Update an existing API Product or create a new API Product in the importing environment. Default value is `false`.  
                `--update-apis` : Update dependent APIs of the API Product. Default value is `false`.  
                `--skipCleanup` : Leave all temporary files created in the CTL during import process. Default value is `false`.  

        !!! example
            ```bash
            apictl import api-product -f dev/LeasingAPIProduct_1.0.0.zip -e production -k --import-apis=true
            ```
            ```bash
            apictl import api-product -f dev/LeasingAPIProduct_1.0.0.zip -e production -k
            ```
            ```bash
            apictl import api-product --file /home/user/api-products/LeasingAPIProduct_1.0.0.zip --environment production -k
            ``` 
            ```bash
            apictl import api-product --file /home/user/api-products/LeasingAPIProduct_1.0.0.zip --environment production --update-apis=true -k
            ``` 
            ```bash
            apictl import api-product --file /home/user/api-products/LeasingAPIProduct_1.0.0.zip --environment production --update-api-product=true -k
            ```    
            ``` go
            apictl import api-product -f dev/LeasingAPIProduct_1.0.0.zip -e production --preserve-provider=false --update-apis=true -k 
            ```
        !!! tip
            If your file path is `/Users/kim/.wso2apictl/exported/api-products/dev/LeasingAPIProduct_1.0.0.zip.`, then you need to enter `dev/LeasingAPIProduct_1.0.0.zip` as the value for `--file` or `-f` flag.

        !!! tip
            You do not need to set `--import-apis` flag to true if the depedent APIs are already inside the environment. So that, the tool will try only to import the API Product.

        !!! tip
            If you set `--update-apis` flag to true, it will make `--update-api-product` flag true as well.

        !!! tip
            When using `--update-api-product` or `--update-apis` flags with `import api-product` command, the CTL tool will check if the given API Product exists in the targeted environment. If the API Product exists, it will update the existing API Product. If not, it will create a new API Product in the imported environment. 

       
     -   **Response**
        
        ``` bash
        Successfully imported API Product!
        ```

    !!! note
        **Preserving Provider while Importing API Product**  

        The `--preserve-provider` flag is used to decide whether to keep the actual provider as the provider of the API Product and the depedent APIs or change the provider to the user who is importing the API Product to a different environment.  

        As an example, If `--preserve-provider` is set to `true`, when importing an API Product created by user-1 in environment-1 will be preserved with user-1 as the provider when and after importing that API Product to environment-2 by user-2. If `--preserve-provider` is set to `false`, when importing that API Product created by user-1 to the environment-2, the provider will be changed (not preserved) to user-2 who is importing the API Product. (Same goes with dependent APIs as well)

        !!! tip
            You must add the flag `--preserve-provider` to the CTL command and set its value to `false` if the API Product is imported to a different domain than its exported one. So it sets the provider of the imported API Product to the user who is issuing the CTL command. 

!!! note
    **Configuring Environment Specific Parameters**

    When the importing and exporting environments are different, before importing the API Product, you may need to update the dependent APIs with details relevant to the importing environment. For example, the production and sandbox URLs, the timeout configurations, the backend certificates of your endpoints might differ between the dev and production environments. To allow easily configuring environment-specific details, by default CTL tool supports an additional parameter file named `api_params.yaml`. For each dependent API, you can specify those inside the corresponding folder of that particular API. As an example, if you have an exported API Product named LeasingAPIProduct_1.0.0.zip, you can find the dependent APIs inside APIs folder in the .zip. Assume it has a subfolder named LeasingAPI-1.0.0 (which is a dependent API), add/change the `api_params.yaml` file inside it to match with the environment.
    
    For more information on using an environment parameter file, see [Configuring Environment Specific Parameters]({{base_path}}/learn/api-controller/advanced-topics/configuring-environment-specific-parameters).

    **Add Dynamic Data to Environment Configs**

    The above parameter file supports detecting environment variables during the API Product import process. For more information on using dynamic data, see [Add Dynamic Data to Environment Configs]({{base_path}}/learn/api-controller/advanced-topics/using-dynamic-data-in-api-controller-projects/#add-dynamic-data-to-environment-configs).

!!! info
    Tiers are provider-specific. If an exported tier is not already available in the importing environment, that tier is not added to the new environment.

!!! tip
    **Troubleshooting**  
        
    After importing, if the API Products or the dependent APIs are not visible in the API Publisher UI, do the following to re-index the artifacts in the registry.

    1.  Shut down the API Manager 3.2.0, backup and delete the `<API-M_3.2.0_HOME>/solr` directory.
        
    2.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_3.2.0_HOME>/repository/conf/registry.xml` file. If you use a **distributed API Manager setup**, change the file in the API Publisher node. For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1 `

    3.  Restart API Manager 3.2.0 server.

### Import/Export API Products in Tenanted Environments 
The environments that you create will be common to the admin and the tenants. Therefore, you do not need to create environments again when exporting and importing API Products between tenanted environments.

!!! warning
    When exporting and importing an API Product across tenanted environments, the `--preserve-provider` flag value should be set to `false` as the original provider username in the exporting environment does not exist in the importing environment.
