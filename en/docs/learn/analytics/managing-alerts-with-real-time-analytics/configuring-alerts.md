# Configuring Alerts

WSO2 API Manager Analytics allows you to customize and configure the analytics-based alerts sent to the subscribers using the features listed below.

-   [Configure sending email alerts](#ConfiguringAlerts-Configuresendingemailalerts)
-   [Edit alerts as business rules](#ConfiguringAlerts-Editalertsasbusinessrules)

!!! note
Before you begin...

Make sure that you have configured Analytics for API Manager. For instructions, see [Configuring APIM Analytics](_Configuring_APIM_Analytics_) .


### Configure sending email alerts

The users of your APIs can subscribe to analytics-related alerts from the API Publisher and the API Store. Follow the instructions below to configure an email address with API Manager to send email alerts to subscribers.

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

    -   [**On Windows**](#cab702f4a75a4df0b4740e2f4490ec33)
    -   [**On Linux**](#941b07699f2d4cf79b96b0e1728ef57c)

    ``` java
        dashboard.bat --run
    ```

    ``` java
            sh dashboard.sh
    ```

2.  Go to the Business Rules and Status Dashboard. ( e.g., `https://localhost:9643/business-rules                    )         `
3.  You can view the existing business rules that are applied for API Manager. Depending on your privileges, you can view, edit, and delete business rules.
    For more details on working with business rules, see [Managing Business Rules](https://docs.wso2.com/display/SP430/Managing+Business+Rules) .
    ![]({{base_path}}/assets/attachments/103335144/103335145.png)
