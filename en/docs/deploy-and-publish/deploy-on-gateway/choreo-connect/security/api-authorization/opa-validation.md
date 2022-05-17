# Validate Request with Open Policy Agent (OPA)

The [Open Policy Agent (OPA)](https://openpolicyagent.org/) is an open source, general-purpose policy engine that unifies policy enforcement. In Choreo Connect, you can offload some responsibility of making the decision to authorize or not when a consumer invokes APIs based on policies attached to APIs.

Choreo Connect uses OPA’s policy evaluation REST API interface to communicate with OPA. Following diagram describes the request/response of OPA validation.

!!! tip
    You can deploy OPA server as a sidecar with Choreo Connect Runtime (Enforcer and Router) in a Kubernetes deployment, if you want to improve communication between Enforcer and OPA server.

<a href="{{base_path}}/assets/img/deploy/mgw/choreo-connect-opa-overview.png">
    <img src="{{base_path}}/assets/img/deploy/mgw/choreo-connect-opa-overview.png" alt="Choreo Connect OPA request flow" width="60%"/>
</a>

| Numbers | Description                                                                                                                                         |
|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| 1       | Client request                                                                                                                                      |
| 2       | Request to validate (i.e. authentication, rate-limiting, OPA validation and other validations) the client request through Enforcer                  |
| 3       | Enforcer calling the OPA server with the JSON payload described in [Request Payload to the OPA server](#request-payload-to-the-opa-server)          |
| 4       | Response from OPA server after validating the request as described in [Response Payload from the OPA server](#response-payload-from-the-opa-server) |
| 5       | Respond the validation status to the Router                                                                                                         | 
| 6,7     | Response from the backend                                                                                                                           |
| 8       | Response to the client                                                                                                                              |

Please refer the documentation on [Validate Request with Open Policy Agent (OPA)]({{base_path}}/design/api-security/opa-validation/overview/) to learn how to attach and configure OPA policies to APIs.
