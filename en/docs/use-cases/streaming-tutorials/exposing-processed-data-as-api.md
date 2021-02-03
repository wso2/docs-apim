# Siddhi Query API

## Introduction

Siddhi query API is the REST API exposed by the Streaming Integrator (SI). It gives you a set of APIs to perform all of the essential operations relating to Siddhi applications, including developing, testing, and querying them.

Siddhi query API provides APIs related to:
- Siddhi application management (such as creating, updating, deleting a Siddhi application; listing all running Siddhi applications etc.)
- Event simulation
- Authentication and permission management
- Health check
- Siddhi store operations

For a comprehensive reference on the Siddhi query API, see [Streaming Integration REST API Guide](https://ei.docs.wso2.com/en/next/streaming-integrator/ref/si-rest-api-guide/).

This tutorial demonstrates how you can use the Siddhi query API to perform essential operations in WSO2 Streaming Integrator using simple examples.

## Preparing the server

!!!tip "Before you begin:"
    - You need to have access to a MySQL instance.<br/>
    - Save the MySQL JDBC driver in the `<SI_HOME>/lib` directory as follows:<br/>
      1. Download the MySQL JDBC driver from [the MySQL site](https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz).<br/>
      2. Unzip the archive.<br/>
      3. Copy the `mysql-connector-java-5.1.45-bin.jar` to the `<SI_HOME>/lib` directory.<br/>
      4. Start the SI server.<br/>

1. Let's create a new database in the MySQL server which you are to use throughout this tutorial. To do this, execute the following query.
    ```
    CREATE SCHEMA production;
    ```

2. Create a new user by executing the following SQL query.
    ```
    GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'wso2si' IDENTIFIED BY 'wso2';
    ```

3. Switch to the `production` database and create a new table, by executing the following queries:
    ```
    use production;
    ```

    ```
    CREATE TABLE SweetProductionTable (name VARCHAR(20),amount double(10,2));
    ```

## Creating a Siddhi application

1. Open a text file and copy-paste following application to it.

    ```
    @App:name("SweetProduction-Store")

    @App:description('Receive events via HTTP and persist the received data in the store.')

    @Source(type = 'http', receiver.url='http://localhost:8006/productionStream', basic.auth.enabled='false',
        @map(type='json'))
    define stream insertSweetProductionStream (name string, amount double);

    @Store(type="rdbms",
           jdbc.url="jdbc:mysql://localhost:3306/production?useSSL=false",
           username="wso2si",
           password="wso2" ,
           jdbc.driver.name="com.mysql.jdbc.Driver")
    define table SweetProductionTable (name string, amount double);

    from insertSweetProductionStream
    update or insert into SweetProductionTable
    on SweetProductionTable.name == name;
    ```

    Here the `jdbc.url` parameter has the value `jdbc:mysql://localhost:3306/production?useSSL=false`. Change it to point to your MySQL server. Similarly change `username` and `password` parameters as well.

2. Save this file as `SweetProduction-Store.siddhi` in a location of your choice in the local file system.

3. Now you need to execute a `CURL` command and deploy this Siddhi application. In the command line, navigate to the location where you saved the Siddhi application in the previous step, and execute following command:
    ```
    curl -X POST "https://localhost:9443/siddhi-apps" -H "accept: application/json" -H "Content-Type: text/plain" -d @SweetProduction-Store.siddhi -u admin:admin -k
    ```

  Upon successful deployment, the following response is logged for the `CURL` command you just executed.
    ```
    {"type":"success","message":"Siddhi App saved succesfully and will be deployed in next deployment cycle"}
    ```

  In addition to that, the following is logged in the SI console.
    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App SweetProduction-Store deployed successfully
    ```

    !!!info
        Next, you are going to send a few events to `insertSweetProductionStream` stream via a `CURL` command.

6. Execute following `CURL` command in the console:
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Almond cookie\",\"amount\": 100.0}}"  http://localhost:8006/productionStream --header "Content-Type:application/json"
    ```

    !!!info
        You have written the Siddhi application to insert a new record from the `insertSweetProductionStream` stream into the `SweetProductionTable` table, or to update the record if it already exists in the table. As a result, above event is now inserted into the `SweetProductionTable`.

7. To verify whether above event is inserted into `SweetProductionTable`, execute following `SQL` query in the SQL console:
    ```
    SELECT * FROM SweetProductionTable;
    ```

    The following table appears to indicate that the record has been inserted into the table.
    ```
    +---------------+--------+
    | name          | amount |
    +---------------+--------+
    | Almond cookie | 100.00 |
    +---------------+--------+
    ```

## Running a Siddhi Store API query

You can use `Siddhi Store Query API` to execute queries on Siddhi Store tables.

In this section shows you how to execute a simple store query via the REST API in order to fetch all records from the `SweetProductionTable` Siddhi Store table. To learn about other types of queries, see [Streaming Integrator REST API Guide](https://ei.docs.wso2.com/en/next/streaming-integrator/ref/si-rest-api-guide/).

Execute following `CURL` command on the console:
```
curl -k -X POST http://localhost:7070/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "from SweetProductionTable select *" }'
```

The following output is logged in the console:
```
{"records":[["Almond cookie",100.0]]}
```

## Fetching the status of a Siddhi Application

Now let's fetch the status of the Siddhi application you just deployed.

Execute following `CURL` command, in the console:
```
curl -X GET "http://localhost:9090/siddhi-apps/SweetProduction-Store/status" -H "accept: application/json" -u admin:admin -k
```

The following output appears in the command line:
```
{"status":"active"}
```

## Taking a snapshot of a Siddhi Application

In this section, deploy a stateful Siddhi application and use the REST API to take a snapshot of it. To do this, follow the procedure below:

1. To enable the state persistence feature in SI server, open the `<SI_HOME>/conf/server/deployment.yaml` file in a text editor and locate the `state.persistence` section, and then update it as follows.

    ```
      # Periodic Persistence Configuration
    state.persistence:
      enabled: true
      intervalInMin: 5
      revisionsToKeep: 2
      persistenceStore: org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore
      config:
        location: siddhi-app-persistence
    ```

    As shown above, set `enabled` parameter to `true` and set the `intervalInMin` to `5`. Then save the file.

2. Restart the Streaming Integrator server for the above change to be effective.

3. Open a text file and copy-paste following application into it.
    ```
    @App:name("CountProductions")

    @App:description("Siddhi application to count the total number of orders.")

    @Source(type = 'http', receiver.url='http://localhost:8007/productionStream', basic.auth.enabled='false',
        @map(type='json'))
    define stream SweetProductionStream (name string, amount double);

    @sink(type = 'log')
    define stream LogStream (totalProductions double);

    @info(name = 'query')
    from SweetProductionStream
    select sum(amount) as totalProductions
    insert into LogStream;
    ```

4. Save this file as `CountProductions.siddhi` in a location of your choice in the local file system.

5. Now execute a `CURL` command and deploy this Siddhi application. To do this, use the command line to navigate to the location where you saved the Siddhi application in above step, and then execute following command.
    ```
    curl -X POST "https://localhost:9443/siddhi-apps" -H "accept: application/json" -H "Content-Type: text/plain" -d @CountProductions.siddhi -u admin:admin -k
    ```

   Upon successful deployment, the following response is logged for the `CURL` command you just executed.
    ```
    {"type":"success","message":"Siddhi App saved succesfully and will be deployed in next deployment cycle"}
    ```

   In addition to that, the following log appears in the SI console.
    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App CountProductions deployed successfully.
    ```

8. Now let's send  two sweet production events using `CURL` by issuing tghe following two `CURL` commands via the command line:
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Almond cookie\",\"amount\": 100.0}}"  http://localhost:8007/productionStream --header "Content-Type:application/json"
    ```
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Baked alaska\",\"amount\": 20.0}}"  http://localhost:8007/productionStream --header "Content-Type:application/json"
    ```

9. As a result, the following logs appears on the SI console:
    ```
    INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1566288572024, data=[100.0], isExpired=false}
    INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1566288596336, data=[120.0], isExpired=false}
    ```
    Note that the current productions count is `120`.

10. Now you can invoke the Siddhi Query API to take a snapshot of the Siddhi application. To do this, execute following `CURL` command on the command line:
    ```
    curl -X POST "https://localhost:9443/siddhi-apps/CountProductions/backup" -H "accept: application/json" -u admin:admin -k
    ```

    An output similar to the following is logged.
    ```
    {"revision":"1566293390654__CountProductions"}
    ```

    !!!info
        `1566293390654__CountProductions` is the revision number of the Siddhi application snapshot that you requested via the REST API. You can store this revision number and later use it in order to restore the Siddhi application to the state at which you took the snapshot.

## Restoring a Siddhi Application via a snapshot

In the previous section, you took a snapshot of the `CountProductions` Siddhi application when the productions count was `120`. In this section, you can increase the count further by sending a few more production events, and then restore the Siddhi application to the state you backed up. To do this, follow the procedure below

1. Send following two sweet production events:
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Cup cake\",\"amount\": 300.0}}"  http://localhost:8007/productionStream --header "Content-Type:application/json"
    ```
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Doughnut\",\"amount\": 500.0}}"  http://localhost:8007/productionStream --header "Content-Type:application/json"
    ```

   As a result, the following two lines of log appear in the SI console:
    ```
    INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1566288572024, data=[420.0], isExpired=false}
    INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1566288596336, data=[920.0], isExpired=false}
    ```
   Note that the current productions count is `920`.

3. Now you can invoke the Siddhi Query API to restore the snapshot that you obtained in step 10 of the [Taking a snapshot of a Siddhi Application](#Taking-a-snapshot-of-a-Siddhi-Application) section of this tutorial.

    In this example, the revision number obtained is `1566293390654__CountProductions` (see step 10 in [Taking a snapshot of a Siddhi Application](#Taking-a-snapshot-of-a-Siddhi-Application) section.). When restoring the state, use the exact revision number that you obtained.

    Execute following command on the command line:
    ```
    curl -X POST "https://localhost:9443/siddhi-apps/CountProductions/restore?revision=1566293390654__CountProductions" -H "accept: application/json" -u admin:admin -k
    ```
    !!! note
        Replace `1566293390654__CountProductions` with the revision number that you obtained when taking the Siddhi application snapshot.

    The response you receive is as follows:
    ```
    {"type":"success","message":"State restored to revision 1566293390654__CountProductions for Siddhi App :CountProductions"}
    ```

    In addition to that, the following log is printed in the SI console:
    ```
    INFO {org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore} - State loaded for CountProductions revision 1566293390654__CountProductions from the file system.
    ```

4.  Now send another sweet production event by executing the following `CURL` command:
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Danish pastry\",\"amount\": 100.0}}"  http://localhost:8007/productionStream --header "Content-Type:application/json"
    ```

   As a result, the following log appears in the SI console:
    ```
    INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1566293520176, data=[220.0], isExpired=false}
    ```
    Note that the productions count is `220`. This is because the count was reset to `120` when you restored the snapshot.
