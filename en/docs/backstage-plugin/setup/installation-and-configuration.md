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

| Package                                                           | Purpose                                                             |
| -------------------------------------------------------------------| ---------------------------------------------------------------------|
| `@wso2/backstage-plugin-wso2-api-platform`                        | Frontend UI — the main page and entity cards                        |
| `@wso2/backstage-plugin-wso2-api-platform-backend`                | Backend plugin — API proxying and runtime operations                |
| `@wso2/backstage-plugin-catalog-backend-module-wso2-api-platform` | Catalog module — automatic discovery and ingestion of WSO2 entities |

## Installation

Install the full suite in your Backstage application using Yarn:

```bash
# Frontend plugin — add to your app package
yarn workspace app add @wso2/backstage-plugin-wso2-api-platform

# Backend plugin and catalog module — add to your backend package
yarn workspace backend add @wso2/backstage-plugin-wso2-api-platform-backend @wso2/backstage-plugin-catalog-backend-module-wso2-api-platform
```


## Verifying the Installation

After installation, check your package.json files for the expected entries:

- **packages/app/package.json** — should list `@wso2/backstage-plugin-wso2-api-platform`
- **packages/backend/package.json** — should list `@wso2/backstage-plugin-wso2-api-platform-backend` and `@wso2/backstage-plugin-catalog-backend-module-wso2-api-platform`

If those entries are present, the plugins are correctly integrated into your workspace and ready for configuration.

## Configuration

After installing, update your `app-config.yaml` with the following configurations. Note that you can enable both **wso2ApiPlatform** and **wso2ApiPlatformGateway**, or just one depending on your setup. For a detailed breakdown of every configuration property, please see the [References](../references.md).

First, add the following configuration under `catalog.providers`:

```yaml
catalog:
  providers:
    wso2ApiPlatform:
      # TODO: Update the base URL for the WSO2 APIM Entity Provider
      baseUrl: ${WSO2_BASE_URL}
      namespace: wso2
      username: ${WSO2_APIM_USERNAME}
      password: ${WSO2_APIM_PASSWORD}
      schedule:
        frequency:
          minutes: ${WSO2_SYNC_FREQUENCY_MINUTES}
        timeout:
          minutes: ${WSO2_SYNC_TIMEOUT_MINUTES}
        initialDelay:
          seconds: ${WSO2_SYNC_INITIAL_DELAY_SECONDS}
```

Next, put this below everything in the config, as an independent configuration block. If you are running in a local environment, you can set `tls.rejectUnauthorized: false`.

```yaml
wso2ApiPlatform:
  enabled: true
  # Maximum time (in seconds) the Backstage plugin will wait for a response when making an HTTP request to the WSO2 API Manager instance before aborting the request. Default is 30.
  requestTimeoutSeconds: 30
  # TODO: Update the base URL of your WSO2 API Manager instance
  baseUrl: ${WSO2_BASE_URL}
  publisherBasePath: ${WSO2_PUBLISHER_BASE_PATH}
  developerBasePath: ${WSO2_DEVPORTAL_BASE_PATH}
  serviceCatalogBasePath: ${WSO2_SERVICE_CATALOG_BASE_PATH}
  tls:
    rejectUnauthorized: ${WSO2_TLS_REJECT_UNAUTHORIZED}
  auth:
    # TODO: Update with your WSO2 APIM application credentials
    clientId: ${WSO2_CLIENT_ID}
    clientSecret: ${WSO2_CLIENT_SECRET}
    # TODO: Update the token URL and grant type if necessary
    tokenUrl: ${WSO2_BASE_URL}/oauth2/token
    requiredScopes:
      - apim:api_view
      - apim:mcp_server_view
      - apim:mcp_server_create
      - apim:mcp_server_publish
      - apim:mcp_server_generate_key
      - apim:mcp_server_import_export
      - apim:mcp_server_list_view
      - apim:llm_provider_read
      - apim:publisher_settings
      - apim:api_create
      - apim:api_publish
      - apim:api_import_export
    grantType: client_credentials
  catalogSyncTimeoutSeconds: 60

wso2ApiPlatformGateway:
  enabled: true
  gateways:
    - name: Self-Hosted-1
      environmentType: Development
      urls:
        - ${WSO2_GATEWAY_SELF_HOSTED_URL}
      discoveryUrl: ${WSO2_GATEWAY_SELF_HOSTED_DISCOVERY_URL}
      discoveryUsername: ${WSO2_GATEWAY_DISCOVERY_USERNAME}
      discoveryPassword: ${WSO2_GATEWAY_DISCOVERY_PASSWORD}
      description: 'Gateways in wso2 API platform environment (config_dump discovery)'
```


## Next Steps

Now that you have installed the plugins and updated your configuration, choose the setup guide that matches your Backstage system:

- **[Latest Backstage Setup](./latest-setup.md)**: If you are using the latest Backstage backend and frontend systems.
- **[Legacy Backstage Setup](./legacy-setup.md)**: If your application is still using the legacy backend or frontend systems.
- **[OpenChoreo Setup](./openchoreo-setup.md)**: If you are deploying your Backstage instance on the OpenChoreo platform.

Once you have configured the setup, you can see our [tutorials](./tutorials.md) to get hands-on experience using the plugin features.
