# Migrating APIs to Different Environments

**WSO2 API Controller(apictl)** allows you to maintain multiple environments running on the same WSO2 API Manager (WSO2 API-M) version. This allows you to import and export APIs between your environments. For example, if you have an API running in the development environment, you can export it and import it to the production environment. Thereby, APIs do not have to be created from scratch in different environments.

!!! info
    **Before you begin**

    -   Make sure apictl is initialized and running, if not follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -  Add an environment before you start working with the following apictl commands, because all APIs need to be imported or exported to/from a specific environment.      
    For more information, visit [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).
    
!!! tip
    A user with `Internal/devops` role or `admin` role are allowed to import/export APIs. To create a custom user who can import/export APIs, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

### Export an API

1.  Log in to the WSO2 API-M in the exporting environment by following steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to export an API as a `.zip` archive.  

    -   **Command**
     
        ```go
        apictl export api -n <API-name> -v <version> --rev <revision-number> -r <provider> -e <environment>  
        ``` 
        ```go
        apictl export api --name <API-name> --version <version> --provider <provider> --environment <environment>  
        ```

        ```go
        apictl export api -n <API-name> -v <version> --rev <revision-number> -r <provider> -e <environment> --preserve-status=<preserve-status> --format <export-format>  
        ``` 

        !!! info
            **Flags:**  
            
            -    Required :  
                `--name` or `-n` : Name of the API to be exported  
                `--version` or `-v` : Version of the API to be exported      
                `--environment` or `-e` : Environment from which the API should be exported  
            -    Optional :  
                `--rev` : Revision Number of the API. If not provided, working copy of the API will be exported.  
                `--provider` or `-r` : Provider of the API.   
                `--latest` : Export the latest revision of the API.  
                `--preserve-status` : Preserve API status when exporting. Otherwise, the API will be exported in the `CREATED` status. The default value is `true`.  
                `--format` : File format of exported archive (JSON or YAML). The default value is YAML.
            
        !!! example
            ```go
            apictl export api -n PhoneVerification -v 1.0.0 -e dev 
            ```
            ```go
            apictl export api -n PizzaShackAPI -v 1.0.0 --rev 2 -r Alice -e dev --preserve-status=true --format JSON 
            ```            

        !!!note
            `apictl export-api` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl export api` as shown above.

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
├── api.yaml
├── api_meta.yaml
├── deployment_environments.yaml
├── Client-certificates
│   ├── Alias1.crt
│   ├── Alias2.crt
│   └── client_certificates.yaml
├── Definitions
│    |── swagger.yaml
|    |── schema.graphql
|    └── graphql-complexity.yaml
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
├── Endpoint-certificates
│   ├── Alias3.crt
│   ├── Alias4.crt
│   └── endpoint_certificates.yaml
├── Image
|    └── <imageName>.extension
├── WSDL   
|    └── <APIName>-<version>.wsdl  
└── Sequences
    ├── fault-sequence
    |    |── Custom 
    |    |    |── <custom-sequence-1-name.xml>     
    |    |    └── <custom-sequence-2-name.xml>   
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

<table>
    <thead>
        <tr class="header">
            <th>Sub Directory/File</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd">
            <td><code>api.yaml</code></td>
            <td>It contains all the basic information required for an API to be imported to another environment.</td>
        </tr>
        <tr class="even">
            <td><code>api_meta.yaml</code></td>
            <td>The meta-information file of the source artifact (This includes the name and the version of the API).</td>
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
            <td>Client-certificates</td>
            <td>If the API is secured using MutualSSL, this folder contains the information related to those.
                <ul>
                    <li>
                        <code>client_certificates.yaml</code>: This contains the information such as alias, certificate file name, tier name and the API Identifier (with the API name, version and the provider name). 
                    </li>
                </ul>
            Apart from the above <code>client_certificates.yaml</code> file, this folder contains the certificate files (.crt). Those file names should be included in the  <code>client_certificates.yaml</code> by mapping to the corresponding alias name. Below is an example file for a  <code>client_certificates.yaml</code> file which has mapped the certificates Alias1.crt and Alias2.crt to the corresponding aliases Alias1 and Alias2 accordingly. 
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
    apiName: PizzaShackAPI
    version: 1.0.0
    id: 0
 -
  alias: Alias2
  certificate: Alias2.crt
  tierName: Gold
  apiIdentifier:
    providerName: admin
    apiName: PizzaShackAPI
    version: 1.0.0
    id: 0
            </code></pre>
            </td>
        </tr>
        <tr class="odd">
            <td>Definitions</td>
            <td> This folder contains the definition file associated to a particular API.
                <ul>
                    <li><code>swagger.yaml</code>: It contains the API Swagger definition.</li>
                    <li><code>schema.graphql</code>: If API is a GraphQL API, this contains the GraphQL schema definition.</li>
                    <li><code>graphql-complexity.yaml</code>: If API is a GraphQL API, and configured query complexity 
                    for different types, this file will contain that complexity information.</li>
                </ul>
            </td>
        </tr>
        <tr class="even">
            <td>Docs</td>
            <td> This folder contains documentation attached to a particular API. Each document will have a separate folder by its name. Each folder contains a file named <code>document.yaml</code> which contains the meta information related to a document. Example for a <code>document.yaml</code> file is shown below.
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
            <br> Similarly if the you have attached a <b>MARKDOWN</b> document, the <code>sourceType</code> will be changed to <b>MARKDOWN</b> and there will not be a field named <code>fileName</code>. The markdown content of that particular document will be included in the same individual document directory named by the document name (E.g., <code>Doc3</code>).
            <br> If the document is just a URL, the <code>sourceType</code> will be changed to <b>URL</b> and a field named <code>sourceURL</code> will be there which will consist the URL of the document.
            </td>
        </tr>
        <tr class="odd">
            <td>Endpoint-certificates</td>
            <td>If the API is secured using endpoint certificates, this folder contains the information related to those.
                <ul>
                    <li>
                        <code>endpoint_certificates.yaml</code>: This contains the information such as alias, certificate file name and the endpoint to which the certificate is attached to. 
                    </li>
                </ul>
            Apart from the above <code>endpoint_certificates.yaml</code> file, this folder contains the certificate files (.crt). Those file names should be included in the  <code>endpoint_certificates.yaml</code> by mapping to the corresponding alias name. Below is an example file for a  <code>endpoint_certificates.yaml</code> file which has mapped the certificates Alias3.crt and Alias4.crt to the corresponding aliases Alias3 and Alias4 accordingly. 
            <pre><code>
type: endpoint_certificates
version: v4.0.0
data:
 -
  alias: Alias4
  endpoint: https://prod.wso2.com
  certificate: Alias4.crt
 -
  alias: Alias3
  endpoint: https://sand.wso2.com
  certificate: Alias3.crt
            </code></pre>
            </td>
        </tr>
        <tr class="even">
            <td>Image</td>
            <td>Thumbnail image of the API.</td>
        </tr>
        <tr class="odd">
            <td>WSDL</td>
            <td>WSDL file of the API.</td>
        </tr>
        <tr class="even">
            <td>Sequences</td>
            <td>
                <ul>
                    <li><b>fault-sequence</b>: It contains the specific API fault sequence.</li>
                    <li><b>in-sequence</b>: It contains the specific API in sequence.</li>
                    <li><b>out-sequence</b>: It contains the specific API out sequence.</li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

### Export all the APIs of a tenant at once

You can use the below command to export all the APIs belong to the currently logged in user's tenant at once.

- **Command**

    ``` go
    apictl export apis --environment <environment-from-which-artifacts-should-be-exported> 
    ```
    ``` go
    apictl export apis --environment <environment-from-which-artifacts-should-be-exported> --all --force 
    ```
    ``` go
    apictl export apis --environment <environment-from-which-artifacts-should-be-exported> --format <export-format> --preserve-status --force 
    ```

    !!! info
        **Flags:**  
        
        -    Required :      
            `--environment` or `-e` : Environment from which the APIs should be exported  
        -    Optional :  
            `--all` : Export the working copy and all the revisions of APIs irrespective of the deployment status.  
            `--force` : Clean all the previously exported APIs of the given target tenant, in the given environment if any, and to export APIs from beginning  
            `--preserve-status` : Preserve API status when exporting. Otherwise, the APIs will be exported in the `CREATED` status. The default value is `true`.  
            `--format` : File format of exported archive (JSON or YAML). The default value is YAML.

    !!! example
        ```go
        apictl export apis -e production 
        ```
        ```go
        apictl export apis --environment production --format json  --preserve-status --force 
        ```
        
    !!! info
        - By default, this will only export the revisions which are deployed at least in one gateway environment.
        To export all the revisions and the working copy without considering the deployment status, use `--all` flag.
        - Exported Artifacts will be named `<API-Name>_<API-Version>_<Revision-Number>.zip`. The exported working copy 
        does not have a revision number.
    
    !!!note
        `apictl export-apis` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl export apis` as shown above.

