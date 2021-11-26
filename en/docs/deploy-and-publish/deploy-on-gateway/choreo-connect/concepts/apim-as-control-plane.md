# Choreo Connect with API Manager as Control Plane

## Overview

Choreo Connect can connect to WSO2 API Manager (WSO2 API-M), which is running on cloud or on-premise. You can configure Choreo Connect to connect with API-M as the Control Plane, so that the user actions, such as API deploying, application creation, key generation, subscription creation, etc. are received by Choreo Connect seamlessly.

[![Choreo Connect Overview]({{base_path}}/assets/img/deploy/mgw/choreo-connect-overview.png){: style="width:80%"}]({{base_path}}/assets/img/deploy/mgw/choreo-connect-overview.png)

## Workflow When Deploying an API

The following are the sequece of actions that take place when an API is deployed via the WSO2 API Manager Publisher Portal in Choreo Connect.

1. You need to configure the `[controlPlane]` Choreo Connect configuration section to point to WSO2 API Manager.
2. You need to create a revision of the API via the API Manager Publisher Portal.
3. You need to select Choreo Connect as the Gateway environment and deploy the API.
4. The API Manager [Event Hub]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/event-hub) component will send an API deploy event to the Adapter component in Choreo Connect.
5. The Adapter will pull the API object from the Event Hub upon receiving the API deploy event.
6. The Adapter will pass the API to the Router and Enforcer.

## See Also

- [Event Hub]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/event-hub)
- [Rate Limiting in Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/cc-rate-limiting)
- [Revoked Tokens in Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/revoked-tokens)
- [Working with third party Key Managers in Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/third-party-key-managers})
