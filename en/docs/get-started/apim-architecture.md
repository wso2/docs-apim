# Architecture and Key Components

The diagram below is a high-level snapshot of WSO2 API Manager and the various components that it can works with. 

[![Basic Architecture]({{base_path}}/assets/img/get_started/architecture/apim-architecture-final.png)]({{base_path}}/assets/img/get_started/architecture/apim-architecture-final.png)

<!--The above diagram consists of an API management layer and an integration layer where the above components all fit into and mesh together to address the various use cases of the product. The API management layer contains several components, which you can use in your deployment according to your requirement. The integration layer includes either the Micro Integrator runtime (for services integration) and the Streaming Integrator runtime (for streaming requirements) or both runtimes. For details on deployment patterns, see [Deployment Overview]({{base_path}}/install-and-setup/setup/deployment-overview/). The pattern you use would depend on the workload of each component and the traffic that is expected for each of the components and runtimes.-->

## API Control Plane

The API Control Plane is where API creation and API management takes place. It consists of portals (Publisher, Developer Portal and Service Catalog) for users to create and manage APIs, implement rate limiting policies, monitor, and monetize. The API Control Plane consists of a Key Manager component for API security validation and API key generation. It also provides a set of APIs to interact with external tools like API Controller. The API Control Plane includes API Analytics dashboards, displaying various business insights.

#### API Publisher

[![API Publisher]({{base_path}}/assets/img/get_started/architecture/publisher-overview.png)]({{base_path}}/assets/img/get_started/architecture/publisher-overview.png)

WSO2 API Control Plane's API Publisher is a state-of-the-art GUI based tool for API development and management. The GUI is designed for API creators to develop, document, secure, test, and version APIs with ease. It’s also able to cater to more API management-related tasks such as publishing APIs, monetizing APIs, and applying rate limiting policies.

#### API Developer Portal

[![Developer Portal]({{base_path}}/assets/img/get_started/architecture/developer-portal-overview.png)]({{base_path}}/assets/img/get_started/architecture/developer-portal-overview.png)

The Developer Portal is a state-of-the-art web interface that allows API publishers to host and advertise their APIs while allowing API consumers to self-register, discover, evaluate, subscribe to, and consume APIs securely and easily.

#### Service Catalog

[![Service Catalog]({{base_path}}/assets/img/get_started/architecture/service-catalog.png)]({{base_path}}/assets/img/get_started/architecture/service-catalog.png)

WSO2 API Control Plane includes a Service Catalog where developers can register their services in a RESTful manner. Service Catalog is one of the main attributes that enable the API-first Integration in WSO2 API Manager. Through the Service Catalog, integration services are made discoverable to the API Management layer so that API proxies can directly be created using them. 

These integration services can be created using WSO2 Integration Studio and a variety of other platforms. For an Integration Studio user, the service registration happens automatically when exporting the project as a composite application (CApp).

#### Key Manager
 
[![Key Manager]({{base_path}}/assets/img/get_started/architecture/key-manager-overview.png)]({{base_path}}/assets/img/get_started/architecture/key-manager-overview.png)

The Key Manager is the identity provider for WSO2 API Control Plane and acts as the Secure Token Service (STS). WSO2 API Control Plane supports OAuth 2.0, Basic Auth, Mutual SSL as well as API-Key based authentication mechanisms. 
 
In WSO2 API Control Plane, tokens are generated for an application. The Key Manager provides a token API to generate access tokens. These tokens can be used by clients to invoke APIs exposed by WSO2 API Control Plane. The Key Manager also exposes a revoke token API that clients can use to revoke an access token. A client can generate an OAuth 2.0 access token by invoking the token API directly or via the Developer Portal UI. Alternatively, an API Key can be generated through the Developer Portal without calling the Key Manager. The API Key is a self-signed JWT token. When a client invokes an API with an OAuth 2.0 access token or an API Key, the Gateway validates the token by validating its signature and subscription.
 
The Key Manager performs scope validation as well. It could also generate JWT tokens to pass end-user attributes to the backend, if configured. 
 
