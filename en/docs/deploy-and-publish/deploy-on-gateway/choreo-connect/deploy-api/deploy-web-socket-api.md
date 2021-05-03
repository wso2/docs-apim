# Deploy WebSocket API in Choreo Connect

A Web Socket API can be deployed in Choreo Connect via API Manager.

Before You begin

### Step 1 - Create a WebSocket API in API Manager

 Please follow [Create a WebSocket API]({{base_path}}/design/create-api/create-streaming-api/create-a-websocket-streaming-api/) and create the WebSocket API.

### Step 2 - Deploy the API in Choreo Connect environment.
Deploy the API in Choreo Connect by following the [Deploy API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/)

### Step 3 - Generate an Access Token to invoke the API
By default, the WebSocket API is protected by Oauth2 token.

Generate a JWT Access token by following, [Get a Test Key to Invoke an API]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/#get-a-test-key-to-invoke-an-api)

### Invoke the API using a WebSocket client
The websocket api exposed via Choreo Connect, can be invoked by using a WebSocket client.
The JWT token should be set as the Authorization header in the initial WebSocket handshake request.

!!!note
    The same ports 9095 (https) and 9090 (http) are used for WebSocket APIs.

Please follow [Step 4 - Invoke the WebSocket API]({{base_path}}/tutorials/streaming-api/create-and-publish-websocket-api/#step-4-invoke-the-websocket-api) on how to invoke a WebSocket API.
