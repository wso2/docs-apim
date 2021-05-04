# Working with Organizations

Enterprises and companies who want to use the Analytics Portal collaboratively can utilize the organization
concept in Choreo. In essence, the organization is a collection of users belonging to the same logical team. A given user
can be a part of multiple organizations. When a user first signs up for Choreo, an organization will be created by
default with user's name. Then that same user, acting as the administrator for the group can invite other
registered users. This documentation will outline features required by analytics users and if you need further
information please use the given referenced links for Choreo documentation.

## Invite Users into Your Organization

- Log into [Choreo console](https://console.choreo.dev/login/) using your credentials. If you are not a registered user you will have to signup
  beforehand.
- Click on the user profile in the top right corner of the screen and select **Settings**. This will take you to
  settings of your current organization.
- Choose the **Organization** tab

  ![Organization Page]({{base_path}}/assets/img/observe/organization-page.png)

- This page contains information about your organization such as organization name, current members, pending members
  and different groups within your organization. Groups allow you to do role based access control. By default there
  will be two groups namely Admin and Developer. When you invite another user as an admin to your organization he/she
  can do administrative operations of that group such as inviting new users, etc. Developer only allows you read
  -only access to the organization where you can see the organization members and analytics information available
  under that organization
- Click on **Invite Members** and fill in the dialog box. You can select an appropriate group as explained above and
  then provide the registered email address of the user you want to invite. Once all details are added, click **Invite**.

 <img src="{{base_path}}/assets/img/observe/invite-dialogue-box.png" title="Invite dialog box" width="380"/>

- This process will send an email to the user and once he/she clicks the activation link, he/she will be added to the
  respective organization.
- Once all required users are added, continue to follow this [documentation]({{base_path}}/observe/api-manager-analytics/configure-analytics/register-for-analytics)  
  to complete registration.

## Modifying/Viewing Settings of Invited Organizations

When you are part of multiple organizations, you are allowed to modify/view settings related to each organization based on the privileges given to you by the group administrator. To modify the settings, you should be invited and added
to the **Admin** group once they send you the invitation.

Once you log into Choreo console, your current organization will be shown in the top left-hand side corner.

![Invite Page]({{base_path}}/assets/img/observe/organization-selector.png)

When you visit the settings page, it will reflect settings related to the organization that is currently selected in
the organization selector. Using this selector you can modify/view settings of multiple organizations.
