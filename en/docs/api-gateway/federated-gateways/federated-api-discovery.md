# Federated API Discovery

WSO2 API Manager supports discovering APIs deployed on external third-party API gateways (such as AWS, Azure, Google Apigee, Kong, etc.) and bringing them under a centralized control plane. 

Publishers can trigger discovery on-demand, inspect the discovered APIs, and selectively import or update them in WSO2 API Manager.

---

## Discovering and Importing APIs via the Publisher Portal

To discover and import APIs from a registered external gateway:

1. Log in to the Publisher Portal.
   
   `https://<hostname>:9443/publisher`
   
2. Navigate to **API Gateways** to view the list of configured Gateway Environments.

   [![API Gateways list view]({{base_path}}/assets/img/deploy/federated-gateways-list.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/federated-gateways-list.png)

3. On the APIs listing page, click **Discover APIs** and select the target external gateway environment from the dropdown list in the dialog.

   [![Discover APIs Dialog]({{base_path}}/assets/img/deploy/discover-apis-dialog.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/discover-apis-dialog.png)

4. Click **Discover**. WSO2 API Manager will connect to the selected gateway and fetch the deployed APIs.

5. Once the discovery process is complete, the portal displays a list of discovered APIs in a table with their details and discovery status:
   * **New**: The API exists on the external gateway but has not been imported to WSO2 API Manager.
   * **Update**: The API has been imported, but updates (e.g., OpenAPI spec changes) are available on the external gateway.

   [![Discovered APIs List]({{base_path}}/assets/img/deploy/discovered-apis-list.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/discovered-apis-list.png)

6. To import or update APIs:
   * Select the checkbox next to the APIs you want to import or update. To select all discovered APIs at once, check the selection box in the table header.
   * Click **Import** to bring the new APIs into WSO2 API Manager, or click **Update** to sync changes for existing ones.

7. Once successfully imported, these APIs will appear in the main Publisher Portal API catalog. From here, you can configure their lifecycle, apply policies, and publish them to the Developer Portal.

---

## Automated Workflow via REST APIs

For automation or CI/CD pipelines, you can programmatically trigger and manage API discovery using the following asynchronous REST APIs:

1. **Trigger Discovery**:
   Send a `POST` request to start the discovery task for a registered gateway environment.
   ```http
   POST /federated-apis/discover?environment={gatewayName}
   ```
   * **Response**: Returns a `202 Accepted` status with a `taskId` (e.g., `{"taskId": "df2b5346-c2ba-4b68-8be4-f77df2307ef5"}`).

2. **Poll Status**:
   Poll the task status periodically using the `taskId` returned in the previous step.
   ```http
   GET /federated-apis/status/{taskId}
   ```
   * **Response**: Returns the task status (`PENDING`, `COMPLETED`, or `FAILED`).

3. **Retrieve Cached Results**:
   Once the task status is `COMPLETED`, retrieve the list of discovered APIs cached in the database.
   ```http
   GET /federated-apis/cached?environment={gatewayName}
   ```

4. **Import or Update APIs**:
   Submit the list of APIs you want to import or update.
   ```http
   POST /federated-apis/import?environment={gatewayName}
   POST /federated-apis/update?environment={gatewayName}
   ```
