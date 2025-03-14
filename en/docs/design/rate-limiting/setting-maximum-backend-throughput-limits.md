# Setting Maximum Backend Throughput Limits

You can define the maximum backend throughput setting to limit the total number of calls a particular API in API Manager is allowed to make to the backend. While the [other rate limiting levels]({{base_path}}/design/rate-limiting/setting-throttling-limits) define the quota the API invoker gets, they do not ensure that the backend is protected from overuse. The maximum backend throughput configuration limits the quota the backend can handle. The request count is calculated and rate limiting occurs at the node level. 

{!includes/design/redis-counter-note.md!}

Follow the instructions below to set a maximum backend throughput for a given API:

1.  Sign in to the WSO2 API Publisher `https://<hostname>:9443/publisher`.

2.  Click on the API for which you want to set the maximum backend throughput.
    
    [![Select API]({{base_path}}/assets/img/learn/select-api-with-business-info.png){: style="width:30%"}]({{base_path}}/assets/img/learn/select-api-with-business-info.png)
    
3.  Navigate to **API Configurations** and click **Runtime**.

4.  Select the **Specify** option for the maximum backend throughput and specify the limits of the Production and Sandbox endpoints separately, as the two endpoints can come from two servers with different capacities.

    [![Max Throughput]({{base_path}}/assets/img/learn/learn-throttling-maxtps.png)]({{base_path}}/assets/img/learn/learn-throttling-maxtps.png)
    
5.  Save the API.
    
     When the maximum backend throughput quota is reached for a given API, more requests will not be accepted for that particular API. The following error message will be returned for all the throttled out requests.

    ```json
    {
      "fault": {
        "code": 900801,
        "message": "API Limit Reached",
        "description": "API not accepting requests"
      }
    }
    ```  

## Setting Maximum Backend Throughput Limits for AI APIs

For AI APIs, WSO2 API Manager provides enhanced rate limiting features by introducing token-based backend rate limiting in addition to traditional request-based limits. This ensures that AI API backends, which often deal with tokenized resources are protected from overuse.

### Token-Based Backend Rate Limiting

Unlike the default APIs that use request counts to limit backend throughput, AI APIs use token-based quotas to enforce backend limitations. These quotas help manage the number of tokens consumed by backend services, ensuring that AI models and other backend components aren't overwhelmed by excessive requests.

Follow the steps below to configure token-based backend rate limiting for AI APIs:

1. Sign in to the WSO2 API Publisher at `https://<hostname>:9443/publisher`.

2. Select the AI API for which you want to set the maximum backend throughput.

3. Navigate to **API Configurations** and click **Runtime**.

4. In the **Backend Throughput** section, select the **Specify** option to define the token-based limits. You can configure the following quotas:

    - **Total Token Count**: Limits the total number of tokens that can be consumed by the backend.
    - **Prompt Token Count**: Limits the number of tokens used in prompts sent to the backend AI model.
    - **Completion Token Count**: Limits the number of tokens generated as the output of an AI model from the backend.

    [![Max Backend Throughput for AI APIs]({{base_path}}/assets/img/learn/learn-throttling-maxtps-tokens.png)]({{base_path}}/assets/img/learn/learn-throttling-maxtps-tokens.png)

5. Set the limits for both **Production** and **Sandbox** environments separately, as each environment may have different resource capacities.

6. Save the API.

This token-based backend rate limiting feature for AI APIs ensures that the backend resources are utilized efficiently and not exhausted by overconsumption.
