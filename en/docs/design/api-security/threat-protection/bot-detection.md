# Bot Detection

There is a possibility that hackers may invoke services without any proper authentication by using tools such as port scanning. Therefore, WSO2 API Manager (WSO2 API-M) provides a bot detection mechanism in place. There is an unadvertised service deployed in the gateway that logs and sends events to that API-M Analytics if it receives any traffic. These events can then be configured to send e-mail alerts and also to be shown in the bot detection dashboard via the Admin Portal. Thereby, this helps Publishers to protect their data from bot attackers and improve the security of the data.

If hackers (e.g., bot attackers) try to invoke the unadvertised service, WSO2 API Manager will log the API calls in the `<API-M_HOME>/repository/logs/wso2-BotDetectedData.log` file. The following is a sample log record.
```
INFO BotDetectionMediator MessageId : urn:uuid:535437f1-a178-4722-a232-164e4a7e0207 | Request Method : POST | Message Body : <soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><jsonObject/></soapenv:Body> | client Ip : 127.0.0.1 | Headers set : [Accept=*/*, activityid=4b932127-d07e-43c3-bee2-4f5344074185, Content-Length=2, Content-Type=application/json, Host=localhost:8243, User-Agent=curl/7.58.0]  
```

 <html>
  <div class="admonition info">
  <p class="admonition-title">Info</p>
  <p>You can view the above logs without configuring API Manager Analytics</p>
  </div> 
  </html>

If you enable WSO2 API Manager Analytics with WSO2 API Manager, you can enable email notifications for all unauthorized API calls that you receive and also view the bot detection data easily via the Admin Portal.


  <html>
  <div class="admonition note">
  <p class="admonition-title">Note</p>
  <p>If you wish to work with a third-party monitoring tool, then you can use the  details in the <code><API-M_HOME>/repository/logs/wso2-BotDetectedData.log</code> trace log and build an alert mechanism to receive alerts. </p>
  </div> 
  </html>

## Enabling email notifications for bot detection

Follow the instructions below to enable email notifications for bot detection:

1. Enable WSO2 API Manager Analytics.

    Follow steps 1, 2, and 3 of the quick setup in [Configuring API Manager Analytics]({{base_path}}/observe/api-manager-analytics/configuring-apim-analytics/).
    
2. Share your API-M database (`AM_DB`).

     Add the following `AM_DB` datasource configuration in the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file under the `wso2.datasources:` section.
     
     ```
     wso2.datasources:
      dataSources:
        ...

        - name: AM_DB
            description: "Main datasource used by API Manager."
            jndiConfig:
              name: jdbc/AM_DB
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:mysql://localhost:3306/apimgt_database'
                username: username
                password: password
                driverClassName: com.mysql.jdbc.Driver
                maxPoolSize: 50
                idleTimeout: 60000
                connectionTestQuery: SELECT 1
                validationTimeout: 30000
                isAutoCommit: false
        ...

     ```

3. [Enable Alerts]({{base_path}}/observe/api-manager-analytics/configuring-alerts/#enable-alerts).

4. Follow the instructions below to configure an email address to send email alerts to subscribers.

    - Open the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file.
    - Navigate to the `extensions` configuration under `siddhi` configurations.
    - Add a new extension to configure the sender email address. The sample code is shown below.

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


      - Go to the `<API-M_ANALYTICS_HOME>/resources/apim-analytics/` directory. Copy the `APIM_ALERT_BOT_DETECTION_EMAIL.siddhi` file and paste it in the `<API-M_ANALYTICS_HOME>/wso2/worker/deployment/siddhi-files` directory.

5. Start the WSO2 API Manager Analytics server.
   
     Navigate to the `<API-M_ANALYTICS_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.

    - On Windows:  `worker.bat --run`
    - On Linux/Mac OS:  `sh worker.sh`
    

6. Start the WSO2 API Manager server.
  
    Navigate to the  `<API-M_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.

    - On Windows:  `api-manager.bat --run`
    - On Linux/Mac OS:  `sh api-manager.sh`
    

7. Sign in to the API Manager Admin Portal.

     `https://<IP_Address>:9443/admin`

8. Click **Configure Emails** under **Bot Detection** category and Click **Add Email**.
  
    ![Add email Menu]({{base_path}}/assets/img/learn/bot-email-notification-menu.png)

9. Enter the recipient's email address and click **Save**.
    ![Add email Recipient]({{base_path}}/assets/img/learn/bot-email-notification-recipient-adding.png)

    If a hacker (e.g., bot attacker) tries to invoke an open service API, WSO2 API Manager will send emails to the email alert recipients. The following is a sample email notification.

    ![Sample email notification for unauthorized API call]({{base_path}}/assets/img/learn/sample-alert-email.png)
 
## Viewing bot detection data via the Admin Portal

Follow the instructions below to view the bot detection data for the unauthorized API calls via the Admin Portal.

  <html>
  <div class="admonition note">
  <p class="admonition-title">Note</p>
  <p>Skip steps 1 to 7 if you have already enabled API Manager Analytics, configured the AM_DB database, configured Alerts, started the WSO2 API Manager Analytics and WSO2 API Manager servers, and signed in to the Admin Portal.</p>
  </div> 
  </html>

1. Enable WSO2 API Manager Analytics.

    Follow steps 1, 2, and 3 of the quick setup in [Configuring API Manager Analytics]({{base_path}}/observe/api-manager-analytics/configuring-apim-analytics/).
    
2. Share your API-M database (`AM_DB`). 

     Add the following `AM_DB` datasource configuration in the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file under the `wso2.datasources:` section.
     
     ```
     wso2.datasources:
        ...
        - name: AM_DB
            description: "Main datasource used by API Manager."
            jndiConfig:
              name: jdbc/AM_DB
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:mysql://localhost:3306/apimgt_database'
                username: username
                password: password
                driverClassName: com.mysql.jdbc.Driver
                maxPoolSize: 50
                idleTimeout: 60000
                connectionTestQuery: SELECT 1
                validationTimeout: 30000
                isAutoCommit: false
        ...
     ```

3. [Enable Alerts]({{base_path}}/observe/api-manager-analytics/managing-alerts-with-real-time-analytics/configuring-alerts/#enable-alerts).

4. Follow the instructions below to configure an email address to send email alerts to subscribers.

    - Open the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file.
    - Navigate to the `extensions` configuration under `siddhi` configurations.
    - Add a new extension to configure the sender's email address. The sample code is shown below.

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


      - Go to the `<API-M_ANALYTICS_HOME>/resources/apim-analytics/` directory. Copy the `APIM_ALERT_BOT_DETECTION_EMAIL.siddhi` file and paste it in the `<API-M_ANALYTICS_HOME>/wso2/worker/deployment/siddhi-files` directory.

5. Start the WSO2 API Manager Analytics server.
   
     Navigate to the `<API-M_ANALYTICS_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.

    - On Windows:  `worker.bat --run`
    - On Linux/Mac OS:  `sh worker.sh`
    

6. Start the WSO2 API Manager server.
  
    Navigate to the  `<API-M_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.

    - On Windows:  `api-manager.bat --run`
    - On Linux/Mac OS:  `sh api-manager.sh`
    

7. Sign in to the API Manager Admin Portal.

     `https://<IP_Address>:9443/admin`

8. Click **Bot Detection Data**.

     ![Bot detection data details for unauthorized API calls]({{base_path}}/assets/img/learn/bot-data.png)

    If a hacker (e.g., bot attacker) tries to invoke an open service API, the Bot detection data details will appear in the `<API-M_HOME>/repository/logs/wso2-BotDetectedData.log` file.
