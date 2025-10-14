# API YAML Representation in WSO2 API Manager

This documentation provides an overview of the structure and fields in the `api.yaml` file used in WSO2 API Manager to represent an API.
The `api.yaml` file is used to represent various aspects of an API, including simple details such as the API name and description, as well as more complex configurations such as security schemes, throttling policies, etc.

!!! tip
    You can find the `api.yaml` file for an API by downloading the API from API Manager Publisher Portal or by exporting the API using the API Manager REST API.

!!! warning
    Not all fields of the `api.yaml` will be populated for every API. The fields populated in the `api.yaml` file depend on the API configuration in WSO2 API Manager.

## API YAML Structure

The structure of the `api.yaml` file follows a specific format as shown below for representing an API in WSO2 API Manager.


=== "Template"
    ```toml
    type: API Type
    version: Version of the API Manager
    data:
      id: API UUID
      name: API Name
      description: API Description
      context: API Context
      version: API Version
      provider: API Provider Name
      lifeCycleStatus: Current Lifecycle Status of the API
      responseCachingEnabled: API Response Caching Status
      cacheTimeout: API'sCache Timeout Duration in Seconds
      hasThumbnail: API Thumbnail Availability
      isDefaultVersion: API Default Version Status
      isRevision: API Revision Status
      revisionId: API Revision ID
      enableSchemaValidation: API Schema Validation Status
      enableSubscriberVerification: API Subscriber Verification Status
      type: API Type
      audience: API Audience
      transport: Supported Transports for the API
      tags: API Tags
      policies: API Policies
      apiThrottlingPolicy: API Level Throttling Policy
      authorizationHeader: API Authorization Header
      apiKeyHeader: API Key Header Name
      securityScheme: API Security Scheme Type
      maxTps: Maximum Transactions per Second (Production and Sandbox Environments)
      visibility: Visibility Level of the API
      visibleRoles: Roles with Access to the API in Developer Portal
      visibleTenants: Tenants with Access to the API in Developer Portal
      mediationPolicies: Set of Mediation Policies for the API
      subscriptionAvailability: API Subscription Availability
      subscriptionAvailableTenants: Tenants Allowed to Subscribe to the API if Subscription Availability is SPECIFIC_TENANTS
      additionalProperties: Custom Properties for the API
      additionalPropertiesMap: Additional Custom Metadata for the API
      accessControl: API Access Control
      accessControlRoles: Roles with Permissions to View/Modify the API as Publisher/Creator
      businessInformation:
        businessOwner: Business Owner Name
        businessOwnerEmail: Business Owner Email
        technicalOwner: Technical Owner Name
        technicalOwnerEmail: Technical Owner Email
      corsConfiguration:
        corsConfigurationEnabled: API CORS Configuration Status
        accessControlAllowOrigins: Origins Allowed to Access the API
        accessControlAllowCredentials: Credentials Allowed for CORS Requests
        accessControlAllowHeaders: Headers Allowed for CORS Requests
        accessControlAllowMethods: Methods Allowed for CORS Requests
      websubSubscriptionConfiguration:
        enable: WebSub Subscription Configuration Status
        secret: Secret for Signing WebSub Content
        signingAlgorithm: Algorithm Used for Signing WebSub Messages
        signatureHeader: Header Containing the WebSub Signature
      createdTime: API Creation Timestamp
      lastUpdatedTimestamp: Last API Update Timestamp
      lastUpdatedTime: Time of the Last API Update
      endpointConfig:
        endpoint_type: Endpoint Type (HTTP/HTTPS)
      endpointImplementationType: API Endpoint Implementation Type
      scopes: API Scopes
      operations: API Operations
      categories: API Categories
      keyManagers: List of Key Managers
      advertiseInfo:
        apiOwner: API Owner
        vendor: API Vendor
      gatewayVendor: API Gateway Vendor
      gatewayType: Selected API Gateway Type (e.g., wso2/synapse, wso2/apk)
      asyncTransportProtocols: Supported Async Transport Protocols (HTTP, HTTPS)
      organizationId: Organization ID
      egress: API Egress Configuration
    ```

