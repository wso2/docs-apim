# References

This page provides reference information for the WSO2 Backstage plugin suite, including the full configuration schema and catalog annotation reference.


## Configuration Reference

<table>
  <tr>
    <th>Module</th>
    <th>Configuration Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td rowspan="13">wso2ApiManager</td>
    <td>enabled</td>
    <td>boolean</td>
    <td>Enables the WSO2 API Manager integration.</td>
  </tr>
  <tr>
    <td>requestTimeoutSeconds</td>
    <td>number</td>
    <td>Maximum time (in seconds) the plugin waits for a response before aborting. Default: 30.</td>
  </tr>
  <tr>
    <td>baseUrl</td>
    <td>string</td>
    <td>The base URL of your WSO2 API Manager instance.</td>
  </tr>
  <tr>
    <td>publisherBasePath</td>
    <td>string</td>
    <td>The base path for the Publisher API. Refer to the <a href="https://apim.docs.wso2.com/en/4.7.0/reference/product-apis/publisher-apis/publisher-v4/publisher-v4/">Publisher API</a> docs.</td>
  </tr>
  <tr>
    <td>developerBasePath</td>
    <td>string</td>
    <td>The base path for the DevPortal API. Refer to the <a href="https://apim.docs.wso2.com/en/4.7.0/reference/product-apis/devportal-apis/devportal-v3/devportal-v3/">DevPortal API</a> docs.</td>
  </tr>
  <tr>
    <td>serviceCatalogBasePath</td>
    <td>string</td>
    <td>The base path for the Service Catalog API.</td>
  </tr>
  <tr>
    <td>tls.rejectUnauthorized</td>
    <td>boolean</td>
    <td>Set to false if your WSO2 instance uses a self-signed certificate (common for local testing). In production, set to true.</td>
  </tr>
  <tr>
    <td>auth.clientId</td>
    <td>string</td>
    <td>Your WSO2 APIM application Consumer Key. Log in to the WSO2 DevPortal and <a href="https://apim.docs.wso2.com/en/latest/api-developer-portal/manage-application/generate-keys/generate-api-keys/">generate keys</a>.</td>
  </tr>
  <tr>
    <td>auth.clientSecret</td>
    <td>string</td>
    <td>Your WSO2 APIM application Consumer Secret. Log in to the WSO2 DevPortal and <a href="https://apim.docs.wso2.com/en/latest/api-developer-portal/manage-application/generate-keys/generate-api-keys/">generate keys</a>.</td>
  </tr>
  <tr>
    <td>auth.tokenUrl</td>
    <td>string</td>
    <td>The OAuth2 token endpoint used to request access tokens (e.g., https://&lt;WSO2_HOST&gt;:9443/oauth2/token).</td>
  </tr>
  <tr>
    <td>auth.requiredScopes</td>
    <td>string[]</td>
    <td>A list of OAuth2 scopes required by the plugin to communicate with WSO2 APIs.</td>
  </tr>
  <tr>
    <td>auth.grantType</td>
    <td>string</td>
    <td>The grant type used to fetch the token. Typically client_credentials.</td>
  </tr>
  <tr>
    <td>catalogSyncTimeoutSeconds</td>
    <td>number</td>
    <td>The timeout duration for fetching API items from the APIM instance.</td>
  </tr>
  <tr>
    <td rowspan="7">wso2PlatformGateway</td>
    <td>enabled</td>
    <td>boolean</td>
    <td>Enables the WSO2 Platform Gateway integration.</td>
  </tr>
  <tr>
    <td>gateways[].name</td>
    <td>string</td>
    <td>The name of the self-hosted gateway.</td>
  </tr>
  <tr>
    <td>gateways[].environmentType</td>
    <td>string</td>
    <td>The environment type of the gateway (e.g., Development, Production).</td>
  </tr>
  <tr>
    <td>gateways[].urls</td>
    <td>string[]</td>
    <td>A list of base URLs where the gateway is accessible (e.g., https://&lt;GATEWAY_URL&gt;).</td>
  </tr>
  <tr>
    <td>gateways[].discoveryUrl</td>
    <td>string</td>
    <td>The endpoint used to fetch API deployments from the gateway directly (e.g., &lt;GATEWAY_URL&gt;/rest-apis).</td>
  </tr>
  <tr>
    <td>gateways[].discoveryUsername</td>
    <td>string</td>
    <td>The Basic Auth username required to access the gateway discovery endpoint.</td>
  </tr>
  <tr>
    <td>gateways[].discoveryPassword</td>
    <td>string</td>
    <td>The Basic Auth password required to access the gateway discovery endpoint.</td>
  </tr>
  <tr>
    <td rowspan="4">catalog.providers.wso2Apim</td>
    <td>schedule.frequency</td>
    <td>object</td>
    <td>The periodic interval between each catalog ingestion sweep (e.g., minutes: 20).</td>
  </tr>
  <tr>
    <td>schedule.timeout</td>
    <td>object</td>
    <td>The maximum allowed duration for a single ingestion task before it is automatically aborted (e.g., minutes: 5).</td>
  </tr>
  <tr>
    <td>schedule.initialDelay</td>
    <td>object</td>
    <td>Delays the very first ingestion after the Backstage backend boots up (e.g., seconds: 15).</td>
  </tr>
  <tr>
    <td>schedule.scope</td>
    <td>string</td>
    <td>Determines the execution scope across the cluster. Typically set to global.</td>
  </tr>
</table>

---

## More Information

- [WSO2 API Manager Documentation](https://apim.docs.wso2.com)
- [Backstage Documentation](https://backstage.io/docs)
- [Plugin GitHub Repository](https://github.com/wso2/Backstage-WSO2-APIM-plugins)