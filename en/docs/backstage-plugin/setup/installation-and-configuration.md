# Installation and Configuration

These docs assume you have already set up Backstage and are able to run it locally, or it has been deployed somewhere.

If you haven't set up Backstage yet, start with the [Backstage Getting Started guide](https://backstage.io/docs/getting-started/).

## Prerequisites

Before installing the WSO2 Backstage plugins, ensure your environment meets these requirements:

- A running [Backstage](https://backstage.io) application.
- A running WSO2 API Manager instance (4.x or later recommended).
- Node.js 20 or later (Node.js 24 LTS recommended).

## Plugin Packages

The WSO2 integration consists of three packages that work together. You need all three for the full experience:

| Package                                                   | Purpose                                                             |
| -----------------------------------------------------------| ---------------------------------------------------------------------|
| `@wso2/backstage-plugin-wso2-api-manager`                 | Frontend UI — the main page and entity cards                        |
| `@wso2/backstage-plugin-wso2-api-manager-backend`         | Backend plugin — API proxying and runtime operations                |
| `@wso2/backstage-plugin-catalog-backend-module-wso2-apim` | Catalog module — automatic discovery and ingestion of WSO2 entities |

## Installation

Install the full suite in your Backstage application using Yarn:

```bash
# Frontend plugin — add to your app package
yarn workspace app add @wso2/backstage-plugin-wso2-api-manager

# Backend plugin and catalog module — add to your backend package
yarn workspace backend add @wso2/backstage-plugin-wso2-api-manager-backend @wso2/backstage-plugin-catalog-backend-module-wso2-apim
```


## Verifying the Installation

After installation, check your package.json files for the expected entries:

- **packages/app/package.json** — should list `@wso2/backstage-plugin-wso2-api-manager`
- **packages/backend/package.json** — should list `@wso2/backstage-plugin-wso2-api-manager-backend` and `@wso2/backstage-plugin-catalog-backend-module-wso2-apim`

If those entries are present, the plugins are correctly integrated into your workspace and ready for configuration.

## Configuration

After installing, add the WSO2 configuration block to your app-config.yaml. Note that you can enable both **wso2PlatformGateway** and **wso2ApiManager** or disable one. If you are running in a local environment, you can set **tls.rejectUnauthorized: false**.

For a detailed breakdown of every configuration property, please see the [References](../references.md).

```yaml
wso2PlatformGateway:
  enabled: true
  gateways:
    - name: APIPlatform
      urls:
        - https://<YOUR_GATEWAY_URL>
      discoveryUrl: https://<YOUR_DISCOVERY_URL>/rest-apis
      discoveryUsername: <YOUR_USERNAME>
      discoveryPassword: <YOUR_PASSWORD>
      description: 'Gateways in wso2 API platform environment (config_dump discovery)'

wso2ApiManager:
  enabled: true
  # TODO: Update the base URL of your WSO2 API Manager instance
  baseUrl: https://<WSO2_HOST>:<PORT>
  publisherBasePath: /api/am/publisher/v4
  developerBasePath: /api/am/devportal/v3
  serviceCatalogBasePath: /api/am/service-catalog/v1
  tls:
    rejectUnauthorized: true
  auth:
    # TODO: Update with your WSO2 APIM application credentials
    clientId: <WSO2_SERVICE_ACCOUNT_CLIENT_ID>
    clientSecret: <WSO2_SERVICE_ACCOUNT_CLIENT_SECRET>
    # TODO: Update the token URL and grant type if necessary
    tokenUrl: https://<WSO2_HOST>:<PORT>/oauth2/token
    additionalScopes:
      - apim:api_view
      - apim:mcp_server_view
      - apim:mcp_server_create
      - apim:mcp_server_publish
      - apim:mcp_server_generate_key
      - apim:mcp_server_import_export
      - apim:mcp_server_list_view
      - apim:llm_provider_read
    grantType: client_credentials
  catalogSyncTimeoutSeconds: 60

catalog:
  providers:
    wso2Apim:
      # TODO: Update the base URL for the WSO2 APIM Entity Provider
      baseUrl: https://<WSO2_HOST>:<PORT>
      namespace: wso2
      username: <YOUR_USERNAME>
      password: <YOUR_PASSWORD>
      schedule:
        frequency:
          minutes: 15
        timeout:
          minutes: 5
        initialDelay:
          seconds: 15
```


## Next Steps

Now that you have installed the plugins and updated your configuration, choose the setup guide that matches your Backstage system:

- **[Latest Backstage Setup](./latest-setup.md)**: If you are using the latest Backstage backend and frontend systems.
- **[Legacy Backstage Setup](./legacy-setup.md)**: If your application is still using the legacy backend or frontend systems.

Once you have configured the setup, you can see our [tutorials](./tutorials.md) to get hands-on experience using the plugin features.
