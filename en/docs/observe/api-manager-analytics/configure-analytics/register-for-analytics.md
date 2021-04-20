# Register for Analytics

API Manager 4.0.0 offers analytics as a cloud service. Hence, users need to register with analytics cloud in order to
 use API Manager Analytics
 
## Prerequisites
You need to be a registered Choreo user in order to utilize Analytics Cloud.
 If you are a standalone user trying out the product, please signup to Choreo by visiting 
 [https://console.choreo.dev](https://console.choreo.dev). If you are a group of people who need to share the
  Analytics Cloud please follow [this]({{base_path}}/observe/api-manager-analytics/configure-analytics/working-with-organizations) 
  document to signup and create a group which is formally referred as an
   organization.
 
## Register On-premise Environment
Please follow below steps to register your on-premise environment.

- Please log on to [Choreo console](https://console.choreo.dev) using your credentials.
- Click on the user profile in the top right corner of the screen and select **Settings**.
- If you are a member of multiple organizations select the appropriate organization from top left-hand corner. For
 more information on handling organizations please visit [here]({{base_path}}/observe/api-manager-analytics/configure-analytics/working-with-organizations)
- Choose the **On-prem Keys** tab and click on **Generate keys**.
- Provide a suitable name for your environment (e.g., customer1-dev) and click the **Generate** button
- You will be provided with a key in the next step. Copy that key before closing the dialog box.
- Now you can use this key to configure the Gateway to publish stats into the Analytics cloud. Follow [this
 document]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-synapse-gateway) if you are using
  Synapse Gateway and follow 
  [this document]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-microgateway) 
  if you are using Choreo Connect Gateway.