In addition to using the built-in Key Manager as the IDP, WSO2 API Control Plane also supports integrating with third-party identity providers such as Okta, Auth0, Keycloak, etc., for OAuth 2.0 based security for APIs.

#### API Analytics

- For information on the architecture, see [API Analytics Architecture]({{base_path}}/monitoring/api-analytics/analytics-overview/#architecture/)

- For information on working with Analytics, see the [API Analytics Getting Started Guide]({{base_path}}/monitoring/moesif-analytics/moesif-integration-guide/).

## Data Plane

The Data Plane is where the created API is exposed to the public consumers and acts as the proxy for API calls. This also provides additional capabilities such as enforcing security, rate limiting, etc. 

#### Universal Gateway

[![Universal Gateway]({{base_path}}/assets/img/learn/gateway-overview.png)]({{base_path}}/assets/img/learn/gateway-overview.png)

WSO2 Universal Gateway acts as the entry point for an API request made to an API managed by WSO2 API Manager.

The Universal Gateway does the JWT token validation by validating the signature, issuer, expiry time, and subscription. The subscription is validated using the in-memory map. This in-memory map includes API-related information, application-related information, subscription-related information, etc., and is updated each time an artifact (API/application) is updated.

Once the token is validated, the Universal Gateway acts upon the API request before sending it to the backend. It first processes the message to a preconfigured format (e.g., JSON, XML, CSV etc.).  It then applies security policies, rate limiting policies,  collects statistics, etc., via its handlers.  The mediators then act upon the API payload based on the mediation logic developed. The message is then formatted to a preconfigured format (e.g., JSON, XML, CSV, etc.) and sent to the backend. WSO2 Universal Gateway supports transports such as HTTP, HTTPS, etc. It is also able to scale on-demand in cloud environments and is easily pluggable in non-cloud environments. 

#### Kubernetes Gateway

WSO2 Kubernetes Gateway is WSO2's cloud-native API management platform. It is designed to help you build, deploy, and manage APIs in a cloud environment. This is built on top of a microservices architecture and uses containerization technologies to ensure scalability and flexibility. With features like automatic failover and load balancing, this platform is designed to be highly available and able to handle large numbers of API requests without performance degradation. There is added support for continuous delivery and deployment, so you can quickly and easily push updates to your API services. 

Please refer to the WSO2 Kubernetes Gateway [Quick Start Guide](https://apk.docs.wso2.com/en/1.3.0/get-started/quick-start-guide/) for trying out the product.

#### Immutable Gateway

Being an API Gateway for micro services, which is cloud-native, decentralized and developer centric, the WSO2 Immutable Gateway is a lightweight message processor for APIs. The Immutable Gateway is used for message security, transport security, routing, and other common API Management related quality of services.

Please refer to the WSO2 Immutable Gateway [documentation](https://mg.docs.wso2.com/en/latest/) for more details.
 
## Traffic Manager
 
[![Traffic Manager]({{base_path}}/assets/img/get_started/architecture/traffic-manager-overview.png)]({{base_path}}/assets/img/get_started/architecture/traffic-manager-overview.png)
 
The Traffic Manager helps users to regulate API traffic, make APIs and applications available to consumers at different service levels, and secure APIs against security attacks. The Traffic Manager features a dynamic throttling engine to process throttling policies in real-time, including rate limiting of API requests. 

In addition to the above, the Traffic Manager also helps to keep the Universal Gateway's in-memory map, which is used for key validation, up-to-date via a JMS topic. The Traffic Manager publishes artifact (API/application) update events that are received from the API Publisher and API Developer Portal to a JMS topic. The Universal Gateway receives these events via the JMS topic and updates its in-memory map.

For more information, see [Working with Throttling]({{base_path}}/manage-apis/design/rate-limiting/introducing-throttling-use-cases).

## Tooling

There are multiple developer-friendly tools that can be used to help you work with WSO2 API Manager.

#### API Controller

WSO2 API Controller (CTL) is a command-line tool for managing API Manager environments, listing APIs, API products and applications, creating API projects, importing and exporting APIs, API products and applications, generating tokens for APIs and API products for testing purposes, etc.
