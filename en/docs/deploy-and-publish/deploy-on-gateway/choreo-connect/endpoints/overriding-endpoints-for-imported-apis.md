# Overriding Endpoints for deployed APIs

The API deployed from the API Manager once deployed in Choreo Connect, it needs to be moved across different environments. When moving from one environment to the other backend service details can be altered. In those cases, we need to override the endpoint details of the API
The following section describes how this can be overridden on the APIs that are imported from the WSO2 API Manager.

## Overriding endpoints using environment variables 

You can define endpoint details as the Adapter environment variables at docker-composer.yaml file.

1. Set the production or sandbox endpoint(s) of an API.

    === "Format"
        ``` java  
        <API-ID>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint-URL>" 
        ```

    === "Example"
        ``` java
        services:
            adapter:
                environment:
                - api_cc429c240db698dd2522038f8f85602bfcd33ed3_prod_endpoint_0="http://wso2.prod.com"
                - api_cc429c240db698dd2522038f8f85602bfcd33ed3_sand_endpoint_0="http://wso2.sand.com"
        ```
    
    - `<API-ID>` - `api_SHA1(<apiName>:<apiVersion>)` ID generated for the imported API. For the above examples, sample API-ID would be `api_cc429c240db698dd2522038f8f85602bfcd33ed3`. The ID hash can be generated as follows.

        === "Format"
            ``` java
            echo -n "<apiName>:<apiVersion>" | openssl sha1
            ```

        === "Example"
            ``` java
            echo -n "Petstore:1.0.0" | openssl sha1
            ```

    - `<endpoint-type>` - Use one of the following values based on the type of endpoint.
        - `prod` - Use this for a production endpoint.
        - `sand` - Use this for a sandbox endpoint.
    - `<endpoint-index>` - The endpoint index starts from 0. Therefore, when overriding a single endpoint this value is 0. If there are many URLs (e.g., load-balanced or failover), you can override them using endpoint indexes (e.g., 1, 2, 3).


        
2. If the backend is protected by basic authentication, provide username and password as follows.
    
    === "Format"
        ``` java
        <API-ID>_<endpoint-type>_basic_username="<basic-auth-username>"
        <API-ID>_<endpoint-type>_basic_password="<basic-auth-password>"
        ```

    === "Example"
        ``` java
        services:
            adapter:
                environment:
                - api_cc429c240db698dd2522038f8f85602bfcd33ed3_prod_basic_username="admin"
                - api_cc429c240db698dd2522038f8f85602bfcd33ed3_prod_basic_password="admin"
        ```
    
    - `<basic-auth-username>` - Provide the username                            
    - `<basic-auth-password>` - Provide the password
  