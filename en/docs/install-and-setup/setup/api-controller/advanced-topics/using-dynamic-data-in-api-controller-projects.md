#  Using Dynamic Data in apictl Projects

The **WSO2 API Controller (apictl)** can inject dynamic values based on environment variables to various project files. The use of environment variables is a very convenient way of controlling inputs in almost every CI/CD platform.

## Add dynamic data to environment configurations

To allow easily configuring environment-specific details, by default, the apictl supports an additional parameter file. For more information on using an environment parameter file, see [Configuring Environment Specific Parameters]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters). 

The file supports detecting environment variables during the API (or API Product) import process. You can use the notation `${DEV_URL}` to specify environment variables to any attribute in this file. 

Follow the instructions below to add dynamic data to environment configurations of an API.

1. Initialize an API Project using the below command.

    ```bash
    apictl init PetstoreProject --oas https://petstore.swagger.io/v2/swagger.json
    ```

2.  Create a file named `params.yaml` with the below content.

    ```
    environments:
        - name: development
          configs:
              endpoints:
                  production:
                      url: ${DEV_ENV_PROD_URL}
                      config:
                          retryTimeOut: ${DEV_ENV_PROD_RE_TO}
                          retryDelay: ${DEV_ENV_PROD_RE_DELAY}
                  sandbox:
                      url: ${DEV_ENV_SAND_URL}
    ```

3.  Export the environment variables with required values.

    ```bash tab="Linux/Mac"
    export DEV_ENV_PROD_URL=https://petstore.swagger.io/v2
    export DEV_ENV_PROD_RE_DELAY=10
    export DEV_ENV_PROD_RE_TO=5
    export DEV_ENV_SAND_URL=https://sand.petstore.swagger.io/v2
    ```

    ```bat tab="Windows"
    SET DEV_ENV_PROD_URL=https://petstore.swagger.io/v2
    SET DEV_ENV_PROD_RE_DELAY=10
    SET DEV_ENV_PROD_RE_TO=5
    SET DEV_ENV_SAND_URL=https://sand.petstore.swagger.io/v2
    ```  

4.  Import the API Project

    ```bash
    apictl import api -f PetstoreProject --environment development --params params.yaml
    ```

    !!! warning
        If an environment variable is not set, the command will fail and request to set the required missing environment variables on the system. 

    !!!note
        `apictl import-api` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl import api` as shown above.

Once the project is successfully imported, sign-in to the WSO2 API Manager (WSO2 API-M) Publisher Portal and check the Endpoints section of the imported API. The URLs specified as environment variables will appear there.

[![]({{base_path}}/assets/img/learn/api-controller/advanced-topics/dynamic-data-env-config-api-endpoints.png)]({{base_path}}/assets/img/learn/api-controller/advanced-topics/dynamic-data-env-config-api-endpoints.png) 

## Add dynamic data to Operation Policies in an API project

Other than the API (or API Product) Environment Configuration (`params.yaml`), the apictl supports environment variable substitution in operation policies.

For example, consider we need to send a special header to the backend when calling the SwaggerPetstore API we created above. The value of the header should be a dynamic value which the apictl should have control over.

1. Create the below operation policy template `addCustomLogMessage.j2` in `PetstoreProject/Policies` folder.

    ```xml
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="custom-header-in">
        <header name="X-ENV-KEY" value="${ENV_KEY}" scope="transport" />
        <log level="custom">
            <property name="Sent header(X-ENV-KEY)" value="${ENV_KEY}"/>
        </log>
    </sequence>
    ```

2. Define the metadata of the above sequence by creating a new file named `addCustomLogMessage.yaml` in the `PetstoreProject/Policies` folder.

    ```yaml
    type: operation_policy_specification
    version: v4.2.0
    data:
      category: Mediation
      name: addCustomLogMessage
      version: v1
      displayName: Custom Log Policy
      description: "Using this policy, you can log the important details of the request"
      applicableFlows:
       - request
       - response
       - fault
      supportedGateways:
       - Synapse
      supportedApiTypes:
       - HTTP
      policyAttributes: []
    ```

3. Open `PetstoreProject/api.yaml` and change the following settings.

    1. Replace `lifeCycleStatus` value from `CREATED` to `PUBLISHED`. This is to ensure that the API will be Published once imported.
    2. Add the operation policy under the field (list) `operations` as shown below. (Here, the operation policy that we created in the above steps has been attached to the operation `/pet/{petId}`)

       ```yaml
         operations:
          -
           id: ""
           target: /pet/{petId}
           verb: GET
           authType: Application & Application User
           throttlingPolicy: Unlimited
           operationPolicies:
            request:
             -
              policyName: addCustomLogMessage
              parameters: {}
            response: []
            fault: []
       ```

    A sample configuration after applying the above changes is shown below.

    ```yaml
    type: api
    version: v4.2.0
    data:
        name: SwaggerPetstore
        description: 'This is a sample server Petstore server.  You can find out more about
            Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For
            this sample, you can use the api key `special-key` to test the authorization filters.'
        context: /v2/1.0.6
        version: 1.0.6
        lifeCycleStatus: PUBLISHED
        operations:
          -
           id: ""
           target: /pet/{petId}
           verb: GET
           authType: Application & Application User
           throttlingPolicy: Unlimited
           operationPolicies:
            request:
             -
              policyName: addCustomLogMessage
              parameters: {}
            response: []
            fault: []
    ...
    ```

4. Export the environment variables with required values.

    ```bash tab="Linux/Mac"
    export ENV_KEY=dev_101
    ```

    ```bat tab="Windows"
    SET ENV_KEY=dev_101
    ```

5. Import the API Project.

    ```bash
    apictl import api -f PetstoreProject --environment development --params params.yaml --update
    ```

    !!!note
        `apictl import-api` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl import api` as shown above.
        
6. Generate a token and invoke the API

    ```bash
    $ apictl get keys -e development -n SwaggerPetstore -v 1.0.6 -r admin
    eyJ0eXAiOiJKV1QiLCJhbGciOiJSUz....RWrACAUNSFBpxz1lRLqFlDiaVJAg

    $ curl -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUz....RWrACAUNSFBpxz1lRLqFlDiaVJAg" https://localhost:8243/v2/1.0.6/pet/1 -k
    {"id":1,"category":{"id":1001,"name":"Animal"},"name":"doggie","photoUrls":["img/test/dog.jpeg","img/test/dog1.jpeg"],"tags":[{"id":2001,"name":"Pet"},{"id":2002,"name":"Animal"}],"status":"available"}
    ```

    !!!note
        `apictl get-keys` command has been deprecated from the API Controller 4.0.0 onwards. Instead use `apictl get keys` as shown above.

Upon successful invocation, the header `X-ENV-KEY: dev_101` will be sent to the backend of the API. The below log will be printed in the API gateway's terminal.

```bash
INFO - LogMediator {api:SwaggerPetstore:v1.0.6} Sent header(X-ENV-KEY) = dev_101
```
