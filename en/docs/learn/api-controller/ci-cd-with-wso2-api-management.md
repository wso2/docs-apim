# CI/CD with WSO2 API Manager

APIs have become a defacto for connecting apps, services, and data. An organization can have multiple environments, such 
as development, testing, QA, staging, and production, each with its own instance of API Managers. Therefore, the APIs need to be 
available in each environment after developers specify the required conditions. Manually promoting APIs between environments is a 
tedious, error-prone, and time-consuming task. This drastically reduces an organization’s productivity.

WSO2 API Manager addresses the issue of API automation by providing a platform-agnostic, developer-centric solution. 
**WSO2 API Controller**,  **apictl** tool plays a key role in the automation pipeline. It can seamlessly integrate 
environment-related configurations and also create API Projects from OpenAPI specifications, opening a gate to 
fully automated API deployment with only a few steps. With the power of flexible tooling, WSO2 API Manager is ready to 
address modern requirements for automating API deployments.

[![]({{base_path}}/assets/img/learn/api-controller/ci-cd-pipeline-for-apis-with-wso2-apim.png)]({{base_path}}/assets/img/learn/api-controller/ci-cd-pipeline-for-apis-with-wso2-apim.png)

Continuous integration and continuous deployment for APIs is an open-ended scenario; different organizations have 
different ways of addressing the problem. The above diagram depicts a generic solution that involves a minimum number of parties in an organization for API automation. Although the diagram shows three parties, there could be more or less depending on the organization’s structure.

-   API Developers: Develop APIs and related services
-   API Publishers: Publish APIs to users
-   DevOps: Control the deployment process

API Developers and Publishers work with a version control system, which acts as a single source of truth for the pipeline.   

## API Publisher based CI/CD

API Developers can use the API Publisher in WSO2 API Manager to create APIs in a lower environment. CI/CD for API Manager relies on a Version Control system that acts as a Single Source of Truth for the pipeline. Therefore, after the API Developer exports the APIs from the lower environment, the API Developer can commit the exported API artifacts to a source code management repository, run the tests in the lower environment, promote the APIs to an upper environment and generate keys for promoted APIs. This process of promoting the API seamlessly to multiple environments can be automated via the **apictl** tool and other CI/CD tools (e.g., Jenkins, GitHub). The **apictl** tool makes this process simpler as it handles per environment-related configurations. 

**To migrate the existing APIs using the API Publisher via CI/CD** carry out the steps mentioned in <a href="#A">A</a>, <a href="#B">B</a>, <a href="#C">C</a>, <a href="#E">E</a>, <a href="#F">F</a> and <a href="#G">G</a>, which is listed under the Building blocks for creating a CI/CD pipeline section, in sequential order.

## Dev First based approach based CI/CD

WSO2 API Manager supports OpenAPI/Swagger specifications to create APIs. The **apictl** can generate projects with Swagger/OpenAPI specifications without using the API Publisher in WSO2 API Manager. This powerful feature can be used to design pipelines that depend on Swagger/OpenAPI specifications.   

Based on the API Project generation, a powerful pipeline for API automation can be developed using OpenAPI/Swagger. This allows rapid API development and increases developer productivity.

[![]({{base_path}}/assets/img/learn/api-controller/api-automation-with-openapi-swagger.png)]({{base_path}}/assets/img/learn/api-controller/api-automation-with-openapi-swagger.png)


**To migrate APIs using the Developer First approach via CI/CD** carry out <a href="#A">A</a>, <a href="#D">D</a>, <a href="#E">E</a>, <a href="#F">F</a> and <a href="#G">G</a>, which is listed under the Building blocks for creating a CI/CD pipeline section, in sequential order.

_________________
## Building blocks for creating a CI/CD pipeline

Let us check out the basic building blocks for creating a CI/CD pipeline with WSO2 API-M in sequential order.

<a name="A"></a>
### (A.) - Prepare the environments

1.  Download and install WSO2 API Manager 3.2.0 in your environments.
     
     For more information, see [installation Prerequisites]({{base_path}}/install-and-setup/installation-guide/installation-prerequisites/).

