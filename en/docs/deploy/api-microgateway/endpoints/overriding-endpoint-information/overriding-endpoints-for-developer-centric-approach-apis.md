# Overriding Endpoints for Developer-first Approach APIs

The following sections describe how you can override endpoint information for APIs that have been added to WSO2 API Microgateway using an OpenAPI definition.
Since the Microgateways are immutable, the image or the binary output(.jar) from toolkit can be used in multiple environments like dev, test and prod by overriding endpoint details like urls, credentials.
This allows to use the same tested container or the binary of Microgateway in multiple environments without having to rebuild the Microgateway for each environment.

You need to define endpoints as endpoint objects in the OpenAPI definition in order to override endpoints at runtime. See [defining endpoint object]({{base_path}}/deploy/api-microgateway/endpoints/defining-endpoints-in-an-openapi-definition/#endpoint-object).


## Overriding endpoints at runtime

Use the following command to start WSO2 Microgateway. Here the system variables are provided at server start-up to override the endpoint of the API, which has been added to WSO2 API Microgateway using an OpenAPI definition.

``` tab="Format - binary" 
gateway <path-to-MGW-executable-file> --<endpoint-name>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL_1>" --<endpoint-name>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL_2>"

- <path-to-MGW-executable-file> - Enter the path to the WSO2 API Microgateway project's executable file ( `.jar` ).
- <endpoint-name> - Name specified in the OpenAPI definition under the `x-wso2-endpoints` OpenAPI extension.
- <endpoint-type> -  Use one of the following values based on the type of the endpoint.
    - prod - Use this for a production endpoint.
    - sand - Use this for a sandbox endpoint.
- <endpoint-index>- The endpoint index starts from 0. Therefore, when overriding a single endpoint this value is 0.
```

```  tab="Example - binary"
gateway /home/user/petstore-project/target/petstore-project.jar --myEndpoint_prod_endpoint_0="http://wso2.com"   
```

``` tab="Format - docker"
docker run -d -p 9090:9090 -p 9095:9095 -e <endpoint-name>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL-1>" -e <endpoint-name>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL-2>" <docker_image_name>
```

``` tab="Example - docker" 
docker run -d -p 9090:9090 -p 9095:9095 -e myEndpoint_prod_endpoint_0="http://wso2.com" docker.wso2.com/petstore:v1
```

## Overriding endpoints at runtime which is protected by basic authentication

Use the following command to start WSO2 Microgateway. Here the endpoint details are provided at server start-up as command line arguments to override the endpoint of the API, which has been added to WSO2 API Microgateway using an OpenAPI definition.

``` tab="Format -binary"
gateway <path-to-MGW-executable-file> --<endpoint-name>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL>" --<endpoint-name>_<endpoint-type>_basic_password=<password> 

- <path-to-MGW-executable-file> - Enter the path to the WSO2 API Microgateway project's executable file ( `.jar` ).
- <endpoint-name> - Name specified in the OpenAPI definition under the `x-wso2-endpoints` OpenAPI extension.
- <endpoint-type> -  Use one of the following values based on the type of the endpoint.
    - prod - Use this for a production endpoint.
    - sand - Use this for a sandbox endpoint.
- <endpoint-index>- The endpoint index starts from 0. Therefore, when overriding a single endpoint this value is 0.
- Basic Auth parameters

note:
    The following parameters are only required if your endpoint is **protected by Basic Auth credentials** 
    
   `<endpoint-name>_<endpoint-type>_basic_password=<password>`
```

``` tab="Example - binary"
gateway /home/user/petstore-project/target/petstore-project.jar --myEndpoint_prod_endpoint_0="http://wso2.com" --myEndpoint_prod_basic_password=123456 
```

``` tab="Format - docker"
docker run -d -p 9090:9090 -p 9095:9095 -e <endpoint-name>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint_URL>" -e <endpoint-name>_<endpoint-type>_basic_password=<password> docker.wso2.com/petstore:v1
```

``` java tab="Example - docker"
docker run -d -p 9090:9090 -p 9095:9095 -e myEndpoint_prod_endpoint_0="http://wso2.com" -e myEndpoint_prod_basic_password=123456 docker.wso2.com/petstore:v1
```

## Overriding endpoints using environment variables

Use the following command to provide the system variables as system properties to override more than one endpoint (e.g., load balance endpoint) that corresponds to an API, which was imported from WSO2 API Manager.

Follow the instructions below to override the production or sandbox endpoint(s).

1. Set the endpoint using environment variables. 

    ``` java tab="Format"
    export <endpoint-name>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint-URL>" <endpoint-name>_<endpoint-type>_endpoint_<endpoint-index>="<endpoint-URL-2>"
    ```
    
    - `<endpoint-name>` - Name specified in the OpenAPI definition under the `x-wso2-endpoints` OpenAPI extension.
    - `<endpoint-type>` - Use one of the following values based on the type of endpoint.
       - `prod` - Use this for a production endpoint.
       - `sand` - Use this for a sandbox endpoint.
    - `<endpoint-index>` - The endpoint index starts from 0. Therefore, when overriding a single endpoint this value is 0. If there are many URLs (e.g., load-balanced or failover), you can override them using endpoint indexes (e.g., 1, 2, 3).
    
    ``` java tab="Example"
    export myEndpoint_prod_endpoint_0="http://wso2.com" 
    export myEndpoint_prod_endpoint_1="http://support.wso2.com"
    ```

2. Optionally, define the Basic Auth credentials using environment variables.

    !!! note
        This step is only applicable if your endpoint is protected by **Basic Auth credentials**.
    
    ``` java tab="Format"
    export <endpoint-name>_<endpoint-type>_basic_username="<basic-auth-username>"
    export <endpoint-name>_<endpoint-type>_basic_password="<basic-auth-password>"
    ```
    
    - `<basic-auth-username>` - Provide the username                            
    - `<basic-auth-password>` - Provide the password 
    
    ``` java tab="Example"
    export myEndpoint_prod_basic_username="admin"
    export myEndpoint_prod_basic_password="admin"
    ```