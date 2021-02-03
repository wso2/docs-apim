# Disabling Anonymous Access to the Developer Portal

By default, anonymous access to the Developer Portal is enabled. Therefore, users do not need to authenticate themselves by way of signing in when accessing the Developer Portal in WSO2 API Manager. However, if required, you can disable anonymous access to the Developer Portal to prevent anonymous users from accessing the Developer Portal. When anonymous access is disabled, users will not be allowed to access the Developer Portal UI without appropriate login details or an access token.

Follow the instructions below to disable anonymous access to the Developer Portal for a particular tenant:

1. Sign in to the WSO2 API-M Management Console as a tenant admin user.

    `https://<API-M_host>:<API-M_port>/carbon`

2. Navigate to **Main > Resources > Browse** 

3. Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to browse the registry and locate the required resource.

4. Add the field named `EnableAnonymous` with the value `false` to the `tenant-conf.json` as shown below.

    [![Disabling Developer Portal Anonymous Mode]({{base_path}}/assets/img/administer/disable-developer-portal-anonymous-mode.png)]({{base_path}}/assets/img/administer/disable-developer-portal-anonymous-mode.png)

5. Restart the server or wait for 15 mins until the registry cache expires.

6. Navigate to the Developer Portal.

     `https://<API-M_host>:<API-M_port>/devportal` 

     You will be automatically redirected to the Sign In page if you have not previously authenticated yourself by signing in to the Developer Portal.

    !!! info
        If you have a multi-tenant environment, when you navigate to `https://<API-M_host>:<API-M_port>/devportal`, it will ask you to select the tenant first. When you select a tenant, if the anonymous mode is disabled for that tenant (by following the above steps), you will be redirected to the Sign In page if you have not previously authenticated yourself by signing in to the Developer Portal.
