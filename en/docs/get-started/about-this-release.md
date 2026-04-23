# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.7.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.6.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/get-started/overview/).

## Downloads

<a href="https://wso2.com/api-manager/#"><img src="{{base_path}}/assets/img/get_started/download-apim.png" title="Download WSO2 API Manager" width="25%" alt="Download WSO2 API Manager"/></a>

## New Features


??? note "API Platform Gateway Integration"

    WSO2 API Manager introduces integration with the API Platform Gateway, enabling modern gateway capabilities while allowing APIM to act as the centralized control plane.

    - **Envoy-based gateway support**: Leverage modern gateway features such as HTTP/2 and HTTP/3 in on-prem deployments.
    - **APIM as control plane**: Manage gateway registration, configuration, API deployments, and policies directly from API Manager.
    - **Unified gateway model**: Use a single gateway implementation across cloud and on-prem environments.

    **[Learn more]({{base_path}}/api-gateway/universal-gateway/getting-started)**

??? note "API-Bound API Keys with Enhanced Security and Access Control"

    WSO2 API Manager introduces enhanced API key capabilities with improved visibility, security, and lifecycle control, enabling more fine-grained and secure API access management.

    - **API-bound API keys**: Generate API keys scoped to a specific API, preventing misuse across multiple APIs.
    - **Improved access control**: Enforce subscription validation, ensuring API keys are used only with valid subscriptions.
    - **Lifecycle management**: Define validity periods and manage API key generation and association with applications.
    - **Advanced security restrictions**: Restrict API key usage based on IP addresses or HTTP referrers.

    **[Learn more]({{base_path}}/api-security/runtime/api-authentication/secure-apis-using-api-keys)**

??? note "Symmetric Encryption Support"

    WSO2 API Manager adopts symmetric key encryption as the default mechanism for securing sensitive data, improving security, performance, and operational simplicity.

    - **Default symmetric encryption**: Uses AES-256 (GCM mode) for encrypting sensitive data across the platform.
    - **Enhanced security posture**: Provides strong protection for credentials, tokens, and configuration secrets.
    - **Broad coverage**: Secures backend credentials, API keys, tokens, user store data, and policy-related secrets.
    - **APICTL Enhancement**: Supports symmetric key encryption for creating secrets using an initialized encryption key.  
    - **Cipher Tool and Secure Vault**: Encrypt configuration secrets using symmetric encryption and support key rotation and password updates through symmetric cryptography.  

    **[Learn more]({{base_path}}/install-and-setup/setup/security/encryption/symmetric-encryption)**

??? note "Support for Multiple Client Secrets in OAuth Applications"

    WSO2 API Manager now supports multiple client secrets per application, enabling improved credential management and enhanced security for OAuth applications.

    - **Multiple client secrets**: Generate and manage multiple consumer secrets for a single application.
    - **Secure handling**: Secrets are displayed only at creation time and masked thereafter for security.
    - **Flexible token generation**: Access tokens can be generated using any valid client secret.
    - **Configurable limits**: Control the number of allowed client secrets or disable the feature via configuration.
    
    **[Learn more]({{base_path}}/api-developer-portal/manage-application/generate-keys/generate-api-keys)**

??? note "AsyncAPI 3.0.x Specification Support"

    WSO2 API Manager introduces support for the AsyncAPI 3.0.x specification, enabling improved modeling and management of event-driven APIs while maintaining backward compatibility with existing definitions.

    - **AsyncAPI 3.0.x support**: Create and manage event-driven APIs using the latest AsyncAPI 3.0.x specification.
    - **Backward compatibility**: Import and work with existing AsyncAPI 2.x definitions without disruption.
    - **Standardized API creation**: All newly created Async APIs are based on the AsyncAPI 3.x specification.

    **[Learn more]({{base_path}}/api-design-manage/design/create-api/create-streaming-api/create-a-streaming-api-from-an-asyncapi-definition)**

??? note "MCP Governance"

    WSO2 APIM introduces governance support for MCP Servers, enabling users to define rulesets for MCP artifacts in addition to REST APIs and Async APIs.
    
    - Enforce ruleset-attached policies on MCP Servers in either synchronous or asynchronous mode.

    **[Learn more]({{base_path}}/administer/governance/governance-concept)**

