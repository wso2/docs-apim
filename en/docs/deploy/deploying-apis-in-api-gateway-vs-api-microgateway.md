#Deploying APIs in API Gateway vs API Microgateway

**API Deploying** is the process of making the API available for subscription. WSO2 API Manager comes with two gateway choices, the traditional API Gateway and the lightweight API Microgateway.

WSO2 API Microgateway is focused on providing a convenient experience for developers through developer-centric API management. This is where APIs can be managed by the use of OpenAPI definitions and it is the most common way of creating/defining APIs in a Microgateway environment. This method allows developers to define Microgateway API endpoints using standard OpenAPI definitions. They only have to copy an already defined OpenAPI definition of a valid REST endpoint to the Microgateway project. Microgateway will parse the resources and different attributes defined in the OpenAPIs definition and generate the required gateway services. These services can then be built and deployed into different gateway environments.

### API Microgateway vs API Gateway

API Microgateway and the "traditional" API Gateway can be compared in different aspects as below.  The decision to select either of the gateways is highly dependent on the architecture, design, and deployment. Both gateways mostly have similar features and functionality, but works differently in order to cater for the purpose it was designed to serve.

#### Design and deployment comparison

|Design/ Deployment       |API Microgateway                                         |API Gateway                        |
|-------------------------|---------------------------------------------------------|-----------------------------------|
|Architecture             |Designed for microservices                               |Designed for monolith              |
|Horizontal Scaling       |Scales independently as the runtime does not have a direct dependency on other components. Security and throttling validations are done within the Microgateway.                           |  Scaling can be done with other components. For example, the traffic manager (one node per dedicated cluster of gateway nodes ) and key manager can be scaled along with the gateway.|
|Deployment distribution  | Decentralized                                           | Centralized                       |
|Runtime footprint        | Lightweight and can run on computers with low performance.| Designed to run on high performing computers with high load (memory and high CPUs )|
|Isolated lockdown environments| Designed to work in a network isolated environment| Limited functionalities(affect on throttling/ analytics)|
|Cloud ready              | Yes                                                     | Yes                               |
|Automated API CI/CD flows| Supported with CLI tools                                |Supported with CLI tools           |
|Update APIs              | Immutable gateways. Rebuild the gateway upon updating the API| Mutable gateway, updating APIs supported|

#### Security Comparison

API Gateway and API Microgateway both support different security mechanisms.

| Security Mechanism           | API Microgateway                                              | API Gateway                       |
|------------------------------|:-------------------------------------------------------------:|:---------------------------------:|
| Oauth2 opaque tokens         | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) |
| Oauth2 self-contained tokens | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) |
| Mutual SSL                   | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) |
| Basic Auth                   | Config based supported, can not plug user stores                      | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) |
| API Keys                     | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) |

#### Feature Comparison

|   Feature                                                  | API Microgateway                                                                        |          API Gateway                                                                |
|----------------------------------------------------|:-------------------------------------------------------------------------:|:-----------------------------------------------------------------------:|
| SOAP backends                                      | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| REST APIs                                          | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| JMS backends                                       | ![(error)]({{base_path}}/assets/img/getting-started/error.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| GraphQL APIs                                       | ![(error)]({{base_path}}/assets/img/getting-started/error.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| GRPC Services                                      | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   | ![(error)]({{base_path}}/assets/img/getting-started/error.svg) |
| Web socket APIs                                    | ![(error)]({{base_path}}/assets/img/getting-started/error.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| Custom mediation/transformation                    | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| Advance throttling (header, IP, query param, jwt claims) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| Advance throttling (based on bandwidth) | ![(error)]({{base_path}}/assets/img/getting-started/error.svg) | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| Schema validation                                  | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| JWT revocation                                     | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   |
| Per resource Endpoints                             | ![(tick)]({{base_path}}/assets/img/getting-started/check.svg)   | ![(error)]({{base_path}}/assets/img/getting-started/error.svg) |
