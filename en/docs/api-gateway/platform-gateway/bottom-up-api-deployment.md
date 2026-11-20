# Bottom-Up API Deployment

This guide explains how to deploy a REST API directly to a Platform Gateway and have it automatically synced to an on-premises WSO2 API Manager 4.7.0 Control Plane.

## Overview

When you deploy a REST API through the gateway controller's management REST API, the gateway automatically tracks it for bottom-up sync to an on-premises WSO2 API Manager 4.7.0 instance, if the gateway is configured for on-premises Control Plane mode.

### Understand deployment approaches

Platform Gateway supports two deployment approaches, distinguished by the direction the API definition flows:

**Top-down deployment** (Control Plane → Gateway)

In top-down deployment, the Control Plane is the source of truth. You create and deploy the API from the Publisher Portal, and the Control Plane pushes the API definition to the gateway. For this flow, see [Getting started with Platform Gateway]({{base_path}}/api-gateway/platform-gateway/getting-started/).

**Bottom-up deployment** (Gateway → on-premises API Manager)

In bottom-up deployment, you deploy a REST API directly to the gateway through its `POST /rest-apis` management endpoint. The gateway makes the API available immediately, then syncs it to the on-premises Control Plane in the background. This mode is only available when the Control Plane is running in on-premises mode — the cloud Control Plane does not support bottom-up sync.

| Aspect | Top-down | Bottom-up |
|---|---|---|
| Initiation | Control Plane | Gateway (REST API) |
| Direction | Control Plane → Gateway | Gateway → on-premises API Manager |
| Source of truth | Central Control Plane | Local gateway |
| Status tracking | Managed by the Control Plane | Tracked in the gateway database |
| Failure handling | Depends on the Control Plane | API keeps working; sync retries automatically |

This guide focuses on bottom-up deployment.

## Prerequisites

Before you begin, ensure that you have the following:

- A running gateway controller v1.2.0 or later, with its management API endpoint accessible (default: `http://localhost:9090/api/management/v1`). This guide's `scripts/setup.sh` and `api-platform.env` configuration steps apply to v1.2.0+; earlier versions use a different setup flow (`configs/keys.env`).
- The gateway controller registered with the Control Plane, with a registration token obtained from that process. The controller skips the Control Plane connection entirely if this token isn't configured. See [Gateway registration and deployment]({{base_path}}/api-gateway/platform-gateway/gateway-registration-and-deployment/).
- An on-premises WSO2 API Manager 4.7.0 instance, reachable from the gateway controller.
- API Manager OAuth2 credentials for the gateway to authenticate with (either a client ID and secret, or a username and password).

## Configure the gateway controller

The shipped `config.toml` already has a `[controller.controlplane]` section with environment-variable interpolation for every field — set the values through environment variables (for example, in `api-platform.env`) rather than editing `config.toml` directly:

```toml
[controller.server]
gateway_id = "gateway-1"
api_port = 9090

[controller.controlplane]
# Registration token obtained from gateway registration — required for the
# Control Plane connection. The controller skips connecting entirely if this
# is empty, regardless of the OAuth2 credentials below.
token = '{% raw %}{{ env "APIP_GW_CONTROLLER_CONTROLPLANE_TOKEN" "" }}{% endraw %}'

# For bottom-up sync to on-prem APIM
host = '{% raw %}{{ env "APIP_GW_CONTROLLER_CONTROLPLANE_HOST" "" }}{% endraw %}'

# Defaults to true. Skips TLS certificate verification for the connection to
# the Control Plane, which is useful when it uses a self-signed certificate.
# Set to false in production once the gateway trusts the issuing CA.
insecure_skip_verify = '{% raw %}{{ env "APIP_GW_CONTROLLER_CONTROLPLANE_INSECURE_SKIP_VERIFY" "true" }}{% endraw %}'

# OAuth2 credentials (choose one option)
# Option A: Client credentials flow
apim_oauth2_client_id = '{% raw %}{{ env "APIP_GW_CONTROLLER_CONTROLPLANE_APIM_OAUTH2_CLIENT_ID" "" }}{% endraw %}'
apim_oauth2_client_secret = '{% raw %}{{ env "APIP_GW_CONTROLLER_CONTROLPLANE_APIM_OAUTH2_CLIENT_SECRET" "" }}{% endraw %}'

# Option B: Resource owner password flow
# The shipped config.toml does not include apim_oauth2_username or
# apim_oauth2_password, even as commented-out placeholders. Add both
# keys yourself if you use this option instead of Option A.
# apim_oauth2_username = '{% raw %}{{ env "APIP_GW_CONTROLLER_CONTROLPLANE_APIM_OAUTH2_USERNAME" "" }}{% endraw %}'
# apim_oauth2_password = '{% raw %}{{ env "APIP_GW_CONTROLLER_CONTROLPLANE_APIM_OAUTH2_PASSWORD" "" }}{% endraw %}'

# Must match the name of the Platform Gateway registered in the API Manager
# Admin Portal. If it doesn't match, the synced API is deployed to a
# deployment environment that doesn't exist.
gateway_name = '{% raw %}{{ env "APIP_GW_CONTROLLER_CONTROLPLANE_GATEWAY_NAME" "default" }}{% endraw %}'

[controller.auth.basic]
enabled = true

[[controller.auth.basic.users]]
username        = '{% raw %}{{ env "APIP_GW_CONTROLLER_AUTH_BASIC_ADMIN_USERNAME" "" }}{% endraw %}'
password        = '{% raw %}{{ env "APIP_GW_CONTROLLER_AUTH_BASIC_ADMIN_PASSWORD_HASH" "" }}{% endraw %}'
password_hashed = true
roles           = ["admin"]
```