??? note "MCP Analytics"

    WSO2 API Manager introduces MCP-aware analytics, enabling deeper visibility into Model Context Protocol (MCP) interactions with structured, protocol-specific insights.

    - **Protocol-aware analytics**: Capture MCP-specific data such as JSON-RPC methods, tool usage, and session information.
    - **Tool-level visibility**: Analyze usage patterns, latency, and failure rates of individual MCP tools.
    - **Enhanced observability**: Monitor MCP interaction patterns, client behavior, and protocol-level metrics.
    - **Structured analytics model**: Publish MCP-specific fields in a standardized format for accurate querying and dashboards.
    - **Minimal performance impact**: Analytics data is collected from existing context and published asynchronously.

    **[Learn more]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-analytics-dashboards)**

??? note "Asgardeo Key Manager Support"

    WSO2 API Manager introduces support for integrating Asgardeo as a third-party Key Manager using a dedicated connector.

    - **Out-of-the-box integration**: Easily connect to Asgardeo using the provided connector.
    - **Scope and role management**: Supports managing scopes and roles through Asgardeo integration.

    **[Learn more]({{base_path}}/api-security/key-management/third-party-key-managers/configure-asgardeo-connector/)**

??? note "Semantic Tool Filtering Guardrail"

    WSO2 API Manager introduces semantic tool filtering as a guardrail to ensure that only contextually relevant tools are available during AI-driven interactions.

    - **Context-aware filtering**: Filters tools based on the semantic relevance of the user request.
    - **Flexible selection modes**: Supports selection by rank (top-N) or by threshold (similarity score).
    - **Multiple embedding provider support**: Works with different embedding providers.

    **[Learn more]({{base_path}}/ai-gateway/ai-guardrails/semantic-tool-filtering-guardrail/)**

??? note "Multi-Model Routing Policies"

    WSO2 API Manager introduces new policies to support multi-model routing, enabling dynamic selection of models based on request context and defined strategies.

    - **Intelligent Model Routing**: Selects the most suitable model based on predefined criteria and runtime conditions. **[Learn more]({{base_path}}/ai-gateway/multi-model-routing/intelligent-model-routing/)**
    - **Semantic Model Routing**: Routes requests to models based on semantic relevance. **[Learn more]({{base_path}}/ai-gateway/multi-model-routing/semantic-model-routing/)**
    
## Improvements

??? note "Build and Runtime Compatibility with JDK 21"

    WSO2 API Manager now supports JDK 21 for both build and runtime environments, enabling improved performance, long-term support (LTS), and enhanced security. This ensures compatibility with modern Java ecosystems while maintaining stability for enterprise deployments.

    Key Capabilities:

    - **Full JDK 21 support**: Build and run API Manager using JDK 21.
    - **Improved performance**: Benefit from JVM optimizations and enhanced garbage collection.
    - **Enhanced security**: Leverage latest Java security updates and standards.
    - **Future-ready platform**: Align with latest LTS version for long-term maintainability.

??? note "Optimized Token Generation by Disabling JWT Persistence by Default"

    WSO2 API Manager optimizes OAuth2 token handling by disabling JWT token persistence by default, improving performance and scalability in high-throughput environments.

    - **No JWT persistence by default**: JWT access and refresh tokens are not stored in the database, reducing storage overhead.
    - **Improved performance**: Eliminates database interactions during token generation, increasing throughput and reducing latency.
    - **Better scalability**: Supports large-scale deployments with high token generation rates without database bottlenecks.
    - **Configurable behavior**: Option to enable token persistence if required for specific use cases.

    **[Learn more]({{base_path}}/api-security/key-management/tokens/token-persistence/)**

??? note "Enhanced SOAP API Experience in the Developer Portal"

    WSO2 API Manager enhances the developer experience for SOAP APIs by improving accessibility and visibility of service definitions.

    - **WSDL access via URL**: Access WSDL of a SOAP API through a direct URL without needing to manually download them, enabling seamless integration with tools like SOAPUI.
    - **SOAP operations visibility**: View available SOAP operations directly in the Developer Portal Documents section without inspecting the WSDL manually.

    **[Learn more]({{base_path}}/api-developer-portal/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-a-soap-client)**

## Compatible WSO2 product versions

{!includes/compatibility-matrix.md!}

