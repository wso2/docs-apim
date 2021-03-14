# Configuring Kafka

In order to use the kafka inbound endpoint, you need to download and install [Apache Kafka](http://kafka.apache.org/downloads.html). The recommended version is `kafka_2.12-2.2.1`.

To configure the kafka inbound endpoint, copy the following client libraries from the `KAFKA_HOME/libs` directory to the `MI_HOME/lib` directory.
    
      - kafka_2.12-2.2.1.jar     
      - metrics-core-2.2.0.jar    
      - zkclient-0.11.jar
      - kafka-clients-2.2.1.jar  
      - scala-library-2.12.8.jar  
      - zookeeper-3.4.13.jar

To start the Kafka server:

-   Navigate to `<KAFKA_HOME>` and run the
    following command to start the ZooKeeper server:

    ```bash
    bin/zookeeper-server-start.sh config/zookeeper.properties
    ```

-   Run the following command to start the Kafka server

    ```bash
    bin/kafka-server-start.sh config/server.properties
    ```