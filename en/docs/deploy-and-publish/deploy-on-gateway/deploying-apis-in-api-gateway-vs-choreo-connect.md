# Deploying APIs in API Gateway vs Choreo Connect

**API Deploying** is the process of making the API available for invocation. WSO2 API Manager comes with two gateway choices, the traditional API Gateway and the lightweight Choreo Connect.

Choreo Connect is focused on providing a convenient experience for developers through developer-centric API management. This is where APIs can be managed by the use of OpenAPI definitions and it is the most common way of creating/defining APIs in a Choreo Connect environment. This method allows developers to define Choreo Connect API endpoints using standard OpenAPI definitions. They only have to copy an already defined OpenAPI definition of a valid REST endpoint to the Choreo Connect project. Choreo Connect will parse the resources and different attributes defined in the OpenAPIs definition and generate the required gateway services. These services can then be built and deployed into different gateway environments.

### Choreo Connect vs API Gateway

Choreo Connect and the "traditional" API Gateway can be compared in different aspects as below.  The decision to select either of the gateways is highly dependent on the architecture, design, and deployment. Both gateways mostly have similar features and functionality, but works differently in order to cater for the purpose it was designed to serve.

#### Design and deployment comparison

| **Design/ Deployment**       | **Choreo Connect**                                       | **API Gateway**                        |
|-------------------------|---------------------------------------------------------|-----------------------------------|
|Architecture             |Designed for microservices                               |Designed for monolith              |
|Horizontal Scaling       |Scales independently as the runtime does not have a direct dependency on other components. Security and throttling validations are done within Choreo Connect.                           |  Scaling can be done with other components. For example, the traffic manager (one node per dedicated cluster of gateway nodes ) and key manager can be scaled along with the gateway.|
|Deployment distribution  | Decentralized                                           | Centralized                       |
|Runtime footprint        | Lightweight and can run on computers with low performance.| Designed to run on high performing computers with high load (memory and high CPUs )|
|Isolated lockdown environments| Designed to work in a network isolated environment| Limited functionalities(affect on throttling/ analytics)|
|Cloud ready              | Yes                                                     | Yes                               |
|Automated API CI/CD flows| Supported with CLI tools                                |Supported with CLI tools           |
|Update APIs              | Immutable gateways. Rebuild the gateway upon updating the API| Mutable gateway, updating APIs supported|

#### Security Comparison

API Gateway and Choreo Connect both support different security mechanisms.

| **Security Mechanism**           | **Choreo Connect**                                              | **API Gateway**                       |
|------------------------------|:-------------------------------------------------------------:|:---------------------------------:|
| Oauth2                        | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| Mutual SSL                   | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| Basic Auth                   | Config based supported, can not plug user stores                      | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| API Keys                     | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |

#### Feature Comparison

|   **Feature**                                                  | **Choreo Connect**                                                                        |          **API Gateway**                                                                |
|----------------------------------------------------|:-------------------------------------------------------------------------:|:-----------------------------------------------------------------------:|
| SOAP backends                                      | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| REST APIs                                          | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| JMS backends                                       | ![(No)]({{base_path}}/assets/img/deploy/error.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| GraphQL APIs                                       | ![(No)]({{base_path}}/assets/img/deploy/error.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| GRPC Services                                      | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(No)]({{base_path}}/assets/img/deploy/error.svg) |
| Web socket APIs                                    | ![(No)]({{base_path}}/assets/img/deploy/error.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Custom mediation/transformation                    | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Advance throttling (header, IP, query param, jwt claims) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Advance throttling (based on bandwidth) | ![(No)]({{base_path}}/assets/img/deploy/error.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Schema validation                                  | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| JWT revocation                                     | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   |
| Per resource Endpoints                             | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)   | ![(No)]({{base_path}}/assets/img/deploy/error.svg) |
