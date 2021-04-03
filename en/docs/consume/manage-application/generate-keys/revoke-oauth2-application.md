# Revoke OAuth2 Application

1.  An OAuth client is created when an application [access token is generated]({{base_path}}/consume/manage-application/generate-keys/obtain-access-token/overview-of-access-tokens). When a subscriber creates an application and generates an access token to the application using the Developer Portal, the Developer Portal makes a call to the API Gateway, which in turn connects with the Key Manager to create an OAuth client and obtain an access token. Similarly, to validate a token, the API Gateway calls the Key Manager, which fetches and validates the token details from the database.

    You can revoke the access tokens issued for the application by following the instructions below

    1.  Sign in to the management console (`https://<HostName>:9443/carbon`)

    2.  In the **Main** menu, click **Service Providers → List**.

         ![]({{base_path}}/assets/attachments/103333704/103333705.png)    
        
    3.  Select the **Service Provider** and click **Edit**.
        
         ![]({{base_path}}/assets/attachments/103333704/103333707.png)
        
        !!! info
            Only a user with the relevant permission to manage Service Providers will be able to view/edit the existing Service Providers. A user with only subscribe permission is not able to view or edit the Service Providers. The Admin user by default has permission only to view and edit Service Providers of Applications created by the same user. However, its possible for the Admin user to assign the relevant permission for a particular Service Provider, to itself by navigating to **Users and Roles → List → Roles**, and then view/edit the Service Provider.


    4.  Expand the **Inbound Authentication Configurations** section and select **OAuth/OpenID Configuration
        
        ![]({{base_path}}/assets/attachments/103333704/103333708.png)    

    5.  You can revoke/deactivate the OAuth application by clicking **Revoke**. This will revoke all the tokens given for the application.
        
        ![]({{base_path}}/assets/attachments/103333704/103333709.png)
        
        !!! info
            After an OAuth application is revoked, the consumer secret and all the generated access tokens and authorization codes will be invalid. You will not be able to regenerate access tokens in the Developer Portal or using the Token API.

        !!! note
            To re-activate the application, the consumer secret must be regenerated as shown in the next step


    6.  To regenerate the secret of the OAuth Application, click **Regenerate Secret**.
        
        ![]({{base_path}}/assets/attachments/103333704/103333710.png)
        
        !!! info
            You have to generate new access tokens and authorization codes for the OAuth application through the Developer Portal or using the Token API after regenerating the consumer secret.
