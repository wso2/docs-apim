# Enabling Notifications

You can enable notifications when you create new API versions, to notify the existing subscribers (via email) that a new version of the API is available. If you want to send a different type of notification, you can extend the `org.wso2.carbon.apimgt.impl.notification.Notifier` abstract class based on your requirements.

Follow the instructions below to enable notifications for new API versions:

1.  Add the email server configurations to the `<API-M_HOME>/repository/conf/deployment.toml` file as follows:

    ``` toml
    [apim.notification]
    from_address = "abcd@gmail.com"
    username = "abcd@gmail.com"
    password = "xxxxxx"
    signature = "do not reply"
    hostname = "smtp.gmail.com"
    port = "587"
    enable_start_tls = true
    enable_authentication = true
    ```

    | Property               | Description                                                                                                               |
    |------------------------|---------------------------------------------------------------------------------------------------------------------------|
    | from_address           | The email address you use to send emails.                                                                                  |
    | username               | The email address used to authenticate the mail server. This can be the same email address as the `from_address`. |
    | password               | Password used to authenticate the mail server.                                                                            |
    | signature              | Signature of the sender account.
                                                                                |
    
    For more information, see [Enable Notifications]({{base_path}}/reference/config-catalog/#enable-notifications).    


2.  Sign in to the Management Console.

    `https://<hostname>:9443/carbon` 
   
    Example: `https://localhost:9443/carbon`

3. Click **Main &gt; Resource &gt; Browse**.

    [![Browser option]({{base_path}}/assets/img/learn/browse-option.png)]({{base_path}}/assets/img/learn/browse-option.png)


4.  Enter `/_system/config/apimgt/applicationdata/tenant-conf.json`, click **Go**, and click **Edit as Text**.

5.  Set the `NotificationsEnabled` property to `true` as shown below:

    ``` json
    "NotificationsEnabled":"true",
      "Notifications":[{
        "Type":"new_api_version",
        "Notifiers" :[{
          "Class":"org.wso2.carbon.apimgt.impl.notification.NewAPIVersionEmailNotifier",
          "ClaimsRetrieverImplClass":"org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever",
          "Title": "Version $2 of $1 Released",
          "Template": " <html> <body> <h3 style=\"color:Black;\">We’re happy to announce the arrival of the next major version $2 of $1 API which is now available in Our Developer Portal.</h3><a href=\"https://localhost:9443/devportal\">Click here to Visit WSO2 API Developer Portal</a></body></html>" 
        }]
      }]
    ```

    A notification type can have multiple notifier classes that help send multiple notifications. In this case, the notifications are sent via e-mail but it could be a SMS notification. Each notifier has a class attribute containing the full class path. The following properties should be set for the default `NewAPIVersionEmailNotifier` class:

    <table>
    <thead>
    <tr class="header">
    <th>Property</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Class</td>
    <td>The full class path of the notifier class.</td>
    </tr>
    <tr class="even">
    <td>ClaimsRetrieverImplClass</td>
    <td><p>Subscriber email addresses are extracted from user claims. The default pack uses the <code>org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever</code> class to read the claim values from the user store.</p>
      <div class="admonition note">
      <p class="admonition-title">Claims</p>
      <p>A claim is a piece of information about a particular subject. It can be anything that the subject is owned by or associated with, such as name, group, preferences, etc. For information on how to add new claim mappings, see <a href="https://is.docs.wso2.com/en/5.10.0/learn/configuring-claims/">Configuring Claims</a>.</p>
      </div>
    </td>
    </tr>
    <tr class="odd">
    <td>Title</td>
    <td>The subject of the email.</td>
    </tr>
    <tr class="even">
    <td>Template</td>
    <td>The template of the email body. This can be string values or a valid registry path to a template file.</td>
    </tr>
    </tbody>
    </table>

    The following strings are replaced with API specific values in the `Title` and `Template` properties.

    $1 - API name

    $2 - New API version

    !!! note
        If you create the subscriber via the Management Console, you need to add the subscriber's email in the subscriber user profile. You can find the user profile when you list the users in the management console.

    !!! note
        If you are using a Google mail account, note that Google has restricted third-party apps and apps with lower security levels from sending emails by default. Therefore, you need to configure your account to disable this restriction. For more information on Setting up Gmail, see [Creating Users using the Ask Password Option](https://is.docs.wso2.com/en/5.10.0/learn/creating-users-using-the-ask-password-option/).


