# Amazon SQS Connector Overview

Amazon Simple Queue Service (SQS) is a fully managed message queuing service that allows you to run business applications and services so that the messaging is not dependent on the IT infrastructure itself. This means the messages can run and fail independently of each other in a way that does not cause slowdowns, system-wide faults, or a disturbance within the application. By using Amazon SQS, you can move data between distributed components of your applications that perform different tasks without losing messages or requiring each component to be always available.

To see the Amazon SQS connector, navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for "Amazon".

<img src="{{base_path}}/assets/img/integrate/connectors/amazon-sqs-store.png" title="Amazon SQS Connector Store" width="200" alt="Amazon SQS Connector Store"/>

## Compatibility

| Connector Version | Supported WSO2 EI version |
| ------------- |-------------|
| 1.0.10    | EI 7.1.0, EI 7.0.x, EI 6.6.0, EI 6.5.0 |

For older versions, see the details in the connector store.

## Amazon SQS Connector documentation

The WSO2 Amazon SQS connector allows you to access the exposed API through the WSO2 EI. Through this connector, you can perform CRUD operations for queues in Amazon SQS instance, update permissions and can work with messages. For further reference please refer to [Amazon SQS API reference](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/Welcome.html).

* **[Amazon SQS Connector Example]({{base_path}}/reference/connectors/amazonsqs-connector/amazonsqs-connector-example/)**: This example explains how to use Amazon SQS Connector to create a queue in the Amazon SQS, send a message to the queue, forward it to a backend service and send the response to the user. 

* **[Amazon SQS Connector Reference]({{base_path}}/reference/connectors/amazonsqs-connector/amazonsqs-connector-config/)**: This documentation provides a reference guide for the Amazon SQS Connector.

## Amazon SQS Inbound Endpoint

The AmazonSQS Inbound Endpoint allows you to connect to Amazon and consume messages form an Amazon SQS queue. The messages are then injected into a WSO2 EI mediation engine for further processing and mediation.

* **[Amazon SQS Inbound Endpoint Example]({{base_path}}/reference/connectors/amazonsqs-connector/amazonsqs-inbound-endpoint-example/)**: This example demonstrates how the AmazonSQS inbound endpoint works as a message consumer. 

* **[Amazon SQS Inbound Endpoint Reference]({{base_path}}/reference/connectors/amazonsqs-connector/amazonsqs-inbound-endpoint-reference-configuration/)**: This documentation provides a reference guide for the Amazon SQS Inbound Endpoint.

## How to contribute

As an open source project, WSO2 extensions welcome contributions from the community. 

To contribute to the code for this connector, create a pull request in the following repository. 

* [Amazon SQS Connector GitHub repository](https://github.com/wso2-extensions/esb-inbound-amazonsqs)

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.
