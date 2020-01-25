# CI/CD with WSO2 API Manager

APIs have become a defacto for connecting apps, services, and data. An organization can have multiple environments, such 
as development, testing, QA, staging, and production, each with its own instance of API Managers. Therefore, the APIs need to be 
available in each environment after developers specify the required conditions. Manually promoting APIs between environments is a 
tedious, error-prone, and time-consuming task. This drastically reduces an organization’s productivity.

WSO2 API Manager addresses the issue of API automation by providing a platform-agnostic, developer-centric solution. 
**WSO2 API Controller**,  **apictl** tool plays a key role in the automation pipeline. It can seamlessly integrate 
environment-related configurations and also create API Projects from Swagger/OpenAPI specifications, opening a gate to 
fully automated API deployment with only a few steps. With the power of flexible tooling, WSO2 API Manager is ready to 
address modern requirements for automating API deployments.

[![]({{base_path}}/assets/img/Learn/APIController/ci-cd-pipeline-for-apis-with-wso2-apim.png)]({{base_path}}/assets/img/Learn/APIController/ci-cd-pipeline-for-apis-with-wso2-apim.png)

Continuous integration and continuous deployment for APIs is an open-ended scenario; different organizations have 
different ways of addressing the problem. The above diagram depicts a generic solution that involves a minimum number of parties in an organization for API automation. Although the diagram shows three parties, there could be more or less depending on the organization’s structure.

-   API Developers: Develop APIs and related services
-   API Publishers: Publish APIs to users
-   DevOps: Control the deployment process

API Developers and Publishers work with a version control system, which acts as a single source of truth for the pipeline. 
API Developers can use WSO2 API Manager's Publisher to create APIs. CI/CD for API Manager relies on a Version Control system that acts as a Single Source of Truth for the pipeline. After APIs are exported from one environment, promoting it to the other environment is done via the `apictl`. It is capable of handling 
environment-related configurations and can promote the API seamlessly to other environments via a single command.  

Let us check out the basic building blocks for creating a CI/CD pipeline with WSO2 API-M.

## Preparing Environments

1.  Download and install WSO2 API Manager 3.0 in your environments.
     
     For more information, see [installation Prerequisites]({{base_path}}/InstallAndSetup/InstallationGuide/installation-prerequisites/).

2.  Download and setup WSO2 API Controller, `apictl`. 

     For more information, see [Download and initialize the ctl tool]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).  

3.  Add API Manager environments using the `add-env` command.

    !!! example
        ``` bash
        apictl add-env -e dev \
                    --registration https://localhost:9444/client-registration/v0.15/register \
                    --apim https://localhost:9444 \
                    --token https://localhost:8244/token \

        apictl add-env -e prod \
                    --registration https://localhost:9443/client-registration/v0.15/register \
                    --apim https://localhost:9443 \
                    --token https://localhost:8243/token \
        ```

    For more information, see [Add an environment]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#add-an-environment). 

## Creating and Publishing an API in a Lower Environment

