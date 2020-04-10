#  Configuring Environment Specific Parameters

When there are multiple environments, to allow easily configuring environment-specific details, apictl supports an additional parameter file named `api_params.yaml`. It is recommended to store the parameter file with the API Project; however, it can be stored anywhere as required. 

After the file is placed in the project directory, the tool will auto-detect the parameters file upon running the `import-api` command and create an environment-based artifact for API Manager. If the `api_params.yaml` is not found in the project directory, the tool will lookup in the project’s base path and the current working directory. 

The following is the structure of the parameter file.

```go
environments:
    - name: <environment_name>
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
      gatewayEnvironments:
        - <gateway_environment_name>           
      certs:
        - hostName: <endpoint_url>
          alias: <certificate_alias>
          path: <certificate_file_path>
```
The following code snippet contains sample configuration of the parameter file.

!!! example
    ```go
    environments:
        - name: dev
          endpoints:
            production:
              url: 'https://dev.wso2.com'
          certs:
            - hostName: 'https://dev.wso2.com'
              alias: Dev
              path: ~/.certs/dev.pem 
          gatewayEnvironments:
            - Production and Sandbox    
        - name: test
          endpoints:
            production:
              url: 'https://test.wso2.com'
              config:
                retryTimeOut: $RETRY
            sandbox:
              url: 'https://test.sandbox.wso2.com'
    ```
Instead of the default `api_params.yaml`, you can a provide custom parameter file using `--params` flag. A sample command will be as follows.

!!! example
    ```go
    apictl import-api -f dev/PhoneVerification_1.0.zip -e production --params /home/user/custom_params.yaml 
    ```

!!! info
    -   Production/Sandbox backends for each environment can be specified in the parameter file with additional configurations, such as timeouts.
    -   Certificates for each URL can be configured in the parameter file. For certificates, a valid path to the certificate file is required. 
    -   The parameter file supports detecting environment variables during the API import process. You can use the usual notation. For example, `url: $DEV_PROD_URL`.  If an environment variable is not set, the tool will fail. In addition, the system will also request for a set of required environment variables.