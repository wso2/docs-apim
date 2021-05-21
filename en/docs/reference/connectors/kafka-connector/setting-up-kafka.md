# Setting up Kafka

To use the Kafka connector, download and install [Apache Kafka](http://kafka.apache.org/downloads.html). Before you start configuring the Kafka you also need the integration runtime and we refer to that location as <PRODUCT_HOME>.

> **Note**: The recommended version is [Kafka_2.11-2.2.1](https://www.apache.org/dyn/closer.cgi?path=/kafka/1.0.0/kafka_2.11-2.2.1.tgz). For all available versions of Kafka that you can download, see https://kafka.apache.org/downloads. The recommended Java version is 1.8.

To configure the Kafka connector, copy the following client libraries from the `<KAFKA_HOME>/lib` directory to the `<MI_HOME>/lib` directory.

* [kafka_2.11-2.2.1.jar](https://mvnrepository.com/artifact/org.apache.kafka/kafka_2.11/2.2.1)  
* [kafka-clients-1.0.0.jar](https://mvnrepository.com/artifact/org.apache.kafka/kafka-clients/1.0.0)
* [metrics-core-2.2.0.jar](https://mvnrepository.com/artifact/com.yammer.metrics/metrics-core/2.2.0)
* [scala-library-2.12.3.jar](https://mvnrepository.com/artifact/org.scala-lang/scala-library/2.12.3)
* [zkclient-0.10.jar](https://mvnrepository.com/artifact/com.101tec/zkclient/0.10)
* [zookeeper-3.4.10.jar](https://mvnrepository.com/artifact/org.apache.zookeeper/zookeeper/3.4.10)

Copy the following additional client libraries to the `<MI_HOME>/lib` directory (can be copied from the Confluent platform):

* [avro-1.8.1.jar](https://mvnrepository.com/artifact/org.apache.avro/avro/1.8.1)
* [common-config-5.4.0.jar](https://mvnrepository.com/artifact/io.confluent/common-config/5.4.0)
* [common-utils-5.4.0.jar](https://mvnrepository.com/artifact/io.confluent/common-utils/5.4.0)
* [kafka-avro-serializer-5.3.0.jar](https://mvnrepository.com/artifact/io.confluent/kafka-avro-serializer/5.3.0)
* [kafka-schema-registry-client-5.3.0.jar](https://mvnrepository.com/artifact/io.confluent/kafka-schema-registry-client/5.3.0)

Navigate to <KAFKA_HOME> and run the following command to start the ZooKeeper server:

```bash
bin/zookeeper-server-start.sh config/zookeeper.properties
```

From the <KAFKA_HOME> directory, run the following command to start the Kafka server:

```bash
bin/kafka-server-start.sh config/server.properties
```

Now that you have connected to Kafka, you can start publishing and consuming messages using the Kafka brokers. For more information, see [Publishing Messages using Kafka]({{base_path}}/reference/connectors/kafka-connector/kafka-connector-producer-example/) and [Consuming Messages using Kafka]({{base_path}}/reference/connectors/kafka-connector/kafka-inbound-endpoint-example/).
