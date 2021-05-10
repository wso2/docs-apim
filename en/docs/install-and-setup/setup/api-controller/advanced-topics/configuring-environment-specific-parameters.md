#  Configuring Environment Specific Parameters

To allow easily configuring environment-specific details when there are multiple environments, **WSO2 API Controller (apictl)** supports an additional parameter file (will be referred to as the "params file" in this document) or an additional directory to store these deployment-related artifacts. It is recommended to store the params file inside the deployment directory if there are certificates and other details included. However, it can be stored somewhere else when certificates are not specified via this params file. 

## Generating the Deployment Directory 

When there are multiple artifacts which needs to be added as deployment-related configurations, it is recommended to use a separate directory to store all these configurations. apictl provides the support to generate this deployment-specific directory using the following commands.

-   **Command**
        ``` bash
        apictl gen deployment-dir -s <path-to-source-directory-or-archive>
        ```
        ``` bash
        apictl gen deployment-dir -s <path-to-source-directory-or-archive> -d <path-to-create-the-deployment-directory>
        ```
        ``` bash
        apictl gen deployment-dir --source <path-to-source-directory-or-archive>
        ```
        ``` bash
        apictl gen deployment-dir --source <path-to-source-directory-or-archive> --destination <path-to-create-the-deployment-directory>
        ```

    !!! info
            **Flags:**  
            
            -   Required :  
                `--source` or `-s` : File path of the source artifact to be used when generating the deployment directory.
            -   Optional :  
                `--destination` or `-d` : Path of the directory where the new deployment directory should be generated.    

    !!! example
            ```bash
            apictl gen deployment-dir  -s /desktop/source/Dev/PizzaShackAPI_1.0.0   
            ```
            ```bash
            apictl gen deployment-dir  -s /desktop/source/dev/PizzaShackAPI_1.0.0.zip  -d /desktop/deployment/dev
            ```
            ```bash
            apictl gen deployment-dir  -s /desktop/source/dev/LeasingAPIProduct_1.0.0  -d /desktop/deployment/dev
            ```
            ```bash
            apictl gen deployment-dir  --source  /desktop/source/dev/PizzaShackAPI_1.0.0   
            ```
            ```bash
            apictl gen deployment-dir  --source /desktop/source/Dev/PizzaShackAPI_1.0.0.zip  --destination /desktop/deployment/dev
            ```
            ```bash
            apictl gen deployment-dir  --source /desktop/source/dev/LeasingAPIProduct_1.0.0  --destination /desktop/deployment/dev
            ```

    !!!note
            If the `--destination` flag is not provided, the deployment directory will be generated in the working directory by default.

    A project folder with the following default structure will be created in the given directory.

    ``` java
    DeploymentArtifacts_<API_Name>-<API_Version>
    ├── api_meta.yaml (api_product_meta.yaml for API Products)
    ├── certificates
    └── params.yaml   
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
                <td><code>params.yaml</code></td>
                <td>The specification of the environment specific configurations.</td>
            </tr>
            <tr class="even">
                <td><code>api_meta.yaml</code>/<code>api_product_meta.yaml</code></td>
                <td>The meta-information file of the source artifact (This includes the name and the version of the source).</td>
            </tr>
            <tr class="odd">
                <td>certificates</td>
                <td>Contains the client certificates for Mutual SSL enabled APIs/API Products and endpoint certificates for endpoint security enabled APIs.</td>
            </tr>
        </tbody>
    </table>


## Bundling the generated directory before Import

After generating the deployment directory, you can use the bundle command to archive it without the need of external dependencies. This command will generate a `.zip` archive
file of a given directory. If `api_meta.yaml` file (or `api_product_meta.yaml` or `application_meta.yaml`) is included in
the project, the created archive file name will be the combination of the project name and the version.  

-   **Command**
        ``` bash
        apictl bundle -s <path-to-source-directory> 
        ```
        ``` bash
        apictl bundle -s <path-to-source-directory>  -d <path-to-the-archive-destination>
        ```
        ``` bash
        apictl bundle --source <path-to-source-directory> 
        ```
        ``` bash
        apictl bundle --source <path-to-source-directory>  --destination <path-to-the-archive-destination>
        ```
        
    !!! info
            **Flags:**  
            
            -   Required :  
                `--source` or `-s` : File path of the source directory to archive  
            -   Optional :  
                `--destination` or `-d` : Path of the directory where the archive should be generated     

    !!! example
            ```bash
            apictl bundle -s /Source/apis/dev/API1-1  
            ```
            ```bash
            apictl bundle -s /Source/apis/dev/API1-1  -d /Deployment/apis/dev
            ```
            ```bash
            apictl bundle --source /Source/apis/dev/API1-1   
            ```
            ```bash
            apictl bundle --source /Source/apis/dev/API1-1  --destination /Deployment/apis/dev
            ```

    !!!note
            - If the `--destination` flag is not provided, the archive will be created in the working directory by
             default.
            - If the `api_meta.yaml` (or `api_product_meta.yaml` or `application_meta.yaml`) is not included in the
              project, source directory name would be used as the archived file name.


## Defining the params file for an API

The following is the structure of the params file of an API.

```yaml
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
              production:
                  enabled: <whether_security_is_enabled_for_production_endpoint>
                  type: <endpoint_authentication_type_basic_or_digest_for_production_endpoint>
                  username: <endpoint_username_for_production_endpoint>
                  password: <endpoint_password_for_production_endpoint>
              sandbox:
                  enabled: <whether_security_is_enabled_for_sandbox_endpoint>
                  type: <endpoint_authentication_type_basic_or_digest_for_sandbox_endpoint>
                  username: <endpoint_username_for_sandbox_endpoint>
                  password: <endpoint_password_for_sandbox_endpoint>
          deploymentEnvironments:
              - displayOnDevportal: <boolean>
	            deploymentEnvironment: <environment_name>
                deploymentVhost : <vhost_name>        
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

