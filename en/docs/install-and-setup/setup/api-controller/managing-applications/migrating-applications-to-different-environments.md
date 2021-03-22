# Migrating Apps to Different Environments
**WSO2 API Controller (apictl)** allows you to maintain multiple environments running on the same WSO2 API Manager (WSO2 API-M) version. This feature allows you to import and export applications between your environments. For example, if you have an application running in the development environment, you can import it and export it to the production environment. Thereby, applications do not have to be created from scratch in different environments.

!!! info
    **Before you begin** 

    -   Make sure apictl is initialized and running, if not follow the instructions in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -  Make sure to add an environment before you start working with the following CTL commands, because all applications need to be imported or exported to/from a specific environment.    
       For more information, see [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).
    
!!! tip
    A user with `Internal/devops` role or `admin` role are allowed to import/export Applications. To create a custom user who can import/export APIs, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

## Manage the application lifecycle

The lifecycle of an application could be defined as the stages of an application between the development and production environments. The feature facilitates to manage the application life cycle by allowing the user to migrate the applications within desired environments. The user should have admin permissions in order to use this.

[![Managing Application Lifecycle]({{base_path}}/assets/img/learn/managing-application-lifecycle.png)]({{base_path}}/assets/img/learn/managing-application-lifecycle.png)


## Export an application

You can export an application in the Developer Portal and download it as a zipped file.

1.  Log in to the WSO2 API-M in the exporting environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and the keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to export an existing application as a `.zip` archive.

    -   Command 
        ``` java
        apictl export app -n <application-name> -o <owner> -e <environment> 
        ```

        ``` java
        apictl export app --name <application-name> --owner <owner> --environment <environment> 
        ```

        ``` java
        apictl export app --name <application-name> --owner <owner> --environment <environment> --with-keys=<with-keys> 
        ```

        !!! info
            **Flags:**  
            
            -    Required :  
                `--name` or `-n` : Name of the application to be exported  
                `--owner` or `-o` : Owner of the application to be exported          
                `--environment` or `-e` : Environment to which the application should be exported  
            -   Optional :  
                `--with-keys` : Export keys for the application    
                `--format` : File format of exported archive (JSON or YAML). The default value is YAML.     

        !!! example
            ```go
            apictl export app -n SampleApp -o admin -e dev 
            ```
            ```go
            apictl export app --name SampleApp --owner SampleUser --environment dev  
            ```       
            ```go
            apictl export app --name SampleApp --owner SampleUser --environment dev --with-keys=true  
            ```     

        !!!note
            `apictl export-app` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl export app` as shown above.

    -   **Response**

        ``` bash tab="Response Format"
        Successfully exported Application!
        Find the exported Application at <USER_HOME>/.wso2apictl/exported/apps/<envrionment-name>/<Application-owner>_<Application-name>.zip
        ```

        ``` bash tab="Example Response"
        Successfully exported Application!
        Find the exported Application at /Users/kim/.wso2apictl/exported/apps/dev/admin_SampleApp.zip
        ```

The exported application zipped file will be as follows:
```bash
<Application-owner>_<Application-name>.zip         
 ├── application.yaml  
 └── application_meta.yaml       
