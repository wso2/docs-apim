# Deploy WebSocket API in Choreo Connect

A Web Socket API can be deployed in Choreo Connect via API Manager.

!!! info
    **Before you begin**

    This guide assumes that you already have a Choreo Connect instance that is up and running. If not, checkout the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-with-apim) on how to install and run Choreo Connect. To learn more about Choreo Connect, have a look at the [Overview of Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview). 


### Step 1 - Create a WebSocket API in API Manager

 For instructions on how to create a WebSocket API, see [Create a WebSocket API]({{base_path}}/design/create-api/create-streaming-api/create-a-websocket-streaming-api/).

### Step 2 - Deploy the API in the Choreo Connect environment
For more information on deploying the API in Choreo Connect, see [Deploy API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/).

### Step 3 - Generate an Access Token to invoke the API
By default, the WebSocket API is protected by an OAuth2 token.

For more information on generating a JWT Access token, see [Get a Test Key to Invoke an API]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/#get-a-test-key-to-invoke-an-api).

### Invoke the API using a WebSocket client
The WebSocket API exposed via Choreo Connect can be invoked by using a WebSocket client.
The JWT token should be set as the Authorization header in the initial WebSocket handshake request.

!!!note
    The same ports 9095 (HTTPS) and 9090 (HTTP) are used for WebSocket APIs.

Invoke the WebSocket API by carrying out [Step 4]({{base_path}}/tutorials/streaming-api/create-and-publish-websocket-api/#step-4-invoke-the-websocket-api) in the Create and Publish a WebSocket API tutorial.
