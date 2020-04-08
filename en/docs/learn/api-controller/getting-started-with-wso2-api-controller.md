# Getting Started with WSO2 API Controller

WSO2 API Controller(CTL) is a command-line tool for managing API Manager environments, listing APIs and applications, creating API projects, importing and exporting APIs and applications, generating tokens for testing purposes, etc.  

## Download and initialize the CTL Tool

1.  Navigate to the API Management Tooling page - <https://wso2.com/api-management/tooling/>
2.  Under **Dev-Ops Tooling**, click **Download** based on your preferred platform (i.e., Mac, Windows, Linux).
3.  Extract the downloaded archive of the CTL Tool to the desired location.

4.  Navigate to the working directory where the executable CTL Tool resides.

5.  Execute the following command to start the CTL Tool.

    !!! warn
        From API Manager Tooling 3.1.0 version onwards, the names of the endpoints have been modified and this causes changing the syntax in `/home/<user>/.wso2apictl/main_config.yaml` file. If you have an older file, you'll get an error while executing the apictl commands due to this. To avoid that, backup and remove `/home/<user>/.wso2apictl/main_config.yaml` file and reconfigure the environments using new commands as explained below in [Add an environment](#add-an-environment) section.
    
    ``` go
    ./apictl
    ```
    The directory structure for the configuration files ( `<USER_HOME>/.wso2apictl` ) will be created upon the execution of the `apictl` command.

6.  Add the location of the extracted folder to your system's `$PATH` variable to be able to access the executable from anywhere.


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
    Version: 3.1.0
    Build Date: 2020-03-31 13:22:12 UTC
    ```

## Set mode of the CTL

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

## Add an environment
        
You can add environments by either manually editing the `<USER_HOME>/.wso2apictl/main_config.yaml` file or by running the following CTL command.

``` go
apictl add-env
```

1.  Make sure that the WSO2 API Manager is started and that the CTL tool is running.     
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Run the following CTL command to add an environment.

    -   **Command**

        ``` bash tab="Linux/Unix"
        apictl add-env -e <environment-name> \
                        --registration <client-registration-endpoint> \
                        --apim <API-Manager-endpoint> \
                        --token <token-endpoint> \
                        --admin <admin-REST-API-endpoint> \
                        --publisher <Publisher-endpoint> \
                        --devportal <DevPortal-endpoint>
        ```

        ``` bash tab="Mac/Windows"
        apictl add-env -e <environment-name> --registration <client-registration-endpoint> --apim <API-Manager-endpoint> --token <token-endpoint> --admin <admin-REST-API-endpoint> --publisher <Publisher-endpoint> --devportal <DevPortal-endpoint>
        ```

        !!! info
            **Flags:**  
            
            -    Required :  

                `--environment` or `-e` : Name of the environment to be added   
                `--token` : Token endpoint for the environment
                AND (either)
                `--apim` : API Manager endpoint for the environments
                OR (the following 4)
                `--registration` : Registration endpoint for the environment 
                `--admin` : Admin endpoint for the environment  
                `--publisher` : Publisher endpoint for the environment  
                `--devportal` : DevPortal endpoint for the environment 
            
        !!! tip
            When adding an environment, when the optional flags are not given, CTL will automatically derive those from `--apim` flag value.

        !!! note
            The flags `--environment (-e)` and `--token` are mandatory.
            You can either provide only the 2 flags `--apim` and `--token`, or all the other 5 flags (`--registration`, `--publisher`, `--devportal`, `--admin`, `--token`) without providing `--apim` flag.
            If you are omitting any of `--registration`, `--publisher`, `--devportal`, `--admin` flags, you need to specify `--apim` flag with the API Manager endpoint.

        !!! example

            ``` bash tab="Linux/Unix"
            apictl add-env -e dev \
                        --apim https://localhost:9443 \
                        --token https://localhost:8243/token
            ``` 

            ``` bash tab="Mac/Windows"
            apictl add-env -e dev --apim https://localhost:9443 --token https://localhost:8243/token
            ```               

        !!! example

            ``` bash tab="Linux/Unix"
            apictl add-env -e production \
                        --registration https://idp.com:9444 \
                        --token https://gw.com:8244/token \
                        --admin https://apim.com:9444 \
                        --publisher https://apim.com:9444 \
                        --devportal https://apps.com:9444
            ```

            ``` bash tab="Mac/Windows"
            apictl add-env -e production --registration https://idp.com:9444 --token https://gw.com:8244/token --admin https://apim.com:9444 --publisher https://apim.com:9444 --devportal https://apps.com:9444
            ```  
    
        !!! example

            ``` bash tab="Linux/Unix"
            apictl add-env -e production \
                        --registration https://idp.com:9444 \
                        --apim https://apim.com:9444 \
                        --token https://gw.com:8244/token
            ```

            ``` bash tab="Mac/Windows"
            apictl add-env -e production --registration https://idp.com:9444 --apim https://apim.com:9444 --token https://gw.com:8244/token
            ```  

    -   **Response**
    
        ``` bash tab="Response Format"
        Successfully added environment '<environment-name>'
        ```

        ``` bash tab="Example Response"
        Successfully added environment 'production'
        ```

## Remove an environment

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.  
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
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

## List environments

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.    
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
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
        NAME                  API MANAGER ENDPOINT      REGISTRATION ENDPOINT      TOKEN ENDPOINT     PUBLISHER ENDPOINT       DEVPORTAL ENDPOINT       ADMIN ENDPOINT
        <environment-name>    <APIM-endpoint>           <registration-endpoint>    <token-endpoint>   <Publisher-endpoint>     <DevPortal-endpoint>     <admmin-endpoint>
        ```

        ```bash tab="Example Response"
        NAME         API MANAGER ENDPOINT     REGISTRATION ENDPOINT    TOKEN ENDPOINT                  PUBLISHER ENDPOINT       DEVPORTAL ENDPOINT       ADMIN ENDPOINT
        dev          https://localhost:9443   https://localhost:9443   https://localhost:8243/token    https://localhost:9443   https://localhost:9443   https://localhost:9443
        production   https://localhost:9444   https://localhost:9444   https://localhost:8244/token    https://localhost:9444   https://localhost:9444   https://localhost:9444

        ```

## Login to an environment

After adding an environment, you can log in to the API Manager instance in that environment using credentials.

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.   
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

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.   
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

## List APIs of an environment
Follow the instructions below to display a list of APIs in an environment using CTL:

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.   
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Log in to the API Manager in the environment by following the instructions in [Login to an Environment](#login-to-an-environment).
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

## List applications of an environment
Follow the instructions below to display a list of applications in an environment using CTL:

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.   
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Log in to the API Manager in the environment by following the instructions in [Login to an Environment](#login-to-an-environment).
3.  Run any of the following CTL commands to list the applications.

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

## Get keys for an API
Follow the instructions below to generate a JWT/OAuth token for testing purposes using CTL in order to invoke an API by subscribing to it using the default application:

1.  Make sure that WSO2 API Manager is started and the CTL tool is running.     
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2. Log in to the API Manager in the environment by following the instructions in [Login to an Environment](#login-to-an-environment).
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
        Upon running the above command, the CTL tool will create a default application in the environment, subscribe to the API, and generate keys based on the token type defined in the `<USER_HOME>/.wso2apictl/main-config.yaml`file. For information on changing the token type, see [Set Token Type](#set-token-type). 

## Set token type

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

