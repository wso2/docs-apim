# CI/CD for APIs - Using the CLI

When you implement CI/CD for your APIs, there are two approaches you can use.

-   **Using the CLI**

    WSO2 API-M supports OpenAPI/Swagger specifications to create APIs. The **apictl** can generate projects with Swagger/OpenAPI specifications without using the API Publisher in WSO2 API-M. This powerful feature can be used to design pipelines that depend on Swagger/OpenAPI specifications.   

    Based on the API Project generation, a powerful pipeline for API automation can be developed using OpenAPI/Swagger. This allows rapid API development and increases developer productivity.

    [![]({{base_path}}/assets/img/learn/api-controller/api-automation-with-openapi-swagger.png)]({{base_path}}/assets/img/learn/api-controller/api-automation-with-openapi-swagger.png)


    **To migrate APIs using the Developer First approach via CI/CD** carry out <a href="#A">A</a>, <a href="#D">D</a>, <a href="#E">E</a>, <a href="#F">F</a> and <a href="#G">G</a>, which is listed under the Building blocks for creating a CI/CD pipeline section, in sequential order.

-   **Using the Publisher and CLI**

    API Developers can use the API Publisher in WSO2 API-M to create APIs in a lower environment. CI/CD for WSO2 API-M relies on a Version Control system that acts as a Single Source of Truth for the pipeline. Therefore, after the API Developer exports the APIs from the lower environment, the API Developer can commit the exported API artifacts to a source code management repository, run the tests in the lower environment, promote the APIs to an upper environment and generate keys for promoted APIs. This process of promoting the API seamlessly to multiple environments can be automated via the **apictl** tool and other CI/CD tools (e.g., Jenkins, GitHub). The **apictl** tool makes this process simpler as it handles per environment-related configurations. 

    **To migrate the existing APIs using the API Publisher via CI/CD** carry out the steps mentioned in <a href="#A">A</a>, <a href="#B">B</a>, <a href="#C">C</a>, <a href="#E">E</a>, <a href="#F">F</a> and <a href="#G">G</a>, which is listed under the Building blocks for creating a CI/CD pipeline section, in sequential order.

## Get started!

Let us check out the basic building blocks for creating a CI/CD pipeline with WSO2 API-M in sequential order.

### Step 1 - Prepare the environments

1.  Download and install WSO2 API-M 4.0.0 in your environments.
     
     For more information, see [installation Prerequisites]({{base_path}}/install-and-setup/install/installation-prerequisites/).

2.  Download and setup apictl 4.0.0 version. 

     For more information, see [Download and initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).  

