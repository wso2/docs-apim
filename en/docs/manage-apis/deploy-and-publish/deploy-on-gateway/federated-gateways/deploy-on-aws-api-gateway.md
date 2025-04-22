
# Deploy API on AWS API Gateway

From 4.5.0 release, WSO2 API Manager supports deploying APIs to AWS API Gateway. WSO2 API Manager is prepacked with an inbuilt gateway agent and with the use of the agent it is capable of deploying/undeploying APIs created with WSO2 API Manager to AWS API Gateway.

Follow the instructions given below to configure AWS API Gateway as a Federated API Gateway.

## Step 1: Configure User credentials AWS API Gateway

1. Create an IAM user in AWS with `AmazonAPIGatewayAdministrator` permission.
2. Obtain an Access Key and Secret Key for the IAM user created in the previous step. 

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

## Step 3 : Create API and Deploy to AWS API Gateway

1. Sign in to the Publisher Portal.

    `https://<hostname>:9443/admin`

    `https://localhost:9443/admin`

2. Create a new REST API and select Gateway Type as AWS. And provide a valid endpoint URL.

    [![select aws gateway]({{base_path}}/assets/img/deploy/select-aws-gateway.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/select-aws-gateway.png)

3. Design the API as required.

4. Configure the API with OAuth2.0 security.
    1. Navigate to the `Polcies` section and move to the API level policies tab.
    2. Attach the AWS OAuth2.0 policy to the API. Here you will have to provide an OAuth2.0 Lambda function ARN and a valid Invoke Role. OAuth2.0 lambda function should be implemented to validate the tokens from the IDP of your choice.
   
5. Navigate to `Deployments` and deploy the API to the AWS API Gateway configured in Step 2.

    !!!note
        Please note that only REST APIs are supported for deployment to AWS API Gateway.

## Step 4 : Configure Security for the API

AWS APIs are secured using AWS OAuth2 policy. The policy takes in a `Lambda ARN` and a `Lambda Invoke Role ARN` as parameters. These information will be used to configure the Lambda Authorizer at AWS Gateway. You can implement the Lambda function to validate the tokens from an IDP of your choice. Please follow the steps below to configure the security for the API.

??? note "Configuring Lambda Function and Invoke Role"
    1. Configure a Lambda function to validate the OAuth2 tokens issued by the IDP of your choice.    
    2. Configure a Custom Role with **lambda:InvokeFunction** permission to be used as the Invoke Role of the above Lambda. A sample permission JSON is shown below.
        ``` 
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": [
                        "lambda:InvokeFunction"
                    ],
                    "Resource": [
                        "*"
                    ]
                }
            ]
        }
        ```
    3. Also configure a trust relationship for the role to allow **sts:AssumeRole**.
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

1. Navigate to the `Policies` section and move to the API level policies tab.
2. Attach the AWS OAuth2.0 policy to the API. Here you will have to provide an OAuth2.0 Lambda function ARN and a valid Invoke Role.
    [![attach aws oauth policy]({{base_path}}/assets/img/deploy/attach-aws-oauth-policy.png){: style="width:70%"}]({{base_path}}/assets/img/deploy/attach-aws-oauth-policy.png)
3. Save and re-deploy the API.

!!!note
    If you do not specify an AWS OAuth2 policy when deploying the API, the API will be deployed without any security. AWS OAuth2 policy can be applied at either the API level or the resource level. If policies exist at both levels the resource level policy will take precedence.
