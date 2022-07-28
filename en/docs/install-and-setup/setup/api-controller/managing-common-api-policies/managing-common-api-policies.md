# Managing Common API Policies

## Add Common API Policies in an environment

You can add Common API Policies via the Publisher Portal.
However, **WSO2 API Controller (apictl)** allows you to create API Policies without using the Publisher Portal. For more information on adding Common API Policies, see [Importing Common API Policies Via Dev First Approach]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-common-api-policies-via-dev-first-approach).

## Get Common API Policies in an environment

Follow the instructions below to display a list of Common API Policies in an environment using apictl:

1.  Make sure that the WSO2 API Manager (WSO2 API-M) 4.1.0 version is started and that the 4.1.0 version of apictl is set up.   
     For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get (list) Common API Policies in an environment.

    1. Get API Common Policies in an environment.

        -   **Command**
            ``` bash
            apictl get policies api -e <environment>
            ```
            ``` bash
            apictl get policies api --environment <environment>
            ```
            ``` bash
            apictl get policies api --environment <environment> --all 
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment to be searched  
                -   Optional :
                    `--all`: All Common API Policies available in the environment
                    `--limit` or `-l` : Maximum number of Common API Policies to return (Default 25)
                    `--format` : pretty-print environments using templates

            !!! example
                ```bash
                apictl get policies api -e dev 
                ```
                ```bash
                apictl get policies api --environment production --limit 15 
                ```    
                ```bash
                apictl get policies api --environment production
                ```  
                ```go
                apictl get policies api --environment production --all 
                ```  

        -   **Response**

            ```go
            ID                                     NAME                       Display NAME               CATEGORY            APPLICABLE FLOWS     SUPPORTED GATEWAYS
            e758ccd3-39ec-430c-8722-a44253a53ecd   ccCallInterceptorService   Call Interceptor Service   Mediation           [request response]   [ChoreoConnect]
            55e8e47f-35ee-46b3-b097-5f347079c7c4   setToHeader                Set To Header              Mediation           [request]            [Synapse]
            ```
            
            !!! tip 
                When using the `apictl get policies api -e dev` command, `--all` optional flag can be used to 
                get all available Common API Policies.

            !!!note
                Output of the `get policies api` command can be formatted with Go Templates. For more information on formatting the get commands, see [Formatting the outputs of get commands]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/formatting-the-output-of-get-command).
               

## Delete a Common API Policy in an environment

Follow the instructions below to delete a Common API Policy in an environment using apictl:

1.  Make sure that the WSO2 API-M 4.1.0 version is started and that the 4.1.0 version of apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to delete a Common API Policy in an environment.

    1. Delete a Common API Policy in an environment.

        -   **Command**
            ``` bash
            apictl delete policy api -n <Common API Policy name> -e <environment>
            ```
            ``` bash
            apictl delete policy api --name <API name> --environment <environment> 
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment from which the Common API Policy should be deleted  
                    `--name` or `-n` : Name of the Common API Policy to be deleted  

            !!!note
                In api controller v4.2.0, --version flag support is not provided. Instead, internally it considers the default version which is `v1` when finding the policy.

            !!! example
                ```bash
                apictl delete policy api -n addHeader -e dev
                ```
                ```bash
                apictl delete policy api --name addHeader --environment production 
                ```    
                ```go
                apictl delete policy api --name addHeader --environment production
                ```  

        -   **Response**

            ```go
            testHeader Common API Policy deleted successfully!
            ```