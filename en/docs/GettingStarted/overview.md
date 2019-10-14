# Overview

In an age where organizations are becoming more and more "data-driven", exposing services & microservices via APIs is becoming the norm. These APIs are consumed by a wide range of devices for various day to day activities such as banking, shopping, smart solutions etc. In the recent past, the number of consumers, consuming these APIs have increased exponentially. This brings in new challenges for enterprises to deal with such as security of services,  maintaining APIs, managing APIs, enforcing policies etc. This is where an API Management solution is required. An API management solution manages the APIs by taking care of the exposure related complexities such as security, rate limiting, monitoring etc, while providing a platform to manage the APIs .

**The WSO2 API Manager is a high performant API Management solution** designed to solve this problem elegantly. It is the **only 100% open source** solution and comes with an [Apache Software License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0) which makes it **free to use** .

## **What is the WSO2 API Manager** ?

WSO2 API Manager is the only 100% open source product that addresses all aspects of API management including API creation, consumption, security, rate limitation, monetization and analytics. The WSO2 API Manager was named as **a leader in "The Forrester Wave™: API Management Solutions, Q4 2018."**

![]({{base_path}}/assets/attachments/103327648/103346653.png)
In brief, the WSO2 API Manager consists of 6 main components, the [API Publisher,](#api-publisher) the [API developer Portal,](#developer-portal) [API Gateway](#api-gateway) (now comes as a [API Microgateway](_API_Microgateway_) as well ), [Key Manager,](#key-manager) [Traffic Manager](#traffic-manager) and the [API Analytics](#analytics) . For more information on these components see [Basic Architecture and Key Components]() .

The key features of the product are listed below.

## Key Features

-   Design and Prototype APIs

-   Publish APIs and Govern API Use

-   Consume and Manage APIs

-   Manage and Scale API Traffic

-   Control Access and Enforce Security

-   Monitor and Monetize

-   Pluggable, Extensible, and Themeable

-   Easily Deployable in Your Enterprise

-   Manage Developer Community

## Competitive Advantage

  <TO-DO>

## Basic Architecture and Key Components

The WSO2 API Manager consists of 6 main components, the [API Publisher,](#api-publisher) the [API developer Portal,](#developer-portal) [API Gateway](#api-gateway) (now comes as a [API Microgateway](https://docs.wso2.com/display/SHAN/API+Microgateway) as well ), [Key Manager,](#key-manager) [Traffic Manager](#traffic-manager) and the [API Analytics](#analytics) . A component is made up of one or more [OSGi](http://www.osgi.org/Technology/Home) bundles. A bundle is the modularization unit in OSGi, similar to a JAR file in Java.

The component architecture of the WSO2 API Manager is illustrated in the diagram below.

-   #### API Publisher

![]({{base_path}}/assets/attachments/103327648/126556771.png)

API development is usually done by someone who understands the technical aspects of the API, interfaces, documentation, versions etc., while API management is typically carried out by someone who understands the business aspects of the APIs. In most business environments, API development is a responsibility that is distinct from API publication and management.

WSO2 API Manager provides a state-of-the-art web interface called **WSO2 API Publisher** for API development and management. It is a structured GUI designed for API creators to develop, document, scale and version APIs, while also facilitating more API management-related tasks such as publishing API, monetizating APIs, and promoting.

The diagram above shows the common lifecycle activities of an API developer/manager.

-   #### Developer Portal

![]({{base_path}}/assets/attachments/103327648/126556772.png)

The Developer Portal is a state-of-the-art web interface that allows API publishers to host and advertise their APIs while allowing API consumers to [self register](https://docs.wso2.com/display/AM260/Customizing+the+API+Store) , discover, evaluate, subscribe to and consume APIs.

The diagram above shows common API consumer lifecycle activities:

-   #### API Gateway

The API Gateway is a runtime, backend component (an [API proxy](https://docs.wso2.com/display/EI611/Working+with+APIs) ) developed using [WSO2 ESB](https://docs.wso2.com/display/EI611/WSO2+Enterprise+Integrator+Documentation) . API Gateway secures, protects, manages, and scales API calls. It intercepts API requests, applies policies such as throttling and security using handlers, and manages API statistics. Upon validation of a policy, the Gateway passes web service calls to the actual backend. If the service call is a token request, the Gateway passes it directly to the [Key Manager](#key-manager) .

The API Gateway supports OAuth 2.0, JWT, Basic Auth, Mutual SSL as well as API-Key based authentication mechanisms the above mentioned authentication mechanisms and enables IT organizations to enforce rate limits and throttling policies.

When WSO2 API Manager is running, you can access the Gateway using the following URL: <https://localhost:9443/carbon> . You can integrate a monitoring and analytics component to the API Manager by [configuring WSO2 API Manager Analytics](https://docs.wso2.com/display/AM260/Configuring+APIM+Analytics) . This component provides reports, statistics and graphs on the APIs deployed in WSO2 API Manager. You can also configure alerts to monitor these APIs and detect unusual activity, manage locations via geo location statistics and, carry out detailed analysis of the logs.

!!! note
    Although the API Gateway contains ESB features, it is recommended not to use it for ESB-specific tasks. Its intended to be used only for Gateway functionality related to API invocations. For example, if you want to call external services like SAP, use a separate [ESB cluster](https://docs.wso2.com/display/EI611/Clustering+the+ESB+Profile) for that purpose.

-   #### Key Manager

![]({{base_path}}/assets/attachments/103327648/126556773.png)

The Key Manager manages all clients, security and access token-related operations. The Gateway connects with the Key Manager to check the validity of access tokens, subscriptions and API invocations. The Key Manager also provides a token API to generate access tokens that can be accessed via the Gateway. The Key Manager supports OAuth 2.0, JWT, Basic Auth, Mutual SSL as well as API-Key based authentication mechanisms. 


 To generate an access token, a Subscriber first creates an application on the Developer Portal and generates an access token for the application. Behind the scenes, the Developer Portal makes a token generation request to the API Gateway. The API Gateway then, requests for an access token from the Key Manager. Upon recieving the request, the Key Manager creates an OAuth client and generates an access token. This access token is sent back to the Developer Portal via the API Gateway. 
 
 Similarly, to validate a token, the API Gateway calls the Key Manager, which fetches and validates the token details from the database.

You can avoid making the Gateway connect with the Key Manager every time it receives an API invocation call, by enabling API Gateway [caching](https://docs.wso2.com/display/AM260/Configuring+Caching) . When caching is not enabled, a verification call happens every time the Gateway receives an API invocation call. For this verification, the Gateway passes an access token, the API, and API version to the Key Manager. Communication between the API Gateway and the Key Manager happens in either of the following ways:

-   Through a Web service call
-   Through a [Thrift](http://thrift.apache.org/static/files/thrift-20070401.pdf) call (Thrift is the default communication protocol and is much faster than SOAP over HTTP)

 The Key Manager properly decouples the operations for creating OAuth applications and validating access tokens so that you can even plug in a third party-authorization server for key validations. In a typical production environment, you can configure one of the following setups:

-   Configure a WSO2 API Manager instance as the Key Manager in a separate server. See [Product Profiles](https://docs.wso2.com/display/AM260/Product+Profiles) .
-   Configure an instance of WSO2 Identity Server as the Key Manager. See [Configuring WSO2 Identity Server as the Key Manager](https://docs.wso2.com/display/AM260/Configuring+WSO2+Identity+Server+as+the+Key+Manager) .
-   Configure a third-party authorization server for key validations and an API Manager instance for the rest of the key management operations. See [Configuring a Third-Party Key Manager](https://docs.wso2.com/display/AM260/Configuring+a+Third-Party+Key+Manager) .

-   #### Traffic Manager

![]({{base_path}}/assets/attachments/103327648/126556774.png)
The Traffic Manager helps users to regulate API traffic, make APIs and applications available to consumers at different service levels, and secure APIs against security attacks. The Traffic Manager features a dynamic throttling engine to process throttling policies in real-time, including rate limiting of API requests. For more information, see [Working with Throttling](https://docs.wso2.com/display/AM260/Working+with+Throttling) .

-   #### Analytics

![]({{base_path}}/assets/attachments/103327648/126556775.png)
Additionally, monitoring and analytics are provided by the analytics component, WSO2 API Manager Analytics. This component provides a host of statistical graphs and an  alerting mechanism on pre-determined events. For more information, see [Working with Analytics](https://docs.wso2.com/display/AM260/Working+with+Analytics) .