=== "Sample"
    ```toml
      type: api
      version: v4.6.0
      data:
        id: 1eac20a4-4240-4fb7-8ced-c257e25e542d
        name: PizzaShackAPI
        description: This is a simple API for Pizza Shack online pizza delivery store.
        context: /pizzashack
        version: 1.0.0
        provider: admin
        lifeCycleStatus: PUBLISHED
        responseCachingEnabled: false
        cacheTimeout: 300
        hasThumbnail: false
        isDefaultVersion: false
        isRevision: false
        revisionId: 0
        enableSchemaValidation: false
        enableSubscriberVerification: false
        type: HTTP
        audiences:
          - all
        transport:
          - https
        tags:
          - pizza
        policies:
          - Bronze
        organizationPolicies: []
        authorizationHeader: Authorization
        apiKeyHeader: ApiKey
        securityScheme:
          - oauth_basic_auth_api_key_mandatory
          - oauth2
        visibility: PUBLIC
        visibleRoles: []
        visibleTenants: []
        visibleOrganizations:
          - none
        mediationPolicies: []
        subscriptionAvailability: CURRENT_TENANT
        subscriptionAvailableTenants: []
        additionalProperties: []
        additionalPropertiesMap: {}
        accessControl: NONE
        accessControlRoles: []
        businessInformation:
          businessOwner: Jane Roe
          businessOwnerEmail: marketing@pizzashack.com
          technicalOwner: John Doe
          technicalOwnerEmail: architecture@pizzashack.com
        corsConfiguration:
          corsConfigurationEnabled: false
          accessControlAllowOrigins:
            - '*'
          accessControlAllowCredentials: false
          accessControlAllowHeaders:
            - authorization
            - Access-Control-Allow-Origin
            - Content-Type
            - SOAPAction
            - apikey
            - Internal-Key
          accessControlAllowMethods:
            - GET
            - PUT
            - POST
            - DELETE
            - PATCH
            - OPTIONS
        websubSubscriptionConfiguration:
          enable: false
          secret: ""
          signingAlgorithm: SHA1
          signatureHeader: x-hub-signature
        createdTime: "1741450820577"
        lastUpdatedTimestamp: "1741504347820"
        lastUpdatedTime: 2025-03-09 12:42:27.82
        endpointConfig:
          endpoint_type: http
          sandbox_endpoints:
            url: https://localhost:9443/am/sample/pizzashack/v1/api/
          production_endpoints:
            url: https://localhost:9443/am/sample/pizzashack/v1/api/
          endpoint_security:
            sandbox:
              tokenUrl: https://test.com
              clientId: 1eac20a4-4240-4fb7-8ced-c257e25e542d
              connectionTimeoutDuration: "100"
              type: OAUTH
              socketTimeoutDuration: "100"
              enabled: true
              proxyConfigs:
                proxyEnabled: ""
                proxyPort: ""
                proxyProtocol: ""
                proxyUsername: ""
                proxyPassword: ""
                proxyHost: ""
              clientSecret: ""
              customParameters: {}
              grantType: CLIENT_CREDENTIALS
              connectionRequestTimeoutDuration: "100"
              username: ""
            production:
              tokenUrl: ""
              connectionTimeoutDuration: -1
              type: BASIC
              socketTimeoutDuration: -1
              enabled: true
              proxyConfigs:
                proxyEnabled: ""
                proxyPort: ""
                proxyProtocol: ""
                proxyUsername: ""
                proxyPassword: ""
                proxyHost: ""
              password: ""
              customParameters: {}
              grantType: ""
              connectionRequestTimeoutDuration: -1
              username: admin
        endpointImplementationType: ENDPOINT
        subtypeConfiguration:
          subtype: DEFAULT
        scopes: []
        operations:
          -
            id: ""
            target: /orders
            verb: POST
            authType: Application & Application User
            throttlingPolicy: Unlimited
            scopes: []
            usedProductIds: []
            operationPolicies:
              request:
                -
                  policyName: addHeader
                  policyVersion: v2
                  policyType: common
                  policyId: b7adde73-ec49-4f3e-8c4b-dc57922315bb
                  parameters:
                    headerName: Test
                    headerValue: "1234"
              response:
                -
                  policyName: disableChunking
                  policyVersion: v1
                  policyType: common
                  policyId: a249d66e-bea6-4cf8-88fa-0e6e66f61582
                  parameters: {}
              fault: []
          -
            id: ""
            target: /menus
            verb: GET
            authType: Application & Application User
            throttlingPolicy: Unlimited
            scopes: []
            usedProductIds: []
            operationPolicies:
              request: []
              response: []
              fault: []
          -
            id: ""
            target: "/orders/{orderId}"
            verb: GET
            authType: Application & Application User
            throttlingPolicy: Unlimited
            scopes: []
            usedProductIds: []
            operationPolicies:
              request: []
              response: []
              fault: []
          -
            id: ""
            target: "/orders/{orderId}"
            verb: PUT
            authType: Application & Application User
            throttlingPolicy: Unlimited
            scopes: []
            usedProductIds: []
            operationPolicies:
              request: []
              response: []
              fault: []
          -
            id: ""
            target: "/orders/{orderId}"
            verb: DELETE
            authType: Application & Application User
            throttlingPolicy: Unlimited
            scopes: []
            usedProductIds: []
            operationPolicies:
              request: []
              response: []
              fault: []
        categories: []
        keyManagers:
          - all
        advertiseInfo:
          advertised: false
          apiOwner: admin
          vendor: WSO2
        gatewayVendor: wso2
        gatewayType: wso2/synapse
        asyncTransportProtocols: []
        egress: false
        organizationId: carbon.super
    ```


