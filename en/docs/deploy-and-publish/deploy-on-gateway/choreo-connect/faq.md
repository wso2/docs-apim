# Frequently Asked Questions (FAQs)

## About WSO2 Choreo Connect

### What is WSO2 Choreo Connect ?

WSO2 Choreo Connect is a cloud-native, open-source, and developer-centric API gateway. It provides first-class support for Kubernetes while facilitating an array of API management quality of services (QoS), such as message security, rate-limiting, observability, and message mediation.

### What are the key technologies used underneath WSO2 Choreo Connect ?

The main components of WSO2 Choreo Connect are listed below along with the primary technologies that are used.

- Router - [Envoy proxy](https://www.envoyproxy.io/docs)
- Adapter - Management service written in Go
- Enforcer - Authentication and authorization service written in Java

### What are the differences between WSO2 API Manager Synapse Gateway and Choreo Connect?

WSO2 Choreo Connect is a lightweight, decentralized API gateway designed for microservices related applications whereas WSO2 Synapse gateway is primarily designed for monolithic applications. For more information, refer [Deploying APIs in API Gateway vs Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploying-apis-in-api-gateway-vs-choreo-connect/)

### What are the differences between WSO2 API Microgateway (Ballerina MGW) and WSO2 Choreo Connect ?

Earlier versions of the Choreo Connect were named as WSO2 API Microgateway (Ballerina MGW) and it was a completely different implementation done using the Ballerina programming language. The final version of API Microgateway is 3.X.X and it is compatible with WSO2 API Manager 3.0 series only. With the release of WSO2 API Manager 4.0.0, Choreo Connect 1.0.0 released as the new version of API Microgateway. Refer to the [migration guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/migration-guide-from-ballerina-api-microgateway/) for more information. 

### What is the open source license of WSO2 Choreo Connect ?

[Apache Software License Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)

### Does WSO2 Choreo Connect offer any commercial support?

It is completely supported from evaluation to production. For more details, see [WSO2 Support](https://wso2.com/subscription/).

## Installation and deployment

### What are the minimum requirements needed to run WSO2 Choreo Connect?

Refer to the installation [prerequisites section]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/installation-prerequisites/)

### How to deploy WSO2 Choreo Connect in production ?

It is recommended to use the helm charts based deployment option for production. Refer to the [helm charts based deployment guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-kubernetes-with-apim-as-control-plane-helm-artifacts/) for more information.

### Can I run Choreo Connect using docker compose ?

Docker Compose is recommended to run for try out purposes. Kubernetes should be used for production deployments as Kubernetes provides container management capabilities.

### When Choreo Connect is deployed in Kubernetes, some pods are in pending status. What can be the root causes?

Use `kubectl describe pod` to find the root cause. Allocate more resources if you don't have enough memory or CPU. If you are deploying for tryout purposes, decrease the values.

### What are the default ports used in WSO2 Choreo Connect ?

- HTTP - 9090
- HTTPS - 9095
- Enforcer Auth server - 8081
- Adapter management server - 9843
- Envoy admin port - 9000
- Adapter debug port - 6060
- Adapter xDS port 18000
- Enforcer admin port - 9001

### What are the different deployment patterns available for WSO2 Choreo Connect ?

* [Choreo Connect standalone gateway mode with apictl]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)
    * [Deploy APIs as Immutable Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-apis-as-immutable-gateway/)
    * [Git integration with source watcher]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/git-integration/)
* [Choreo Connect with APIM as a control plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)

### Is it possible to scale different components of WSO2 Choreo Connect separately ?

Yes, you can define the number of replicas you want and scale the services accordingly. The Router and Enforcer components can be scaled based on the traffic but no scaling is required for the Adapter component as it is a management server. 

### How do I apply configuration changes?

`config.toml` file is used by the Adapter to read the configuration and the adapter should be restarted to apply new configuration. If the configuration changes should be applied to the Enforcer,  Enforcer should be restarted as it only reads data at the startup. The Router gets updates directly from the Adapter. So a restart is not required.

### Is Choreo Connect 1.1.0 supported with apim 4.0.0?

No, supported API Manager versions are listed below with the respective Choreo Connect versions.

| API Manager       | Choreo Connect       |
|-------------------|----------------------|
| API Manager 4.0.0 | Choreo Connect 1.0.0 |
| API Manager 4.1.0 | Choreo Connect 1.1.0 |

### Why do I keep getting gRPC xDS errors during the start up?