3.  Add WSO2 API-M environments using the `add env` command.

    !!! example
        ``` bash tab="Linux/Unix"
        apictl add env dev \
                    --apim https://localhost:9443 

        apictl add env prod \
                    --apim https://localhost:9444 
        ```

        ``` bash tab="Mac/Windows""
        apictl add env dev --apim https://localhost:9443 

        apictl add env prod --apim https://localhost:9444 
        ```    

    For more information, see [Add an environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#add-an-environment).
    
    !!!note
        `apictl add-env` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl add env` as shown above. 

### Step 2 - Create, Deploy and Publish an API in a lower environment

Now, you have added two different environments. Our end goal is to automate the API migration between the `dev` and `prod` environments. 
Therefore, first, the API should be created with relevant information, create a new revision, deploy the revision in relevant gateways 
and publish in the `dev` environment using the API Publisher in WSO2 API-M. 
For more information on deploying an API in the WSO2 API-M, see the [Quick Start Guide](http://localhost:8000/getting-started/quick-start-guide/).   

For this example, let us use the [Swagger Petstore - OpenAPI 3.0](https://petstore3.swagger.io/). 

  1.  Sign in to the API Publisher.
       
      `https://localhost:9443/publisher`
  
  2. Click **CREATE API** and select **I have an existing REST API**. 
  
  3. Create the API and define its name as `SwaggerPetstore` and Version as `1.0.0`.

      [![]({{base_path}}/assets/img/learn/api-controller/create-api.png)]({{base_path}}/assets/img/learn/api-controller/create-api.png)

 4. Enter the backend URLs for the Production and Sandbox environments, and publish the API.

      For this example, let us use the following endpoints.

      ```
      Production: http://dev.wso2.com
      Sandbox: http://dev.sandbox.wso2.com
      ```

     [![]({{base_path}}/assets/img/learn/api-controller/prod-dev-endpoints-petstore-api.png)]({{base_path}}/assets/img/learn/api-controller/prod-dev-endpoints-petstore-api.png)

### Step 3 - Export an API from a lower environment

The **apictl** can export an API as an archive from a lower environment (i.e., dev), which contains all the information to recreate the API on another upper environment (i.e., prod).

1.  Sign in to the WSO2 API-M in the lower environment via the **apictl**.

    !!! example
        ``` bash
        apictl login dev -u admin -p admin 
        ```

     For more information, see [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).

    !!! tip
        A user with `Internal/devops` role or `admin` role are allowed to export APIs. To create a custom user who can export APIs, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

2. Export the latest revision of the API from the lower environment using the `export api` command.

    !!! example
        ``` bash
        apictl export api -e dev -n SwaggerPetstore -v 1.0.0 --provider admin --latest
        ```

     For more information, see [Export an API]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/migrating-apis-to-different-environments/#export-an-api).
    
    !!!note
        - Here we are assuming that the latest revision is up to date with all the changes. If needed, you can remove the `--latest`
        flag and export the working copy without deployment information.
        - `apictl export-api` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl export api` as shown above.

3.  Extract the content (API will be exported as an archive to the 
`<USER_HOME>/.wso2apictl/exported/apis/dev/` directory). After extraction, you will find a directory named 
`SwaggerPetstore-1.0.0`. Rename it to `SwaggerPetstore` for easy reference.

### Step 4 - Initialize the project using a Swagger/OpenAPI specification

Execute the following command to directly generate the `PetstoreAPI` project using a Swagger/OpenAPI specification. (You can download the Swagger/OpenAPI specification from [here](https://github.com/OAI/OpenAPI-Specification/blob/master/examples/v2.0/yaml/petstore.yaml).)

!!! example
    ```bash
    apictl init PetstoreAPI --oas path/to/petstore.yaml
    ```

- This generates an API project in the `PetstoreAPI` directory using the provided specification. This project can be directly imported into the API Manager.
- The **apictl** allows further customization to the project initialization using a template file. Organization-specific common details can be added into this template file and shared across developers to increase productivity.
- To further finetune API creation, an additional API Definition file can be used. This definition file supports detecting environment variables during the creation process. It can be combined with scripting to develop powerful tools for automating API Project creation.
- Using this method, the Swagger/OpenAPI specification becomes a single source of truth for API deployment. By combining templating and the definition file, the automation servers can be configured to initialize API Projects from Swagger/OpenAPI specifications and also have custom parameter files. This reduces human intervention and boosts productivity.
- For example, when an organization depends on a microservices architecture, this method can be utilized to create an automated pipeline to move Swagger/OpenAPI specifications to upper environments.

For more information on initializing an API Project using OpenAPI/Swagger Specification, see 
[Initialize an API Project]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-apis-via-dev-first-approach/#initialize-an-api-project).

### Step 5 - Prepare an API project for CI/CD

1. Copy this directory into your Version Control Repository.
    
    - If you are using the Dev First approach - Copy the initialized project directory.
    - If you are using the Publisher based approach - Copy the extracted project directory.

2. Define the environment-specific details in the parameter file.

     Define the *prod.wso2.com* and *prod.sandbox.wso2.com* as the backend URLs in this file.
     
     It is recommended to store the parameter file with the API Project; however, you can store it anywhere as required and provide the location to this file as a flag when using the `import api` command.

    !!! example
        ```bash
        environments: 
            - name: dev 
                configs:
                    endpoints: 
                        production: 
                            url: 'http://dev.wso2.com' 
                        sandbox:
                            url: 'http://dev.sandbox.wso2.com' 
                    deploymentEnvironments:
                        - displayOnDevportal: true
                          deploymentEnvironment: Default
                          deploymentVhost : localhost
                        - displayOnDevportal: true
                          deploymentEnvironment: Label1
                          deploymentVhost : us.wso2.com 
            - name: prod
                configs:
                    endpoints:
                        production:
                            url: 'http://prod.wso2.com'
                        sandbox:
                            url: 'http://prod.sandbox.wso2.com'
                    deploymentEnvironments:
                        - displayOnDevportal: true
                          deploymentEnvironment: Label2
                          deploymentVhost : localhost
                        - displayOnDevportal: true
                          deploymentEnvironment: Label3
                          deploymentVhost : us.wso2.com 
        ```  

     [![]({{base_path}}/assets/img/learn/api-controller/creating-env-based-artifacts.png)]({{base_path}}/assets/img/learn/api-controller/creating-env-based-artifacts.png)        

    !!! info
        - The tool reduces the pipeline’s complexity and provides a simple and powerful mechanism to handle environment-specific configurations.
        - You can define both production and sandbox backend endpoints and additional configurations for the environments such as retry/suspend timeouts, gateway environments, etc. in the params file.  
        - Backend certificates for each URL can be configured. For certificates, a valid path to the certificate file is required. These paths can be stored in the Automation Server.
        - The **apictl** supports detecting environment variables defined in usual notation. If an environment variable is not set, the tool will fail. Also, the system will request the user for a set of required environment variables to ensure that information is not missing during the migration process.
        - It is recommended to store API and environment-specific parameters in separate repositories.
        - For more information on using an environment parameter file, see [Configuring Environment Specific Parameters]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters).


3.  Commit the project to the version control system.        

### Step 6 - Import the API to an upper environment

The Automation Server can be configured to run a specific pipeline for promoting artifacts to other environments. 
The DevOps team can develop this pipeline further to include automated tests, workflow approvals, and other tasks.  

The **apictl** tool should be installed in the automation servers to begin the process. As the tool supports a variety of platforms, including Linux/Windows and macOS, this can be done easily. 

#### a. Promoting APIs in a Git repository to upper environments via CI/CD

The repository that you committed the project in the above step <a href="#E">E</a> needs to be cloned into the instance that is executing the CI/CD process. The API controller (**apictl**) has inbuilt support for integrating with a Git-based version control system. It gives a unified command `vcs deploy` to deploy any type of project (e.g., APIs, API Products, and Apps).

1.  Navigate to the directory that has the cloned Git repository.
    ```bash
    $ cd <cloned-repository-name>
    ```
2.  As this is the first time that the repository is used for Git Integration functionality of apictl, run `vcs init` command to initialize the repository with apictl. This needs to run only once for the repository.

    !!! example
        ```bash
        $ apictl vcs init
        Successfully initialized GIT repository
        ```

    Once `vcs init` command is executed, a new file `vcs.yaml` will be created in the root location of the repository. 
    
    Make sure to commit this file to the repository.   

    !!! tip
        `vcs.yaml` will contain a unique identifier for the repository which is used to store deployed commits related meta-information.

3.  Run `vcs status` command to see the available changes that needs to be deployed to the production environment.

    !!! example
        ```bash
        $ apictl vcs status -e prod
        Projects to Deploy (1)

        APIs (1) ...
        1: [save]		SwaggerPetstore-1.0.0: (SwaggerPetstore-1.0.0)
        ```

4.  Import the **SwaggerPetstore** API into the production environment by running the following sample command.

    !!! tip
        - Make sure you have already logged-in to the `prod` environment. For more information, see 
        [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).

        - A user with `Internal/devops` role or `admin` role are allowed to import APIs. To create a custom user who can import APIs, see [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#minimal-permissions-and-scopes-required-to-perform-apictl-operations).

    !!! example
        ```bash
        $ apictl vcs deploy -e prod
        Deploying Projects (1)...

        APIs (1) ...
        1: SwaggerPetstore-1.0.0: (SwaggerPetstore-1.0.0)
        Successfully imported API
        ```

    The above command will detect the target environment and provision the API to it.

    If you run `vcs deploy` command again, you will see the following output indicating that the deployment is already up-to-date.

    !!! example
        ```bash
        $ apictl vcs deploy -e prod
        Everything is up-to-date
        ```

5.  Adding a new API to the Git repository

    Multiple APIs can be promoted through CI/CD by committing the respective API projects to the repository.

    1.  Create another API Project (**Pizzashack-1.0.0**) by following the steps (<a href="#B">B</a>,<a href="#C">C</a>) OR <a href="#D">D</a>.
    
    2.  Commit the project to the Git repository.

    3.  Run `vcs status` command to verify the new project addition.

        ```bash
        $ apictl vcs status -e prod
        Projects to Deploy (1)

        APIs (1) ...
        1: [save]		Pizzashack-1.0.0: (Pizzashack-1.0.0)
        ```

    4.  Run `vcs deploy` command to deploy the new API to the production environment.

        ```bash
        $ apictl vcs deploy -e prod
        Deploying Projects (1)...

        APIs (1) ...
        1: Pizzashack-1.0.0: (Pizzashack-1.0.0)
        Successfully imported API
        ```

        Here, **apictl** will deploy only the new API **Pizzashack-1.0.0** without re-deploying the other unchanged API **SwaggerPetstore-1.0.0**.

    !!! important
        For deploying an API using `vcs deploy` command: 
        
        -   It is mandatory to have your API projects in a Git based version control system.
        -   It is mandatory to have `api_params.yaml` file inside each API Project. This is created by default when you export an API using `export api` or initialized an API Project using `init`. The following configuration section in the `api_params.yaml` file is used to deploy the API.

        ```bash
        deploy:
            import:
                update: true
                preserveProvider: true
        ```

        You can change the above fields accordingly.

        | Field           | Description                                                                              |
        |-----------------|------------------------------------------------------------------------------------------|
        | update          | Used to specify whether to update the API if it already exists during the deployment     |
        | preserveProvider| Preserve existing provider of API after importing it                                     |
        

#### b. Promoting a single API via CI/CD to upper environments

You can use the following alternative approach to promote a single API via CI/CD. This method is ideal if your CI/CD pipeline is not built based on Git.

1.  Import the **SwaggerPetstore** API into the production environment and test the API by running the following sample command.

    !!! example
        ```bash
        apictl import api -f ./SwaggerPetstore -e prod --preserve-provider=false --update=true --rotate-revision
        ```
    !!! note
        -   When the update flag is present, WSO2 API-M will attempt to seamlessly update if an existing API is found with the same name and version. 
        
        - The import command prepares an API Project for WSO2 API-M by processing the parameter file. It determines which configuration should be processed to create an API Project by detecting the environment that has been used to import it.
        - If the API project as specified the deployment environment information, when the working copy is updated during the update process, a new 
        revision will be created. If the maximum number of revisions (5) reached for the API and `--rotate-revision` 
        flag is present, the earliest revision for that API will be deleted and a new revision will be created.

        - For more information on importing an API to an environment, see [Import an API]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/migrating-apis-to-different-environments/#import-an-api).
        
        - `apictl import-api` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl import api` as shown above.

    The above command will detect the target environment and provision the API to it.

3. Sign in to the API Publisher.

     `https://localhost:9444/publisher`

4. Check the details of the API.
     
     You will see that the API has been imported with correct environment-specific details that you defined. 
     - If you have followed, <a href="#A">A</a>, <a href="#B">B</a>, <a href="#C">C</a>, <a href="#E">E</a>, and <a href="#F">F</a>, then you can see that your API is in the `PUBLISHED` state.
     - If you have followed <a href="#A">A</a>, <a href="#D">D</a>, <a href="#E">E</a>, and <a href="#F">F</a>, then you can see that your API is in the `CREATED` state.

!!! info  
    -   When exporting an API, the **apictl** tool will also export the API’s lifecycle status. When importing to another environment, this lifecycle status will be preserved. This ensures that the API has the same state across environments. 
    
    -   For example, if an API is in the `PUBLISHED` state in the development environment, it will also be in the same state in the testing environment. This default behavior can be changed via the **apictl** tool, which assigns APIs the `CREATED` state after importing. 

### Step 7 - Get keys for an API/API Product

Follow the instructions below to generate a JWT/OAuth token for testing purposes using apictl in order to invoke an API or an [API Product]({{base_path}}/design/create-api-product/api-product-overview) by subscribing to it using a new application created by apictl:

!!! tip
    - Make sure that WSO2 API-M is started and the apictl is set up. For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl). 
    - You should log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).

