# Building a Jenkins CI/CD Pipeline for Dev First Approach

By using a developer-first approach, an organization can adopt to have minimal interaction between the API developer 
and API Publisher Portal. First, an API developer develops his/her own backend microservice and creates an OpenAPI 
Specification for it. Thereafter, he/she can create an API using that OpenAPI specification and deploy it to the desired 
WSO2 API Manager (WSO2 API-M) environment without accessing the Publisher Portal directly.

Let us create a CI/CD pipeline using Jenkins as the automation tool and Github as the source code management repository. Let us use Postman to write the test scripts in order to test the API that is deployed in WSO2 API-M.

## Prerequisites

1.  Install Jenkins from [here](https://jenkins.io/doc/book/installing/).

2.  Install [npm and nodejs plugins](https://wiki.jenkins.io/display/JENKINS/NodeJS+Plugin) and [Newman](https://learning.getpostman.com/docs/postman/collection-runs/integration-with-jenkins/#installation) globally 
in your Jenkins server.  

     [![install node-npm-jenkins]({{base_path}}/assets/img/learn/api-controller/install-node-npm-jenkins.png)]({{base_path}}/assets/img/learn/api-controller/install-node-npm-jenkins.png)   

3.  Download and setup [WSO2 API-M 4.0.0](https://wso2.com/api-management/) in Development and Production environment servers. 
     
     For more information, see [installation-prerequisites]({{base_path}}/install-and-setup/install/installation-prerequisites/).

4. Download and setup [WSO2 API Controller 4.0.0 version](https://wso2.com/api-management/tooling/) to the Jenkins server and the
developer machines. 
     
     For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).  

     [![Setup apictl in Jenkins]({{base_path}}/assets/img/learn/api-controller/setup-apictl-jenkins.png)]({{base_path}}/assets/img/learn/api-controller/setup-apictl-jenkins.png)
  
!!! info
    For this tutorial, let us use a sample backend Ballerina [service](https://github.com/dushaniw/wso2-apim-cicd-apis/blob/master/SampleStoreService/samplestore.bal) for the SampleStore Application. 

    There are two environments, namely development and production, and there are dedicated backend services for 
    these two environments running at `http://dev.wso2.com:9090/samplestore` and `http://prod.wso2.com:9090/samplestore`.


## Building the pipeline

[![]({{base_path}}/assets/img/learn/api-controller/ci-cd-for-dev-first-approach.png)]({{base_path}}/assets/img/learn/api-controller/ci-cd-for-dev-first-approach.png)

### Step 1 - Write the OpenAPI Specification and test scripts

As the API Developer, initially write the OpenAPI Specification for the backend API and write the test scripts to test the API in the lower WSO2 API-M environment (i.e., development environment).

!!! tip

    The sample OpenAPI specification for the backend API that is used in this tutorial is available [here](https://github.com/dushaniw/wso2-apim-cicd-apis/blob/master/SampleStoreService/store.yaml).

    A sample test script to test the API that is going to be deployed in WSO2 API-M development environment is available [here](https://github.com/dushaniw/wso2-apim-cicd-apis/blob/master/SampleStoreService/sample_store.postman_collection.json). 
    
    This sample JS test script was written using 
    [Postman](https://learning.getpostman.com/docs/postman/scripts/test-scripts/) by importing the OpenAPI definition 
    and defining environment variables. Our goal is to run the test script within the pipeline using Postman’s CLI 
    Collection Runner, 
    [Newman](https://learning.getpostman.com/docs/postman/collection-runs/command-line-integration-with-newman/). 

### Step 2 - Initialize an API project

Initialize an API Project using the OpenAPI definition, API definition template, and the environment variables.

!!! warning
    **Before you begin...**   

    -   As the API Developer, make sure apictl is initialized and running in your local machine, 
    if not follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
    
    
Run the following sample command to initialize an API Project using the apictl by providing the OpenAPI specification and API Definition template. For more information, see [Initialize an API Project]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-apis-via-dev-first-approach/#initialize-an-api-project).

!!! example
    ``` bash
    apictl init SampleStore --oas store.yaml --definition api_template.yaml 
    ```
    [![init samplestore api project]({{base_path}}/assets/img/learn/api-controller/init-samplestore-api-project.png)]({{base_path}}/assets/img/learn/api-controller/init-samplestore-api-project.png)  

When running the above command, you can inject data into the definition template using environment variables. 
    
!!! info
    When you create an API Project, APIs are generated using a default template. To further finetune the process of creating the API and to include organization-specific common API related details, you can use a custom API Definition file. 
    For more information, see [Initialize an API project]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-apis-via-dev-first-approach/#initialize-an-api-project).

!!! tip
    The custom API template used in this tutorial is available [here](https://gist.github.com/dushaniw/fdbb460f971730a661e75b29eb4e7999#file-api_template-yaml).
    It includes the minimum information that you need to create the SampleStore API Project including, the API name, version, 
    provider name, context, description, API tiers, backend URLs, etc.

    -   The context field has been kept blank so that you can automatically derive the context using the API name followed by the API version. 
    -   The API Status value is given as an environment variable, `STATE`. Before initializing the API Project, the developer needs to set up the environment variable `STATE` in the OS using the following command:   
        `export STATE=PUBLISHED`

### Step 3 - Update API data in the API project

Add a thumbnail image of any image file type with the name `icon.<img-extension>` into the `SampleStore/Image` directory of the SampleStore API Project.   

!!! info
    -   After initializing an API project, the developer can update the created API project files to add an API thumbnail, API documentation, Custom meditations, etc. In this tutorial, let us add a thumbnail for the API.

    -   Similarly, developers can add any additional meta information to the `api.yaml` file and also add the required API documentation and the required custom mediations to the respective folders of the same API project.

    -   To get an understanding of the directory structure of an API project, see 
    [Initialize an API Project]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-apis-via-dev-first-approach/#initialize-an-api-project).

### Step 4 - Define environment specific data

Define environment specific data in API parameter file. In this tutorial as there are two main environments, named `dev` and `prod`, create an environment template file that consists of the environment-specific configurations similar to [this file](https://gist.github.com/dushaniw/fdbb460f971730a661e75b29eb4e7999#file-env_template-yaml).  

!!! info
    -   When there are multiple environments, to allow easily configuring environment-specific details, `apictl` supports an additional parameter file.

    -   Once the file is placed in the project directory, the tool will auto-detect the parameters file upon running the `import api` command and create an environment-based artifact for API Manager. 

    -   If the `api_params.yaml` is not found in the project directory, the tool will lookup in the project’s base path and the current working directory.

    -   For more information on using an environment template, see [Configuring Environment Specific Parameters]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters). 

!!! tip
    The `retryTimeOut` is defined as an environment variable so that the actual value of it can be controlled using a 
    single variable based on the environment type. 

### Step 5 - Commit the API project 

Commit the API project with the required test scripts to the GitHub repository.

Add the test script developed in **Step 1**, into the same API Project for easy use and commit the API project along with the test scripts to a [GitHub](https://github.com/) source code management repository.

[![]({{base_path}}/assets/img/learn/api-controller/commit-api-project-github.png)]({{base_path}}/assets/img/learn/api-controller/commit-api-project-github.png)  
    
### Step 6 - Trigger Jenkins Pipeline 

Follow the instructions below to use a GitHub Webhook to trigger the Jenkins Pipeline.

!!! info
    -   A predefined pipeline in the CI tool will automatically trigger a build upon the commit to run tests and deploy it to 
    environments; such a pipeline has the following main steps.  

        1.  Check out the source code and deploy the API to a lower environment.
        2.  Run tests against the lower environment.
        3.  Deploy it to the upper environment.
        
    -   The deployment to environments can be done automatically using `apictl`.

1. Configure your source code repository in GitHub with a webhook to automatically start a Jenkins pipeline after you commit any changes. 
        
2. Add the two environments using the following sample `apictl` commands.

    !!! warning
        Make sure you have already installed `apictl` to the Jenkins server and set the Path variable. For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    !!! example
        ```bash
        apictl add env dev \
        --registration https://dev.apim.wso2.com \
        --apim https://dev.apim.wso2.com \
        --token https://dev.apim.wso2.com/token
        ```
        
        ```bash
        apictl add env prod \
        --registration https://prod.apim.wso2.com \
        --apim https://prod.apim.wso2.com \
        --token https://prod.apim.wso2.com/token
        ```

     For more information, see [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#add-an-environment).

    !!!note
        `apictl add-env` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl add env` as shown above. 
    
     You can also add an environment manually beforehand or provide the details as a shell script in the same pipeline.

3. Store the credentials for the two environments as Jenkins credentials.  

     [![]({{base_path}}/assets/img/learn/api-controller/jenkins-credentials.png)]({{base_path}}/assets/img/learn/api-controller/jenkins-credentials.png) 


4. Add the Jenkins pipeline configuration defined in [here](https://github.com/dushaniw/wso2-apim-cicd-apis/blob/master/jenkinsfile).

     [![]({{base_path}}/assets/img/learn/api-controller/jenkins-pipeline-build.png)]({{base_path}}/assets/img/learn/api-controller/jenkins-pipeline-build.png) 

     [![]({{base_path}}/assets/img/learn/api-controller/pipeline-config.png)]({{base_path}}/assets/img/learn/api-controller/pipeline-config.png) 

    !!! info
        -   The `RETRY` variable is defined with 80 milliseconds so that the production and sandbox endpoints of the API deployed in the dev environment has an endpoint retry timeout value of 80 milliseconds. 
        -   As the first step, this will log in to the dev environment using the provided Jenkins credentials and 
        then deploy the API into the dev environment using the `import api` command. 
        -   The `preserve-provider` and `update` flags, will preserve the API provider in the given API project and import the API to the development environment seamlessly.
        -   The next stage `Run Tests` will run the test script that you committed to the project in the Git repository using `Newman`. 
        -   If you need to use the same test script to run it against multiple environments, you can maintain a separate 
        environment file and provide that as an argument for the `Newman` run command. For more information, see [Using environments in collection runs](https://learning.getpostman.com/docs/postman/collection-runs/using-environments-in-collection-runs/).
        -   After the tests are passed, the next stage will deploy the API to the prod environment using the 
        `import api` command. Similar to the dev environment, you can provide any environment-specific variable 
        values here so that they will be injected into the API during the deployment.
    

Upon committing and pushing any changes to the remote repository, the webhook will automatically trigger a pipeline build on 
the Jenkins server.  

A successful pipeline build will have a similar console output to the following.     

[![]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-1.png)]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-1.png) 

[![]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-2.png)]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-2.png) 

[![]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-3.png)]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-3.png) 

[![]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-4.png)]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-4.png) 

[![]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-5.png)]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-5.png) 

[![]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-6.png)]({{base_path}}/assets/img/learn/api-controller/jenkins-cicd-pipeline-output-6.png) 


After the pipeline status changes to **SUCCESS**, when you navigate to the API Publisher in the dev and prod environments, you can see the **SampleStore** API is in the `PUBLISHED` state. 

If you check the endpoints, you can see the endpoint URLs are updated according to the dev and production environment configs. 

[![]({{base_path}}/assets/img/learn/api-controller/dev-samplestoreapi.png)]({{base_path}}/assets/img/learn/api-controller/dev-samplestoreapi.png)

[![]({{base_path}}/assets/img/learn/api-controller/prod-samplestoreapi.png)]({{base_path}}/assets/img/learn/api-controller/prod-samplestoreapi.png) 


Further, if you go and check the advanced endpoint configurations of the same API, you can see the retry timeout is updated to 80 and 60 milliseconds accordingly.

[![]({{base_path}}/assets/img/learn/api-controller/dev-advanced-config.png)]({{base_path}}/assets/img/learn/api-controller/dev-advanced-config.png) 

[![]({{base_path}}/assets/img/learn/api-controller/prod-advanced-config.png)]({{base_path}}/assets/img/learn/api-controller/prod-advanced-config.png) 

You have successfully created a basic CI/CD pipeline using **Jenkins** as the CI tool and **GitHub** as the SCM tool, to 
create and deploy an API using the **API/Dev first approach** with WSO2 API-M.