## **Key Changes**

Before upgrading to WSO2 API Manager 4.7.0, review the following architectural and behavioral changes that may impact your deployment, integrations, and runtime behavior:

### JDK 21 and 25 Are the Only Supported Versions

WSO2 API Manager 4.7.0 requires **JDK 21 or JDK 25** to run. Older JDK versions are no longer supported.

* JDK versions prior to 21 are **not supported** and will not work with this release.
* Ensure your environment is running **JDK 21** or **JDK 25** before upgrading.

**Impact:**

* Deployments running on JDK 11 or JDK 17 must upgrade their JDK before migrating to API Manager 4.7.0.

### Control Plane Resource Access Restricted by Default

Starting from 4.7.0, control plane resource access via the Tomcat valve follows a **default deny** model instead of the previous permissive behavior.

* Access to control plane endpoints (port `9443` by default) is now **denied by default** unless explicitly allowed.
* Only resources defined under `<ResourceAccessControl>` or configured via `deployment.toml` are accessible.
* This change primarily affects **custom or non-standard endpoints** exposed on the control plane.

**Default allowed endpoints include:**

* `/admin`
* `/publisher`
* `/devportal`
* `/client-registration`
* `/keymanager-operations`
* `/api/am/publisher`
* `/api/am/devportal`
* `/api/am/admin`
* `/api/am/gateway`
* `/api/am/service-catalog`
* `/api/am/devops`
* `/api/am/governance`
* `/internal/data`
* `/usage-data-receiver`
* `/registry/resourceContent`
* `/acs`

**Migration / Configuration:**

To allow additional resources, configure them explicitly:

```toml
[[resource.access_control]]
context = "(.*)/pattern(.*)"
secure = true
http_method = "all"
```

* Set `secure` based on transport requirements.
* Use `http_method` such as `GET`, `POST`, or `all`.

**Impact:**

* Requests to undeclared control plane resources will be **blocked by default**.
* Existing deployments relying on previously accessible endpoints may experience failures after upgrade.
* Custom endpoints must be explicitly **allowlisted** to remain accessible.
* Strengthens security by preventing unintended exposure of internal endpoints.

### API Key Behavior Changes

Starting from 4.7.0, API Manager generates **API-bound API keys by default**, replacing the previous application-bound model.

* API keys are now **scoped to a specific API**, preventing reuse across multiple APIs.
* All API keys are now generated in an **opaque format**. JWT-based API keys are no longer issued.
* Application-bound API keys are **disabled by default** and treated as **legacy**.
* Existing JWT-based keys will continue to function without interruption.

**Migration / Configuration:**

To re-enable legacy application-bound keys:

```toml
[apim.devportal]
enable_legacy_api_keys = true
```

**Impact:**

* Improved security and isolation per API.
* Systems relying on application-level key reuse must be redesigned.
* JWT-based key validation logic should be reviewed and updated.

### Default Encryption Mechanism Updated

The default encryption mechanism has changed from **RSA-based asymmetric encryption** to **symmetric encryption (AES/GCM/NoPadding)** .

* Uses a **shared encryption key** instead of keystore-based encryption.
* Requires explicit key configuration before startup.

**Migration / Configuration:**

To use the new default:

```toml
[encryption]
key = "<64-character-hexadecimal-key>"
```

To retain old behavior:

```toml
[keystore]
userstore_password_encryption = "InternalKeyStore"

[system.parameter]
'org.wso2.CipherTransformation' = "RSA/ECB/OAEPwithSHA1andMGF1Padding"

[encryption]
internal_crypto_provider = "org.wso2.carbon.crypto.provider.KeyStoreBasedInternalCryptoProvider"
```

**Impact:**

* Improved performance and simplified key management.
* **Mandatory key configuration before startup** (otherwise startup failure).
* Requires **data migration / key rotation** when switching models.
* All nodes must share the same key in distributed setups.

### Token Persistence Disabled by Default

JWT token persistence is **disabled by default** to improve performance and scalability.

* Tokens are **not stored in the database** during generation.
* Each request generates a **new access + refresh token pair**.
* JWTs are used for both access and refresh tokens.

**Migration / Configuration:**

To revert to previous behavior:

```toml
[oauth.token_persistence]
enable=true

[oauth.revoked_token_headers_in_response]
enable=true
```

