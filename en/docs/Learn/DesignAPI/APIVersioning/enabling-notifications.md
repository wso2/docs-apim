# Enabling Notifications

You can enable notifications at the creation of new API versions in order to notify existing subscribers (via email) that a new version of the API is available. If you want to send a different type of notification, you can extend the `org.wso2.carbon.apimgt.impl.notification.Notifier` abstract class on your own accordingly.

Follow the instructions below to enable notifications for new API versions:

1.  Set the email server configurations in the `<API-M_HOME>` / `repository/conf/output-event-adapters.xml` file under the `<adapterConfig type="email">` section.

    ``` java
         <adapterConfig type="email">
                <!-- Comment mail.smtp.user and mail.smtp.password properties to support connecting SMTP servers which use trust
                based authentication rather username/password authentication -->
                <property key="mail.smtp.from">abcd@gmail.com</property>
                <property key="mail.smtp.user">abcd</property>
                <property key="mail.smtp.password">xxxx</property>
                <property key="mail.smtp.host">smtp.gmail.com</property>
                <property key="mail.smtp.port">587</property>
                <property key="mail.smtp.starttls.enable">true</property>
                <property key="mail.smtp.auth">true</property>
                <!-- Thread Pool Related Properties -->
                <property key="minThread">8</property>
                <property key="maxThread">100</property>
                <property key="keepAliveTimeInMillis">20000</property>
                <property key="jobQueueSize">10000</property>
            </adapterConfig>
    ```

    | Property               | Description                                                                                                               |
    |------------------------|---------------------------------------------------------------------------------------------------------------------------|
    | mail.smtp.from         | The email address you use to send emails                                                                                  |
    | mail.smtp.user         | The email address used to authenticate the mail server. This can be same as `mail.smtp.from` |
    | mail.smtp.password     | Password used to authenticate the mail server.                                                                            |

2.  Log in to the Management Console and click **Main &gt; Resource &gt; Browse** .
3.  Browse to the `/_system/          config          /          apimgt          /          applicationdata          /tenant-conf.json` file and click **Edit as Text** .
4.  Set the `NotificationsEnabled` property to true as shown below:

    ``` java
            "NotificationsEnabled":"true",
              "Notifications":[{
                "Type":"new_api_version",
                "Notifiers" :[{
                  "Class":"org.wso2.carbon.apimgt.impl.notification.NewAPIVersionEmailNotifier",
                  "ClaimsRetrieverImplClass":"org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever",
                  "Title": "Version $2 of $1 Released",
                  "Template": " <html> <body> <h3 style=\"color:Black;\">We’re happy to announce the arrival of the next major version $2 of $1 API which is now available in Our API Store.</h3><a href=\"https://localhost:9443/store\">Click here to Visit WSO2 API Store</a></body></html>" 
        }]
      }
      ]
    ```
    A notification type can have multiple notifier classes that help send multiple notifications. In this case, notification sends via EMail but it could be SMS notification. Each notifier has a class attribute containing the full class path. The following properties should be set for the default `NewAPIVersionEmailNotifier` class:

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
    <td><div class="content-wrapper">
    <p>Subscriber email addresses are extracted from user claims. The default pack uses the <code>                 org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever                </code> class to read the claim values from the user store.</p>
        !!! note
        <p>Claims</p>
        <p>A claim is a piece of information about a particular subject. It can be anything that the subject is owned by or associated with, such as name, group, preferences, etc. For information on how to add new claim mappings, see <a href="https://docs.wso2.com/display/IS540/Configuring+Claims">Configuring Claims</a> .</p>

    </div></td>
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
    If you create the subscriber in the Management Console, you need to add the subscriber's email in the subscriber user profile. You can find the user profile when you list the users in the management console.

        !!! note
    If you are using a Google mail account, note that Google has restricted third-party apps and less secure apps from sending emails by default. Therefore, you need to configure your account to disable this restriction. For more information about Setting Gmail, see [Creating Users using the Ask Password Option](https://docs.wso2.com/display/IS540/Creating+Users+using+the+Ask+Password+Option) .



