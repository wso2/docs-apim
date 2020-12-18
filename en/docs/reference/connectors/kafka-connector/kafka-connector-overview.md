# Kafka Connector Overview

Kafka is a distributed publish-subscribe messaging system that maintains feeds of messages in topics. Producers write data to topics and consumers read from topics. For more information on Apache Kafka, see [Apache Kafka documentation](http://kafka.apache.org/documentation.html).

Kafka mainly operates based on a topic model. A topic is a category or feed name to which records get published. Topics in Kafka are always multi-subscriber.

To see the Kafka Connector, navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for "kafka".

<img src="../../../../assets/img/connectors/kafka-store.png" title="Kafka Connector Store" width="200" alt="Kafka Connector Store"/>

## Compatibility

| Connector Version | Supported WSO2 EI version |
| ------------- |-------------|
| 2.0.9    | EI 7.1.0, EI 7.0.x EI 6.6.0 EI 6.5.0 |

For older versions, see the details in the connector store.

## Kafka Connector documentation

The Kafka connector allows you to access the Kafka Producer API through WSO2 EI and acts as a message producer that facilitates message publishing. The Kafka connector sends messages to the Kafka brokers. 

* **[Setting up Kafka](setting-up-kafka.md)**: This includes instructions on setting up Kafka and Zookeeper.

* **[Enabling Security for Kafka](enabling-security-for-kafka.md)**: This includes a variety of security-related details that will be used to secure Kafka.

* **[Kafka Connector Example](kafka-connector-producer-example.md)**: This example demonstrates how to send messages to a Kafka broker via Kafka topics. 

* **[Kafka Connector Reference](kafka-connector-config.md)**: This documentation provides a reference guide for the Kafka Connector.

## Kafka Inbound Endpoint documentation

WSO2 EI Kafka inbound endpoint acts as a message consumer. It creates a connection to ZooKeeper and requests messages for a topic. The inbound endpoint is bundled with the Kafka connector.

* **[Kafka Inbound Endpoint Example](kafka-inbound-endpoint-example.md)**: This sample demonstrates how one way message bridging from Kafka to HTTP can be done using the inbound Kafka endpoint. 

## How to contribute

As an open source project, WSO2 extensions welcome contributions from the community. 

To contribute to the code for this connector, create a pull request in one of the following repositories. 

* [Kafka Connector GitHub repository](https://github.com/wso2-extensions/esb-connector-kafka)
* [Kafka Inbound Endpoint GitHub repository](https://github.com/wso2-extensions/esb-inbound-kafka)

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.
