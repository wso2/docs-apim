# Provisioning Out-of-Band OAuth Clients

When an application access token is generated , an OAuth client is created underneath. The consumer key and consumer secret shown under a key type actually belongs to the OAuth client. There can be situations where an OAuth client is created elsewhere, but needs to be associated with an application in the API Store. For instance, in an organization where WSO2 Identity Server is used as the authoritative server, OAuth clients may only be created through the Identity Server. Similarly, when a third party OAuth provider is used, users might want to use previously created OAuth clients with the API Manager. To achieve this, you can provision the OAuth clients created outside the API Store into the WSO2 API Manager (WSO2 APIM), thereby associating the OAuth client with an application in the API Store. Once the mapping is done, you can use it in the same way as an OAuth client created through the API Store.


The steps below describe how to provision OAuth clients created outside the API Store into the WSO2 APIM:
In this example, we use a standalone API Manager instance and do this via the WSO2 APIM Management Console.


1.  Sign in to the WSO2 APIM Management Console ( `https://<Server Host>:9443/carbon` ) and click **Add** under **Service Providers** .
    ![](/assets/attachments/103334858/103334847.png)

2.  Enter the name of the service provider and click **Register** .
    ![](/assets/attachments/103334858/103334854.png)
3.  Click **Configure** under **Inbound Authentication Configuration &gt; OAuth/OpenId Connect Configuration** to add a new OAuth client.
    ![](/assets/attachments/103334858/103334857.png)
4.  Provide a callback URL and click **Add** .
    If you do not have a callback URL, you can clear the **Code** and **Implicit** authorization grant types and add the OAuth client.
    ![](/assets/attachments/103334858/103334848.png)
    You have now created the OAuth client and are provided with the OAuth client key and OAuth client secret.
    ![](/assets/attachments/103334858/103334846.png)
5.  Enable the option to provide out-of-band keys by opening the `<APIM_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/site.json` file and changing the `"mapExistingAuthApps"` setting to `true` .

    ``` java
        "mapExistingAuthApps" : true
    ```

        !!! note
    Note that the the ability to provision Out-of-Band Auth client will only be available for the applications that you created **after** doing this configuration.


6.  Sign into the WSO2 API Store.
`https://<Server Host>:9443/store         `
7.  Click **Applications** .
    ![](/assets/attachments/103334858/103334853.png)
8.  Click on the respective application to view the subscriptions details for the application.
    ![](/assets/attachments/103334858/103334845.png)
9.  Provision an out-of-band OAuth client for the required environment.

        !!! note
    The following steps explain how you can provision an out-of-band OAuth client for the production environment. If you wish to generate keys for your sandbox, you can follow the steps below using the **Sandbox Keys** tab.


    1.  Click **Production Keys** .
        Notice that you now see a **Provide Keys** button for your application.
        ![](/assets/attachments/103334858/103334844.png)
    2.  Click **Provide Keys** , paste the consumer key and consumer secret pair, which you received in [step 4](#ProvisioningOut-of-BandOAuthClients-step4) , and click **Save** .
        ![](/assets/attachments/103334858/103334843.png)

    You have successfully provisioned an out-of-band OAuth client.


