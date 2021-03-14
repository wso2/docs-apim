# Amazon S3 Connector Overview

Amazon S3 is a web-based storage service that can be used to store and retrieve data at anytime from anywhere on the web. Amazon uses the same service to run its own network that proves its scalability, reliability, and security.

The Amazon S3 Connector versions 1.0.10 and below allow you to access the REST API of [Amazon Storage Service S3](https://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html). This lets you store your information and retrieve it back when needed. WSO2 EI AmazonS3 Connector is useful to take your on-premise data to the cloud. The advantage is, you do not need to worry about managing and replicating data on-premise.

The versions 2.0.0 and above allow you to access the AWS component via AWS [SDK](https://aws.amazon.com/sdk-for-java/). The SDK makes it easy to call AWS services using idiomatic Java APIs.

To see the Amazon S3 connector, navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for "Amazon".

<img src="{{base_path}}/assets/img/integrate/connectors/amazon-s3-store.png" title="Amazon S3 Connector Store" width="200" alt="Amazon S3 Connector Store"/>

## Compatibility

| Connector Version | Supported WSO2 EI version | Supported API |
| ------------- |-------------|-------------|
| 2.0.0    | EI 7.0.x, EI 6.6.0 | AWS SDK |
| 1.0.10    | EI 7.1.0, EI 7.0.x, EI 6.6.0, EI 6.5.0 | REST |

For older versions, see the details in the connector store.

## Amazon S3 Connector documentation (latest - 2.x version)

* **[Amazon S3 Connector Example]({{base_path}}/reference/connectors/amazons3-connector/amazons3-connector-example/)**: This example demonstrates how to use Amazon S3 Connector to create an S3 bucket, upload a text message into the bucket, retrieve it back, and convert it into a message in WSO2 EI integration. 

* **[Amazon S3 Connector Reference]({{base_path}}/reference/connectors/amazons3-connector/amazons3-connector-reference/)**: This documentation provides a reference guide for the Amazon S3 Connector.

## How to contribute

As an open source project, WSO2 extensions welcome contributions from the community. 

To contribute to the code for this connector, create a pull request in the following repository. 

* [Amazon S3 Connector GitHub repository](https://github.com/wso2-extensions/esb-connector-amazons3)

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.
