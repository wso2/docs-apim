# Subscribing for Alerts

You can subscribe to events as a system administrator or as a API publisher/subscriber. These users can subscribe to any of the alert types listed in the **Manage Alert Subscriptions** page specific to them. For more information about different types of alerts and their importance, see [Alert Types](../../../../../Learn/Analytics/ManagingAlertsWithRealTimeAnalytics/alert-types) .

### System Administrators

A system administrator is allowed to select one or more alert types to subscribe for, as well as specify a list of email addresses to which the alerts should be sent. Follow the procedure below to carry out the tasks mentioned above using the Admin Portal of WSO2 API Manager.

1.  Log into the WSO2 API Manager Admin Portal using the `https://<API-M_HOST>:<API-M_PORT>/admin` URL.
2.  In **ANALYTICS** menu, Click **MANAGE ALERT TYPES** to open the **Manage Alert Types** page.
    ![](../../../../assets/img/Learn/alerts-subscribe-admin.png)3.  Select the relevant check boxes based on the alert types to which you want to subscribe.
4.  Under **Email list** , enter the list of email addresses that should receive alerts. The email addresses should be those of system administrators. Each email address can be separated with a comma or you can type Email address and press Enter.
5.  Click **Save** to save the information.

An API Manager publisher/subscriber can enable/disable alert types based on the alerts that he/she wants to receive individually, as well as specify a list of email addresses to which the alerts should be sent.

### APIM Publisher/Subscriber

1.  Log into the API publisher with the username and password of a user with permission to publish using WSO2 API Manager.
2.  Click on the **SETTINGS** menu, to open the **Manage Alert Subscriptions** page.

    - **API Publisher**
    ![](../../../../assets/img/Learn/alerts-subscribe-publisher.png)
    
    - **API Developer Portal**
    ![](../../../../assets/img/Learn/alerts-subscribe-devportal.png)
3.  Select the relevant check boxes based on the alert types to which you want to subscribe.
4.  Under **Email list** , enter the list of email addresses that should receive alerts.
5.  Click **Save** to save the information.


