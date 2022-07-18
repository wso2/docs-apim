Choreo Connect supports the following policies at operation level for request and response flows. To add policies to the API, open API Manager Publisher Portal, navigate to the **Policies** tab, and drag and drop the policies to the relevant flow in the required order.

## Request flow

- Add header
- Remove header
- Remove Query Parameter
- Rewrite Resource Path
- Change HTTP Method
- Validate Request with OPA
- Call Interceptor Service

## Response flow

- Add header
- Remove header
- Call Interceptor Service

## See also

- [Attaching Policies]({{base_path}}/design/api-policies/attach-policy/)
- [API Policies Overview]({{base_path}}/design/api-policies/overview/)
- [Policy to Validate Request with Open Policy Agent]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authorization/opa-validation/)
- [Message Transformation with Interceptors]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/message-transformation-overview/)
- [Request Flow Custom Filters]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/extensions/custom-filters/)