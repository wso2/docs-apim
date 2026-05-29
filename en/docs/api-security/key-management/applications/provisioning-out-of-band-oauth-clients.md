# Provisioning Out-of-Band OAuth2 Clients

When application keys are generated, an OAuth2 client is created underneath. The consumer key and consumer secret that appears under a key type belong to the OAuth2 client. There can be situations where an OAuth2 client is created elsewhere but needs to be associated with an application in the Developer Portal. These types of OAuth2 clients are referred to as **Out-of-Band OAuth2 Clients**. 

For instance, in an organization where WSO2 Identity Server (WSO2 IS) is used as the authoritative server, OAuth2 clients may only be created through the Identity Server. Similarly, when you use a third-party OAuth2 provider, you may also want to use the previously created OAuth2 clients with WSO2 API Manager. In such a scenario, you need to provision the OAuth2 clients that you created outside the Developer Portal into WSO2 API Manager (WSO2 API-M) by associating the OAuth2 client with an application in the Developer Portal. After the mapping is completed, the third-party OAuth2 client will work in a similar manner to an OAuth2 client that was created via the Developer Portal.


Follow the instructions below to provision an OAuth2 client that was created outside the Developer Portal into the WSO2 API-M.

In this example, let's use WSO2 IS configured as a third-party Key Manager. An OAuth2 client will be created in its Management Console and will be provisioned into WSO2 API-M by associating it with an application in the Developer Portal.

## Step 1 - Configure a third-party key manager

Follow the steps in [Configure WSO2 IS as a Key Manager]({{base_path}}/api-security/key-management/third-party-key-managers/configure-wso2is7-connector.md) to setup WSO2 IS as a third-party key manager

!!! note
     You can use any Key Manager mentioned under [Third-Party Key Manager Integration]({{base_path}}/api-security/key-management/third-party-key-managers/overview/) and configure it as a third-party key manager.

Under the **Advanced Configurations** section, enable **Out Of Band Provisioning**.

[![Out Of Band Provisioning]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/out-of-band-provisioning.png)]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/out-of-band-provisioning.png)

!!! Note
          If **Out Of Band Provisioning** is not enabled in the third-party key manager configuration, you can set a global default by adding the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file under the `[apim.devportal]` section. This global setting only takes effect when **Out Of Band Provisioning** is disabled in the third-party key manager configuration.

          ``` toml
          [apim.devportal]
          enable_key_provisioning = true
          ```

In this example, it will be assumed that WSO2 IS and WSO2 API-M are up and running in `https://<Server Host>:9444` and `https://<Server Host>:9443` respectively.

## Step 2 - Create an external OAuth2 client

1.  Sign in to the WSO2 IS Console (`https://<Server Host>:9444/console`).

2.  Create a **Traditional Application**.

     [![Create Traditional Application]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/create-traditional-application.png)]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/create-traditional-application.png)

3.  In the service provider, go to the **Protocol** tab and select the desired grant types.

     [![Select Grant Types]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/select-grant-types.png)]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/select-grant-types.png)

4.  In the same tab, set the **Token Type** as `JWT` and click **Update**.

     [![Set Token Type JWT]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/set-token-type-jwt.png)]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/set-token-type-jwt.png)

5.  Copy the **Client ID** and **Client Secret**.

## Step 3 - Provision the out-of-band OAuth2 client

Follow the instructions below to provision the out-of-band OAuth2 client that you created in the previous step in WSO2 API Manager.

1.  [Start the server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server).

2.  Sign in to the Developer Portal.

      `https://<Server Host>:9443/devportal`

3.  Create an application. 
     
     For more information, see [Create Application]({{base_path}}/api-developer-portal/manage-application/create-application).
    
4.  Click on the respective application to view the credential details.
    
     [![App listing]({{base_path}}/assets/img/learn/application-listing.png)]({{base_path}}/assets/img/learn/application-listing.png)   
    
5.  Click **OAuth2 Tokens** under **Production Keys** tab and navigate to the respective key manager tab (here it is `IS`).

      The **PROVIDE EXISTING OAUTH KEYS** button appears under the **Production OAuth2 Keys** section.

    !!! Note
        Out-of-band OAuth2 client can be provisioned either for production or sandbox environment. If you wish to generate keys for your sandbox, you can follow the same instructions in the **Sandbox Keys** tab.

     [![Provide Keys]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/provide-keys-section.png)]({{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/provide-keys-section.png)

6.  Paste the consumer key and consumer secret pair, which you derived in [Step 2 - (5) Creating an external OAuth client](#step5).

     <a href="{{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/update-keys.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/provisioning-out-of-band-oauth-clients/update-keys.png" alt="update-keys" title="update-keys" width="80%" /></a>

    !!! Note
        - The ability to provision Out-of-Band Auth client will only be available for the applications that you created **after** applying this configuration.
        - If you want to disable the validation of the provisioned applications, add the following config under the `apim.key_manager` configuration to `<API-M_HOME>/repository/conf/deployment.toml` file.
        ``` toml
        [apim.key_manager]
        enable_provisioned_app_validation = false
        ```

7. Click **Provide**.

Now you have successfully mapped an out-of-band OAuth client to an application. 

## Step 4 - Invoke an API

1. [Subscribe to an API]({{base_path}}/api-developer-portal/manage-subscription/subscribe-to-an-api) via this application.

2. Obtain an access token for it.
   
    You cannot obtain an access token from the Developer Portal for the provisioned applications. You need to use the command line (cURL). For more information, see [Obtain Access Token]({{base_path}}/api-developer-portal/manage-application/generate-keys/obtain-access-token/overview-of-access-tokens).

3. [Invoke the API]({{base_path}}/api-developer-portal/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console).
