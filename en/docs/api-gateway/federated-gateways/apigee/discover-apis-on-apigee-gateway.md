# Discover APIs on Google Apigee Gateway

WSO2 API Manager supports federated API discovery for APIs deployed on Google Apigee. This enables API proxies created and managed in Apigee to be discovered and brought under the centralized control plane of WSO2 API Manager.

Once discovered, these APIs can fully leverage the control plane capabilities of WSO2 API Manager, including:

Governance enforcement – apply security, compliance, and lifecycle policies consistently.

Unified management – maintain a centralized view of all APIs, eliminating manual imports and fragmented operations.

Developer Portal Features – provide a unified catalog where developers can discover Apigee-hosted APIs, explore documentation, test endpoints, subscribe to APIs, and access keys and tokens seamlessly.

By integrating Apigee APIs into the control plane, organizations can ensure consistent standards, stronger governance, and improved visibility across their API ecosystem.

Follow the steps below to configure Google Apigee as a Federated API Gateway for API discovery.

## Step 1: Create a GCP Service Account and Generate a JSON Key

1. Log in to the [Google Cloud Console](https://console.cloud.google.com/) and navigate to **IAM & Admin** > **Service Accounts**.
2. Click **Create Service Account** and provide a name (e.g., `wso2-apim-discovery`).
3. Grant the service account the `Apigee API Admin` role (or `Apigee API Reader` for read-only access). Optionally add the `API Hub Viewer` role for API Hub spec retrieval.
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
        - **API Hub Location** – The GCP region where API Hub is deployed (e.g., `global`, `us-west1`).
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
