# Deploying a GraphQL API in Choreo Connect

You can deploy GraphQL APIs using Choreo Connect by following one of the two deployment modes described in below.

|**Mode**                               | **Method**    |
|---------------------------------------|---------------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Via WSO2 API Manager Publisher Portal](#via-wso2-api-manager-publisher-portal)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)                  |[Via apictl for Standalone Mode](#via-apictl-for-standalone-mode)                |

## Via WSO2 API Manager Publisher Portal

Below instructions explain how to deploy a GraphQL to the Choreo Connect via the Publisher Portal in WSO2 API Manager. The Publisher Portal provides following capabilities for GraphQL APIs.

- Import and download GraphQL schema file
- Runtime configurations
    - Transport level security
    - [GraphQL query analysis]({{base_path}}/design/rate-limiting/graphql-api/overview-query-limits-for-graphql/#static-query-analyzer)
- [Rate limiting policies (API level and operation level)]({{base_path}}/design/create-api/create-a-graphql-api/#rate-limiting-for-graphql-operations)
- [Security scopes]({{base_path}}/design/create-api/create-a-graphql-api/#authorization-for-graphql-operations)
- Enable/ disable security for GraphQL operations
- Deploy option for multiple gateways
- API life-cycle management

!!! info "Before you begin"

    - This guide assumes that you already have a up and running Choreo Connect instance configured with WSO2 API Manager. If not, checkout the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/) on how to install and run Choreo Connect. To learn more about Choreo Connect, have a look at the [Overview of Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview).
    - Also you need to have a correctly defined GraphQL schema file.

### Step 1 - Create a GraphQL API in API Manager

1. Create a GraphQL API by following the steps in [Create a GraphQL API]({{base_path}}/design/create-api/create-a-graphql-api/#create-a-graphql-api).

### Step 2 - Deploy and publish the API

1. Deploy the API in Choreo Connect by navigating to the **Deployments** page from the left menu. For more information, see the step three and four explained in [here]({{base_path}}/tutorials/create-and-publish-a-graphql-api/#step-3-deploy-the-graphql-api).
2. Publish the API from the **Lifecycle** page.

### Step 3 - Generate an Access Token to invoke the API

1. Click **View in Dev Portal** at the top right corner to open Developer Portal in another browser tab.

2. Open **Applications** from the top menu and select **DefaultApplication** from the list.

3. Open the **Subscriptions** tab and subscribe your API to the **DefaultApplication**. 

4. Open **APIs** from the top menu and select your API.

5. Open the **Subscriptions** tab from the left menu bar, click on **PROD KEYS**, and generate keys.

6. Open the **Try Out** tab and click **GET TEST KEY**. This will include the access token in the cURL command you generate in the section below.

!!! tip 
    To generate a temporary test key to invoke the API, follow the steps [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt/)

### Step 4 - Invoke the API by providing a valid GraphQL query

!!! note
    Currently Choreo Connect supports `query` and `mutation` GraphQL operations only. Upcoming releases will support `subscription` operation also.

1. Since GraphQL APIs require a GraphQL query to provide results, you need to have a valid query. A sample query is provided in below section. In API Manager publisher portal, GraphiQL is used for build queries. You can use explorer option available there to build queries. More information regarding valid GraphQL query generation includes in [here]({{base_path}}/tutorials/create-and-publish-a-graphql-api/#step-51-optionally-try-out-a-query-operation).

``` 
query{
   human(id:1000){
      id
      name
   }
   droid(id:2000){
      name
      friends{
          name
          appearsIn
      }
   }
}
```
2. Click **Execute**.

You will get a response for the GraphQL API invocation, as shown in below.

[![Response of GraphQL Query]({{base_path}}/assets/img/learn/graphql-response-query.png)]({{base_path}}/assets/img/learn/graphql-response-query.png)

If you inspect the network calls from your browser developer tools, you can see the messages passed between the GraphiQL client and the backend.
    


## Via apictl for Standalone Mode

The CLI tool ([**apictl**]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl)) does not support initializing projects for Streaming APIs yet. However, you can download a GraphQL API from a WSO2 API Manager instance and deploy the downloaded project in Choreo Connect. You do not need any special configurations in API-M or Choreo Connect for this. If you do not have a running API Manager instance already, simply download the pack from the [official site](https://wso2.com/api-manager/) and start one locally.

The following are the steps to download and deploy the API using apictl.

### Step 1 - Create an API 

Create a GraphQL API following the steps in [Create a GraphQL API in API Manager](#step-1-create-a-graphql-api-in-api-manager). 

### Step 2 - Download the API

After creating the API and making the necessary changes, click **Download API** in the top right corner. The API will be downloaded as a .zip file and after that it can be deployed via apictl using the next few commands.

{! ./includes/deploy/cc-deploy-api-standalone-mode.md !}

### Step 6 - Generate an access token

{! ./includes/obtain-jwt.md !}

### Step 7 - Invoke the API

!!! note
    Choreo Connect handles GraphQL API requests considering the `POST` HTTP method type only. Therefore, the query given in the request should follow the structure explained in [here](https://graphql.org/learn/serving-over-http/#post-request).


1. Invoke the API using the following cURL command structure.

    ```bash tab="Format"
    curl -X POST "<Docker-hostname>:<Docker-port>/<API-context>/<API-resource>" -H "Authorization: Bearer $TOKEN" -d "<query>"-k 
    ```

    ```bash tab="Example"
    curl -X POST "localhost:9095/gql/1.0.0" -H "Authorization: Bearer $TOKEN" -d '{"query":"{\n hero{\n name\n }\n}","variables":null}'-k 
    ```