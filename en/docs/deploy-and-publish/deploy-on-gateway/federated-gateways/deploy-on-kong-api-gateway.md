# Deploy API on Kong Gateway

From the 4.5.0 release, WSO2 API Manager supports deploying APIs to Kong Gateway. With the introduction of a pluggable gateway agent architecture, WSO2 API Manager can now deploy and undeploy APIs to Kong Gateway running in a Kubernetes environment using the Kong Agent.

Follow the instructions below to configure Kong Gateway as a Federated API Gateway.

## Step 1: Set Up Kong Gateway on Kubernetes

Kong Gateway must be deployed in a Kubernetes cluster along with the required Gateway API CRDs.

1. Install Gateway API CRDs:
    ```bash
    kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml
    ```

2. Create a GatewayClass for Kong:
    ```yaml
    # gateway-class.yaml
    apiVersion: gateway.networking.k8s.io/v1
    kind: GatewayClass
    metadata:
      name: kong
      annotations:
        konghq.com/gatewayclass-unmanaged: 'true'
    spec:
      controllerName: konghq.com/kic-gateway-controller
    ```

    ```bash
    kubectl apply -f gateway-class.yaml
    ```

3. Create a Gateway resource:
    ```yaml
    # gateway.yaml
    apiVersion: gateway.networking.k8s.io/v1
    kind: Gateway
    metadata:
      name: kong-gateway
      namespace: kong
    spec:
      gatewayClassName: kong
      listeners:
      - name: http
        protocol: HTTP
        port: 80
    ```

    ```bash
    kubectl apply -f gateway.yaml
    ```

4. Install Kong Gateway using Helm:
    ```bash
    helm repo add kong https://charts.konghq.com
    helm repo update
    helm install kong kong/ingress --namespace kong --create-namespace
    ```

## Step 2: Install WSO2 API Manager (Control Plane or Data Plane)

WSO2 API Manager must be installed in the same or connected Kubernetes environment. You can choose either **Control Plane (CP)** or **Data Plane (DP)** mode depending on your architecture.

Follow the guide below based on your preferred mode:

- **WSO2 APIM Control Plane Mode:**  
  [Quick Start Guide (CP Mode)](https://apk.docs.wso2.com/en/latest/get-started/quick-start-guide-as-gateway/)

- **WSO2 APIM Data Plane Mode (with CP):**  
  [Quick Start Guide (DP Mode)](https://apk.docs.wso2.com/en/latest/get-started/quick-start-guide-with-cp/)

## Step 3: Install the Kong Gateway Agent

Install the Kong Gateway Agent Helm chart to allow WSO2 API Manager to communicate with the Kong Gateway.

```bash
helm install kong-agent ./apk-helm/. -n <namespace>
```

Ensure your `values.yaml` includes the following configuration:

```yaml
agent:
  mode: CPtoDP or DPtoCP
  gateway: kong

gatewayAgent:
  someValue:
    - val1
    - val2
```

## Step 4: Register Kong Gateway in WSO2 API Manager

1. Sign in to the **Admin Portal**:

    ```
    https://<hostname>:9443/admin
    ```

2. Add a new Gateway Environment:
    - Select the Gateway type as **Kong**.
    - Provide a unique name and description.
    - Save the configuration.

     [![add kong gateway environment]({{base_path}}/assets/img/deploy/add-kong-gw-environment.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/add-kong-gw-environment.png)

    !!!note
        The Kong Gateway must be deployed on Kubernetes and reachable from the API Manager deployment.

## Step 5: Create API and Deploy to Kong Gateway

1. Sign in to the **Publisher Portal**:

    ```
    https://<hostname>:9443/publisher
    ```

2. Create a new REST API.
3. Select the previously configured **Kong Gateway** as the deployment target.

  [![select kong gateway]({{base_path}}/assets/img/deploy/select-kong-gateway.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/select-kong-gateway.png)

4. Design the API as required and define its endpoints.
5. Navigate to **Deployments**, select the Kong Gateway environment, and deploy the API.

    !!!note
        Currently, only REST APIs are supported for Kong Gateway.

## Limitations

- **Rate Limiting:**  
  Only rate limits based on a single time unit (e.g., requests per second/minute) are supported. Complex rate limiting policies (e.g., requests per given number of minutes) are not available.

- **Base Path Constraints:**  
  It is not possible to define multiple endpoints with different base paths under the same API.

- **Scope Validation:**  
  Scope validation based on OAuth2.0 scopes is not supported in Kong Gateway deployments.

- **Subscription Rate Limiting:**  
  In the Developer Portal application, APIs subscribed to by consumers will not have **business plans** (subscription-level rate limits) enforced.

- **Key Manager Support:**  
  Only **PEM-encoded** key formats are supported for JWT signing in Kong Gateway integrations.

## Notes

- **DPtoCP Flow Configuration:**
  - Add the following Kubernetes resource labels to HTTPRoute or relevant CRs:
    - `"apiName"`: Name of the API.
    - `"apiUUID"`: Used to group multiple HTTPRoutes into a single API Product. If not specified, each HTTPRoute is treated as an individual API.
    - `"apiVersion"`: Custom API version identifier (e.g., `v1`, `v2`). Defaults to `v1`.
    - `"environment"`: Deployment environment, either `production` or `sandbox` (defaults to `production`).
    - `"showInCP"`: Whether the API should be visible in the Control Plane (`true` by default).

- **JWT Authentication Behavior:**
  - For each API subscription (ACL group), a group name is generated following the pattern:
    ```
    api-<sha1hash-of-api-name>-<environment>
    ```
  - In the JWT token, the `client_id` claim will contain the **consumer ID** associated with the API subscription.