### Top-Level Fields

- **type**: Always set to `api`.
- **version**: Represents the API Manager version (e.g., `4.5.0`).

### Data Fields

- **id**: A unique identifier for the API in UUID format.
- **name**: The name of the API.
- **description**: A brief description of the API’s functionality or use case.
- **context**: The API context path, which is used to route API requests.
- **version**: The version number of the API (e.g., `1.0.0`).
- **provider**: The API provider’s name (e.g., `admin`).
- **lifeCycleStatus**: Indicates the current lifecycle status of the API (e.g., `PUBLISHED`, `CREATED`).
- **responseCachingEnabled**: Specifies if response caching is enabled (`true` or `false`).
- **cacheTimeout**: The time in seconds before cached responses expire.
- **hasThumbnail**: Specifies whether the API has an associated thumbnail (`true` or `false`).
- **isDefaultVersion**: Whether this API version is the default version (`true` or `false`).
- **isRevision**: Specifies whether the API is a revision of an older version (`true` or `false`).
- **revisionId**: The revision ID, used if the API is a revision.
- **enableSchemaValidation**: Indicates if schema validation is enabled (`true` or `false`).
- **enableSubscriberVerification**: Enables or disables subscriber verification for API requests (`true` or `false`).
- **type**: Defines the type of the API (e.g., `HTTP`, `WS`).
- **audiences**: The intended audiences of the API (e.g., `all`).
- **transport**: The list of supported transport protocols (e.g., `https`).
- **tags**: Tags used to categorize the API.
- **policies**: The subscription policies applied to the API (e.g., `Bronze`).
- **apiThrottlingPolicy**: The throttling policy applied at the API level.
- **authorizationHeader**: The name of the authorization header (e.g., `Authorization`).
- **apiKeyHeader**: The name of the API key header (e.g., `ApiKey`).
- **securityScheme**: The type of security scheme used by the API (e.g., `oauth_basic_auth_api_key_mandatory`, `oauth2`).
- **maxTps**: Maximum transactions per second allowed for the API in both production and sandbox environments.
- **visibility**: Specifies the visibility of the API (e.g., `PUBLIC`, `PRIVATE`).
- **visibleRoles**: List of roles allowed to access the API in the developer portal.
- **visibleTenants**: List of tenants with access to the API.
- **mediationPolicies**: A list of mediation policies applied to the API, typically for message transformation, logging, etc.
- **subscriptionAvailability**: Specifies the availability of the API for subscription (e.g., `CURRENT_TENANT`, `SPECIFIC_TENANTS`, `ALL_TENANTS`).
- **subscriptionAvailableTenants**: Specifies the tenants allowed to subscribe if `subscriptionAvailability` is set to `SPECIFIC_TENANTS`.
- **additionalProperties**: Custom properties associated with the API.
- **additionalPropertiesMap**: A map containing additional custom metadata.
- **accessControl**: The type of access control applied to the API.
- **accessControlRoles**: The roles that have permissions to view or modify the API (e.g., `internal/publisher`).
- **gatewayVendor**: The vendor of the API gateway (e.g., `WSO2`).
- **gatewayType**: The type of the API gateway used (e.g., `wso2/synapse`, `wso2/apk`).
- **asyncTransportProtocols**: List of supported asynchronous transport protocols, such as `HTTP` and `HTTPS`.
- **organizationId**: The ID of the organization associated with the API (e.g., `carbon.super`).
- **egress**: Configuration for egress. Can be `true` or `false` based on whether the API egress is enabled.
- **createdTime**: The timestamp when the API was created.
- **lastUpdatedTimestamp**: The timestamp when the API was last updated.
- **lastUpdatedTime**: The date and time when the API was last updated.

