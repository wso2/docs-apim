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

For the frontend, Choreo requires the legacy setup. Follow the [Legacy Frontend Setup](./legacy-setup.md#legacy-frontend-setup) instructions to configure your application's UI.

Once both are configured, you are good to go!
