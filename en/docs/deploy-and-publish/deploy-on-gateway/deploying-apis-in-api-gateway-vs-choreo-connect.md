# Deploying APIs in API Gateway vs Choreo Connect

**API Deploying** is the process of making the API available for invocation. WSO2 API Manager comes with two gateway choices, the traditional API Gateway and the lightweight Choreo Connect.

Choreo Connect is a cloud-native, open-source, and developer-centric API gateway proxy. It provides first-class support for K8s, while facilitating an array of API management quality of services (QoS), such as message security, rate-limiting, observability, and message mediation. It can also be configured to have multiple Gateway environments, which can have different sets of APIs.

### Choreo Connect vs API Gateway

Choreo Connect and the "traditional" API Gateway can be compared in different aspects as below.  The decision to select either of the Gateways is highly dependent on the architecture, design, and deployment. Both Gateways mostly have similar features and functionality, but works differently in order to cater for the purpose it was designed to serve.

#### Design and deployment comparison

| **Design/ Deployment**       | **Choreo Connect**                                       | **API Gateway**                        |
|-------------------------|---------------------------------------------------------|-----------------------------------|
|Architecture             |Designed for microservices                               |Designed for monolith              |
|Horizontal Scaling       |Scales independently as the runtime does not have a direct dependency on other components. Security and throttling validations are done within Choreo Connect.                           |  Scaling can be done with other components. For example, the traffic manager (one node per dedicated cluster of gateway nodes ) and key manager can be scaled along with the gateway.|
|Deployment distribution  | Decentralized                                           | Centralized                       |
|Runtime footprint        | Lightweight and can run on computers with low performance.| Designed to run on high performing computers with enough memory and more CPUs.|
|Isolated lockdown environments| Designed to work in a network isolated environment| Limited functionalities(affect on throttling/ analytics)|
|Cloud ready              | Yes                                                     | Yes                               |
|Automated API CI/CD flows| Supported with CLI tools                                |Supported with CLI tools           |
|Update APIs              | Supports both Mutable Gateway and Immutable Gateway     | Mutable Gateway                   |

#### Security Comparison

API Gateway and Choreo Connect both support different security mechanisms.

| **Security Mechanism**           | **Choreo Connect**                                              | **API Gateway**                       |
|------------------------------|:-------------------------------------------------------------:|:---------------------------------:|
| OAuth2                        | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| Mutual SSL                   | ![(Yes))]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| Basic Auth                   | Custom Filter can be developed                    | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| API Keys                     | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |

#### Feature Comparison

|   **Feature**                                                  | **Choreo Connect**                                                                        |          **API Gateway**                                                                |
|----------------------------------------------------|:-------------------------------------------------------------------------:|:-----------------------------------------------------------------------:|
| SOAP backends                                      | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| REST APIs                                          | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| JMS backends                                       | ![(No)]({{base_path}}/assets/img/deploy/error.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| GraphQL APIs                                       | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Web Socket APIs                                    | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Custom mediation/transformation                    | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Advanced rate limiting (header, IP, query param, jwt claims) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Advanced rate limiting (based on bandwidth) | ![(No)]({{base_path}}/assets/img/deploy/error.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Schema validation                                  | ![(No)]({{base_path}}/assets/img/deploy/error.svg)   | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| JWT revocation                                     | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Per resource Endpoints                             | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(No)]({{base_path}}/assets/img/deploy/error.svg) |
