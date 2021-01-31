# Getting Started with WSO2 API Controller

WSO2 API Controller(CTL) is a command-line tool for managing API Manager environments, listing APIs, API products and applications, creating API projects, importing and exporting APIs, API products and applications, generating tokens for APIs and API products for testing purposes, etc. and managing WSO2 Micro Integrator.

## Download and initialize the CTL Tool

1.  Download **API Controller** based on your preferred platform (i.e., Mac, Windows, Linux).

    - [For MacOS]({{base_path}}/assets/attachments/learn/api-controller/apictl-3.2.1-macosx-x64.tar.gz)
    - [For Linux 32-bit]({{base_path}}/assets/attachments/learn/api-controller/apictl-3.2.1-linux-i586.tar.gz)
    - [For Linux 64-bit]({{base_path}}/assets/attachments/learn/api-controller/apictl-3.2.1-linux-x64.tar.gz)
    - [For Windows 32-bit]({{base_path}}/assets/attachments/learn/api-controller/apictl-3.2.1-windows-i586.zip)
    - [For Windows 64-bit]({{base_path}}/assets/attachments/learn/api-controller/apictl-3.2.1-windows-x64.zip)

2.  Extract the downloaded archive of the CTL Tool to the desired location.
3.  Navigate to the working directory where the executable CTL Tool resides.
4.  Execute the following command to start the CTL Tool.

    !!! Warn
        From API Manager Tooling 3.1.0 version onwards, the names of the endpoints have been modified and this causes changing the syntax in `/home/<user>/.wso2apictl/main_config.yaml` file. If you have an older file, you'll get an error while executing the apictl commands due to this. To avoid that, backup and remove `/home/<user>/.wso2apictl/main_config.yaml` file and reconfigure the environments using new commands as explained below in [Add an environment](#add-an-environment) section.

    ``` go
    ./apictl
    ```
    The directory structure for the configuration files (`<USER_HOME>/.wso2apictl`) will be created upon the execution of the `apictl` command.

    !!! Tip
        If you want to change the default location for the .wso2apictl directory, set an environment variable (**APICTL_CONFIG_DIR**) as follows with the path for the desired location.

        ```
        export APICTL_CONFIG_DIR="/home/wso2user/CLI"
        ```

5.  Add the location of the extracted folder to your system's `$PATH` variable to be able to access the executable from anywhere.


    !!! Tip    
        For further instructions, execute the following command.
        ``` go
        apictl --help
        ```


## Global flags for CTL Tool

The following are some global flags that you can use with any CTL tool command.

``` go
--verbose
    Enable verbose logs (Provides more information on execution)
--insecure, -k
    Allow connections to SSL sites without certs
--help, -h
    Display information and example usage of a command
```

## Check the version of the CTL

Run the following CTL command to check the version of the CTL.

-   **Command**
    ```bash
    apictl version
    ```
-   **Response**

    ```bash
    Version: 4.0.0
    Build Date: 2020-12-11 13:22:12 UTC
    ```

!!!note
    **Set mode of the CTL**

    From the API Controller 4.0.0 onwards the flag (--mode) which was used to set the mode of the CTL has been deprecated. Now, you do not need to set the mode of the CTL, because if you want to execute Kubernetes based commads, you just need to add the `k8s` keyword after `apictl` keyword. (Example: `apictl k8s add api`). By default the API Controller will execute the commands in the `default` mode (which means if you did not use `k8s` keyword).

    You can still use the `mode` flag as explained below if you need it, but it will be removed in the future.
        
    -   **Command**

        ```go
        apictl set --mode <mode>
        ```

        !!! example

            ``` go
            apictl set --mode default
            ```
            ``` go
            apictl set --mode kubernetes
            ```

         The allowed modes are `default` and `kubernetes`. 

## Set proxy environment variables for CTL

You can set proxy related `HTTP_PROXY`, `HTTPS_PROXY`, `http_proxy`, and `https_proxy` standard environment variables, with or without basic authentication as shown below to send the requests initiated from CTL via a proxy server. After one of the following environment variables is set in your environment where CTL is used, all the requests will go through the proxy server specified.

