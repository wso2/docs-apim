# Getting Started with WSO2 API Controller (apictl)

**WSO2 API Controller (apictl)** is a command-line tool providing the capability to move APIs, API Products, and Applications across environments and to perform CI/CD operations. It can also be used to perform these same tasks on a Kubernetes deployment. Furthermore, it can perform WSO2 Micro Integrator (WSO2 MI) server specific operations such as monitoring Synapse artifacts and performing MI management/administrative tasks from the command line.

## Download and initialize the apictl

1.  Download **apictl** based on your preferred platform (i.e., Mac, Windows, Linux).

    - [For Mac with Intel Chip](https://github.com/wso2/product-apim-tooling/releases/download/v4.6.0-rc2/apictl-4.6.0-rc2-darwin-amd64.tar.gz)
    - [For Mac with Apple Silicon](https://github.com/wso2/product-apim-tooling/releases/download/v4.6.0-rc2/apictl-4.6.0-rc2-darwin-arm64.tar.gz)
    - [For Linux 32-bit](https://github.com/wso2/product-apim-tooling/releases/download/v4.6.0-rc2/apictl-4.6.0-rc2-linux-i586.tar.gz)
    - [For Linux 64-bit with AMD processor](https://github.com/wso2/product-apim-tooling/releases/download/v4.6.0-rc2/apictl-4.6.0-rc2-linux-amd64.tar.gz)
    - [For Linux 64-bit with ARM processor](https://github.com/wso2/product-apim-tooling/releases/download/v4.6.0-rc2/apictl-4.6.0-rc2-linux-arm64.tar.gz)
    - [For Windows 32-bit](https://github.com/wso2/product-apim-tooling/releases/download/v4.6.0-rc2/apictl-4.6.0-rc2-windows-i586.zip)
    - [For Windows 64-bit](https://github.com/wso2/product-apim-tooling/releases/download/v4.6.0-rc2/apictl-4.6.0-rc2-windows-x64.zip)

2.  Extract the downloaded archive of the apictl to the desired location.
3.  Navigate to the working directory where the executable apictl resides.
4.  Add the current working directory to your system's `$PATH` variable to be able to access the executable from anywhere.
5.  Execute the following command to start the apictl.

    !!! Warn
        If you have previously used an apictl old version, backup and remove `/home/<user>/.wso2apictl` directory and reconfigure the environments using the commands as explained below in [Add an environment](#add-an-environment) section.

    ``` go
    apictl
    ```

    The directory structure for the configuration files (`<USER_HOME>/.wso2apictl`) will be created upon the execution of the `apictl` command.

    !!! Tip
        If you want to change the default location for the .wso2apictl directory, set an environment variable (**APICTL_CONFIG_DIR**) as follows with the path for the desired location.

        === "Linux/Mac"
            ```go
            export APICTL_CONFIG_DIR="/home/wso2user/CLI"
            ```

        === "Windows"
            ```go
            set APICTL_CONFIG_DIR=C:\Users\wso2user\CLI
            ```


    !!! Tip    
        For further instructions, execute the following command.
        
        ``` go
        apictl --help
        ```

## Global flags for apictl

The following are some global flags that you can use with any apictl command.

``` go
--verbose
    Enable verbose logs (Provides more information on execution)
--insecure, -k
    Allow connections to SSL sites without certs
--help, -h
    Display information and example usage of a command
```

## Check the version of the apictl

Run the following apictl command to check the version.

-   **Command**
    ```bash
    apictl version
    ```
-   **Response**

    ```bash
    Version: 4.6.0-rc2
    Build Date: 2024-10-24 18:51:53 UTC
    ```

!!!note
    **Set mode of apictl**

    From the apictl 4.0.0 onwards the flag (--mode) which was used to set the mode of apictl has been deprecated. Now, you do not need to set the mode of apictl, because if you want to execute Kubernetes based commads, you just need to add the `k8s` keyword after `apictl` keyword. (Example: `apictl k8s add api`). By default apictl will execute the commands in the `default` mode (which means if you did not use `k8s` keyword).

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

## Set proxy environment variables for apictl

You can set proxy related `HTTP_PROXY`, `HTTPS_PROXY`, `http_proxy`, and `https_proxy` standard environment variables, with or without basic authentication as shown below to send the requests initiated from CTL via a proxy server. After one of the following environment variables is set in your environment where CTL is used, all the requests will go through the proxy server specified.

-   **Formats**

    === "Without Basic Authentication"
        ``` bash
        export HTTP_PROXY="http://<host-name>:<port>"

        export HTTPS_PROXY="https://<host-name>:<port>"

        export http_proxy="http://<host-name>:<port>"

        export https_proxy="https://<host-name>:<port>"
        ```

    === "With Basic Authentication"
        ``` bash
        export HTTP_PROXY="http://<username>:<password>@<host-name>:<port>"

        export HTTPS_PROXY="https://<username>:<password>@<host-name>:<port>"

        export http_proxy="http://<username>:<password>@<host-name>:<port>"

        export https_proxy="https://<username>:<password>@<host-name>:<port>"
        ```

-   **Examples**

    === "Without Basic Authentication"
        ``` bash
        export HTTP_PROXY="http://localhost:3128"

        export HTTPS_PROXY="https://localhost:3128"

        export http_proxy="http://localhost:3128"

        export https_proxy="https://localhost:3128"
        ```

    === "With Basic Authentication"
        ``` bash
        export HTTP_PROXY="http://testuser:password@localhost:3128"

        export HTTPS_PROXY="https://testuser:password@localhost:3128"

        export http_proxy="http://testuser:password@localhost:3128"

        export https_proxy="https://testuser:password@localhost:3128"
        ```

## Add an environment
        
You can add environments by either manually editing the `<USER_HOME>/.wso2apictl/main_config.yaml` file or by running the following apictl command.

``` go
apictl add env <environment-name>
```

1.  Make sure that the WSO2 API Manager started and that the apictl is set up.     
For more information, see [Download and Initialize the apictl](#download-and-initialize-the-apictl).
2.  Run the following apictl command to add an environment.

    -   **Command**

        === "Linux/Unix"
            ``` bash
            apictl add env <environment-name> \
                        --registration <client-registration-endpoint> \
                        --apim <API-Manager-endpoint> \
                        --token <token-endpoint> \
                        --admin <admin-REST-API-endpoint> \
                        --publisher <publisher-portal-endpoint> \
                        --devportal <developer-portal-endpoint> \
                        --mi <mi-management-endpoint>
            ```

        === "Mac/Windows"
            ``` bash
            apictl add env <environment-name> --registration <client-registration-endpoint> --apim <API-Manager-endpoint> --token <token-endpoint> --admin <admin-REST-API-endpoint> --publisher <publisher-portal-endpoint> --devportal <developer-portal-endpoint> --mi <mi-management-endpoint>
            ```

        !!! info
            **Flags:**  
            
            **To add a WSO2 API-M**

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

            **To add a WSO2 MI**

            -    Required :     
                `--mi` : Management endpoint of the Micro Integrator
            
        !!! tip
            When adding an environment, when the optional flags are not given, apictl will automatically derive those from `--apim` flag value.

        !!! note
            You can either provide only the flag `--apim` , or all the other 4 flags (`--registration`, `--publisher`, `--devportal`, `--admin`) without providing `--apim` flag.
            If you are omitting any of `--registration`, `--publisher`, `--devportal`, `--admin` flags, you need to specify `--apim` flag with the WSO2 API-M endpoint.
            In both of the above cases `--token`  flag is optional and can be used to provide a user-preferred token endpoint.
            You can use the `--mi` flag to add a Micro Integrator instance to an environment.

    -   Adding a WSO2 API-M to an environment using `--apim` flag

        !!! example

            === "Linux/Unix"
                ``` bash
                apictl add env dev \
                    --apim https://localhost:9443 
                ``` 

            === "Mac/Windows"
                ``` bash
                apictl add env dev --apim https://localhost:9443 
                ```               

    -   Adding a WSO2 API-M to an environment using `--registration`, `--publisher`, `--devportal`, `--admin` flags

        !!! example

            === "Linux/Unix"
                ``` bash
                apictl add env production \
                            --registration https://idp.com:9444 \
                            --admin https://apim.com:9444 \
                            --publisher https://apim.com:9444 \
                            --devportal https://apps.com:9444 \
                            --token https://apim.com:9444/oauth2/token                        
                ```

            === "Mac/Windows"
                ``` bash
                apictl add env production --registration https://idp.com:9444  --admin https://apim.com:9444 --publisher https://apim.com:9444 --devportal https://apps.com:9444 --token https://apim.com:9444/oauth2/token
                ```  

    -   Adding a WSO2 API-M to an environment using some of the `--registration`, `--publisher`, `--devportal`, `--admin` flags along with `--apim` flag

        !!! example

            === "Linux/Unix"
                ``` bash
                apictl add env production \
                            --registration https://idp.com:9444 \
                            --apim https://apim.com:9444 \
                            --token https://apim.com:9444/oauth2/token
                ```

            === "Mac/Windows"
                ``` bash
                apictl add env production --registration https://idp.com:9444 --apim https://apim.com:9444 --token https://apim.com:9444/oauth2/token
                ```  

    -   Adding a WSO2 MI to an environment using `--mi` flag

        !!! example

            === "Linux/Unix"
                ``` bash
                apictl add env dev \
                            --mi https://localhost:9164
                ```

            === "Mac/Windows"
                ``` bash
                apictl add env dev --mi https://localhost:9164
                ```

    -   Adding both WSO2 API-M and WSO2 MI to an environment

        !!! example

            === "Linux/Unix"
                ``` bash
                apictl add env test \
                    --apim https://localhost:9443 \
                    --mi https://localhost:9164
                ```

            === "Mac/Windows"
                ``` bash
                apictl add env test --apim https://localhost:9443 --mi https://localhost:9164
                ```

        !!!note
            `apictl add-env` command has been deprecated from apictl 4.0.0 onwards. Instead, use `apictl add env` as shown above. 

    -   **Response**
    
        === "Response Format"
            ``` bash
            Successfully added environment '<environment-name>'
            ```

        === "Example Response"
            ``` bash
            Successfully added environment 'production'
            ```

## Remove an environment

1.  Make sure that the WSO2 API-M is started and that the apictl is set up.  
For more information, see [Download and Initialize the apictl](#download-and-initialize-the-apictl).
2.  Run the following apictl command to remove an environment.

    -   **Command**

        ```bash
        apictl remove env <environment-name> 
        ``` 
  
        !!! example
            ```bash
            apictl remove env production
            ```

    -   **Response**

        === "Response Format"
            ``` bash
            Successfully removed environment '<environment-name>'
            Execute 'apictl add env --help' to see how to add a new environment
            ```

        === "Example Response"
            ``` bash
            Successfully removed environment 'production'
            Execute 'apictl add env --help' to see how to add a new environment
            ```

## Get environments

1.  Make sure that the WSO2 API-M is started and that the apictl is set up.    
For more information, see [Download and Initialize the apictl](#download-and-initialize-the-apictl).
2.  Run the following apictl command to list the environments.  

    -   **Command**

        ```bash
        apictl get envs
        ``` 

        !!! info
            **Flags:**  
            
            -    Optional :     
                `--format` : pretty-print environments using Go templates 

    -   **Response**

        === "Response Format"
            ``` bash
            NAME                  API MANAGER ENDPOINT      REGISTRATION ENDPOINT      TOKEN ENDPOINT     PUBLISHER ENDPOINT       DEVPORTAL ENDPOINT       ADMIN ENDPOINT          MI MANAGEMENT ENDPOINT
            <environment-name>    <APIM-endpoint>           <registration-endpoint>    <token-endpoint>   <Publisher-endpoint>     <DevPortal-endpoint>     <admmin-endpoint>       <mi-management-endpoint>
            ```

        === "Example Response"
            ```bash
            NAME         API MANAGER ENDPOINT     REGISTRATION ENDPOINT    TOKEN ENDPOINT                  PUBLISHER ENDPOINT       DEVPORTAL ENDPOINT       ADMIN ENDPOINT             MI MANAGEMENT ENDPOINT
            dev          https://localhost:9443   https://localhost:9443   https://localhost:9443/oauth2/token    https://localhost:9443   https://localhost:9443   https://localhost:9443
            production   https://localhost:9444   https://localhost:9444   https://localhost:9443/oauth2/token    https://localhost:9444   https://localhost:9444   https://localhost:9444     https://localhost:9164
            dev-mi                                                                                                                                                                      https://localhost:9164

            ```

        !!!note
            Output of the `get envs` command can be formatted with Go Templates. For more information on formatting the get commands, see [Formatting the outputs of get commands]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/formatting-the-output-of-get-command).

        !!!note
            `apictl list envs` command has been deprecated from the apictl 4.0.0 onwards. Instead use `apictl get envs` as shown above. 

## Login to an environment

After adding an environment, you can log in to the WSO2 API-M instance in that environment using credentials.

1.  Make sure that the WSO2 API-M is started and that the apictl is set up.   
For more information, see [Download and Initialize the apictl](#download-and-initialize-the-apictl).
2.  Run any of the following apictl commands to log in to the environment.

    -   **Command**

        ```go
        apictl login <environment-name> 
        ```

        ```go
        apictl login <environment-name> -u <username> 
        ```

        ```go
        apictl login <environment-name> -u <username> -p <password> 
        ``` 
        ```go
        apictl login <environment-name> --token <access-token>
        ```

        !!! tip
            If you run `apictl login <environment-name>` you are prompted to provide both the username and the password.
            If you run `apictl login <environment-name> --username <username>`, you are prompted to provide the password.

        !!! tip 
            If you want to pass the access token directly as `apictl login <environment-name> --token <access-token>`, you can generate a personal access token providing the required scopes, see [Minimal permissions and scopes required to perform apictl operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations)        

        !!! info
            **Flags:**  
            
            -    Optional :     
                `--username` or `-u` : Username for login  
                `--password` or `-p` : Password for login     
                `--password-stdin` : Get password from stdin  
                `--token` : Personal access token

        !!! example
            ```bash
            apictl login dev 
            ```
            ```bash
            apictl login dev -u admin -p admin 
            ```
            ```bash
            apictl login dev --username admin --password admin 
            ```
            ```bash
            apictl login dev --token 45ab5790-aa3f-3ebb-882b-37b81f585976 
            ```
                 
    -   **Response**

        === "Response Format"
            ``` bash
            Logged into '<environment-name>' environment 
            ```

        === "Example Response"
            ```bash
            Logged into dev environment
            ```

    !!! warning
        Using -`-password` in apictl is not secure. You can use `--password-stdin` instead. For example,
        ```bash
        cat ~/.mypassword | ./apictl login dev --username admin --password-stdin 
        ```          

## Logout from an environment

1.  Make sure that the WSO2 API-M is started and that the apictl is set up.   
For more information, see [Download and Initialize the apictl](#download-and-initialize-the-apictl).

2.  Run the following command to log out from the current session of the WSO2 API-M environment.

    -   **Command** 

        ```go
        apictl logout <environment-name>
        ```

        !!! example
            ```go
            apictl logout dev
            ```
                    
## Set HTTP request timeout

Run the following apictl command to set the HTTP request timeout.

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

By default, TLS renegotiation is disabled for the apictl. However, the TLS renegotiation mode can be configured by 
running the following command, which will be applied globally to all subsequent TLS connections established by apictl.

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

Run the following apictl command to change the default location of the export directory.

-   **Command**
        ``` go
        apictl set --export-directory <export-directory-path>
        ```

    !!! example

        === "Linux/Mac"
            ```go
            apictl set --export-directory /home/user/exported-apis
            ```

        === "Windows"
            ```go
            apictl set --export-directoty C:\Documents\exported
            ```
        
    !!! info
        **Flags:** 

        - Required :   
            `--export-directory`: Path to directory where APIs, API Products, and Applications should be saved.   
            Default : `/home/.wso2apictl/exported`
            
            
## Import SSL certificates for Secure HTTP communication with WSO2 API-M

Different environments of WSO2 API-M can have different SSL certificates for secure HTTP communications. The default
certificate of WSO2 API-M is a self-signed certificate and in production environments, it is advised to use a
different certificate than the default.   

If the certificate is the default WSO2 certificate or a CA-signed certificate of a CA (Certificate Authority) trusted by
the OS, these certificates will be imported by default to apictl. If the CA or the certificate is new or does
not get imported by default, you can add the certificate to the ```certs``` directory found in 
`APICTL_CONFIG_DIR/.wso2apictl`. 
(The default location of the certs directory is `/home/.wso2apictl/certs`)  

The certificates added to this directory will be imported whenever an action is performed with apictl. Any
DER or PEM encoded certificate with the file extensions of ```*.pem```, ```*.crt``` or ```*.cer``` can be used with apictl.

!!! Info
    If you are using Windows, CA certs will not be imported by default and have to be added to the ```certs``` directory.
