# Building a Jenkins CI/CD Pipeline for Dev First Approach

By using a developer-first approach, an organization can adopt to have minimal interaction between the API developer 
and API Publisher Portal. First, an API developer develops his own backend microservice and creates an OpenAPI 
Specification for that. Then, he can create an API using that OpenAPI specification and deploy it to the desired 
WSO2 API Management environment without accessing the Publisher Portal directly.

Let's see how we can create a CI/CD pipeline using Jenkins as the automation tool and Github as the source code management repository. We are using Postman to write the test scripts to test the API deployed in WSO2 API Manager.

[![]({{base_path}}/assets/img/Learn/APIController/ci-cd-for-dev-first-approach.png)]({{base_path}}/assets/img/Learn/APIController/ci-cd-for-dev-first-approach.png)

## Prerequisites

1.  Install Jenkins from [here](https://jenkins.io/doc/book/installing/).
2.  Install [npm and nodejs plugins](https://wiki.jenkins.io/display/JENKINS/NodeJS+Plugin) and [Newman](https://learning.getpostman.com/docs/postman/collection-runs/integration-with-jenkins/#installation) globally 
in your Jenkins server.  

    [![]({{base_path}}/assets/img/Learn/APIController/install-node-npm-jenkins.png)]({{base_path}}/assets/img/Learn/APIController/install-node-npm-jenkins.png)   

3.  Download and setup [WSO2 API-M 3.0](https://wso2.com/api-management/) in Development and Production environment servers. For more information, visit [here]({{base_path}}/InstallAndSetup/InstallationGuide/installation-prerequisites/).
4. Download and setup [WSO2 API Controller](https://wso2.com/api-management/tooling/) to the Jenkins server and the
developer machines. For more information, visit [here]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).  

    [![]({{base_path}}/assets/img/Learn/APIController/setup-apictl-jenkins.png)]({{base_path}}/assets/img/Learn/APIController/setup-apictl-jenkins.png)
  
!!! info
    For this tutorial, we are using a sample backend Ballerina [service](https://github.com/dushaniw/wso2-apim-cicd-apis/blob/master/SampleStoreService/samplestore.bal) for our SampleStore Application. 

    We have two environments named, development and production and have dedicated backend services for 
    these two environments running at *http://dev.wso2.com:9090/samplestore* and *http://prod.wso2.com:9090/samplestore*.


## Building the Pipeline

1.  **As the API Developer, first write the OpenAPI Specification for the backend API and write the     test scripts to test 
the API in lower WSO2 API-M environments**

    !!! tip

        The sample OpenAPI specification for the backend API used in this tutorial can be found from 
        [here](https://github.com/dushaniw/wso2-apim-cicd-apis/blob/master/SampleStoreService/store.yaml).

        A sample test script to test the API which is going to be deployed in WSO2 APIM-M development environment can be 
        found from [here](https://github.com/dushaniw/wso2-apim-cicd-apis/blob/master/SampleStoreService/sample_store.postman_collection.json). 
        
        This sample JS test script were written using 
        [Postman](https://learning.getpostman.com/docs/postman/scripts/test-scripts/) by importing the OpenAPI definition 
        and defining environment variables. Our goal is to run the test script within the pipeline using Postman’s CLI 
        Collection Runner, 
        [Newman](https://learning.getpostman.com/docs/postman/collection-runs/command-line-integration-with-newman/). 

2.  **Initialize an API Project using OpenAPI definition + API Definition Template + Environment Variables**

    !!! warning
        **Before you begin...**   

        -   As the API Developer, make sure WSO2 API Manager CTL Tool is initialized and running in your local machine, 
        if not follow the steps in [Download and Initialize the CTL Tool]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool)
    
    Run the following sample command to initialize an API Project using the CTL by providing OpenAPI specification and 
    API Definition template. For more information, 
    visit [Initialize an API Project]({{base_path}}/Learn/APIController/importing-apis-via-dev-first-approach/#initialize-an-api-project).

    !!! example
        ``` bash
        apictl init SampleStore --oas store.yaml --definition api_template.yaml -k
        ```
        [![]({{base_path}}/assets/img/Learn/APIController/init-samplestore-api-project.png)]({{base_path}}/assets/img/Learn/APIController/init-samplestore-api-project.png)  

    When doing above, you can inject data into the definition template using environment variables. 
    
    !!! info
        -   When you create an API Project, APIs are generated using the default template specified in 
            `$HOME/.wso2apictl/default_api.yaml` the file. Organization-specific common API related details can be put into this template file and shared across developers. To further finetune API creation, a custom API Definition file can be used.

    !!! tip
        The custom api template used in this tutorial can be found from [here](https://gist.github.com/dushaniw/fdbb460f971730a661e75b29eb4e7999#file-api_template-yaml).
        It includes minimal information that need to create the SampleStore API Project including the API name, version, 
        provider name, context, description, API tiers, backend URLs, etc.

        -   We have kept the context field blank, as we want to automatically derive the context using API name followed by 
            version. 
        -   The API Status value is given as an environment variable, `$STATE`. Before initializing the API Project, 
            developer needs to set up the environment variable $STATE in the OS using the command, `export STATE=PUBLISHED`.

3. **Update API data in the API Project**

    Add a thumbnail image of any image file type with the name `icon.<img-extension>` in to the `SampleStore/Image` directory
    of the SampleStore API Project.   

    !!! info
        -   After initializing an API project, the developer can update the created API project files to add an API thumbnail, 
        API documentation, Custom meditations, etc. In this tutorial, we will add a thumbnail for the API.

        -   Similarly, developers can add any additional meta information to the api.yaml and add API documentation, 
        custom mediations to the same API project.

        -   To learn about the directory structure of an API project, visit 
        [Step 3 - Initialize an API Project]({{base_path}}/Learn/APIController/importing-apis-via-dev-first-approach/#initialize-an-api-project).

4. **Define Environment Specific Data in API Parameter File**

    In this tutorial, we have two main environments, named `dev` and `prod`. So create an environment template file 
    consisting of the environment-specific configurations similar to [this](https://gist.github.com/dushaniw/fdbb460f971730a661e75b29eb4e7999#file-env_template-yaml).  

    !!! info
        -   When there are multiple environments, to allow easily configuring environment-specific details, **apictl** 
        supports an additional parameter file.

        -   Once the file is placed in the project directory, the tool will auto-detect the parameters file upon running the 
        `import-api` command and create an environment-based artifact for API Manager. If the `api_params.yaml` is not found in 
        the project directory, the tool will lookup in the project’s base path and the current working directory.

        -   For more information on using an environment template, visit 
        [Configure Environment Specific Details]({{base_path}}/Learn/APIController/importing-apis-via-dev-first-approach/#configure-environment-specific-details). 

    !!! tip
        The `retryTimeOut` is defined as an environment variable so that the actual value of it can be controlled using a 
        single variable based on the environment type.

    

5. **Commit the API Project with Test Scripts to Github Repository**

    Add the test script developed in **Step1**, in to the same API Project for easy use and commit the API project along 
    with the test scripts to a [Github](https://github.com/) source code management repository.

    [![]({{base_path}}/assets/img/Learn/APIController/commit-api-project-github.png)]({{base_path}}/assets/img/Learn/APIController/commit-api-project-github.png)  
    
6.  **Trigger Jenkins Pipeline using a Github Webhook**

    !!! info
        -   A predefined pipeline in the CI tool will automatically trigger a build upon the commit, to run tests and deploy it to 
        environments. Such pipeline will have 3 main steps.  
            1.  Check out the source code and deploy the API to a lower environment  
            2.  Run tests against the lower environment
            3.  Deploy it to the upper environment
            
        -   The deployment to environments can be done automatically using **apictl**.

    1.   Configure your source code repository in Github with a webhook to automatically start a Jenkins pipeline 
    once you commit any changes. 
          
    2.   Add the two environments using following sample **apictl** commands.
    
        !!! warning
            Make sure you have already installed **apictl** to the **Jenkins** server and set the Path variable. For more information,
            visit [here]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

        !!! example
            ``` bash
            apictl add-env -e dev \
            --registration https://dev.apim.wso2.com/client-registration/v0.15/register \
            --apim https://dev.apim.wso2.com \
            --token https://dev.apim.wso2.com/token \
            ```
            ``` bash
            apictl add-env -e prod \
            --registration https://prod.apim.wso2.com/client-registration/v0.15/register \
            --apim https://prod.apim.wso2.com \
            --token https://prod.apim.wso2.com/token \
            ```
    
        To learn on how to add environments, visit 
        [here]({{base_path}}/Learn/APIController/getting-started-with-wso2-api-controller/#add-an-environment). 
        You can do this manually beforehand or provide as a shell script in the same pipeline.

    3.   Store the credentials for the two environments as Jenkins credentials.  

        [![]({{base_path}}/assets/img/Learn/APIController/jenkins-credentials.png)]({{base_path}}/assets/img/Learn/APIController/jenkins-credentials.png) 
    

    4.  Add the Jenkins pipeline configuration defined in [here](https://github.com/dushaniw/wso2-apim-cicd-apis/blob/master/jenkinsfile).

        [![]({{base_path}}/assets/img/Learn/APIController/jenkins-pipeline-build.png)]({{base_path}}/assets/img/Learn/APIController/jenkins-pipeline-build.png) 
    
        [![]({{base_path}}/assets/img/Learn/APIController/pipeline-config.png)]({{base_path}}/assets/img/Learn/APIController/pipeline-config.png) 

        !!! info
            -   The `RETRY` variable is defined with 80 milliseconds, so that the production and sandbox endpoints of the API deployed 
            in the dev environment to have an endpoint retry time out value of 80 milliseconds. 
            -   As the first step, this will log in to the dev environment using the provided Jenkins credentials and 
            then deploy the API to the dev environment using the `import-api` command. 
            -   Note the `preserve-provider` and `update` flags, which will preserve the API provider in the given 
            API project and import the API to the development environment **seamlessly**.
            -   The next stage `Run Tests` will run the test script which we have committed to the project in Git 
            repository using **Newman**. 
            -   If you need to use the same test script to run against multiple environments, you can maintain a separate 
            environment file and provide that as an argument for the Newman run command. For more info, visit [here](https://learning.getpostman.com/docs/postman/collection-runs/using-environments-in-collection-runs/).
            -   Once the tests are passed, the next stage will deploy the API to the prod environment using the 
            `import-api` command. Similar to the dev environment, you can provide any environment-specific variable 
            values here. So that they will be injected into the API during the deployment.
    

**Upon committing and pushing any changes to the remote repository, the webhook will automatically a pipeline build on 
the Jenkins server.**   

A successful pipeline build would give a console output as similar to follows.     

[![]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-1.png)]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-1.png) 

[![]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-2.png)]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-2.png) 

[![]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-3.png)]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-3.png) 

[![]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-4.png)]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-4.png) 

[![]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-5.png)]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-5.png) 

[![]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-6.png)]({{base_path}}/assets/img/Learn/APIController/jenkins-cicd-pipeline-output-6.png) 


Once the pipeline status is a **Success**, once you go to the API-M Publisher Portal in the dev and prod environments, 
you can see the **SampleStore** API is in the `PUBLISHED` state. 

If you check the endpoints, you can see the endpoint URLs are updated according to the dev and production environment configs. 

[![]({{base_path}}/assets/img/Learn/APIController/dev-samplestoreapi.png)]({{base_path}}/assets/img/Learn/APIController/dev-samplestoreapi.png)

[![]({{base_path}}/assets/img/Learn/APIController/prod-samplestoreapi.png)]({{base_path}}/assets/img/Learn/APIController/prod-samplestoreapi.png) 


Further, if you go and check the advanced endpoint configurations of the same API, you can see the retry timeout is 
updated to 80 and 60 milliseconds accordingly.

[![]({{base_path}}/assets/img/Learn/APIController/dev-advanced-config.png)]({{base_path}}/assets/img/Learn/APIController/dev-advanced-config.png) 

[![]({{base_path}}/assets/img/Learn/APIController/prod-advanced-config.png)]({{base_path}}/assets/img/Learn/APIController/prod-advanced-config.png) 

In this tutorial, we have created a basic CI/CD pipeline using **Jenkins** as the CI tool and **Github** as the SCM tool, to 
create and deploy an API using the **API/Dev first approach** with WSO2 API Management.