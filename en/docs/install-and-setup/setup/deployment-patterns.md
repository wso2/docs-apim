# WSO2 API Manager Deployment Patterns


## Pattern 1: Single node (all-in-one) deployment

[![Single node deployment]({{base_path}}/assets/img/setup-and-install/1-single-node-deployment.png)]({{base_path}}/assets/img/setup-and-install/1-single-node-deployment.png)

You can use this pattern when you are working with low throughput.

## Pattern 2: Deployment with a separate Gateway and separate Key Manager

[![Deployment with a separate Gateway and separate Key Manager]({{base_path}}/assets/img/setup-and-install/2-separate-gateway-and-key-manager.png)]({{base_path}}/assets/img/setup-and-install/2-separate-gateway-and-key-manager.png)

You can use this pattern when you require a high throughput scenario that requires a shorter token lifespan.

## Pattern 3: Fully distributed setup

[![Fully distributed setup]({{base_path}}/assets/img/setup-and-install/3-fully-distributed-setup.png)]({{base_path}}/assets/img/setup-and-install/3-fully-distributed-setup.png)

You can use this pattern to maintain scalability at each layer and higher flexibility at each component.

## Pattern 4: Internal and external (on-premise) API Management

[![Internal and external API-M]({{base_path}}/assets/img/setup-and-install/4-internal-and-external.png)]({{base_path}}/assets/img/setup-and-install/4-internal-and-external.png)

You can use this pattern when you require a separate internal and external API Management with separate Gateway instances.

## Pattern 5: Internal and external (public and private cloud) API Management

[![Internal and external (public and private cloud) API-M]({{base_path}}/assets/img/setup-and-install/internal-public-and-private-cloud.png)]({{base_path}}/assets/img/setup-and-install/internal-public-and-private-cloud.png)

You can use this pattern when you wish to maintain a cloud deployment as an external API Gateway layer.
