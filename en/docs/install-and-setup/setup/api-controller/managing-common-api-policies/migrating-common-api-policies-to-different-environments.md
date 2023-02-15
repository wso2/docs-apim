# Migrating Common API Policies to Different Environments

**WSO2 API Controller (apictl)** allows you to maintain multiple environments running on the same WSO2 API Manager (WSO2 API-M) version. This allows you to import and export Common API Policies between your environments. For example, if you have a Common API Policy defined in the development environment, you can export it and import it to the production environment. Thereby, Common API Policies do not have to be created from scratch in different environments.

!!! info
    **Before you begin** 

    -   Make sure apictl is initialized and setup, if not follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -  Make sure to add an environment before you start working with the following apictl commands, because all API Products need to be imported or exported to/from a specific environment.      
    For more information, visit [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).

!!! tip
    A user with `Internal/devops` role or `admin` role are allowed to import/export Common API Policies. To create a custom user who can import/export Common API Policies, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

### Export a Common API Policy

1.  Log in to the WSO2 API-M in the exporting environment by following steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to export a Common API Policy as a `.zip` archive.  

    -   **Command**
     
        ```bash
        apictl export policy api -n <Common API Policy name> -e <environment>  
        ``` 
        ```bash
        apictl export policy api --name <Common API Policy name> --environment <environment>  
        ```
        ```bash
        apictl export policy api --name <Common API Policy name> --environment <environment> --format <Policy Definition file format>
        ```

        !!! info
            **Flags:**  
            
            -    Required :  
                `--name` or `-n` : Name of the API Product to be exported
                `--version` or `-v` : Version of the common API Policy to be exported       
                `--environment` or `-e` : Environment from which the API Product should be exported  
            -   Optional :  
                `--format` : File format of exported policy definition file (JSON or YAML). The default value is YAML.   

        !!! example
            ```bash
            apictl export policy api -n addHeader -e dev
            ```          
            ```bash
            apictl export policy api -n addHeader -e dev --format JSON
            ``` 

    -   **Response**

        ``` bash tab="Response Format"
        Successfully exported API Policy!
        Find the exported API Policies at /Users/benura/.wso2apictl/exported/policies/api/<Environment Name>/<Policy Name>_<Policy Version>.zip
        ```

        ``` bash tab="Example Response"
        Successfully exported API Policy!
        Find the exported API Policies at /Users/benura/.wso2apictl/exported/policies/api/dev/addHeader_v1.zip
        ```

The exported ZIP file has the following structure:

``` java
<Common API Policy-name>
├── <Common API Policy-name>.yaml
├── <Common API Policy-name>.j2
├── <Common API Policy-name>.gotmpl
```

The structure of an exported Common API Policy ZIP file is explained below:

<table>
    <thead>
        <tr class="header">
            <th>Sub Directory/File</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd">
            <td><code>Policy-name.yaml</code></td>
            <td>Contains all the basic information required for a Common API Policy to be imported to another environment.</td>
        </tr>
        <tr class="even">
            <td><code>Policy-name.yaml</code></td>
            <td>Synapse gateway configurations which get applied during the runtime.</td>
        </tr>
        <tr class="odd">
            <td><code>Policy-name.gotmpl</code></td>
            <td>Choreo Connect gateway configurations which get applied during the runtime.</td>
        </tr>
    </tbody>
</table>

### Import a Common API Policy

You can use the common API Policy archive exported from the previous section (or you can extract it and use the extracted folder) and import it to the WSO2 API-M instance in the target environment. 

1.  Log in to the WSO2 API-M in the importing environment by following steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to import a common API Policy.

    -   **Command**
        ``` bash
        apictl import policy api -f <path to Common API Policy directory> -e <environment> 
        ```
        ``` bash
        apictl import policy api --file <path to Common API Policy directory> --environment <environment>
        ```
        ``` bash
        apictl import policy api -f  <path to Common API Policy archived file> -e <environment> 
        ```
        ``` bash
        apictl import policy api --file <path to Common API Policy archived file> --environment <environment>
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--file` or `-f` : The file path of the common API Policy to import.  
                `--environment` or `-e` : Environment to which the common API Policy should be imported.

        !!! example
            ```bash
            apictl import policy api -f ~/addHeader_v1.zip -e production 
            ```
            ```bash
            apictl import policy api --file ~/addHeader_v1.zip --environment production
            ```   
            ```bash
            apictl import policy api -f ~/AddHeader -e production 
            ``` 
            ``` go
            apictl import policy api --file ~/AddHeader --environment production 
            ```

        !!! tip
            If your file path is `/Users/benura/.wso2apictl/exported/policies/api/dev/addHeader_v1.zip`, then you need to enter `dev/addHeader_v1.zip` as the value for `--file` or `-f` flag.
       
     -   **Response**
        
        ``` bash
        Successfully Imported API Policy.
        ```