The following code snippet contains sample configuration of the params file of an API.

!!! example
    ```go
    environments:
        - name: dev
          configs:
            endpoints:
                production:
                    url: 'https://dev.wso2.com'
            security:
                production:
                    enabled: true
                    type: basic
                    username: admin
                    password: admin
            certs:
                - hostName: 'https://dev.wso2.com'
                  alias: Dev
                  path: dev.crt 
            deploymentEnvironments:
                - displayOnDevportal: true
                  deploymentEnvironment: Label1
                  deploymentVhost : localhost
                - displayOnDevportal: true
                  deploymentEnvironment: Label2
                  deploymentVhost : us.wso2.com 
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
                production:
                    enabled: true
                    type: digest
                    username: admin
                    password: admin
                sandbox:
                    enabled: true
                    type: basic
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
    
You can provide the params file using `--params` flag when importing an API. A sample command will be as follows.

!!! example
    ```go
    apictl import api -f dev/PhoneVerification_1.0.zip -e production --params /home/user/custom_params.yaml 
    ```
    
!!! note
    `apictl import-api` command has been deprecated from the API Controller 4.0.0 onwards. Instead, use `apictl import api` as shown above.

-   You can deploy an API project which does not include `deployment_environments.yaml` (working copy of the API or a revision without deployment environments) by specifying the `deploymentEnvironments` fields in the params file.
-   Production/Sandbox backends for each environment can be specified in the params file with additional configurations, such as timeouts.
-   Under the `security` field, you can specify the endpoint security details for the `production` and the `sandbox` endpoint separately. If the `enabled` attribute is `true`, you must specify the `username`, `password` and the `type` (can be either only `basic` or `digest`). If the `enabled` attribute is `false`, then none of the security parameters will be set. If the `enabled` attribute is not set (blank), then the security parameters in the `api.yaml` file will be considered.
-   The params file supports detecting environment variables during the API import process. You can use the usual notation. For example, `url: $DEV_PROD_URL`.  If an environment variable is not set, the tool will fail. In addition, the system will also request for a set of required environment variables.
-   To learn about setting up different endpoint types such as HTTP/REST, HTTP/SOAP (with load balancing and failover), Dynamic and AWS Lambda, see [Configuring Different Endpoint Types]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-different-endpoint-types).
-   You can define the subscription level policies of an API using the field `policies`. There you can specify one or more subscription level policies that is available in the particular environment where you are importing the API to.
-   Refer the section [Handling the certificates using the params file](#handling-the-certificates-using-the-params-file) to learn how to configure certificates using the params file.

## Defining the params file for an API Product

The following is the structure of the params file of an API Product.

```yaml
environments:
    - name: <environment_name>
      configs: <multiple_configurations_relevant_to_the_specific_environment>
          dependentAPIs:
              <api_1_name>-<api_1_version>:
                      endpoints:
                          production:
                              url: <production_endpoint_url_for_api_1>
                              config:
                                  retryTimeOut: <no_of_retries_before_suspension_for_api_1>
                                  retryDelay: <retry_delay_in_ms_for_api_1>
                                  factor: <suspension_factor_for_api_1>
                          sandbox:
                              url: <sandbox_endpoint_url_for_api_1>
                              config:
                                  retryTimeOut: <no_of_retries_before_suspension_for_api_1>
                                  retryDelay: <retry_delay_in_ms_for_api_1>
                                  factor: <suspension_factor_for_api_1>
                      security:
                          production:
                              enabled: <whether_security_is_enabled_for_production_endpoint_for_api_1>
                              type: <endpoint_authentication_type_basic_or_digest_for_production_endpoint_for_api_1>
                              username: <endpoint_username_for_production_endpoint_for_api_1>
                              password: <endpoint_password_for_production_endpoint_for_api_1>
                          sandbox:
                              enabled: <whether_security_is_enabled_for_sandbox_endpoint_for_api_1>
                              type: <endpoint_authentication_type_basic_or_digest_for_sandbox_endpoint_for_api_1>
                              username: <endpoint_username_for_sandbox_endpoint_for_api_1>
                              password: <endpoint_password_for_sandbox_endpoint_for_api_1>
                      deploymentEnvironments:
                          - displayOnDevportal: <boolean_for_api_1>
                            deploymentEnvironment: <environment_name_for_api_1>
                            deploymentVhost : <vhost_name_for_api_1>        
                      certs:
                          - hostName: <endpoint_url_for_api_1>
                            alias: <certificate_alias_for_api_1>
                            path: <certificate_name_for_api_1>
                      mutualSslCerts:
                          - tierName: <subscription_tier_name_for_api_1>
                            alias: <certificate_alias_for_api_1>
                            path: <certificate_name_for_api_1>
                      policies: 
                          - <subscription_policy_1_name_for_api_1>
                          - <subscription_policy_2_name_for_api_1>
              <api_2_name>-<api_2_version>:
                      endpoints:
                          production:
                              url: <production_endpoint_url_for_api_2>
                              config:
                                  retryTimeOut: <no_of_retries_before_suspension_for_api_2>
                                  retryDelay: <retry_delay_in_ms_for_api_2>
                                  factor: <suspension_factor_for_api_2>
                          sandbox:
                              url: <sandbox_endpoint_url_for_api_2>
                              config:
                                  retryTimeOut: <no_of_retries_before_suspension_for_api_2>
                                  retryDelay: <retry_delay_in_ms_for_api_2>
                                  factor: <suspension_factor_for_api_2>
                      security:
                          production:
                              enabled: <whether_security_is_enabled_for_production_endpoint_for_api_2>
                              type: <endpoint_authentication_type_basic_or_digest_for_production_endpoint_for_api_2>
                              username: <endpoint_username_for_production_endpoint_for_api_2>
                              password: <endpoint_password_for_production_endpoint_for_api_2>
                          sandbox:
                              enabled: <whether_security_is_enabled_for_sandbox_endpoint_for_api_2>
                              type: <endpoint_authentication_type_basic_or_digest_for_sandbox_endpoint_for_api_2>
                              username: <endpoint_username_for_sandbox_endpoint_for_api_2>
                              password: <endpoint_password_for_sandbox_endpoint_for_api_2>
                      deploymentEnvironments:
                          - displayOnDevportal: <boolean_for_api_2>
                            deploymentEnvironment: <environment_name_for_api_2>  
                            deploymentVhost : <vhost_name_for_api_2>      
                      certs:
                          - hostName: <endpoint_url_for_api_2>
                            alias: <certificate_alias_for_api_2>
                            path: <certificate_name_for_api_2>
                      mutualSslCerts:
                          - tierName: <subscription_tier_name_for_api_2>
                            alias: <certificate_alias_for_api_2>
                            path: <certificate_name_for_api_2>
                      policies: 
                          - <subscription_policy_1_name_for_api_2>
                          - <subscription_policy_2_name_for_api_2>
          deploymentEnvironments:
              - displayOnDevportal: <boolean>
	            deploymentEnvironment: <environment_name>
                deploymentVhost : <vhost_name>
	      mutualSslCerts:
              - tierName: <subscription_tier_name>
                alias: <certificate_alias>
                path: <certificate_name>
          policies: 
              - <subscription_policy_1_name>
              - <subscription_policy_2_name>
