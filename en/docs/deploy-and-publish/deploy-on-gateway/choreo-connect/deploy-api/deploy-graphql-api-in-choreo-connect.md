# Deploying a GraphQL API in Choreo Connect

Choreo Connect supports below features additionally to the basic GraphQL API invocations.

- Runtime configurations
    - Transport level security
    - [GraphQL query analysis (query complexity and query depth limitation)]({{base_path}}/design/rate-limiting/graphql-api/overview-query-limits-for-graphql/#static-query-analyzer)
- [Rate limiting policies (API level and operation level) with the support of WSO2 API-M]({{base_path}}/design/create-api/create-a-graphql-api/#rate-limiting-for-graphql-operations)
- [Security scopes]({{base_path}}/design/create-api/create-a-graphql-api/#authorization-for-graphql-operations)
- Enable/ disable security for GraphQL operations

!!! note
    Currently Choreo Connect supports **`query`** and **`mutation`** GraphQL operations only.

You can deploy GraphQL APIs using Choreo Connect by following one of the two deployment modes described in below.

|**Mode**                               | **Method**    |
|---------------------------------------|---------------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Via WSO2 API Manager Publisher Portal](#via-wso2-api-manager-publisher-portal)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)                  |[Via apictl for Standalone Mode](#via-apictl-for-standalone-mode)                |

## Via WSO2 API Manager Publisher Portal

Below instructions explain how to deploy a GraphQL to the Choreo Connect via the Publisher Portal in WSO2 API Manager.

!!! info "Before you begin"

    - This guide assumes that you already have a up and running Choreo Connect instance configured with WSO2 API Manager. If not, checkout the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/) on how to install and run Choreo Connect. To learn more about Choreo Connect, have a look at the [Overview of Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview).
    - Also you need to have a correctly defined GraphQL schema file (SDL).

### Step 1 - Create a GraphQL API in API Manager

1. Create a GraphQL API in WSO2 API-M publisher portal by following the step number two in [here]({{base_path}}/design/create-api/create-a-graphql-api/#step-2-design-a-graphql-api).

### Step 2 - Deploy and publish the API

1. Deploy the API in Choreo Connect by navigating to the **Deployments** page in API-M publisher portal. For more information, see the step three and four explained in [here]({{base_path}}/tutorials/create-and-publish-a-graphql-api/#step-3-deploy-the-graphql-api).
2. Change the API's life cycle state from **CREATED** to **PUBLISHED** in order to make it visible in the WSO2 API-M Dev Portal.

### Step 3 - Generate an Access Token to invoke the API

1. Click **View in Dev Portal** at the top right corner to open Developer Portal in another browser tab.

2. Open **Applications** from the top menu and select **DefaultApplication** from the list.

3. Open the **Subscriptions** tab and subscribe your API to the **DefaultApplication**. 

4. Open **APIs** from the top menu and select your API.

5. Open the **Subscriptions** tab from the left menu bar, click on **PROD KEYS**, and generate keys.

6. Open the **Try Out** tab and click **GET TEST KEY**. This will include the access token in the cURL command you generate in the section below.

### Step 4 - Invoke the API by providing a valid GraphQL query

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

### Step 1 - Create an API Project

When using GraphQL APIs in Choreo Connect standalone mode, you need to have an API project. Structure of a sample GraphQL API project included in below.

```bash
.
├── Definitions
│   ├── graphql-complexity.yaml
│   └── schema.graphql
└── api.yaml

```

!!! note
    - Similar to the sample project, you can deploy your own GraphQL API in Choreo Connect by changing the relevant attribute values that are defined in the `yaml` files.
    - `graphql-complexity.yaml` is an optional file where you can define complexities relevant to the GraphQL queries.

You can download a sample GraphQL API project from [here](link) to try out this deployment mode.

### Step 2 - Add a Choreo Connect Environment to apictl

To use apictl with Choreo Connect, a Choreo Connect environment needs to be added to apictl. This environment will hold the adapter URL for further commands.

``` bash
apictl mg add env dev --adapter https://localhost:9843
```

!!! info

    Note `mg` in the above command. The apictl commands that starts as `apictl mg` are Choreo Connect specific. If a command does not have `mg` after `apictl` then the command could probably be common to both Choreo Connect and API Manager, but it could also be API Manager specific. 

!!! tip

    The apictl commands here onwards are executed with the -k flag to avoid SSL verification with the Choreo Connect.

    To communicate via HTTPS without skipping SSL verification (without -k flag), add the cert in the Choreo Connect truststore into the `<USER_HOME>/.wso2apictl/certs` folder.

### Step 3 - Log in to the Choreo Connect Environment in apictl

You can use the following command to log in to the above Choreo Connect cluster (log in to the Choreo Connect adapter). When you log in, an access token will be retrieved from Choreo Connect and it will be saved in  the apictl.

``` bash tab="Format"
apictl mg login dev -u <username> -p <password> -k
```

``` bash tab="Example"
apictl mg login dev -u admin -p admin -k
```

### Step 4 - Deploy the API

Now let's deploy the API to Choreo Connect by executing the following command.     

``` bash
apictl mg deploy api -f <path_to_the_API_project_just_created>/<gqlProjectName> -e dev -k
```  

### Step 5 - Generate an access token

After the APIs are exposed via Choreo Connect, you can invoke an API with a valid access token.

Let's use the following command to generate a JWT to access the API, and set it to the variable `TOKEN`. 

``` tab="Format"
TOKEN=$(curl -X POST "https://<hostname>:<port>/testkey" -d "scope=<scope values>" -H "Authorization: Basic base64(username:password)" -k -v)

```

``` tab="Example"
TOKEN=$(curl -X POST "https://localhost:9095/testkey" -d "" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)

```


### Step 6 - Invoke the API

!!! note
    - Choreo Connect handles GraphQL API requests considering the `POST` HTTP method type only. Therefore, the query given in the request should follow the JSON structure explained in [here](https://graphql.org/learn/serving-over-http/#post-request).
    - Request should include one of the http request `Content-Type` headers listed in below. 
        - `-H "Content-Type: application/json"`
        - `-H "Content-Type: application/graphql"`


1. Invoke the API using the following cURL command structure.

    ```bash tab="Format"
    curl -X POST "<Docker-hostname>:<Docker-port>/<API-context>/<API-version>" -H "Authorization: Bearer $TOKEN" -d "<query>" -H "Content-Type: application/json" -k 
    ```

    ```bash tab="Example"
    curl -X POST "https://localhost:9095/starwars/1.0.0" -H "Authorization: Bearer $TOKEN" -d '{"query":"query MyQuery { allDroids { appearsIn } }","variables":null}' -H "Content-Type: application/json" -k 
    ```

    ```bash tab="Response"
    {"data":{"allDroids":[{"appearsIn":["NEWHOPE","EMPIRE","JEDI"]},{"appearsIn":["NEWHOPE","EMPIRE","JEDI"]}]}}
    ```