```

The structure of an exported Application ZIP file is explained below:

<table>
    <thead>
        <tr class="header">
            <th>File</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd">
            <td><code>application.yaml</code></td>
            <td>Contains all the basic information required for an Application to be imported to another environment.</td>
        </tr>
        <tr class="even">
            <td><code>application_meta.yaml</code></td>
            <td>The meta-information file of the source artifact (This includes the name and the owner of the Application).</td>
        </tr>
     </tbody>
</table>

## Import an application

You can import an application to your environment as a zipped application. When you import an application as a zipped file, a new application is created within the target environment.

1.  Log in to the WSO2 API-M in the importing environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and the keys already are available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to import an existing application as a `.zip` archive.

    -   **Command**
        ```go
        apictl import app -f <file> -e <environment>          
        ```
        ```go
        apictl import app --file <file> --environment <environment>          
        ```

        ```go
        apictl import app -f <file> -e <environment> -s=<skip-subscriptions> -o <owner> --skip-keys=<skip-keys>       
        ```

        ```go
        apictl import app --file <file> --environment <environment> --skip-subscriptions=<skip-subscriptions> --skip-keys=<skip-keys> --preserve-owner=<preserve-owner> --update=<update> 
        ```

        !!! info
            **Flags:**  
            
            -    Required :  
                `--file` or `-f` : The file path of the exported application.   
                `--environment` or `-e` : Environment to which the application should be imported.  
            -   Optional :  
                `--owner` or `-o` : Name of the target owner of the application as desired by the importer  
                `--preserve-owner` : Preserves application owner. Default `false`.    
                `--skip-subscriptions` or `-s` : Skip subscriptions of the application. Default `false`.  
                `--skip-keys` : Skip importing keys of application Default `false`.  
                `--update` : Update application or create new. Default `false`. 


        !!! example
            ```go
            apictl import app -f dev/admin_SampleApp.zip -e production
            ``` 
            ```go
            apictl import app --file dev/admin_SampleApp.zip --environment production
            ```  
            ```go
            apictl import app -f dev/admin_SampleApp.zip -e production -o admin --skip-subscriptions=true --skip-keys=true
            ```
            ```go
            apictl import app -f dev/admin_SampleApp.zip -e production --preserve-owner=true 
            ```     
            ```go
            apictl import app -f dev/admin_SampleApp.zip -e production --update=true
            ```  

        !!! tip
            If your file path is `/Users/kim/.wso2apictl/exported/apps/dev/admin_SampleApp.zip.`, then you need to enter `dev/admin_SampleApp.zip` as the value for `--file` flag.

        !!!note
            `apictl import-app` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl import app` as shown above.

    -   **Response**
        ``` bash
        Succesfully imported Application!
        ```

    !!! note
        **Skipping subscriptions/keys while importing application**  
            You can opt to skip importing the subscriptions of the application by defining `--skip-subscriptions` or `-s` flag. This parameter is set to `false` by default.  
            &nbsp;   
            You can opt to skip importing the keys (client credentials of the OAuth App) of the application by defining `--skip-keys`.  This parameter is set to `false` by default.  
            &nbsp;   
        **Changing/Preserving Owner while Importing Application**       
            The owner of the imported application can be specified by providing a username of a valid user based on your preference. The application importer can set the preferred owner’s username as the value of the `--owner` or `-o` flag.    
            &nbsp;     
            You can also import the application by preserving the application owner’s information, from the previous environment. The application importer can add the `--preserve-owner` flag in order to define that this flag is set to true. This parameter is set to false by default. Therefore, the default value is used when you do not define this flag. If you import the application without specifying any of the optional flags, you will be added as the owner of the application in the imported environment.
            &nbsp;   
            &nbsp;       
            If both the `--owner` and the `--preserve-owner` flags are set, then the `--owner` flag gets higher priority over the `--preserve-owner` flag. 


### Import applications in a single-tenant environment

There are three options to import applications in a single-tenant environment.

-   Application A in environment 1 is migrated to environment 2. Some APIs may not be available in environment 2 (API B in this case) and the relevant subscriptions are not added in such cases (skipped).
    [![Importing Applications across Two Environments with the Same Owner]({{base_path}}/assets/img/learn/import-apps-tenanted-env1.png)]({{base_path}}/assets/img/learn/import-apps-tenanted-env1.png)
-   A different owner can be specified while importing an application to environment 2,  without preserving the original user of environment 1.
    [![Importing Applications across Two environments with Different Owners]({{base_path}}/assets/img/learn/import-apps-tenanted-env2.png)]({{base_path}}/assets/img/learn/import-apps-tenanted-env2.png)
-   The original owner of the application can be preserved when the application is imported to environment 2 by adding the `--preserve-owner` flag.
    [![Importing Applications across Two environments with Preserve Owner]({{base_path}}/assets/img/learn/import-apps-tenanted-env3.png)]({{base_path}}/assets/img/learn/import-apps-tenanted-env3.png)

### Import applications in a multi-tenant environment

In a situation where an application has API subscriptions in different tenant domains, such subscriptions are added if the relevant APIs with the target tier, are available in the importing environment. Note that the provider of the API may not be the same in the importing environment.
