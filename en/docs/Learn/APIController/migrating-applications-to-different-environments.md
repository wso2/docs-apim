# Migrating Apps to Different Environments
WSO2 API Controller, **apictl** allows you to maintain multiple environments running on the same WSO2 API-M version. This feature allows you to import and export applications between your environments. For example, if you have an application running in the development environment, you can import it and export it to the production environment. Thereby, applications do not have to be created from scratch in different environments.

!!! info
    **Before you begin...** 

    -   Make sure WSO2 API CTL Tool is initialized and running, if not follow the steps in [Download and Initialize the CTL Tool](../getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

    -  Make sure to add an environment before you start working with the following CTL commands, because all Applications need to be imported or exported to/from a specific environment.    
       For more information, visit [Add an Environment](../getting-started-with-wso2-api-controller#add-an-environment).
    
!!! warning
    -  Only the following types of users are allowed to export and import applications.  
        -   A user with the `admin` role.
        -   A user with a role having `apim:app_import_export` Admin REST API scope.

-   [Manage Application Lifecycle](#manage-application-lifecycle)
-   [Export an Application](#export-an-application)
-   [Import an Application](#import-an-application)
    -   [Import Applications in a Single Tenant Environment](#import-applications-in-a-single-tenant-environment)
    -   [Import Applications in a Multi-Tenant Environment](#import-applications-in-a-multi-tenant-environment)

## Manage Application Lifecycle

The lifecycle of an application could be defined as the stages of an application between the development and production environments. The feature facilitates to manage the application life cycle by allowing the user to migrate the applications within desired environments. The user should have admin permissions in order to use this.

![Managing Application Lifecycle](../../../assets/img/Learn/managing-application-lifecycle.png)


## Export an Application

You can export an application in the API Store and download it as a zipped file.

1.  Log in to the API Manager in exporting the environment by following steps in [Login to an Environment](../getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys already available in `$HOME/.wso2apictl/keys.json`, you can skip following above step 1. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in `$HOME/.wso2apictl/keys.json`, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following CTL commands to export an existing application as a `.zip` archive.

    -   Command 
        ``` java
        apictl export-app -n <application-name> -o <owner> -e <environment> -k
        ```

        ``` java
        apictl export-app --name <application-name> --owner <owner> --environment <environment> --insecure
        ```

        ``` java
        apictl export-app --name <application-name> --owner <owner> --environment <environment> --withKeys=<with-keys> --insecure
        ```

        !!! info
            **Flags:**  
            
            -    Required :  
                `--name` or `-n` : Name of the Application to be exported  
                `--owner` or `-o` : Owner of the Application to be exported          
                `--environment` or `-e` : Environment to which the Application should be exported  
            -   Optional :  
                `--withKeys` : Export keys for the application         

        !!! example
            ```go
            apictl export-app -n SampleApp -o admin -e dev -k
            ```
            ```go
            apictl export-app --name SampleApp --owner SampleUser --environment dev  -k
            ```       
            ```go
            apictl export-app --name SampleApp --owner SampleUser --environment dev --withKeys=true  -k
            ```     

    -   Response
        ``` java
        Successfully exported Application!
        Find the exported Application at /Users/kim/.wso2apimcli/exported/apps/dev/admin_SampleApp.zip
        ```

The exported application zipped file will be as follows:
```bash
<exported-Application>.zip        
 └── <Application-Name>        
 └── <Application-Name>.json        
```

## Import an Application

You can import an application to your environment as a zipped application. When you import an application as a zipped file, a new application is created within the target environment.

1.  Log in to the API Manager in exporting the environment by following steps in [Login to an Environment](../getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys already available in `$HOME/.wso2apictl/keys.json`, you can skip following above step 1. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in `$HOME/.wso2apictl/keys.json`, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following CTL commands to import an existing application as a `.zip` archive.

    -   **Command**
        ```go
        apictl import-app -f <file> -e <environment> -k         
        ```
        ```go
        apictl import-app --file <file> --environment <environment> -k         
        ```

        ```go
        apictl import-app -f <file> -e <environment> -s=<skip-subscriptions> -o <owner> --skipKeys=<skip-keys> -k      
        ```

        ```go
        apictl import-app --file <file> --environment <environment> --skipSubscriptions=<skip-subscriptions> --skipKeys=<skip-keys> --preserveOwner=<preserve-owner> --update=<update> --insecure
        ```

        !!! info
            **Flags:**  
            
            -    Required :  
                `--file` or `-f` : The file path of the exported Application   
                `--environment` or `-e` : Environment to which the Application should be imported to  
            -   Optional :  
                `--owner` or `-o` : Name of the target owner of the Application as desired by the importer  
                `--preserveOwner` : Preserves Application owner. Default false.    
                `--skipSubscriptions` or `-s` : Skip subscriptions of the Application. Default false.  
                `--skipKeys` : Skip importing keys of application Default false.  
                `--update` : Update application or create new. Default false. 


        !!! example
            ```go
            apictl import-app -f dev/admin_SampleApp.zip -e production
            ``` 
            ```go
            apictl import-app --file dev/admin_SampleApp.zip --environment production
            ```  
            ```go
            apictl import-app -f dev/admin_SampleApp.zip -e production -o admin --skipSubscriptions=true --skipKeys=true
            ```
            ```go
            apictl import-app -f dev/admin_SampleApp.zip -e production --preserveOwner=true 
            ```     
            ```go
            apictl import-app -f dev/admin_SampleApp.zip -e production --update=true
            ```  

        !!! tip
            If your file path is `/Users/kim/.wso2apictl/exported/apps/dev/admin_SampleApp.zip.`, then you need to enter `dev/admin_SampleApp.zip` as the value for `--file` flag.

    -   Response
        ``` java
        ZipFilePath: /Users/kim/.wso2apictl/exported/apps/dev/admin_SampleApp.zip
        Completed importing the Application 'dev/admin_SampleApp.zip'
        Succesfully imported Application!
        ```

    !!! note
        **Skipping Subscriptions/Keys while Importing Application**  
            You can opt to skip importing the subscriptions of the application by defining `--skipSubscriptions` or `-s` flag. This parameter is set to false by default.  
            &nbsp;   
            You can opt to skip importing the keys (client credentials of the OAuth App) of the application by defining `--skipKeys`.  This parameter is set to false by default.  
            &nbsp;   
        **Changing/Preserving Owner while Importing Application**       
            The owner of the imported application can be specified by providing a username of a valid user based on your preference. The application importer can set the preferred owner’s username as the value of the `--owner` or `-o` flag.    
            &nbsp;     
            You can also import the application by preserving the application owner’s information, from the previous environment. The application importer can add the `--preserveOwner` flag in order to define that this flag is set to true. This parameter is set to false by default. Therefore, the default value is used when you do not define this flag. If you import the application without specifying any of the optional flags, you will be added as the owner of the application in the imported environment.
            &nbsp;   
            &nbsp;       
            If both the `--owner` and the `--preserveOwner` flags are set, then the `--owner` flag gets higher priority over the `--preserveOwner` flag. 


### Import Applications in a Single Tenant Environment

There are three options to import applications in a single-tenant environment.

-   Application A in environment 1 is migrated to environment 2. Some APIs may not be available in environment 2 (API B in this case) and the relevant subscriptions are not added in such cases (skipped).
    ![Importing Applications across Two Environments with the Same Owner](../../../assets/img/Learn/import-apps-tenanted-env1.png)

-   A different owner can be specified while importing an application to environment 2,  without preserving the original user of environment 1.
    ![Importing Applications across Two environments with Different Owners](../../../assets/img/Learn/import-apps-tenanted-env2.png)
-   The original owner of the application can be preserved when the application is imported to environment 2 by adding the `--preserveOwner` flag.
    ![Importing Applications across Two environments with Preserve Owner](../../../assets/img/Learn/import-apps-tenanted-env3.png)

### Import Applications in a Multi-Tenant Environment

In a situation where an application has API subscriptions in different tenant domains, such subscriptions are added if the relevant APIs with the target tier, are available in the importing environment. Note that the provider of the API may not be the same in the importing environment.
