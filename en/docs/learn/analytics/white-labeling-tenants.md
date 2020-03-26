# White Labeling for Tenants
This section explains how to white label analytics dashboard for tenants.
1. Add following configuration in the deployment.yaml
    ```yaml
    themeConfigProviderClass: org.wso2.analytics.apim.dashboards.theme.config.provider.CustomDashboardThemeConfigProvider
    logoFileName: logo.png
    faviconFileName: favicon.ico
    ```
2. Create a tenant in APIM node 
Log in to the Management Console.

    Click **Add New Tenant** in the **Configure** tab of the management console.
    ![]({{base_path}}/assets/img/administer/configure-tenants.png)

    Refer [Adding a new tenant ]({{base_path}}/administer/product-administration/multitenancy/managing-tenants/#adding-a-new-tenant) for more information.

3. Go to `<API-M_ANALYTICS_HOME>/wso2/dashboard/deployment/web-ui-apps/analytics-dashboard/public/` directory and create a directory with the name of tenant (abc.com)
    
Create following folder structure inside the tenant folder and add relavent logo and favicon file.

![]({{base_path}}/assets/img/learn/analytics/tenant-white-label-tree.png)

4. To verify changes Log in to the Analytics Dashboard by accessing `<Protocol>://<Host>:<Port>/analytics-dashboard` (ex: [https://localhost:9643/analytics-dashboard](https://localhost:9643/analytics-dashboard)). 