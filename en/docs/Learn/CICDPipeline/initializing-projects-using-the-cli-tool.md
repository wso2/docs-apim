#Building a CICD Pipeline for APIs

Organizations can have multiple environments like Development, Testing,
QA, Staging, Production with own instance of API Managers. These
environments often have different configurations for APIs. WSO2 API
Manager supports creating fully automated CI/CD pipelines for APIs. It
supports a variety of features including maintaining the lifecycle of
API, changing environment-specific configurations throughout the CI/CD
process.  This allows seamlessly migrating APIs across different
environments reducing human intervene on the migration process.

-   Initializing projects using the CLI tool
-   [Migrating the APIs to a Different Environment](Migrating-the-APIs-to-a-Different-Environment_126559899.html)

If you are a non-subscription user, follow the link below to migrate
APIs and applications between environments.

-   [Migrating the APIs and Applications to a Different Environment](https://docs.wso2.com/display/AM260/Migrating+the+APIs+and+Applications+to+a+Different+Environment)


## Initializing projects using the CLI Tool

!!! note
Feature Availability
This feature is only available
with the WSO2 **WUM **updates from July 8, 2019 onwards. For
more information on updating WSO2 API Manager, see [Updating WSO2 API
Manager](https://docs.wso2.com/display/AM260/Updating+WSO2+API+Manager).

The WSO2 API Manager Command Line Interface(CLI) tool can be used to
create APIs without using the API Publisher portal. You can use this
feature to create an API specification when you already have a Swagger
or Open API specification of your API. 


###Before you begin...
!!! info

#### Running the CLI tool

##### Step 1 - Deploy the API import/export tool

1.  Download the latest version of WSO2 API Manager
    from <a href="http://wso2.com/api-management/try-it/" class="external-link">http://wso2.com/products/api-manager/</a>.

2.  Start WSO2 API Manager.
3.  Download the latest WSO2 API import/export tool
    (`api-import-export-2.6.0-v10.war`) from [here]({{base_path}}/assets/attachments/learn/api-import-export-2.6.0-v10.war).

    -   Note that the import/export tool attached is specific to this
        version of WSO2 API Manager.

    -   Make sure to delete all previous versions of the web app (e.g.,
        `api-import-export-2.6.0-v10.war`), both the compressed and the
        extracted files, before copying over the new web app.

    -   This version of the API Import and Export web application is         compatible with the WSO2 **WUM **updates from July 8, 2019           onwards. For more
        information on updating WSO2 API Manager, see [Updating WSO2 API
        Manager](https://docs.wso2.com/display/AM260/Updating+WSO2+API+Manager).
    -   The previous version of the web application which is compatible
        with WUM updates that are prior to the above mentioned date can
        be download from [here]({{base_path}}/assets/attachments/learn/api-import-export-2.6.0-v10.war).
    -   Note that API update support in targeted environment is
        available only with the api-import-export-2.6.0-v10.war version.

4.  Copy the downloaded `api-import-export-2.6.0-v10.war` file to   the `<API-M_HOME>/repository/deployment/server/webapps` folder. The file is automatically deployed as hot deployment is enabled.

  

##### Step 2- Run the CLI tool

1.  Navigate to the API Management Tooling page
    - <a href="https://wso2.com/api-management/tooling/" class="external-link">https://wso2.com/api-management/tooling/</a>
2.  Click **Download** under **Dev-Ops Tooling**.  
    <span
    class="confluence-embedded-file-wrapper confluence-embedded-manual-size"><img src="assets/images/103328894/126567324.png" class="confluence-embedded-image" width="400" /></span>
    ![](../../assets/img/103328894/126567324.png) 
3.  Select a generated archive suitable for your platform (i.e., Mac,
    Windows, Linux) and extract it the CLI tool that you downloaded to a
    desired location and `cd` into it.

4.  Navigate to the working directory where the executable CLI Tool
    resides.

5.  Execute the following command to start the CLI tool.

    ``` 
    ./apimcli
    ```

6.  Add the location of the extracted folder to your system's `$PATH`
    variable to be able to access the executable from anywhere.

    For further instructions execute the following command.

    ```
    apimcli --help
    ```

##### Global flags for CLI tool

The following are some global flags that you can use with the CLI tool.

```
      --verbose
           Enable verbose logs (Provides more information on execution)
      --insecure, -k
          Allow connections to SSL sites without certs
      --help, -h
          Display information and example usage of a command
```

### Logging into API Manager via the CLI tool

Before exporting an API, you need to log in to API Manager to be able to
gain the required privileges for the action. Make sure that you have
credentials with the proper scopes before logging in via the CLI tool.

The sample command to log in is given below.

-   **Command**
``` 
apimcli login <Environment> -u <Username> -p <Password>
```
-   **Sample**
```
apimcli login DEV -u USER -p PASSWORD123
```

  

To log out from the specific environment, use the command given below.

-   **Command**
```
apimcli logout <Environment>
```
-   **Sample**
```
apimcli logout DEV
```

### Create a new API project

1.  Open a terminal window and navigate to the path you need to create
    the project.
2.  Execute the command given below to initialize a new API project. 
   
    -   **Command**
    ``` 
        apimcli init <Project Path>
    ```
    -   **Sample**
    ``` 
    apimcli init SampleAPI
    ```
    -   **Output**
    ``` 
    Initializing a new WSO2 API Manager project in /home/user/work/SampleAPI
    Project initialized
    Open README file to learn more
    ```

3.  A project folder with the following structure will be created in the
    given directory. 

``` 
    ├── api_params.yaml
    ├── Docs
    │   └── FileContents
    ├── Image
    ├── Meta-information
    │   ├── api.yaml
    │   └── swagger.yaml
    ├── README.md
    └── Sequences
        ├── fault-sequence
        ├── in-sequence
        └── out-sequence
```

| File/Folder                                              	| Description                                                                                                                                                                                                                           	|
|----------------------------------------------------------	|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| api.yaml                                                 	| The specification of the created API.                                                                                                                                                                                                 	|
| swagger.yaml                                             	| The swagger file generated when the API is created.                                                                                                                                                                                   	|
| api_params.yaml                                          	| Contains environment-specific details. Note that To set a CI/CD pipeline you need to edit the configurations in this file.                                                                                                            	|
| Sequences, <br/>- fault-sequence <br/>- in-sequence <br/>- out-sequence 	| To add custom sequences, save them in xml format and add them to the corresponding folder.  E.g., To add a custom in-sequence, save the custom sequence as `SampleSequence.xml` and add it to the `Sequences/in-sequence/` directory. 	|

4.  Open the `api.yaml` file. You can edit the mandatory configurations
    listed below.

    | Field           | Description                                             |
    |-----------------|---------------------------------------------------------|
    | `apiName`       | The name of API without spaces.                         |
    | `context`       | Context of the API in API Manager with a leading slash. |
    | `productionUrl` | Production endpoint for API.                            |
    | `sandboxUrl`    | Sandbox endpoint for API.                               |

    For more information about the configurations, go to the <a href="https://gist.github.com/kasvith/01e704611b6c301f470ab0e3b5cb0607" class="external-link">gist</a>.

    **api.yaml**

    ``` 
    id:
      providerName: admin
      apiName: ""
      version: 1.0.0
    type: HTTP
    context: ""
    availableTiers:
    - name: Unlimited
    status: CREATED
    visibility: public
    transports: http,https
    productionUrl: http://localhost:8080
    sandboxUrl: http://localhost:8081
    ```

5.  After editing the mandatory fields, you can import the API using the
    following command.   
      

    ``` 
    apimcli import-api --file ./SampleAPI --environment dev
    ```

    For more information, see [Migrating the APIs to a Different
    Environment](Migrating-the-APIs-to-a-Different-Environment_126559899.html).

    <span
    class="aui-icon aui-icon-small aui-iconfont-warning confluence-information-macro-icon"></span>
    To publish the API immediately after importing, set the `status`
    field to "`PUBLISHED"`

### Generate API projects using a Swagger/Open API specification

1.  You can user Swagger2 and OpenAPI3 specifications to generate an
    API. File format should be yaml or json. A sample command is given
    below.

      

    ``` 
    apimcli init --oas <Path to API specification>/SampleAPI
    ```

2.  To import the created API to your preferred environment, use the
    command given below.

    ``` 
    apimcli import-api -f <Path to API> -e <Environment>
    ```

You can also initialize an API project from a remote Swagger/Open API
specification. The sample command is given below.

``` 
apimcli init --oas https://petstore.swagger.io/v2/swagger.json PetstoreAPI
```

### Change the default API template

APIs are generated using a default template specified in
the `HOME/.wso2apimcli/default_api.yaml` file. You can edit this file to
change how the API projects are initialized. This file contains the same
notation as the `api.yaml` file.

### Generate APIs with dynamic data

You can initialize APi projects with dynamic data using an additional
definition file. The definition file will have the field names (e.g.,
apiName, version) as variables. A sample is shown below.

**sample-additional-definition.yaml**

``` 
id:
  providerName: admin
  apiName: $APINAME
  version: $APIVERSION
```

Execute the following command to create the project.

``` 
apimcli init MyAPI --definition <path>/definition.yaml
```

When executing the command, the CLI tool automatically injects the
values to the API definition.

To make this work you will need to set up required environment variables
according to your OS. In a Linux/Unix environment, it can be done using

``` 
export APINAME=MyAPI
export APIVERSION=1.0.0
```
