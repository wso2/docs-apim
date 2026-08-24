# Gateway Registration and Deployment

## Overview

A Platform Gateway can be registered with the Control Plane in two ways:

- **Admin Portal** - create the gateway from the UI, then download and start it using the generated commands. This is the default, manual method.
- **Automated Gateway Registration** - declare the gateway in `deployment.toml`, so it registers itself the first time it connects, without an Admin Portal step. Use this to automate provisioning, for example with GitOps.

## Create a Platform Gateway in the Admin Portal

Sign in to the Admin Portal, add a Platform Gateway environment with a display name, description, URL, and gateway version, then use the generated download, configuration, and start commands to bring the gateway up. See [Create a Platform Gateway in the Admin Portal]({{base_path}}/api-gateway/platform-gateway/getting-started/#create-a-platform-gateway-in-the-admin-portal) in the Getting Started guide for the full walkthrough.

## Automated Gateway Registration

!!! note
    This feature is available in WSO2 API Manager 4.7.0 starting from update level 7.

As an alternative to the Admin Portal, you can declare a Platform Gateway directly in `<API-M_HOME>/repository/conf/deployment.toml`. This lets you onboard a gateway purely through configuration, for example to automate provisioning with GitOps. The gateway record is not created at Control Plane startup - it is created the first time the gateway connects, using the details below.

### Configure the gateway

1. Add a `[[apim.platform_gateway.connect]]` entry in `deployment.toml`:

    ```toml
    [[apim.platform_gateway.connect]]
    registration_token = "$env{PLATFORM_GW_1_REGISTRATION_TOKEN}"
    name = "platform-gw-1"
    display_name = "Production Platform Gateway"
    description = "Platform Gateway for production traffic"
    url = "https://<gateway-host>:<gateway-port>"
    organization = "carbon.super"
    ```

    | Parameter | Required | Description |
    |---|---|---|
    | `registration_token` | Yes | The gateway's registration token, in `<token-id>.<plain-token>` format. Choose any value for `<token-id>` (for example a UUID) and `<plain-token>` (for example a random string) - you are defining the token, not copying one from the Admin Portal. Use this same value as `GATEWAY_REGISTRATION_TOKEN` when you configure the gateway. Reference it with WSO2's `$env{...}` syntax (as shown above) instead of a literal value, especially if `deployment.toml` is checked into version control (for example under GitOps). |
    | `url` | Yes | The URL where the gateway will be accessible, for example `https://<gateway-host>:<gateway-port>`. |
    | `name` | No | Environment name shown in the Control Plane. Defaults to an ID derived from `registration_token`. |
    | `display_name` | No | Display name shown in the Admin Portal and Publisher Portal. Defaults to `name`. |
    | `description` | No | Optional description of the gateway. |
    | `organization` | No | Tenant organization that owns the gateway. Defaults to `carbon.super`. A Platform Gateway is always scoped to a single tenant; `WSO2-ALL-TENANTS` is not supported here. |

    You can repeat the `[[apim.platform_gateway.connect]]` block to declare multiple gateways. For the full parameter reference, see [apim.platform_gateway.connect]({{base_path}}/reference/config-catalog/#api-m-platform-gateway-connect-configurations) in the Configuration Catalog.

2. Restart API Manager. `registration_token` and `url` are validated for every entry at startup; fix and restart if the server logs a configuration error.

!!! note
    If you later regenerate this gateway's token from the Admin Portal, update the environment variable or secret referenced by `PLATFORM_GW_1_REGISTRATION_TOKEN` and the gateway runtime's `GATEWAY_REGISTRATION_TOKEN` together - don't replace the `$env{...}` reference in `deployment.toml` with the literal token. Once a gateway has connected, its stored token is authoritative, so a stale value on either side will fail to authenticate.

### Start the gateway

Continue with [Setup the Gateway]({{base_path}}/api-gateway/platform-gateway/getting-started/#setup-the-gateway) in the Getting Started guide to download, configure, and start the gateway. When you create `configs/keys.env`, set `GATEWAY_REGISTRATION_TOKEN` to the same value you stored in `PLATFORM_GW_1_REGISTRATION_TOKEN` above, and set `GATEWAY_CONTROLPLANE_HOST` to your Control Plane host and port. The gateway registers automatically the moment it connects - no Admin Portal step is required.

Once the gateway is running and connected, continue with [Add an API and invoke it]({{base_path}}/api-gateway/platform-gateway/getting-started/#add-an-api-and-invoke-it) in the Getting Started guide.