Run any of the following apictl commands to get keys for the API/API Product.

- **Command**

    ```bash
    apictl get keys -n <API or API Product name> -v <API version> -r <API or API Product provider> -e <environment> 
    ```  

    ```bash
    apictl get keys --name <API or API Product name> --version <API version> --provider <API or API Product provider> --environment <environment> 
    ```

    !!! example
        ```bash
        apictl get keys -n PizzaShackAPI -e dev 
        ```

    !!! example
        ```bash
        apictl get keys -n PizzaShackAPI -v 1.0.0 -e dev  -r admin -t https://localhost:8243/token
        ```
    !!! info
        **Flags:**  
            
        -   Required :  
            `--environment` or `-e` : Key generation environment  
            `--name` or `-n` : API or API Product to generate keys for   
        -   Optional :  
            `--token` or `-t` : New token endpoint of the environment (This overrides the previously provided token endpoint that was provided using the `add env` command)       
            `--provider` or `-r` : Provider of the API or API Product  
            `--version` or `-v` : Version of the API (Currently API Products do not have versions)

    !!! note
        - Both the flags (`--name` (`-n`) and `--environment` (`-e`)) are mandatory.

        - You can override the given token endpoint or the default token endpoint using the `--token` (`-t`) optional flag together with the new token endpoint.

        - `apictl get-keys` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl get keys` as shown above.

!!! info
    - Upon running the above command, the apictl tool will create a default application in the environment, subscribe to the API, and generate keys based on the token type defined in the `<USER_HOME>/.wso2apictl/main-config.yaml`file. 
    - Using apictl tool the HTTP request timeout, and export directory can be set up and changed. For more information on changing the HTTP request timeout, see [Set HTTP request timeout]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#set-http-request-timeout) and [Set export directory]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/##set-export-directory) accordingly. 
    - When running the above command, if you have not specified the --version (-v), the tool will consider the version as 1.0.0 by default. If you have specified the version, then that value will be considered.

### Step 8 - Extending a CI/CD pipeline to support API Products

For example, let us consider there is an [API Product]({{base_path}}/design/create-api-product/api-product-overview) **PetsInfo** in the development environment with a subset of operations of **SwaggerPetstore** API.

1.  Export the API Product using `export api-product` command from the development environment (dev).

    ```bash
    $ apictl export api-product -n PetsInfo -e dev --latest
    
    Successfully exported API Product!
    Find the exported API Product at /home/wso2user/.wso2apictl/exported/api-products/dev/PetsInfo_1.0.0.zip
    ```

2.  Extract the exported API Product Project.

3.  Commit the project to the Git repository.

4.  Run `vcs status` command to see the available changes that needs to be deployed to the production environment.

    !!! example
        ```bash
        $ apictl vcs status -e prod
        Projects to Deploy (1)

        API Products (1) ...
        1: [save]		PetsInfo-1.0.0: (PetsInfo-1.0.0)
        ```

    !!! important
        If you haven't initialized the repository with API Controller, you will get the below error.
        
        ```bash
        $ apictl vcs status -e prod
        apictl: The repository info: vcs.yaml is not found in the repository root. If this is the first time you are using this repo, please initialize it with 'vcs init'.
        Exit status 1
        ```

        make sure to follow [Promoting APIs in a Git repository to upper environments via CI/CD](#a-promoting-apis-in-a-git-repository-to-upper-environments-via-cicd) - *Step 2* to initialize the repository.

3.  Import the **PetsInfo** Product into the production environment by running the following sample command.

    !!! example
        ```bash
        $ apictl vcs deploy -e prod
        Deploying Projects (1)...

        API Products (1) ...
        1: PetsInfo-1.0.0: (PetsInfo-1.0.0)
        Successfully imported API Product
        ```

    The above command will detect the target environment and create the **PetsInfo** Product in the target environment.
    
    !!! important
        For deploying an API Product using `vcs deploy` command: 
        
        -   It is mandatory to have your API Product projects in a Git based version control system.
        -   It is mandatory to have `api_product_params.yaml` file inside each API Product Project. This is created by default when you export an API Product using `export api-product`. The following configuration section in the `api_product_params.yaml` file is used to deploy the API Product.

        ```bash
        deploy:
            import:
                updateApiProduct: true
                preserveProvider: true
                importApis: true
                updateApis: false
        ```

        You can change the above fields accordingly.

        | Field           | Description                                                                                 |
        |-----------------|---------------------------------------------------------------------------------------------|
        | updateApiProduct| Used to specify whether to update the API Product if it already exists during deployment|
        | preserveProvider| Preserve the existing provider of the API Product after importing it                            |
        | importApis      | Import the dependant API(s) along with the API Product if the dependant API(s) are not available in the target environment|
        | updateApis      | Update the dependant API(s) in the target environment                                       |

    !!! tip
        Multiple API product projects can be promoted through CI/CD by committing them to the same repository.

### Step 9 - Extending a CI/CD pipeline to support applications

Let us assume that the **PetsApp** application is in the development environment which is already subscribed to the **SwaggerPetstore** API.

1.  Export the Application using the `export app` command from the development environment (dev). Note that `--with-keys` option is used to export the subscriptions and keys (if any) of the application.

    ```bash
    $ apictl export app --name PetsApp --owner david -e dev --with-keys

    Successfully exported Application!
    Find the exported Application at /home/wso2user/.wso2apictl/exported/apps/dev/david_PetsApp.zip
    ```

    !!!note
        `apictl export-app` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl export app` as shown above.