Now, you have added two different environments. Our end goal is to automate the API migration between the `dev` and `prod` environments. Therefore, first, the API should be published in the `dev` environment using the API Publisher in WSO2 API Manager. 
For more information on deploying an API in the API Manager, see the [Quick Start Guide](http://localhost:8000/GettingStarted/quick-start-guide/).   

For this example, let's use the [Swagger Petstore API](https://petstore.swagger.io/). 

  1.  Sign in to the API Publisher.
       
      `https://localhost:9443/publisher`
  
  2. Click **CREATE API** and select **I have an existing REST API**. 
  
  3. Create the API and define its name as `SwaggerPetstore` and Version as `1.0.0`.

      [![]({{base_path}}/assets/img/Learn/APIController/create-api.png)]({{base_path}}/assets/img/Learn/APIController/create-api.png)

 4. Enter the backend URLs for the Production and Sandbox environments, and publish the API.

      For this example, let's use the following endpoints.

      ```
      Production: http://dev.wso2.com
      Sandbox: http://dev.sandbox.wso2.com
      ```

     [![]({{base_path}}/assets/img/Learn/APIController/prod-dev-endpoints-petstore-api.png)]({{base_path}}/assets/img/Learn/APIController/prod-dev-endpoints-petstore-api.png)


## Exporting an API from a Lower Environment

The **apictl** can export an API as an archive from a lower environment (i.e., dev), which contains all the information to recreate the API on another upper environment (i.e., prod).

1.  Sign in to the API Manager in the lower environment via the **apictl**.

    !!! example
        ``` bash
        apictl login dev -u admin -p admin -k
        ```

     For more information, see [Login to an Environment]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#login-to-an-environment).

    !!! warning
        -   A user with `admin` role is allowed to export APIs.
        -   A user with any role [`custom_role`] having either one of the `API Create` or `API Publish` permissions (along with the `Login` permission) can be allowed to export APIs by following the steps below.
            1. Sign in to the API-M management console as a tenant admin user. 
                 `https://localhost:9443/carbon`
            2. Click **Main > Resources > Browse**
            3. Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to browse the registry and locate the required resource.
            4. Update the `RESTAPIScopes` JSON field with the following.
                ```bash
                {...
                "Name": "apim:api_import_export",
                "Roles": "admin, custom_role"
                ...},
                ``` 
            5. Restart the server or wait for 15 mins until the Registry cache expires.

2. Export the API from the lower environment using the `export-api` command.

    !!! example
        ``` bash
        apictl export-api -e dev -n SwaggerPetstore -v 1.0.0 --provider admin
        ```

     For more information, see [Export an API]({{base_path}}/Learn/APIController/migrating-apis-to-different-environments/#export-an-api).

## Preparing an API Project for CI/CD

1.  Extract the content (API will be exported as an archive to the 
`<USER_HOME>/.wso2apictl/exported/apis/dev/` directory). After extraction, you will find a directory named 
`SwaggerPetstore-1.0.0`.

2.  Copy this directory into your Version Control Repository.            
     Rename it to `SwaggerPetstore` for easy reference.

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

     [![]({{base_path}}/assets/img/Learn/APIController/creating-env-based-artifacts.png)]({{base_path}}/assets/img/Learn/APIController/creating-env-based-artifacts.png)        

    !!! info
        - The tool reduces the pipeline’s complexity and provides a simple and powerful mechanism to handle environment-specific configurations.
        - You can define both production and sandbox backend endpoints and additional configurations for the environments such as retry/suspend timeouts, gateway environments etc. in the `api_params.yaml` file.  
        - Backend certificates for each URL can be configured. For certificates, a valid path to the certificate file is 
        required. These paths can be stored in the Automation Server.
        - The **apictl** supports detecting environment variables defined in usual notation. If an environment variable is not set, the tool will fail. In addition, the system will request the user for a set of required environment variables to ensure that information is not missing during the migration process.
        - It is recommended to store API and environment-specific parameters in separate repositories.
        - For more information on using an environment parameter file, see [Configuring Environment Specific Parameters]({{base_path}}/Learn/APIController/migrating-apis-to-different-environments/#configuring-environment-specific-parameters).


4.  Commit the project to the version control system.        

## Importing API to Upper Environment

The Automation Server can be configured to run a specific pipeline for promoting artifacts to other environments. 
The DevOps team can develop this pipeline further to include automated tests, workflow approvals, and other tasks.  

The **apictl** tool should be installed in the automation servers to begin the process. As the tool supports a variety of platforms, including Linux/Windows and macOS, this can be done easily. The **apictl** tool supports the process of importing API Projects via the `import-api` command. This command is mainly used in the pipeline to migrate to different environments.

1.  Import the `SwaggerPetstore` API into the production environment and test the API by running the following sample command.

    !!! warning
        Make sure you have already logged-in to the `prod` environment. For more information, see 
        [Login to an Environment]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#login-to-an-environment).

        -   A user with `admin` role is allowed to import APIs.
        -   A user with a role [`custom_role`] with BOTH `API Create` and `API Publish` permissions (along with `Login` permission) is allowed to import APIs by following the steps below.
            1. Sign in to the API-M management console as a tenant admin user. 
                 `https://localhost:9443/carbon`
            2. Click **Main > Resources > Browse**
            3. Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to browse the registry and locate the required resource.
            4. Update the `RESTAPIScopes` JSON field with the following.
                ```bash
                {...
                    "Name": "apim:api_import_export",
                    "Roles": "admin, custom_role"
                ...},
                ``` 
            4. Restart the server or wait for 15 mins until the registry cache expires.
        -   If the `custom_role` only has the `API Create` permissions, then the user with that `custom_role` can import APIs only that are in the `CREATED` state.
        -   To import an API by updating/changing the lifecycle state, the user with a `custom_role` should have both `API Create` and `API Publish` permissions.
        -   A user that has a `custom_role` with only the `API Publish` permission, cannot import an API.         

    !!! example
        ```bash
        apictl import-api -f ./SwaggerPetstore -e prod --preserve-provider=false --update=true
        ```
    !!! note
        -   When the update flag is present, WSO2 API Manager will attempt to seamlessly update if an existing API is found 
        with the same name and version. 
        
        - The import command prepares an API Project for WSO2 API Manager by processing the parameter file. It determines which configuration should be processed to create an API Project by detecting the environment that has been used to import it.

        - For more information on importing an API to an environment, see [Import an API]({{base_path}}/Learn/APIController/migrating-apis-to-different-environments/#import-an-api).

     Now the tool will automatically detect the target environment and prepare a new artifact containing environment-related details. 

3. Sign in to the API Publisher.

     `https://localhost:9443/publisher`

4. Check the details of the API.
     
     You will see that the API has been imported with correct environment-specific details that you defined and also that the API is in the `PUBLISHED` state.

!!! info  
    -   When exporting an API, the **apictl** tool will also export the API’s lifecycle status. When importing to another environment, this lifecycle status will be preserved. This ensures that the API has the same state across environments. 
    
    -   For example, if an API is in the `PUBLISHED` state in the development environment, it will also be in the same state 
    in the testing environment. This default behavior can be changed via the **apictl** tool, which assigns APIs the `CREATED` state after importing. 

## Swagger/OpenAPI-based API CI/CD

WSO2 API Manager supports OpenAPI/Swagger specifications to create APIs. The **apictl** can generate projects with Swagger/OpenAPI specifications without using the API Publisher in WSO2 API Manager. This powerful feature can be used to design pipelines that depend on Swagger/OpenAPI specifications.   

Based on the API Project generation, a powerful pipeline for API automation can be developed using OpenAPI/Swagger. This allows rapid API development and increases developer productivity.

For more information on initializing an API Project using OpenAPI/Swagger Specification, see 
[Initialize an API Project]({{base_path}}/Learn/APIController/importing-apis-via-dev-first-approach/#initialize-an-api-project).

[![]({{base_path}}/assets/img/Learn/APIController/api-automation-with-openapi-swagger.png)]({{base_path}}/assets/img/Learn/APIController/api-automation-with-openapi-swagger.png)

Execute the following command to directly generate the `PetstoreAPI` project using a Swagger/OpenAPI specification.

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

Now, you know the building blocks of creating a CI/CD pipeline using **apictl**. By using the above, you can create 
an automated pipeline for API promotion between environments using either one of the latter mentioned approaches. 

!!! More
    Next let's use the above knowledge to create a [Jenkins CI/CD Pipeline with WSO2 API Management for a Dev First Approach]({{base_path}}/Learn/APIController/building-jenkins-ci-cd-pipeline-for-dev-first-approach/).





