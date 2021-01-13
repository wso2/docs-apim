# Managing Integrations with CTL

WSO2 API Controller, **apictl** allows you to monitor the synapse artifacts (deployed in a specified Micro Integrator server) and perform various management and administration tasks from the command line. **apictl** communicates with the management API of WSO2 Micro Integrator to function.

!!! info
    **Before you begin** 

    -   Make sure WSO2 API CTL Tool is initialized and running, if not follow the steps in [Download and Initialize the CTL Tool]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

    -  Make sure to add the micro integrator to an environment before you start working with the following CTL commands.      
    For more information, visit [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#add-an-environment).

## Login to a Micro Integrator

After adding an environment, you can log in to the Micro Integrator instance in that environment using credentials.

1.  Make sure that the WSO2 Micro Integrator 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.   
2.  Run any of the following CTL commands to log in to a Micro Integrator.

    -   **Command**

        ```go
        apictl mi login <environment-name> -k
        ```

        ```go
        apictl mi login <environment-name> -u <username> -k
        ```

        ```go
        apictl mi login <environment-name> -u <username> -p <password> -k
        ``` 

        !!! tip
            If you run `apictl mi login <environment-name>` you are prompted to provide both the username and the password.
            If you run `apictl mi login <environment-name> --username <username>`, you are prompted to provide the password.

        !!! info
            **Flags:**  
            
            -    Optional :     
                `--username` or `-u` : Username for login  
                `--password` or `-p` : Password for login     
                `--password-stdin` : Get password from stdin  

        !!! example
            ```bash
            apictl mi login dev -k
            ```
            ```bash
            apictl mi login dev -u admin -p admin -k
            ```
            
            ```bash
            apictl mi login dev --username admin --password admin -k
            ```
                 
    -   **Response**

        ``` bash tab="Response Format"
        Logged into MI in '<environment-name>' environment 
        ```

        ```bash tab="Example Response"
        Logged into MI in dev environment
        ```

    !!! warning
        Using -`-password` in CTL is not secure. You can use `--password-stdin` instead. For example,
        ```bash
        cat ~/.mypassword | ./apictl mi login dev --username admin --password-stdin -k
        ```          

## Logout from a Micro Integrator

1.  Make sure that the WSO2 Micro Integrator 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.   
For more information, see [Download and Initialize the CTL Tool]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

2.  Run the following command to log out from the current session of the Micro Integrator.

    -   **Command** 

        ```go
        apictl mi logout <environment-name>
        ```

        !!! example
            ```go
            apictl mi logout dev
            ```
    
    -   **Response**

        ``` bash tab="Response Format"
        Logged out from MI in '<environment-name>' environment 
        ```

        ```bash tab="Example Response"
        Logged out from MI in dev environment
        ```
