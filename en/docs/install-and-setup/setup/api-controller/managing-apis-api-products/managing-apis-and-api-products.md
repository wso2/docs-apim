# Managing APIs and API Products

## Add APIs/API Products in an environment

You can add APIs and API Products via the Publisher Portal and Developer Portal.
However, **apictl** allows you to create and deploy APIs without using the Publisher Portal. For more information on adding APIs, see [Importing APIs Via Dev First Approach]({{base_path}}/learn/api-controller/importing-apis-via-dev-first-approach).

## Get APIs/API Products in an environment

Follow the instructions below to display a list of APIs/API Products/Applications in an environment using CTL:

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APICTL is setup.   
     For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).

2.  Log in to the API Manager in the environment by following the instructions in [Login to an Environment](#login-to-an-environment).
3.  Run the corresponding CTL command below to get (list) APIs/API Products/Applications in an environment.

    1. Get APIs in an environment.

        -   **Command**
            ``` bash
            apictl get apis -e <environment> -k
            ```
            ``` bash
            apictl get apis --environment <environment> --insecure
            ```
            ``` bash
            apictl get apis --environment <environment> --query <API search query> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment to be searched  
                -   Optional :  
                    `--query` or `-q` : Search query pattern  
                    `--limit` or `-l` : Maximum number of APIs to return (Default 25)
                    `--format` : pretty-print environments using templates

            !!! example
                ```bash
                apictl get apis -e dev -k
                ```
                ```bash
                apictl get apis --environment production --limit 15 --insecure
                ```    
                ```go
                apictl get apis --environment production --query provider:Alice name:PizzaShackAPI --insecure
                ```  

        -   **Response**

            ```go
            ID                                     NAME                VERSION             CONTEXT             STATUS              PROVIDER
            12d6e73c-778d-45ac-b57d-117c6c5092a4   PhoneVerification   1.0                 /phoneverify        PUBLISHED           admin
            91fe87c3-f0d7-4c35-81f5-0e0e42d8e19f   PizzaShackAPI       2.0.0               /pizzashack         CREATED             Alice
            ```
            
            !!! tip 
                When using the `apictl get apis -e dev` command, `-q` or `--query` optional flag can be used to 
                search for APIs.
                You can search in attributes by using a `:` modifier. Supported attribute modifiers are **name**, 
                **version**, **provider**, **context**, **status**, **description**, **subcontext**, **doc** and 
                **label**.  You can also use combined modifiers.  
                **Example:**
                   
                -  `provider:wso2` will match an API if the provider of the API contains `wso2`.
                -  `'provider:"wso2"'` will match an API if the provider of the API is exactly `wso2`.
                -  `status:PUBLISHED` will match an API if the API is in PUBLISHED state.
                -  `label:external` will match an API if it contains a Microgateway label called "external".
                -  `name:pizzashack version:v1` will match an API if the name of the API is pizzashack and version is v1.
                
                If no advanced attribute modifier has been specified, the API names containing the search term will 
                be returned as a result.

            !!!note
                `apictl list apis` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl get apis` as shown above. 

    2. Get API Products in an environment.
    
        -   **Command**
            ``` bash
            apictl get api-products -e <environment> -k
            ```
            ``` bash
            apictl get api-products --environment <environment> --insecure
            ```
            ``` bash
            apictl get api-products --environment <environment> --query <API search query> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment to be searched  
                -   Optional :  
                    `--query` or `-q` : Search query pattern  
                    `--limit` or `-l` : Maximum number of API Products to return

            !!! example
                ```bash
                apictl get api-products -e dev -k
                ```
                ```bash
                apictl get api-products --environment production --insecure
                ```    
                ```go
                apictl get api-products --environment production --query provider:Alice name:PizzaShackAPI --limit 25 --insecure
                ```  

        -   **Response**

            ```go
            ID                                     NAME                CONTEXT              STATUS              PROVIDER
            b39e08d7-caa9-40d0-a430-b8e840dd7c31   LeasingAPIProduct   /leasingapiproduct   PUBLISHED           admin
            ab422af2-b19e-4e6a-a34b-8f45c50db0d5   CreditAPIProduct    /creditapiproduct    PUBLISHED           Alice
            ```

            !!!note
                `apictl list api-products` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl get api-products` as shown above.

## Delete an API or API Product in an environment
Follow the instructions below to delete an API/API Product/Application in an environment using CTL:

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APICTL is setup.   
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Log in to the API Manager in the environment by following the instructions in [Login to an Environment](#login-to-an-environment).
3.  Run the corresponding CTL command below to delete an API/API Product/Application in an environment.

    1. Delete an API in an environment.

        -   **Command**
            ``` bash
            apictl delete api -n <API name> -v <API version> -e <environment> -k
            ```
            ``` bash
            apictl delete api --name <API name> --version <API version> --environment <environment> --insecure
            ```
            ``` bash
            apictl delete api --name <API name> --version <API version> --environment <environment> --provider <API provider> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment from which the API should be deleted  
                    `--name` or `-n` : Name of the API to be deleted  
                    `--version` or `-v` : Version of the API to be deleted  
                -   Optional :  
                    `--provider` or `-r` : Provider of the API to be deleted  

            !!! example
                ```bash
                apictl delete api -n PizzaShackAPI -v 1.0.0 -e dev -k
                ```
                ```bash
                apictl delete api --name PizzaShackAPI --version 1.0.0 --environment production --insecure
                ```    
                ```go
                apictl delete api --name PizzaShackAPI --version 1.0.0 --environment production --provider Alice --insecure
                ```  

        -   **Response**

            ```go
            PizzaShackAPI API deleted successfully!
            ```

    2. Delete an API Product in an environment.

        -   **Command**
            ``` bash
            apictl delete api-product -n <API Product name> -e <environment> -k
            ```
            ``` bash
            apictl delete api-product --name <API Product name> --environment <environment> --insecure
            ```
            ``` bash
            apictl delete api-product --name <API Product name> --environment <environment> --provider <API Product provider> --insecure
            ```

            !!! info
                **Flags:**  
                
                -   Required :  
                    `--environment` or `-e` : Environment from which the API Product should be deleted  
                    `--name` or `-n` : Name of the API Product to be deleted   
                -   Optional :  
                    `--provider` or `-r` : Provider of the API Product to be deleted  

            !!! example
                ```bash
                apictl delete api-product -n LeasingAPIProduct -e dev -k
                ```
                ```bash
                apictl delete api-product --name LeasingAPIProduct -environment production --insecure
                ```    
                ```go
                apictl delete api-product --name LeasingAPIProduct --environment production --provider Alice --insecure
                ```  

        -   **Response**

            ```go
            LeasingAPIProduct API Product deleted successfully!
            ```
    
## Change status of an API in an environment
Follow the instructions below to change the status of an API in an environment using CTL:

1.  Make sure that the WSO2 API Manager 4.0.0 version is started and that the 4.0.0 version of APTCTL is running.   
For more information, see [Download and Initialize the CTL Tool](#download-and-initialize-the-ctl-tool).
2.  Log in to the API Manager in the environment by following the instructions in [Login to an Environment](#login-to-an-environment).
3.  Run the corresponding CTL command below to change the status of an API in an environment.

    -   **Command**
        ``` bash
        apictl change-status api -a <Action> -n <API name> -v <API version> -e <environment> -k
        ```
        ``` bash
        apictl change-status api --action <Action> --name <API name> --version <API version> --environment <environment> --insecure
        ```
        ``` bash
        apictl change-status api --action <Action> --name <API name> --version <API version> --environment <environment> --provider <API provider> --insecure
        ```

        !!! info
            **Flags:**  
            
            -   Required :  
                `--environment` or `-e` : The environment that the command is executed on  
                `--name` or `-n` : The name of the respective API
                `--version` or `-v` : The version of the respective API
                `--action` or `-a` : The action to be taken to change the status of the API
            -   Optional :  
                `--provider` or `-r` : The provider of the respective API  

        !!! example
            ```bash
            apictl change-status api -a Publish -n PizzaShackAPI -v 1.0.0 -e dev -k
            ```
            ```bash
            apictl change-status api --action Publish --name PizzaShackAPI --version 1.0.0 --environment production --insecure
            ```    
            ```go
            apictl change-status api --action Publish --name PizzaShackAPI --version 1.0.0 --environment production --provider Alice --insecure
            ```  

    -   **Response**

        ```go
        PizzaShackAPI API state changed successfully!
        ```

    !!! Info
        Supported action values : Publish, Deploy as a Prototype, Demote to Created, Demote to Prototyped, Block, Deprecate, Re-Publish, Retire.
        Note that the Re-publish action is available only after calling Block action.
