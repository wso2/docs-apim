#  Configuring Environment Specific Parameters

When there are multiple environments, to allow easily configuring environment-specific details, apictl supports an additional parameter file named `api_params.yaml` or an additional directory to store these deployment-related artifacts. It is recommended to store the parameter file inside the deployment directory if there are certificates and other details are included; however, it can be stored somewhere else when certificates are not specified via this additional `api_params.yaml` file. 

## Generating the Deployment Directory 

When there are multiple artifacts which needs to be added as deployment-related configurations, it is recommended to use a separate directory to store all these configurations. API Controller provides the support to generate this deployment-specific directory using the following commands.

-   **Command**
        ``` bash
        apictl gen deployment-dir -s <path-to-API-Source-archive> 
        ```
        ``` bash
        apictl gen deployment-dir -s <path-to-API-Source-archive> -d <path-to-the-Deployment-archive>
        ```
        ``` bash
        apictl gen deployment-dir --source <path-to-API-Source-archive> 
        ```
        ``` bash
        apictl gen deployment-dir --source <path-to-API-Source-archive> --destination <path-to-the-Deployment-archive>
        ```

    !!! info
            **Flags:**  
            
            -   Required :  
                `--source` or `-s` : File path of the source artifact to be used when generating the deployment directory.
            -   Optional :  
                `--destination` or `-d` : Path of the directory where the new deployment directory should be generated.    

    !!! example
            ```bash
            apictl gen deployment-dir  -s  /desktop/source/Dev/PizzaShackAPI_1.0.0_r1   
            ```
            ```bash
            apictl gen deployment-dir  -s /desktop/source/Dev/PizzaShackAPI_1.0.0_r1  -d /desktop/deployment/Dev
            ```
            ```bash
            apictl gen deployment-dir  --source  /desktop/source/Dev/PizzaShackAPI_1.0.0_r1   
            ```
            ```bash
            apictl gen deployment-dir  --source /desktop/source/Dev/PizzaShackAPI_1.0.0_r1  --destination /desktop/deployment/Dev
            ```

    !!!note
            If the `--destination` flag is not provided, the deployment directory will be generated in the working directory by default.

    A project folder with the following default structure will be created in the given directory.

    ``` java
    ├── api_params.yaml
    ├── api_meta.yaml
    └── certificates    
    ```
    <table>
        <thead>
            <tr class="header">
                <th>Sub Directory/File</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr class="odd">
                <td><code>api_params.yaml</code></td>
                <td>The specification of the environment specific configurations.</td>
            </tr>
            <tr class="odd">
                <td><code>api_meta.yaml</code></td>
                <td>The meta-information file of the source artifact (This includes the name, version, and revision of the source).</td>
            </tr>
            <tr class="odd">
                <td>certificates</td>
                <td>Contains the client certificates for Mutual SSL enabled APIs and endpoint certificates for endpoint security enabled APIs.</td>
            </tr>
        </tbody>
    </table>

## Defining the api_params.yaml file.

The following is the structure of the parameter file.

```go
environments:
    - name: <environment_name>
      configs: <multiple_configurations_relevant_to_the_specific_environment>
        endpoints:
            production:
                url: <production_endpoint_url>
                config:
                    retryTimeOut: <no_of_retries_before_suspension>
                    retryDelay: <retry_delay_in_ms>
                    factor: <suspension_factor>
            sandbox:
                url: <sandbox_endpoint_url>
                config:
                    retryTimeOut: <no_of_retries_before_suspension>
                    retryDelay: <retry_delay_in_ms>
                    factor: <suspension_factor>
        security:
            enabled: <whether_security_is_enabled>
            type: <endpoint_authentication_type_basic_or_digest>
            username: <endpoint_username>
            password: <endpoint_password>
        gatewayEnvironments:
            - <gateway_environment_name>           
        certs:
            - hostName: <endpoint_url>
              alias: <certificate_alias>
              path: <certificate_name>
        mutualSslCerts:
            - tierName: <subscription_tier_name>
              alias: <certificate_alias>
              path: <certificate_name>
        policies:
            - <subscription_policy_1_name>
            - <subscription_policy_2_name>
```
The following code snippet contains sample configuration of the parameter file.

!!! example
    ```go
    environments:
        - name: dev
          configs:
            endpoints:
                production:
                    url: 'https://dev.wso2.com'
            security:
                enabled: true
                type: basic
                username: admin
                password: admin
            certs:
                - hostName: 'https://dev.wso2.com'
                  alias: Dev
                  path: dev.crt 
            gatewayEnvironments:
                - Production and Sandbox   
            policies:
                - Gold
                - Silver 
        - name: test
          configs:
            endpoints:
                production:
                    url: 'https://test.wso2.com'
                    config:
                        retryTimeOut: $RETRY
                sandbox:
                    url: 'https://test.sandbox.wso2.com'
            security:
                enabled: true
                type: digest
                username: admin
                password: admin
        - name: production
          configs:
            endpoints:
                production:
                    url: 'https://prod.wso2.com'
                mutualSslCerts:
                    - tierName: Unlimited
                      alias: Prod1
                      path: prod1.crt
                    - tierName: Gold
                      alias: Prod2
                      path: prod2.crt
    ```
Instead of the default `api_params.yaml`, you can a provide custom parameter file using `--params` flag. A sample command will be as follows.

!!! example
    ```go
    apictl import api -f dev/PhoneVerification_1.0.zip -e production --params /home/user/custom_params.yaml 
    ```

!!!note
    `apictl import-api` command has been deprecated from the API Controller 4.0.0 onwards. Instead, use `apictl import api` as shown above.

!!! info
    -   Production/Sandbox backends for each environment can be specified in the parameter file with additional configurations, such as timeouts.
    -   Under the `security` field, if the `enabled` attribute is `true`, you must specify the `username`, `password` and the `type` (can be either only `basic` or `digest`). If the `enabled` attribute is `false`, then none of the security parameters will be set. If the `enabled` attribute is not set (blank), then the security parameters in the `api.yaml` file will be considered.
    -   The parameter file supports detecting environment variables during the API import process. You can use the usual notation. For example, `url: $DEV_PROD_URL`.  If an environment variable is not set, the tool will fail. In addition, the system will also request for a set of required environment variables.
    - To learn about setting up different endpoint types such as HTTP/REST, HTTP/SOAP (with load balancing and failover), Dynamic and AWS Lambda, see [Configuring Different Endpoint Types]({{base_path}}/learn/api-controller/advanced-topics/configuring-different-endpoint-types).
    - You can define the subscription level policies of an API using the field `policies`. There you can specify one or more subscription level policies that is available in the particular environment where you are importing the API to.

!!! note

    Certificates (Endpoint certificates and MutualSSL certificates) for each URL can be configured in the parameter file. When configuring these certificates the following steps should be followed:
       
      -   Create a directory named `certificates` at the location where the parameter file is stored. (Both the `certificates` directory and the parameter file should exist at the same directory level.)
      -   Move all the certificates (Endpoint certificates and MutualSSL certificates) to that directory.
      -   You need to provide the name of the certificate at the `path` field of the parameters file and also a valid name for the certificate file.
