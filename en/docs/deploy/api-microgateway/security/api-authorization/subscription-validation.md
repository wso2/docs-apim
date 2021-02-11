# Subscription Validation

The [subscription]({{apim_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api/) validation is configurable for JWT and Opaque/reference tokens. In order to mandate the subscriptions, subscription validation can be enabled. 
If validation has failed, it will send an error message with error code 900908.

In WSO2 Microgateway subscription validation can be done in two ways.

1. Self-contained token with `subscribedAPIs` claim
    
    To authorize an API request with the self-contained JWT token under an issuer with subscription validation, the API name and version should be listed under `subscribedAPIs` claim of the JWT token.
    
    !!! note
        When an older version of WSO2 API Manager (3.1.* and below) is used as the key manager it sends the subscribed APIs as a list in the JWT under the `subscribedAPIs` claim. Therefore it is required to have the corresponding API name and version listed under `subscribedAPIs` claim to authorize the API request when JWT tokens issued by older API Manager versions are used. 

2. Event Hub based subscription validation

    For opaque/reference tokens and JWTs issued by API Manager 3.2.0 onwards, to enable subscription validation it requires the Event Hub to fetch Application and Subscription data from WSO2 API Manager.
    
    The latest versions of API manager do not include the `subscribedAPIs` claim in the JWT, instead, subscription validation is done using the `[eventhub]`. Refer documentation on [Event Hub and Subscription Validation Model]({{base_path}}/concepts/event-hub-and-subscription-validation/) to understand how WSO2 Microgateway validates subscriptions using Event Hub.   

### Configure Subscription Validation

You can enable or disable subscription validation using the following configuration and it is disabled by default. Add the following to the `<MGW-RUNTIME_HOME>`/conf/micro-gw.conf.

1. Configure Event Hub and key managers for token authentication.

    In order to do subscription validation, the `[eventHub]` must be enabled for the latest versions of API Manager. 

    ```toml
    # Configurations for retrieving API and subscription data from API Manager.
    [apim.eventHub]
        # Enable/ Disable the feature
        enable = true
        # The API Manager URL
        serviceUrl = "https://localhost:9443"
        # The internal data REST API context.
        internalDataContext="/internal/data/v1/"
        # User name and password of the internal data api.
        username="admin"
        password="admin"
        # The message broker connection URL.
        eventListeningEndpoints = "amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'"
    ```
   
    For JWT, provide JWT issuer configurations. Follow document on [configure Multiple JWT issuers]({{base_path}}/depoloy/security/api-authentication/secure-apis-using-oauth2.0-access-tokens/secure-apis-using-jwt-self-contained-jwt/#configure-multiple-jwt-issuers).
    For Opaque / reference token, provide introspection configurations. Follow document on [Secure APIs Using Opaque Tokens]({{base_path}}/depoloy/security/api-authentication/secure-apis-using-oauth2.0-access-tokens/secure-apis-using-opaque-tokens/#configure-api-microgateway-to-validate-oauth2-opaque-tokens).
    
    !!! note
        Older versions of WSO2 API Manager (2.x series and 3.0.0, 3.1.0) do not have the Event Hub capabilities. Therefore, when using Microgateway with those APIM versions, disable the Event Hub and set enableLegacyKM to true. This will use the older key validation service to validate the token and subscriptions for reference/ opaque tokens.
    
        ```yml
        # Key manager configurations
        [keyManager]
        # Connection URL of the Key Manager server
        serverUrl = "https://localhost:9443"
        # The token endpoint context of the Key Manager server
        tokenContext = "oauth2"
        # When Microgateway is used with older APIM versions for subscription validation by using KeyValidation service.
        enableLegacyMode = true
        ...
        [apim.eventHub]
        # Enable / Disable the feature
        enable = false
        ```
        
2. Enable subscription validation.
   
    - Enable Subscription Validation for JWT and Opaque/Reference tokens globally by enabling `validateSubscriptions` in security configuration.
    
    ```toml
    [security]
        # Enable/ Disable subscription validation for tokens.
        validateSubscriptions = true
    ```
    
    - Enable/disable Subscription Validation for JWT tokens by configuring `validateSubscription` under the corresponding JWT issuer configuration.
    
    ```toml 
    [[jwtTokenConfig]]
        issuer = "https://localhost:9443/oauth2/token"
        audience = "http://org.wso2.apimgt/gateway"
        certificateAlias = "wso2apim310"
        # Validate subscribed APIs
        validateSubscription = true
    ```
   
    !!! note
        If `validateSubscription` is configured(i.e. enabled/disabled) in `[[jwtTokenConfig]]`, regardless of the global validateSubscription configuration in `[security]`, 
        `validateSubscription` configuration in `[[jwtTokenConfig]]` will be effective for the particular JWT issuer
     