**Impact:**

* Significant performance improvement and reduced DB load.
* Token reuse behavior changes.
* Logout/session invalidation **will not revoke tokens**.
* Not compatible with **Token Binding**.
* Custom JWT issuers must extend `ExtendedJWTTokenIssuer`.

### Secure XML Processing Enabled by Default

Secure XML processing is now enabled by default.

* **DTD processing and external entity expansion are disabled**.
* Protects against XXE and related attacks.

**Migration / Configuration:**

To revert:

```toml
[apim.mediation]
enable_secure_xml_processing = false
```

**Impact:**

* Stronger security by default.
* APIs relying on DTD/external entities must be updated.

### Improved Callback/Redirect URI Validation

Callback/redirect URI validation now enforces stricter regex handling.

* Literal character enforcement is enabled by default.
* Special characters like `.`, `?`, `+` are handled more strictly.

**Migration / Configuration:**

To revert:

```toml
[oauth.callback]
enforce_literal_characters = false
```

**Impact:**

* Prevents unintended wildcard matches.
* Existing regex-based configurations must be reviewed.

### Multipart Content-Type Handling Change

Content-Type headers in multipart requests are now preserved **as-is**.

* No automatic charset modification.

**Migration / Configuration:**

To restore previous behavior:

```toml
[message_formatter.options]
disableSendingMultipartPartCharset = false
```

**Impact:**

* Ensures consistency with client requests.
* Systems depending on auto charset injection must adjust.

### Multi-value Claim Handling (Token Exchange)

Multi-valued claims are now always handled correctly.

* Claims are preserved as **arrays**, not stringified.
* Legacy behavior is removed (no fallback).

**Impact:**

* Fixes incorrect claim formatting.
* Downstream systems expecting string format must be updated.

### AsyncAPI 3.0.x Support for Streaming APIs

Streaming APIs now support **AsyncAPI 3.0.x** by default.

* New APIs use AsyncAPI 3.0.x.
* Import supports both 2.x and 3.0.x.
* Existing APIs continue unchanged.

**Impact:**

* Aligns with modern event-driven standards.
* No breaking impact for existing APIs.

### Lambda Backend Invocation Payload Change

Starting from 4.7.0, request bodies are **no longer sent for HTTP GET and HEAD methods** when invoking Lambda backends.

* Request payload is included **only for methods that support a body** (e.g., POST, PUT, PATCH).
* GET and HEAD requests will **not include a request body**, even if previously sent as empty.

**Impact:**

* Aligns Lambda invocations with HTTP standards.
* Fixes non-standard behavior where empty bodies were sent for GET/HEAD requests.
* Lambda functions relying on the presence of a request body for GET/HEAD methods may require updates.
* Payload parsing logic in existing integrations should be reviewed.

### Removal of Java Security Manager support

The Java Security Manager has been removed as it was deprecated in Java 17 and fully removed in Java 21. WSO2 API Manager no longer supports or relies on the Java Security Manager for defining security policies. If your deployment previously used the `-Djava.security.manager` JVM flag or a `sec.policy` file, these configurations should be removed.

## Deprecations

### Application-Bound API Keys

Application-bound API keys are **deprecated** and disabled by default.

* API-bound keys are now the recommended approach.
* Can be temporarily re-enabled via configuration.

## Fixed issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue%20is%3Aclosed%20label%3AComponent%2FAPIM%20closed%3A2025-10-28..2026-04-03%20-label%3AResolution%2FInvalid%20-label%3AResolution%2FDuplicate%20-label%3A%22Resolution%2FNot%20a%20bug%22%20-label%3A%22Resolution%2FCannot%20Reproduce%22%20-label%3A%22Resolution%2FWon%E2%80%99t%20Fix%22)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue%20is%3Aclosed%20label%3AComponent%2FAPICTL%20closed%3A2025-10-28..2026-04-03%20-label%3AResolution%2FInvalid%20-label%3AResolution%2FDuplicate%20-label%3A%22Resolution%2FNot%20a%20bug%22%20-label%3A%22Resolution%2FCannot%20Reproduce%22%20-label%3A%22Resolution%2FWon%E2%80%99t%20Fix%22)

## Known issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPIM+is%3Aopen)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPICTL+is%3Aopen)
