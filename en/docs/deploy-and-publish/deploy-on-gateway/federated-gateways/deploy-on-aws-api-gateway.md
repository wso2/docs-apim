
# Deploy API on AWS API Gateway

From 4.5.0 release, WSO2 API Manager supports deploying APIs to AWS API Gateway. WSO2 API Manager is prepacked with an inbuilt gateway agent and with the use of the agent it is capable of deploying/undeploying APIs created with WSO2 API Manager to AWS API Gateway.

Follow the instructions given below to configure AWS API Gateway as a Federated API Gateway.

## Step 1: Configure User credentials AWS API Gateway

1. Create an IAM user in AWS and provide the necessary permissions to access the AWS API Gateway.
2. Obtain the Access Key and Secret Key of the IAM user created in the previous step.

## Step 2 : Register AWS API Gateway as a Federated Gateway in WSO2 API Manager

1. Start WSO2 API Manager.

   2. Sign in to the Admin Portal.

    `https://<hostname>:9443/admin`
   
    `https://localhost:9443/admin`

3. Add a new Gateway Environment.
    1. Select the Gateway type as AWS and provide the relevant details in the fields accordingly.
    2. Enter the Access Key and Secret Key obtained in Step 1 under Gateway configurations.
    3. Under virtual host section, provide the hostname of the AWS API Gateway as below.
         
           `{apiId}.execute-api.{region}.amazonaws.com`
   
    4. Save the configurations.

## Step 3 : Create API and Deploy to AWS API Gateway

1. Sign in to the Publisher Portal.

    `https://<hostname>:9443/admin`

    `https://localhost:9443/admin`

2. Create a new REST API and select Gateway Type as AWS. And provide a valid endpoint URL

3. Design the API as required.

4. Configure the API with OAuth2.0 security.
    1. Navigate to the `Polcies` section and move to the API level policies tab.
    2. Attach the AWS OAuth2.0 policy to the API. Here you will have to provide an OAuth2.0 Lambda function ARN and a valid Invoke Role. OAuth2.0 lambda function should be implemented to validate the tokens from the IDP of your choice.
   
5. Navigate to `Deployments` and deploy the API to the AWS API Gateway configured in Step 2.

