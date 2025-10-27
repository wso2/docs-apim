# Disable Subscription Requirement for an API

By default when you create and publish an API, subscriptions are mandatory for API consumption. But, there could be scenarios where an API Publisher might want to publish an API that does not require subscriptions for API consumption.

You can disable the subscription requirement for an API at any point after the creation of the API. However, it is recommended to do this before publishing the API in order to avoid any confusions among the consumers. Once the subscription requirement has been disabled, the gateway will not validate the subscription when an API request comes to the gateway.

To disable subscription validation requirement, deselect all the Business Plans (subscription policies) under the Business Plan section of the API in the Publisher portal and save the API.

[![Disable subscription validation]({{base_path}}/assets/img/design/advanced/disable-sub-validation.png)]({{base_path}}/assets/img/design/advanced/disable-sub-validation.png)

!!! info
    Once the subscription validation has been disabled, you can invoke the API with any valid OAuth token. The OAuth token can be either associated with an application in the devportal or a token obtained directly from a key manager that has been registered with APIM as a third party key manager.

!!! warning
    Disabling subscription requirement for an API means that the API will be overly permissive as neither Subscription Level nor Application Level rate limiting will be applicable. Please make sure you apply proper Advanced (API or Resource level) rate limiting policies to secure your APIs.

#### Re-enable subscription requirement for an API

To enable subscription requirement for an API, you simply have to save the API after specifying a business plan from the Publisher.

!!! warning
    Please note that re-enabling subscription validation can have an impact on the existing API consumers. If someone is consuming the API using a token associated with an Application in the Developer Portal, they should be able to continue using the API without any disruptions. However, those who use tokens obtained directly from the IdP will face disruption due to subscription validation failures.

#### Prevent disabling subscription requirement for an API

API Manager supports disabling subscription requirement for APIs by default. However, if you want to prevent API Publishers from doing this, you can use the following configuration to disable this capability on a global level.

```toml
[apim.key_manager]
allow_subscription_validation_disabling = false
```

You can further control this capability on a tenant level using the `tenant-conf.json` through the Admin portal.

```json
"AllowSubscriptionValidationDisabling" = false
```
