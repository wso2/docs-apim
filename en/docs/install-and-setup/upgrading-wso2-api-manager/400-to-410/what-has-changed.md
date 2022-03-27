WSO2 API Manager Server 4.1.0 brings a range of new features and major improvements. The following aspects have changed in 4.1.0 compared to the previous WSO2 API-M versions.

This page provides details about the behavioral changes from WSO2 API Manager Server 4.0.0 to 4.1.0

### REST API versions 
If you consume APIs which are exposed from the API Publisher, Developer Portal, Admin Portal and Gateway directly through the UIs or an external REST client like cURL, please note the latest version of them as below.  

  -   Publisher API (v3) 
  -   Admin Portal (v3)
  -   Developer Portal (v2)
  -   Gateway (v2)

### Mediation policies migration

With 4.1.0 release, WSO2 API manager has realigned it’s previous API level mediation policies feature to a more sophisticated policy feature which provides support for not only mediation policies, but a vast number of different use cases. Instead of API level policy allocation, the new feature supports policies at the operation level for regular gateway (synapse based) and at resource level for the choreo connect gateway. With this support, previous mediation policy support via Admin REST APIs is no longer available, instead  publisher REST API `operation-policies` support the same functionality. Publisher UI mediation policies which were displayed under runtime configuration has been removed and it is moved to a separate tab called `policies`. Therefore, you will be able to see the mediation policies in previous apim versions under policies UI.

Major functionalities of the new policies feature are listed below.

1. A new UI to manage common policies which can be shared across all the APIs.
2. An interactive UI in the API configurations to allocate the policies.
3. Increased granularity for the policy allocation which is spread until operation level.
4. Ability to apply multiple policies for a single operation and has an interactive UI to manage the policy execution order.
5. Ability to parameterize the policies with dynamic values and reuse the same policy across different operations with different configurations.

With these new features, we have removed the API level mediation policies and if you need to apply a policy with the same configurations across the API, you can do so by selecting the `Apply to all resources` option.

Previous mediation related resources from the Publisher and Admin REST API have been removed and you can achieve the same functionality via the operation-policies resource in the Publisher REST API.

APICTL Project structure has been changed and Sequences directory has been replaced with a new Policies directory. This policies directory contains the policies applied to the API at the operation level. Each policy has a specification file (yaml or json) which has all the meta information about the policy and a policy definition file (j2 file for regular gateway and gotmpl file for choreo connect) which contains the logic behind the policy. Policy allocation and policy order of each operation is recorded in the api.yaml file and if the policy is parameterized, values of each parameterized attribute are defined in this section.

For more information see, [OPA policy support]({{base_path}}/design/api-security/opa-validation/overview/#attaching-opa-policy)

### GraphQL Subscription 
If the GraphQL subscription operations are available on your existing GraphQL APIs in 4.0.0,  APIM 4.1.0 is supported for subscription opertaion under websocket flow.

For more information see, [GraphQL subscription]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console/#invoke-a-graphql-subscription-operation)
