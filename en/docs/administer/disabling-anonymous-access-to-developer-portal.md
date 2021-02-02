# Disabling Anonymous Access to Developer Portal

When accessing the Developer portal in WSO2 API Manager, the user is not needed to be authenticated (do not require to be logged in) by default. This is called the "Anonymous access to Developer Portal". But in some cases, you might need to prevent such behavior. You can achieve this by simply disabling the anonymous access to Developer Portal. When the anonymous access is disabled, anyone is not allowed to access the Developer Portal UI without proper login or an access token.

## Steps to Disable Anonymous Access to Developer Portal

This setting can be disabled tenant-wise by following the below steps for a particular tenant.

1. Sign in to the API-M management console (`https://<APIM_Host>:<APIM_Port>/carbon`) as a tenant admin user.

2. Navigate to **Main > Resources > Browse** 

3. Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to browse the registry and locate the required resource.

4. Add the field named `EnableAnonymous` with the value `false` to the `tenant-conf.json` as shown below.

    [![Disabling Developer Portal Anonymous Mode]({{base_path}}/assets/img/administer/disable-developer-portal-anonymous-mode.png)]({{base_path}}/assets/img/administer/disable-developer-portal-anonymous-mode.png)

5. Restart the server or wait for 15 mins until the registry cache expires.

6. Navigate to the Developer Portal (`https://<APIM_Host>:<APIM_Port>/devportal`). You will be automatically redirected to login screen if you are not previously authenticated.

    !!! info
        If you have a multi-tenant environment, when you navigate to `https://<APIM_Host>:<APIM_Port>/devportal`, it will ask you to select the tenant first. When you select a tenant, if the anonymous mode is disabled for that tenant (by following the above steps), you will be redirected to the login page if you are not previously authenticated.
