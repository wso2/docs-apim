# Customize Developer Portal Credential Preferences
  
You can change your WSO2 API Manager Developer Portal password, customize the default Developer Portal password policy, and enable or disable the Developer Portal password policy guidelines based on your requirement.

## Change the Developer Portal password

Follow the instructions below to change your password:

1. Sign in to the Developer Portal.

     `https://<hostname>:9443/devportal`

     Example: `https://localhost:9443/devportal`

     Use your username and password to sign in
  
2. Click on your username that appears at the top right corner and select **Change Password**.
  
     <img src="{{base_path}}/assets/img/learn/change-devportal-password-user-menu-click.png" alt="Change Developer Portal password User Menu" width="300px"/>
  
3. Enter your current password, a new password, re-enter the new password, and thereafter click **SAVE** to submit the changes. 

     The new password should adhere to the custom password policies as described below.

     <img src="{{base_path}}/assets/img/learn/change-devportal-password-submiting.png" alt="Developer portal password change submit" width="700"/>
  
## Customize Developer Portal password policy

You can define your custom password policy by defining one or both of the followings
    
- [User store password RegEx](https://apim.docs.wso2.com/en/latest/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store/#configuring-a-jdbc-user-store)  

     Example:

     ```toml
     [user_store]
     type = "database_unique_id"

     [user_store.properties]
     PasswordJavaRegEx = "^[\\S]{6,30}$"
     ```

- [Identity management password policies](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/security/identity-management-for-the-api-dev-portal/#password-policies)
     <html>    
     <div class="admonition note">    
     <p class="admonition-title">Note</p>    
     <p>
     <ul><li><p>
     The password policy set by the identity management password policies via the configuration file can be overridden using the Management Console for each tenant.
     </p></li>
     <li>
     <p>
     When changing the password, the new password will be validated against the user store password RegEx and conditions enforced by the Identity Management password policy. Therefore, you will not be able to change your password, if these conditions/RegEx patterns are set in a way that they conflict with each other.
     </p>
     </li>
     </ul></p>
     </div>
     </html>

## Display password policy guidelines
  
Alternatively, you can display a list of policy guidelines in the password changing UI.  
  
<img src="{{base_path}}/assets/img/learn/change-devportal-password-policy-guideline-display.png" alt="Displaying Developer Portal password policy guidelines" width="700"/>
  
1. Enable password changing guidelines in the `settings.js` file.  

     1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/settings.js` file.  
     
     2. Edit the configuration as follows:  
   
        ```javascript
         const Settings = {
            ...
            passwordChange: {
                guidelinesEnabled: true,
                ...
            },
         };
        ```

2. List your custom guidelines under `Settings.passwordChange.policyList`.

    ```javascript
     const Settings = {
        ...
        passwordChange: {
            guidelinesEnabled: true,
            policyList: [
                'Policy 1',
                'Policy 2',
                'Policy 3',
            ],
        },
     };
    ```

    <html>
    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>If the guideline list is empty, the change password UI will not show the Password Policy guidelines section.</p>
    </div>
    </html>