-   **Formats**

    ``` bash tab="Without Basic Authentication"
    export HTTP_PROXY="http://<host-name>:<port>"

    export HTTPS_PROXY="https://<host-name>:<port>"

    export http_proxy="http://<host-name>:<port>"

    export https_proxy="https://<host-name>:<port>"
    ```

    ``` bash tab="With Basic Authentication"
    export HTTP_PROXY="http://<username>:<password>@<host-name>:<port>"

    export HTTPS_PROXY="https://<username>:<password>@<host-name>:<port>"

    export http_proxy="http://<username>:<password>@<host-name>:<port>"

    export https_proxy="https://<username>:<password>@<host-name>:<port>"
    ```

-   **Examples**

    ``` bash tab="Without Basic Authentication"
    export HTTP_PROXY="http://localhost:3128"

    export HTTPS_PROXY="https://localhost:3128"

    export http_proxy="http://localhost:3128"

    export https_proxy="https://localhost:3128"
    ```

    ``` bash tab="With Basic Authentication"
    export HTTP_PROXY="http://testuser:password@localhost:3128"

    export HTTPS_PROXY="https://testuser:password@localhost:3128"

    export http_proxy="http://testuser:password@localhost:3128"

    export https_proxy="https://testuser:password@localhost:3128"
    ```

## Add an environment
        
You can add environments by either manually editing the `<USER_HOME>/.wso2apictl/main_config.yaml` file or by running the following CTL command.

``` go
apictl add env <environment-name>
```

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.     
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Run the following CTL command to add an environment.

    -   **Command**

        ``` bash tab="Linux/Unix"
        apictl add env <environment-name> \
                       --registration <client-registration-endpoint> \
                       --apim <API-Manager-endpoint> \
                       --token <token-endpoint> \
                       --admin <admin-REST-API-endpoint> \
                       --publisher <publisher-portal-endpoint> \
                       --devportal <developer-portal-endpoint> \
                       --mi <mi-management-endpoint>
        ```

        ``` bash tab="Mac/Windows"
        apictl add env <environment-name> --registration <client-registration-endpoint> --apim <API-Manager-endpoint> --token <token-endpoint> --admin <admin-REST-API-endpoint> --publisher <publisher-portal-endpoint> --devportal <developer-portal-endpoint> --mi <mi-management-endpoint>
        ```

        !!! info
            **Flags:**  
            
            **To add an API Manager**

            -    Required :     
                (either)     
                `--apim` : API Manager endpoint for the environments     
                OR (the following 4)     
                `--registration` : Registration endpoint for the environment     
                `--admin` : Admin endpoint for the environment     
                `--publisher` : Publisher Portal endpoint for the environment     
                `--devportal` : Developer Portal endpoint for the environment     

            -   Optional :     
                `--token` : Token endpoint for the environment

            **To add a Micro Integrator**

            -    Required :     
                `--mi` : Management endpoint of the Micro Integrator
            
        !!! tip
            When adding an environment, when the optional flags are not given, CTL will automatically derive those from `--apim` flag value.

        !!! note
            You can either provide only the flag `--apim` , or all the other 4 flags (`--registration`, `--publisher`, `--devportal`, `--admin`) without providing `--apim` flag.
            If you are omitting any of `--registration`, `--publisher`, `--devportal`, `--admin` flags, you need to specify `--apim` flag with the API Manager endpoint.
            In both of the above cases `--token`  flag is optional and can be used to provide a user-preferred token endpoint.
            You can use the `--mi` flag to add a Micro Integrator instance to an environment.

    -   Adding an API Manager to an environment using `--apim` flag

        !!! example

            ``` bash tab="Linux/Unix"
            apictl add env dev \
                        --apim https://localhost:9443 
            ``` 

            ``` bash tab="Mac/Windows"
            apictl add env dev --apim https://localhost:9443 
            ```               

    -   Adding an API Manager to an environment using `--registration`, `--publisher`, `--devportal`, `--admin` flags

        !!! example

            ``` bash tab="Linux/Unix"
            apictl add env production \
                        --registration https://idp.com:9444 \
                        --admin https://apim.com:9444 \
                        --publisher https://apim.com:9444 \
                        --devportal https://apps.com:9444 \
                        --token https://gw.com:8244/token                        
            ```

            ``` bash tab="Mac/Windows"
            apictl add env production --registration https://idp.com:9444  --admin https://apim.com:9444 --publisher https://apim.com:9444 --devportal https://apps.com:9444 --token https://gw.com:8244/token
            ```  

    -   Adding an API Manager to an environment using some of the `--registration`, `--publisher`, `--devportal`, `--admin` flags along with `--apim` flag

        !!! example

            ``` bash tab="Linux/Unix"
            apictl add env production \
                        --registration https://idp.com:9444 \
                        --apim https://apim.com:9444 \
                        --token https://gw.com:8244/token
            ```

            ``` bash tab="Mac/Windows"
            apictl add env production --registration https://idp.com:9444 --apim https://apim.com:9444 --token https://gw.com:8244/token
            ```  

    -   Adding a Micro Integrator to an environment using `--mi` flag

        !!! example

            ``` bash tab="Linux/Unix"
            apictl add env dev \
                        --mi https://localhost:9164
            ```

            ``` bash tab="Mac/Windows"
            apictl add env dev --mi https://localhost:9164
            ```

    -   Adding both API Manager and Micro Integrator to an environment

        !!! example

            ``` bash tab="Linux/Unix"
            apictl add env test \
                        --apim https://localhost:9443 \
                        --mi https://localhost:9164
            ```

            ``` bash tab="Mac/Windows"
            apictl add env test --apim https://localhost:9443 --mi https://localhost:9164
            ```

        !!!note
            `apictl add-env` command has been deprecated from the API Controller 4.0.0 onwards. Instead, use `apictl add env` as shown above. 

    -   **Response**
    
        ``` bash tab="Response Format"
        Successfully added environment '<environment-name>'
        ```

        ``` bash tab="Example Response"
        Successfully added environment 'production'
        ```

