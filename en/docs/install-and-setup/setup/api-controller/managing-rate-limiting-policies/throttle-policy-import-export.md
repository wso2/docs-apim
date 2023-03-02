# Managing Rate Limiting Policies

WSO2 API Controller (apictl) allows the following actions on rate limiting Policies.

1. Get rate limiting policies in an environment.
2. Delete rate limiting policies from an environment.
3. Export rate limiting policies from an environment.
4. Import rate limiting policies to an environment.

## Get rate limiting policies in an environment

Get rate limiting policies operation allows users to list the available rate limiting policies. It also allows the user to filter the rate limiting policies by rate limiting policy levels like Application, Subscription, Advanced, and Custom.

Follow the instructions below to display a list of rate limiting API Policies in an environment using apictl:

1.  Make sure that the WSO2 API Manager (WSO2 API-M) is started and that the relevant version of apictl is set up.   
     For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get (list) rate limiting Policies in an environment.

    - **Command**
        ```bash
        apictl get policies rate-limiting -e <environment-name> -q  <query>
        ```

        ``` bash
        apictl get policies rate-limiting --environment <environment> -q <query>
        ```

        ``` bash
        apictl get policies rate-limiting --environment <environment> -q <query> --all 
        ```

        !!! Info
            **Flags**
            `-q, --query` - This allows the user to filter out rate limiting policies by type
            `-e, --environment string` - Environment to be searched
            `--format string` - Pretty-print rate limiting policies using Go Templates. Use `{% raw %}"{{ jsonPretty . }}"{% endraw %}` to list all fields
            `-h, --help` - Help for rate-limiting

        !!! example
            ```bash
            apictl get policies  rate-limiting  -e prod  -q type:sub
            ```

## Delete a rate limiting policies from an environment

Follow the instructions below to delete a rate limiting policy in an environment using apictl:

1.  Make sure that the WSO2 API-M is started and that the corresponding version of apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to delete a common API Policy in an environment.

    -   **Command**
        ``` bash
        apictl delete policy rate-limiting -n <rate limiting policy name> -v <rate limiting policy version> -e <environment>
        ```
        ``` bash
        apictl delete policy rate-limiting --name <rate limiting name> --version <rate limiting policy version> --environment <environment> 
        ```

        !!! info
            **Flags:**  
                
            -   Required :  
                `-e, --environment string` - Environment from which the Throttling Policy should be deleted
                `-h, --help` - Help for rate-limiting
                `-n, --name string` - Name of the Throttling Policy to be deleted
                `-t, --type string` - Type of the Throttling Policies to be exported (sub,app,custom,advanced)  

            !!! example
                ```bash
                apictl delete policy rate-limiting -n Gold -e dev --type sub 
                ```
                
                ```bash
                apictl delete policy rate-limiting -n AppPolicy -e prod --type app
                ```

                ```bash
                apictl delete policy rate-limiting -n TestPolicy -e dev --type advanced 
                ```
                
                ```bash
                apictl delete policy rate-limiting -n CustomPolicy -e prod --type custom 
                ```

            !!! Note 
                All the 2 flags (--name (-n) and --environment (-e)) are mandatory.


## Export/Import rate limiting policies

For more details on exporting and importing rate limiting policies, see the document on [migrating rate limiting policies]({{base_path}}/install-and-setup/setup/api-controller/managing-rate-limiting-policies/migrating-rate-limiting-policies-to-different-environments/).




