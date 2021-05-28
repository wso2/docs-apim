# Configuring Alerts
    
WSO2 API Manager analytics-based alerts are disabled by default. Once you [enable alerts]({{base_path}}/observe/api-manager-analytics/configuring-alerts/#enable-alerts), you can customize and configure the analytics-based alerts using the features listed below.

-   Configure sender email alerts
-   Configure alerts as business rules
-   Configure alerts via the Publisher
-   Configure alerts via the Developer Portal

Once you have configured alerts, you can subscribe to alerts to receive email notifications. For instructions, see [Subscribing for Alerts]({{base_path}}/observe/api-manager-analytics/subscribing-for-alerts/).

!!! note
     Before you begin, make sure that you have configured Analytics for API Manager. For instructions, see [Configuring APIM Analytics]({{base_path}}/observe/api-manager-analytics/overview-of-api-analytics/).

### Enable alerts

WSO2 API Manager analytics-based alerts are disabled by default. Follow the instructions below to enable alerts.

1.  Shut down the analytics server if it is running.
2.  Open the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file.
3.  Uncomment the following configuration.
    ``` java
    analytics.solutions:
        APIM-alerts.enabled: true
    ```
4.  Go to the `<API-M_ANALYTICS_HOME>/bin` directory and run the following command to start the worker, to deploy the alerts Siddhi applications.

    -   On Windows: `worker.bat --run` 
    -   On Linux: `sh worker.sh`

### Configure sender email alerts

!!! note
    - If you do not require to subscribe to email notifications for alerts, you can skip these steps. 
    - Admin users can view analytics in the Admin Portal (`https://<API-M_HOST>:<API-M_PORT>/admin`) without configuring the sender email address.
     
The users of your APIs can subscribe to analytics-related alerts from the API Publisher and the API Developer Portal. Follow the instructions below to configure an email address with WSO2 API Manager to send email alerts to subscribers.

1.  Open the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file.
2.  Navigate to the `extensions` configuration under `siddhi` configurations.
3.  Add a new extension to configure the sender email address.
     
     The sample code is shown below.

     - If you are using **Gmail as the SMTP host**.
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
    
    - If you are using an **SMTP host other than Gmail**.
        ```java
        siddhi:
        extensions:
        ...
            -
            extension:
                name: email
                namespace: sink
                properties:
                    username: <senders-email-username>
                    address: <senders-email-address>
                    password: <senders-email-password>
                    mail.smtp.host: <senders-email-host>
                    port: 25
                    ssl.enable : false
                    auth : false
                    mail.store.protocol: pop3
                    mail.smtp.starttls.enable: true
        ...
        ```

    For more details on the email sender configurations, see the [Siddhi IO Email configurations](https://siddhi-io.github.io/siddhi-io-email/api/2.0.5/#email-sink) in the official Siddhi documentation.

    !!! warning
          Note that you might have to bypass a security warning to configure this with a private email address.

3.  Go to the `<API-M_ANALYTICS_HOME>/resources/apim-analytics/` directory. Copy the `APIM_ALERT_EMAIL_NOTIFICATION.siddhi` file and paste it in the `<API-M_ANALYTICS_HOME>/wso2/worker/deployment/siddhi-files` directory.
4.  Restart the servers.

### Configure alerts as business rules

You can configure alerts as a business rule by using the features listed below.

-   View deployment information of alerts
-   View alerts configuration
-   Edit alerts configuration
-   Delete alerts configuration
-   Undeploy alerts configuration

!!! note
    Before you begin, make sure that the worker instance of the Analytics server is running.

1.  Open the `<API-M_ANALYTICS_HOME>/conf/dashboard/deployment.yaml` file and do the following.

    Point the business rules manager to the worker node by configuring the `deployment_configs` of `wso2.business.rules.manager` as shown below.

    ``` java
    wso2.business.rules.manager:
        datasource: BUSINESS_RULES_DB
        # rule template wise configuration for deploying business rules
        deployment_configs:
        -
            # <IP>:<HTTPS Port> of the Worker node
            <API-M_ANALYTICS_WORKER_HOST>:<API-M_ANALYTICS_WORKER_PORT>
        ...
    ```

2.  Go to the `<API-M_ANALYTICS_HOME>/bin` directory and run the following command to start the dashboard.

    -   On Windows: `dashboard.bat --run` 
    -   On Linux: `sh dashboard.sh`

3.  Sign in to the Business Rules. (e.g., `https://<API-M_ANALYTICS_HOST>:9643/business-rules`)

4.  You can view the existing business rules that are applied for WSO2 API Manager. Depending on your privileges, you can view, edit, and delete business rules.
    For more details on working with business rules, see [Managing Business Rules](https://ei.docs.wso2.com/en/latest/streaming-integrator/admin/creating-business-rules-templates/#managing-business-rules).
    ![Alerts business rules]({{base_path}}/assets/img/learn/alerts-business-rules.png)

### Configure alerts via the Publisher

Follow the instructions below to manage alerts via the Publisher:

- [Create an abnormal response time alert]({{base_path}}/observe/api-manager-analytics/configuring-alerts/#create-an-abnormal-response-time-alert/)
- [Create an abnormal backend time alert]({{base_path}}/observe/api-manager-analytics/configuring-alerts/#create-an-abnormal-backend-time-alert/)

!!! info
     You can not disable Health Availability related alerts, because they are enabled by default. However, you can enable and disable the email alerts that correspond to the Health Availability alerts.

#### Create an abnormal response time alert

1. Sign in to the API Publisher with the username and password of a user with the required permission.
2. Click **SETTINGS**.

     The Manage Alert Subscriptions page appears.
     
     ![Publisher alerts settings]({{base_path}}/assets/img/learn/alerts-settings-publisher.png)

3. Click on the **Configuration** option that corresponds to the Abnormal Response Time option.
    
    ![Alerts configuration icon]({{base_path}}/assets/img/learn/alerts-config-icon.png)

4.  Click **New Configuration** to add a new configuration
![Add new abnormal response time configuration]({{base_path}}/assets/img/learn/alerts-abnormal-response-time-config-new.png)

5.  Select the API name and version for which you need to set up the alerts and define the time period (in milliseconds).
![Add new abnormal response time configuration]({{base_path}}/assets/img/learn/alerts-abnormal-response-time-config.png)

6.  Click on **Add** to save the alert configuration <br />
    <html>
        <head />
        <body>
            <img src="{{base_path}}/assets/img/learn/alerts-config-add.png" alt="Add alert configuration" title="Add alert configuration" width="60" />
        </body>
    </html>
    
Immediately after the response period of the API exceeds the above defined time period an alert gets triggered, such alerts could be treated as an indication of a slow WSO2 API Manager runtime or a slow backend.

#### Create an abnormal backend time alert

1.  Sign in to the API Publisher with the username and password of a user with the required permission.
2.  Click **SETTINGS**. 

     The Manage Alert Subscriptions page.
     
     ![Publisher alerts settings]({{base_path}}/assets/img/learn/alerts-settings-publisher.png)

3.  Click on the **Configuration** option that corresponds to the Abnormal Backend Time option.
![Alerts configuration icon]({{base_path}}/assets/img/learn/alerts-config-icon.png)

4.  Click **New Configuration** to add a new configuration
![Add new abnormal response time configuration]({{base_path}}/assets/img/learn/alerts-abnormal-backend-time-config-new.png)

5.  Select the API name and version for which you need to set up the alerts and define the time period (in milliseconds).
![Add new abnormal response time configuration]({{base_path}}/assets/img/learn/alerts-abnormal-backend-time-config.png)

6.  Click on **Add** to save the alert configuration <br />
    <html>
        <head />
        <body>
            <img src="{{base_path}}/assets/img/learn/alerts-config-add.png" alt="Add alert configuration" title="Add alert configuration" width="60" />
        </body>
    </html>
    
Immediately after the backend time of the API exceeds the above defined time period an alert gets triggered, such alerts could be treated as an indication of a slow backend. In technical terms, if the backend time of a particular API of a tenant lies outside the predefined value, an alert is sent.

### Configure alerts via the Developer Portal

Follow the instructions below to manage alert types via the Developer Portal:

- [Create an abnormal requests per minute alert]({{base_path}}/observe/api-manager-analytics/configuring-alerts/#create-an-abnormal-requests-per-minute-alert/)

!!! info
     You can not disable Abnormal Resource Access Alerts, Unseen Source IP Access Alerts and Tier Crossing Alerts, because they are enabled by default. However, you can enable and disable the email alerts that correspond to the latter mentioned alerts.
     
#### Create an abnormal requests per minute alert

1.  Sign in to the API Developer Portal with the username and password of a user with the required permission.
2.  Click on the **SETTINGS** menu, to open the Manage Alert Subscriptions page.
![Publisher alerts settings]({{base_path}}/assets/img/learn/alerts-settings-devportal.png)

3.  Click on the **Configuration** option that corresponds to the Abnormal Requests per Minute option. <br />
![Alerts configuration icon]({{base_path}}/assets/img/learn/alerts-config-icon.png)

4.  Click **New Configuration** to add a new configuration.
![Add new abnormal request count configuration]({{base_path}}/assets/img/learn/alerts-abnormal-request-per-min-config-new.png)

5.  Select the API name and version for which you need to set up the alerts and define the request count per minute.
![Add new abnormal request count configuration]({{base_path}}/assets/img/learn/alerts-abnormal-request-per-min-config.png)

6.  Click on **Add** to save the alert configuration <br />
    <html>
        <head />
        <body>
            <img src="{{base_path}}/assets/img/learn/alerts-config-add.png" alt="Add alert configuration" title="Add alert configuration" width="60" />
        </body>
    </html>

Immediately after the request count of the API exceeds the above-defined request count per minute an alert gets triggered. These alerts could be treated as indications of possible high traffic, suspicious activity, possible malfunction of the client application etc.
