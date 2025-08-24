# Discover API on AWS API Gateway

From 4.6.0 release, WSO2 API Manager supports federated API discovery for APIs deployed in AWS API Gateway. This enables APIs created and managed in AWS to be discovered and brought under the centralized control plane of WSO2 API Manager.

Once discovered, these APIs can fully leverage the control plane capabilities of WSO2 API Manager, including:

Governance enforcement – apply security, compliance, and lifecycle policies consistently.

Unified management – maintain a centralized view of all APIs, eliminating manual imports and fragmented operations.

Developer Portal Features – provide a unified catalog where developers can discover AWS-hosted APIs, explore documentation, test endpoints, subscribe to APIs, and access keys and tokens seamlessly.

By integrating AWS APIs into the control plane, organizations can ensure consistent standards, stronger governance, and improved visibility across their API ecosystem.

Follow the instructions given below to configure AWS API Gateway as a Federated API Gateway.

## Step 1: Configure User Credentials in AWS API Gateway

1. Login to your [AWS](https://console.aws.amazon.com/) account and navigate to Console Home. Search for “IAM” in the search bar.
2. Click on the IAM service. Navigate to **Users** under **Access Management**.
3. Create an IAM user in AWS with `AmazonAPIGatewayAdministrator` permission.
4. Obtain an Access Key and Secret Access Key for the IAM user created in the previous step. Select **Third-party service** as the use case.

   !!!note
   Note that it is not recommended to enter root credentials of the AWS account. Instead, create a new IAM user with the required permissions and use the credentials of the IAM user. For more information see [Best practices for managing AWS access keys](https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html).

## Step 2 : Register AWS API Gateway as a Federated Gateway in WSO2 API Manager

1. Start WSO2 API Manager.

2. Sign in to the Admin Portal.

   `https://<hostname>:9443/admin`

   `https://localhost:9443/admin`

3. Add a new Gateway Environment.
    1. Select the Gateway type as AWS and provide the relevant details in the fields accordingly.
    2. Enter the Access Key and Secret Key obtained in Step 1 under Gateway configurations.
    3. Select the Gateway mode as ReadOnly, or ReadWrite based on the requirement.
    4. Provide the Schedule time for the API discovery.
    5. Save the configurations.

   [![add aws gateway discovery environment]({{base_path}}/assets/img/deploy/add-aws-gw-environment.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/add-aws-gw-discovery.png)


## Step 3 : Deploy to Developer Portal

1. Sign in to Publisher Portal.
   `https://<hostname>:9443/publisher`

   `https://localhost:9443/publisher`

2. Go to APIs view and the APIs discovered from AWS API Gateway will be listed.
3. Click on the API to view the API details.
4. From the left menu, click **Lifecycle** and select **Publish** so that API will deploy to the Developer Portal.

## Step 4 : Invoke the API
1. Sign in to the Developer Portal.

   `https://<hostname>:9443/devportal`

   `https://localhost:9443/devportal`

2. Create an Application and obtain an access token from the KM you configured in step 3.

3. Navigate to tryout and invoke the API with above access token.
