# Kafka Connector Overview

Kafka is a distributed publish-subscribe messaging system that maintains feeds of messages in topics. Producers write data to topics and consumers read from topics. For more information on Apache Kafka, see [Apache Kafka documentation](http://kafka.apache.org/documentation.html).

Kafka mainly operates based on a topic model. A topic is a category or feed name to which records get published. Topics in Kafka are always multi-subscriber.

To see the Kafka Connector, navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for "kafka".

<img src="{{base_path}}/assets/img/integrate/connectors/kafka-store.png" title="Kafka Connector Store" width="200" alt="Kafka Connector Store"/>

## Compatibility

| Connector Version | Supported product versions |
| ------------- |-------------|
| 2.0.9    | APIM 4.0.0, EI 7.1.0, EI 7.0.x EI 6.6.0 EI 6.5.0 |

For older versions, see the details in the connector store.

## Kafka Connector documentation

The Kafka connector allows you to access the Kafka Producer API from the integration sequence and acts as a message producer that facilitates message publishing. The Kafka connector sends messages to the Kafka brokers. 

* **[Setting up Kafka]({{base_path}}/reference/connectors/kafka-connector/setting-up-kafka/)**: This includes instructions on setting up Kafka and Zookeeper.

* **[Enabling Security for Kafka]({{base_path}}/reference/connectors/kafka-connector/enabling-security-for-kafka/)**: This includes a variety of security-related details that will be used to secure Kafka.

* **[Kafka Connector Example]({{base_path}}/reference/connectors/kafka-connector/kafka-connector-producer-example/)**: This example demonstrates how to send messages to a Kafka broker via Kafka topics. 

* **[Kafka Connector Reference]({{base_path}}/reference/connectors/kafka-connector/kafka-connector-config/)**: This documentation provides a reference guide for the Kafka Connector.

## Kafka Inbound Endpoint documentation

The Kafka inbound endpoint acts as a message consumer. It creates a connection to ZooKeeper and requests messages for a topic. The inbound endpoint is bundled with the Kafka connector.

* **[Kafka Inbound Endpoint Example]({{base_path}}/reference/connectors/kafka-connector/kafka-inbound-endpoint-example/)**: This sample demonstrates how one way message bridging from Kafka to HTTP can be done using the inbound Kafka endpoint. 

## How to contribute

As an open source project, WSO2 extensions welcome contributions from the community. 

To contribute to the code for this connector, create a pull request in one of the following repositories. 

* [Kafka Connector GitHub repository](https://github.com/wso2-extensions/esb-connector-kafka)
* [Kafka Inbound Endpoint GitHub repository](https://github.com/wso2-extensions/esb-inbound-kafka)

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.
