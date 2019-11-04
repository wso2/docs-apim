# Promoting APIs Through CI/CD

WSO2 API Manager provides a clean and elegant solution to address automating API deployment. It automates from environment migration to lifecycle management and solves many issues regarding the manual process.

As shown in the above diagram, the pipeline could be integrated with any existing version control system and to support any available CI/CD automation server. The pipeline was designed to be flexible and provides maximum productivity for developers.

Although the diagram shows three parties, there could be more or less, depending on the organization’s structure.

-   API Developers: Develop APIs and related services
-   API Publishers: Publish APIs to users
-   DevOps: Control the deployment process

API Developers and Publishers work with a version control system, which acts as a single source of truth for the pipeline. API Developers can use WSO2 API Manager Publisher to create APIs. To continue with developed CI/CD APIs, they need to be accessible from a version control system.

WSO2 API Manager provides the following two approaches for organizations to select when promoting APIs through a CI/CD pipeline.

-   [Initializing API Projects and Promoting APIs](#initializing-api-projects-and-promoting-apis) 
-   [Migrating APIs to Different Environments](#migrating-apis-to-different-environments)

## Initializing API Projects and Promoting APIs

WSO2 API Manager’s CLI tool, **apimctl** allows to create and deploy APIs without using WSO2 API Publisher Portal. You can use this feature to create an API **from scratch** or **using an existing Swagger or Open API specification** and deploy it to the desired API Manager environment.

!!! info
    **Before you begin...** 

    -   Make sure WSO2 API Manager CLI Tool is initialized and running, if not follow the steps in [Downloading and Initilazing the CLI Tool](#downloading-and-initializing-the-cli-tool).

    -   Make sure you already have added an environment using the CLI tool for the API Manager environment you plan to deploy the API to. 

        If not, follow the steps in [Adding an Environment](#adding-an-environment).

### Initializing an API Project

APIM CLI tool allows API Developers to create API Projects which could be later committed to the central repository, so that API Publishers can start working on preparing those APIs for other environments. 

1. Open a terminal window and navigate to the path you need to create the project.

2. You can follow either of the following ways to generate the project.

    -   **From Scratch**
        ```bash
        apictl init <Project Path>   
        ```

        !!! example
            ```bash tab="Command"
            apictl init SampleAPI                
            ```
            
            ```go tab="Output"
            Initializing a new WSO2 API Manager project in /home/user/work/SampleAPI
            Project initialized
            Open README file to learn more
            ```


    -   **From OpenAPI/Swagger Specification**  
        You can user Swagger2 and OpenAPI3 specifications to generate an API. File format should be yaml or json.

        ```bash
        apictl init SampleAPI --oas <Path to API specification>
        ```

        !!! example
            ```bash tab="From File"
            apictl init Petstore --oas petstore.yaml
            ```

            ```bash tab="From URL"
            apictl init Petstore --oas https://petstore.swagger.io/v2/swagger.json
            ```

            ```go tab="Output"
            Initializing a new WSO2 API Manager project in /home/user/work/PetstoreAPI
            Project initialized
            Open README file to learn more
            ```

### Changing the Default API Template

When you create an API Project, APIs are generated using the default template specified in `$HOME/.wso2apictl/default_api.yaml` file. This file contains the same notation as the `<API-Project>/Meta-information/api.yaml`. Organization-specific common details can be put into this template file and shared across developers to increase productivity. 

To further finetune API creation, a custom API Definition file can be used. If you need to use a specific definition file when generating a certain API project, use the `--definition` or `-d` flag along with `apictl init` command as follows.

!!! info
    The definition file should be in YAML format only.

-   **From Scratch Using Custom API Template**
    ```bash
    apictl init <API-Project> -d <API Definition>
    ```

    !!! example
        ```bash tab="Command"
        apictl init SampleAPI -d definition.yaml               
        ```
            
        ```go tab="Output"
        Initializing a new WSO2 API Manager project in /home/user/work/SampleAPI
        Project initialized
        Open README file to learn more
        ``` 

-   **From OpenAPI/Swagger Specification and Custom API Template**  
    ```bash
    apictl init <API-Project> --oas <OpenAPI Specification> -d <API Definition>
    ```

    !!! example
        ```bash tab="Command"
        apictl init PetStore --oas ./petstore.yaml -d definition.yaml                
        ```
            
        ```go tab="Output"
        Initializing a new WSO2 API Manager project in /home/user/work/PetStore
        Project initialized
        Open README file to learn more 
        ```  

#### Generate APIs with Dynamic Data
The custom API definition file supports detecting environment variables during the creation process. It can be combined with scripting to develop powerful tools for automating API Project creation. A sample custom definition file is shown below.

!!! sample
    ```bash
    id:
        providerName: admin
        apiName: $APINAME
        version: $APIVERSION
    ```
Execute the following command to create the project.

```bash
apimcli init <API-Project-name> --definition <path>/<sample-definition>.yaml
```
When executing the command, the CLI tool automatically injects the values to the API definition.

!!! tip
    To make this work you will need to set up required environment variables according to your OS. In a Linux/Unix environment, it can be done using
    ```bash
    export APINAME=MyAPI
    export APIVERSION=1.0.0
    ```        

### Importing API Project to an Environment

!!! info
    **Before you begin...** 

    -   Make sure you have already created an environment which you are planning to import the API to. If not follow steps in [Adding an Environment](#adding-an-environment). 
    
    -   Make sure you have logged-in to that importing environment.s If not follow steps in [Login to an Environment](#login-to-an-environment). 

#### Configure Environment Specific Details
Once the API project archive is committed to the central repository, API Publishers can start working on preparing the API for other environments. To allow easily configuring environment-specific details, apimctl supports an additional parameter file named `api_params.yaml`. We recommend storing the parameter file with the API Project; however, it can be stored anywhere as required.

Refer below to view a sample configuration of the parameter file.

!!! sample
    ```go
    environments:
        - name: dev
          endpoints:
            production:
              url: 'https://dev.wso2.com'
          certs:
            - hostName: 'https://dev.wso2.com'
              alias: Dev
              path: ~/.certs/dev.pem 
        - name: test
          endpoints:
            production:
              url: 'https://test.wso2.com'
              config:
                retryTimeOut: $RETRY
            sandbox:
              url: 'https://test.sandbox.wso2.com'
    ```

-   Production/Sandbox backends for each environment can be specified in the parameter file with additional configurations, such as timeouts.
-   Certificates can be stored in the Automation Server and the certificates for each URL can be configured in the paramater file. For certificates, a valid path to the certificate file is required. 
-   Parameter file supports detecting environment variables during the API import process. You can use the usual notation. For eg: `url: $DEV_PROD_URL`.  If an environment variable is not set, the tool will fail and request for a set of required environment variables on the system.
-   You can provide a custom path for the parameter file using `--params` flag. If not, the CLI tool will lookup the `api_params.yaml` file in the project directory, project's base path and the current working directory respectively. 

#### Import API Project

After editing the mandatory fields in the API Project and updating the `api_params.yaml` or providing a custom parameter file, you can import the API to an environment using the following command.

```bash
apimcli import-api -f <path>/<API-Project-name> -e <environment-name>
```

```bash
apimcli import-api -f <path>/<API-Project-name> -e <environment-name> --params <path>/<parameter-file-name>
```

