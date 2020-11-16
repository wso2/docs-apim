#Customizing Analytics Dashboards

API Manager analytics provides three types of dashboards which are APIM Admin, APIM Developer Portal and APIM Publisher.

The users are not allowed to modify the default dashboards - i.e modify the layout of the widget or add custom widgets to a particular dashboard. If you need to modify one of the default dashboards, you need to make a copy of the dashboard and do modifications to the copy of the dashboard as described in steps 1 to 5.

In order to make it possible for other users to create dashboards, you need to append `_<tenant domain>` to existing scopes in the `deployment.yaml` file which resides in `<Analytics_HOME>/conf/dashboard` directory. 

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

1.  Click on the button at the bottom right corner of the dashboard that needs to be customized as shown below.

    ![API Manager default dashboards]({{base_path}}/assets/img/learn/apim-analytics-default-dashboards.png)
    
2.  A dropdown menu will appear as shown below and click the `Duplicate` button from the dropdown.
    
    ![APIM Analytics dashboard dropdown]({{base_path}}/assets/img/learn/apim-analytics-dashboard-dropdown.png)
    
3.  A form will be displayed as shown below. Add a valid `Name` and `URL` for the dashboard according to the preference and click the `ok` button.

    ![Dashboard duplication form]({{base_path}}/assets/img/learn/apim-analytics-dashboard-duplication-form.png)
    
4.  Now a copy of the dashboard is created with the provided `Name` as shown below.
    
    ![Duplicated dashboard]({{base_path}}/assets/img/learn/apim-analytics-duplicated-dashboard.png)
    
5.  Click the dropdown button at the bottom right corner of the created dashboard and click the `design` button as shown below.
    
    ![Dashboard dropdown]({{base_path}}/assets/img/learn/apim-analytics-design-dropdown.png)
    
6.  Now it will be directed to the design portal where the customization of the selected dashboard can be done.