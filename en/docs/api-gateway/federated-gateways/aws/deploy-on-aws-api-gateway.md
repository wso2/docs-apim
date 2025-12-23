
# Deploy API on AWS API Gateway

From 4.5.0 release, WSO2 API Manager supports deploying APIs to AWS API Gateway. WSO2 API Manager is prepacked with an inbuilt AWS gateway connector and with the use of the connector it is capable of deploying/undeploying APIs created with WSO2 API Manager to AWS API Gateway.

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
    3. Save the configurations.

    [![add aws gateway environment]({{base_path}}/assets/img/deploy/add-aws-gw-environment.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/add-aws-gw-environment.png)

## Step 3 : Configure a third party Key Manager

!!!note
    This step needs to be followed only if you plan to enable security for the AWS API in Step 4.

1. Sign in to the Admin Portal.

    `https://<hostname>:9443/admin`

    `https://localhost:9443/admin`

2. Register a third party KM following instructions in WSO2 documentation. In this guide we will setup Auth0 as the KM following the guide [Configure Auth0 as a Key Manager]({{base_path}}/api-security/key-management/third-party-key-managers/configure-auth0-connector/).

## Step 4 : Create and Design API

1. Sign in to the Publisher Portal.

    `https://<hostname>:9443/publisher`

    `https://localhost:9443/publisher`

2. Create a new REST API and select Gateway Type as AWS. And provide a valid endpoint URL.

    [![select aws gateway]({{base_path}}/assets/img/deploy/select-aws-gateway.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/select-aws-gateway.png)

3. Design the API as required.

## Step 5 : Configure Lambda Function and Execution Role in AWS

AWS APIs are secured using AWS OAuth2 policy. The policy takes in a `Lambda ARN` and a `Lambda Invoke Role ARN` as parameters. These information will be used to configure the Lambda Authorizer at AWS Gateway. You can implement the Lambda function to validate the tokens from an IDP of your choice.

When the AWS API Gateway receives a request to a secured API, it will pass the request through the relevant Authorizer function before directing the request to the actual backend API.
Please follow the steps below to configure the security for the API.

!!!note
    Below steps would require additional permissions to be granted to the IAM user created in Step 1. Attach `AWSLambda_FullAccess` permission to the user and attach below custom policy to allow sts:AssumeRole action.
    ```
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Sid": "test",
            "Effect": "Allow",
            "Action": [
               "iam:GetRole",
               "iam:PassRole"
            ],
            "Resource": "*"
            }
        ]
    }
    ```

1. Configure a Lambda function in AWS to validate tokens generated from the IDP configured in step 3. You may refer to the sample lambda function implementation at [https://github.com/wso2/samples-apim/tree/master/custom-lambda-authorizer](https://github.com/wso2/samples-apim/tree/master/custom-lambda-authorizer).

2. In AWS IAM configure an execution role for the lambda function.

   i. Navigate to IAM > roles in AWS console and create a new role with below details.
   
   ```
   Trusted Entity Type : AWS Service
   Use Case : Lambda
   ```

   ii. Under Add Permissions stage attach `AWSLambdaRole` permission. Optionally attach `AWSLambdaBasicExecutionRole` if you wish to enable cloudwatch logs for the lambda function.

   iii. Provide a role name and edit the Trust Policy as below to allow API Gateway service as well.
   
   ```
   {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Principal": {
               "Service": [
                  "lambda.amazonaws.com",
                  "apigateway.amazonaws.com"
               ]
            },
            "Action": "sts:AssumeRole"
            }
        ]
   }
   ```

## Step 6 : Configure Security for the API

1. In WSO2 API Publisher portal, navigate to the `Policies` section of the API created in Step 4 and move to the API level policies tab.

2. Attach the AWS OAuth2.0 policy to the API. Here you will have to provide the ARN of the Lambda function and the execution role created above.

    [![attach aws oauth policy]({{base_path}}/assets/img/deploy/attach-aws-oauth-policy.png){: style="width:70%"}]({{base_path}}/assets/img/deploy/attach-aws-oauth-policy.png)

## Step 7 : Deploy and Publish API

1. Navigate to `Deployments` and deploy the API to the AWS API Gateway configured in Step 2.

2. Publish the API to developer portal.

## Step 8 : Invoke the API

1. Sign in to the Developer Portal.

   `https://<hostname>:9443/devportal`

   `https://localhost:9443/devportal`

2. Create an Application and obtain an access token from the KM you configured in step 3.

3. Navigate to tryout and invoke the API with above access token.

!!!note
    If you do not specify an AWS OAuth2 policy when deploying the API, the API will be deployed without any security. AWS OAuth2 policy can be applied at either the API level or the resource level. If policies exist at both levels the resource level policy will take precedence.

!!!note
    Please note that no subscriptions are required for the APIs deployed to AWS API Gateway.

!!!note
    Please note that only REST APIs are supported for deployment to AWS API Gateway.