## Remove an environment

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.  
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Run the following CTL command to remove an environment.

    -   **Command**

        ```bash
        apictl remove env <environment-name> 
        ``` 
  
        !!! example
            ```bash
            apictl remove env production
            ```

    -   **Response**

        ``` bash tab="Response Format"
        Successfully removed environment '<environment-name>'
        Execute 'apictl add env --help' to see how to add a new environment
        ```

        ``` bash tab="Example Response"
        Successfully removed environment 'production'
        Execute 'apictl add env --help' to see how to add a new environment
        ```

## Get environments

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.    
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Run the following CTL command to list the environments.  

    -   **Command**

        ```bash
        apictl get envs
        ``` 

        !!! info
            **Flags:**  
            
            -    Optional :     
                `--format` : pretty-print environments using templates 

    -   **Response**

        ``` bash tab="Response Format"
        NAME                  API MANAGER ENDPOINT      REGISTRATION ENDPOINT      TOKEN ENDPOINT     PUBLISHER ENDPOINT       DEVPORTAL ENDPOINT       ADMIN ENDPOINT          MI MANAGEMENT ENDPOINT
        <environment-name>    <APIM-endpoint>           <registration-endpoint>    <token-endpoint>   <Publisher-endpoint>     <DevPortal-endpoint>     <admmin-endpoint>       <mi-management-endpoint>
        ```

        ```bash tab="Example Response"
        NAME         API MANAGER ENDPOINT     REGISTRATION ENDPOINT    TOKEN ENDPOINT                  PUBLISHER ENDPOINT       DEVPORTAL ENDPOINT       ADMIN ENDPOINT             MI MANAGEMENT ENDPOINT
        dev          https://localhost:9443   https://localhost:9443   https://localhost:8243/token    https://localhost:9443   https://localhost:9443   https://localhost:9443
        production   https://localhost:9444   https://localhost:9444   https://localhost:8244/token    https://localhost:9444   https://localhost:9444   https://localhost:9444     https://localhost:9164
        dev-mi                                                                                                                                                                      https://localhost:9164

        ```

        !!!note
            `apictl list envs` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl get envs` as shown above. 

## Login to an environment

After adding an environment, you can log in to the API Manager instance in that environment using credentials.

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.   
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
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
            If you run `apictl login <environment-name>` you are prompted to provide both the username and the password.
            If you run `apictl login <environment-name> --username <username>`, you are prompted to provide the password.

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
            apictl login dev --username admin --password admin -k
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

## Logout from an environment

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.   
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).

2.  Run the following command to log out from the current session of the API Manager environment.

    -   **Command** 

        ```go
        apictl logout <environment-name>
        ```

        !!! example
            ```go
            apictl logout dev
            ```
            
## Add APIs/API Products/Applications in an environment

You can add APIs/API Products/Applications via the Publisher Portal and Developer Portal.
However, **apictl** allows you to create and deploy APIs without using the Publisher Portal. For more information on adding APIs, see [Importing APIs Via Dev First Approach]({{base_path}}/learn/api-controller/importing-apis-via-dev-first-approach).

## Get APIs/API Products/Applications in an environment

Follow the instructions below to display a list of APIs/API Products/Applications in an environment using CTL:

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.   
     For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).

2.  Log in to the API Manager in the environment by following the instructions in [Login to an Environment](#login-to-an-environment).
3.  Run the corresponding CTL command below to get (list) APIs/API Products/Applications in an environment.

    1. Get APIs in an environment.

        -   **Command**
            ``` bash
            apictl get apis -e <environment> -k
            ```
            ``` bash
            apictl get apis --environment <environment> --insecure
            ```
            ``` bash
            apictl get apis --environment <environment> --query <API search query> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment to be searched  
                -   Optional :  
                    `--query` or `-q` : Search query pattern  
                    `--limit` or `-l` : Maximum number of APIs to return (Default 25)
                    `--format` : pretty-print environments using templates

            !!! example
                ```bash
                apictl get apis -e dev -k
                ```
                ```bash
                apictl get apis --environment production --limit 15 --insecure
                ```    
                ```go
                apictl get apis --environment production --query provider:Alice name:PizzaShackAPI --insecure
                ```  

        -   **Response**

            ```go
            ID                                     NAME                VERSION             CONTEXT             STATUS              PROVIDER
            12d6e73c-778d-45ac-b57d-117c6c5092a4   PhoneVerification   1.0                 /phoneverify        PUBLISHED           admin
            91fe87c3-f0d7-4c35-81f5-0e0e42d8e19f   PizzaShackAPI       2.0.0               /pizzashack         CREATED             Alice
            ```
            
            !!! tip 
                When using the `apictl get apis -e dev` command, `-q` or `--query` optional flag can be used to 
                search for APIs.
                You can search in attributes by using a `:` modifier. Supported attribute modifiers are **name**, 
                **version**, **provider**, **context**, **status**, **description**, **subcontext**, **doc** and 
                **label**.  You can also use combined modifiers.  
                **Example:**
                   
                -  `provider:wso2` will match an API if the provider of the API contains `wso2`.
                -  `'provider:"wso2"'` will match an API if the provider of the API is exactly `wso2`.
                -  `status:PUBLISHED` will match an API if the API is in PUBLISHED state.
                -  `label:external` will match an API if it contains a Microgateway label called "external".
                -  `name:pizzashack version:v1` will match an API if the name of the API is pizzashack and version is v1.
                
                If no advanced attribute modifier has been specified, the API names containing the search term will 
                be returned as a result.

            !!!note
                `apictl list apis` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl get apis` as shown above. 

    2. Get API Products in an environment.
    
        -   **Command**
            ``` bash
            apictl get api-products -e <environment> -k
            ```
            ``` bash
            apictl get api-products --environment <environment> --insecure
            ```
            ``` bash
            apictl get api-products --environment <environment> --query <API search query> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment to be searched  
                -   Optional :  
                    `--query` or `-q` : Search query pattern  
                    `--limit` or `-l` : Maximum number of API Products to return

            !!! example
                ```bash
                apictl get api-products -e dev -k
                ```
                ```bash
                apictl get api-products --environment production --insecure
                ```    
                ```go
                apictl get api-products --environment production --query provider:Alice name:PizzaShackAPI --limit 25 --insecure
                ```  

        -   **Response**

            ```go
            ID                                     NAME                CONTEXT              STATUS              PROVIDER
            b39e08d7-caa9-40d0-a430-b8e840dd7c31   LeasingAPIProduct   /leasingapiproduct   PUBLISHED           admin
            ab422af2-b19e-4e6a-a34b-8f45c50db0d5   CreditAPIProduct    /creditapiproduct    PUBLISHED           Alice
            ```

            !!!note
                `apictl list api-products` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl get api-products` as shown above.

    3. Get Applications in an environment.

        -   **Command**
            ``` bash
            apictl get apps -e <environment> -k
            ```
            ``` bash
            apictl get apps --environment <environment> --insecure
            ```
            ``` bash
            apictl get apps --environment <environment> --owner <application owner> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment to be searched  
                -   Optional :  
                    `--owner` or `-o` : Owner of the Application  
                    `--limit` or `-l` : Maximum number of applications to return (Default 25)

            !!! example
                ```bash
                apictl get apps -e dev -k
                ```
                ```bash
                apictl get apps --environment production --insecure
                ```    
                ```go
                apictl get apps --environment production --owner sampleUser --limit 15 --insecure
                ```  

        -   **Response**

            ```go
            ID                                     NAME                OWNER       STATUS     GROUP ID
            29b4fcc6-05a4-42a7-aa64-f1a1b8a7b979   DefaultApplication  admin       APPROVED 
            36d51e55-3f1e-4f85-86ee-8fe73b0c8adff  SampleApplication   sampleUser  APPROVED   orgA
            ```

            !!! tip 
                When using the `apictl get apps -e dev` command, you can either specify `-o` (`--owner`) flag or not.

                - When someone has invoked the command **without specifying the owner flag**, it will list all the applications in that environment which belongs to the tenant that the currently logged in user belongs.
                - When someone has invoked the command **by specifying the owner flag**, it will list all the applications belongs to that particular owner in that environment.

            !!!note
                `apictl list apps` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl get apps` as shown above. 
        
## Delete an API/API Product/Application in an environment
Follow the instructions below to delete an API/API Product/Application in an environment using CTL:

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.   
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Log in to the API Manager in the environment by following the instructions in [Login to an Environment](#login-to-an-environment).
3.  Run the corresponding CTL command below to delete an API/API Product/Application in an environment.

    1. Delete an API in an environment.

        -   **Command**
            ``` bash
            apictl delete api -n <API name> -v <API version> -e <environment> -k
            ```
            ``` bash
            apictl delete api --name <API name> --version <API version> --environment <environment> --insecure
            ```
            ``` bash
            apictl delete api --name <API name> --version <API version> --environment <environment> --provider <API provider> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment from which the API should be deleted  
                    `--name` or `-n` : Name of the API to be deleted  
                    `--version` or `-v` : Version of the API to be deleted  
                -   Optional :  
                    `--provider` or `-r` : Provider of the API to be deleted  

            !!! example
                ```bash
                apictl delete api -n PizzaShackAPI -v 1.0.0 -e dev -k
                ```
                ```bash
                apictl delete api --name PizzaShackAPI --version 1.0.0 --environment production --insecure
                ```    
                ```go
                apictl delete api --name PizzaShackAPI --version 1.0.0 --environment production --provider Alice --insecure
                ```  

        -   **Response**

            ```go
            PizzaShackAPI API deleted successfully!
            ```

    2. Delete an API Product in an environment.

        -   **Command**
            ``` bash
            apictl delete api-product -n <API Product name> -e <environment> -k
            ```
            ``` bash
            apictl delete api-product --name <API Product name> --environment <environment> --insecure
            ```
            ``` bash
            apictl delete api-product --name <API Product name> --environment <environment> --provider <API Product provider> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment from which the API Product should be deleted  
                    `--name` or `-n` : Name of the API Product to be deleted   
                -   Optional :  
                    `--provider` or `-r` : Provider of the API Product to be deleted  

            !!! example
                ```bash
                apictl delete api-product -n LeasingAPIProduct -e dev -k
                ```
                ```bash
                apictl delete api-product --name LeasingAPIProduct -environment production --insecure
                ```    
                ```go
                apictl delete api-product --name LeasingAPIProduct --environment production --provider Alice --insecure
                ```  

        -   **Response**

            ```go
            LeasingAPIProduct API Product deleted successfully!
            ```
    
    3. Delete an Application in an environment.

        -   **Command**
            ``` bash
            apictl delete app -n <application name> -e <environment> -k
            ```
            ``` bash
            apictl delete app -name <application name> --environment <environment> --insecure
            ```
            ``` bash
            apictl delete app --name <application name> --environment <environment> --owner <application owner> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment from which the Application should be deleted  
                    `--name` or `-n` : Name of the Application to be deleted   
                -   Optional :  
                    `--owner` or `-o` : Owner of the Application to be deleted  

            !!! example
                ```bash
                apictl delete app -n DefaultApplication -e dev -k
                ```
                ```bash
                apictl delete app --name DefaultApplication --environment production --insecure
                ```    
                ```go
                apictl delete app --name DefaultApplication --environment production --owner sampleUser --insecure
                ```  

        -   **Response**

            ```go
            DefaultApplication Application deleted successfully!
            ``` 

