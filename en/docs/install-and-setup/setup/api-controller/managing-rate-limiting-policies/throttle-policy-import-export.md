# Managing Rate Limiting Policies

WSO2 API Controller (apictl) allows the following actions on rate limiting Policies.

1. Get rate limiting policies
2. Delete rate limiting policies
2. Export rate limiting policy
3. Import rate limiting policy

## Get rate limiting policies

Get rate limiting policies operation allows users to list the available rate limiting policies. It also allows the user to filter the rate limiting policies by rate limiting policy levels like Application, Subscription, Advanced, and Custom.

Follow the instructions below to display a list of rate limiting API Policies in an environment using apictl:

1.  Make sure that the WSO2 API Manager (WSO2 API-M) is started and that the relevant version of apictl is set up.   
     For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get (list) rate limiting Policies in an environment.

    - **Command**
        ```bash
        apictl get policies rate-limiting -e <environment-name>  <query>
        ```

        ``` bash
        apictl get policies rate-limiting --environment <environment> <query>
        ```

        ``` bash
        apictl get policies rate-limiting --environment <environment> <query> --all 
        ```

        !!! Info
            **Flags**
            `-q (query)` - This only allows the user to filter out rate limiting policies by type

        !!! example
            ```bash
            apictl get policies  rate-limiting  -e prod  -q type:sub
            ```

## Delete a rate limiting policy in an environment

Follow the instructions below to delete a rate limiting policy in an environment using apictl:

1.  Make sure that the WSO2 API-M is started and that the corresponding version of apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to delete a common API Policy in an environment.

    -   **Command**
        ``` bash
        apictl delete policy rate-limiting -n <common API Policy name> -v <common API Policy version> -e <environment>
        ```
        ``` bash
        apictl delete policy rate-limiting --name <common API Policy name> --version <common API Policy version> --environment <environment> 
        ```

        !!! info
            **Flags:**  
                
            -   Required :  
                `--environment` or `-e` : Environment from which the common API Policy should be deleted  
                `--name` or `-n` : Name of the rate limiting policy to be deleted  
                `--version` or `-v` : Version of the common API Policy to be deleted  

            !!! example
                ```bash
                apictl delete policy api -n addHeader -v v1 -e dev
                ```
                ```bash
                apictl delete policy api --name addHeader --version v1 --environment production 
                ```


## Export/Import rate limiting policies

For more details on exporting and importing rate limiting policies, see the document on [migrating rate limiting policies]({{base_path}}/install-and-setup/setup/api-controller/managing-rate-limiting-policies/migrating-rate-limiting-policies-to-different-environments/).




