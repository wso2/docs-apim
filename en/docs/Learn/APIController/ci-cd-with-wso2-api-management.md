# Building CI/CD Pipeline for WSO2 API-M 

## CI/CD With WSO2 API Management

APIs have become a defacto for connecting apps, services, and data. An organization can have multiple environments, such 
as development, testing, QA, staging, and production, each with own instance of API managers. So the APIs need to be 
available on each environment after developers specify conditions. Manually promoting APIs between environments is a 
tedious, error-prone, and time-consuming task. This drastically reduces an organization’s productivity.

WSO2 API Manager addresses the issue of API automation by providing a platform-agnostic, developer-centric solution. 
**WSO2 API Controller**,  **apictl** tool plays a key role in the automation pipeline. It can seamlessly integrate 
environment-related configurations and also create API Projects from Swagger/OpenAPI specifications, opening a gate to 
fully automated API deployment with only a few steps. With the power of flexible tooling, WSO2 API Manager is ready to 
address modern requirements for automating API deployments.

[![]({{base_path}}/assets/img/Learn/APIController/ci-cd-pipeline-for-apis-with-wso2-apim.png)]({{base_path}}/assets/img/Learn/APIController/ci-cd-pipeline-for-apis-with-wso2-apim.png)

Continuous integration and continuous deployment for APIs is an open-ended scenario; different organizations have 
different ways of addressing the problem. We have focus on discussing a generic solution that involves a minimum number 
of parties in an organization for API automation. Although the diagram shows three parties, there could be more or less, 
depending on the organization’s structure.

-   API Developers: Develop APIs and related services
-   API Publishers: Publish APIs to users
-   DevOps: Control the deployment process

API Developers and Publishers work with a version control system, which acts as a single source of truth for the pipeline. 
API Developers can use WSO2 API Manager Publisher to create APIs. CI/CD for API Manager relies on a Version Control 
system which acts as a Single Source of Truth for the pipeline. After APIs are exported from one environment, promoting 
it to the other environment is done via the **apictl**. It is capable of handling 
environment-related configurations and can promote the API seamlessly to other environments via a single command.  

Let us check out the basic building blocks for creating a CI/CD pipeline with WSO2 API-M.

### Preparing Environments

1.  Download and install WSO2 API Manager 3.0 in your environments. For more information, visit [here]({{base_path}}/InstallAndSetup/InstallationGuide/installation-prerequisites/).

2.  Download and setup WSO2 API Controller, `apictl`. For more information, visit [here]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).  

3.  Once the tool installed you can introduce API Manager environments using `add-env` command.

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

    For more information on adding environments, visit [here]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#add-an-environment). 

### Creating & Publishing API in Lower Environment

