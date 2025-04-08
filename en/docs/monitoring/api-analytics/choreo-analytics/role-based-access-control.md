# Role-based Access Control for API Analytics

Enterprises and companies who want to use Choreo Insights collaboratively can utilize the organization concept in Choreo. An organization is a collection of users belonging to the same logical team. A user can be a part of multiple organizations. When a user first signs up to Choreo, an organization will be created by default with the user's name. Thereafter, that same user can act as the administrator for the group and invite other registered users to the organization. The groups in Choreo, namely **Admin** and **Developer**, allow you to carry out role-based access control.

## Inviting new users to access API Analytics

1. Sign in to <a href="https://console.choreo.dev/login/">Choreo console</a> using your credentials. 

     If you are not a registered user, you will have to sign up beforehand.

2. Click on the user profile in the top right corner of the screen and select **Settings**. 
   
     This will take you to the settings of your current organization.

3. Click on the **Organization** tab.

     The Organization page appears. This page contains information about your organization, such as the organization name, current members, pending members, and different groups within your organization.

     [![Organization Page]({{base_path}}/assets/img/observe/organization-page.png)]({{base_path}}/assets/img/observe/organization-page.png)

4. Click **Invite Members** and fill in the dialog box. 

     You can select either one of the following groups and then provide the invitee's registered email address.

     - **Admin** - If you invite another user as an admin to your organization, he/she can do administrative operations with regard to that group (such as inviting new users, etc.).

     - **Developer** -  If you invite a user as a developer to your organization, that user will only have read-only access to the organization. Such users will be able to see the list of members in that specific organization and also the available analytics information, which corresponds to that specific organization.
   
5. Click **Invite**.

     <a href="{{base_path}}/assets/img/observe/invite-dialogue-box.png"><img src="{{base_path}}/assets/img/observe/invite-dialogue-box.png" title="Invite dialog box" width="380"/></a>

     After the invitation is successfully submitted, the invitee will receive an email. After the invitee clicks on the activation link, he/she will be added to the respective organization.

## Viewing and modifying organization related settings

When you are a part of multiple organizations, you are allowed to modify/view settings related to each organization based on the privileges given to you by the group administrator. You will be able to modify the setting only if you are invited and added to the the **Admin** group.

1. Sign in to the Choreo console.
 
     Your current organization will be shown in the top left-hand side corner.

     [![Invite Page]({{base_path}}/assets/img/observe/organization-selector.png)]({{base_path}}/assets/img/observe/organization-selector.png)

2. If you are a part of multiple organizations, select an organization from the organization selector.

3. Click on the user profile in the top right corner of the screen and select **Settings**.

       This allows you to view the settings related to the currently selected organization.

4. Optionally, modify the organization settings as required and save the changes.
