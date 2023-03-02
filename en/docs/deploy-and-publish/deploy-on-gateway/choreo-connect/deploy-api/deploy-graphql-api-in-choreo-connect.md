# Deploying a GraphQL API in Choreo Connect

GraphQL is a querying language for APIs that was developed by Facebook. When compared to the REST APIs, GraphQL APIs allow
you to query only the required data. Response will have only the data you requested (over-fetching and under-fetching will not happen). Using a single request you can fetch data
related to multiple resources. This is not possible with REST APIs. If REST API is used, you will have to consider multiple requests
to gather the same amount of data. GraphQL APIs are based on a strong type system. Schema Definition Language (SDL) file defines the
contract between client and the server. It explains how client can access the data provided by the server. This page explains how to 
deploy a GraphQL API in Choero Connect and also explains the supported features of Choreo Connect for GraphQL APIs.

Choreo Connect supports the below features in addition to the basic GraphQL API invocations.

- Runtime configurations
    - Transport level security
    - [GraphQL query analysis (query complexity and query depth limitation)]({{base_path}}/design/rate-limiting/graphql-api/overview-query-limits-for-graphql/#static-query-analyzer)
    - Cross-Origin Resource Sharing (CORS)
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

Below instructions explain how to deploy a GraphQL API to the Choreo Connect via the Publisher Portal in WSO2 API Manager.

!!! info "Before you begin"

    - This guide assumes that you already have a up and running Choreo Connect instance configured with WSO2 API Manager. If not, you can refer to the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/) on how to run Choreo Connect with WSO2 API Manager. To learn more about Choreo Connect related componentes, refer to the [Overview of Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview).
    - You need to have a GraphQL schema file (SDL) and a GraphQL server implementaion relevant to the SDL. You can obtain the SDL file relevant to this example from [here]({{base_path}}/assets/attachments/learn/schema_graphql.graphql) and the server implementation relevant to that SDL file from [here]({{base_path}}/tutorials/create-and-publish-a-graphql-api/#step-1-start-the-graphql-backend-server).

### Step 1 - Create a GraphQL API in WSO2 API Manager Publisher Portal

You can create a GraphQL API in WSO2 API-M Publisher Portal by following the steps described below.


1. Sign in to the API Publisher Portal.

    `https://<hostname>:9443/publisher`

    Example: `https://localhost:9443/publisher`

    Let's use `admin` as the username and password to sign in.

2. Click **Create API** and then click **Import GraphQL SDL**.

    [![Create GraphQL Schema Option]({{base_path}}/assets/img/learn/create-graphql-schema-option.png)]({{base_path}}/assets/img/learn/create-graphql-schema-option.png)

3. Import the schema by dragging and dropping the file or by uploading the file, and click **Next**.

    Let's use the [StarWarsAPI schema definition]({{base_path}}/assets/attachments/learn/schema_graphql.graphql) to create the schema file. 

    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <ul><li>
        <p>You need to define the SDL Schema based on the [GraphQL schema design best practices](https://leapgraph.com/graphql-schema-design-best-practices).</p></li>
        <li>The file extension can be either `.graphql`, `.txt`, or `.json`. </li><li> The file name can be any name, which is based on your preference.</li></ul>
    </div>

    [![Import a GraphQL schema by adding a file]({{base_path}}/assets/img/learn/import-graphql-schema-via-file.png){: style="width:80%"}]({{base_path}}/assets/img/learn/import-graphql-schema-via-file.png)

4. Enter the GraphQL API related details and click **Create**.

    Let's create an API named "StarWarsAPI" using the following sample data.

       <table>
          <thead>
            <tr class="header">
                <th><div>
                    <div>
                        <b>Field</b>
                    </div>
                    </div>
                </th>
          <th><div>
          <div>
          <b>Description</b>
          </div>
          </div></th>
          </tr>
          </thead>
          <td >
             <p>Name</p>
          </td>
          <td>
             <p>StarWarsAPI</p>
          </td>
          </tr>
          <tr>
          <td>
             <p>Context</p>
          </td>
          <td>
             <p><code>/swapi</code></p>
          </td>
          </tr>
          <tr>
          <td>
             <p>Version</p>
          </td>
          <td>
             <p>1.0.0</p>
          </td>
          </tr>
          <tr>
          <td>
             <p>Endpoint</p>
          </td>
          <td>
             <a href="http://hostName:8080/graphql" target="_blank">http://hostName:8080/graphql</a>
          </td>
          </tr>
          </table>

       [![Add GraphQL API details]({{base_path}}/assets/img/learn/create-graphql-api-details.png){: style="width:75%"}](../../assets/img/learn/create-graphql-api-details.png)

5. Click `Create` button.

### Step 2 - Deploy and publish the API


1. Navigate to **Deploy** and click **Deployments** to retrieve the API deployment page.
2. Click **Deploy** to deploy the API in Choreo Connect.

       [![Deploy GraphQL API]({{base_path}}/assets/img/learn/deploy-graphql-api.png)]({{base_path}}/assets/img/learn/deploy-graphql-api.png)

       The Deployment page appears.

       [![GraphQL API Deployment page]({{base_path}}/assets/img/learn/graphql-api-revision-1.png)]({{base_path}}/assets/img/learn/graphql-api-revision-1.png)

3. Navigate to **Publish** and click **Lifecycle**.

       The API lifecycle page appears.

4. Click **Publish** to publish the API to the API Developer Portal.

       [![Publish GraphQL API]({{base_path}}/assets/img/learn/publish-graphql-api.png)]({{base_path}}/assets/img/learn/publish-graphql-api.png)

### Step 3 - Generate an Access Token to invoke the API

1. Click **View in Dev Portal** at the top right corner to open Developer Portal in another browser tab.

2. Open **Applications** from the top menu and select **DefaultApplication** from the list.

3. Open the **Subscriptions** tab and subscribe your API to the **DefaultApplication**. 

4. Open **APIs** from the top menu and select your API.

5. Open the **Try Out** tab and click **GET TEST KEY**. This will include the access token in the cURL command you generate in the section below.

### Step 4 - Invoke the API by providing a valid GraphQL query

1. Since GraphQL APIs require a GraphQL query to provide results, you need to have a valid query. A sample query is provided in the below section. In API Manager Publisher Portal, GraphiQL is used for build queries. You can use the explorer option available there to build queries. For more information regarding valid GraphQL query generation, see [here]({{base_path}}/tutorials/create-and-publish-a-graphql-api/#step-51-optionally-try-out-a-query-operation).

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

    You will get a response for the GraphQL API invocation, as shown below.

    [![Response of GraphQL Query]({{base_path}}/assets/img/learn/graphql-response-query.png)]({{base_path}}/assets/img/learn/graphql-response-query.png)

## Via apictl for Standalone Mode

The CLI tool ([**apictl**]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl)) 
does not support initializing projects for GraphQL APIs yet. However, you can download the sample GraphQL API project from 
[here](https://github.com/wso2/product-microgateway/tree/main/samples/apiProjects/SampleGraphQLApi) and try it out by deploying into the Choreo Connect. When you are using your own GraphQL API with Choreo Connect, you can change the relevant attribute values 
in `api.yaml`, `graphql-complexity.yaml` and `definitions/schema.graphql` files. There is an explanation regarding those attribute values in 
[here](https://github.com/wso2/product-microgateway/tree/main/samples/apiProjects/apiProjects/SampleGraphQLApi/README.md).

The following steps describe how to deploy a GraphQL API in Choreo Connect standalone mode.

### Step 1 - Create an API Project

When using GraphQL APIs in Choreo Connect standalone mode, you need to have an API project. The structure of a sample GraphQL API project is included in below.

```bash
.
├── Definitions
│   ├── graphql-complexity.yaml
│   └── schema.graphql
└── api.yaml

```

!!! note
    - Similar to the sample project, you can deploy your own GraphQL API in Choreo Connect by changing the relevant attribute values that are defined in the `api.yaml` file.
    - `graphql-complexity.yaml` is an optional file where you can define complexities relevant to the GraphQL queries.

### Step 2 - Add a Choreo Connect Environment to apictl

To use apictl with Choreo Connect, a Choreo Connect environment needs to be added to the apictl. This environment will hold the adapter URL for further commands.

``` bash
apictl mg add env dev --adapter https://localhost:9843
```

!!! info

    Note `mg` in the above command. The apictl commands that starts as `apictl mg` are Choreo Connect specific. If a command does not have `mg` after `apictl` then the command could probably be common to both Choreo Connect and API Manager, but it could also be API Manager specific.

!!! tip

    The apictl commands here onwards are executed with the -k flag to avoid SSL verification with the Choreo Connect.

    To communicate via HTTPS without skipping SSL verification (without -k flag), add the cert in the Choreo Connect truststore into the `<USER_HOME>/.wso2apictl/certs` folder.

### Step 3 - Log in to the Choreo Connect Environment in apictl

You can use the following command to log in to the above Choreo Connect cluster (log in to the Choreo Connect adapter). When you log in, an access token will be retrieved from Choreo Connect and it will be saved in the apictl.

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

After exposing the GraphQL API via Choreo Connect, you can invoke an API with a valid access token.

Let's use the following command to generate a JWT to access the API, and set it to the variable `TOKEN`. 

``` tab="Format"
TOKEN=$(curl -X POST "https://<hostname>:<port>/testkey" -d "scope=<scope values>" -H "Authorization: Basic base64(username:password)" -k -v)

```

``` tab="Example"
TOKEN=$(curl -X POST "https://localhost:9095/testkey" -d "" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)

```


### Step 6 - Invoke the API

!!! note
    - Choreo Connect handles GraphQL API requests considering the `POST` HTTP method type only. Therefore, the query given in the request should follow the JSON structure explained [here](https://graphql.org/learn/serving-over-http/#post-request).
    - Request should include one of the http request `Content-Type` headers listed in below. 
        - `-H "Content-Type: application/json"`
        - `-H "Content-Type: application/graphql"`


- Invoke the API using the following cURL command structure.

    ```bash tab="Format"
    curl -X POST "<Docker-hostname>:<Docker-port>/<API-context>/<API-version>" -H "Authorization: Bearer $TOKEN" -d "<query>" -H "Content-Type: application/json" -k 
    ```

    ```bash tab="Example"
    curl -X POST "https://localhost:9095/starwars/1.0.0" -H "Authorization: Bearer $TOKEN" -d '{"query":"query MyQuery { allDroids { appearsIn } }","variables":null}' -H "Content-Type: application/json" -k 
    ```

    ```bash tab="Response"
    {"data":{"allDroids":[{"appearsIn":["NEWHOPE","EMPIRE","JEDI"]},{"appearsIn":["NEWHOPE","EMPIRE","JEDI"]}]}}
    ```