During the start up, the enforcer service tries to connect with the adapter to fetch applications, subscriptions and other required resources. The adapter waits for the APIM to start and  relative to the adapter, APIM takes more time to start and hence during this time duration, xDS config discovery client errors are thrown.

## Functionality

### What are the application layer protocols supported by WSO2 Choreo Connect ?

HTTP/1.1 , HTTP/2

### What are the API types supported by WSO2 Choreo Connect ?

REST, SOAP, GraphQL, WebSocket

### I want to do a custom validation for all the API requests in addition to the default validations. How can I do that?

You can write a [custom filter]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/extensions/custom-filters/) in the enforcer component or use a separate [interceptor service]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/interceptor-microservice/). Also you can perform custom request validation using the [Open Policy Agent (OPA)]({{base_path}}/design/api-security/opa-validation/custom-opa-policy-for-choreo-connect/).

### Can I perform API request / response transformations ?

Yes, use a separate [interceptor service]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/interceptor-microservice/). Also API policies can be used to perform simple transformations like adding/removing headers, rewriting paths, adding query params, changing HTTP methods etc.

## Security

### What are the different methods available for API authentication ?

Choreo Connect supports several API authentication mechanisms including OAuth 2.0. Refer to the [API authentication documentation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/api-authentication/) for more information.

### Can I use a custom Authorization header ?

Yes, you can configure a custom authorization header name in Choreo Connect. Refer to the [Custom Authorization Header]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/use-a-custom-authorization-header/) for more information.

### Can I disable API security for a specific API deployed in WSO2 Choreo Connect ?

Yes, security can be disabled at API, resource and operation level. Refer to the [Disabling Security]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/disabling-security/) for more information.

### What are the different methods of API Authorization supported by WSO2 Choreo Connect ?

Scope validation, subscription validation, custom claims mapping and Open Policy Agent (OPA) validation. Refer to the [API Authorization]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authorization/scope-validation/) for more information.

## Troubleshooting

### Why am I getting Cross-Origin Resource Sharing (CORS) errors ?

It could be due to an invalid CORS configuration in the router component. Also another possibility is that the API is not deployed at all. Since the preflight request is usually sent prior to the actual request, users would see a CORS failure. Refer to the [CORS configuration] for more information.

### How can I enable debug logs?

Debug and trace logs can be enabled separately for each of the components. Refer to the [Enable Debug Logs]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/troubleshooting/adding-debug-logs/) for more information.

### How can I print logs in different formats?

You can change the log format only in adapter & enforcer. Currently, Choreo Connect supports plain text format (default) and JSON formatted logs only. Refer to the [Logs configuration]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-overview/) for more information.

### How can I inspect HTTP headers and payloads related to a request ?

Enable router trace logs. Refer to the [Router logs configuration]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-router/) for more information. 

### Where can I get more information about the error codes ?

Refer to the [Error handling]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/troubleshooting/error-handling/) for information regarding the error codes.

### Why am I getting an Unclassified Validation Failure with 500 HTTP status code?

This error occurs when the router is unable to connect to the enforcer service to perform authentication. Possible reasons could be,

* Enforcer service not being available
    * Execute the following command to see the status of the enforcer service.
        * `docker ps` for docker compose based deployments
        * `kubectl get deployments` for kubernetes based deployments
* Runtime exception in the enforcer service causes a timeout
    * Enable debug logs and router access logs to see whether there’s any unusual behavior / exception
* Invalid network configuration like host name, port, port bindings etc.
* Enforcer service does not have enough resources to process the request. (insufficient memory or high CPU usage)

### Why am I getting an upstream connection termination error with 503 status code ?

Enable access logs in the router and inspect the logs. Refer to the response error codes to find the exact reason for upstream connection termination. If further analysis is required, enable router trace logs.

### Why do I get a 404 that says resource not found when I deploy the API?

Check adapter logs for API deployment and verify whether the API has been successfully deployed or not. Check the router config dump to verify whether a relevant route exists for the invoked resource. To access router config dump, use Kubernetes port forwarding to access the router admin interface.

`kubectl port-forward <POD_NAME> 9000:9000`

### Why do I get a 401 unauthorized error for an API request?

401 Unauthorized is returned when the authentication fails in the enforcer for the provided credentials.

* Check whether the provided credentials are valid or not. 
* Check enforcer logs to see the reason for the failure. 
* Enable debug logs to further verify. 
