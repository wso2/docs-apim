# Migrating Common API Policies to Different Environments

**WSO2 API Controller (apictl)** allows you to maintain multiple environments running on the same WSO2 API Manager (WSO2 API-M) version. This allows you to import and export Common API Policies between your environments. For example, if you have a Common API Policy defined in the development environment, you can export it and import it to the production environment. Thereby, Common API Policies do not have to be created from scratch in different environments.

!!! info
    **Before you begin** 

    -   Make sure apictl is initialized and setup, if not follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -  Make sure to add an environment before you start working with the following apictl commands, because all API Products need to be imported or exported to/from a specific environment.      
    For more information, visit [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).

!!! tip
    A user with `Internal/devops` role or `admin` role are allowed to import/export Common API Policies. To create a custom user who can import/export Common API Policies, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

### Export an Common API Policies

1.  Log in to the WSO2 API-M in the exporting environment by following steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).  
    
    !!! tip
        If you are already logged-in and your logged-in credentials and keys are already available in the `<USER_HOME>/.wso2apictl/keys.json` file, you can skip this step. 

    !!! info
        If you skip step 1 and if no keys exist for the environment in the `<USER_HOME>/.wso2apictl/keys.json` file, you will be prompt to log in to the environment when running the next command.

2.  Run any of the following apictl commands to export a Common API Policy as a `.zip` archive.  

    -   **Command**
     
        ```go
        apictl export policy api -n <Common API Policy name> -e <environment>  
        ``` 
        ```go
        apictl export policy api --name <Common API Policy name> --environment <environment>  
        ```

        !!! info
            **Flags:**  
            
            -    Required :  
                `--name` or `-n` : Name of the API Product to be exported      
                `--environment` or `-e` : Environment from which the API Product should be exported  
            
        !!! example
            ```go
            apictl export api-product -n addHeader -e dev 
            ```          

    -   **Response**

        ``` bash tab="Response Format"
        Successfully exported API Policy!
        Find the exported API Policies at /Users/benura/.wso2apictl/exported/policies/operation/<Policy Name>_<Polic Version>.zip
        ```

        ``` bash tab="Example Response"
        Successfully exported API Policy!
        Find the exported API Policies at /Users/benura/.wso2apictl/exported/policies/operation/testHeader_v1.zip
        ```

The exported ZIP file has the following structure:

``` java
<Common API Policy Name>
├── policySpecification.yaml
├── synapseDefinition.j2
├── ccDefinition.gotmpl
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
            <td><code>policySpecification.yaml</code></td>
            <td>Contains all the basic information required for a Common API Policy to be imported to another environment.</td>
        </tr>
        <tr class="even">
            <td><code>synapseDefinition.yaml</code></td>
            <td>Synapse gateway configurations which get applied during the runtime.</td>
        </tr>
        <tr class="odd">
            <td><code>ccDefinition.gotmpl</code></td>
            <td>Choreo Connect gateway configurations which get applied during the runtime.</td>
        </tr>
    </tbody>
</table>