2.  Download and setup WSO2 API Controller 3.2.0 version, `apictl`. 

     For more information, see [Download and initialize the ctl tool]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).  

3.  Add API Manager environments using the `add-env` command.

    !!! example
        ``` bash tab="Linux/Unix"
        apictl add-env -e dev \
                    --apim https://localhost:9443 

        apictl add-env -e prod \
                    --apim https://localhost:9444 
        ```

        ``` bash tab="Mac/Windows""
        apictl add-env -e dev --apim https://localhost:9443 

        apictl add-env -e prod --apim https://localhost:9444 
        ```    

    For more information, see [Add an environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#add-an-environment). 

<a name="B"></a>
### (B.) - Create and Publish an API in a lower environment

Now, you have added two different environments. Our end goal is to automate the API migration between the `dev` and `prod` environments. Therefore, first, the API should be published in the `dev` environment using the API Publisher in WSO2 API Manager. 
For more information on deploying an API in the API Manager, see the [Quick Start Guide](http://localhost:8000/getting-started/quick-start-guide/).   

For this example, let's use the [Swagger Petstore API](https://petstore.swagger.io/). 

  1.  Sign in to the API Publisher.
       
      `https://localhost:9443/publisher`
  
  2. Click **CREATE API** and select **I have an existing REST API**. 
  
  3. Create the API and define its name as `SwaggerPetstore` and Version as `1.0.0`.

      [![]({{base_path}}/assets/img/learn/api-controller/create-api.png)]({{base_path}}/assets/img/learn/api-controller/create-api.png)

 4. Enter the backend URLs for the Production and Sandbox environments, and publish the API.

      For this example, let's use the following endpoints.

      ```
      Production: http://dev.wso2.com
      Sandbox: http://dev.sandbox.wso2.com
      ```

     [![]({{base_path}}/assets/img/learn/api-controller/prod-dev-endpoints-petstore-api.png)]({{base_path}}/assets/img/learn/api-controller/prod-dev-endpoints-petstore-api.png)

<a name="C"></a>
### (C.) - Export an API from a lower environment

The **apictl** can export an API as an archive from a lower environment (i.e., dev), which contains all the information to recreate the API on another upper environment (i.e., prod).

1.  Sign in to the API Manager in the lower environment via the **apictl**.

    !!! example
        ``` bash
        apictl login dev -u admin -p admin -k
        ```

     For more information, see [Login to an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).

    !!! tip
        A user with `admin` role is allowed to export APIs. To create a custom user who can export APIs, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/learn/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

2. Export the API from the lower environment using the `export-api` command.

    !!! example
        ``` bash
        apictl export-api -e dev -n SwaggerPetstore -v 1.0.0 --provider admin
        ```

     For more information, see [Export an API]({{base_path}}/learn/api-controller/migrating-apis-to-different-environments/#export-an-api).

3.  Extract the content (API will be exported as an archive to the 
`<USER_HOME>/.wso2apictl/exported/apis/dev/` directory). After extraction, you will find a directory named 
`SwaggerPetstore-1.0.0`. Rename it to `SwaggerPetstore` for easy reference.

<a name="D"></a>
### (D.) - Initialize the project using a Swagger/OpenAPI specification

Execute the following command to directly generate the `PetstoreAPI` project using a Swagger/OpenAPI specification. (You can download the Swagger/OpenAPI specification from [here](https://github.com/OAI/OpenAPI-Specification/blob/master/examples/v2.0/yaml/petstore.yaml).)

!!! example
    ```bash
    apictl init PetstoreAPI --oas path/to/petstore.yaml
    ```

- This generates an API project in the `PetstoreAPI` directory using the provided specification. This project can be directly 
imported into the API Manager.
- The **apictl** allows further customization to the project initialization using a template file. Organization-specific common details can be added into this template file and shared across developers to increase productivity.
- To further finetune API creation, an additional API Definition file can be used. This definition file supports detecting environment variables during the creation process. It can be combined with scripting to develop powerful tools for 
automating API Project creation.
- Using this method, the Swagger/OpenAPI specification becomes a single source of truth for API deployment. By combining 
templating and the definition file, the automation servers can be configured to initialize API Projects from Swagger/OpenAPI 
specifications and also have custom parameter files. This reduces human intervention and boosts productivity.
- For example, when an organization depends on a microservices architecture, this method can be utilized to create an automated pipeline to move Swagger/OpenAPI specifications to upper environments.

For more information on initializing an API Project using OpenAPI/Swagger Specification, see 
[Initialize an API Project]({{base_path}}/learn/api-controller/importing-apis-via-dev-first-approach/#initialize-an-api-project).

<a name="E"></a>
### (E.) - Prepare an API project for CI/CD

2.  Copy this directory into your Version Control Repository.
    
    - If you are using the Dev First approach - Copy the initialized project directory.
    - If you are using the Publisher based approach - Copy the extracted project directory.

3.  Define the environment-specific details in the `api_params.yaml` parameter file.

     Define the *prod.wso2.com* and *prod.sandbox.wso2.com* as the backend URLs in this file.
     
     It is recommended to store the parameter file with the API Project; however, you can store it anywhere as required and provide the location to this file as a flag when using the `import-api` command.

    !!! example
        ```bash
        environments: 
          - name: dev 
            endpoints: 
              production: 
                url: 'http://dev.wso2.com' 
              sandbox:
                url: 'http://dev.sandbox.wso2.com' 
          - name: prod
            endpoints:
              production:
                url: 'http://prod.wso2.com'
              sandbox:
                url: 'http://prod.sandbox.wso2.com'
        ```  

     [![]({{base_path}}/assets/img/learn/api-controller/creating-env-based-artifacts.png)]({{base_path}}/assets/img/learn/api-controller/creating-env-based-artifacts.png)        

    !!! info
        - The tool reduces the pipeline’s complexity and provides a simple and powerful mechanism to handle environment-specific configurations.
        - You can define both production and sandbox backend endpoints and additional configurations for the environments such as retry/suspend timeouts, gateway environments etc. in the `api_params.yaml` file.  
        - Backend certificates for each URL can be configured. For certificates, a valid path to the certificate file is 
        required. These paths can be stored in the Automation Server.
        - The **apictl** supports detecting environment variables defined in usual notation. If an environment variable is not set, the tool will fail. In addition, the system will request the user for a set of required environment variables to ensure that information is not missing during the migration process.
        - It is recommended to store API and environment-specific parameters in separate repositories.
        - For more information on using an environment parameter file, see [Configuring Environment Specific Parameters]({{base_path}}/learn/api-controller/advanced-topics/configuring-environment-specific-parameters).


4.  Commit the project to the version control system.        

<a name="F"></a>
### (F.) - Import the API to an upper environment

The Automation Server can be configured to run a specific pipeline for promoting artifacts to other environments. 
The DevOps team can develop this pipeline further to include automated tests, workflow approvals, and other tasks.  

The **apictl** tool should be installed in the automation servers to begin the process. As the tool supports a variety of platforms, including Linux/Windows and macOS, this can be done easily. The **apictl** tool supports the process of importing API Projects via the `import-api` command. This command is mainly used in the pipeline to migrate to different environments.

1.  Import the `SwaggerPetstore` API into the production environment and test the API by running the following sample command.

    !!! tip
        - Make sure you have already logged-in to the `prod` environment. For more information, see 
        [Login to an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).

        - A user with `admin` role is allowed to import APIs. To create a custom user who can import APIs, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/learn/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

    !!! example
        ```bash
        apictl import-api -f ./SwaggerPetstore -e prod --preserve-provider=false --update=true
        ```
    !!! note
        -   When the update flag is present, WSO2 API Manager will attempt to seamlessly update if an existing API is found 
        with the same name and version. 
        
        - The import command prepares an API Project for WSO2 API Manager by processing the parameter file. It determines which configuration should be processed to create an API Project by detecting the environment that has been used to import it.

        - For more information on importing an API to an environment, see [Import an API]({{base_path}}/learn/api-controller/migrating-apis-to-different-environments/#import-an-api).

     Now the tool will automatically detect the target environment and prepare a new artifact containing environment-related details. 

3. Sign in to the API Publisher.

     `https://localhost:9444/publisher`

4. Check the details of the API.
     
     You will see that the API has been imported with correct environment-specific details that you defined. Also, If you have followed, <a href="#A">A</a>, <a href="#B">B</a>, <a href="#C">C</a>, <a href="#E">E</a>, and <a href="#F">F</a>, you can see that the API is in the `PUBLISHED` state and if you have followed <a href="#A">A</a>, <a href="#D">D</a>, <a href="#E">E</a>, and <a href="#F">F</a>, then your API will be in `CREATED` state.

!!! info  
    -   When exporting an API, the **apictl** tool will also export the API’s lifecycle status. When importing to another environment, this lifecycle status will be preserved. This ensures that the API has the same state across environments. 
    
    -   For example, if an API is in the `PUBLISHED` state in the development environment, it will also be in the same state 
    in the testing environment. This default behavior can be changed via the **apictl** tool, which assigns APIs the `CREATED` state after importing. 

<a name="G"></a>
### (G.) - Get keys for an API/API Product

Follow the instructions below to generate a JWT/OAuth token for testing purposes using CTL in order to invoke an API or an API Product by subscribing to it using a new application created by CTL:

!!! tip
    - Make sure that WSO2 API Manager is started and the CTL tool is running. For more information, see [Download and Initialize the CTL Tool]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool). 
    - You should log in to the API Manager in the environment by following the instructions in [Login to an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).

Run any of the following CTL commands to get keys for the API/API Product.

- **Command**

    ```bash
    apictl get-keys -n <API or API Product name> -v <API version> -r <API or API Product provider> -e <environment> -k
    ```  

    ```bash
    apictl get-keys --name <API or API Product name> --version <API version> --provider <API or API Product provider> --environment <environment> -k
    ```

    !!! example
        ```bash
        apictl get-keys -n PizzaShackAPI -e dev -k
        ```
    !!! example
        ```bash
        apictl get-keys -n PizzaShackAPI -v 1.0.0 -e dev -k -r admin -t https://localhost:8243/token
        ```
    !!! info
        **Flags:**  
            
        -   Required :  
            `--environment` or `-e` : Key generation environment  
            `--name` or `-n` : API or API Product to enerate keys for   
        -   Optional :  
            `--token` or `-t` : New token endpoint of the environment (This overrides the previously provided token endpoint that was provided using the add-env command)       
            `--provider` or `-r` : Provider of the API or API Product  
            `--version` or `-v` : Version of the API (Currently API Products do not have versions)

    !!! note
        Both the flags (`--name` (`-n`) and `--environment` (`-e`)) are mandatory.
        You can override the given token endpoint or the default token endpoint using the `--token` (`-t`) optional flag together with the new token endpoint.

!!! info
    - Upon running the above command, the CTL tool will create a default application in the environment, subscribe to the API, and generate keys based on the token type defined in the `<USER_HOME>/.wso2apictl/main-config.yaml`file. 
    - Using apictl tool the token type , HTTP request timeout, and export directory can be set up and changed. For more information on changing the token type, see [Set token type]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#set-token-type), [Set HTTP request timeout]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#set-http-request-timeout) and [Set export directory]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/##set-export-directory) accordingly. 
    - When running the above command, if you have not specified the --version (-v), the tool will consider the version as 1.0.0 by default. If you have specified the version, then that value will be considered.

Now, you know the building blocks of creating a CI/CD pipeline using **apictl**. By using the above, you can create 
an automated pipeline for API promotion between environments using either one of the latter mentioned approaches. 

!!! More
    Next let's use the above knowledge to create a [Jenkins CI/CD Pipeline with WSO2 API Management for a Dev First Approach]({{base_path}}/learn/api-controller/building-jenkins-ci-cd-pipeline-for-dev-first-approach/).
