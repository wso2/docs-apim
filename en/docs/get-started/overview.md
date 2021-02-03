# Overview

WSO2 API Manager is a fully open-source solution for end to end API Management in the cloud, on-prem or in hybrid environments. It comes with an [Apache Software License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0) which makes it **free to use**. It allows API developers to design, publish, and manage the lifecycle of APIs and API product managers to create API products from one or more APIs. It hosts an application developer portal which helps in building and managing a developer community for your APIs. Its cloud-native API gateway is used for securing, routing, controlling and monitoring your API traffic in a scalable manner.

## **What is the WSO2 API Manager** ?

WSO2 API Manager is the only 100% open-source product that addresses all aspects of API management including API development, productization, consumption, security, rate limitation, monetization and analytics.

![]({{base_path}}/assets/attachments/103327648/103346653.png)
In brief, the WSO2 API Manager consists of 6 main components, the [API Publisher,](#api-publisher) the [API developer Portal,](#developer-portal) [API Gateway](#api-gateway) (now comes as a [API Microgateway](https://mg.docs.wso2.com/en/3.2.0/) as well ), [Key Manager,](#key-manager) [Traffic Manager](#traffic-manager) and the [API Analytics](#analytics). For more information on these components see [Basic Architecture and Key Components]().

The key features of the product are listed below.

## Key Features

-  Design and Prototype APIs
-  Publish API Products and Govern the Use of APIs
-  Control Access and Enforce Security
-  Developer Portal
-  Manage Developer Community
-  Manage and Scale API Traffic
-  Monitor and Monetize
-  Pluggable, Extensible, and Themeable
-  Easily Deployable in Your Enterprise
-  WSO2 Platform Multi-Tenancy Support
-  Multiple Key Manager Support

## Basic Architecture and Key Components

The WSO2 API Manager consists of 6 main components, the [API Publisher,](#api-publisher) the [API Developer Portal,](#developer-portal) [API Gateway](#api-gateway) (now comes as an [API Microgateway](https://mg.docs.wso2.com/en/3.2.0/) as well ), [Key Manager,](#key-manager) [Traffic Manager](#traffic-manager) and the [API Analytics](#analytics). A component is made up of one or more [OSGi](http://www.osgi.org/Technology/Home) bundles. A bundle is the modularization unit in OSGi, similar to a JAR file in Java.

The component architecture of the WSO2 API Manager is illustrated in the diagram below.

#### API Publisher

![]({{base_path}}/assets/attachments/103327648/126556771.png)

API development is usually done by someone who understands the technical aspects of the API, interfaces, documentation, versions etc., while API management is typically carried out by someone who understands the business aspects of the APIs. In most business environments, API development is a responsibility that is distinct from API publication and management.

WSO2 API Manager provides a state-of-the-art web interface called **WSO2 API Publisher** for API development and management. It is a structured GUI designed for API creators to develop, document, scale and version APIs, while also facilitating more API management-related tasks such as publishing API, monetizing APIs, and promoting.

The diagram above shows the common lifecycle activities of an API developer/manager.

#### Developer Portal

![]({{base_path}}/assets/attachments/103327648/126556772.png)

The Developer Portal is a state-of-the-art web interface that allows API publishers to host and advertise their APIs while allowing API consumers to [self-register]({{base_path}}/learn/consume-api/customizations/customizing-the-developer-portal/enabling-or-disabling-self-signup), discover, evaluate, subscribe to and consume APIs.


The diagram above shows common API consumer lifecycle activities:

#### API Gateway

The API Gateway is a runtime, backend component (an [API proxy](https://docs.wso2.com/display/EI611/Working+with+APIs) ) developed using [WSO2 ESB]({{base_path}}/getting-started/about-this-release/). API Gateway secures, protects, manages, and scales API calls. It intercepts API requests, applies policies such as throttling and security using handlers, and manages API statistics. Upon validation of a policy, the Gateway passes web service calls to the actual backend. If the service call is a token request, the Gateway passes it directly to the [Key Manager](#key-manager).

The API Gateway supports OAuth 2.0, JWT, Basic Auth, Mutual SSL as well as API-Key based authentication mechanisms the above-mentioned authentication mechanisms and enables IT organizations to enforce rate limits and throttling policies.

When WSO2 API Manager is running, you can access the Gateway using the following URL: <https://localhost:9443/carbon>. You can integrate a monitoring and analytics component to the API Manager by [configuring WSO2 API Manager Analytics]({{base_path}}/learn/analytics/configuring-apim-analytics). This component provides reports, statistics and graphs on the APIs deployed in WSO2 API Manager. You can also configure alerts to monitor these APIs and detect unusual activity, manage locations via geo location statistics and, carry out detailed analysis of the logs.

!!! note
    Although the API Gateway contains ESB features, it is recommended not to use it for ESB-specific tasks. Its intended to be used only for Gateway functionality related to API invocations. For example, if you want to call external services like SAP, use a separate [ESB cluster](https://docs.wso2.com/display/EI650/Clustering+the+ESB+Profile) for that purpose.

#### Key Manager

![]({{base_path}}/assets/img/get_started/key-manager.png)


The Key Manager manages all clients, security and access token-related operations. The Gateway connects with the Key Manager to check the validity of access tokens, subscriptions and API invocations. The Key Manager also provides a token API to generate access tokens that can be accessed via the Gateway. The Key Manager supports OAuth 2.0, JWT, Basic Auth, Mutual SSL as well as API-Key based authentication mechanisms. 


 To generate an access token, a Subscriber first creates an application on the Developer Portal and generates an access token for the application. Behind the scenes, the Developer Portal makes a token generation request to the API Gateway. The API Gateway then, requests for an access token from the Key Manager. Upon receiving the request, the Key Manager creates an OAuth client and generates an access token. This access token is sent back to the Developer Portal via the API Gateway. 
 
 Similarly, to validate a token, the API Gateway calls the Key Manager, which fetches and validates the token details from the database.

You can avoid making the Gateway connect with the Key Manager every time it receives an API invocation call, by enabling API Gateway [caching]({{base_path}}/administer/product-configurations/configuring-caching). When caching is not enabled, a verification call happens every time the Gateway receives an API invocation call. For this verification, the Gateway passes an access token, the API, and API version to the Key Manager. Communication between the API Gateway and the Key Manager happens in either of the following ways:

-   Through a Web service call

 The Key Manager properly decouples the operations for creating OAuth applications and validating access tokens so that you can even plug in a third party-authorization server for key validations. In a typical production environment, you can configure one of the following setups:

-   Configure a WSO2 API Manager instance as the Key Manager in a separate server. See [Product Profiles]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/product-profiles).
-   Configure an instance of WSO2 Identity Server as the Key Manager. See [Configuring WSO2 Identity Server as the Key Manager]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/configuring-wso2-identity-server-as-a-key-manager).
-   Configure a third-party authorization server for key validations and an API Manager instance for the rest of the key management operations. See [Configuring a Third-Party Key Manager]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/configure-a-third-party-key-manager).

#### Traffic Manager

![]({{base_path}}/assets/img/get_started/traffic-manager.png)

The Traffic Manager helps users to regulate API traffic, make APIs and applications available to consumers at different service levels, and secure APIs against security attacks. The Traffic Manager features a dynamic throttling engine to process throttling policies in real-time, including rate-limiting of API requests. For more information, see [Working with Throttling]({{base_path}}/learn/rate-limiting/introducing-throttling-use-cases).

#### Streaming Integrator

![]({{base_path}}/assets/img/get_started/streaming-integrator.png)

The Streaming Integrator allows API Manager to publish streaming data via the API Publisher asynchronously. It can also consume APIs to perform stream processing on API data as well as to expose API data to streaming applications.

#### Analytics

![]({{base_path}}/assets/attachments/103327648/126556775.png)
![]({{base_path}}/assets/img/get_started/analytics.png)

Additionally, monitoring and analytics are provided by the analytics component, WSO2 API Manager Analytics. This component provides a host of statistical graphs and an alerting mechanism on pre-determined events. For more information, see [Working with Analytics]({{base_path}}/learn/analytics/configuring-apim-analytics).

