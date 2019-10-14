# Adding User Roles

Roles contain permissions for users to manage the server. They can be reused and they eliminate the overhead of granting permissions to users individually.

Throughout this documentation, we use the following roles that are typically used in many enterprises. You can also define different user roles depending on your requirements.

-   **admin:** The API management provider who hosts and manages the [API Gateway](https://docs.wso2.com/display/AM210/Key+Concepts#KeyConcepts-APIGateway) and is responsible for creating users in the system, assigning them roles, managing databases, security, etc. The Admin role is also used to access the WSO2 Admin Portal ( `https://<APIM_Host>:<APIM_Port>/admin` ), where you can define workflow tasks, throttling policies, analytics configurations, etc. The Admin role is available by default with the credentials admin/admin. By default, this role contains all the permissions (including super admin permissions) in the permission tree.
-   **creator:** A creator is typically a person in a technical role who understands the technical aspects of the API (interfaces, documentation, versions etc.) and uses the [API publisher](https://docs.wso2.com/display/AM210/Key+Concepts#KeyConcepts-APIPublisher) to provision APIs into the API store. The creator uses the API Store to consult ratings and feedback provided by API users. Creator can add APIs to the store but cannot manage their lifecycle. Governance permission gives to a creator to govern, manage and configure the API artifacts.
-   **publisher:** A person in a managerial role and overlooks a set of APIs across the enterprise and controls the API lifecycle, subscriptions and monetization aspects. The publisher is also interested in usage patterns for APIs and has access to all API statistics.
-   **subscriber:** A user or an application developer who searches the [API store](https://docs.wso2.com/display/AM210/Key+Concepts#KeyConcepts-APIStore(DeveloperPortal)) to discover APIs and use them. S/he reads the documentation and forums, rates/comments on the APIs, subscribes to APIs, obtains access tokens and invokes the APIs.

Follow the instructions below to create the `creator` , `publisher` and `subscriber` roles in the API Manager for example.

!!! info
Creator, Publisher and Subscriber roles are available by default in API Manager.


### Create user roles

1.  Log in to the management console ( https://&lt;APIM\_Host&gt;:&lt;APIM\_Port&gt;/admin ) as admin (default credentials are admin/admin).
2.  In the **Main** menu, click **Add** under **Users and Roles** .
    ![]({{base_path}}/assets/attachments/103333587/103333591.png)

3.  Click **Add New Role** .
    ![]({{base_path}}/assets/attachments/103333587/103333590.png)

4.  Enter the name of the user role (e.g., `creator` ) and click **Next** .
    ![]({{base_path}}/assets/attachments/103333587/103333603.png)

        !!! info
    **Tip** : The **Domain** drop-down list contains all user stores configured in the system. By default, you only have the PRIMARY user store. To configure secondary user stores, see [Configuring Secondary User Stores](https://docs.wso2.com/display/ADMIN44x/Configuring+Secondary+User+Stores) .


5.  The permissions page opens. Select the permissions according to the role that you create. The table below lists the permissions of the `creator` , `publisher` and `subscriber` roles which are available by default:

    <table>
    <thead>
    <tr class="header">
    <th>Roles</th>
    <th>Permissions</th>
    <th>UI</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>creator</td>
    <td><ul>
    <li>Configure &gt; Governance and all underlying permissions.</li>
    <li>Login</li>
    <li>Manage &gt; API &gt; Create</li>
    <li>Manage &gt; Resources &gt; Govern and all underlying permissions</li>
    </ul></td>
    <td><div class="content-wrapper">
    <img src="attachments/103333587/103333589.png" />
    </div></td>
    </tr>
    <tr class="even">
    <td>publisher</td>
    <td><ul>
    <li>Login</li>
    <li>Manage &gt; API &gt; Publish</li>
    </ul></td>
    <td><div class="content-wrapper">
    <img src="attachments/103333587/103333588.png" />
    </div></td>
    </tr>
    <tr class="odd">
    <td><p>subscriber<br />
    </p></td>
    <td><ul>
    <li>Login</li>
    <li>Manage &gt; API &gt; Subscribe</li>
    </ul>
    <br />
    </td>
    <td><div class="content-wrapper">
    <img src="attachments/103333587/103333592.png" />
    </div></td>
    </tr>
    </tbody>
    </table>

6.  Click **Finish** once you are done adding permissions.

!!! info
When a user creates an application and generates application keys, a role is created automatically in the following format.

``` java
    "Application/<username>_<applicationName>_PRODUCTION"
```

These roles do not have any permissions assigned to it, but it is used to manage the visibility of the corresponding service provider that is created in the format of `'<username>_<applicationName>_PRODUCTION'` within the Key Manager. The created service provider is only visible to users with the latter mentioned role that has been generated automatically. Only if a user with admin privileges assigns the latter mentioned role to a user, will that user be able to view the details of the service provider that is created per application.


