# Publish Integrations to the Service Catalog

The **Service Catalog** connects the integation layer and the API management layer of WSO2 API-M 4.0.0. The integration services (REST APIs artifacts) that you develop using WSO2 Integration Studio can be published to the service catalog during deployment. 

This allows API creators to create new API proxies from integration services and expose them to an API marketplace where application developers can discover and use them. An API proxy created from the API Publisher is a managed API. That is, API managers can control the API's lifecycle, apply security, and rate limiting conditions. These API proxies can be monitized and exposed in an API marketplace. Therefore, by using the service catalog, integration services with complex mediation sequences can easily be converted to managed APIs and exposed to an API marketplace.

As an integration developer, be mindful of the following requirements when you develop integrations for the **Service Catalog**:

## Update the service metadata

When you create a REST API artifact from WSO2 Integration Studio, a **resources** folder with metadata files are created as shown below.

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/metadata-folder-service-catalog.png" width="400">

The service's metadata will be used by the API management runtime to generate the API proxy for the service.

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
            This is the URL of the API when it gets deployed in the Micro Integrator. You (as the integration developer) may not know this URL during development. Therefore, you can parameterize the URL to be resolved later using environment variables. By default, the <code>{host}</code> and <code>{port}</code> values are parameterized with placeholders.</br></br>
            You can configure the serviceUrl in the following ways:
            <ul>
                <li>
                    Add the complete URL without parameters. For example: <code>http://localhost:8290/healthcare</code>.</br>
                </li>
                <li>
                    Parameterize using the host and port combination. For example: <code>http://{host}:{port}/healthcare</code>.
                </li>
                <li>
                    Parameterize using a preconfigured URL. For example: <code>http://{url}/healthcare</code>.
                </li>
            </ul>
        </td>
    </tr>
</table>

!!! Tip
    See the [Service Catalog API documentation]({{base_path}}/reference/product-apis/service-catalog-apis/service-catalog-v1/service-catalog-v1/) for more information on the metadata in the YAML file.

## Enable the Service Catalog client

The Micro Integrator contains a client for publishing integrations to the Service Catalog. Be sure to enable the following configurations in the `deployment.toml` file of your Micro Integrator.

```toml
[[service_catalog]]
apim_host = "https://localhost:9443"
enable = true
username = "admin"
password = "admin"
```

See the descriptions of the [service catalog paramaters]({{base_path}}/reference/config-catalog-mi/#service-catalog-client).

## Start the servers

Once you have created the integration service and deployed it in the Micro Integrator, you only need to start the two servers (API-M server and the Micro Integrator server). Note that the API-M server should be started before the Micro Integrator. The Service Catalog client in the Micro Integrator publishes the integration services to the API-M layer during server startup.

## Create an API from a service

Once the servers are started and the services are published, you can sign in to the **Publisher** of WSO2 API-M, access the **Service Catalog**, and then create an API for the service.

See [Creating a API using a integration service]({{base_path}}/design/create-api/create-an-api-using-a-service).
