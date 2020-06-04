# Managing Analytics Dashboard Permissions

API statistics related to both the API Publisher and the Developer Portal can be viewed using the **dashboard** runtime of the API-M Analytics server.

This section explains about managing permissions of each of these dashboards.

## Permission Levels of a Dashboard
A dashboard has three levels of permissions.

+ **Owners** - Owners of a dashboard are the most privileged users of the dashboard. Only they have access to settings page once access control is set. They also can edit or view the dashboard.
+ **Editors** - Editors of a dashboard can either edit the dashboard or view the dashboard. Editing the dashboard includes adding / removing widgets, add / remove pages to the dashboard, changing the layout of the dashboard etc. 
But they don’t have access to the dashboard settings page.
+ **Viewers** - Viewers of a dashboard are the least privileged users of a dashboard. The can only view the dashboard and cannot edit or change the settings of a dashboard.

## Configuring Dashboard Permissions
Now let's see how we can change the default permissions that is set for each of these dashboards.

+ Log in to the Analytics Dashboard by accessing `<Protocol>://<Host>:<Port>/analytics-dashboard` (ex: [https://localhost:9643/analytics-dashboard](https://localhost:9643/analytics-dashboard)). 
+ After login in, you will see the **APIM Publisher** and the **APIM Developer Portal** dashboards listed.
  
       ![]({{base_path}}/assets/img/learn/analytics-dashboard-listing.png)

+ Click on the three dots at the bottom right corner of the preferred dashboard card and select **Settings**

       ![]({{base_path}}/assets/img/learn/dashboard-settings.png)
     
!!! Note
      Settings option will be visible only if you have owner permission of the selected dashboard.
      
+ The Dashboard Settings page opens and you can assign scopes for different permission levels.

      ![]({{base_path}}/assets/img/learn/dashboard-settings-dev-portal.png)
      
!!! Info
      List of available scopes will be populated for each permission level. Dashboard owners can set the required scopes for each of those permission levels. Each permission level can have multiple scopes.

## Permission Level and User Role Mapping

Following table illustrates the default mapping between the permission level for each analytics dashboard and user role. This table can be referred to assign a role to a user in order to provide the required permissions. 

| **User role**       | **APIM Admin**    | **APIM Publisher**  | **APIM Developer Portal** |
|---------------------|-------------------|---------------------|---------------------------|
| admin               | Owner / Editor    | Owner / Editor      | Owner / Editor            |
| Internal/analytics  | Not allowed       | Viewer              | Not allowed               |
| Internal/creator    | Not allowed       | Viewer              | Not allowed               |
| Internal/publisher  | Not allowed       | Viewer              | Not allowed               |
| Internal/subscriber | Not allowed       | Not allowed         | Viewer                    |
