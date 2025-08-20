# Multi-Model Routing

AI APIs often require flexibility in routing requests to multiple models within the same AI provider. The Multi-Model Routing feature in WSO2 API Manager enables API creators to define and enforce routing strategies for distributing requests across different AI models. This ensures efficient resource utilization, enhances reliability, and optimizes performance.

With Multi-Model Routing, API designers can configure either of the following routing strategies:

1. Load Balancing – Distributes requests across multiple models in a round-robin fashion within the same AI provider.
2. Failover – Redirects traffic to configured fallback models within the same AI provider when the primary model becomes unavailable.

We cater to your multi-model routing requirements via **AI Policies**. Listed below are the policies that you can use:

- Model Round Robin Policy
- Model Weighted Round Robin Policy
- Model Failover Policy

!!! tip
     You can only attach one of these AI Policies to your AI API based on your routing requirements, unless you are using the Failover policy. You can attach multiple Failover policies by configuring different primary models.

### Prerequisites

Before moving into the routing stratergy enforcement be sure to complete the following two prerequisites:

- Add the AI/LLM Service Provider supported **model list** under the Admin Portal
- Add the required **endpoints** alongside the API Key for AI service access

Detailed below is how to complete these two prerequisites:

#### Configuring Model List

Make sure to add the model list you desire to utilize prior to moving into the AI policy configuraiton section.

!!! tip
     Note that the models that are listed under the corresponding AI/LLM Service Provider gets listed down as available models at the time of policy configuration. 

1. Login to the Admin Portal (`https://<hostname>:9443/admin`).
2. Navigate to **AI/LLM Service Providers** section from the left menu.
3. Select the Service Provider which you used to create your AI API.
4. Find the `Model List` section and make sure to add in the models which you used to consume using the AI API. You can do so by typing in the model name and pressing `Enter` to add them.
5. Once the model list is added, click on **Update** to save the changes you made to the AI Service Provider.

#### Configuring Endpoints

If you require multiple endpoints and multiple AI Service Provider API Keys to manage your multi-model routing requirements, make sure to add them before moving to the AI policy configuration section.

1. Login to the Publisher Portal (`https://<hostname>:9443/publisher`).
2. Navigate to **API Configurations**, and click **Endpoints**.
3. Click on **Add New Endpoint**.
4. Fill out the endpoint related details.

    <table>
        <tr>
            <th>Field</td>
            <th>Sample Value</td>
        </tr>
        <tr>
            <td>Endpoint Type</td>
            <td>Production</td>
        </tr>
        <tr>
            <td>Endpoint Name</td>
            <td>Prod</th>
        </tr>
        <tr>
            <td>Endpoint URL</td>
            <td>https://api.openai.com/v1</td>
        </tr>
        <tr>
            <td>API Key</td>
            <td>Add the API Key obtained from the AI Service Provider</td>
        </tr>
    </table>

    [![Multiple Endpoint Add]({{base_path}}/assets/img/learn/ai-gateway/endpoint-add.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/endpoint-add.png)

5. Click on **Create**.
6. Repeat steps 3 to 5 if you wish to add more production/sandbox endpoints.
