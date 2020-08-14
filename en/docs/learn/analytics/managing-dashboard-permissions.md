# Managing Analytics Dashboard Permissions

You can view the API statistics related to both the API Publisher and the Developer Portal using the **dashboard** runtime of the WSO2 API-M Analytics server.

## Permission levels of a dashboard

A dashboard has the following three levels of permissions.

- **Owners** - Owners of a dashboard are the most privileged users of the dashboard. After access control is set only users with the **Owners** permission have access to the Dashboard Settings page. They also can edit or view the dashboard.
- **Editors** - Editors of a dashboard can either edit the dashboard or view the dashboard. Editing the dashboard includes adding/removing widgets, adding/removing pages to/from the dashboard, changing the layout of the dashboard, etc. Users with the **Editors** permission do not have access to the Dashboard Settings page.
- **Viewers** - Viewers of a dashboard are the least privileged users of a dashboard. They can only view the dashboard and cannot edit or change the settings of a dashboard.

## Configuring Dashboard Permissions

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

The following table illustrates the default mapping between the permission level for each analytics dashboard and user role. You can refer to this table when assigning a role to a user in order to provide the required permissions. 

| **User role**       | **Application Analytics** | **Business Analytics** | **API Analytics** | **Monitoring** |  **Reports**   |
|---------------------|---------------------------|------------------------|-------------------|----------------|----------------|
| admin               | Owner / Editor            | Owner / Editor         | Owner / Editor    | Owner / Editor | Owner / Editor |
| Internal/analytics  | Not allowed               | Viewer                 | Not allowed       | Viewer         | Not allowed    |    
| Internal/creator    | Not allowed               | Not allowed            | Viewer            | Not allowed    | Not allowed    |
| Internal/publisher  | Not allowed               | Not allowed            | Viewer            | Not allowed    | Not allowed    |
| Internal/subscriber | Viewer                    | Not allowed            | Not allowed       | Not allowed    | Not allowed    |

