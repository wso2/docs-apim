# Change the Developer Portal Password

  You can change your own password for the WSO2 API Manager Developer Portal using the Developer Portal UI.  

Follow the instructions below to change your password: 

1. Sign in to the Developer Portal.    

     `https://<hostname>:9443/devportal`     

     Example: `https://localhost:9443/devportal`    

     Use your username and password to sign in.    

2. Click  on your username at the top right corner and select  **Change Password**.  

     [![Change Developer Portal password User Menu]({{base_path}}/assets/img/learn/change-devportal-password-user-menu-click.png)]({{base_path}}/assets/img/learn/change-devportal-password-user-menu-click.png)    

3. Enter your old password, a new password, re-enter the new password, and thereafter click **SAVE** to submit changes.

     [![Change Developer Portal password Save Clicking]({{base_path}}/assets/img/learn/change-devportal-password-policy-guideline-display.png)]({{base_path}}/assets/img/learn/change-devportal-password-policy-guideline-display.png)

## Display password policy guidelines

Alternatively, you can display a list of policy guidelines on the password changing UI.

[![Change DevPortal password User Menu Clicking]({{base_path}}/assets/img/learn/change-devportal-password-user-menu-click.png)]({{base_path}}/assets/img/learn/change-devportal-password-user-menu-click.png)

1. Enable Password changing guidelines in the `settings.js` file.
    1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/settings.js` file.
	
	2. Edit the configuration as follows:
		```
		const Settings = {
		...
			passwordChange: {
				guidelinesEnabled: true,
				...
			},
		};
		```

2. List your custom guidelines under `Settings.passwordChange.policyList`.

	```
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