- **Response**

    ``` go tab="Response Format"
    Exporting APIs for the migration...
    Cleaning all the previously exported APIs of the given target tenant, in the given environment if any, and prepare to export APIs from beginning
    Batch of <number-of-APIs> APIs exported successfully..!

    Total number of APIs exported: <number-of-APIs>
    API export path: <USER_HOME>/.wso2apictl/exported/migration/<environment-name>/tenant-default/apis

    Command: export apis execution completed !
    ```

    ``` go tab="Example Response"
    Exporting APIs for the migration...
    Cleaning all the previously exported APIs of the given target tenant, in the given environment if any, and prepare to export APIs from beginning
    Batch of 5 APIs exported successfully..!

    Total number of APIs exported: 5
    API export path: /Users/kim/.wso2apictl/exported/migration/<environment-name>/tenant-default/apis

    Command: export apis execution completed !
    ```

### Import an API

You can use the API archive exported from the previous section (or you can extract it and use the extracted folder) and import it to the WSO2 API-M instance in the target environment. When importing the API, you can either **create the API as a new API** or **seamlessly update an existing API** in the environment with it. 
If the API archive contains information about deployment environments in the deployment_environments.yaml file, 
once the API is successfully created or updated, a **new revision will be created** and that revision will be deployed in the
mentioned gateway environments. If the **deployment environments are not provided, only the working copy will be updated**.  