2.  Extract the exported Application Project.
3.  Commit the project to the same git repository.
4.  Run the `vcs status` command to see the available changes that need to be deployed to the production environment.

    !!! example
        ```bash
        $ apictl vcs status -e prod
        Projects to Deploy (1)

        Applications (1) ...
        1: [save]		PetsApp: (PetsApp)
        ```

    !!! important
        If you haven't initialized the repository with API Controller, you will get the below error.
        
        ```bash
        $ apictl vcs status -e prod
        apictl: The repository info: vcs.yaml is not found in the repository root. If this is the first time you are using this repo, please initialize it with 'vcs init'.
        Exit status 1
        ```

        make sure to follow [Promoting APIs in a Git repository to upper environments via CI/CD](#a-promoting-apis-in-a-git-repository-to-upper-environments-via-cicd) - *Step 2* to initialize the repository.

3.  Import the **PetsApp** Application into the production environment by running the following sample command.

    !!! example
        ```bash
        $ apictl vcs deploy -e prod
        Deploying Projects (1)...

        Applications (1) ...
        1: PetsApp: (PetsApp)
        Successfully imported Application
        ```

    The above command will detect the target environment and create the application in the target environment.

    !!! important
        For deploying an application using `vcs deploy` command:
        
        -   It is mandatory to have your Application projects in a Git based version control system.
        -   It is mandatory to have `application_params.yaml` file inside each application project. This is created by default when you export an Application using `export app`. The following configuration section in the `application_params.yaml` file is used to deploy the application.

        ```bash
        deploy:
            import:
                update: true
                preserveOwner: true
                skipSubscriptions: false
                skipKeys: true
        ```

        You can change the above fields accordingly.

        | Field             | Description                                                                                 |
        |-------------------|---------------------------------------------------------------------------------------------|
        | update            | Used to specify whether to update the application if it already exists during the deployment|
        | preserveOwner     | Preserve existing owner of the application after importing it                               |
        | skipSubscriptions | Specifies whether to import the subscriptions of the application                            |
        | skipKeys          | Specifies whether to import the credentials of the application                              |

    !!! tip
        Multiple applications could be promoted through CI/CD by committing those application projects to the same repository.


Now, you know the building blocks of creating a CI/CD pipeline using **apictl**. By using the above, you can create 
an automated pipeline for API promotion between environments using either one of the latter mentioned approaches. 

!!! More
    Next let us use the above knowledge to create a [Jenkins CI/CD Pipeline with WSO2 API Management for a Dev First Approach]({{base_path}}/install-and-setup/setup/api-controller/building-jenkins-ci-cd-pipeline-for-dev-first-approach/).
