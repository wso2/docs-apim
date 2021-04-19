# Managing Applications

## Add Applications in an environment

You can add Applications via the Developer Portal.
However, **WSO2 API Controller (apictl)** allows you to create Applications without using the Developer Portal. For more information on adding Applications, see [Migrating Apps to Different Environments]({{base_path}}/install-and-setup/setup/api-controller/managing-applications/migrating-applications-to-different-environments).

## Get Applications in an environment

Follow the instructions below to display a list of Applications in an environment using apictl:

1.  Make sure that the WSO2 API Manager (WSO2 API-M) 4.0.0 version is started and that the 4.0.0 version of apictl is set up.   
     For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get (list) Applications in an environment.

    -   **Command**
        ``` bash
        apictl get apps -e <environment> 
        ```
        ``` bash
        apictl get apps --environment <environment> 
        ```
        ``` bash
        apictl get apps --environment <environment> --owner <application owner> 
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
            apictl get apps -e dev 
            ```
            ```bash
            apictl get apps --environment production 
            ```    
            ```go
            apictl get apps --environment production --owner sampleUser --limit 15 
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
            Output of the `get apps` command can be formatted with Go Templates. For more information on formatting the get commands, see [Formatting the outputs of get commands]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/formatting-the-output-of-get-command).

        !!!note
            `apictl list apps` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl get apps` as shown above. 
        
## Delete an Application in an environment

1.  Make sure that the WSO2 API-M 4.0.0 version is started and that the 4.0.0 version of apictl is set up.   
     For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get (list) Applications in an environment.

    -   **Command**
        ``` bash
         apictl delete app -n <application name> -e <environment> 
        ```
        ``` bash
        apictl delete app -name <application name> --environment <environment> 
        ```
        ``` bash
        apictl delete app --name <application name> --environment <environment> --owner <application owner> 
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
            apictl delete app -n DefaultApplication -e dev 
            ```
            ```bash
            apictl delete app --name DefaultApplication --environment production 
            ```    
            ```go
            apictl delete app --name DefaultApplication --environment production --owner sampleUser 
            ```  

    -   **Response**

        ```go
        DefaultApplication Application deleted successfully!
        ``` 
