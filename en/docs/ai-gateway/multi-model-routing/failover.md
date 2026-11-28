# Failover

Failover routing enhances reliability by automatically switching to an alternate AI model if the primary model becomes unresponsive or encounters an error. This strategy ensures continuous service availability without manual intervention.

!!! tip
     You can configure more than one Failover policy.

## Configure Failover

You can configure failover for your AI API by attaching the **Model Failover** policy. Here are the steps that you need to follow:

1. Login to the Publisher Portal (`https://<hostname>:9443/publisher`).
2. Select the AI API for which you want to configure load balancing.
3. Navigate to **API Configurations**, and click **Policies**.
4. Look for the policy named **Model Failover** listed under the Common Policies section within the policy list. Let's, drag and drop the **Model Failover** policy to the **Request** flow of `/chat/completions` POST operation.
5. Fill in the requested details and click **Save**.

    <table>
        <tr>
            <th>Section</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Production/Sandbox</td>
            <td>
                Select the **target model** and **target endpoint**. To learn which responses trigger failover, see <a href="#how-failover-is-triggered">How failover is triggered</a>.<br>
                Add any amount of fallback models by clicking on **Add Fallback Model** button.
                For each fallback model addition, select a model and an endpoint from the respective dropdowns.
            </td>
        </tr>
        <tr>
            <td>Request Timeout</td>
            <td>Request timeout in seconds.</td>
        </tr>
        <tr>
            <td>Suspend Duration</td>
            <td>Suspend duration in seconds. This will be used to suspend any failed model-endpoint pairs. If not configured, knowledge about failed invocations are not persisted.</td>
        </tr>
    </table>

    [![Model Failover Policy Configuration]({{base_path}}/assets/img/learn/ai-gateway/failover-policy-configuration.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/failover-policy-configuration.png)


!!! note "AWS Bedrock Configuration"
    If you are configuring a multi model provider service, you must select both the **Provider** (model family) and the **Model** for each target and fallback model entry. The **Provider** dropdown lists the model families you have set up in the Admin Portal (such as Meta, Anthropic, DeepSeek, etc.), and once a provider is selected, the **Model** dropdown will display the specific models available under that provider.

    [![AWS Bedrock Failover Policy Configuration]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-failover-policy-configuration.png){: style="width:40%"}]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-failover-policy-configuration.png)


6. Finally, scroll to the bottom of the page and click on **Save and deploy**.

7. For more information on how to work with API Policies, refer to the [API Policies]({{base_path}}/api-design-manage/design/api-policies/overview/) section.

## How failover is triggered

The Model Failover policy decides whether to fail over based on the **HTTP status code returned by the AI service**.

| AI service response | Gateway behavior |
|---|---|
| `2xx` | The gateway returns the response to the client without triggering failover. |
| `400`, `405`, `422` | The gateway returns the response to the client as is. These codes indicate an invalid client request, so the gateway skips failover. |
| Any other HTTP status code (for example, `401`, `403`, `404`, `429`, `500`, `502`, `503`, `504`) | The gateway marks the current model–endpoint pair as failed and suspends it. The gateway then resends the request to the next model in the configured fallback order. |

!!! note
    Model failover works only when the AI service **returns an HTTP response**. Transport-level failures, such as refused connections, unknown hosts, DNS resolution failures, and TLS handshake errors, bypass model failover. The API's fault sequence handles these requests, and the client receives a gateway error. Make sure all configured endpoint URLs are reachable, and use endpoint-level timeout and suspension settings to handle network failures.

!!! tip
    An invalid or expired API key can cause the AI service to return a `401` or `403` response. Either response triggers failover and suspends the model–endpoint pair.

### Suspension of failed models

- The gateway suspends a failed model–endpoint pair for the configured **Suspend Duration**. During that time, the gateway sends requests to the first fallback model whose pair is not suspended.
- The gateway also skips suspended fallback models until their suspension ends.
- If you leave **Suspend Duration** unset, the gateway does not track failures across requests and tries the target model first on every request.
- Each gateway node keeps suspension state in memory for each API.

### Token exhaustion

If the AI service provider is configured with a header that reports the remaining token count, a successful (`2xx`) response with a count of **zero or less** causes the gateway to suspend the model–endpoint pair for the configured duration. The gateway still returns that response to the client.

### When all models fail

If the target model and all fallback models fail or are suspended, the gateway returns the following response:

    HTTP/1.1 503 Service Unavailable

    {"code": "900808", "message": "No active endpoints available. Please try again later."}

### Default configurations

If you leave **Request Timeout** unset in the policy, the gateway uses the default timeout of 30 seconds. You can change the default timeout and the maximum number of fallback models in `<APIM_HOME>/repository/conf/deployment.toml`.

    [apim.ai.failover_configurations]
    default_request_timeout = 30
    failover_endpoints_limit = 10
