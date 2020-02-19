# WSO2 API Manager deployment patterns

\[ [Pattern 1](#pattern-1-single-node-all-in-one-deployment) \] \[ [Pattern 2](#pattern-2-deployment-with-a-separate-gateway-and-separate-key-manager) \] \[ [Pattern 3](#pattern-3-fully-distributed-setup) \] \[ [Pattern 4](#pattern-4-internal-and-external-on-premise-api-management) \] \[ [Pattern 5](#pattern-5-internal-and-external-public-and-private-cloud-api-management) \]

## Pattern 1: Single node (all-in-one) deployment

![]({{base_path}}/assets/attachments/103334440/103334441.png)
You can use this pattern when you are working with a low throughput.

## Pattern 2: Deployment with a separate Gateway and separate Key Manager

![]({{base_path}}/assets/attachments/103334440/103334442.png)
You can use this pattern when you require a high throughput scenario that requires a shorter token lifespan.

## Pattern 3: Fully distributed setup

![]({{base_path}}/assets/attachments/103334440/103334445.png)
You can use this pattern to maintain scalability at each layer and higher flexibility at each component.

## Pattern 4: Internal and external (on-premise) API Management

![]({{base_path}}/assets/attachments/103334440/103334444.png)
You can use this pattern when you require a separate internal and external API Management with separated Gateway instances.

## Pattern 5: Internal and external (public and private cloud) API Management
![]({{base_path}}/assets/attachments/103334440/103334443.png)
You can use this pattern when you wish to maintain a cloud deployment as an external API Gateway layer.