1.  Log in to the WSO2 API-M in the importing environment by following steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to import an API.

    -   **Command**
        ``` bash
        apictl import api -f <path-to-API-archive> -e <environment> 
        ```
        ``` bash
        apictl import api --file <path-to-API-archive> --environment <environment> 
        ```
        ``` bash
        apictl import api --file <path-to-API-archive> --environment <environment> --preserve-provider=<preserve_provider> --update=<update_api> --skip-cleanup=<skip-cleanup> --params <environment-params-file>  --rotate-revision=<rotate-revision>
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--file` or `-f` : The file path of the API to import.  
                `--environment` or `-e` : Environment to which the API should be exported.  
            -   Optional :  
                `--rotate-revision` : If the maximum revision limit reached, delete the oldest revision and create a new revision.  
                `--skip-deployments` : Skip the deployment environments specified in the project and only update the working copy of the API.   
                `--preserve-provider` : Preserve existing provider of API after importing. Default value is `true`.  
                `--update` : Update an existing API or create a new API in the importing environment.  
                `--params` : Define the API Manager environment params file.   
                `--skip-cleanup` : Leave all temporary files created in the apictl during import process. Default value is `false`.  

        !!! example
            ```bash
            apictl import api -f dev/PhoneVerification_1.0.0.zip -e production 
            ```
            ```bash
            apictl import api --file /home/user/apis/PhoneVerification_1.0.0.zip --environment production --rotate-revision
            ```    
            ``` go
            apictl import api -f dev/PhoneVerification_1.0.0.zip -e production --preserve-provider=false --update=true --params dev/params.yaml  
            ```
        !!! tip
            If your file path is `/Users/kim/.wso2apictl/exported/apis/dev/PhoneVerification_1.0.0.zip.`, then you need to enter `dev/PhoneVerification_1.0.0.zip` as the value for `--file` or `-f` flag.

        !!! tip
            When using `--update` flag with `import api` command, the apictl will check if the given API exists in the targeted environment. If the API exists, it will update the existing API. If not, it will create a new API in the imported environment.

        !!!note
            `apictl import-api` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl import api` as shown above.
       
     -   **Response**
        
        ``` bash
        Successfully imported API!
        ```
        
    !!! note
        **Changes to the import command with the revision support for APIs**  
        
        - From WSO2 API-M 4.0.0 onwards, you have to create a new revision in order to deploy an API in an gateway environment and 
            **only a revision can be deployed in a gateway environment**. 
        - With the import command of the apictl, if the API project has specified the deployment environments, import 
            will first **update the working copy of the API**.
        - If the number of revisions created for that API **does not exceed the max revision limit of 5**, a new revision
            of that API will be created and that revision will be deployed in the specified gateway environments.
        - If the max revision numbers is reached, imported API will **only update the working copy** and not be deployed 
            in the specified gateway environments.
        - You can use `--rotate-revision` flag with the import command and if the max revision limit reached, import
            operation will **delete the earliest revision for that API and create a new revision**. This new revision will be
            deployed in the specified gateway environments.

    !!! note
        **Preserving Provider while Importing API**  

        The `--preserve-provider` flag is used to decide whether to keep the actual provider as the provider of the API or change the provider to the user who is importing the API to a different environment.  

        As an example, If `--preserve-provider` is set to `true`, when importing an API created by user-1 in environment-1 will be preserved with user-1 as the provider when and after importing that API to environment-2 by user-2. If `--preserve-provider` is set to `false`, when importing that API created by user-1 to the environment-2, the provider will be changed (not preserved) to user-2 who is importing the API.    

        !!! tip
            You must add the flag `--preserve-provider` to the apictl command and set its value to `false` if the API is imported to a different domain than its exported one. So it sets the provider of the imported API to the user who is issuing the apictl command. 

!!! note
    **Configuring Environment Specific Parameters**

    When the importing and exporting environments are different, before importing the API, you may need to update the exported API with details relevant to the importing environment. For example, the production and sandbox URLs, the timeout configurations, the backend certificates of your endpoints might differ between the dev and production environments. To allow easily configuring environment-specific details, by default apictl supports an additional parameter file. For more information on using an environment parameter file for APIs, see [Defining the params file for an API]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#defining-the-params-file-for-an-api).
    
    **Add dynamic data to environment configs**

    The above parameter file supports detecting environment variables during the API import process. For more information on using dynamic data, see [Add dynamic data to environment configs]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/using-dynamic-data-in-api-controller-projects/#add-dynamic-data-to-environment-configs).

!!! info
    Tiers and sequences are provider-specific. If an exported tier is not already available in the importing environment, that tier is not added to the new environment. However, if an exported API sequence is not available in the importing environment, it is added.

!!! tip
    **Troubleshooting**  
    
    - After importing, if the APIs are not visible in the API Publisher UI, do the following to re-index the artifacts in the registry.

        1.  Shut down the WSO2 API-M 4.0.0, backup and delete the `<API-M_4.0.0_HOME>/solr` directory.
        
        2.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_4.0.0_HOME>/repository/conf/registry.xml` file. If you use a **distributed WSO2 API-M setup**, change the file in the API Publisher node. For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1 `

        3.  Restart WSO2 API-M 4.0.0 server.  
    
    - If you want to verify the final import artifact just before it is sent to the WSO2 API-M server, use `--skip-cleanup` 
    with `--verbose` logs. In the verbose logs, you can find the temporary directory location.
    

### Import/Export APIs in tenanted environments 
The environments that you create will be common to the admin and the tenants. Therefore, you do not need to create environments again when exporting and importing APIs between tenanted environments.

!!! warning
    When exporting and importing an API across tenanted environments, the `--preserve-provider` flag value should be set to `false` as the original provider username in the exporting environment does not exist in the importing environment.
