# Getting Started with WSO2 API Controller

WSO2 API Controller(CTL) is a command-line tool for managing API Manager environments, listing apis and applications, creating API projects, importing and exporting APIs and applications, generating tokens for testing purposes, etc.  

-   [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool)
-   [Global Flags for CTL Tool](#global-flags-for-ctl-tool)
-   [Check the Version of the CTL](#check-the-version-of-the-ctl)
-   [Set Mode of the CTL](#set-mode-of-the-ctl)
-   [Add an Environment](#add-an-environment)
-   [Remove an Environment](#remove-an-environment)
-   [List Environments](#list-environments)
-   [Login to an Environment](#login-to-an-environment)
-   [Logout from an Environment](#logout-from-an-environment)
-   [List APIs of an Environment](#list-apis-of-an-environment)
-   [List Applications of an Environment](#list-applications-of-an-environment)
-   [Get Keys for an API](#get-keys-for-an-api) 
-   [Set Token Type](#set-token-type)
-   [Set HTTP Request Timeout](#set-http-request-timeout)
-   [Set Export Directory](#set-export-directory)

## Download and Initialize the CTL Tool

1.  Navigate to the API Management Tooling page - <https://wso2.com/api-management/tooling/>
2.  Click **Download** button under **Dev-Ops Tooling** according to your preferred platform (i.e., Mac, Windows, Linux).
3.  Extract the downloaded archive of the CTL Tool to the desired location.

4.  Navigate to the working directory where the executable CTL Tool resides.

5.  Execute the following command to start the CTL Tool.

    ``` go
    ./apictl
    ```
    The directory structure for the configuration files ( `$HOME/.wso2apictl` ) will be created upon the execution of the `apictl` command.

6.  Add the location of the extracted folder to your system's `$PATH` variable to be able to access the executable from anywhere.


    !!! Tip    
        For further instructions execute the following command.
        ``` go
        apictl --help
        ```


## Global Flags for CTL Tool

The following are some global flags that you can use with any CTL tool command.

``` go
--verbose
    Enable verbose logs (Provides more information on execution)
--insecure, -k
    Allow connections to SSL sites without certs
--help, -h
    Display information and example usage of a command
```

## Check the Version of the CTL

Run the following CTL command to check the version of the CTL.

-   **Command**
    ```bash
    apictl version
    ```
-   **Response**

    ```bash
    Version: 3.0.0
    Build Date: 2019-10-28 13:22:12 UTC
    ```

## Set Mode of the CTL

Run the following CTL command to set the mode of the CTL. The allowed modes are `default` and `kubernetes`.
    
-   **Command**

    ```go
    apictl set mode <mode>
    ```

    !!! example

        ``` go
        apictl set mode default
        ```
        ``` go
        apictl set mode kubernetes
        ```

## Add an Environment

You can add environments by either manually editing the `$HOME/.wso2apictl/main_config.yaml` file or by running the following CTL command.

``` go
apictl add-env
```

1.  Make sure that the WSO2 API Manager is started and that the CTL tool is running.     
For more information, visit [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Run the following CTL command to add an environment.

    -   **Command**

        ``` bash tab="Linux/Unix"
        apictl add-env -e <environment-name> \
                        --registration <registration-endpoint> \
                        --apim <API-Manager-endpoint> \
                        --token <token-endpoint> \
                        --admin <admin-REST-API-endpoint> \
                        --api_list <API-listing-REST-API-endpoint> \
                        --app_list <application-listing-REST-API-endpoint>
        ```

        ``` bash tab="Mac"
        apictl add-env -e <environment-name> --registration <registration-endpoint> --apim <API-Manager-endpoint> --token <token-endpoint> --admin <admin-REST-API-endpoint> --api_list <API-listing-REST-API-endpoint> --app_list <application-listing-REST-API-endpoint>
        ```

        !!! info
            **Flags:**  
            
            -    Required :     
                `--environment` or `-e` : Name of the environment to be added  
                `--registration` : Registration endpoint for the environment  
                `--token` : Token endpoint for the environment  
                `--apim` : API Manager endpoint for the environments  

            -   Optional :      
                `--admin` : Admin endpoint for the environment  
                `--api_list` : API List endpoint for the environment  
                `--app_list` : Application List endpoint for the environment  
            
        !!! tip
            When adding an environment, when the optional flags are not given, CTL will automatically derive those from `--apim` flag value.   

        !!! example

            ``` bash tab="Linux/Unix"
            apictl add-env -e dev \
                        --registration https://localhost:9444/client-registration/v0.15/register \
                        --apim https://localhost:9444 \
                        --token https://localhost:8244/token \
            ``` 

            ``` bash tab="Mac"
            ./apictl add-env -e dev --registration https://localhost:9444/client-registration/v0.15/register --apim https://localhost:9444 --token https://localhost:8244/token
            ```               

        !!! example

            ``` bash tab="Linux/Unix"
            apictl add-env -e production \
                        --registration https://localhost:9443/client-registration/v0.15/register \
                        --apim https://localhost:9443 \
                        --token https://localhost:8243/token \
                        --admin https://localhost:9443/api/am/admin/v0.15 \
                        --api_list https://localhost:9443/api/am/publisher/v0.15/apis \
                        --app_list https://localhost:9443/api/am/store/v0.15/applications
            ```

            ``` bash tab="Mac"
            apictl add-env -e production --registration https://localhost:9443/client-registration/v0.15/register --apim https://localhost:9443 --token https://localhost:8243/token --admin https://localhost:9443/api/am/admin/v0.15 --api_list https://localhost:9443/api/am/publisher/v0.15/apis --app_list https://localhost:9443/api/am/store/v0.15/applications
            ```  
    
    -   **Response**
    
        ``` bash tab="Response Format"
        Successfully added environment '<environment-name>'
        ```

        ``` bash tab="Example Response"
        Successfully added environment 'production'
        ```

## Remove an Environment

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.  
For more information, visit [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Run the following CTL command to remove an environment.

    -   **Command**

        ```bash
        apictl remove-env -e <environment-name> 
        ``` 

        !!! info
            **Flags:**  
            
            -    Required :     
                `--environment` or `-e`: Name of the environment to be removed  
  
        !!! example
            ```bash
            apictl remove-env --environment production
            ```

    -   **Response**

        ``` bash tab="Response Format"
        Successfully removed environment '<environment-name>'
        Execute 'apictl add-env --help' to see how to add a new environment
        ```

        ``` bash tab="Example Response"
        Successfully removed environment 'production'
        Execute 'apictl add-env --help' to see how to add a new environment
        ```

## List Environments

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.    
For more information, visit [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Run the following CTL command to list the environments.  

    -   **Command**

        ```bash
        apictl list envs
        ``` 

        !!! info
            **Flags:**  
            
            -    Optional :     
                `--format` : pretty-print environments using templates 

    -   **Response**

        ``` bash tab="Response Format"
        NAME                  API MANAGER ENDPOINT      REGISTRATION ENDPOINT      TOKEN ENDPOINT
        <environment-name>    <API-Manager-endpoint>    <registration-endpoint>    <token-endpoint>
        ```

        ```bash tab="Example Response"
        NAME         API MANAGER ENDPOINT     REGISTRATION ENDPOINT                                       TOKEN ENDPOINT
        dev          https://localhost:9443   https://localhost:9443/client-registration/v0.15/register   https://localhost:8243/token
        production   https://localhost:9444   https://localhost:9444/client-registration/v0.15/register   https://localhost:8244/token   

        ```

## Login to an Environment

After adding an environment, you can log in to the API Manager instance in that environment using credentials.

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.   
For more information, visit [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Run any of the following CTL commands to log in to the environment.

    -   **Command**

        ```go
        apictl login <environment-name> -k
        ```

        ```go
        apictl login <environment-name> -u <username> -k
        ```

        ```go
        apictl login <environment-name> -u <username> -p <password> -k
        ``` 

        !!! tip
            If you run `apictl login <environment-name>` you are prompt to provide both username and password.  
            If you run `apictl login <environment-name> --username <username>`, you are prompt to provide password.

        !!! info
            **Flags:**  
            
            -    Optional :     
                `--username` or `-u` : Username for login  
                `--password` or `-p` : Password for login     
                `--password-stdin` : Get password from stdin  

        !!! example
            ```bash
            apictl login dev -k
            ```
            ```bash
            apictl login dev -u admin -p admin -k
            ```
            
            ```bash
            apictl login dev -username admin -password admin -k
            ```
                 
    -   **Response**

        ``` bash tab="Response Format"
        Logged into '<environment-name>' environment 
        ```

        ```bash tab="Example Response"
        Logged into dev environment
        ```

    !!! warning
        Using -`-password` in CTL is not secure. You can use `--password-stdin` instead. For example,
        ```bash
        cat ~/.mypassword | ./apictl login dev --username admin --password-stdin -k
        ```          

## Logout from an Environment

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.   
For more information, visit [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).

2.  Run the following command to log out from the current session of the API Manager environment.

    -   **Command** 

        ```go
        apictl logout <environment-name>
        ```

        !!! example
            ```go
            apictl logout dev
            ```

## List APIs of an Environment
By following the below steps, you can display a list of APIs in an environment using CTL.

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.   
For more information, visit [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Log in to the API Manager in the environment by following steps in [Login to an Environment](#login-to-an-environment).
3.  Run any of the following CTL commands to list the APIs.

    -   **Command**
        ``` bash
        apictl list apis -e <environment> -k
        ```
        ``` bash
        apictl list apis --environment <environment> --insecure
        ```
        ``` bash
        apictl list apis --environment <environment> --query <API search query> --insecure
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : Environment to be searched  
            -   Optional :  
                `--query` or `-q` : Search query pattern 

        !!! example
            ```bash
            apictl list apis -e dev -k
            ```
            ```bash
            apictl list apis --environment production --insecure
            ```    
            ```go
            apictl list apis --environment production --query "provider:Alice name:PizzaShackAPI" --insecure
            ```  

    -   **Response**

        ```go
        ID                                     NAME                VERSION             CONTEXT             STATUS              PROVIDER
        12d6e73c-778d-45ac-b57d-117c6c5092a4   PhoneVerification   1.0                 /phoneverify        PUBLISHED           admin
        91fe87c3-f0d7-4c35-81f5-0e0e42d8e19f   PizzaShackAPI       2.0.0               /pizzashack         CREATED             Alice
        ```

## List Applications of an Environment
You can display a list of Applications in an environment using CTL.

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.   
For more information, visit [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Log in to the API Manager in the environment by following steps in [Login to an Environment](#login-to-an-environment).
3.  Run any of the following CTL commands to list the Applications.

    -   **Command**
        ``` bash
        apictl list apps -e <environment> -k
        ```
        ``` bash
        apictl list apps --environment <environment> --insecure
        ```
        ``` bash
        apictl list apps --environment <environment> --owner <application owner> --insecure
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : Environment to be searched  
            -   Optional :  
                `--owner` or `-o` : Owner of the Application 

        !!! example
            ```bash
            apictl list apps -e dev -k
            ```
            ```bash
            apictl list apps --environment production --insecure
            ```    
            ```go
            apictl list apps --environment production --owner sampleUser --insecure
            ```  

    -   **Response**

        ```go
        ID                                     NAME                OWNER       STATUS     GROUP ID
        29b4fcc6-05a4-42a7-aa64-f1a1b8a7b979   DefaultApplication  admin       APPROVED 

        36d51e55-3f1e-4f85-86ee-8fe73b0c8adff  SampleApplication   sampleUser  APPROVED   orgA
        ```  

## Get Keys for an API
For testing purposes, the CTL tool allows generating a JWT/OAuth token to invoke an API by subscribing from a default application.

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.     
For more information, visit [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2. Log in to the API Manager in the environment by following steps in [Login to an Environment](#login-to-an-environment).
3. Run any of the following CTL commands to get keys for the API.

    - **Command**

    ```bash
    apictl get-keys -n <API name> -v <API version> -r <API provider> -e <environment> -k
    ```  

    ```bash
    apictl get-keys --name <API name> --version <API version> --provider <API provider> --environment <environment> -k
    ```

    !!! example
        ```bash
        apictl get-keys -n PizzaShackAPI -v 1.0.0 -r admin -e dev -k
        ```
    !!! info
        **Flags:**  
            
        -   Required :  
            `--environment` or `-e` : Key generation environment  
            `--name` or `-n` : API to enerate keys for  
            `--version` or `-v` : Version of the API  
            `--provider` or `-r` : Provider of the API   

    !!! info
        Upon running the above command, the CTL tool will create a default application in the environment, subscribe to the API and generate keys based on the token type given in `$HOME/.wso2apictl/main-config.yaml`. Refer [Set Token Type](#set-token-type) to change the token type. 

## Set Token Type

Run the following CTL command to set the token type of the default apictl application.

-   **Command**
        ```go
        apictl set --token-type <token type>
        ```

    !!! example
        ```bash
        apictl set --token-type JWT
        ```
        ```bash
        apictl set --token-type OAuth
        ```
    
    !!! info
        **Flags:** 

        -   Required :   
            `--token-type` or `-t` : Type of the token to be generated

## Set HTTP Request Timeout

Run the following CTL command to set the HTTP request timeout.

-   **Command**
        ``` go
        apictl set --http-request-timeout <http-request-timeout>
        ```

    !!! example
        ```bash
        apictl set --http-request-timeout 10000
        ```
    
    !!! info
        **Flags:** 

        - Required :   
          `--http-request-timeout` : Timeout for HTTP Client (default 10000)

## Set Export Directory

Run the following CTL command to change the default location of the export directory.

-   **Command**
        ``` go
        apictl set --export-directory <export-directory-path>
        ```

    !!! example

        ```go tab="Linux/Mac"
        apictl set --export-directory /home/user/exported-apis
        ```

        ```go tab="Windows"
        apictl set --export-directoty C:\Documents\exported
        ```
        
    !!! info
        **Flags:** 

        - Required :   
            `--export-directory`: Path to directory where APIs should be saved.   
            Default : `/home/.wso2apictl/exported`

