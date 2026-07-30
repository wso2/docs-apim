# Discover APIs on Google Apigee Gateway

WSO2 API Manager supports federated API discovery for APIs deployed on Google Apigee. This enables API proxies created and managed in Apigee to be discovered and brought under the centralized control plane of WSO2 API Manager.

Once discovered, these APIs can fully leverage the control plane capabilities of WSO2 API Manager, including:

- **Governance enforcement** – Apply security, compliance, and lifecycle policies consistently.
- **Unified management** – Maintain a centralized view of all APIs, eliminating manual imports and fragmented operations.
- **Developer Portal features** – Provide a unified catalog where developers can discover Apigee-hosted APIs, explore documentation, test endpoints, subscribe to APIs, and access keys and tokens seamlessly.

By integrating Apigee APIs into the control plane, organizations can ensure consistent standards, stronger governance, and improved visibility across their API ecosystem.

Follow the steps below to configure Google Apigee as a Federated API Gateway for API discovery.

## Step 1: Create a GCP Service Account and Generate a JSON Key

1. Log in to the [Google Cloud Console](https://console.cloud.google.com/) and navigate to **IAM & Admin** > **Service Accounts**.
2. Click **Create Service Account** and provide a name (e.g., `wso2-apim-discovery`).
3. Grant the service account the `Apigee API Admin` role (or `Apigee API Reader` for read-only access).

    If you maintain OpenAPI specifications for your API proxies in Apigee API Hub, also grant the `API Hub Viewer` role. Without it, the specifications cannot be read from API Hub, and the APIs are imported with a generated placeholder definition instead of their actual resources.
4. Navigate to the newly created service account, click **Keys** > **Add Key** > **Create new key**.
5. Select **JSON** as the key type and click **Create**. A JSON key file will be downloaded.

    !!!warning
        Keep this JSON key file safe. It contains credentials that grant access to your Apigee organization. You will need to paste the full JSON content when configuring the gateway in WSO2 API Manager.

## Step 2: Register Apigee Gateway as a Federated Gateway in WSO2 API Manager

1. Start WSO2 API Manager.

2. Sign in to the Admin Portal.

    `https://<hostname>:9443/admin`

    `https://localhost:9443/admin`

3. Add a new Gateway Environment.
    1. Select the **Gateway Type** as **Apigee** from the dropdown and provide the relevant details in the fields accordingly.
    2. Select the **Gateway Mode** as **Read Only**.
    3. Under **Gateway Connector Configurations**, provide the following:
        - **Apigee Organization** – The GCP project ID (e.g., `my-gcp-project`).
        - **Apigee Environment** – The target environment name (e.g., `eval`, `test`, `prod`).
        - **Service Account JSON Credentials** – The full contents of the GCP service account JSON key file obtained in Step 1. The content should start with `{` and end with `}`.
        - **API Hostname** – The hostname where APIs are accessible (e.g., `34.49.61.76.nip.io` or `api.example.com`). Leave empty to use the default `{org}-{env}.apigee.net`.
        - **API Hub Location** – The GCP region in which your API Hub instance is provisioned (e.g., `global`, `us-west1`). You can find this in the Google Cloud Console under **Apigee** > **API hub**, where the region is shown with the API hub instance.

            !!! warning
                The **API Hub Location** must match the region of your API hub instance exactly. If it does not, the specifications cannot be retrieved and the APIs are imported with a generated placeholder definition instead of their actual resources. See [OpenAPI Specifications for Discovered APIs](#openapi-specifications-for-discovered-apis).

    4. Provide the scheduling interval for API discovery in minutes (e.g., set to `0` to disable background scheduling).
    5. Save the configurations.

    [![add apigee gateway discovery environment]({{base_path}}/assets/img/deploy/add-apigee-gw-discovery.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/add-apigee-gw-discovery.png)

## Step 3: Discover and Publish to Developer Portal

1. Sign in to the Publisher Portal.

    `https://<hostname>:9443/publisher`

    `https://localhost:9443/publisher`

2. Discover and import your APIs. For step-by-step instructions, see [Federated API Discovery]({{base_path}}/api-gateway/federated-gateways/federated-api-discovery/).
3. Once imported, click on the API from the listing to view its details.
4. From the left menu, click **Lifecycle** and select **Publish** so that the API will deploy to the Developer Portal.

## Step 4: Invoke the API

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`

    `https://localhost:9443/devportal`

2. Navigate to tryout and invoke the API.

!!!note
    The Apigee connector operates in **Read-Only** mode. It only discovers APIs from Apigee, it does not deploy APIs to Apigee.

## OpenAPI Specifications for Discovered APIs

If you maintain OpenAPI specifications for your API proxies in Apigee API Hub, the connector attaches them to the discovered APIs. For a specification to be retrieved, its API Hub entry must reside in the region configured as the **API Hub Location**, and its display name must exactly match the name of the API proxy.

If a specification cannot be retrieved, the API is still imported, but with a generated placeholder definition that exposes a single wildcard resource instead of its actual resources. If you see this, verify the **API Hub Location**, confirm that the API Hub display name matches the proxy name, and ensure that the service account has the `API Hub Viewer` role.
