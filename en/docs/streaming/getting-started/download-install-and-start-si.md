# Step 1: Download Streaming Integrator and Dependencies

First, you are required to download the Streaming Integrator and the other software needed for the scenario you are trying out. To do this, follow the topics below.

!!! tip "Before you begin:"
    - Install [Oracle Java SE Development Kit (JDK) version 1.8](https://www.oracle.com/technetwork/java/javase/downloads/index.html).<br/>
    - [Set the Java home](https://docs.oracle.com/cd/E19182-01/820-7851/inst_cli_jdk_javahome_t/) environment variable.<br/>
    
## Downloading the Streaming Integrator runtime and tooling

- To download the Streaming Integrator runtime, visit the [Streaming Integrator Product Page](https://wso2.com/integration/streaming-integrator/). Enter you email address and agree to the license. Then click **Zip Archive** download the Streaming Integrator as a zip file.

- To download Streaming Integrator Tooling, click **Tooling** in the [Streaming Integrator Product Page](https://wso2.com/integration/streaming-integrator/). Enter you email address and agree to the license. Then click **MacOS Installer pkg** download the Streaming Integrator as a zip file.

## Downloading the other dependencies for your scenario

This section shows how to prepare your production environment for the scenario described in the [Streaming Integration Overview section]({{base_path}}/streaming/getting-started/getting-started-guide-overview).

## Setting up a MySQL database table

In this scenario, the Streaming Integrator reads input data from a MySQL database table. Therefore, let's download and install MySQL and define the database and the database table as follows:

1. Download MySQL 5.1.49 from [MySQL Community Downloads](https://dev.mysql.com/downloads/connector/j/5.1.html).

2. Enable binary logging in the MySQL server. For detailed instructions, see [Debezium documentation - Enabling the binlog](https://debezium.io/docs/connectors/mysql/#enabling-the-binlog).  

    !!!note
        If you are using MySQL 8.0, use the following query to check the binlog status:
        ```
        SELECT variable_value as "BINARY LOGGING STATUS (log-bin) ::"
        FROM performance_schema.global_variables WHERE variable_name='log_bin';
        ```
    
3. Once you install MySQL and start the MySQL server, create the database and the database table you require as follows:

    1. Let's create a new database in the MySQL server which you are to use throughout this tutorial. To do this, execute the following query.
        ```
        CREATE SCHEMA production;
        ```
       
    2. Create a new user by executing the following SQL query.<br/>
        ```
        GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'wso2si' IDENTIFIED BY 'wso2';
        ```<br/>
    3. Switch to the `production` database and create a new table, by executing the following queries:<br/>
        `use production;`<br/>
        `CREATE TABLE SweetProductionTable (name VARCHAR(20),amount double(10,2));`<br/> 
               

## Download Kafka and create topics

This scenario involves publishing some filtered production data to a Kafka topic named `eclair_production`. 

1. Download the Kafka broker from [the Apache site](https://www.apache.org/dyn/closer.cgi?path=/kafka/2.3.0/kafka_2.12-2.3.0.tgz) and extract it.
   This directory is referred to as `<KAFKA_HOME>` from here on.
   
2. Start Kafka as follows:

    1. First, start a zoo keeper node. To do this, navigate to the `<KAFKA_HOME>` directory and issue the following command.
    
        `sh bin/zookeeper-server-start.sh config/zookeeper.properties`
    
    2. Next, start a Kafka server node. To do this, issue the following command from the same directory.
    
        `sh bin/kafka-server-start.sh config/server.properties`
        
    3. To create a Kafka topic named `eclair-production`, issue the following command from the same directory.
    
        `bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic eclair-production`
        
        
## Starting the WSO2 Streaming Integrator Server

To start WSO2 Streaming Integrator, navigate to the `<SI_HOME>/bin` directory from the CLI, and issue the appropriate command based on your operating system:

- **For Linux**: `./server.sh`
- **For Windows**: `server.bat --run`           
              
Now you have completed a WSO2 Streaming Integrator setup that is capable of the following:

- Design, test and deploy Siddhi applications via Streaming Integrator Tooling.

- Consume data from as well as publish data to MySQL databases.

- Consume data from as well as publish data to Kafka topics.


!!! tip "What's Next?"
    To design a Siddhi application, proceed to [Step 2: Create the Siddhi Application]({{base_path}}/streaming/getting-started/create-the-siddhi-application).

