# Create and Publish an AWS Lambda API

When using AWS Lambda, you can execute your code without having to manage or provision servers. For more information on AWS Lambda, see [What is AWS Lambda?](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html). WSO2 API Manager has integrated the support for invoking AWS Lambda functions through WSO2 API Gateway to get the benefits of AWS Lambda. Follow the steps below to create and publish an AWS Lambda API.

## Step 1 - Create a REST API

1. Sign in to the API Publisher Portal `https://<hostname>:9443/publisher`.

2. Click **CREATE API** and then click **Start From Scrach**.

    [![Create a new REST API]({{base_path}}/assets/img/learn/create-lambda-api.png)]({{base_path}}/assets/img/learn/create-lambda-api.png)

3. Enter the API details without an endpoint URL and click **Create**.  

    [![Create a test API]({{base_path}}/assets/img/learn/create-lambda-api-details.png)]({{base_path}}/assets/img/learn/create-lambda-api-details.png)

## Step 2 - Add AWS Lambda Endpoint

1. Click **Endpoints** to navigate to Endpoints page.
2. Navigate to the **AWS Lambda Endpoint** type and click **ADD**.

    [![Select AWS Lambda endpoint]({{base_path}}/assets/img/learn/endpoint-select-awslambda-endpoint.png)]({{base_path}}/assets/img/learn/endpoint-select-awslambda-endpoint.png)

3. Select the preferred **Access Method**

    AWS SDK needs AWS credentials and AWS region to invoke AWS Lambda functions. The access method defines how you provide those AWS credentials. There are two ways that you can select. 

    1. **Using IAM role-supplied temporary AWS credentials**

        If API Manager is running on an AWS EC2 or ECS instance, it is recommended to select this method. You need to attach an IAM role with both `AWSLambda_ReadOnlyAccess` and `AWSLambdaRole` permissions to the insatance so that it can grant permission to applications to list and invoke Lambda functions. For more information on attaching an IAM role to EC2, see [Using an IAM Role to Grant Permissions to Applications Running on Amazon EC2 Instances](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html).

    2. **Using stored AWS credentials**
    
        If API Manager is not running on an AWS instance, select this method. Note that it is not recommended to enter root credentials of the AWS account. Instead create a separate user account with both `AWSLambda_ReadOnlyAccess` and `AWSLambdaRole` permissions and enter credentials of that account. For more information see [Best practices for managing AWS access keys](https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html).
         

4. **[Optional]** Enable STS AssumeRole

    !!!note
        In both options above, Lambda function should belong to the **same AWS account**. You need to enable STS AssumeRole for cross-account Lambda function invocation.

    If your Lambda functions exists on different AWS account, you can use AWS STS AssumeRole feature. For more information see [AWS STS AssumeRole](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html). However, you should setup required policies in both accounts to assume a role.

    - For **Using IAM role-supplied temporary AWS credentials** method, IAM role with `AWS_AssumeRolePolicy` permission should be attached to the EC2 instance instead of a role with `AWSLambda_ReadOnlyAccess` and `AWSLambdaRole` permissions. 
    
    - Similarly for **Using stored AWS credentials** method, use credentials of a separate user account with `AWS_AssumeRolePolicy` instead of a user account with `AWSLambda_ReadOnlyAccess` and `AWSLambdaRole` permissions. Also, enter region of AWS STS endpoint for the **Region**. For more information see [Managing AWS STS in an AWS Region](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html).
    
    After that check `Enable STS AssumeRole` and enter required values to configure STS AssumeRole.

    <table>
        <thead>
            <tr class="header">
                <th>Field</th>
                <th>Value</th>
            </tr>
        </thead>
        <tbody>
            <tr class="odd">
                <td>Role ARN</td>
                <td>ARN of the role to be assumed</td>
            </tr>
            <tr class="even">
                <td>Role Session Name</td>
                <td>String value to uniquely identify the session</td>
            </tr>
            <tr class="odd">
                <td>Region </td>
                <td>Region of AWS Lambda functions</td>
            </tr>
        </tbody>
    </table>

5. Click **Save**.

    [![Save the AWS Lambda endpoint]({{base_path}}/assets/img/learn/endpoint-awslambda-save.png)]({{base_path}}/assets/img/learn/endpoint-awslambda-save.png)

    !!!note
         You will get an error message if you have not set the Access Method properly.

## Step 3 - Map Function ARNs to Resources

!!!note
    For more information on ARNs, see [Amazon Resource Names (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).

1. Click **Resources** to navigate to the Resources page.
2. Configure the resources.

     By default, the API will have five resources with `/*` as the URL pattern.

    1. Click delete, as shown below, to remove all the existing resources.

          [![Delete all existing resources]({{base_path}}/assets/img/learn/delete-all-existing-resources.png)]({{base_path}}/assets/img/learn/delete-all-existing-resources.png)

    2. Add a new resource.
          1. Select a HTTP Verb.
          2. Enter a meaningful name for URI Pattern (You can add path parameter as well).
          3. Click **(+)** to add a new resource.

          [![Add a new resource]({{base_path}}/assets/img/learn/resource-add-post-lambda.png)]({{base_path}}/assets/img/learn/resource-add-post-lambda.png)

3. Under AWS Lambda Settings, select or type Amazon Resource Name (ARN) for the resource.

    [![Select or type ARN]({{base_path}}/assets/img/learn/resource-add-amazon-resource-name.png)]({{base_path}}/assets/img/learn/resource-add-amazon-resource-name.png)

4. Optionally, change the AWS SDK Client Execution Timeout by changing the **Set Timeout** option.

     The default AWS SDK Client Execution Timeout is 50 seconds.

     - Min Timeout - 1 second
     - Max Timeout - 15 minutes

    [![Set Timeout]({{base_path}}/assets/img/learn/resource-set-amazon-resource-timeout.png)]({{base_path}}/assets/img/learn/resource-set-amazon-resource-timeout.png)

5. Click **SAVE**.

    [![Save resources]({{base_path}}/assets/img/learn/resource-save-lambda.png)]({{base_path}}/assets/img/learn/resource-save-lambda.png)

!!! note
    From version 4.1.0 onwards, WSO2 API Manager supports the [Lambda Proxy Integration](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html) concept by default. You can pass path parameters, query parameters, and headers along with the payload to the Lambda backend. These properties can be accessed via the `event` object parameter of the Lambda function. For example refer to following sample `event` object.

    ```
        {
            "headers":{
                "Host":"localhost:8243",
                "Origin":"https://localhost:9443",
                "Referer":"https://localhost:9443/",
            },
            "pathParameters":{
                "id":"7"
            },
            "queryStringParameters":{
                "lastName":"Doe",
                "firstName":"John"
            },
            "httpMethod":"POST",
            "path":"/user/{id}",
            "body":{
                "message":"Hello, World!"
            }
        }
    ```

## Step 4 - Deploy and Publish the AWS Lambda API

1. Go to **Deployments** page and click on **Deploy** button to deploy the API to Gateway.
2. Go to **Lifecycle** page and click on **PUBLISH** to publish the API to Developer Portal.

You have successfully published the AWS Lambda API. Try invoking the Lambda API in the Developer Portal.
