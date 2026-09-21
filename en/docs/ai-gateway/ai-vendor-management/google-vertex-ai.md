# Google Vertex AI

!!! note
    - This feature is available in WSO2 API Manager 4.6.0 starting from update level 47.
    - This feature is available in WSO2 API Manager Control Plane 4.6.0 starting from update level 48.
    - This feature is available in WSO2 API Manager Universal Gateway 4.6.0 starting from update level 46.

Google Cloud's [Vertex AI](https://cloud.google.com/vertex-ai/docs) is a platform that hosts foundation models from a range of providers. WSO2 API Manager integrates with Vertex AI as a **default AI Service Provider**, so you can expose and govern Vertex AI models through the AI Gateway.

!!! note "Supported Vertex AI models"
    WSO2 API Manager 4.6.0 supports only **Anthropic Claude** models on Vertex AI, through the built-in `VertexAI-Anthropic` service provider.

Unlike the other default providers, Vertex AI is not accessed with a simple API key &mdash; every request is authenticated with a **Google Cloud service account** using OAuth 2.0, and the Gateway obtains and injects the access token on your behalf. See [Authentication](#authentication).

## Configuring Google Vertex AI

Follow these steps to review and customize the Vertex AI provider in your API Manager environment.

### Step 1: Access Configuration

1. Login to the Admin Portal (`https://<hostname>:9443/admin`).
2. Navigate to the **AI Service Providers** section in the left navigation pane.
3. Find **VertexAI-Anthropic** in the list and click on it to edit the configuration.

[![Vertex AI Configuration]({{base_path}}/assets/img/learn/ai-gateway/vertex-ai-config.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/vertex-ai-config.png)

### Step 2: Configure Models

#### Read-Only Configurations

The following configurations are **read-only** and cannot be modified:

<table>
    <thead>
        <tr>
            <th style="width: 30%">Category</th>
            <th style="width: 70%">Fields</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>General Details</strong></td>
            <td>
                • Name<br>
                • API Version<br>
                • Description
            </td>
        </tr>
        <tr>
            <td><strong>LLM Configurations</strong></td>
            <td>
                • Request Model<br>
                • Response Model<br>
                • Prompt Token Count<br>
                • Completion Token Count
            </td>
        </tr>
        <tr>
            <td><strong>LLM Provider Auth Configurations</strong></td>
            <td>
                • Auth Type: <code>gcp</code> (Google Cloud service-account OAuth 2.0)
            </td>
        </tr>
        <tr>
            <td><strong>Connector Type for AI Service Provider</strong></td>
            <td>
                • Connector Type
            </td>
        </tr>
    </tbody>
</table>

#### Editable Configurations

The following configurations can be updated:

<table>
    <thead>
        <tr>
            <th style="width: 30%">Category</th>
            <th style="width: 70%">Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>API Definition</strong></td>
            <td>AI service provider exposed API definition file.</td>
        </tr>
        <tr>
            <td><strong>Model List</strong></td>
            <td>Add the list of models supported by the AI service provider. This list enables you to configure routing strategies within your AI APIs.</td>
        </tr>
    </tbody>
</table>

- By default, the following models are included: `claude-sonnet-4`, `claude-3-5-sonnet-v2`, and `claude-3-5-haiku`.
- To add available models supported by Claude on Vertex AI, type the model name and press enter.
- This enables model-based load balancing and failover capabilities. For more details, see [Multi-Model Routing Overview]({{base_path}}/ai-gateway/multi-model-routing/overview/).

!!! Note
    Make sure the models you add are available &mdash; and enabled in Vertex AI Model Garden &mdash; in the Google Cloud region you configure on the AI API endpoint. See [Step 1: Grant Vertex AI permissions in Google Cloud](#step-1-grant-vertex-ai-permissions-in-google-cloud).

### Step 3: Save Configuration

Click **Update** to apply your changes. The updated configuration is then available for use in your AI APIs.

## Authentication

Every request to Vertex AI is authenticated with a **Google Cloud service account** over OAuth 2.0. The Gateway mints a short-lived access token for the service account (using the JWT-bearer grant), caches it, and adds it as a `Bearer` token on each outbound request to Vertex AI. You never send a static API key.

There are two ways for the Gateway to obtain the service-account credentials, configured per endpoint:

<table>
    <thead>
        <tr>
            <th style="width: 30%">Credential Mode</th>
            <th style="width: 70%">Behavior</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Service-account key</strong></td>
            <td>You upload the service-account key JSON on the endpoint. The Gateway signs a JWT with the key's private key and exchanges it for an access token. The key is <strong>encrypted at rest</strong> in API Manager. Use this when the Gateway does not run on Google Cloud.</td>
        </tr>
        <tr>
            <td><strong>Keyless (attached identity)</strong></td>
            <td>You leave the key empty. The Gateway uses the GCP identity <strong>attached to its own workload</strong> &mdash; the equivalent of Application Default Credentials / Workload Identity &mdash; obtaining tokens from the GCP metadata server. No key is stored, mounted, or rotated. Requires the Gateway to run on Google Cloud (GCE, GKE with Workload Identity, Cloud Run, ...) with a service account attached.</td>
        </tr>
    </tbody>
</table>

!!! Note "Service-account key storage"
    An uploaded service-account key is encrypted at rest. When you reopen the endpoint, the key is shown as already configured (masked) rather than returned in clear text. To switch an endpoint to keyless, clear the stored key.

### Step 1: Grant Vertex AI permissions in Google Cloud

The service account that the Gateway uses (whether via an uploaded key or the attached identity) must be permitted to invoke the models you configured.

1. Log in to the [Google Cloud Console](https://console.cloud.google.com/) and select the project you will call Vertex AI in.
2. Ensure the **Vertex AI API** (`aiplatform.googleapis.com`) is enabled for the project.
3. Under **IAM & Admin → Service Accounts**, create (or select) a service account and grant it the **Vertex AI User** role (`roles/aiplatform.user`), which includes the `aiplatform.endpoints.predict` permission needed to invoke models. For more information, see [Vertex AI access control with IAM](https://cloud.google.com/vertex-ai/docs/general/access-control).
4. Enable/accept the Claude models you intend to use in [Vertex AI Model Garden](https://cloud.google.com/vertex-ai/generative-ai/docs/partner-models/use-claude) &mdash; this is a one-time, project-level step, separate from the service-account role.
5. Provide the credentials to the Gateway according to the credential mode:
    - **Service-account key** &mdash; create a JSON key for the service account (**Keys → Add key → Create new key → JSON**) and download it. You will upload this file on the endpoint.
    - **Keyless (attached identity)** &mdash; attach the service account to the Google Cloud workload the Gateway runs on, so the metadata server issues tokens for it. No key file is required.
6. Note the Google Cloud **region** (for example, `us-east5`) and **project ID** you will use. The region must be one where your chosen models are available, and it is used to build the endpoint URL.

!!! Important
    The Gateway requests the `https://www.googleapis.com/auth/cloud-platform` OAuth scope. Make sure the service account (and, in keyless mode, the attached identity) is authorized for Vertex AI in the project and region you target.

### Step 2: Configure Authentication on the AI API Endpoints

1. Sign in to the Publisher Portal (`https://<hostname>:9443/publisher`) and open the AI API that uses **VertexAI-Anthropic** as its AI service provider.
2. Navigate to **API Configurations → Endpoints**.
3. Click the **Edit** icon of the endpoint you want to configure and set the **Endpoint URL** using the structured builder:

    <table>
        <thead>
            <tr>
                <th style="width: 30%">Field</th>
                <th style="width: 70%">Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Endpoint Location</strong></td>
                <td>Choose <strong>Regional</strong> (call a specific Google Cloud region) or <strong>Global</strong> (the multi-region endpoint).</td>
            </tr>
            <tr>
                <td><strong>Region</strong></td>
                <td>The Google Cloud region for a regional endpoint (for example, <code>us-east5</code>). The region is written into <em>both</em> the host prefix and the <code>locations</code> path of the URL, so it is entered once and kept consistent for you. Not required for a global endpoint.</td>
            </tr>
            <tr>
                <td><strong>Project ID</strong></td>
                <td>Your Google Cloud project ID.</td>
            </tr>
        </tbody>
    </table>

    The builder assembles the Vertex AI URL for you. For reference, the underlying template is:

    `https://{region}-aiplatform.googleapis.com/v1/projects/{project_id}/locations/{region}/publishers/anthropic/models`

    [![Vertex AI Endpoint URL Builder]({{base_path}}/assets/img/learn/ai-gateway/vertex-ai-endpoint-url.png){: style="width:100%"}]({{base_path}}/assets/img/learn/ai-gateway/vertex-ai-endpoint-url.png)

4. Configure the **GCP Service Account Key** section according to the credential mode:

    <table>
        <thead>
            <tr>
                <th style="width: 30%">Credential Mode</th>
                <th style="width: 70%">Action</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Service-account key</strong></td>
                <td>Upload the service-account key JSON (drag and drop, or browse). The key is validated and stored encrypted.</td>
            </tr>
            <tr>
                <td><strong>Keyless (attached identity)</strong></td>
                <td>Leave the service-account key empty. The Gateway uses its attached GCP identity at runtime.</td>
            </tr>
        </tbody>
    </table>

    [![Vertex AI Service Account Key]({{base_path}}/assets/img/learn/ai-gateway/vertex-ai-service-account-key.png){: style="width:100%"}]({{base_path}}/assets/img/learn/ai-gateway/vertex-ai-service-account-key.png)

5. Click **Update** to save the endpoint.
6. **Save and deploy the API** for the changes to take effect.

!!! Note
    - The endpoint URL ends at `.../models`; the specific model is taken from each request's URL path and appended by the Gateway, so you do not put the model in the URL.
    - The **Region** must match a region where your models are available and enabled in Model Garden. A regional Vertex AI URL requires the same region in both the host and the `locations` path &mdash; the structured builder keeps them consistent, so prefer it over hand-editing the URL.

!!! Important "Required for VertexAI-Anthropic APIs: add the DISABLE_CHUNKING policy"
    For **every AI API that uses `VertexAI-Anthropic`**, add the **`DISABLE_CHUNKING`** policy to the **request flow at the API level**, then **Save and deploy** the API.

    **How to add it:** In the Publisher Portal, open the API and go to **API Configurations → Policies**. Attach the `DISABLE_CHUNKING` policy to the **request** flow at the **API level** (not to an individual operation), save, and deploy the API.

    **Why it is needed:** By default the Gateway forwards the request body to the backend using HTTP *chunked transfer-encoding*. The Anthropic Claude models on Vertex AI (`:rawPredict` / `:streamRawPredict`) expect the request with a fixed **`Content-Length`** header and do not reliably accept a chunked request body, so requests can be rejected by the backend. The `DISABLE_CHUNKING` policy makes the Gateway buffer the request and send it with a `Content-Length` header instead of chunked transfer-encoding, which is what the Vertex AI Anthropic endpoints require.

For more information on securing the backend of AI APIs, see [AI Backend Security]({{base_path}}/ai-gateway/ai-backend-security/).
