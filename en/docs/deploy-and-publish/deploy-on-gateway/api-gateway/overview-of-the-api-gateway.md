# Overview of the API Gateway

[![API-M overview]({{base_path}}/assets/img/learn/apim-overview.png)]({{base_path}}/assets/img/learn/apim-overview.png)

**WSO2 API Gateway** provides a runtime and a backend component (an API proxy) for API calls. It secures, protects, manages, and scales API calls by intercepting API requests and applying policies, such as throttling and security, using handlers and managing API statistics.

Upon validation of a policy, the Gateway passes Web service calls to the actual backend. If the service call is a token request, the Gateway passes it directly to the Key Manager.

After the API Manager server has started, you can access the Gateway using the Management Console [https://localhost:9443/carbon](https://localhost:9443/carbon). If you need to integrate a monitoring and analytics component to WSO2 API Manager, you can do so by configuring WSO2 API Manager Analytics. This component provides reports, statistics, and graphs on the APIs deployed in WSO2 API Manager. You can then configure alerts to monitor these APIs and detect unusual activity, manage locations via Geolocation statistics and carry out a detailed analysis of the logs.

!!! Info    
    Although the API Gateway contains integration features, it is recommended not to use it for integration-specific tasks. Use it only for Gateway functionality related to API invocations. For example, if you want to call external services (e.g., SAP), use a separate Micro Integrator cluster for this purpose.

**Gateway Architecture**

[![Gateway overview]({{base_path}}/assets/img/learn/gateway-overview.png)]({{base_path}}/assets/img/learn/gateway-overview.png)

Messages that reach the Gateway are processed as follows:

1. When a request hits the API Gateway, it is received by the `HTTP/HTTPS transports`. 
   
     The transport is responsible for carrying messages that are in a specific format. The transport provides a receiver, which is used to receive messages, and a sender, which is used to send messages.

2. The receiving transport selects a message builder based on the message's content type. 

     It uses the builder to process the message's raw payload data and convert it into a common XML, which the Gateway mediation engine can then read and understand. The Gateway includes message builders for text-based and binary content.

3. The request is passed through a set of handlers that applies the quality of services on the request message. Furthermore, it enforces security, rate-limiting, and transformations on API requests if applicable and also feeds valuable information with regard to these requests to API Analytics.

4. After all the requests are routed to the backend endpoint, a message formatter is used to build the outgoing stream back into its original format based on the message.

     The message formatter is selected based on the message's content type.

5. The transport sends the message out from the Gateway.

**Main Features**

The Gateway supports the following features to control access and enforce security.

* Supports JWT, OAuth2.0, Basic Auth, API Key, Mutual TLS, and more.
* Supports in-memory subscription validation, that decouples runtime dependency on the Key Manager.
* Provides multiple Key Manager support for authentication.
* Restricts API access tokens to domains/IPs.
* Validates APIs payload content against schemas.
* Applies additional security policies to APIs (authentication and authorization).
* Supports all standard OAuth2.0 grant types and allows extensions and additions to grants.
* Works seamlessly with third-party OAuth2.0 providers, standard, or proprietary.
* Allows blocking subscriptions due to non-payment, API abuse, etc.
* Associates API to system-defined service tiers for quotas and rate-limits.
* Generates JSON web tokens for consumption by back-end servers.
* Leverages XACML for entitlements management and fine-grain authorization.
* Provides threat protection, bot detection, and token-fraud detection.
* Supports detection of abnormal system use through artificial intelligence and machine learning.
