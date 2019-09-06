# Enabling or disabling self signup

In a multi-tenanted API Manager setup, self signup to the API Store is disabled by default to all tenants except the super tenant. A tenant admin can enable it as follows:

1.  Sign in to the management console ( `          https://<HostName>:9443/carbon         ` ) as admin (or tenant admin).
2.  In the **Main** menu, click **Add** under **Users and Roles** .

3.  Click **Add New Role** .
4.  Add a role by the name subscriber (or any other name you prefer).
5.  Click **Next** and add the following permissions:
6.  Go to the **Resources&gt; Browse** menu.
7.  Navigate to the `           /_system/governance/apimgt/applicationdata/          ` directory.

8.  Click on `           sign-up-config.xml          ` to load the resource in the registry browser UI and select the "Edit as text " option to edit the configurations.

9.  Do the following changes in the signup configuration and save.

    -   Set `            <EnableSignup>           ` to `            true.           `
    -   Set `            <RoleName>           ` to `            subscriber           ` and `            <IsExternalRole>           ` to `            true           ` . Note that you must have the subscriber role created at this point.
    -   Set `            <AdminUserName>           ` and `            <AdminPassword>           ` to the credentials of the super admin, or if you are in a **multitenant setup** and you are not the super admin, to the tenant admin's credentials. **Note** that the super admin's credentials are admin/admin by default. If you changed the default super admin's credentials, using admin/admin will cause errors.

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <tbody>
    <tr class="odd">
    <td><div class="container" title="Hint: double-click to select code">
    <div class="line number1 index0 alt2">
    <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   selfsignup                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number2 index1 alt1">

    </div>
    <div class="line number3 index2 alt2">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   enablesignup                  </code> <code class="xml plain">                   &gt;true&lt;/                  </code> <code class="xml keyword">                   enablesignup                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number4 index3 alt1">

    </div>
    <div class="line number5 index4 alt2">
    <code class="xml spaces">                  </code> <code class="xml comments">                   &lt;!-- user storage to store users --&gt;                  </code>
    </div>
    <div class="line number6 index5 alt1">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   signupdomain                  </code> <code class="xml plain">                   &gt;PRIMARY&lt;/                  </code> <code class="xml keyword">                   signupdomain                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number7 index6 alt2">

    </div>
    <div class="line number8 index7 alt1">
    <code class="xml spaces">                  </code> <code class="xml comments">                   &lt;!-- Tenant admin information. (for clustered setup credentials for AuthManager) --&gt;                  </code>
    </div>
    <div class="line number9 index8 alt2">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   adminusername                  </code> <code class="xml plain">                   &gt;xxxx&lt;/                  </code> <code class="xml keyword">                   adminusername                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number10 index9 alt1">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   adminpassword                  </code> <code class="xml plain">                   &gt;xxxx&lt;/                  </code> <code class="xml keyword">                   adminpassword                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number11 index10 alt2">

    </div>
    <div class="line number12 index11 alt1">
    <code class="xml spaces">                  </code> <code class="xml comments">                   &lt;!-- List of roles for the tenant user --&gt;                  </code>
    </div>
    <div class="line number13 index12 alt2">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   signuproles                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number14 index13 alt1">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   signuprole                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number15 index14 alt2">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   rolename                  </code> <code class="xml plain">                   &gt;subscriber&lt;/                  </code> <code class="xml keyword">                   rolename                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number16 index15 alt1">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   isexternalrole                  </code> <code class="xml plain">                   &gt;true&lt;/                  </code> <code class="xml keyword">                   isexternalrole                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number17 index16 alt2">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;/                  </code> <code class="xml keyword">                   signuprole                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number18 index17 alt1">
    <code class="xml spaces">                  </code> <code class="xml plain">                   &lt;/                  </code> <code class="xml keyword">                   signuproles                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    <div class="line number19 index18 alt2">

    </div>
    <div class="line number20 index19 alt1">
    <code class="xml plain">                   &lt;/                  </code> <code class="xml keyword">                   selfsignup                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    </div></td>
    </tr>
    </tbody>
    </table>

10. Restart the server and open the API Store ( `           https://<HostName>:9443/store          ` )
    Note the **Sign-up** link that appears in the top, right-hand corner of the window.

11. To disable the self signup capability, n avigate to the `          /_system/governance/apimgt/applicationdata/sign-up-config.xml         ` file in the registry again and set the `          <SelfSignUp><EnableSignup>         ` element to false.

!!! tip
Tip : To engage your own signup process, see Adding a User Signup Workflow .


