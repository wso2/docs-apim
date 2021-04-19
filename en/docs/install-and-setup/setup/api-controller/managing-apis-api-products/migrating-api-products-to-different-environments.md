# Migrating API Products (with or without Dependent APIs) to Different Environments

**WSO2 API Controller (apictl)** allows you to maintain multiple environments running on the same WSO2 API Manager (WSO2 API-M) version. This allows you to import and export API Products between your environments. For example, if you have an API Product running in the development environment, you can export it and import it to the production environment. Thereby, API Products do not have to be created from scratch in different environments.

!!! info
    **Before you begin** 

    -   Make sure apictl is initialized and setup, if not follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -  Make sure to add an environment before you start working with the following apictl commands, because all API Products need to be imported or exported to/from a specific environment.      
    For more information, visit [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).

!!! tip
    A user with `Internal/devops` role or `admin` role are allowed to import/export API Products. To create a custom user who can import/export APIs, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

### Export an API Product

1.  Log in to the WSO2 API-M in the exporting environment by following steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to export an API Product as a `.zip` archive.  

    -   **Command**
     
        ```go
        apictl export api-product -n <API Product-name> --rev <revision-number> -r <provider> -e <environment>  
        ``` 
        ```go
        apictl export api-product --name <API Product-name> --provider <provider> --environment <environment>  
        ```

        ```go
        apictl export api-product -n <API Product-name> --rev <revision-number> -r <provider> -e <environment> --format <export-format>  
        ``` 

        !!! info
            **Flags:**  
            
            -    Required :  
                `--name` or `-n` : Name of the API Product to be exported      
                `--environment` or `-e` : Environment from which the API Product should be exported  
            -    Optional :   
                `--rev` : Revision Number of the API Product. If not provided, working copy of the API Product will be exported.     
                `--provider` or `-r` : Provider of the API Product.    
                `--latest` : Export the latest revision of the API Product.   
                `--format` : File format of exported archive (JSON or YAML). The default value is YAML.
            
        !!! example
            ```go
            apictl export api-product -n LeasingAPIProduct -e dev 
            ```
            ```go
            apictl export api-product -n CreditAPIProduct --rev 2 -r admin -e production --format JSON 
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
├── api_product.yaml
├── api_product_meta.yaml
├── deployment_environments.yaml
├── Client-certificates
│   ├── Alias1.crt
│   ├── Alias2.crt
│   └── client_certificates.yaml
├── APIs
│    ├── <1stAPIName>_version
│    |── <2ndAPIName>_version
|    |── 
|    └── <NthAPIName>_version
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

The structure of an exported API Product ZIP file is explained below:

<table>
    <thead>
        <tr class="header">
            <th>Sub Directory/File</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd">
            <td><code>api_product.yaml</code></td>
            <td>Contains all the basic information required for an API Product to be imported to another environment.</td>
        </tr>
        <tr class="even">
            <td><code>api_product_meta.yaml</code></td>
            <td>The meta-information file of the source artifact (This includes the name and the version of the API Product. Since currently we do not have the version support for API Products, the version will be always 1.0.0).</td>
        </tr>
        <tr class="odd">
            <td><code>deployment_environments.yaml</code></td>
            <td>If the exported revision is deployed in one or more gateway environments, this file will contain the list of those deployed gateways.
            <pre><code>
type: deployment_environments
version: v4.0.0
data:
 -
   displayOnDevportal: true
   deploymentEnvironment: Default
 -
   displayOnDevportal: true  
   deploymentEnvironment: Label1  
 -
   displayOnDevportal: false  
   deploymentEnvironment: Label2  
            </code></pre>
            </td>
        </tr>
        <tr class="even">
            <td>APIs</td>
            <td>Dependent APIs (the APIs which the resources of the API Product belong to) will be exported into subfolders with the name format <code>&lt;APIName&gt;_version</code>.</td>
        </tr>
        <tr class="odd">
            <td>Client-certificates</td>
            <td>If the API Product is secured using MutualSSL, this folder will contain the information related to the API Product.
                <ul>
                    <li>
                        <code>client_certificates.yaml</code>: Contains the information such as alias, certificate file name, tier name and the API Identifier (with the API Product name, version which is 1.0.0 by default and the provider name). 
                    </li>
                </ul>
            Apart from the above <code>client_certificates.yaml</code> file, this folder contains the certificate files (.crt). These file names should be included in the  <code>client_certificates.yaml</code> by mapping to the corresponding alias name. Below is an example file for a  <code>client_certificates.yaml</code> file which has mapped the certificates Alias1.crt and Alias2.crt to the corresponding aliases Alias1 and Alias2 accordingly. 
            <pre><code>
type: client_certificates
version: v4.0.0
data:
-
alias: Alias1
certificate: Alias1.crt
tierName: Bronze
apiIdentifier:
    providerName: admin
    apiName: LeasingAPIProduct
    version: 1.0.0
    id: 0
-
alias: Alias2
certificate: Alias2.crt
tierName: Gold
apiIdentifier:
    providerName: admin
    apiName: LeasingAPIProduct
    version: 1.0.0
    id: 0
            </code></pre>
            </td>
        </tr>
        <tr class="even">
            <td>Definitions</td>
            <td> This folder will contain the definition file associated to a particular API Product.
                <ul>
                    <li><code>swagger.yaml</code>: It contains the API Product Swagger definition.</li>
                </ul>
            </td>
        </tr>
        <tr class="odd">
            <td>Docs</td>
            <td> This folder will contain documentation attached to a particular API Product. Each document will have a seperate folder by its name. Each folder will contain a file named <code>document.yaml</code> which will contain the meta information related to a document. Example for a <code>document.yaml</code> file is shown below.
            <pre><code>
type: document
version: v4.0.0
data:
  documentId: 7be89b14-6b7c-4e1f-8bee-f72295dd65cb
  name: Doc1
  type: HOWTO
  summary: This is the sample summary
  sourceType: FILE
  fileName: document-file.pdf
  visibility: API_LEVEL
            </pre></code>
            The above example denotes a document for a <b>FILE</b> named <code>document-file.pdf</code>. The corresponding file will be inside the individual folder of the <b>Docs</b> directory. 
            <br>If the you have attached an <b>INLINE</b> document, the <code>sourceType</code> will be changed to <b>INLINE</b> and the field named <code>fileName</code> will not be available. The inline content of that particular document will be included in the same individual document directory named by the document name (E.g., <code>Doc2</code>).
            <br> Similarly if you have attached a <b>MARKDOWN</b> document, the <code>sourceType</code> will be changed to <b>MARKDOWN</b> and there will not be a field named <code>fileName</code>. The markdown content of that particular document will be included in the same individual document directory named by the document name (E.g., <code>Doc3</code>).
            <br> If the document is just a URL, the <code>sourceType</code> will be changed to <b>URL</b> and a field named <code>sourceURL</code> will be there which will consist the URL of the document.
            </td>
        </tr>
        <tr class="even">
            <td>Image</td>
            <td>Thumbnail image of the API Product.</td>
        </tr>
    </tbody>
</table>

### Import an API Product

You can use the API Product archive exported from the previous section (or you can extract it and use the extracted folder) and import it to the WSO2 API-M instance in the target environment. When importing the API Product, you can either **create the API Product as a new API Product** or **seamlessly update an existing API Product** in the environment with it.
If the API Product archive contains information about deployment environments in the `deployment_environments.yaml` file, 
once the API Product is successfully created or updated, a **new revision will be created** and that revision will be deployed in the
mentioned gateway environments. If the **deployment environments are not provided, only the working copy will be updated**.  

1.  Log in to the WSO2 API-M in the importing environment by following steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to import an API Product.

    -   **Command**
        ``` bash
        apictl import api-product -f <path-to-API-Product-archive> -e <environment>  --import-apis
        ```
        ``` bash
        apictl import api-product -f <path-to-API-Product-archive> -e <environment> 
        ```
        ``` bash
        apictl import api-product --file <path-to-API-Product-archive> --environment <environment> 
        ```
        ``` bash
        apictl import api-product --file <path-to-API-Product-archive> --environment <environment> --update-api-product=<update_api_product> 
        ```
        ``` bash
        apictl import api-product --file <path-to-API-Product-archive> --environment <environment> --preserve-provider=<preserve_provider> --update-apis=<update_apis> --skip-cleanup=<skip-cleanup> --params <environment-params-file> --rotate-revision=<rotate-revision>
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--file` or `-f` : The file path of the API Product to import.  
                `--environment` or `-e` : Environment to which the API Product should be exported.  
            -   Optional :  
                `--preserve-provider` : Preserve existing provider of API Product after importing. Default value is `true`.  
                `--rotate-revision` : If the maximum revision limit reached, delete the oldest revision and create a new revision.  
                `--skip-deployments` : Skip the deployment environments specified in the project and only update the working copy of the API Product.  
                `--import-apis` : Import depedent APIs to the environment along with the API Product. Default value is `false`.  
                `--update-api-product` : Update an existing API Product or create a new API Product in the importing environment. Default value is `false`.  
                `--update-apis` : Update dependent APIs of the API Product. Default value is `false`.  
                `--params` : Define the API Manager environment params file.  
                `--skip-cleanup` : Leave all temporary files created in the apictl during import process. Default value is `false`.  

        !!! example
            ```bash
            apictl import api-product -f dev/LeasingAPIProduct_1.0.0.zip -e production  --import-apis=true
            ```
            ```bash
            apictl import api-product -f dev/LeasingAPIProduct_1.0.0.zip -e production --rotate-revision
            ```
            ```bash
            apictl import api-product --file /home/user/api-products/LeasingAPIProduct_1.0.0.zip --environment production 
            ``` 
            ```bash
            apictl import api-product --file /home/user/api-products/LeasingAPIProduct_1.0.0.zip --environment production --update-apis=true --rotate-revision
            ``` 
            ```bash
            apictl import api-product --file /home/user/api-products/LeasingAPIProduct_1.0.0.zip --environment production --update-api-product=true 
            ```    
            ``` go
            apictl import api-product -f dev/LeasingAPIProduct_1.0.0.zip -e production --preserve-provider=false --update-apis=true  
            ```
            ``` go
            apictl import api-product -f dev/LeasingAPIProduct_1.0.0.zip -e production --preserve-provider=false --update-apis=true --params dev/api_product_params.yaml  
            ```

        !!! tip
            If your file path is `/Users/kim/.wso2apictl/exported/api-products/dev/LeasingAPIProduct_1.0.0.zip.`, then you need to enter `dev/LeasingAPIProduct_1.0.0.zip` as the value for `--file` or `-f` flag.

        !!! tip
            You do not need to set `--import-apis` flag to true if the dependent APIs are already inside the environment. So that, the tool will try only to import the API Product.

        !!! tip
            If you set `--update-apis` flag to true, it will make `--update-api-product` flag true as well.

        !!! tip
            When using `--update-api-product` or `--update-apis` flags with `import api-product` command, the apictl tool will check if the given API Product exists in the targeted environment. If the API Product exists, it will update the existing API Product. If not, it will create a new API Product in the imported environment. 

       
     -   **Response**
        
        ``` bash
        Successfully imported API Product!
        ```

    
    !!! note
        **Changes to the import command with the revision support for API Products**  
        
        - From WSO2 API-M 4.0.0 onwards, you have to create a new revision in order to deploy both APIs and API Products in an 
            gateway environment and **only a revision can be deployed in a gateway environment**.
        - With the import command of the apictl, if the API Product project has specified the deployment environments, import 
            will first **update the working copy of the API Product and dependent APIs**.
        - If the number of revisions created for that API Product **does not exceed the max revision limit of 5**, a new revision
            of that API Product will be created and that revision will be deployed in the specified gateway environments.
        - If the max revision numbers is reached, imported API Product will **only update the working copy** and not be deployed 
            in the specified gateway environments.
        - You can use `--rotate-revision` flag with the import command and if the max revision limit reached, import
            operation will **delete the earliest revision for that API Product and create a new revision**. This new revision will be
            deployed in the specified gateway environments.  
        - If dependent APIs also imported with the Product, a revision for the APIs will be created as well and 
            they will be deployed in the parent API Product's deployment environments.
            

    !!! note
        **Preserving Provider while Importing API Product**  

        The `--preserve-provider` flag is used to decide whether to keep the actual provider as the provider of the API Product and the depedent APIs or change the provider to the user who is importing the API Product to a different environment.  

        As an example, If `--preserve-provider` is set to `true`, when importing an API Product created by user-1 in environment-1 will be preserved with user-1 as the provider when and after importing that API Product to environment-2 by user-2. If `--preserve-provider` is set to `false`, when importing that API Product created by user-1 to the environment-2, the provider will be changed (not preserved) to user-2 who is importing the API Product. (Same goes with dependent APIs as well)

        !!! tip
            You must add the flag `--preserve-provider` to the apictl command and set its value to `false` if the API Product is imported to a different domain than its exported one. So it sets the provider of the imported API Product to the user who is issuing the apictl command. 

!!! note
    **Configuring Environment Specific Parameters**

    When the importing and exporting environments are different, before importing the API Product, you may need to update the exported API Product with details relevant to the importing environment. For example, the subscription policies, MutualSSL certificates and deployment environments of an API Product might differ between the dev and production environments. Furthermore, when considering the dependent APIs of an API product, the production and sandbox URLs, the timeout configurations, the backend certificates of your endpoints might differ between environments as well. To allow easily configuring environment-specific details, by default apictl supports an additional parameter file. For more information on using an environment parameter file for API Products, see [Defining the params file for an API Product]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#defining-the-params-file-for-an-api-product).

    **Add dynamic data to environment configs**

    The above parameter file supports detecting environment variables during the API Product import process. For more information on using dynamic data, see [Add dynamic data to environment configs]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/using-dynamic-data-in-api-controller-projects/#add-dynamic-data-to-environment-configs).

!!! info
    Tiers are provider-specific. If an exported tier is not already available in the importing environment, that tier is not added to the new environment.

!!! tip
    **Troubleshooting**  
        
    After importing, if the API Products or the dependent APIs are not visible in the WSO2 API-M Publisher UI, do the following to re-index the artifacts in the registry.

    1.  Shut down the WSO2 API-M 4.0.0, backup and delete the `<API-M_4.0.0_HOME>/solr` directory.
        
    2.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_4.0.0_HOME>/repository/conf/registry.xml` file. If you use a **distributed WSO2 API-M setup**, change the file in the API Publisher node. For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1 `

    3.  Restart WSO2 API-M 4.0.0 server.

### Import/Export API Products in tenanted environments 
The environments that you create will be common to the admin and the tenants. Therefore, you do not need to create environments again when exporting and importing API Products between tenanted environments.

!!! warning
    When exporting and importing an API Product across tenanted environments, the `--preserve-provider` flag value should be set to `false` as the original provider username in the exporting environment does not exist in the importing environment.
