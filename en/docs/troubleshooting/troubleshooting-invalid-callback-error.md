#Troubleshooting 'Registered callback does not match with the provided url' error

The **Registered callback does not match with the provided url** error can be encountered during the API Publisher(`https://<hostname>:9443/publisher`) and API Dev portal(`https://<hostname>:9443/devportal`) login attempts, in a case where the hostname of the API Manager has been changed after accessing the Dev Portal or Publisher apps via different hostnames. 

For example, let's assume that you have started a fresh APIM server and accessed the API Publisher and Dev Portal apps via localhost. If you have [changed the hostname]({{base_path}}/install-and-setup/deploying-wso2-api-manager/changing-the-hostname/) of the server from `localhost` to `apim.wso2.com`, the next login attempt to API Publisher or Devportal will be failed giving this error.

<a href="{{base_path}}/assets/img/troubleshooting/invalid-callback-url-error.png" ><img src="{{base_path}}/assets/img/troubleshooting/invalid-callback-url-error.png" alt="Invalid callback url error" 
          title="Invalid callback url error" width="50%" /></a> 
          
This error has been occurred due to the mismatch of the API Publisher or API Dev portal access URLs((`https://<hostname>:9443/publisher` and `https://<hostname>:9443/devportal`)  and callback URLs which are configured in API Publisher and API Devportal Service Providers.
 
Please follow below steps to fix the login failure due to callback URL mismatch.

1.  Login to management console(`https://<hostname>:9443/carbon`).
2.  Navigate to service providers list.

    <a href="{{base_path}}/assets/img/troubleshooting/service-providers.png" ><img src="{{base_path}}/assets/img/troubleshooting/service-providers.png" alt="SP list" 
          title="SP list" width="20%" /></a> 

3.  Click on the **Edit** button of API Publisher service provider

    <a href="{{base_path}}/assets/img/troubleshooting/service-providers-list.png" ><img src="{{base_path}}/assets/img/troubleshooting/service-providers-list.png" alt="SP list" 
          title="SP list" width="60%" /></a> 

4.  Navigate to  **Inbound Authentication Configuration > OAuth/OpenID Connect Configuration** and click on OAuth application edit button.

    <a href="{{base_path}}/assets/img/troubleshooting/oauth-app-select.png" ><img src="{{base_path}}/assets/img/troubleshooting/oauth-app-select.png" alt="OAuth app edit" 
          title="OAuth app edit" width="60%" /></a>    
          
5.  See the **Callback Url** regex value configured under Application Settings. You will observe that the callback URL value is having a different hostname(`localhost` or previous hostname which was configured before the hostname change). 
    
    ```
    regexp=(https://localhost:9443/publisher/services/auth/callback/login|https://localhost:9443/publisher/services/auth/callback/logout)
    ``` 

    Then replace the callback URL hostname with the current hostname of the server. For example, if the current hostname of the server is `apim.wso2.com`, the callback URL regex has to be changes as follows.
    
    ```
    regexp=(https://apim.wso2.com:9443/publisher/services/auth/callback/login|https://apim.wso2.com:9443/publisher/services/auth/callback/logout)
    ```     

6.  Click on **Update** button in Applications Settings page, then the **Update** button of service provider information page to save the callback URL change.

7.  Select the service provider for API Dev portal(`admin_admin_store`) and repeat the step 4 - step 6 to apply the same changes.
