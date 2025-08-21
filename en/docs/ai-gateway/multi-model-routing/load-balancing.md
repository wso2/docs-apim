# Load Balancing

Load balancing ensures that AI API requests are efficiently distributed across multiple models within the same AI Service Provider, preventing overloading of any single model. WSO2 API Manager supports the following load balancing methods:

- Round Robin
- Weighted Round Robin

!!! note
     You can only configure a single load balancing stratgery at a given time for a given AI API.

## Round Robin

With Round Robin policy, requests are evenly distributed across all configured AI models in a cyclic manner, ensuring equal request allocation over time.

### Configure Round Robin Routing

You can enforce round robin based load balancing for your AI API by attaching the **Model Round Robin** policy. Here are the steps that you need to follow:

1. Login to the Publisher Portal (`https://<hostname>:9443/publisher`).
2. Select the AI API for which you want to configure load balancing.
3. Navigate to **API Configurations**, and click **Policies**.
4. Look for the policy named **Model Round Robin** listed under the Common Policies section within the policy list. Let's, drag and drop the **Model Round Robin** policy to the **Request** flow of `/chat/completions` POST operation.

    [![Model Round Robin Policy]({{base_path}}/assets/img/learn/ai-gateway/attach-model-round-robin-policy.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/attach-model-round-robin-policy.png)

!!! note "AWS Bedrock Configuration"
    When configuring **AWS Bedrock** as your provider for round robin routing, you must select both the **Provider** (model family) and the **Model** for each model entry. The **Provider** dropdown will show the model families you have configured in the Admin Portal (such as Meta, Anthropic, DeepSeek, etc.). After selecting a provider, the **Model** dropdown will list the specific models available under that provider.

    [![AWS Bedrock Weighted Round Robin Policy Configuration]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-round-robin-policy-configuration.png){: style="width:40%"}]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-round-robin-policy-configuration.png)

5. Fill in the requested details and click **Save**.

    <table>
        <tr>
            <th>Section</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Production/Sandbox</td>
            <td>Add any amount of models by clicking on **Add Model** button. </br>For each model addition, select a model from the dropdown (if no models are listed, make sure to add the desired models from the Admin Portal). Following the model selection, select the endpoint from the dropdown (if no endpoints are listed, make sure to add the required endpoints under the Endpoints page of Publisher Portal)</td>
        </tr>
        <tr>
            <td>Suspend Duration</td>
            <td>Suspend duration in seconds. This will be used to suspend any failed model-endpoint pairs. If not configured, knowledge about failed invocations are not persisted.</td>
        </tr>
    </table>

    [![Model Round Robin Policy Save]({{base_path}}/assets/img/learn/ai-gateway/round-robin-save.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/round-robin-save.png)

6. Finally, scroll to the bottom of the page and click on **Save and deploy**.

7. For more information on how to work with API Policies, refer to the [API Policies]({{base_path}}/design/api-policies/overview/) section.

### Try Out Round Robin Routing

1. Navigate to the Developer Portal and try to invoke the AI API.
2. Let's invoke `/chat/completions POST` resource by obtaining a **Production** key since we configured the round robin policy only for production. You can use the below mentioned payload.

    ```json
    {
        "model": "gpt-4o",
        "messages": [{"role": "user", "content": "Say this is a test!"}]
    }
    ```

    Notice how the request was made to `gpt-4o` model, but the response was from `gpt-4o-mini`.

    [![Round Robin Invoke]({{base_path}}/assets/img/learn/ai-gateway/round-robin-invoke.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/round-robin-invoke.png)

## Weighted Round Robin

Requests are distributed based on predefined weight values assigned to each model. This allows probabilistic control over request distribution, giving higher priority to models with greater processing power or availability.

### Configure Weighted Round Robin Routing

You can enforce weighted round robin based load balancing for your AI API by attaching the **Model Weighted Round Robin** policy. Here are the steps that you need to follow:

1. Login to the Publisher Portal (`https://<hostname>:9443/publisher`).
2. Select the AI API for which you want to configure load balancing.
3. Navigate to **API Configurations**, and click **Policies**.
4. Look for the policy named **Model Weighted Round Robin** listed under the Common Policies section within the policy list. Let's, drag and drop the **Model Weighted Round Robin** policy to the **Request** flow of `/chat/completions` POST operation.

    [![Model Round Robin Policy]({{base_path}}/assets/img/learn/ai-gateway/attach-model-weighted-round-robin-policy.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/attach-model-weighted-round-robin-policy.png)

5. Fill in the requested details and click **Save**.

    <table>
        <tr>
            <th>Section</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Production/Sandbox</td>
            <td>Add any amount of models by clicking on **Add Model** button. </br>For each model addition, select a model from the dropdown (if no models are listed, make sure to add the desired models from the Admin Portal). Following the model selection, select the endpoint from the dropdown (if no endpoints are listed, make sure to add the required endpoints under the Endpoints page of Publisher Portal). Assign a weight to the model that was picked.</td>
        </tr>
        <tr>
            <td>Suspend Duration</td>
            <td>Suspend duration in seconds. This will be used to suspend any failed model-endpoint pairs. If not configured, knowledge about failed invocations are not persisted.</td>
        </tr>
    </table>

    [![Model Round Robin Policy Save]({{base_path}}/assets/img/learn/ai-gateway/weighted-round-robin-save.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/weighted-round-robin-save.png)
    

!!! note "AWS Bedrock Configuration"
    When configuring **AWS Bedrock** as your provider for weighted round robin routing, you must select both the **Provider** (model family) and the **Model** for each model entry. The **Provider** dropdown will show the model families you have configured in the Admin Portal (such as Meta, Anthropic, DeepSeek, etc.). After selecting a provider, the **Model** dropdown will list the specific models available under that provider.

    [![AWS Bedrock Weighted Round Robin Policy Configuration]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-weighted-round-robin-policy-configuration.png){: style="width:40%"}]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-round-weighted-robin-policy-configuration.png)

6. Finally, scroll to the bottom of the page and click on **Save and deploy**.

7. For more information on how to work with API Policies, refer to the [API Policies]({{base_path}}/design/api-policies/overview/) section.

### Try Out Weighted Round Robin Routing

1. Navigate to the Developer Portal and try to invoke the AI API.
2. Let's invoke `/chat/completions POST` resource by obtaining a **Production** key since we configured the weighted round robin policy only for production. You can use the below mentioned payload.

    ```json
    {
        "model": "gpt-4o",
        "messages": [{"role": "user", "content": "Say this is a test!"}]
    }
    ```

    Notice how the request was made to `gpt-4o` model, but the response was from `o3-mini`.

    [![Round Robin Invoke]({{base_path}}/assets/img/learn/ai-gateway/weighted-round-robin-invoke.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/weighted-round-robin-invoke.png)