Now we have to added two different environments. Our end goal is to automate the API migration between dev and prod 
environments. So first the API shoulbe be published in dev environment using Publisher UI of API Manager. 
If you don’t know, visit [Quick Start Guide](http://localhost:8000/GettingStarted/quick-start-guide/) to learn how to 
deploy an API in the API Manager.   

For this example, we are gonna use the [Swagger Petstore API](https://petstore.swagger.io/). 

  1.  Start creating it by using `CREATE API` and selecting an existing API option. Then create the API and set its name 
  as `SwaggerPetstore` and Version as `1.0.0`.

      [![]({{base_path}}/assets/img/Learn/APIController/create-api.png)]({{base_path}}/assets/img/Learn/APIController/create-api.png)

  2.  Next, put backend URLs for Production and Sandbox and publish the API.  
      For this example, we can use,
      ```
      Production: http://dev.wso2.com
      Sandbox: http://dev.sandbox.wso2.com
      ```
    [![]({{base_path}}/assets/img/Learn/APIController/prod-dev-endpoints-petstore-api.png)]({{base_path}}/assets/img/Learn/APIController/prod-dev-endpoints-petstore-api.png)


### Exporting API from Lower Environment

The **apictl** can export an API as an archive from a lower environment, which contains all the information to recreate the API on another upper environment.

1.  Before exporting an API, we need to login to the API Manager in the lower environment from the **apictl**.

    !!! example
        ``` bash
        apictl login dev -u admin -p admin -k
        ```

    For more information on login to environments, visit [Login to an Environment]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#login-to-an-environment).

2. Then we can export the API from the lower environment using `export-api` command.

    !!! example
        ``` bash
        apictl export-api -e dev -n SwaggerPetstore -v 1.0.0 --provider admin
        ```

  For more information on exporting APIs, visit [Export an API]({{base_path}}/Learn/APIController/migrating-apis-to-different-environments/#export-an-api).

### Preparing an API Project for CI/CD

1.  After exporting the API as an archive, extract the content (API will be be exported as an archive to 
`<USER_HOME>/.wso2apictl/exported/apis/dev/` directory). After extraction, you will find a directory called 
`SwaggerPetstore-1.0.0`.

2.  Copy this directory into your Version Control Repository. Rename it to `SwaggerPetstore` for easy reference.

3.  Next, when we promoting API to the production environment we want to have different backend URLs for Production and 
Sandbox. To allow easily configuring environment-specific details, **apictl** supports an additional parameter file named `api_params.yaml`. It is recommended to store parameter file with the API Project, however it can be stored anywhere as 
required and provide as a flag with `import-api` command.

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
        As you can see we have defined *prod.wso2.com* and *prod.sandbox.wso2.com* as backend URLs for the production 
        environment.  

    [![]({{base_path}}/assets/img/Learn/APIController/creating-env-based-artifacts.png)]({{base_path}}/assets/img/Learn/APIController/creating-env-based-artifacts.png)        

    !!! info
        - The tool reduces the pipeline’s complexity and provides a simple and powerful mechanism to handle environment-specific configurations.
        - You can define both production and sandbox backend endpoints and additional configurations for the environments 
        such as retry/suspend timeouts, gateway environments etc, in `api_params.yaml`.  
        - Backend certificates for each URL can be configured. For certificates, a valid path to the certificate file is 
        required. They can be stored in the Automation Server.
        - The apictl supports detecting environment variables defined in usual notation. If an environment variable is 
        not set, the tool will fail and request for a set of required environment variables on the system. This is to 
        ensure that information is not missing during the migration process.
        - We recommend keeping API and environment-specific parameters in separate repositories.
        - For more information on using an environment parameter file, refer 
        [Configuring Environment Specific Parameters]({{base_path}}/Learn/APIController/migrating-apis-to-different-environments/#configuring-environment-specific-parameters).


4.  Now we can commit this project to a version control system.        

### Importing API to Upper Environment

The Automation Server can be configured to run a specific pipeline for promoting artifacts to other environments. 
The DevOps team can develop this pipeline further to include automated tests, workflow approvals, and other tasks.  

The **apictl** tool should be installed in automation servers to begin the process. Since the tool supports a variety of platforms, including Linux/Windows and macOS, this can be done easily. The apictl tool supports importing API Projects via the `import-api` command. This command is mainly used in the pipeline to migrate to different environments.

1.  We can try out importing SwaggerPetstore API into the production environment and test if the API works. To do this,
    execute the following sample command,

    !!! warning
        Make sure you have already logged-in to the `prod` environment. For more information, refer 
        [Login to an Environment]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#login-to-an-environment).

    !!! example
        ```bash
        apictl import-api -f ./SwaggerPetstore -e prod --preserve-provider=false --update=true
        ```
    !!! note
        -   When the update flag is presented, API Manager will attempt to seamlessly update if an existing API is found 
        with the same name and version. 
        
        - The import command prepares an API Project for API Manager by processing the 
        parameter file. It determines which configuration should be processed to create an API Project by detecting the 
        environment used to import.

        - For more information on importing API to an environment, visit [Import an API]({{base_path}}/Learn/APIController/migrating-apis-to-different-environments/#import-an-api).

2.  Now the tool will automatically detect the target environment and prepare a new artifact containing 
environment-related details. 

3. You can investigate that the API has been imported with correct environment-specific details you defined and you can 
also see the API is in the published state too.
!!! info  
    -   When exporting an API, the apictl tool will also export the API’s lifecycle status. When importing to another 
    environment, this lifecycle status will be preserved. This ensures that the API has the same state across environments. 
    
    -   For example, if an API is in the Published state in the development environment, it will also be in the same state 
    in the testing environment. This default behavior can be changed via the apictl tool, which assigns APIs the Created 
    state after importing. 

### Swagger/OpenAPI-based API CI/CD

WSO2 API Manager supports OpenAPI/Swagger specifications to create APIs. The apictl can generate projects with Swagger/OpenAPI specifications without using API-M Publisher. This powerful feature can be used to design pipelines that depend on Swagger/OpenAPI specifications.   

Based on API Project generation, a powerful pipeline for API automation can be developed with OpenAPI/Swagger. 
It allows rapid API development and increases developer productivity.

!!! example
    ```bash
    apictl init PetstoreAPI --oas path/to/petstore.yaml
    ```
For more information, on initializing an API Project using OpenAPI/Swagger Specification, visit 
[Initialize an API Project]({{base_path}}/Learn/APIController/importing-apis-via-dev-first-approach/#initialize-an-api-project).

[![]({{base_path}}/assets/img/Learn/APIController/api-automation-with-openapi-swagger.png)]({{base_path}}/assets/img/Learn/APIController/api-automation-with-openapi-swagger.png)

!!! info
    - This generates an API project in the PetstoreAPI directory using provided specification. This project can be directly 
    imported into the API Manager.
    - The apictl allows further customization to project initialization using a template file. Organization-specific 
    common details can be put into this template file and shared across developers to increase productivity.
    - To further finetune API creation, an additional API Definition file can be used. This definition file supports detecting environment variables during the creation process. It can be combined with scripting to develop powerful tools for 
    automating API Project creation.
    - With this, the Swagger/OpenAPI specification becomes a single source of truth for API deployment. By combining 
    templating and definition file automation servers can be configured to initialize API Projects from Swagger/OpenAPI 
    specifications and also have custom parameter files. This reduces human intervention and boosts productivity.
    - For example, when an organization depends on microservices architecture, this method can be utilized to create an automated pipeline to take Swagger/OpenAPI specification to upper environments.

Now you know the building blocks of creating a CI/CD pipeline using apictl. By using the above, you can create 
an automated pipeline for API promotion between environments for any preferred approach. 

Let us see how we can use the above knowledge to create a Jenkins CI/CD Pipeline with WSO2 API Management for Dev First
Approach.

-   [Building a Jenkins CI/CD Pipeline for Dev First Approach]({{base_path}}/Learn/APIController/building-jenkins-ci-cd-pipeline-for-dev-first-approach/)





