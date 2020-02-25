# Provisioning Out-of-Band OAuth2 Clients

When an application access token is generated, an OAuth2 client is created underneath. The consumer key and consumer secret shown under a key type actually belongs to the OAuth2 client. There can be situations where an OAuth2 client is created elsewhere, but needs to be associated with an application in the API Store. This type of OAuth2 clients are called as **Out-of-Band OAuth2 Clients**. 

For instance, in an organization where WSO2 Identity Server is used as the authoritative server, OAuth2 clients may only be created through the Identity Server. Similarly, when a 
third party OAuth2 provider is used, users might want to use previously created OAuth2 clients with the API Manager. To achieve this, you can provision the OAuth2 clients created outside the API Store into the WSO2 API Manager (WSO2 APIM), thereby associating it with an application in the API Store. Once the mapping is done, you can use it in the same way as an OAuth2 client created through the API Store.


The steps below describe how to provision OAuth2 clients created outside the API Store into the WSO2 APIM.
In this example, we use a standalone API Manager instance and do this via the WSO2 APIM Management Console.

## Creating an external OAuth2 client

1.  Sign in to the WSO2 APIM Management Console (`https://<Server Host>:9443/carbon`) and click **Add** under **Service Providers** .

     <a href="../../../../assets/img/learn/add-service-provider-menu.png" ><img src="../../../../assets/img/learn/add-service-provider-menu.png" alt="Add Service Provider Menu" 
          title="Add Service Provider Menu" width="20%" /></a>

2.  Enter the name of the service provider and click **Register** .

     <a href="../../../../assets/img/learn/create-external-sp.png" ><img src="../../../../assets/img/learn/create-external-sp.png" alt="Add Service Provider" 
          title="Add Service Provider" width="60%" /></a>
             
3.  Click **Configure** under **Inbound Authentication Configuration &gt; OAuth/OpenId Connect Configuration** to add a new OAuth2 client.

     <a href="../../../../assets/img/learn/add-oauth-app.png" ><img src="../../../../assets/img/learn/add-oauth-app.png" alt="Add Oauth app" 
          title="Add Oauth app" width="60%" /></a>
          
4.  Provide a callback URL and click **Add** .
    If you do not have a callback URL, you can clear the **Code** and **Implicit** authorization grant types and add the OAuth2 client.
    
     <a href="../../../../assets/img/learn/register-oauth-app.png" ><img src="../../../../assets/img/learn/register-oauth-app.png" alt="Register Oauth app" 
          title="Register Oauth app" width="50%" /></a>  
    
    Now you have successfully created an OAuth2 client and generated a consumer key and consumer secret for it. 
   
     <a href="../../../../assets/img/learn/external-oauthapp-credentials.png" ><img src="../../../../assets/img/learn/external-oauthapp-credentials.png" alt="Oauth app credentials" 
          title="Oauth app credentials" width="50%" /></a> 
    
## Provisioning an out-of-band OAuth2 client in API Manager

1.  Stop the API Manager server if it is already running.

2.  Open `<APIM_HOME>/repository/conf/deployment.toml` file and add following config under `apim.devportal` config to enable the option to provide out-of-band keys. 

    ``` java
        [apim.devportal]
        enable_key_provisioning=true
    ```

    !!! Note
        Note that the the ability to provision Out-of-Band Auth client will only be available for the applications that you created **after** applying this configuration.


3.  [Start the server]({{base_path}}/install-and-setup/installation-guide/running-the-product/#starting-the-server).

4.  Sign into the WSO2 API Dev Portal.
`https://<Server Host>:9443/devportal   
      `
5.  Create an application by following the steps given in [Create Application]({{base_path}}/learn/consume-api/manage-application/create-application).
    
6.  Click on the respective application to view the credential details.
    
     <a href="../../../../assets/img/learn/application-select.png" ><img src="../../../../assets/img/learn/application-select.png" alt="App listing" 
          title="App listing" width="50%" /></a>     
    
7.  Click on **Production Keys** section to provision an out-of-band OAuth2 client for production environment. You should now see a ** Provide Existing OAuth Keys ** section below the Production Key and Secret section.

    !!! Note
        Out-of-band OAuth2 client can be provisioned either for production or sandbox environment. If you wish to generate keys for your sandbox, you can follow the same steps in **Sandbox Keys** tab.

     <a href="../../../../assets/img/learn/provide-keys-section.png" ><img src="../../../../assets/img/learn/provide-keys-section.png" alt="Provide Keys" 
          title="Provide Keys" width="50%" /></a>

8.  Paste the consumer key and consumer secret pair, which you received in Step 4 in [Creating an external OAuth client](#creating-an-external-oauth-client) , and click **Provide** button.

     <a href="../../../../assets/img/learn/update-keys.png" ><img src="../../../../assets/img/learn/update-keys.png" alt="update-keys" 
          title="update-keys" width="50%" /></a>

    Now you have successfully mapped an out-of-band OAuth client for the application. Then you can [subscribing to an API]({{base_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api/) via this application, [obtain an access token]({{base_path}}/learn/consume-api/manage-application/generate-keys/obtain-access-token/overview-of-access-tokens/) for it and [invoke the API]({{base_path}}/learn/consume-api/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/).

