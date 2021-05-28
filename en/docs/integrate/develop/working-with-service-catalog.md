# Publishing Integrations to the API Manager

A REST API artifact you create from WSO2 Integration Studio is exposed to consumers when you run it on the Micro Integrator runtime. If you want to control and manage this API, and also expose it to an API marketplace where it becomes discoverable to a wider community of consumers, you need to publish this REST API to the API management layer (API-M runtime) of the product.

Follow the steps given below to publish REST APIs from the Micro Integrator to the API-M runtime.

!!! tip "Related Tutorials"
        To try out an end-to-end use case where an integration service is created and used as a managed API, see the tutorial: [Exposing an Integration Service as a Managed API]({{base_path}}/tutorials/integration-tutorials/service-catalog-tutorial).

## Prerequisites

Develop a REST API artifact using WSO2 Integration Studio. This is your integration service with the mediation logic that will run on the Micro Integrator.

!!! Tip
    For instructions on creating a new integration service, use the following documentation: 

    -   [Developing your First Integration Service]({{base_path}}/integrate/develop/integration-development-kickstart).
    -   [Integration Tutorials]({{base_path}}/tutorials/tutorials-overview/#integration-tutorials).

## Step 1 - Update the service metadata

When you create a REST API artifact from WSO2 Integration Studio, a **resources** folder with metadata files is created as shown below. This metadata is used by the API management runtime to generate the API proxy for the service.

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/metadata-folder-service-catalog.png" width="400">

Update the metadata for your service as explained below.

<table>
    <tr>
        <th>
            Parameter
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            description
        </td>
        <td>
            Explain the purpose of the API.
        </td>
    </tr>
    <tr>
        <td>
            serviceUrl
        </td>
        <td>
            This is the URL of the API when it gets deployed in the Micro Integrator. You (as the integration developer) may not know this URL during development. Therefore, you can parameterize the URL to be resolved later using environment variables. By default, the <code>{MI_HOST}</code> and <code>{MI_PORT}</code> values are parameterized with placeholders.</br></br>
            You can configure the serviceUrl in the following ways:
            <ul>
                <li>
                    Add the complete URL without parameters. For example: <code>http://localhost:8290/healthcare</code>.</br>
                </li>
                <li>
                    Parameterize using the host and port combination. For example: <code>http://{MI_HOST}:{MI_PORT}/healthcare</code>.
                </li>
                <li>
                    Parameterize using a preconfigured URL. For example: <code>http://{MI_URL}/healthcare</code>.
                </li>
            </ul>
        </td>
    </tr>
</table>

!!! Tip
    See the [Service Catalog API documentation]({{base_path}}/reference/product-apis/service-catalog-apis/service-catalog-v1/service-catalog-v1/) for more information on the metadata in the YAML file.

## Step 2 - Configure the Micro Integrator server

The Micro Integrator contains a client for publishing integrations to the API-M runtime. To enable this client, update the following in the `deployment.toml` file of your Micro Integrator.

```toml
[[service_catalog]]
apim_host = "https://localhost:9443"
enable = true
username = "admin"
password = "admin"
```

See the descriptions of the [service catalog paramaters]({{base_path}}/reference/config-catalog-mi/#service-catalog-client).

## Step 3 - Start the servers

Once you have created the integration service and deployed it in the Micro Integrator, you only need to start the two servers (API-M server and the Micro Integrator server). 

Note that the API-M server should be started before the Micro Integrator. The client in the Micro Integrator publishes the integration services to the API-M layer during server startup.

## What's Next?

Once the servers are started and the services are published, you can access the service from the API-M layer, and then proceed to **Create**, **Deploy**, and **Publish** the API as follows:

1. [Create and API ]({{base_path}}/design/create-api/create-an-api-using-a-service) using the integration service.
2. [Deploy the API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api) in the API Gateway.
3. [Publish the API]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api) to the Developer Portal.
