#  Configuring Different Endpoint Security Types

When there are multiple environments, to allow easily configuring environment-specific details, apictl supports an additional parameter file named `api_params.yaml`. (Please refer [Configuring Environment Specific Parameters]({{base_path}}/learn/api-controller/advanced-topics/configuring-environment-specific-parameters) for more information). You can specify different types of endpoint security in this file, as discussed under the below topics.

1. Configuring Basic or Digest Endpoint Security
2. Configuring OAuth 2.0 Endpoint Security

### Configuring Basic or Digest Endpoint Security

The following is an example `api_params.yaml` file for this scenario.

!!! example
    ```go
    environments:
        - name: dev
          endpoints:
              production:
                  url: 'https://dev.prod.wso2.com'
              sandbox:
                  url: 'https://dev.sand.wso2.com'
          security:
              enabled: true
              type: basic
              username: 'admin'
              password: 'admin'
    ```

Under the security field, if the `enabled` attribute is `true`, you must specify the `username`, `password` and the `type` (can be either only `basic` or `digest`). If the `enabled` attribute is `false`, then none of the security parameters will be set. If the `enabled` attribute is not set (blank), then the security parameters in api.yaml file will be considered.

!!! info
    Here, setting the basic or digest endpoint security **can only be done globally**. That means when you specify the `security` field as shown above, both the production and sandbox endpoints will have the same security configurations. In other words, you cannot change the production and sandbox security per endpoint type separately via API Controller (apictl) for the basic and digest types.

### Configuring OAuth 2.0 Endpoint Security

!!! warning
    **Configuring OAuth 2.0 Endpoint Security** using the parameters file has been introduced via an U2/WUM update and is effective from 8th October 2021 (2021-10-08).
    
    For more information on how to update using U2, see [Updates 2.0 Documentation](https://updates.docs.wso2.com/en/latest/updates/overview/). For more information on how to update using WUM, see the documentation [Using WSO2 Update Manager](https://docs.wso2.com/display/updates100/Using+WSO2+Update+Manager).

The following is an example `api_params.yaml` file for this scenario.

!!! example
    ```go
    environments:
        - name: dev
          endpoints:
              production:
                  url: 'https://dev.prod.wso2.com'
              sandbox:
                  url: 'https://dev.sand.wso2.com'
          security:
              production:
                  enabled: true
                  type: oauth
                  tokenUrl: https://prod.token.com
                  clientId: Poc7i6mTj0ac3LyTW0szFzdt1gwanew
                  clientSecret: edDEOOjlY0kgClxVlntwWVFve64a
                  grantType: client_credentials
                  customParameters: 
                    param1: val1
                    param2: val2
              sandbox:
                  enabled: true
                  type: oauth
                  username: 'admin'
                  password: 'password'
                  tokenUrl: https://sand.token.com
                  clientId: Fcd7i6mTj0ac3LyTW0szFzdt1asd
                  clientSecret: rfDEOOjlY0kgClxVlntwWVFve56f
                  grantType: password
                  customParameters: 
                    param3: val3
                    param4: val4
    ```

Unlike, basic or digest, you can provide OAuth 2.0 endpoint security **per endpoint type** (for production and sandbox separately).

It is mandatory to specify the fields `type`, `tokenUrl`, `clientId`, `clientSecret` and `grantType` for the OAuth 2.0 endpoint security.

The `grantType` can be either Client Credentials (`client_credentials`) or Resource Owner Password (`password`). If you specify the grant type as `password`, it is mandatory to provide the `username` and `password.`
