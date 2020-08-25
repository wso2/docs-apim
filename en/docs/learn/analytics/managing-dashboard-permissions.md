# Managing Analytics Dashboard Permissions

You can view the API statistics related to both the API Publisher and the Developer Portal using the **Analytics Dashboard** of the WSO2 API Manager Analytics.

## Permission levels of a dashboard

A dashboard has the following three levels of permissions.

- **Owners** - Owners of a dashboard are the most privileged users of the dashboard. After access control is set only users with the **Owners** permission have access to the Dashboard Settings page. They also can edit or view the dashboard.
- **Editors** - Editors of a dashboard can either edit the dashboard or view the dashboard. Editing the dashboard includes adding/removing widgets, adding/removing pages to/from the dashboard, changing the layout of the dashboard, etc. Users with the **Editors** permission do not have access to the Dashboard Settings page.
- **Viewers** - Viewers of a dashboard are the least privileged users of a dashboard. They can only view the dashboard and cannot edit or change the settings of a dashboard.

## Configuring Dashboard Permissions

To support fine-grained access and permission control, WSO2 API Manager Analytics makes use of a set of scopes. Those scopes are assigned to each dashboard, mapping to different permission levels described above. The following table illustrates the default mapping between scopes and permission levels for each dashboard.

<table>
    <thead>
    <tr class="header">
    <th>Dashboards</th>
    <th>Owners</th>
    <th>Editors</th>
    <th>Viewers</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
        <td>
        Application Analytics
        </td>
        <td>
        apim_analytics:application_analytics:own_carbon.super
        </td>
        <td>
        apim_analytics:application_analytics:edit_carbon.super
        </td>
        <td>
        apim_analytics:admin_any <br />
        apim_analytics:application_analytics:view_any
        </td>
    </tr>
    <tr class="even">
        <td>
        Business Analytics
        </td>
        <td>
        apim_analytics:admin_carbon.super <br />
        apim_analytics:business_analytics:own_carbon.super
        </td>
        <td>
        apim_analytics:admin_carbon.super <br />
        apim_analytics:business_analytics:edit_carbon.super
        </td>
        <td>
        apim_analytics:admin_any <br />
        apim_analytics:business_analytics:view_any
        </td>
    </tr>
    <tr class="odd">
    <td>
        API Analytics
        </td>
        <td>
        apim_analytics:admin_carbon.super <br />
        apim_analytics:api_analytics:own_carbon.super
        </td>
        <td>
        apim_analytics:admin_carbon.super <br />
        apim_analytics:api_analytics:edit_carbon.super
        </td>
        <td>
        apim_analytics:admin_carbon.super <br />
        apim_analytics:api_analytics:view_any
        </td>
    </tr>
    <tr class="even">
        <td>
        Monitoring
        </td>
        <td>
        apim_analytics:admin_carbon.super <br />
        apim_analytics:monitoring_dashboard:own_carbon.super
        </td>
        <td>
        apim_analytics:admin_carbon.super <br />
        apim_analytics:monitoring_dashboard:edit_carbon.super
        </td>
        <td>
        apim_analytics:admin_carbon.super <br />
        apim_analytics:monitoring_dashboard:view_any
        </td>
    </tr>
    <tr class="odd">
        <td>
        Reports
        </td>
        <td>
        apim_analytics:admin_carbon.super
        </td>
        <td>
        apim_analytics:admin_carbon.super
        </td>
        <td>
        apim_analytics:admin_any
        </td>
        </tr>    
    </tbody>
    </table> 

Follow the instructions below to change the default permissions that are set for each of the analytics dashboards:

