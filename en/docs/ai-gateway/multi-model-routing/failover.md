# Failover

Failover routing enhances reliability by automatically switching to an alternate AI model if the primary model becomes unresponsive or encounters an error. This strategy ensures continuous service availability without manual intervention.

!!! tip
     You can configure more than one Failover policy.

## Configure Failover

You can configure failover for your AI API by attaching the **Model Failover** policy. Here are the steps that you need to follow:

1. Login to the Publisher Portal (`https://<hostname>:9443/publisher`).
2. Select the AI API for which you want to configure load balancing.
3. Navigate to **API Configurations**, and click **Policies**.
4. Look for the policy named **Model Failover** listed under the Common Policies section within the policy list. Let's, drag and drop the **Model Failover** policy to the **Request** flow of `/v1/chat/completions` POST operation.
5. Fill in the requested details and click **Save**.

    <table>
        <tr>
            <th>Section</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Production/Sandbox</td>
            <td>
                Select the **target model** and **target endpoint**. If the request is made to this combination, fallback will get triggered. </br>
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

    Note that we have used an invalid model name, to make sure that failover would trigger.

6. Finally, scroll to the bottom of the page and click on **Save and deploy**.

7. For more information on how to work with API Policies, refer to the [API Policies]({{base_path}}/design/api-policies/overview/) section.

## Try Out Failover

1. Navigate to the Developer Portal and try to invoke the AI API.
2. Let's invoke `/v1/chat/completions POST` resource by obtaining a **Production** key since we configured the failover policy only for production. You can use the below mentioned payload.

    ```json
    {
        "model": "invalid-model",
        "messages": [{"role": "user", "content": "Who is the most renowned French painter?"}]
    }
    ```

    Notice how the request was made to the `invalid-model` model, but the response was from `mistral-small-latest`.

    [![Failover Invoke]({{base_path}}/assets/img/learn/ai-gateway/failover-invoke.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/failover-invoke.png)
