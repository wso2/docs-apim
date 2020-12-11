# Managing Analytics Dashboard Permissions

From API-M Analytics 3.0.0 release onwards, the Publisher and Developer Portal statistics are moved out from the Publisher and Developer Portal apps, and those statistics can be viewed using the **dashboard** runtime of the WSO2 API-M Analytics server.

## Permission levels of a dashboard

A dashboard has three levels of permissions.

+ **Owners** - Owners of a dashboard are the most privileged users of the dashboard. Only they have access to the Settings page once access control is set. They also can edit or view the dashboard.
+ **Editors** - Editors of a dashboard can either edit the dashboard or view the dashboard. Editing the dashboard includes adding / removing widgets, add / remove pages to the dashboard, changing the layout of the dashboard etc. But they don’t have access to the dashboard Settings page.
+ **Viewers** - Viewers of a dashboard are the least privileged users of a dashboard. They can only view the dashboard and cannot edit or change the settings of a dashboard.

## Configuring dashboard permissions

Follow the instructions below to change the default permissions that are set for each of these dashboards:

1. Sign in to the Analytics Dashboard by accessing `<Protocol>://<Host>:<Port>/analytics-dashboard`.

    Example: [https://localhost:9643/analytics-dashboard](https://localhost:9643/analytics-dashboard)

    After you sign in, you will see the **APIM Publisher** and the **APIM Developer Portal** dashboards listed.
  
    [![Analytics dashboard listing]({{base_path}}/assets/img/learn/analytics-dashboard-listing.png)]({{base_path}}/assets/img/learn/analytics-dashboard-listing.png)

2. Click on the more options icon on a preferred dashboard card and select **Settings**

     [![Dashboard Settings]({{base_path}}/assets/img/learn/dashboard-settings.png)]({{base_path}}/assets/img/learn/dashboard-settings.png)
     
    !!! Note
        The **Settings** option will be visible only if you have owner permission of the selected dashboard.
      
     The Dashboard Settings page opens, and you can assign scopes for different permission levels.

      [![Dashboard settings Developer Portal]({{base_path}}/assets/img/learn/dashboard-settings-dev-portal.png)]({{base_path}}/assets/img/learn/dashboard-settings-dev-portal.png)
      
!!! Info
    A list of available scopes will be populated for each permission level. Dashboard owners can set the required scopes for each of those permission levels. Each permission level can have multiple scopes.

!!! Note
    You are not allowed to modify the default dashboards (i.e., modify the layout of the widget or add custom widgets of a particular dashboard). If you need to modify one of the default dashboards, you need to make a copy of the dashboard and do the required modifications to the copy of the dashboard.
    
    In order to make it possible for other users to create dashboards, you need to append `_<tenant domain>` to the existing scopes in the `<ANALYTICS-HOME>/conf/dashboard/deployment.yaml` file.
    
    !!! example
        ``` bash tab="Format"
        apim_analytics:admin_<tenant-domain>
        ```
    
        ``` bash tab="Sample"
        wso2.dashboard:
          roles:
            creators:
              - apim_analytics:admin_carbon.super 
              - apim_analytics:admin_abc.com
        ```
 