1. Sign in to the Analytics Dashboard by accessing `<Protocol>://<Host>:<Port>/analytics-dashboard` (e.g., [https://localhost:9643/analytics-dashboard](https://localhost:9643/analytics-dashboard).

    The **API Analytics**, **Application Analytics**, **Business Analytics**, and the **Monitoring** dashboards appear.
  
       [![Analytics dashboard listing]({{base_path}}/assets/img/learn/analytics-dashboard-listing.png)]({{base_path}}/assets/img/learn/analytics-dashboard-listing.png)

2. Click on the more options icon with regard to the preferred dashboard card and click **Settings**.

     [![Dashboard Settings]({{base_path}}/assets/img/learn/dashboard-settings.png)]({{base_path}}/assets/img/learn/dashboard-settings.png)
     
    !!! Note
        The settings option is visible only if your permission level is **Owner** with regard to the selected dashboard.
      
     The Dashboard Settings page appears.

     [![Dashboard settings page]({{base_path}}/assets/img/learn/dashboard-settings-application-analytics.png)]({{base_path}}/assets/img/learn/dashboard-settings-application-analytics.png)
      
3.  Assign scopes to the different permission levels as required.
      
    !!! Info
        The list of available scopes is populated for each permission level. The dashboard owners can set the required scopes for each of those permission levels as required. Each permission level can have multiple scopes.

## Permission level and user role mapping

As described above the permission level of a logged-in user is decided based on the assigned scopes for that user. The logged-in user possesses a user role, and scopes are mapped to that user role. You can find the mapping between default scopes and default user roles in the [role mapping table]({{base_path}}/administer/managing-users-and-roles/managing-user-roles/#adding-role-mappings).

The following table illustrates the default mapping between the permission level for each analytics dashboard and user role. You can refer to this table when assigning a role to a user in order to provide the required permissions. 

| **User role**       | **Application Analytics** | **Business Analytics** | **API Analytics** | **Monitoring** |  **Reports**   |
|---------------------|---------------------------|------------------------|-------------------|----------------|----------------|
| admin               | Owner / Editor            | Owner / Editor         | Owner / Editor    | Owner / Editor | Owner / Editor |
| Internal/analytics  | Not allowed               | Viewer                 | Not allowed       | Viewer         | Not allowed    |    
| Internal/creator    | Not allowed               | Not allowed            | Viewer            | Not allowed    | Not allowed    |
| Internal/publisher  | Not allowed               | Not allowed            | Viewer            | Not allowed    | Not allowed    |
| Internal/subscriber | Viewer                    | Not allowed            | Not allowed       | Not allowed    | Not allowed    |


Further, you can add custom scopes for WSO2 API Manager Analytics. Follow the instructions below to add custom scopes.

1. Add the custom scope and role mapping to `RESTAPIScopes` value of `APIM_HOME/repository/resources/tenant-conf.json` file. This file contains the mapping between scopes and roles. The custom scope and the roles that need the scope should be listed as key-value pairs.

    For example, if you need to create a custom scope `apim_analytics:reports:view`, and map with `Internal/analytics` and `Internal/creator` role, then you have to add the following entry to `RESTAPIScopes` value.
    
    ``` toml
        "RESTAPIScopes": {
            "Scope": [
               ...,
               {
                      "Name": "apim_analytics:reports:view",
                      "Roles": "Internal/analytics, Internal/creator"
               },
               ... 
            ]
        }
    ```
   
2. Append the custom scope to the `allScopes` property under `auth.configs` configuration in `ANALYTICS_HOME/conf/dashboard/deployment.yaml`.

    For the example mentioned in the previous step, append the custom scope, `apim_analytics:reports:view` to the space-separated `allScopes` property in the `ANALYTICS_HOME/conf/dashboard/deployment.yaml` as follows.
    
    ``` java
    auth.configs:
      type: apim
      ssoEnabled: true
      properties:
        adminScope: apim_analytics:admin_carbon.super
        allScopes: apim_analytics:admin openid apim:api_view apim:subscribe apim_analytics:monitoring_dashboard:own apim_analytics:monitoring_dashboard:edit apim_analytics:monitoring_dashboard:view apim_analytics:business_analytics:own apim_analytics:business_analytics:edit apim_analytics:business_analytics:view apim_analytics:api_analytics:own apim_analytics:api_analytics:edit apim_analytics:api_analytics:view apim_analytics:application_analytics:own apim_analytics:application_analytics:edit apim_analytics:application_analytics:view apim_analytics:reports:view
    ```
    