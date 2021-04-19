# Setting up the Amazon S3 Environment

To use the AmazonS3 service, you must have an AWS account. If you don't already have an account, you are prompted to create one when you sign up. You're not charged for any AWS services that you sign up for unless you use them.

## Signing Up for AWS

* **To sign up for AWS:**

    1. Navigate to [Amazon AWS website](https://aws.amazon.com/) and select **Create an AWS Account**.

        > **Note**: If you previously signed in to the AWS Management Console using AWS account root user credentials, select **Sign in to a different account**. If you previously signed in to the console using IAM credentials, choose Sign-in using root account credentials. Then select **Create a new AWS account**.

    2. Follow the online instructions.

Part of the sign-up procedure involves receiving a phone call and entering a verification code using the phone keypad. AWS will notify you by email when your account is active and available for you to use.

## Obtaining user credentials

You can access the Amazon S3 service using the root user credentials but these credentials allow full access to all resources in the account as you cannot restrict permission for root user credentials. If you want to restrict certain resources and allow controlled access to AWS services then you can create IAM (Identity and Access Management) users in your AWS account for that scenario.

## Steps to get an AWS Access Key for your AWS root account

  1. Go to the AWS Management Console.
     
     <img src="{{base_path}}/assets/img/integrate/connectors/aws-management-console.png" title="AWS Management Console" width="800" alt="AWS Management Console"/>
  
  2. Hover over your company name in the right top menu and click "My Security Credentials".

     <img src="{{base_path}}/assets/img/integrate/connectors/my-security-credentials.png" title="My security credentials" width="800" alt="My security credentials"/>
  
  3. Scroll to the "Access Keys" section.
  
     <img src="{{base_path}}/assets/img/integrate/connectors/create-accesskey-using-root-account.png" title="Create accesskey using root account" width="800" alt="Create accesskey using root account"/>
  
  4. Click on "Create New Access Key".
  5. Copy both the Access Key ID (YOUR_AMAZON_S3_KEY) and Secret Access Key (YOUR_AMAZON_S3_SECRET).

## Steps to get an AWS Access Key for an IAM user account

  1. Sign in to the AWS Management Console and open the IAM console.

     <img src="{{base_path}}/assets/img/integrate/connectors/iam.png" title="IAM" width="800" alt="IAM"/>
  
  2. In the navigation pane, choose Users.

     <img src="{{base_path}}/assets/img/integrate/connectors/iam-users.png" title="IAM users" width="200" alt="IAM users"/>
     
  3. Add a checkmark next to the name of the desired user, and then choose User Actions from the top.
  4. Click on Manage Access Keys.
  
     <img src="{{base_path}}/assets/img/integrate/connectors/security-credentials.png" title="Security credentials" width="800" alt="Security credentials"/>
  
  5. Click on Create Access Key.
        
     <img src="{{base_path}}/assets/img/integrate/connectors/create-access-key-using-iam.png" title="Create access key using IAM" width="800" alt="Create access key using IAM"/>
     
  6. Click on Show User Security Credentials. Copy and paste the Access Key ID and Secret Access Key values, or click on Download Credentials to download the credentials in a CSV (file).
     
     <img src="{{base_path}}/assets/img/integrate/connectors/download-access-key.png" title="Download access key" width="800" alt="Download access key"/>


The Access Key ID (e.g., AKIAJA3J6GE646JWVA9C) and Secret Access Key (e.g., H/P/G3Tey1fQOKPAU1GBbl/NhL/WpSaEvxbvUlp4) will be required to configure the Amazon S3 connector.  You can manage S3 buckets logging into S3 console.

## Deploying the client libraries

Finally download and place the following client libraries in to the <PRODUCT-HOME>/lib directory.

* [auth-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/auth/2.14.12)
* [aws-core-2.13.71.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/aws-core/2.13.71)
* [aws-query-protocol-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/aws-query-protocol/2.14.12)
* [aws-xml-protocol-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/aws-xml-protocol/2.14.12)
* [http-client-spi-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/http-client-spi/2.14.12)
* [metrics-spi-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/metrics-spi/2.14.12)
* [profiles-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/profiles/2.14.12)
* [protocol-core-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/protocol-core/2.14.12)
* [reactive-streams-1.0.0.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/reactive-streams/1.0.0)
* [regions-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/regions/2.14.12)
* [s3-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/s3/2.14.12)
* [sdk-core-2.14.12.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/sdk-core/2.14.12)
* [url-connection-client-2.1.2.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/url-connection-client/2.1.2)
* [utils-2.14.27.jar](https://mvnrepository.com/artifact/software.amazon.awssdk/utils/2.14.27)
