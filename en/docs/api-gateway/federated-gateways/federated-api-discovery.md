# Federated API Discovery

WSO2 API Manager supports discovering APIs deployed on external third-party API gateways (such as AWS, Azure, Google Apigee, Kong, etc.) and bringing them under a centralized control plane. 

Publishers can trigger discovery on-demand, inspect the discovered APIs, and selectively import or update them in WSO2 API Manager.

---

## Prerequisites

Before discovering APIs, ensure that the external gateway has been registered as a Gateway Environment in the Admin Portal, with a **Gateway Mode** of **Read Only** or **Read Write**. Discovery is not available for gateways registered in **Write Only** mode.

For gateway-specific registration steps, see the documentation for your gateway type, such as [Apigee]({{base_path}}/api-gateway/federated-gateways/apigee/discover-apis-on-apigee-gateway/), [AWS]({{base_path}}/api-gateway/federated-gateways/aws/discover-apis-on-aws-api-gateway/), [Azure]({{base_path}}/api-gateway/federated-gateways/azure/discover-apis-on-azure-api-gateway/), or [Kong]({{base_path}}/api-gateway/federated-gateways/kong/kong-standalone/discover-apis-on-kong-gateway/).

---

## On-Demand and Scheduled Discovery

Discovery can run in either of the following ways, controlled by the `enable_scheduler` setting in the `<API-M_HOME>/repository/conf/deployment.toml` file:

``` toml
[apim.federated_api_discovery]
enable_scheduler = false
```

- **On-demand discovery (default, `enable_scheduler = false`)**: Discovery runs only when a publisher explicitly triggers it from the Publisher Portal or through the REST API. This is the recommended mode.
- **Scheduled discovery (`enable_scheduler = true`)**: A background task periodically discovers and imports APIs automatically, using the **API Discovery Scheduling Interval** configured on each gateway environment.

!!! note
    The **API Discovery Scheduling Interval** field is required when registering a Read Only or Read Write gateway environment, but it only takes effect when `enable_scheduler` is set to `true`. When scheduled discovery is disabled, the value is retained but not used, so it can be left at `0`.

---

## Discovering and Importing APIs via the Publisher Portal

To discover and import APIs from a registered external gateway:

1. Log in to the Publisher Portal.

    `https://<hostname>:9443/publisher`

1. Click on **Discover APIs** to view the list of configured Gateway Environments.

    [![API Gateways list view]({{base_path}}/assets/img/deploy/federated-gateways-list.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/federated-gateways-list.png)

1. On the gateway environment listing page, click on the specific gateway and proceed.

    [![Discover APIs Dialog]({{base_path}}/assets/img/deploy/discover-apis-dialog.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/discover-apis-dialog.png)

1. Once the discovery process is complete, the portal displays a list of discovered APIs in a table with their details and discovery status:
    * **New**: The API exists on the external gateway but has not been imported to WSO2 API Manager.
    * **Update**: The API has already been imported, and changes have been detected on the external gateway.

    !!! note
        The exact changes that mark an API as **Update** depend on the gateway connector. Connectors typically detect changes such as a new deployment or revision of the API on the external gateway. Changes made only to an API's specification, without any corresponding change to the API on the gateway itself, may not be detected by every connector.

    [![Discovered APIs List]({{base_path}}/assets/img/deploy/discovered-apis-list.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/discovered-apis-list.png)

    To import or update APIs, select the checkbox next to the APIs you want to import or update. To select all discovered APIs at once, check the selection box in the table header. Click **Import** to bring the new APIs into WSO2 API Manager, or click **Update** to sync changes for existing ones.

    Once successfully imported, these APIs will appear in the main Publisher Portal API catalog. From here, you can configure their lifecycle, apply policies, and publish them to the Developer Portal.

---

## Automated Workflow via REST APIs

For automation or CI/CD pipelines, you can programmatically trigger and manage API discovery using the following asynchronous REST APIs.

All the resources given below are relative to the Publisher REST API context, which is `https://<hostname>:9443/api/am/publisher/v4`. These operations require an OAuth 2.0 access token with the `apim:api_create` or `apim:api_manage` scope.

1. **Trigger Discovery**:
    Send a `POST` request to start the discovery task for a registered gateway environment.
    ```http
    POST /federated-apis/discover?environment={gatewayName}
    ```
    * **Response**: Returns a `202 Accepted` status with a `taskId` (e.g., `{"taskId": "df2b5346-c2ba-4b68-8be4-f77df2307ef5"}`).

1. **Poll Status**:
    Poll the task status periodically using the `taskId` returned in the previous step.
    ```http
    GET /federated-apis/status/{taskId}
    ```
    * **Response**: Returns the task status (`PENDING`, `COMPLETED`, or `FAILED`).

1. **Retrieve Cached Results**:
    Once the task status is `COMPLETED`, retrieve the list of discovered APIs cached in the database.
    ```http
    GET /federated-apis/cached?environment={gatewayName}
    ```

1. **Import or Update APIs**:
    Submit the list of APIs you want to import or update. Use the `import` resource for APIs discovered with the **New** status, and the `update` resource for APIs discovered with the **Update** status.
    ```http
    POST /federated-apis/import?environment={gatewayName}
    POST /federated-apis/update?environment={gatewayName}
    ```
    * **Request body**: An array of the APIs to import or update. The `id` of each entry is the identifier returned for that API by the discovery result, and is the only required field. Optionally, provide `displayName` and `description` to override the values discovered from the gateway.

        ``` json
        [
            {
                "id": "abcd1234",
                "displayName": "Customer API",
                "description": "Provides customer details."
            }
        ]
        ```

    * **Response**: Returns a summary of the outcome, where `failedIds` lists the APIs that could not be imported or updated.

        ``` json
        {
            "status": "1 API(s) imported successfully",
            "failedIds": []
        }
        ```

---

## Troubleshooting

| Symptom | Possible cause |
|---|---|
| No APIs are discovered from the gateway. | The APIs are not deployed to the environment configured for the gateway, or the configured credentials do not have permission to list them. Verify the environment name and credentials in the Admin Portal. |
| An imported API contains a single wildcard resource instead of its actual resources. | The API's specification could not be retrieved from the gateway, so a placeholder definition was generated instead. Verify the specification-related configurations and permissions for your gateway type. |
| An API that was changed on the gateway is not listed with the **Update** status. | The change may not be one that the connector detects. See the note under [Discovering and Importing APIs via the Publisher Portal](#discovering-and-importing-apis-via-the-publisher-portal). |
| Discovery fails with an authentication or authorization error. | The credentials configured for the gateway environment are invalid or have expired, or they lack the permissions required to read APIs from the gateway. |

If discovery fails, inspect the API Manager logs for the underlying error reported by the gateway connector.
