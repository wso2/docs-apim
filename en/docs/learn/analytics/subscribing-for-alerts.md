# Subscribing for Alerts

You can subscribe to events as a system administrator or as a API publisher/subscriber. These users can subscribe to any of the alert types listed in the **Manage Alert Subscriptions** page specific to them. For more information about different types of alerts and their importance, see [Alert Types]({{base_path}}/learn/analytics/alert-types/).

!!! info
    Before you begin, make sure that you have done the following
    
    - Configure Analytics for API Manager. For instructions, see [Configuring APIM Analytics]({{base_path}}/learn/analytics/configuring-apim-analytics/).
    - Enable alerts in API-M Analytics. For instructions, see [Enable alerts]({{base_path}}/learn/analytics/configuring-alerts/#enable-alerts).
    - Configure the sender email address in in API-M Analytics. For instructions, see [Configure sender email alerts]({{base_path}}/learn/analytics/configuring-alerts/#configure-sender-email-alerts).

### Subscribe to alerts

#### System Administrators

A system administrator is allowed to select one or more alert types to subscribe for, as well as specify a list of email addresses to which the alerts should be sent. Follow the procedure below to carry out the tasks mentioned above using the Admin Portal of WSO2 API Manager.

1.  Log into the WSO2 API Manager Admin Portal using the `https://<API-M_HOST>:<API-M_PORT>/admin` URL.
2.  Click **Manage Alerts** to open the **Manage Alert Subscriptions** page.
    ![Subscribe to alerts in admin portal]({{base_path}}/assets/img/learn/alerts-subscribe-admin-portal.png)
3.  Select the relevant check boxes based on the alert types to which you want to subscribe.
4.  Under **Email list** , enter the list of email addresses that should receive alerts. The email addresses should be those of system administrators. Each email address can be separated with a comma or you can type Email address and press Enter.
5.  Click **Save** to save the information.

An API Manager publisher/subscriber can enable/disable alert types based on the alerts that he/she wants to receive individually, as well as specify a list of email addresses to which the alerts should be sent.

#### APIM Publisher/Subscriber

1.  Log into the API Publisher or API Developer Portal with the username and password of a user with required permission.
2.  Click on the **SETTINGS** menu, to open the **Manage Alert Subscriptions** page.

    - **API Publisher**
    ![Subscribe to alerts in publisher]({{base_path}}/assets/img/learn/alerts-subscribe-publisher.png)
    
    - **API Developer Portal**
    ![Subscribe to alerts in developer portal]({{base_path}}/assets/img/learn/alerts-subscribe-devportal.png)
    
3.  Select the relevant check boxes based on the alert types to which you want to subscribe.
4.  Under **Email list** , enter the list of email addresses that should receive alerts.
5.  Click **Save** to save the information.

### Unsubscribe to alerts

#### System Administrators

1.  Log into the WSO2 API Manager Admin Portal using the `https://<API-M_HOST>:<API-M_PORT>/admin` URL.
2.  Click **Manage Alerts** to open the **Manage Alert Subscriptions** page.
    ![Unubscribe to alerts in admin portal]({{base_path}}/assets/img/learn/alerts-unsubscribe-admin-portal.png)
3.  Deselect the relevant check boxes of the alert types to which you want to unsubscribe.
4.  Under **Email list** , remove the email addresses of users that should be removed from alerts recipient list.
5.  Click **Save** to save the information.
6.  Click **Unsubscribe All** to unsubscribe from all alert types.

#### APIM Publisher/Subscriber

1.  Log into the API Publisher or API Developer Portal with the username and password of a user with required permission.
2.  Click on the **SETTINGS** menu, to open the **Manage Alert Subscriptions** page.

    - **API Publisher**
    ![Unubscribe to alerts in publisher]({{base_path}}/assets/img/learn/alerts-unsubscribe-publisher.png)
    
    - **API Developer Portal**
    ![Unubscribe to alerts in developer portal]({{base_path}}/assets/img/learn/alerts-unsubscribe-devportal.png)
    
3.  Deselect the relevant check boxes of the alert types to which you want to unsubscribe.
4.  Under **Email list** , remove the email addresses of users that should be removed from alerts recipient list.
5.  Click **Save** to save the information.
6.  Click **Unsubscribe All** to unsubscribe from all alert types.