## Change status of an API in an environment
Follow the instructions below to change the status of an API in an environment using CTL:

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.   
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Log in to the API Manager in the environment by following the instructions in [Login to an Environment](#login-to-an-environment).
3.  Run the corresponding CTL command below to change the status of an API in an environment.

    -   **Command**
        ``` bash
        apictl change-status api -a <Action> -n <API name> -v <API version> -e <environment> -k
        ```
        ``` bash
        apictl change-status api --action <Action> --name <API name> --version <API version> --environment <environment> --insecure
        ```
        ``` bash
        apictl change-status api --action <Action> --name <API name> --version <API version> --environment <environment> --provider <API provider> --insecure
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : The environment that the command is executed on  
                `--name` or `-n` : The name of the respective API
                `--version` or `-v` : The version of the respective API
                `--action` or `-a` : The action to be taken to change the status of the API
            -   Optional :  
                `--provider` or `-r` : The provider of the respective API  

        !!! example
            ```bash
            apictl change-status api -a Publish -n PizzaShackAPI -v 1.0.0 -e dev -k
            ```
            ```bash
            apictl change-status api --action Publish --name PizzaShackAPI --version 1.0.0 --environment production --insecure
            ```    
            ```go
            apictl change-status api --action Publish --name PizzaShackAPI --version 1.0.0 --environment production --provider Alice --insecure
            ```  

    -   **Response**

        ```go
        PizzaShackAPI API state changed successfully!
        ```

    !!! Info
        Supported action values : Publish, Deploy as a Prototype, Demote to Created, Demote to Prototyped, Block, Deprecate, Re-Publish, Retire.
        Note that the Re-publish action is available only after calling Block action.
        
## Formatting the outputs of get

Output of `get envs`, `get apis`, `get api-products` and `get apps` can be formatted with Go Templates. 

#### Available formatting options

<table>
    <thead>
        <tr class="header">
            <th>Name</th>
            <th>Usage</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd">
            <td>table</td>
            <td>This is the default format and the output is displayed as a table</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "table {% raw %}{{.Name}}\t{{.Id}}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>json</td>
            <td>Output is formatted as JSON</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ```
                    --format "{% raw %}{{ json . }}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>jsonPretty</td>
            <td>Outputs a human-readable JSON with indented by 2 spaces</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "table {% raw %}{{ jsonPretty . }}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>upper</td>
            <td>Convert string to uppercase</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "{% raw %}{{upper .Name}}\t{{upper .Context}}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>lower</td>
            <td>Convert string to lowercase</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "{% raw %}{{lower .Name}}\t{{lower .Context}}{% endraw %}"
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>title</td>
            <td>Convert the first letter to uppercase of a string</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "{% raw %}{{title .Name}}\t{{title .Context}}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
    </tbody>
</table>

## Set HTTP request timeout

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

## Set TLS renegotiation mode

By default, TLS renegotiation is disabled for the CTL tool. However, the TLS renegotiation mode can be configured by 
running the following command, which will be applied globally to all subsequent TLS connections established by the CTL.

-   **Command**
        ``` go
        apictl set --tls-renegotiation-mode <never|once|freely>
        ```
    
    !!! example
        ```bash
        apictl set --tls-renegotiation-mode freely
        ```
    
    !!! info
        **Flags:** 

        - Required :   
          `--tls-renegotiation-mode`

          Allowed values for this flag are,

          **never**: Disable TLS renegotiation

          **once**: Allow TLS renegotiation once

          **freely**: Allow unrestricted TLS renegotiation


## Set export directory

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
            
            
## Import SSL certificates for Secure HTTP Communication with API Manager

Different environments of API Manager can have different SSL certificates for secure HTTP communications. The default
certificate of WSO2 API Manager is a self-signed certificate and in production environments, it is advised to use a
different certificate than the default.   

If the certificate is the default WSO2 certificate or a CA-signed certificate of a CA (Certificate Authority) trusted by
the OS, these certificates will be imported by default to the controller. If the CA or the certificate is new or does
not get imported by default, you can add the certificate to the ```certs``` directory found in 
`APICTL_CONFIG_DIR/.wso2apictl`. 
(The default location of the certs directory is `/home/.wso2apictl/certs`)  

The certificates added to this directory will be imported whenever an action is performed with the controller. Any
DER or PEM encoded certificate with the file extensions of ```*.pem```, ```*.crt``` or ```*.cer``` can be used with the
controller. 

!!! Info
    If you are using Windows, CA certs will not be imported by default and have to be added to the ```certs``` directory.
