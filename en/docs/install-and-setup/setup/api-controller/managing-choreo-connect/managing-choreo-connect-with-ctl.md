# Managing Choreo Connect

**WSO2 API Controller (apictl)** can be used as a developer CLI tool for Choreo Connect. It enables interacting with one or more Choreo Connect environments without having to perform the following tasks via the WSO2 API Manager (WSO2 API-M).

- Deploy an API
- View the list of deployed APIs
- Undeploy an API

!!! info
    **Before you begin**

    -  Download the Choreo Connect distribution from the [github release page's](https://github.com/wso2/product-microgateway/releases) and follow the Quick Start Guide attached with the release.

    -  Make sure the apictl is downloaded and initialized, if not follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl). Following the guide upto [Check the version of the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#check-the-version-of-the-apictl) will be sufficient to continue. 

    -  Remember to add the cert of Choreo Connect into `/home/<your-pc-username>/.wso2apictl/certs` to communicate via https (to avoid having to use insecure mode with -k or --insecure). Click [here]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#import-ssl-certificates-for-secure-http-communication-with-wso2-api-m) for more information.


## Add a Choreo Connect Environment

A Choreo Connect here refers to the entire cluster which includes all three components: adapter, router and enforcer. By adding a Choreo Connect environment, the url to the adapter will be stored in a config file, and therefore enables login.

Once you have added a Choreo Connect environment, and logged in, other commands such as `apictl mg deploy api` can be used by only specifying an environment. This allows you to use such commands without entering the Choreo Connect adapter url, username, and password every time.

- **Command**

    ```bash
    apictl mg add env <environment-name> --adapter <adapter-url>
    ```

    !!! info
        **Flags:**

        -    Mandatory :     
            `--adapter` or `-a` : The Choreo Connect adapter host url with port  

    !!! example
        ```bash
        apictl mg add env prod --adapter  https://localhost:9443 
        ```

## Log in to a Choreo Connect Environment

Log in will get an access token from the Choreo Connect adapter and store it for further commands.

- **Command**
    ```bash
    apictl mg login <environment-name>
    ```
    ```bash
    apictl mg login <environment-name> -u <username>
    ```
    ```bash
    apictl mg login <environment-name> -u <username> -p <password>
    ```

    !!! tip
        If you run `apictl mg login <environment-name>` you are prompted to provide both the username and the password.
        If you run `apictl mg login <environment-name> --username <username>`, you are prompted to provide the password.
        If you include the flag `--password-stdin`, you can provide the password in a file as well. For an example,

        ```bash
        cat <file-with-the-password> | apictl mg login <environment-name> -u <username> --password-stdin
        ```

    !!! info
        **Flags:**

        - Optional :     
            `--username` or `-u` : Username for login  
            `--password` or `-p` : Password for login     
            `--password-stdin` : Get password from stdin  

    !!! example
        ```bash
        apictl mg login dev
        ```
        ```bash
        apictl mg login dev -u admin
        ```
        ```bash
        apictl mg login dev -u admin -p admin
        ```
        ```bash
        cat ~/.mypassword | apictl mg login dev -u admin --password-stdin
        ```
- **Response**

        ``` bash tab="Response Format"
        Successfully logged into Choreo Connect Adapter in environment: <environment-name>
        ```

        ```bash tab="Example Response"
        Successfully logged into Choreo Connect Adapter in environment: dev
        ```

    !!! warning
        Using `--password` in CTL is not secure. Instead, you can use `--password-stdin` to include password file or provide the password when prompted.

## Deploy an API

In order to deploy, let us first create an API project. Follow the steps in [Initialize an API Project]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-apis-via-dev-first-approach/#initialize-an-api-project) to create an API project using **apictl**.

An API project can be deployed to a Choreo Connect using the following commands.

-   **Command**
    ```go
    apictl mg deploy api -e <environment-name> -f <api-project-file-path>
    ```
    ```go
    apictl mg deploy api ---environment <environment-name> --file <api-project-file-path>
    ```

    !!! tip
        In an API project, the API name and the API version given in the `api.yaml` will be taken as the name and version of the API once deployed.

    !!! tip
        When trying to deploy, if an API with the same name, version, virtual host combination already exists in the Choreo Connect adapter, an error response will be given saying that the API already exists.

        In order to override the existing API or deploy an API without considering whether it already exists or not, include the flag `--override` or its shorthand `-o` to the same command above. For an example,
        ```bash
        apictl mg deploy api -e dev -f petstore -o
        ```  

    !!! info
        **Flags:**
        
        - Mandatory :    
            `-e`, `--environment` : Choreo Connect adapter environment to add the API   
            `-f`, `--file`        : Filepath of the apictl project to be deployed

        - Optional :     
            `-o`, `--override` : Whether to deploy an API irrespective of its existence. Overrides when exists.    
            `--skip-cleanup` : Whether to keep all temporary files created during the deploy process

    !!! example
        ```bash
        apictl mg deploy api -e dev -f petstore
        ```
        ```bash
        apictl mg deploy api --environment dev --file petstore
        ```
        ```bash
        apictl mg deploy api -e dev -f petstore --override
        ```
        ```bash
        apictl mg deploy api -e dev -f petstore -o --skip-cleanup
        ```

-   **Response**

    ``` bash tab="Deployed"
    Successfully deployed API to Choreo Connect.
    ```

    ``` bash tab="API Already Exists"
    Unable to deploy API. API already exists. Status: Conflict 409
    ```

    ```bash tab="Deployed or Updated"
    Successfully deployed/updated the API in Choreo Connect.
    ```

## List Deployed APIs

This command can be used to list the deployed APIs on a given Choreo Connect adapter environment.

-   **Command**
    ```bash
    apictl mg get apis -e <environment-name>
    ```
    !!! tip
        By default, the number of APIs listed will be limited to 25. To increase or decrease the limit set the flag `--limit` or its shorthand flag `-l`. For an example,
        ```bash
        apictl mg get apis -e dev --limit 100
        ```

    !!! tip
        Currently, these APIs can be filtered by API type. The supported types are http and ws (web socket). Use the flag `--query` or its shorthand flag `-q` to filter APIs.
        ```bash
        apictl mg get apis -e dev --query type:http
        ```

    !!! info
        **Flags:**
        
        - Mandatory :    
            `-e`, `--environment` : Choreo Connect adapter environment to list the APIs from  

        - Optional :       
            `-l`, `--limit` : Maximum number of APIs to return     
            `-q`, `--query` : Query to filter the APIs

    !!! example
        ```bash
        apictl mg get apis -e dev
        ```
        ```bash
        apictl mg get apis -q type:http --environment dev --limit 100
        ```
        ```bash
        apictl mg get apis -q type:ws -e dev -l 10
        ```

-   **Response**

    ```
    Limit flag not set. Set to default: 25
    APIs total: 2 received: 2
    NAME                VERSION             TYPE                CONTEXT         GATEWAY_ENVS
    SwaggerPetstore     1.0.5               HTTP                /v2             [Production and Sandbox]
    SwaggerPetstore1    1.0.5               WS                  /v2             [Production and Sandbox]
    ```


## Undeploy an API

This command can be used to remove an API from the Choreo Connect. 

-   **Command**
    ```bash
    apictl mg undeploy api -e <environment-name> -n <api-name> -v <api-version>
    ```
    ```bash
    apictl mg undeploy api -e <environment-name> -n <api-name> -v <api-version> --vhost <vhost>
    ```

    !!! info
        **Flags:**
        
        - Mandatory :    
            `-e`, `--environment` : Choreo Connect adapter environment to undeploy the API from   
            `-n`, `--name`        : API name   
            `-v`, `--version`     : API version   

        - Optional :     
            `-t`, `--vhost` : Virtual host the API belongs to   

    !!! example
        ```bash
        apictl mg undeploy api -e dev -n petstore -v 0.0.1
        ```
        ```bash
        apictl mg undeploy api --name SwaggerPetstore --version 0.0.1 -e dev
        ```
        ```bash
        apictl mg undeploy api -n petstore -v 0.0.1 -e dev --vhost www.pets.com
        ```
-   **Response**

    ```
    API undeployed from Choreo Connect successfully!
    ```

## Log out from a Choreo Connect Environment

This command can be used to logout from a Choreo Connect adapter environment. Once this command is executed, the access token of the Choreo Connect adapter will be erased from apictl.

-   **Command**
    ```bash
    apictl mg logout <environment-name>
    ```

    !!! example
        ```bash
        apictl mg logout dev
        ```
-   **Response**

    ``` bash tab="Response Format"
    Logged out from Choreo Connect Adapter in environment: <environment-name>
    ```

    ``` bash tab="Example Response"
    Logged out from Choreo Connect Adapter in environment: dev
    ```

## Remove a Choreo Connect Environment

This command can be used to remove a Choreo Connect environment from apictl. Once this command is executed, it will delete the adapter url and its access token first, and then remove the Choreo Connect environment from apictl.

-   **Command**
    ```bash
    apictl remove env <environment-name>
    ```

    !!! example
        ```bash
        apictl remove env dev
        ```

-   **Response**

    ``` bash tab="Response Format"
    Successfully removed environment '<environment-name>'
    ```

    ``` bash tab="Example Response"
    Successfully removed environment 'dev'
    ```
