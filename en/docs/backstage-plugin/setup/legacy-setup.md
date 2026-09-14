# Legacy System Setup

Make sure you have completed the [Installation and Configuration](./installation-and-configuration.md) steps before proceeding here.

If your Backstage application is still using the legacy backend or frontend systems, follow these instructions to configure the WSO2 API Manager plugins.

## Legacy Backend

**1. Update packages/backend/src/index.ts**

```typescript
import wso2ApiManager from './plugins/wso2-api-manager';

const wso2ApiManagerEnv = useHotMemoize(module, () => createEnv('wso2-api-manager'));

apiRouter.use('/wso2-api-manager', await wso2ApiManager(wso2ApiManagerEnv));

export default async function createPlugin(
  env: PluginEnvironment,
): Promise<Router> {
  const builder = await CatalogBuilder.create({
    ...env,
    scheduler: {
      ...env.scheduler,
      cancelTask: async () => {},
    },
  });
  // ... other code
```

**2. Update packages/backend/src/plugins/catalog.ts**

```typescript
import { Wso2ApiEntityProvider } from '@wso2/backstage-plugin-catalog-backend-module-wso2-apim';
import { readTaskScheduleDefinitionFromConfig } from '@backstage/backend-tasks';

// ... other code

const provider = Wso2ApiEntityProvider.fromConfig(env.config, {
  id: 'wso2-publisher-apis',
  logger: env.logger,
});
builder.addEntityProvider(provider);

env.scheduler.createScheduledTaskRunner(
  readTaskScheduleDefinitionFromConfig(
    env.config.getConfig('catalog.providers.wso2Apim.schedule'),
  ),
).run({
  id: provider.getProviderName(),
  fn: async () => provider.run(),
});
```

**3. Create packages/backend/src/plugins/wso2-api-manager.ts**

```typescript
import { CatalogClient } from '@backstage/catalog-client';
import { IdentityApiGetIdentityRequest } from '@backstage/plugin-auth-node';
import { Router } from 'express';
import { PluginEnvironment } from '../types';

// The installed WSO2 backend package exposes a new-backend feature publicly.
// This app still uses the legacy backend, so we bridge to its compiled router.
const { createRouter } =
  require('@wso2/backstage-plugin-wso2-api-manager-backend/dist/service/router.cjs.js') as {
    createRouter(options: {
      auth: unknown;
      catalog: unknown;
      httpAuth: unknown;
      logger: PluginEnvironment['logger'];
      config: PluginEnvironment['config'];
    }): Promise<Router>;
  };

export default async function createPlugin(
  env: PluginEnvironment,
): Promise<Router> {
  const catalog = new CatalogClient({ discoveryApi: env.discovery });

  return await createRouter({
    auth: {
      getOwnServiceCredentials: async () => ({}),
      getPluginRequestToken: async () => ({ token: '' }),
    },
    catalog,
    httpAuth: {
      credentials: async (
        req: IdentityApiGetIdentityRequest['request'],
      ) => {
        if (env.identity) {
          await env.identity.getIdentity({ request: req });
        }
        return {};
      },
    },
    logger: env.logger,
    config: env.config,
  });
}
```

## Legacy Frontend

**1. Register the API Client**

In packages/app/src/api.ts:

```tsx
import {
  AnyApiFactory,
  configApiRef,
  createApiFactory,
  discoveryApiRef,
  fetchApiRef,
} from '@backstage/core-plugin-api';
import {
  Wso2ApiManagerClient,
  wso2ApiManagerApiRef,
} from '@wso2/backstage-plugin-wso2-api-manager';

export const apis: AnyApiFactory[] = [
  // ... other APIs
  createApiFactory({
    api: wso2ApiManagerApiRef,
    deps: { discoveryApi: discoveryApiRef, fetchApi: fetchApiRef },
    factory: ({ discoveryApi, fetchApi }) =>
      new Wso2ApiManagerClient({ discoveryApi, fetchApi }),
  }),
];
```

**2. Add the WSO2 API Manager Route**

In packages/app/src/App.tsx:

```tsx
import {
  Wso2ApiManagerPage,
} from '@wso2/backstage-plugin-wso2-api-manager';

// ...
const routes = (
  <FlatRoutes>
    {/* ... other routes */}
    <Route path="/wso2-api-manager" element={<Wso2ApiManagerPage />} />
  </FlatRoutes>
);
```

**3. Add the Sidebar Item**

In packages/app/src/components/Root/Root.tsx (or packages/app/src/root.ts depending on your Backstage version):

```tsx
import CloudIcon from '@material-ui/icons/Cloud';

// ...
export const Root = ({ children }: PropsWithChildren<{}>) => (
  <SidebarPage>
    <Sidebar>
      {/* ... other items */}
      <SidebarItem
        icon={CloudIcon}
        to="wso2-api-manager"
        text="WSO2 API Manager"
      />
    </Sidebar>
    {children}
  </SidebarPage>
);
```

**4. Update the Entity Pages**

In packages/app/src/components/catalog/EntityPage.tsx:

Import the necessary WSO2 components:

```tsx
import {
  EntityWso2AboutCard,
  EntityWso2ApiDefinitionCard,
  EntityWso2ApiDocumentsCard,
  EntityWso2ApiOverviewCard,
  EntityWso2ApiProductResourcesCard,
  EntityWso2McpToolsCard,
  isMcpEntity,
  isWso2Api,
} from '@wso2/backstage-plugin-wso2-api-manager';
```

Define the helper functions:

```tsx
const isNotWso2Api = (entity: Entity) => !isWso2Api(entity);

const isWso2ApiProduct = (entity: Entity) =>
  entity.kind.toLowerCase() === 'api' &&
  entity.metadata.annotations?.['wso2.com/is-api-product'] === 'true';
```

Modify the existing apiPage layouts to use if={isNotWso2Api} for existing routes and add the WSO2-specific layouts:

```tsx
const apiPage = (
  <EntityLayout>
    <EntityLayout.Route path="/" title="Overview" if={isNotWso2Api}>
      {/* Existing overview content */}
    </EntityLayout.Route>

    <EntityLayout.Route path="/definition" title="Definition" if={isNotWso2Api}>
      {/* Existing definition content */}
    </EntityLayout.Route>

    {/* Add the WSO2 specific layouts */}
    <EntityLayout.Route path="/" title="Overview" if={isWso2Api}>
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <EntityWso2AboutCard />
        </Grid>
        <Grid item xs={12}>
          <EntityWso2ApiOverviewCard />
        </Grid>
        <EntitySwitch>
          <EntitySwitch.Case if={isMcpEntity}>
            <Grid item xs={12}>
              <EntityWso2McpToolsCard />
            </Grid>
          </EntitySwitch.Case>
          <EntitySwitch.Case if={isWso2ApiProduct}>
            <Grid item xs={12}>
              <EntityWso2ApiProductResourcesCard />
            </Grid>
          </EntitySwitch.Case>
        </EntitySwitch>
      </Grid>
    </EntityLayout.Route>

    <EntityLayout.Route path="/definition" title="Definition" if={isWso2Api}>
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <EntityWso2ApiDefinitionCard />
        </Grid>
      </Grid>
    </EntityLayout.Route>

    <EntityLayout.Route path="/docs" title="Docs" if={isWso2Api}>
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <EntityWso2ApiDocumentsCard />
        </Grid>
      </Grid>
    </EntityLayout.Route>
  </EntityLayout>
);
```
