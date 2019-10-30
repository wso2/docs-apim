# Configuring Alerts

WSO2 API Manager Analytics allows you to customize and configure the analytics-based alerts sent to the subscribers using the features listed below.

-   Configure sending email alerts
-   Edit alerts as business rules
-   Configure alerts via the Publisher
-   Configure alerts via the Developer Portal

Once you have configured alerts, you can subscribe to alerts to receive email notifications. For instructions, see [Subscribing for Alerts](../../../../../Learn/Analytics/ManagingAlertsWithRealTimeAnalytics/subscribing-for-alerts/) .

!!! note
     Before you begin, make sure that you have configured Analytics for API Manager. For instructions, see [Configuring APIM Analytics](../../../../../Learn/Analytics/configuring-apim-analytics/).


### Configure sending email alerts

The users of your APIs can subscribe to analytics-related alerts from the API Publisher and the API Developer Portal. Follow the instructions below to configure an email address with API Manager to send email alerts to subscribers.

1.  Open the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file.
2.  Configure the sender email address. The sample code is shown below.

    ``` java
        siddhi:
          extensions:
        ...
            -
              extension:
                name: email
                namespace: sink
                properties:
                  username: alex@gmail.com
                  address: alex@gmail.com
                  password: password 
        ...
    ```

    !!! warning
          Note that you might have to bypass a security warning to configure this with a private email address.


3.  Go to the `<API-M_ANALYTICS_HOME>/resources/apim-analytics/` directory. Copy the `APIM_ALERT_EMAIL_NOTIFICATION.siddhi` file and paste it in the `<API-M_ANALYTICS_HOME>/wso2/worker/deployment/siddhi-files` directory.
4.  Restart the servers.

### Edit alerts as business rules

1.  Go to the `<API-M_ANALYTICS_HOME>/bin` directory and run the following command to start the dashboard, if you have not started it already.

    -   On Windows: `dashboard.bat --run` 
    -   On Linux: `sh dashboard.sh`

2.  Go to the Business Rules and Status Dashboard. ( e.g., `https://<API-M_ANALYTICS_HOST>:9643/business-rules                    )         `
3.  You can view the existing business rules that are applied for API Manager. Depending on your privileges, you can view, edit, and delete business rules.
    For more details on working with business rules, see [Managing Business Rules](https://ei.docs.wso2.com/en/latest/streaming-integrator/admin/creating-business-rules-templates/#managing-business-rules) .
    ![Alerts business rules](../../../../assets/img/Learn/alerts-business-rules.png)

### Configure alerts via the Publisher

Follow the instructions below to manage alerts via the Publisher:

- [Create an abnormal response time alert](../../../../../Learn/Analytics/ManagingAlertsWithRealTimeAnalytics/configuring-alerts/#create-an-abnormal-response-time-alert/)
- [Create an abnormal backend time alert](../../../../../Learn/Analytics/ManagingAlertsWithRealTimeAnalytics/configuring-alerts/#create-an-abnormal-backend-time-alert/)

!!! info
     You can not disable Health Availability related alerts, because they are enabled by default. However, you can enable and disable the email alerts that correspond to the Health Availability alerts.

#### Create an abnormal response time alert

1.  Log into the API Publisher with the username and password of a user with required permission.
2.  Click on the **SETTINGS** menu, to open the Manage Alert Subscriptions page.
![Publisher alerts settings](../../../../assets/img/Learn/alerts-settings-publisher.png)

3.  Click on the **Configuration** option that corresponds to the Abnormal Response Time option.
![Alerts configuration icon](../../../../assets/img/Learn/alerts-config-icon.png)

4.  Click **New Configuration** to add a new configuration
![Add new abnormal response time configuration](../../../../assets/img/Learn/alerts-abnormal-response-time-config-new.png)

5.  Select the API name and version for which you need to set up the alerts and define the time period (in milliseconds).
![Add new abnormal response time configuration](../../../../assets/img/Learn/alerts-abnormal-response-time-config.png)

6.  Click on **Add** to save the alert configuration <br />
    <html>
        <head />
        <body>
            <img src="../../../../assets/img/Learn/alerts-config-add.png" alt="Add alert configuration" title="Add alert configuration" width="60" />
        </body>
    </html>
    
Immediately after the response period of the API exceeds the above defined time period an alert gets triggered, such alerts could be treated as an indication of a slow WSO2 API Manager runtime or a slow backend.

#### Create an abnormal backend time alert

1.  Log into the API Publisher with the username and password of a user with required permission.
2.  Click on the **SETTINGS** menu, to open the Manage Alert Subscriptions page.
![Publisher alerts settings](../../../../assets/img/Learn/alerts-settings-publisher.png)

3.  Click on the **Configuration** option that corresponds to the Abnormal Backend Time option.
![Alerts configuration icon](../../../../assets/img/Learn/alerts-config-icon.png)

4.  Click **New Configuration** to add a new configuration
![Add new abnormal response time configuration](../../../../assets/img/Learn/alerts-abnormal-backend-time-config-new.png)

5.  Select the API name and version for which you need to set up the alerts and define the time period (in milliseconds).
![Add new abnormal response time configuration](../../../../assets/img/Learn/alerts-abnormal-backend-time-config.png)

6.  Click on **Add** to save the alert configuration <br />
    <html>
        <head />
        <body>
            <img src="../../../../assets/img/Learn/alerts-config-add.png" alt="Add alert configuration" title="Add alert configuration" width="60" />
        </body>
    </html>
    
Immediately after the backend time of the API exceeds the above defined time period an alert gets triggered, such alerts could be treated as an indication of a slow backend. In technical terms, if the backend time of a particular API of a tenant lies outside the predefined value, an alert is sent.
### Configure alerts via the Developer Portal

Follow the instructions below to manage alert types via the Developer Portal:

- [Create an abnormal requests per minute alert](../../../../../Learn/Analytics/ManagingAlertsWithRealTimeAnalytics/configuring-alerts/#create-an-abnormal-requests-per-minute-alert/)

!!! info
     You can not disable Abnormal Resource Access Alerts, Unseen Source IP Access Alerts and Tier Crossing Alerts, because they are enabled by default. However, you can enable and disable the email alerts that correspond to the latter mentioned alerts.
     
#### Create an abnormal requests per minute alert

1.  Log into the API Developer Portal with the username and password of a user with required permission.
2.  Click on the **SETTINGS** menu, to open the Manage Alert Subscriptions page.
![Publisher alerts settings](../../../../assets/img/Learn/alerts-settings-devportal.png)

3.  Click on the **Configuration** option that corresponds to the Abnormal Requests per Minute option. <br />
![Alerts configuration icon](../../../../assets/img/Learn/alerts-config-icon.png)

4.  Click **New Configuration** to add a new configuration
![Add new abnormal request count configuration](../../../../assets/img/Learn/alerts-abnormal-request-per-min-config-new.png)

5.  Select the API name and version for which you need to set up the alerts and define the request count per minute.
![Add new abnormal request count configuration](../../../../assets/img/Learn/alerts-abnormal-request-per-min-config.png)

6.  Click on **Add** to save the alert configuration <br />
    <html>
        <head />
        <body>
            <img src="../../../../assets/img/Learn/alerts-config-add.png" alt="Add alert configuration" title="Add alert configuration" width="60" />
        </body>
    </html>

Immediately after the request count of the API exceeds the above defined request count per minute an alert gets triggered. These alerts could be treated as indications of possible high traffic, suspicious activity, possible malfunction of the client application etc.