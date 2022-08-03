# Deploying a WebSocket API in Choreo Connect

You can deploy a WebSocket API in the following ways depending on the Choreo Connect **mode** you have chosen.


|**Mode**         | **Method**    |
|--------------|-----------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Via WSO2 API Manager Publisher Portal](#via-wso2-api-manager-publisher-portal)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)  |[Via apictl for Standalone Mode](#via-apictl-for-standalone-mode) |


!!! tip "Characteristics of WebSocket APIs Deployed in Choreo Connect"
    - The API is created based on the **Channels** defined in the AsyncAPI definition. They are also known as **Topics** in WSO2 API Manager, and have a slight similarity to **Resources** in a REST API.
    - Once the API is exposed, although the Gateway endpoint includes a basepath (with topic paths if defined), the **Connection Request** will be sent to the original backend endpoint you provided without any appended paths.
    - If you have a requirement to append different **paths** to the backend URL for different **Channels** (**Topics**), a URL-mapping can be added. The **Topics** that do not include a URL-mapping will have the usual behavior as mentioned above.
    - WebSocket APIs support OAuth 2.0 Security and each **Topic** can have its own local scope.         
    - If configured, Choreo Connect is also capable of publishing analytics for WebSocket frames sent and received by the client.         
    - **Pub** is prioritized over **Sub**. Currently, properties such as URL Mapping and Security are supported at Pub/Sub level rather than per topic (similar to REST APIs). Therefore, in WebSocket APIs, these must be defined under **Publish** or **Subscribe**. Yet, from a Gateway point of view, both Publish and Subscribe are initiated with a GET request that appears the same. Hence, if a **Topic** has both Publish and Subscribe, the properties for **Publish** will be prioritized.

## Via WSO2 API Manager Publisher Portal

Follow the instructions below to deploy a WebSocket type Streaming API to Choreo Connect via the Publisher Portal in WSO2 API Manager. The Publisher Portal provides the capability to conveniently add and update the following.

- The AsyncAPI definition
- Rate limiting policies
- Security scopes
- URL mappings

!!! info "Before you begin"

    This guide assumes that you already have a Choreo Connect instance configured to run with API Manager. If not, checkout the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/) on how to install and run Choreo Connect. To learn more about Choreo Connect, have a look at the [Overview of Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview).


### Step 1 - Create a WebSocket API in API Manager

1. Create a WebSocket API by following the steps in [Create a WebSocket API]({{base_path}}/design/create-api/create-streaming-api/create-a-websocket-streaming-api/).

2. By default, a WebSocket API is protected by OAuth2 in Choreo Connect. Make sure to switch on security for the API via Publisher and **Save**.

    [![Security switched on]({{base_path}}/assets/img/design/create-api/streaming-api/streaming-api-security-on.png)]({{base_path}}/assets/img/design/create-api/streaming-api/streaming-api-security-on.png)

### Step 2 - Deploy and publish the API

1. Deploy the API in Choreo Connect by navigating to the **Deployments** page from the left menu. For more information, see [Deploy API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/).
2. Publish the API from the **Lifecycle** page.

### Step 3 - Generate an Access Token to invoke the API

!!! tip 
    To generate a temporary test key to invoke the API, follow the steps [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt/)

1. Click **View in Dev Portal** at the top right corner to open Developer Portal in another browser tab.

2. Open **Applications** from the top menu and select **DefaultApplication** from the list.

3. Open the **Subscriptions** tab and subscribe your API to the **DefaultApplication**.

4. Open **APIs** from the top menu and select your API.

5. Open the **Subscriptions** tab from the left menu bar, click on **PROD KEYS**, and generate keys.

6. Open the **Try Out** tab and click **GET TEST KEY**. This will include the access token in the cURL command you generate in the section below.

### Step 4 - Invoke the API using a WebSocket client

The WebSocket API exposed via Choreo Connect can be invoked using a WebSocket client.

1. Install wscat client.

2. From Developer Portal resource tab open the topic `/notifications` and generate the cURL command.

3. Open a command-line interface and run the cURL command.

4. Once connected, type anything you want. The websocket server you are connected to must echo back what you type.

!!! note
    Choreo Connect handles websocket connections via the same ports used for HTTP (9090) and HTTPS (9095).

## Via apictl for Standalone Mode

The CLI tool **apictl** does not support initializing projects for Streaming APIs yet. However, you can download a WebSocket API from a WSO2 API Manager instance and deploy the downloaded project in Choreo Connect. You do not need any special configurations in API-M or Choreo Connect for this. If you do not have a running API Manager instance already, simply download the pack from the [official site](https://wso2.com/api-manager/) and start one locally.

The following are the steps to download and deploy the API using apictl.

### Step 1 - Create an API 

Create a WebSocket API following the exact steps in [Create a WebSocket API in API Manager](#step-1-create-a-websocket-api-in-api-manager). 

### Step 2 - Download the API

After creating the API and making the necessary changes, click **Download API** in the top right corner. The downloaded .zip file can be deployed via apictl using the next few commands.

{! ./includes/deploy/cc-deploy-api-standalone-mode.md !}

### Step 6 - Generate an access token

{! ./includes/obtain-jwt.md !}

### Step 7 - Invoke the API

1. Install wscat client.

2. Invoke the API using the following command.

    ```
    wscat -c 'ws://localhost:9090/websocket/1.0.0/notification -H "Authorization:Bearer $TOKEN"
    ```

