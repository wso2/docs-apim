# ImportingCommon API Policy Via Dev First Approach

**WSO2 API Controller (apictl)** allows you to create Common API Policies without using the Publisher Portal of the WSO2 API Manager (WSO2 API-M). You can use this feature to create a Common API Policy **from scratch** in the desired WSO2 API-M environment.

!!! info
    **Before you begin** 

    -   Make sure that the apictl is downloaded and initialized, if not, follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -   Make sure you already have added an environment using the apictl for the WSO2 API-M environment you plan to import the Common API Policy to. 

        If not, follow the steps in [Add an Environment]({{base_path}}/install-and-setup/setup//api-controller/getting-started-with-wso2-api-controller#add-an-environment).


## Import a Common API Policy

!!! info
    **Before you begin...** 

    -   Make sure you have already created an environment to which you are planning to import a Common API Policy. If not, follow steps in [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).
    
    -   Make sure you have logged-in to the importing environment. If not, follow steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment).

    -   Make sure you have created a policy directory with necessary definition files included.

     A project folder with the following files should be created.

    ``` java
    ├── policySpecification.yaml
    ├── synapseDefinition.j2
    ├── ccDefinition.gotmpl
    ```

!!!note
    When creating policies, two gateway configurations are supported. Synapse and Choreo. Hence, when creating the directory either synapse definition or choreo definition or both files should be included along with the policy specification file.

!!! tip
    A user with `Internal/devops` role or `admin` role are allowed to import Common API Policies. To create a custom user who can import Common API Policies, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

After exporting a Common API Policy from one environment, you can import the corresponding Common API Policy to the desired environment using any of the following commands.  

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
    apictl import api --file <path to Common API Policy archived file> --environment <environment>
    ```

    !!! info
        **Flags:**  
           
        -   Required :  
            `--file` or `-f` : The file path of the Common API Policy to import.  
            `--environment` or `-e` : Environment to which the Common API Policy should be imported.  

    !!! example
        ```bash
        apictl import policy api -f ~/addHeader_v1.zip -e production 
        ```
        ```bash
        apictl import api --file ~/addHeader_v1.zip --environment production
        ```   
        ```bash
        apictl import policy api -f ~/AddHeader -e production 
        ``` 
        ``` go
        apictl import api --file ~/AddHeader --environment production 
        ```

    !!!note
        --file flag accepts both directory type and the archived file of the policy.
       
-   **Response**
    ``` bash
    Successfully Imported API Policy!
    ```
    
