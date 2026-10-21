# Setting up in OpenChoreo

If you are deploying your Backstage application to OpenChoreo, you will need to use a combination of the standard backend and legacy frontend setups.

Make sure you have completed the [Installation and Configuration](./installation-and-configuration.md) steps before proceeding here.

## 1. Backend Setup

Follow the standard backend setup by adding the plugin imports to your `packages/backend/src/index.ts` file:

```typescript
backend.add(import('@wso2/backstage-plugin-catalog-backend-module-wso2-apim'));
backend.add(import('@wso2/backstage-plugin-wso2-api-manager-backend'));
```

## 2. Frontend Setup

For the frontend, Choreo requires the legacy setup. Follow the [Legacy Frontend Setup](./legacy-setup.md#legacy-frontend) instructions to configure your application's UI.

## 3. Gateway Setup (Optional)

If your OpenChoreo environment uses the WSO2 API Platform Gateway module, you can discover published APIs directly in your Backstage developer portal.

To enable discovery, configure the self-hosted gateway section of your `app-config.yaml` by pointing `discoveryUrl` to the gateway controller's `/rest-apis` endpoint.

This provides the following benefits:
- APIs deployed via the WSO2 API Platform Gateway module are automatically discovered in your catalog.
- Developers can view API definitions, policies, and invocation details alongside all other entities.

!!! note "Limitation: APIs Created via the `api-management` Trait"
    APIs created using OpenChoreo's `api-management` cluster trait are not exposed through the `/rest-apis` endpoint. As a result, these APIs are not currently discoverable by the plugin.