---

### **Business Information**

- **businessOwner**: The name of the business owner.
- **businessOwnerEmail**: The email of the business owner.
- **technicalOwner**: The name of the technical owner.
- **technicalOwnerEmail**: The email of the technical owner.

---

### **CORS Configuration**

- **corsConfigurationEnabled**: Indicates whether CORS (Cross-Origin Resource Sharing) is enabled for the API (`true` or `false`).
- **accessControlAllowOrigins**: List of allowed origins for CORS requests (e.g., `*` for all origins).
- **accessControlAllowCredentials**: Whether credentials are allowed for CORS requests (`true` or `false`).
- **accessControlAllowHeaders**: List of allowed headers in CORS requests (e.g., `authorization`, `Content-Type`).
- **accessControlAllowMethods**: List of allowed HTTP methods in CORS requests (e.g., `GET`, `POST`).

---

### **WebSub Subscription Configuration**

- **enable**: Specifies whether WebSub subscription is enabled for the API (`true` or `false`).
- **secret**: A secret used for signing WebSub content.
- **signingAlgorithm**: The algorithm used for signing WebSub messages (e.g., `SHA1`).
- **signatureHeader**: The header containing the WebSub signature.

---

### **Endpoint Configuration**

- **endpoint_type**: The type of the endpoint (e.g., `http`, `https`).
- **sandbox_endpoints**: List of sandbox endpoint URLs for the API.
- **production_endpoints**: List of production endpoint URLs for the API.

---

### **Operational Settings**

- **scopes**: List of scopes associated with the API. Scopes define the permission sets for API operations.
- **operations**: A list of operations exposed by the API, each having:
    - **id**: The unique identifier of the operation.
    - **target**: The target URL or path for the operation (e.g., `/orders`).
    - **verb**: The HTTP method for the operation (e.g., `GET`, `POST`).
    - **authType**: Specifies the type of authorization required for the operation (e.g., `Application & Application User`).
    - **throttlingPolicy**: The throttling policy applied to the operation.
    - **operationPolicies**: Policies applied for request, response, and fault handling during the operation.

---

### **Advertise Information**

- **apiOwner**: The owner of the API.
- **vendor**: The vendor providing the API (e.g., `WSO2`).