#Basic Architecture and Key Components

![Basic Architecture]({{base_path}}/assets/img/get_started/basic-architecture.png)

## Management Plane

The management plane is where API creation and API management takes place.  It consists of portals (publisher, developer portal, admin portal) for users to create and manage APIs, implement rate-limiting policies, monitor and monetization, etc. It also provides a set of APIs to interact with external tools like API Controller. The management plane includes API Analytics dashboards, displaying various business insights. . 

### Components

#### API Publisher

![API Publisher]({{base_path}}/assets/img/learn/overviewpage-rest-api.jpg)

WSO2 API Manager’s API Publisher is a state-of-the-art GUI based tool for API development and management. The GUI is designed for API creators to develop, document, secure, test, and version APIs with ease. It’s also able to cater to more API management-related tasks such as publishing APIs, monetizing APIs, and applying rate-limiting policies.

#### API Developer Portal

![Developer Portal]({{base_path}}/assets/img/get_started/developer-portal-overview.png)

The Developer Portal is a state-of-the-art web interface that allows API publishers to host and advertise their APIs while allowing API consumers to self-register, discover, evaluate, subscribe to and consume APIs securely and easily.


#### API Analytics

![API Analytics]({{base_path}}/assets/img/get_started/analytics.png)

Monitoring and analytics of APIs deployed on WSO2 API Manager are provided by the WSO2 API Manager Analytics component. This component includes different types of dashboards to provide more detailed different statistical views of your APIs. Furthermore, you can secure your system by configuring alerts and notifications on pre-determined events to identify any unusual behaviors in near real-time.  For more information, see Working with Analytics.


## Data Plane

Data plane is where the created API is exposed to the public consumers and acts as the proxy for API calls. This also provides additional capabilities such as enforcing security, rate limiting etc. (policy enforcement point).

### Components

#### API Gateway

![API Gateway]({{base_path}}/assets/img/learn/gateway-overview.png)

WSO2 API Gateway acts as the entry point for an API request made to an API managed by WSO2 API Manager.

JWT token validation is done by the API Gateway. The API Gateway validates it's signature and subscription using the information it has in it's an in-memory map. This in-memory map includes API-related information, application-related information, subscription-related information, etc. which is updated each time an artifact (API/application) is updated.
  
 Once the token is validated, the API Gateway acts upon the API request before sending it to the backend. It first processes the message to a pre-configured format (e.g. JSON/XML/CSV/etc.).  It then applies security policies, rate-limiting policies,  collects statistics, etc., via its handlers.  The mediators then act upon the API payload based on the mediation logic developed. The message is then formatted to a pre-configured format (e.g.JSON/XML/CSV/etc.) and sent to the backend. The WSO2 API Gateway supports transports such as HTTP, HTTPS, etc. It is also able to scale on-demand in cloud environments and is easily pluggable in non-cloud environments. 
 
## Control Plane
 
 Control plane is where the API security validation, API key generation and rate limiting decisions are taken.
 
### Components
 
#### Key Manager
 
 ![Key Manager]({{base_path}}/assets/img/get_started/key-manager-overview.png)

 The Key Manager is the identity provider for WSO2 API Manager and acts as the Secure Token Service(STS). WSO2 API Manager supports OAuth2.0, Basic Auth, Mutual SSL as well as API-Key based authentication mechanisms. 
 
 In WSO2 API Manager, tokens are generated for an application. The Key manager provides a token API to generate access tokens. These tokens can be used by clients to invoke APIs exposed by WSO2 API Manager. The Key Manager also exposes a revoke token API that clients can use to revoke an access token. A client can generate an OAuth2.0 access token by invoking the token API directly or via the Developer Portal UI. Alternatively, an API Key can be generated through the Developer Portal without calling the Key Manager. The API Key is a self-signed JWT token. When a client invokes an API with an OAuth2.0 access token or an API Key, the Gateway validates the token by validating its signature and subscription.
 
 The Key Manager performs scope validation as well. It could also generate JWT tokens to pass end user attributes to the backend, if configured. 
 
 In addition to using the built-in Key Manager as the IDP, WSO2 API Manager also supports integrating with third-party IDPs such as Okta, Auth0, KeyCloak, etc., for OAuth2.0 based security for APIs.
 
#### Traffic Manager
 
  ![Traffic Manager]({{base_path}}/assets/img/get_started/traffic-manager-overview.png)
 
The Traffic Manager helps users to regulate API traffic, make APIs and applications available to consumers at different service levels, and secure APIs against security attacks. The Traffic Manager features a dynamic throttling engine to process throttling policies in real-time, including rate-limiting of API requests. 

In addition to the above, the traffic manager also helps to keep the API Gateway's in-memory map, used for key-validation, up-to-date via a JMS topic. The traffic manager publishes artifact(API/application) update events received from the API Publisher and API Developer Portal to a JMS topic. The  API Gateway receives these events via the JMS topic and updates its in-memory map.

For more information, see Working with Throttling.
