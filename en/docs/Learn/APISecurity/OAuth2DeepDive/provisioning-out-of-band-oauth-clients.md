# Provisioning Out-of-Band OAuth Clients

When an application access token is generated , an OAuth client is created underneath. The consumer key and consumer secret shown under a key type actually belongs to the OAuth client. There can be situations where an OAuth client is created elsewhere, but needs to be associated with an application in the API Store. For instance, in an organization where WSO2 Identity Server is used as the authoritative server, OAuth clients may only be created through the Identity Server. Similarly, when a third party OAuth provider is used, users might want to use previously created OAuth clients with the API Manager. To achieve this, you can provision the OAuth clients created outside the API Store into the WSO2 API Manager (WSO2 APIM), thereby associating the OAuth client with an application in the API Store. Once the mapping is done, you can use it in the same way as an OAuth client created through the API Store.


The steps below describe how to provision OAuth clients created outside the API Store into the WSO2 APIM.
In this example, we use a standalone API Manager instance and do this via the WSO2 APIM Management Console.

## Creating an external OAuth client

1.  Sign in to the WSO2 APIM Management Console (`https://<Server Host>:9443/carbon`) and click **Add** under **Service Providers** .

     <a href="../../../../../assets/img/Learn/add-service-provider-menu.png" ><img src="../../../../../assets/img/Learn/add-service-provider-menu.png" alt="Add Service Provider Menu" 
          title="Add Service Provider Menu" width="20%" /></a>

2.  Enter the name of the service provider and click **Register** .

     <a href="../../../../../assets/img/Learn/create-external-sp.png" ><img src="../../../../../assets/img/Learn/create-external-sp.png" alt="Add Service Provider" 
          title="Add Service Provider" width="60%" /></a>
             
3.  Click **Configure** under **Inbound Authentication Configuration &gt; OAuth/OpenId Connect Configuration** to add a new OAuth client.

     <a href="../../../../../assets/img/Learn/add-oauth-app.png" ><img src="../../../../../assets/img/Learn/add-oauth-app.png" alt="Add Oauth app" 
          title="Add Oauth app" width="60%" /></a>
          
4.  Provide a callback URL and click **Add** .
    If you do not have a callback URL, you can clear the **Code** and **Implicit** authorization grant types and add the OAuth client.
    
     <a href="../../../../../assets/img/Learn/register-oauth-app.png" ><img src="../../../../../assets/img/Learn/register-oauth-app.png" alt="Register Oauth app" 
          title="Register Oauth app" width="50%" /></a>  
    
    Now you have successfully created an OAuth client and generated consumer key secret pair for it.
   
     <a href="../../../../../assets/img/Learn/external-oauthapp-credentials.png" ><img src="../../../../../assets/img/Learn/external-oauthapp-credentials.png" alt="Oauth app credentials" 
          title="Oauth app credentials" width="50%" /></a> 
    
## Provisioning an out-of-band OAuth client in API Manager

1.  Open `<APIM_HOME>/repository/conf/deployment.toml` file and add following config under `apim.devportal` config to enable the option to provide out-of-band keys. 

    ``` java
        [apim.devportal]
        enable_key_provisioning=true
    ```

    !!! Note
        Note that the the ability to provision Out-of-Band Auth client will only be available for the applications that you created **after** applying this configuration.


2.  Restart the server

3.  Sign into the WSO2 API Dev Portal.
`https://<Server Host>:9443/devportal   
      `
4.  Create an application following the steps given in [Create Application]({{base_path}}/Learn/ConsumeAPI/ManageApplication/create-application).
    
5.  Click on the respective application to view the credential details.
    
     <a href="../../../../../assets/img/Learn/application-select.png" ><img src="../../../../../assets/img/Learn/application-select.png" alt="App listing" 
          title="App listing" width="50%" /></a>     
    
6.  Click on **Production Keys** section to provision an out-of-band OAuth client for production environment. Notice that you now see a Provide Keys section for your application. 

    !!! Note
        Out-of-band OAuth client can be provisioned either for production or sandbox environment. If you wish to generate keys for your sandbox, you can follow the same steps in **Sandbox Keys** tab.

     <a href="../../../../../assets/img/Learn/provide-keys-section.png" ><img src="../../../../../assets/img/Learn/provide-keys-section.png" alt="Provide Keys" 
          title="Provide Keys" width="50%" /></a>

7.  Paste the consumer key and consumer secret pair, which you received in Step 4 in [Create an external OAuth client](Learn/APISecurity/OAuth2DeepDive/provisioning-out-of-band-oauth-clients/#creating-an-external-oauth-client) , and click **Provide** button.

     <a href="../../../../../assets/img/Learn/update-keys.png" ><img src="../../../../../assets/img/Learn/update-keys.png" alt="update-keys" 
          title="update-keys" width="50%" /></a>

    Now you have successfully mapped an out-of-band OAuth client for the application. You can test this by subscribing to an API via this application, generating an access token for it and accessing the API. 