```

The following code snippet contains sample configuration of the params file of an API Product.

!!! example
    ```go
    environments:
        - name: dev
          configs:
              dependentAPIs:
                  PizzaShackAPI-1.0.0:
                      endpoints:
                          production:
                              url: https://prod1.wso2.com
                              config:
                                  retryTimeOut: $RETRY
                          sandbox:
                              url: https://sand2.wso2.com
                      security:
                          production:
                              enabled: true
                              type: basic
                              username: admin
                              password: admin
                      certs:
                          - hostName: https://prod1.wso2.com
                            alias: alice
                            path: alice.crt
                      policies:
                          - Gold
                          - Silver
                  PetstoreAPI-1.0.5:
                      endpoints:
                          production:
                              url: https://prod1.wso2.com
                          sandbox:
                              url: https://sand2.wso2.com
                      security:
                          production:
                              enabled: true
                              type: digest
                              username: admin
                              password: admin
                          sandbox:
                              enabled: true
                              type: basic
                              username: admin
                              password: admin
                      certs:
                          - hostName: https://prod1.wso2.com
                            alias: bob
                            path: bob.crt
                      policies:
                          - Gold
                          - Silver
              deploymentEnvironments:
                  - displayOnDevportal: true
                    deploymentEnvironment: Label1
                    deploymentVhost : localhost
                  - displayOnDevportal: true
                    deploymentEnvironment: Label2
                    deploymentVhost : us.wso2.com  
              policies:
                  - Gold
                  - Silver 
              mutualSslCerts:
                  - tierName: Unlimited
                    alias: Prod1
                    path: prod1.crt
                  - tierName: Gold
                    alias: Prod2
                    path: prod2.crt
        - name: production
          configs:
              deploymentEnvironments:
                  - displayOnDevportal: true
                    deploymentEnvironment: Default
                    deploymentVhost : localhost
              mutualSslCerts:
                  - tierName: Unlimited
                    alias: Prod1
                    path: prod1.crt
                  - tierName: Gold
                    alias: Prod2
                    path: prod2.crt
    ```
    
You can provide the params file using `--params` flag when importing an API Product. A sample command will be as follows.

!!! example
    ```go
    apictl import api product -f dev/LeasingAPIProduct.zip -e production --params /home/user/custom_params.yaml 
    ```
-   The params file of an API Product does not support the fields `endpoints`, `security` and `certs` like in the params file of an API. It only supports the fields `deploymentEnvironments`, `policies`, `mutualSslCerts` and another special field named `dependentAPIs`.
-   The field `dependentAPIs` can be used to specify the params of dependent APIs. The params of a particular dependent API of an API Product is similar to the params of an API, but there is no use of specifying the `deploymentEnvironments` field under a dependent API. The reason for that is, the deployment environments of the API Product will be considered for dependent APIs as well.
-   You can deploy an API Product which does not include `deployment_environments.yaml` (working copy of the API Product or a revision without deployment environments) by specifying the `deploymentEnvironments` fields in the params file.
-   The params file supports detecting environment variables during the API Product import process. You can use the usual notation. For example, `url: $DEV_PROD_URL`.  If an environment variable is not set, the tool will fail. In addition, the system will also request for a set of required environment variables.
-   Refer the section [Handling the certificates using the params file](#handling-the-certificates-using-the-params-file) to learn how to configure certificates using the params file.

## Handling the certificates using the params file

Follow the below steps to override the certificates using the params file.

1. Generate the deployment directory for the particular API or API Product as explained in [Generating the Deployment Directory](#generating-the-deployment-directory).
2. Move all the certificates (Endpoint certificates and MutualSSL certificates) to the **certificates** directory that is inside the generated deployment directory.
3. Open the `params.yaml` file inside the generated deployment directory and add your params content inside it.
3. Provide the name of the certificate file at the `path` field under the field `certs` (to override endpoint certificates) and `mutualSslCerts` (to override client/MutualSSL certificates) in the params file as shown in the earlier topics.

Now, after you import the API or API Product with the ``--params`` flag pointed to the deployment directory that you generated, the configurations will be applied to the imported API or API Product.

!!! note
    **Special note about the certificates of API Products**
    
    -   You can follow the same steps mentioned above to configure **MutualSSL (Client) certificates** for an API Product (That is, by copying the certificates to the **certificates** directory and by specifying the certificate file names in the `path` field under the `mutualSslCerts` in the params file)
    -   **You cannot configure Endpoint certificates for API Products**, since API Products do not have endpoints itself. Instead, an API Product will be using the endpoints of its dependent APIs. 
    -   **To configure the Endpoint certificates of dependent APIs**, you can add those to the **certificates** directory as we did before. Then, specify the certificate file name in the `path` fields under the `certs` field of the corresponding dependent API listed in the field `dependentAPIs` of the params file of the API Product. 