Set the values for the environment variables used above, for example in `api-platform.env`:

```bash
APIP_GW_CONTROLLER_CONTROLPLANE_TOKEN=<registration-token>
APIP_GW_CONTROLLER_CONTROLPLANE_HOST=<apim-host>:9443
APIP_GW_CONTROLLER_CONTROLPLANE_APIM_OAUTH2_CLIENT_ID=<clientId>
APIP_GW_CONTROLLER_CONTROLPLANE_APIM_OAUTH2_CLIENT_SECRET=<clientSecret>
APIP_GW_CONTROLLER_CONTROLPLANE_GATEWAY_NAME=onprem-gw
```

## How it works

### Sync behavior

When you deploy a REST API through the gateway controller:

1. The API is deployed to the gateway immediately, and is available for routing, API key creation, and request processing.
2. If `controller.controlplane.host` is configured and the gateway is connected to an on-premises API Manager instance, the gateway syncs the API to the Control Plane.
3. The sync status is tracked in the gateway database as `pending`, `success`, or `failed`, with up to three automatic retries on failure.

### Conditions for sync

The gateway only attempts a sync when all of the following are true:

- An API Manager Control Plane connection is configured.
- The gateway's WebSocket connection to the Control Plane is active.
- The Control Plane is detected as running in on-premises mode (through its `.well-known` endpoint).

### If sync fails

- The API remains available on the gateway regardless of sync status.
- Each sync run makes up to three immediate retry attempts. If all three fail, the sync status is marked `failed`, with error details recorded.
- A new sync run is triggered automatically whenever you create, update, or delete the API, and whenever the gateway reconnects to the Control Plane. There's no separate periodic retry timer.
- To trigger a sync run on demand, update the API with its current definition.

### Editing a synced API in API Manager

For a bottom-up API, the gateway is the source of truth: once synced, the API is visible in the Publisher in read-only mode. Make changes to a bottom-up API through the gateway's management REST API — the next sync run re-imports the definition into API Manager with overwrite enabled.

## Deploy a REST API

Bottom-up APIs are REST APIs deployed directly to the gateway controller. Once deployed, they're tracked for automatic sync to the on-premises API Manager Control Plane — no manual push is required, and the API keeps working even if the Control Plane is temporarily unavailable.

### API definition

The following example defines a REST API with API-level and operation-level policies:

```yaml
apiVersion: gateway.api-platform.wso2.com/v1
kind: RestApi
metadata:
  name: PetStoreAPI
spec:
  displayName: PetStore API
  version: v1.0
  context: /petstore

  upstream:
    main:
      url: "https://petstore.example.com"

  # API-level policies apply to all operations.
  # Policies are sourced from Policy Hub: https://wso2.com/api-platform/policy-hub
  policies:
    # https://wso2.com/api-platform/policy-hub/policies/api-key-auth
    - name: api-key-auth
      version: v1
      params:
        key: X-API-Key
        in: header

    - name: basic-ratelimit
      version: v1
      params:
        limits:
          - requests: 1000
            duration: 1h

  operations:
    - method: GET
      path: /pet/{petId}
      # Operation-level policies override API-level policies
      policies:
        - name: basic-ratelimit
          version: v1
          params:
            limits:
              - requests: 100
                duration: 1m

    - method: POST
      path: /pet

    - method: PUT
      path: /pet

    - method: DELETE
      path: /pet/{petId}

    - method: GET
      path: /store/inventory

    - method: POST
      path: /store/order

    - method: GET
      path: /
```

Keep the following in mind when defining a bottom-up API:

- `metadata.name` must be unique per API.
- `context` becomes the URL path prefix on the gateway.
- `upstream.main.url` is required and points to the backend service.
- `version` is tracked separately, so you can run multiple versions of the same API.
- Policies are optional, but recommended for securing the API. See [Policy Hub](https://wso2.com/api-platform/policy-hub) for available policies, and [Adding and managing policies]({{base_path}}/api-gateway/platform-gateway/adding-and-managing-policies/) for how to configure them.

### Deployment steps

#### Step 1: Create the API definition

Save the API definition shown above as `petstore-api.yaml`.

#### Step 2: Deploy the API to the gateway

The following commands use a `BASE64_CREDENTIALS` environment variable for the Basic auth header. Set `ADMIN_PASSWORD` to the password printed by the gateway's `scripts/setup.sh` script (the default username is `admin`):

```bash
export ADMIN_USERNAME=admin
export ADMIN_PASSWORD='<the password scripts/setup.sh printed>'
export BASE64_CREDENTIALS=$(echo -n "$ADMIN_USERNAME:$ADMIN_PASSWORD" | base64)

curl -X POST http://localhost:9090/api/management/v1/rest-apis \
  -H "Content-Type: application/yaml" \
  -H "Authorization: Basic ${BASE64_CREDENTIALS}" \
  --data-binary @petstore-api.yaml
```

A successful response looks like this:

```json
{
  "uuid": "api-uuid-12345",
  "displayName": "PetStore API",
  "version": "v1.0",
  "context": "/petstore",
  "origin": "gateway_api",
  "desiredState": "deployed",
  "createdAt": "2026-04-26T10:30:00Z"
}
```

!!! note
    To confirm the Control Plane sync status, check the gateway controller logs for `Bottom-up sync: starting` and `Bottom-up sync: API synced successfully` entries. If the sync fails, the log includes the error detail, and the gateway retries automatically.

#### Step 3: Test the API on the gateway

```bash
# Get an API key
curl -X POST http://localhost:9090/api/management/v1/rest-apis/PetStoreAPI/api-keys \
  -H "Content-Type: application/json" \
  -H "Authorization: Basic ${BASE64_CREDENTIALS}" \
  -d '{"name": "test-key"}'
```

A successful response looks like this. Use the `apiKey.apiKey` value as `<api-key-from-step-above>` below:

```json
{
  "status": "success",
  "message": "API key generated successfully",
  "apiKey": {
    "apiId": "PetStoreAPI",
    "apiKey": "apip_6b1f3c...e2a9",
    "name": "test-key",
    "status": "active",
    "source": "local",
    "createdAt": "2026-04-26T10:30:00Z",
    "createdBy": "admin",
    "expiresAt": null
  }
}
```

```bash
# Invoke the API
curl http://localhost:8080/petstore/pet/123 \
  -H "X-API-Key: <api-key-from-step-above>"
```

#### Step 4: Verify the API in the on-premises API Manager (optional)

Once the sync completes, the API is available in API Manager. You can check this using the [Publisher REST API v4]({{base_path}}/reference/product-apis/publisher-apis/publisher-v4/publisher-v4/).

`<apim-token>` is an OAuth2 access token for the Publisher API, scoped to `apim:api_view`. Get one using the same client ID and secret configured for the gateway:

```bash
curl -k -X POST https://<apim-host>:9443/oauth2/token \
  -d "grant_type=client_credentials&scope=apim:api_view" \
  -u "<clientId>:<clientSecret>" | jq -r '.access_token'
```

```bash
curl -k -X GET https://<apim-host>:9443/api/am/publisher/v4/apis \
  -H "Authorization: Bearer <apim-token>" | jq '.list[] | select(.name=="PetStore API")'
```

## Update an API

When you update an API, the gateway automatically re-syncs it to the on-premises API Manager instance, if connected.

For example, to add a rate-limiting policy, update the API definition and save it as `petstore-api-updated.yaml`:

```yaml
apiVersion: gateway.api-platform.wso2.com/v1
kind: RestApi
metadata:
  name: PetStoreAPI
spec:
  displayName: PetStore API
  version: v1.0
  context: /petstore
  upstream:
    main:
      url: https://petstore.example.com
  policies:
    - name: basic-ratelimit
      version: v1
      params:
        limits:
          - requests: 1000
            duration: 1h
    - name: api-key-auth
      version: v1
      params:
        key: X-API-Key
        in: header
  operations:
    - method: GET
      path: /pet/{petId}

    - method: POST
      path: /pet

    - method: PUT
      path: /pet

    - method: DELETE
      path: /pet/{petId}

    - method: GET
      path: /store/inventory

    - method: POST
      path: /store/order

    - method: GET
      path: /
```

Send the update:

```bash
curl -X PUT http://localhost:9090/api/management/v1/rest-apis/PetStoreAPI \
  -H "Content-Type: application/yaml" \
  -H "Authorization: Basic ${BASE64_CREDENTIALS}" \
  --data-binary @petstore-api-updated.yaml
```

When you update an API:

1. The gateway applies the update immediately.
2. The sync status resets to `pending`.
3. The gateway automatically re-syncs the API to the on-premises API Manager instance.
4. Once sync completes, the gateway and API Manager both reflect the updated version.

```bash
tail -f gateway-controller.log | grep "Bottom-up sync"
```

## Manage API keys

**Create an API key**

```bash
curl -X POST http://localhost:9090/api/management/v1/rest-apis/PetStoreAPI/api-keys \
  -H "Content-Type: application/json" \
  -H "Authorization: Basic ${BASE64_CREDENTIALS}" \
  -d '{
    "name": "my-api-key"
  }'
```

**Invoke the API with the key**

```bash
curl http://localhost:8080/petstore/pet/1 \
  -H "X-API-Key: <your-api-key>"
```

**List API keys**

```bash
curl -X GET http://localhost:9090/api/management/v1/rest-apis/PetStoreAPI/api-keys \
  -H "Authorization: Basic ${BASE64_CREDENTIALS}"
```

**Revoke an API key**

`<key-name>` is the key's `name` — either the one you set when creating it, or the `name` value from the "List API keys" response above:

```bash
curl -X DELETE http://localhost:9090/api/management/v1/rest-apis/PetStoreAPI/api-keys/<key-name> \
  -H "Authorization: Basic ${BASE64_CREDENTIALS}"
```

## Undeploy an API

To remove an API from both the gateway and the on-premises API Manager instance, send a delete request with the API name:

```bash
curl -X DELETE http://localhost:9090/api/management/v1/rest-apis/PetStoreAPI \
  -H "Authorization: Basic ${BASE64_CREDENTIALS}"
```

A successful response looks like this:

```json
{
  "status": "success",
  "message": "RestAPI deleted successfully",
  "id": "PetStoreAPI"
}
```

Deleting a synced API first undeploys its revision from the on-premises API Manager, then removes the local gateway record — the API itself is not removed from the Publisher, only its deployed revision. The undeploy attempt (up to three retries) runs before the local record is deleted, but the local record is deleted regardless of whether the undeploy succeeds, and the `DELETE` call returns success either way.

If the undeploy fails after all retries (the gateway logs `Bottom-up sync: undeploy all retries exhausted`), there's no local record left for the gateway to retry from, so the API remains deployed in API Manager. In that case, undeploy it manually from the Publisher.

## Track sync status

The gateway tracks the API Manager sync state internally, and you can monitor it through the gateway controller logs.

| Status | Meaning | Log signal |
|---|---|---|
| `pending` | Waiting to sync to API Manager | `Bottom-up sync: starting` |
| `success` | Successfully synced to API Manager | `Bottom-up sync: API synced successfully` |
| `failed` | Sync failed after three retries | `Bottom-up sync: all retries exhausted` |

See [If sync fails](#if-sync-fails) for when the gateway automatically starts a new sync run. To trigger one manually, update the API with its current definition:

```bash
curl -X PUT http://localhost:9090/api/management/v1/rest-apis/PetStoreAPI \
  -H "Content-Type: application/yaml" \
  -H "Authorization: Basic ${BASE64_CREDENTIALS}" \
  --data-binary @petstore-api.yaml
```

## Troubleshooting

### API not syncing to API Manager

**Symptom**: The gateway logs show `Bottom-up sync: attempt failed` or `Bottom-up sync: all retries exhausted`.

**Control Plane not configured** — Check whether the Control Plane host is set:

```bash
echo $APIP_GW_CONTROLLER_CONTROLPLANE_HOST
# or check the [controller.controlplane] section in config.toml
```

Set the registration token, on-premises API Manager host, and OAuth2 credentials through the environment interpolation tokens already present in the shipped `config.toml`:

```bash
export APIP_GW_CONTROLLER_CONTROLPLANE_TOKEN=<registration-token>
export APIP_GW_CONTROLLER_CONTROLPLANE_HOST=<apim-host>:9443
export APIP_GW_CONTROLLER_CONTROLPLANE_APIM_OAUTH2_CLIENT_ID=...
export APIP_GW_CONTROLLER_CONTROLPLANE_APIM_OAUTH2_CLIENT_SECRET=...
```

**API Manager not reachable** — Test the Control Plane's `.well-known` endpoint:

```bash
curl -k https://<apim-host>:9443/internal/gateway/.well-known
# Expected: {"gatewayPath": "/internal/data/v1"}
```

If this fails, verify network connectivity and firewall rules to the API Manager host, and check whether `insecure_skip_verify` is needed for your TLS setup.

**Invalid OAuth2 credentials** — Check the API Manager logs for authentication errors. Verify that `apim_oauth2_client_id` and `apim_oauth2_client_secret` are correct and have the `apim:api_import_export` and `apim:api_view` scopes. If needed, try the username and password flow instead of client credentials.

**Missing upstream URL** — Check the API definition:

```bash
curl -X GET http://localhost:9090/api/management/v1/rest-apis/PetStoreAPI \
  -H "Authorization: Basic ${BASE64_CREDENTIALS}" | jq '.spec.upstream'
```

Ensure `upstream.main.url` is set to a valid backend service.

**Gateway controller not connected to API Manager** — Enable debug logging and check for connection events:

```bash
export APIP_GW_CONTROLLER_LOGGING_LEVEL=debug
```

Restart the gateway controller and look for these log entries:

- `Control plane connection established` — connected to API Manager (logged at `info` level).

The following entries are logged at `debug` level only, so they appear in the gateway controller logs just after enabling `APIP_GW_CONTROLLER_LOGGING_LEVEL=debug`:

- `Failed to resolve gateway path from well-known endpoint, falling back to configured URL` — can't reach API Manager.
- `Resolved WebSocket connect URL from well-known endpoint` — on-premises mode detected.

If the gateway isn't connected, wait for the periodic automatic reconnection, or trigger a sync immediately by updating the API with its current definition.

### "Access token not found"

This means the API Manager OAuth2 token endpoint returned an unexpected response. Verify your credentials are correct, confirm the OAuth2 token endpoint is accessible, and enable debug logging (`APIP_GW_CONTROLLER_LOGGING_LEVEL=debug`) to inspect the actual response.

### "bottom-up API sync skipped: on-prem control plane mode is not enabled"

This means the gateway couldn't detect that the Control Plane is running in on-premises mode. Verify that the API Manager `.well-known` endpoint returns a `gatewayPath`, check network connectivity, and confirm the Control Plane host is configured correctly:

```bash
curl -k https://<apim-host>:9443/internal/gateway/.well-known
```

Expected response:

```json
{
  "gatewayPath": "/internal/data/v1"
}
```

## What's next

- [Getting started with Platform Gateway]({{base_path}}/api-gateway/platform-gateway/getting-started/)
- [Setting up Platform Gateway]({{base_path}}/api-gateway/platform-gateway/setting-up/)
- [Gateway registration and deployment]({{base_path}}/api-gateway/platform-gateway/gateway-registration-and-deployment/)
- [Adding and managing policies]({{base_path}}/api-gateway/platform-gateway/adding-and-managing-policies/)
- [Policy Hub](https://wso2.com/api-platform/policy-hub)
