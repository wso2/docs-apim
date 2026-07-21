# Latest Backstage Setup

Make sure you have completed the [Installation and Configuration](./installation-and-configuration.md) steps before proceeding here.

Once configured, you simply need to add the backend plugin imports to your application.

In packages/backend/src/index.ts:

```typescript
backend.add(import('@wso2/backstage-plugin-catalog-backend-module-wso2-apim'));
backend.add(import('@wso2/backstage-plugin-wso2-api-manager-backend'));
```

Add the following layout configuration to your app-config.yaml to properly route and display the WSO2 API Manager entity pages and cards. This ensures that only relevant tabs are shown when viewing WSO2 APIs.

```yaml
app:
  extensions:
    - page:catalog:
        config:
          path: /
    - entity-content:catalog/overview:
        config:
          filter: not:kind:api
    - entity-content:wso2-api-manager/wso2-overview:
        config:
          group: wso2-overview
    - entity-content:wso2-api-manager/wso2-definition:
        config:
          group: wso2-definition
    - entity-content:wso2-api-manager/wso2-tools:
        config:
          group: wso2-tools
    - entity-content:wso2-api-manager/wso2-policies:
        config:
          group: wso2-policies
    - entity-content:wso2-api-manager/wso2-try-out:
        config:
          group: wso2-try-out
    - entity-content:wso2-api-manager/wso2-docs:
        config:
          group: wso2-docs
    - entity-content:api-docs/definition:
        config:
          filter: not:kind:api
    - entity-content:techdocs:
        config:
          filter: not:kind:api
    - entity-card:catalog/about
```

## What Happens After Setup

Once the plugins are installed and configured, you can start your Backstage app:

```bash
yarn start
```
