# Change Password for the Developer Portal

Follow the instructions below to change your own password for the Developer Portal:

1. Sign in to the Developer Portal.

     `https://<hostname>:9443/devportal`

     Example: `https://localhost:9443/devportal`

     Use your username and password to sign in
  
2. Click on your username that appears at the top right corner and select **Change Password**.
  
     <img src="{{base_path}}/assets/img/learn/change-devportal-password-user-menu-click.png" alt="Change Developer Portal password User Menu" width="250px"/>
  
3. Enter your current password, a new password, re-enter the new password, and thereafter click **SAVE** to submit the changes. 

     The new password should adhere to the custom password policies as described below.

     <img src="{{base_path}}/assets/img/learn/change-devportal-password-submiting.png" alt="Developer portal password change submit" width="600"/>

!!! note

    To disable Change Password for the Developer Portal, add below configuration to `<APIM_HOME>/repository/conf/deployment.toml` file.
    Add this before all the other `[apim.**]` tags in the deployment.toml file.
    
  ```
  [apim]
  enable_change_password = false
  ```