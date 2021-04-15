# Register for Analytics

API Manager 4.0.0 offers analytics as a cloud service. Hence users need to register with analytics cloud in order to
 use API Manager Analytics
 
## Prerequisites
You need to be a registered Choreo user in order to utilize Analytics cloud. If you are an enterprise user please
 talk to your organization administrated. He/She can invite you into organization's Choreo account as a new user.
 If you are an freelance user trying out the product, please signup to Choreo by visiting https://console.choreo.dev
 
## Register On-premise Environment
Please follow below steps to register your on-premise environment.

- Please log in to Choreo console(https://console.choreo.dev) using your credentials.
- Click on the user profile in the top right corner of the screen and select 'Settings'
- Choose 'On-prem Keys' tab and click on generate keys
- Provide a suitable name for your environment(Ex: customer1-dev) and click on 'Generate' button
- You will be provided with a key in the next step and please copy that key before closing the dialogue box
- Now you can use this key to configure Gateway to publish stats into Analytics cloud. Please follow [this
 document]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-synapse-gateway) if you are using
  Synapse Gateway and follow 
  [this document]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-microgateway) 
  if you are using Choreo Connect Gateway.