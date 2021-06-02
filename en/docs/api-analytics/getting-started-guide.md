# Getting Started

API Manager offers analytics as a cloud service. Therefore, you need to register with the analytics cloud in order to use API Manager Analytics. Follow the instructions below to get started with analytics:

## Step 1 - Sign up with Choreo

Follow the instructions below to sign up with Choreo.

1. Navigate to Choreo using the following URL. 
    
     [https://console.choreo.dev](https://console.choreo.dev).

2. Sign-up to Choreo.

!!! info
    Note that the approval for your sign-up request may not take place immediately. Check your email for the invitation email, as Choreo sends out new invites every day.

## Step 2 - Register your environment

Follow the instructions below to register your on-premise environment:

1. Sign in to the [Choreo Console](https://console.choreo.dev) using your credentials.

2. Click on the user profile in the top right corner of the screen and select **Settings**.

     [![Settings Menu]({{base_path}}/assets/img/observe/settings-menu.png)]({{base_path}}/assets/img/observe/settings-menu.png)

3. If you are a member of multiple organizations, select the appropriate organization from the top left-hand corner. 
   
     For more information on handling users with role-based access control in organizations, see [Role-based Access Control for API Analytics]({{base_path}}/api-analytics/role-based-access-control).

     [![Org Selector]({{base_path}}/assets/img/observe/organization-selector.png)]({{base_path}}/assets/img/observe/organization-selector.png)

4. Select the **On-prem Keys** tab and click **Generate keys**.

     [![On-prem Key]({{base_path}}/assets/img/observe/on-prem-key.png)]({{base_path}}/assets/img/observe/on-prem-key.png)

5. Enter a suitable name for your environment (e.g., customer1-dev).

6. Click **Generate**.
   
      <div class="admonition info">
      <p class="admonition-title">Info</p>
      <p>The validity period of the key and the number of keys that you are allowed to generate vary based on the type of user as explained below:</p>
      <table>
      <tr>
      <th><b>User Type</b></th>
      <th><b>Descrption</b></th>
      <th><b>Validity Period</b></th>
      <th><b>Number of Keys Allowed</b></th>
      </tr>
      <tr>
      <td> Free user</td>
      <td> Refers to users who do not have a valid subscription for Choreo.</td>
      <td> 2 weeks</br>
      <p><b>NOTE:</b> The validity of the keys can be temporarily extended by <a href="https://wso2.com/contact/">contacting sales</a> and submitting a request.</p></td>
      <td> 3 keys</td>
      </tr>
      <tr>
      <td> Subscription customers</td>
      <td> Refers to users who have a valid subscription for Choreo.</td>
      <td> 1 year</td>
      <td> unlimited</td>
      </tr>
      </table>
      </div>

7. Copy the key that was generated before closing the dialog box.

## Step 3 - Configure the Gateway

The Gateway configuration process varies based on the Gateway that you are using.

### API Gateway

{!includes/analytics/configure-synapse-gateway.md!}

## Step 4 - View the Analytics Dashboards

Invoke APIs and sign in to the Analytics Portal to view the dashboards. For more detailed information on the Analytics Portal dashboards and their usage, see the [Analytics Portal Overview]({{base_path}}/api-analytics/viewing/analytics-pages-overview).

## What's Next?

Enterprises and companies who want to use the Analytics Portal collaboratively can utilize the organization concept in Choreo. For more information, see [Role-based Access Control for API Analytics]({{base_path}}/api-analytics/role-based-access-control).
