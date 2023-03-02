# Choreo Connect with API Manager as Control Plane

## Overview

Choreo Connect can connect to WSO2 API Manager (WSO2 API-M), which is running on cloud or on-premise. You can configure Choreo Connect to connect with API-M as the Control Plane so that the user actions, such as API deploying, application creation, key generation, subscription creation, etc., are received by Choreo Connect seamlessly.

[![Choreo Connect Overview]({{base_path}}/assets/img/deploy/mgw/choreo-connect-overview.png){: style="width:80%"}]({{base_path}}/assets/img/deploy/mgw/choreo-connect-overview.png)

## Workflow when deploying an API

To deploy an API via API-M you need to,

1. Configure the `[controlPlane]` Choreo Connect configuration section to point to WSO2 API Manager.

2. Create a revision of the API via the API Manager Publisher Portal.

3. Select Choreo Connect as the Gateway environment and deploy the API.

Once an API is deployed to Choreo Connect via the WSO2 API Manager Publisher Portal, the following sequence of actions will take place.

1. The API Manager [Event Hub]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/event-hub) component will send an API deploy event to the Adapter component in Choreo Connect.

2. The Adapter will pull the API object from the Event Hub upon receiving the API deploy event.

3. The Adapter will pass the API to the Router and Enforcer.

## See Also

- [Event Hub]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/event-hub)
- [Rate Limiting in Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/cc-rate-limiting)
- [Revoked Tokens in Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/revoked-tokens)
- [Working with third party Key Managers in Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/third-party-key-managers/)
