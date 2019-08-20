# Customizing the API Store

You can customize the API Store in the following ways:

-   [Enabling or disabling self signup](#CustomizingtheAPIStore-Enablingordisablingselfsignup)
-   [Enabling or disabling the walkthrough](#CustomizingtheAPIStore-Enablingordisablingthewalkthrough)
-   [Enabling or disabling the forum](#CustomizingtheAPIStore-Enablingordisablingtheforum)
-   [Changing the theme](#CustomizingtheAPIStore-Changingthetheme)
-   [Changing language settings](#CustomizingtheAPIStore-Changinglanguagesettings)
-   [Setting single login for all apps](#CustomizingtheAPIStore-Settingsingleloginforallapps)
-   [Categorizing and grouping APIs](#CustomizingtheAPIStore-CategorizingandgroupingAPIs)
-   [Customizing the API group](#CustomizingtheAPIStore-CustomizingtheAPIgroup)
-   [Customizing error Pages](#CustomizingtheAPIStore-CustomizingerrorPages)

### Enabling or disabling self signup

In a multi-tenanted API Manager setup, self signup to the API Store is disabled by default to all tenants except the super tenant. A tenant admin can enable it as follows:

1.  Sign in to the management console ( `          https://<HostName>:9443/carbon         ` ) as admin (or tenant admin).
2.  In the **Main** menu, click **Add** under **Users and Roles** .
    ![](attachments/103333490/103333513.png)

3.  Click **Add New Role** .
    ![](attachments/103333490/103333512.png)
4.  Add a role by the name subscriber (or any other name you prefer).
    ![](attachments/103333490/103333511.png)
5.  Click **Next** and add the following permissions:
    ![subscribePermission.png](attachments/50518268/51250899.png)
6.  Go to the **Resources** **&gt; Browse** menu.
7.  Navigate to the `           /_system/governance/apimgt/applicationdata/          ` directory.

8.  Click on `           sign-up-config.xml          ` to load the resource in the registry browser UI and select the "Edit as text " option to edit the configurations.

    ![](attachments/103333490/103333502.png)
9.  Do the following changes in the signup configuration and save.

    -   Set `            <EnableSignup>           ` to `            true.           `
    -   Set `            <RoleName>           ` to `            subscriber           ` and `            <IsExternalRole>           ` to `            true           ` . Note that you must have the subscriber role created at this point.
    -   Set `            <AdminUserName>           ` and `            <AdminPassword>           ` to the credentials of the super admin, or if you are in a **multitenant setup** and you are not the super admin, to the tenant admin's credentials. **Note** that the super admin's credentials are admin/admin by default. If you changed the default super admin's credentials, using admin/admin will cause errors.

    ``` xml
        <selfsignup>
     <enablesignup>true</enablesignup>

     <!-- user storage to store users -->
     <signupdomain>PRIMARY</signupdomain>

     <!-- Tenant admin information. (for clustered setup credentials for AuthManager) -->
     <adminusername>xxxx</adminusername>
     <adminpassword>xxxx</adminpassword>

     <!-- List of roles for the tenant user -->
     <signuproles>
      <signuprole>
       <rolename>subscriber</rolename>
       <isexternalrole>true</isexternalrole>
      </signuprole>
     </signuproles>

    </selfsignup>
    ```
10. Restart the server and open the API Store ( `           https://<HostName>:9443/store          ` )
    Note the **Sign-up** link that appears in the top, right-hand corner of the window.
    ![](attachments/103333490/103333501.png)
11. To disable the self signup capability, n avigate to the `          /_system/governance/apimgt/applicationdata/sign-up-config.xml         ` file in the registry again and set the `          <SelfSignUp><EnableSignup>         ` element to false.
    ![](attachments/103333490/103333500.png)
!!! tip
Tip : To engage your own signup process, see Adding a User Signup Workflow .


### Enabling or disabling the walkthrough

To disable the API Store walkthrough, open the `         <APIM_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/interactiveTutorial.json        ` file.

Set the `         isEnabledTutorial        ` parameter to false as show below.

``` java
    {
        "isEnabledTutorial" : false,
        "blackListedTenantDomains" : []
    }
```

### Enabling or disabling the forum

The Forum is enabled by default in the API Manager Store.
![](attachments/103333490/103333491.png){height="250"}
Follow the instructions below to disable the Forum:

1.  Navigate to the `          <API_HOME>/repository/conf/api-manager.xml         ` file.
2.  Uncomment the following code.

    ``` java
            <isStoreForumEnabled>false</isStoreForumEnabled>
    ```

3.  Restart WSO2 API Manager.
    If you access the API Store, you will notice that the Forum is no longer available.

### Changing the theme

See [Adding a New API Store Theme](https://docs.wso2.com/display/AM260/Adding+a+New+API+Store+Theme) .

### Changing language settings

To change the language of the API Store, see [Adding Internationalization and Localization](_Adding_Internationalization_and_Localization_) .

### Setting single login for all apps

Single sign-on (SSO) allows users who are logged in to one application to automatically log in to multiple other applications using the same credentials. They do not have to repeatedly authenticate themselves. To configure, see [Configuring Single Sign-on with SAML2](_Configuring_Single_Sign-on_with_SAML2_) .

### Categorizing and grouping APIs

API providers add tags to APIs when designing them using the API Publisher. Tags allow API providers to categorize APIs that have similar attributes. When a tagged API gets published to the API Store, its tags appear as clickable links to the API consumers, who can use them to quickly jump to a category of interest. The font size of the tag in the Store varies based on the number of APIs that are assigned to it. Therefore, for example the font size of a tag which has 10 APIs assigned to it will be bigger than the font size of a tag that has only 2 APIs assigned to it.
![](attachments/103333490/103333494.png)
If you want to see the APIs grouped according to different topics in the API Store, add an API group:

!!! note
Although the way in which you add a Tag and API group appears to be similar there are differences. Therefore, you need to note the following:

-   The **group name** **should always have** the **suffix `           -group          `** and it **can have** **spaces** in it (e.g., APIs groups-group).
-   The **tag name** should **not have a suffix or prefix** , but it **can have spaces** .


1.  Go to `          <API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf         ` directory, open the `          site.json         ` file and set the `          tagWiseMode         ` attribute as true.
2.  Add an API group to the APIs that you wish to group.
    1.  Go to the API Publisher ( `            https://<HostName>:9443/publisher           ` ).
    2.  Click on the edit link of the respective API as shown below.
        ![](attachments/103333490/103333498.png)    3.  Add a group name to the APIs that you wish to group.

        For example add the "APIs groups-group" tag to the Workflow and Integration APIs.

    4.  Save the API for the tag to appear in the Store.

    5.  Repeat steps 2 (a) to (d) to add another APIs to the newly created group.

    Sign in to the API Store and note the API groups.
    ![](attachments/103333490/103333496.png)    If you wish, you can click on a group to see the APIs that belong to a specific group.
    ![](attachments/103333490/103333495.png)
### Customizing the API group

If you want to change the descriptions and the thumbnail images that come by default, do the following:

1.  Sign in to the Management Console and click the **Resources &gt; Browse** menu to open the registry.
    ![](attachments/103333490/103333506.png)
2.  Create a collection named `          tags         ` under the registry location `          /_system/governance/apimgt/applicationdata         ` .
    ![](attachments/103333490/103333505.png)
3.  Give read permission to the `          system/wso2.anonymous.role         ` role.
    ![](attachments/103333490/103333504.png)
4.  Add each tag as collections under the tags collection (e.g., Workflow APIs-group, Integration APIs-group, Quote APIs-group.)
5.  Navigate to each tag collection and upload the following:
    -   **description.txt** with the description of the tag
    -   **thumbnail.png** for the thumbnail image
6.  Back in the API Store, note the changes you did in the registry.

### Customizing error Pages

In API Manager store/publisher and admin webapps, **jaggery.conf** is the Jaggery configuration file specifies the application specific configurations. In that file we can find following code block which have configured the error pages.

``` java
    "errorPages":
             {
                "401":"/site/pages/error-pages/401.html",
                "403":"/site/pages/error-pages/403.html",
                "404":"/site/pages/error-pages/404.html",
                "500":"/site/pages/error-pages/500.html"
             }
```

If such a specified error occurs due to an operation or page redirection inthe web application, it redirects to the specified html page. As an example, if you request for <https://localhost:9443/store/site/conf.site.json,> it gives a 403 response, it serves the html page site/pages/error-pages/403.html specified above.

![](attachments/103333490/103333493.png)
``` java
    <html>
        <head>
        </head>
    <body>
       <h2>Error 403 : Forbidden</h2>
       <br/>
       <p>
       <h4>You don't have permission to access anything with that kind of request.  </h4>
   </body>
</html>
```
These error pages are located in &lt;API-M\_HOME&gt;/repository/deployment/server/jaggeryapps/store/site/pages/error-pages directory. You can customize these html pages according to your preference (adding css, javasccript or jquery functionalities).  And also you can create your own html pages to be viewed for errors occured by adding it to the jaggery.conf.
