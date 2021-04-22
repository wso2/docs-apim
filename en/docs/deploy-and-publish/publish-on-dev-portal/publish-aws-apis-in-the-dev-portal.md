# Importing APIs from AWS API Gateway to the WSO2 API Manager  

This feature helps to publish an existing API in AWS API gateway, on the WSO2 API-M Developer portal. These APIs will not be deployed into the WSO2 API gateway and will not be managed by the WSO2 API gateway.

## Prerequisites 

1. Two **WSO2 API Controller (apictl)** commands are needed for this task. Hence the user needs to have the apictl downloaded and configured.(apictl is a command-line tool providing the capability to move APIs, API Products, and Applications across environments and to perform CI/CD operations. For more information, see [Getting started with the API Controller (apictl)]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller)

2. The `aws init` command will be using the AWS CLI in the background. Hence the user needs to download and install the AWS CLI before using the `aws init` command. Refer [how to download and install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).

3. After successfully installing the AWS CLI it needs to be configured. Refer [how to configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

4. Enable AWS CLI pagination. By default, the AWS CLI returns all objects in the output, but if you have disabled pagination you will have to enable pagination for the `aws init` command to successfully work. 
For more information, refer [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html).

5. The WSO2 API Manager (WSO2 API-M) server needs to be up and running to import the API project to the APIM successfully.

6. An active internet connection is also required to download the OAS of the AWS API to initialize the API project.

## Importing an API from AWS API gateway to the WSO2 API Manager  

Usage of the `aws init` command is quite simple. Two mandatory flags are associated with the `aws init` command, `name` and `stage`. `name` will be the name of the API that is in the AWS API gateway that the user wants to import and publish in the developer portal and `stage` will be the specific stage of that API.

-   **Command**
    ``` bash
    apictl aws init -n <aws-api-name> -s <api-stage-to-get>
    ```

!!! example
    ```bash
    apictl aws init -n PetStore -s demo
    ```

!!! info
    **Flags:**   
    -    Required :  
        `--name` or `-n` : Name of the API to get from the AWS API Gateway
        `--stage` or `-s` : API stage to get 
    -   Optional :
        `--force` or `-f` : To force create an API project
        `--verbose` or `-v` : To execute the command in verbose mode

!!! tip
    The API project will be initialized in the same location where the command was executed from. 

-   **Response**
    
    ``` bash tab="Response Format"
    Initializing a new WSO2 API Manager project in /<path-to-api-manager-project>
    Project initialized
    Open README file to learn more
    ```
    
    ``` bash tab="Example Response"
    Initializing a new WSO2 API Manager project in /home/user/Documents/product-apim-tooling/import-export-cli/products
    Project initialized
    Open README file to learn more
    ```
### How the **aws init** command works.

The `aws init` command will be using the AWS CLI in the background to get a list of all the APIs from the AWS API gateway. It will then look for the ID of the API name provided by the user when the `aws init` command was executed, to download the OAS of that API. After making the necessary adjustments to the APIs version, tags, endpoints etc, an API project will be initialized and the downloaded OAS will be deleted.

### Importing the initialized API project to the WSO2 API Manager as an API

Upon successful initialization of the project, execute the following command to import that API project to the WSO2 API-M Publisher portal as an API. 

-   **Command**

    ``` bash
    apictl import api -f <path-to-api-project> -e <environment> -k
    ```

!!! example
    ```bash
    apictl import api -f /home/user/Documents/product-apim-tooling/import-export-cli/products -e production -k
    ```

After successfully importing the API, it will appear in the publisher as shown below.

[![]({{base_path}}/assets/img/publish/aws-api-publisher.png)]({{base_path}}/assets/img/publish/aws-api-publisher.png)

To publish the API, go to `Lifecycle` under `Publish` and click on `Publish`.

[![]({{base_path}}/assets/img/publish/publish-aws-api.png)]({{base_path}}/assets/img/publish/publish-aws-api.png)

To learn more about importing an API project refer to [import-api-project]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-apis-via-dev-first-approach).
({{base_path}}/learn/api-controller/api-controller/importing-apis-via-dev-first-approach/#import-an-api-project)

The initial state of the API will be set to `CREATED` so the user will be able to make changes to the API if necessary in the publisher portal, before publishing the API on the developer portal.

## Troubleshooting errors

If any errors are being printed and if the problem is not clear, execute the `aws init` command with the `--verbose` flag to get a more detailed output.

### Unable to find an API with the name `<api-name>`

After making sure the user has provided the correct API name and that the API is in the AWS API gateway if the problem persists, it is possible that the user has disabled AWS CLI pagination which will cause the AWS CLI to output only a limited number of APIs. In such cases, the API the user is looking for might not be in the APIs list provided by the AWS CLI. Enable AWS CLI pagination and try again. 

### Error code 255

One of the most common errors related to this command is the `exit status 255`. This is a AWS CLI error code and it means the AWS CLI command failed and that there were errors generated by the AWS CLI or by the AWS service to which the request was sent.
The most common reason for this is due to a incorrect stage-name provided.

!!! tip
    Make sure you provide the correct stage name and the spellings are correct.
    It is also important to remember the `name` and `stage` are case sensitive.

### Error code 400

This is also an AWS CLI error which is caused when making
too many requests for a given operation. To avoid getting this error try granting programmatic access to that specific user or create a new IAM user. Refer [how to create an IAM user with programmatic access.](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
