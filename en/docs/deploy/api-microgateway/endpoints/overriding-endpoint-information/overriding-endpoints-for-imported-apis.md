# Overriding Endpoints for Imported APIs

!!! note
    This information is only applicable for APIs imported from WSO2 API Manager.

The API imported from the API Manager once deployed in Microgateway, it needs to be moved across different environments. When moving from one environment
to the other backend service details can alter. In those cases, we need to override the endpoint details of the API
The following section describes how this can be overriden on the APIs that are imported from the WSO2 API Manager.

## Overriding endpoints at runtime

Use the following command to override the endpoints of an API imported from the WSO2 API Manager at server start-up.

Follow the instructions below to override the production or sandbox endpoint(s).

1.  Use the following command to start WSO2 Microgateway. Here the system variables are provided at server start-up to override the endpoint of the API, which has been added to WSO2 API Microgateway using an OpenAPI definition.

    ``` text tab="Override endpoints - binary"
    gateway <path-to-MGW-jar> 
        --<API-ID>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint-URL-1>" 
        --<API-ID>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL_2>"
    ```
    
    ``` text tab="Override endpoints - docker"
    docker run -d -p 9090:9090 -p 9095:9095 -e <API-ID>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL-1>" -e <API-ID>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL-2>" <docker_image_name>
    ```
    
    - `<API-ID>` - ID generated for the imported API. You can find it by checking the file name of imported API located in `<PROJECT_HOME>/gen/api_definitions/`. Sample file name would be `api_30e623704c5c5479b7c0d9ab78e965df02c1610401e37cbd557e6353e3191c76swagger.json`. Here the 
    `<API-ID>` is `api_30e623704c5c5479b7c0d9ab78e965df02c1610401e37cbd557e6353e3191c76`
    - `<endpoint-type>` - Use one of the following values based on the type of endpoint.
        - `prod` - Use this for a production endpoint.
        - `sand` - Use this for a sandbox endpoint.
    - `<endpoint-index>` - The endpoint index starts from 0. Therefore, when overriding a single endpoint this value is 0. If there are many URLs (e.g., load-balanced or failover), you can override them using endpoint indexes (e.g., 1, 2, 3).
    - `<path-to-MGW-jar>` - Enter the path to the WSO2 API Microgateway project's jar file ( `.jar` ).
    - `<docker_image_name>` - The Microgateway image built by burning the imported API. This parameter is required only running an container

 
    
    ``` text tab="Example - binary"
    gateway /home/user/petstore-project/target/petstore-project.jar 
    --api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_endpoint_0="http://wso2.com" 
    --api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_endpoint_1="http://support.wso2.com"
    ```
    
    ``` text tab="Example - docker"
    docker run -d -p 9090:9090 -p 9095:9095 -e api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_endpoint_0="http://wso2.com" -e api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_endpoint_1="http://wso2.support.com" docker.wso2.com/petstore:v1
    ```
        

2. If the backend is protected by basic authentication, provide username and password as follows.
    
    ``` text tab="Override endpoint security - Format"
    gateway <path-to-MGW-jar> 
    --<API-ID>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint-URL-1>" 
    --<API-ID>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL_2>" 
    --<API-ID>_<endpoint-type>_basic_username="<basic-auth-username>" 
    --<API-ID>_basic_password="<basic-auth-password>
    ```
   
    - `<basic-auth-username>` - Provide the username                            
    - `<basic-auth-password>` - Provide the password                               
   
    
    ``` text tab="Override endpoint security - Example"
    gateway /home/user/petstore-project/target/petstore-project.jar 
    --api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_endpoint_0="http://wso2.com" 
    --api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_endpoint_1="http://support.wso2.com"
    --api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_basic_username="admin" 
    --api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_basic_password="admin"
    ```
    
    !!! Note
        When Running docker images security credentials can be passed to docker container as environment variables using `-e` parameter in the `docker run` command
 
    !!! Note
        If you do not specify a username, the username defined in the API definition during the API implementation will be used.

## Overriding endpoints using environment variables

Use the following command to provide the system variables as system properties to override more than one endpoint (e.g., load balance endpoint) that corresponds to an API, which was imported from WSO2 API Manager.

Follow the instructions below to override the production or sandbox endpoint(s).

1. Set the endpoint using environment variables. 

    ``` java tab="Format"
    export <API-ID>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint-URL>" 
    export <API-ID>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint-URL-2>"
    ```
    
    - `<API-ID>` - ID generated for the imported API. You can find it by checking the file name of imported API located in `<project>/gen/api_definitions/`
    - `<endpoint-type>` - Use one of the following values based on the type of endpoint.
       - `prod` - Use this for a production endpoint.
       - `sand` - Use this for a sandbox endpoint.
    - `<endpoint-index>` - The endpoint index starts from 0. Therefore, when overriding a single endpoint this value is 0. If there are many URLs (e.g., load-balanced or failover), you can override them using endpoint indexes (e.g., 1, 2, 3).
    - `<path-to-MGW-jar>` - Enter the path to the WSO2 API Microgateway project's jar file ( `.jar` ).
    
    ``` java tab="Example"
    export api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_endpoint_0="http://wso2.com" 
    export api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_endpoint_1="http://support.wso2.com"
    ```

2. Optionally, define the Basic Auth credentials using environment variables.

    !!! note
        This step is only applicable if your endpoint is protected by **Basic Auth credentials**.
    
    ``` java tab="Format"
    export <API-ID>_<endpoint-type>_basic_username="<basic-auth-username>"
    export <API-ID>_<endpoint-type>_basic_password="<basic-auth-password>"
    ```
    
    - `<basic-auth-username>` - Provide the username                            
    - `<basic-auth-password>` - Provide the password 
    
    ``` java tab="Example"
    export api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_basic_username="admin"
    export api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_basic_password="admin"
    ```
