#  Configuring Different Endpoint Types

When there are multiple environments, to allow easily configuring environment-specific details, **WSO2 API Controller (apictl)** supports an additional parameter file. (Please refer [Configuring Environment Specific Parameters]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters) for more information). You can specify different types of endpoints in this file, as discussed in this section.

API Manager supports four (4) main types of endpoints as follows.

1. HTTP/REST Endpoints
2. HTTP/SOAP Endpoints
3. Dynamic Endpoints
4. AWS Lambda Endpoints

!!! info
    The following fields should be specified as your requirement when setting up different endpoints in the params file.
    
    -   **endpointType**
        
        To specify the type of the endpoint. Values can be `rest`, `soap`, `dynamic` or `aws`. (For HTTP/REST Endpoints, you can specify the type as `rest`. But even if you do not specify the field `endpointType` at all in the params file, by default it takes the type as `rest`)
    
    -   **endpointRoutingPolicy**
    
        To specify the routing policy to be used. Values can be `load_balanced` or `failover`.
    
    -   **loadBalanceEndpoints** field should be specified if the `endpointRoutingPolicy` is `load_balanced`. This field contains the following.

        - `production`: An array which consists the multiple production endpoints
        - `sandbox`: An array which consists the multiple sandbox endpoints
        - `sessionManagement` (Optional): Values can be `none`, `transport`, `soap`, `simpleClientSession` and if not specified the default value is `transport`
        - `sessionTimeOut` (Optional): The number of milliseconds after which the session would time out

    -   **failoverEndpoints** field should be specified if the `endpointRoutingPolicy` is `failover`. This field contains the following.

        - `production`: The primary production endpoint (not an array)
        - `sandbox`: The primary sandbox endpoint (not an array)
        - `productionFailovers`: An array which consists failover production endpoints
        - `sandboxFailovers`: An array which consists failover sandbox endpoints

    -   **awsLambdaEndpoints** field should be specified if the `endpointType` is `aws`. This field contains the following.

        - `accessMethod`: The access method of awslambda endpoint. Mandatory to specify. (Values can be `role_supplied` or `stored`)
        - `amznRegion`: Region where the endpoint is located. Can be chosen from [here](https://docs.aws.amazon.com/general/latest/gr/rande.html#regional-endpoints)
        - `amznAccessKey`: Access Key for endpoint
        - `amznSecretKey`: Access Secret for endpoint

Let us discuss configuring each of the above endpoint types with separate examples in the following sections.

### HTTP/REST Endpoints

This can be subdivided into three (3) main scenarios.

#### 1. HTTP/REST Endpoint - Without load balancing or failover

The following is an example params file for this scenario. (Note that you can ignore specifying the `endpointType` field if you want, because by default it contains the value as `rest`.)

!!! example
    ```go   
    environments:
      - name: test
        configs:
            endpoints:
                production:
                sandbox:
      - name: dev
        configs: 
            endpointType: rest
            endpoints:
                production:
                    url: https://dev.wso2.com
                sandbox:
                    url: https://dev.sandbox.wso2.com
    ```

#### 2. HTTP/REST Endpoint - With load balancing

The following is an example params file for this scenario. (Note that, as mentioned in the above section, you can ignore specifying the `endpointType` field if you want, because by default it contains the value as `rest`.)

!!! example
    ```go   
    environments:
      - name: test
        configs:
            endpoints:
                production:
                sandbox:
      - name: dev
        configs:
            endpointType: rest
            endpointRoutingPolicy: load_balanced
            loadBalanceEndpoints:
                production:
                    - url: https://dev1.wso2.com
                    - url: https://dev2.wso2.com
                sandbox:
                    - url: https://dev1.sandbox.wso2.com
                    - url: https://dev2.sandbox.wso2.com
                sessionManagement: transport
                sessionTimeOut: 5000
    ```

#### 3. HTTP/REST Endpoint - With failover

The following is an example params file for this scenario. (Note that, as mentioned in the above sections, you can ignore specifying the `endpointType` field if you want, because by default it contains the value as `rest`.)

!!! example
    ```go   
    environments:
      - name: test
        configs:
            endpoints:
                production:
                sandbox:
      - name: dev
        configs:
            endpointType: rest
            endpointRoutingPolicy: failover
            failoverEndpoints:
                production:
                    url: https://dev.wso2.com
                productionFailovers:
                    - url: https://dev1.wso2.com
                    - url: https://dev2.wso2.com
                sandbox:
                    url: https://dev.sandbox.wso2.com
                sandboxFailovers:
                    - url: https://dev1.sandbox.wso2.com
                    - url: https://dev2.sandbox.wso2.com
    ```

### HTTP/SOAP Endpoints

This too can be subdivided into three (3) main scenarios like in the previous section.

#### 1. HTTP/SOAP Endpoint - Without load balancing or failover

The following is an example params file for this scenario. (Make sure to specify the `endpointType` as `soap`)

!!! example
    ```go   
    environments:
      - name: test
        configs:
            endpoints:
                production:
                sandbox:
      - name: dev
        configs:
            endpointType: soap
            endpoints:
                production:
                    url: https://dev.wso2.com
                sandbox:
                    url: https://dev.sandbox.wso2.com
    ```

#### 2. HTTP/SOAP Endpoint - With load balancing

The following is an example params file for this scenario. (Make sure to specify the `endpointType` as `soap`)

!!! example
    ```go   
    environments:
      - name: test
        configs:
            endpoints:
                production:
                sandbox:
      - name: dev
        configs:
            endpointType: soap
            endpointRoutingPolicy: load_balanced
            loadBalanceEndpoints:
                production:
                    - url: https://dev1.wso2.com
                    - url: https://dev2.wso2.com
                sandbox:
                    - url: https://dev1.sandbox.wso2.com
                    - url: https://dev2.sandbox.wso2.com
                sessionManagement: soap
                sessionTimeOut: 5000
    ```

#### 3. HTTP/SOAP Endpoint - With failover

The following is an example params file for this scenario. (Make sure to specify the `endpointType` as `soap`)

!!! example
    ```go   
    environments:
      - name: test
        configs:
            endpoints:
                production:
                sandbox:
      - name: dev
        configs:
            endpointType: soap
            endpointRoutingPolicy: failover
            failoverEndpoints:
                production:
                    url: https://dev.wso2.com
                productionFailovers:
                    - url: https://dev1.wso2.com
                    - url: https://dev2.wso2.com
                sandbox:
                    url: https://dev.sandbox.wso2.com
                sandboxFailovers:
                    - url: https://dev1.sandbox.wso2.com
                    - url: https://dev2.sandbox.wso2.com
    ```

### Dynamic Endpoints

The following is an example params file for this scenario. (Make sure to specify the `endpointType` as `dynamic`)

!!! example
    ```go   
    environments:
        - name: test
          configs:
            endpoints:
                production:
                sandbox:
        - name: development
          configs:
            endpointType: dynamic
    ```

!!! tip
    When importing an API, if you are specifying the endpoint type as `dynamic`, you can include a message mediation policy with a `To` header inside the `Sequences` directory of your API Project. (Refer [Adding Dynamic Endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/message-mediation/adding-dynamic-endpoints/#adding-dynamic-endpoints) to learn more about Dynamic endpoints and message mediations associated with that.)

### AWS Lambda Endpoints

This can be subdivided into two (2) main scenarios.

#### 1. AWS Lambda - Using IAM role-supplied temporary AWS credentials

The following is an example params file for this scenario. (Make sure to specify the `endpointType` as `aws`)

!!! example
    ```go   
    environments:
      - name: test
        configs:
            endpoints:
                production:
                sandbox:
      - name: development
        configs:
            endpointType: aws
            awsLambdaEndpoints:
                accessMethod: role_supplied
    ```

#### 2. AWS Lambda - Using stored AWS credentials

The following is an example params file for this scenario. (Make sure to specify the `endpointType` as `aws`)

!!! example
    ```go   
    environments:
      - name: test
        configs:
            endpoints:
                production:
                sandbox:
      - name: development
        configs:
            endpointType: aws
            awsLambdaEndpoints:
                accessMethod: stored
                amznRegion: us-west-1
                amznAccessKey: jdej3kj34jk3l353k553535b353
                amznSecretKey: 453653nk46j43kewrkj35j2kk32
    ```
