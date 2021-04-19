# Setting up the Amazon DynamoDB Connector 

Amazon DynamoDB Connector allows you to access the [Amazon DynamoDB REST API](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.API.html) from integration sequence. 

Amazon DynamoDB makes it simple and cost-effective to store and retrieve any amount of data, as well as serve any level of request traffic. It uses a NoSQL database model, which is non-relational, allowing documents, graphs, and columnar among its data models.

## Configuring message builders/formatters

Before you start configuring the  Amazon DynamoDB connector, you also need to configure the integration runtime, and we refer to that location as `<PRODUCT_HOME>`.

Specific message builders/formatters configuration needs to be enabled in the product as shown below before starting the integration service.

If you are using the Micro Integrator of **EI7** or **APIM 4.0.0**, you need to enable this property by adding the following to the **<PRODUCT_HOME>/conf/deployment.toml** file. You can further refer to the [Working with Message Builders and Formatters]({{base_path}}/reference/config-catalog/#http-transport) and [Product Configurations]({{base_path}}/install-and-setup/message_builders_formatters/message-builders-and-formatters/) documentations.

```toml
[[custom_message_formatters]]
class="org.apache.synapse.commons.json.JsonStreamFormatter"
content_type = "application/x-amz-json-1.0"

[[custom_message_builders]]
class="org.apache.synapse.commons.json.JsonStreamBuilder"
content_type = "application/x-amz-json-1.0"
```

If you are using **EI 6**, you can enable this property by doing the following Axis2 configurations in the **<PRODUCT_HOME>\repository\conf\axis2\axis2.xml** file.

**messageFormatters**

```xml
<messageFormatter contentType="application/x-amz-json-1.0"
class="org.apache.synapse.commons.json.JsonStreamFormatter"/>
```
**messageBuilders**

```xml
<messageBuilder contentType="application/x-amz-json-1.0"
class="org.apache.synapse.commons.json.JsonStreamBuilder"/>
```

> **Note**: If you want to perform blocking invocations, ensure that the above builder and formatter are added and enabled in the **<PRODUCT_HOME>\repository\conf\axis2\axis2_blocking_client.xml** file.

## Setting up the AWS Account and DynamoDB Environment

Please follow the steps mentioned in the [Setting up the Amazon Lambda Environment]({{base_path}}/reference/connectors/amazonlambda-connector/setting-up-amazonlambda/) document in order to create an Amazon account and obtain the access key id and secret access key.

Please find the following steps to navigate in to the Amazon DynamoDB using the AWS account.

1. Sign in to the AWS Management Console and search **Database** section under **Services**.

    <img src="{{base_path}}/assets/img/integrate/connectors/dynamodb-aws-console.png" title="Amazon Dynamodb aws console" width="600" alt="Amazon Dynamodb aws console"/> 

2. You can see the following operations and sub operations. The output in the AWS DynamoDB console are shown below.

    - Working with Items in Amazon DynamoDB
    - Working with Tables in Amazon DynamoDB

<img src="{{base_path}}/assets/img/integrate/connectors/dynamodb-aws-results-console.png" title="Amazon Dynamodb Table view" width="600" alt="Amazon Dynamodb Table view"/> 