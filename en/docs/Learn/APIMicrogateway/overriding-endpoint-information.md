# Overriding Endpoint Information

The backend URLs and credentials for endpoints can be provided for each Gateway node as system properties. Following are the supported functionalities:

-   [Override endpoints](#OverridingEndpointInformation-Overrideendpoints)
-   [Define backend basic auth credentials](#OverridingEndpointInformation-Definebackendbasicauthcredentials)

#### Override endpoints

To override the production endpoint of an API (e.g., `         TestAPI v1        ` ), provide the following system variable at server startup,

``` java
    bash gateway -e TestAPI.v1.prod.endpoint.0="http://wso2.com"
```

For the sandbox endpoint, provide the following system variable at server startup,

``` java
    bash gateway -e TestAPI.v1.sand.endpoint.0="http://wso2.com"
```

If there is more than one endpoint (e.g. load balance endpoint), use the following method to define each endpoint:

``` java
    bash gateway -e TestAPI.v1.prod.endpoint.0="http://wso2.com" -e TestAPI.v1.prod.endpoint.1="http://support.wso2.com"
```

To set the endpoint using system properties, use the following method (replace **.** with **\_** in a Linux environment):

``` java
    export TestAPI_v1_prod_endpoint_0="http://wso2.com"
```

#### Define backend basic auth credentials

If the backend endpoint is protected with basic auth, provide credentials related to that endpoint. Use the following system variables to define them:

``` java
    bash gateway -e TestAPI.v1.prod.basic.username="admin" -e TestAPI.v1.basic.password="admin"
```

If a username is not defined, the username defined in the API (during API implementation) is used. To set the credentials using system properties, use the following method (replace . with \_ in a Linux environment):

``` java
    export TestAPI_v1_prod_basic_username="admin"
    export TestAPI_v1_prod_basic_password="admin"
```
