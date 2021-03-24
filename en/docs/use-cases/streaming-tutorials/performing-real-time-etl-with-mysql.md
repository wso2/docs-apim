# Performing Real-time Change Data Capture with MySQL

## Introduction

The Streaming Integrator (SI) allows you to capture changes to a database table, in a streaming manner, enabling you to perform ETL operations.

This tutorial takes you through the different modes and  options you could use to perform Change Data Capturing (CDC) using the SI. In this tutorial, you are using a MySQL datasource.

!!!info
    To use a different database other than MySQL, see [dependencies for CDC](https://github.com/siddhi-io/siddhi-io-cdc#dependencies) and add the corresponding driver jar. In addition to that, modify the JDBC URL accordingly, in `url` parameter in all Siddhi applications given in this tutorial.

**Listening mode and Polling mode**

There are two modes in which you could perform CDC using the SI: **Listening mode** and **Polling mode**.

- Polling mode: In the polling mode, the data source is periodically polled for capturing the changes. The polling period can be configured.

- Listening mode: In listening mode, the SI keeps listening to the Change Log of the database and notifies if a change takes place. Here, unlike the polling mode, you are notified about the change immediately.

**Type of events captured**

You can capture following type of changes done to a database table:

- Insert operations

- Update operations

- Delete operations (available for Listening mode only)

## Listening mode

!!!info "Before you begin:"
    - You need to have access to a MySQL instance.<br/>
    - Enable binary logging in the MySQL server. For detailed instructions, see [Debezium documentation - Enabling the binlog](https://debezium.io/docs/connectors/mysql/#enabling-the-binlog).<br/>
        !!! info
            If you are using MySQL 8.0, use the following query to check the binlog status.<br/>
            ```
            SELECT variable_value as "BINARY LOGGING STATUS (log-bin) ::"
            FROM performance_schema.global_variables WHERE variable_name='log_bin';
            ```<br/>
    - Add the MySQL JDBC driver into the `<SI_HOME>/lib` directoryas follows:<br/>
        1. Download the MySQL JDBC driver from [the MySQL site](https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz).<br/>
        2. Unzip the archive.<br/>
        3. Copy the `mysql-connector-java-5.1.45-bin.jar` to the `<SI_HOME>/lib` directory.<br/>
        4. Start the SI server.<br/>
    - Once you install MySQL and start the MySQL server, create the database and the database table you require as follows:
        1. Let's create a new database in the MySQL server which you are to use throughout this tutorial. To do this, execute the following query.<br/>
            ```
            CREATE SCHEMA production;
            ```<br/>
        2. Create a new user by executing the following SQL query.<br/>
            ```
            GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'wso2si' IDENTIFIED BY 'wso2';
            ```<br/>
        3. Switch to the `production` database and create a new table, by executing the following queries:<br/>
            `use production;`<br/>
            `CREATE TABLE SweetProductionTable (name VARCHAR(20),amount double(10,2));`<br/>            
    - Download and install the [siddhi-io-cdc](https://siddhi-io.github.io/siddhi-io-cdc/) extension. For instructions, see [Downloading and Installing Siddhi Connectors]({{base_path}}/streaming/connectors/downloading-and-installing-siddhi-extensions).

### Capturing inserts

Now you can write a simple Siddhi application to monitor the `SweetProductionTable` for insert operations.

1. Open a text file and copy-paste following application into it.

    ```
    @App:name('CDCListenForInserts')

    @App:description('Capture MySQL Inserts using CDC listening mode.')

    @source(type = 'cdc', url = 'jdbc:mysql://localhost:3306/production', username = 'wso2si', password = 'wso2', table.name = 'SweetProductionTable', operation = 'insert',
        @map(type = 'keyvalue'))
    define stream InsertSweetProductionStream (name string, amount double);

    @sink(type = 'log')
    define stream LogStream (name string, amount double);

    @info(name = 'query')
    from InsertSweetProductionStream
    select *
    insert into LogStream;
    ```
    Here the `url` parameter has the value `jdbc:mysql://localhost:3306/production`. Change it to point to your MySQL server.

2. Save this file as `CDCListenForInserts.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application captures all the inserts made to the `SweetProductionTable` database table and logs them.
        
3. To install the extensions required for the `CDCListenForInserts` Siddhi application you deployed, open a new terminal window and navigate to the `<SI_HOME>/bin` directory and issue one of the following commands as appropriate, based on your operating system:
    <br/>
    - For Windows: `extension-installer.bat`<br/>
    <br/>
    - For Linux:  `sh extension-installer.sh`<br/>
    <br/>

4. Now let's perform an insert operation on the MySQL table by executing the following MySQL query on the database:

    ```
    insert into SweetProductionTable values('chocolate',100.0);
    ```

    The following log appears in the SI console:

    ```
    INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CDCWithListeningMode : logStream : Event{timestamp=1563200225948, data=[chocolate, 100.0], isExpired=false}
    ```

### Capturing updates

Now you can write a Siddhi application to monitor the `SweetProductionTable` for update operations.

1. Open a text file and copy-paste following application into it.

    ```
    @App:name('CDCListenForUpdates')

    @App:description('Capture MySQL Updates using CDC listening mode.')

    @source(type = 'cdc', url = 'jdbc:mysql://localhost:3306/production', username = 'wso2si', password = 'wso2', table.name = 'SweetProductionTable', operation = 'update',
        @map(type = 'keyvalue'))
    define stream UpdateSweetProductionStream (before_name string, name string, before_amount double, amount double);

    @sink(type = 'log')
    define stream LogStream (before_name string, name string, before_amount double, amount double);

    @info(name = 'query')
    from UpdateSweetProductionStream
    select *
    insert into LogStream;
    ```

2. Save this file as `CDCListenForUpdates.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application captures all the updates to the `SweetProductionTable` database table and logs them.


3. Now let's perform an update operation on the MySQL table. For this, execute following MySQL query on the database:

    ```
    update SweetProductionTable SET name = 'Almond cookie' where name = 'chocolate';
    ```

    As a result, you can see the following log in the SI console.

    ```
    INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CDCWithListeningMode : updateSweetProductionStream : Event{timestamp=1563201040953, data=[chocolate, Almond cookie, 100.0, 100.0], isExpired=false}
    ```

    !!!info
        Here, the `before_name1` attribute indicates the value of the `name` attribute before the update was made (`chocolate` in this case), and the `name` attribute has the current name after the update (i.e., `almond cookie`).

### Capturing deletes

Now you can write a Siddhi application to monitor the `SweetProductionTable` for delete operations.

1. Open a text file and copy-paste following application into it.

    ```
    @App:name('CDCListenForDeletes')

    @App:description('Capture MySQL Deletes using CDC listening mode.')

    @source(type = 'cdc', url = 'jdbc:mysql://localhost:3306/production', username = 'wso2si', password = 'wso2', table.name = 'SweetProductionTable', operation = 'delete',
        @map(type = 'keyvalue'))
    define stream DeleteSweetProductionStream (before_name string, before_amount double);

    @sink(type = 'log')
    define stream LogStream (before_name string, before_amount double);

    @info(name = 'query')
    from DeleteSweetProductionStream
    select *
    insert into LogStream;
    ```

2. Save this file as `CDCListenForDeletes.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application captures all the delete operations carried out for the `SweetProductionTable` database table and logs them.

3. Now let's perform a delete operation for the MySQL table. To do this, execute following MySQL query on the database:

    ```
    delete from SweetProductionTable where name = 'Almond cookie';
    ```

    The following log appears in the SI console:

    ```
    INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CDCWithListeningMode : DeleteSweetProductionStream : Event{timestamp=1563367367098, data=[Almond cookie, 100.0], isExpired=false}
    ```

    !!!info
        Here, the `before_name` attribute indicates the name of the sweet in the deleted record (i.e., `Almond cookie` in this case). Similarly, the `before_amount` indicates the amount in the deleted record.

### Preserving State of the application through a system failure

Let's try out a scenario in which you are going to deploy a Siddhi application to count the total number of productions.

!!!info
    In this scenario, the SI server is required to *remember* the current count through system failures so that when the system is restored, the count is not reset to zero.
    To achieve this, you can use the state persistence capability in the Streaming Integrator.

1. Enable state persistence feature in SI server as follows. Open the `<SI_HOME>/conf/server/deployment.yaml` file on a text editor and locate the `state.persistence` section.

    ```
      # Periodic Persistence Configuration
    state.persistence:
      enabled: true
      intervalInMin: 1
      revisionsToKeep: 2
      persistenceStore: org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore
      config:
        location: siddhi-app-persistence
    ```

    Set `enabled` parameter to `true` and save the file.

2. Enable state persistence debug logs as follows. Open the `<SI_HOME>/conf/server/log4j2.xml` file on a text editor and locate the following line in it.

    ```
     <Logger name="com.zaxxer.hikari" level="error"/>
    ```

    Add following `<Logger>` element below that.

    ```
    <Logger name="org.wso2.carbon.streaming.integrator.core.persistence" level="debug"/>
    ```

    Save the file.

3. Restart the Streaming Integrator server for above change to be effective.

4. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('CountProductions')

    @App:description('Siddhi application to count the total number of orders.')

    @source(type = 'cdc', url = 'jdbc:mysql://localhost:3306/production', username = 'wso2si', password = 'wso2', table.name = 'SweetProductionTable', operation = 'insert',
            @map(type = 'keyvalue'))
    define stream InsertSweetProductionStream (name string, amount double);

    @sink(type = 'log')
    define stream LogStream (totalProductions double);

    @info(name = 'query')
    from InsertSweetProductionStream
    select sum(amount) as totalProductions
    insert into LogStream;
    ```

5. Save this file as `CountProductions.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory. When the
   Siddhi application is successfully deployed, the following `INFO` log appears in the Streaming Integrator console.

    ```
    INFO {org.wso2.carbon.stream.processor.core.internal.StreamProcessorService} - Siddhi App CountProductions deployed successfully
    ```

6. Now let's perform a few insert operations on the MySQL table. Execute following MySQL queries on the database:

    ```
    insert into SweetProductionTable values('Almond cookie',100.0);
    ```

    ```
    insert into SweetProductionTable values('Baked alaska',20.0);
    ```

    Now you can see following logs on the SI console.

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1564151034866, data=[100.0], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1564151037870, data=[120.0], isExpired=false}
    ```

    These logs print the sweet production count. Note that the current count of sweet productions is being printed as `120` in the second log. This is because the factory has so far produced `120` sweets: `100` Almond cookies and `20` Baked alaskas.

7. Now wait for following log to appear on the SI console

    ```
    DEBUG {org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore} - Periodic persistence of CountProductions persisted successfully
    ```

    This log indicates that the current state of the Siddhi application is successfully persisted. Siddhi application state is persisted every minute. Therefore, you can see this log appearing every minute.

    Next, let's insert two sweet productions into the `SweetProductionTable` and shutdown the SI server before the state persistence happens (in other words, before the above log appears).

    !!!Tip
        It is better to start inserting records immediately after the state persistence log appears, so that you have plenty of time to push messages and shutdown the server before next log appears.

8. Now insert following sweets into the `SweetProductionTable` by executing following queries on the database :

    ```
    insert into SweetProductionTable values('Croissant',100.0);
    ```

    ```
    insert into SweetProductionTable values('Croutons',100.0);
    ```

9. Shutdown SI server. Here you are deliberately creating a scenario where the server crashes before the SI server could persist the latest production count.

    !!!Info
         Here, the SI server crashes before the state is persisted. Therefore the SI server cannot persist the latest count (which should include the last two productions `100` Croissants and `100` Croutons). The good news is, `CDC source` replays the last two messages, allowing the Streaming Integrator to recover successfully from the server crash.

10. Restart the SI server and wait for about one minute.

11. The following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1564151078607, data=[220.0], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1564151078612, data=[320.0], isExpired=false}
    ```

Note that the `CDC source` has replayed the last two messages. As a result, the sweet production runs count has being correctly restored.

## Polling mode

!!!info "Before you begin:"
    You are required to have access to a MySQL instance. Create the required database and the database table in the MySQL instance as follows:<br/>
    1. Let's create a new database in the MySQL server which you are to use throughout this tutorial. To do this, issue the following command.<br/>
        ```
        CREATE SCHEMA production_pol;
        ```<br/>
    2. Switch to the production database and create a new table by executing following queries.<br/>
        `use production_pol;`<br/>
        `CREATE TABLE SweetProductionTable (last_update TIMESTAMP, name VARCHAR(20),amount double(10,2));`<br/>
    3. If you have not already created a user under [Listening Mode](#listening-mode), create a new user by executing the following SQL query.<br/>
        `GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'wso2si' IDENTIFIED BY 'wso2';`<br/>
    4. If you have not already added the MySQL JDBC driver into `<SI_HOME>/lib` under [Listening Mode](#listening-mode), add it as follows:<br/>
            a. Download the MySQL JDBC driver from [the MySQL site](https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz).<br/>
            b. Unzip the archive.<br/>
            c. Copy the `mysql-connector-java-5.1.45-bin.jar` to the `<SI_HOME>/lib` directory.


### Capturing inserts

Now you can write a simple Siddhi application to monitor the `SweetProductionTable` table for insert operations.

1. Open a text file and copy-paste the following application into it.

    ```
    @App:name("CDCPolling")

    @App:description("Capture MySQL changes, using CDC source - polling mode.")

    @source(type = 'cdc',
        url = 'jdbc:mysql://localhost:3306/production_pol?useSSL=false',
        mode = 'polling',
        jdbc.driver.name = 'com.mysql.jdbc.Driver',
        polling.column = 'last_update',
        polling.interval = '10',
        username = 'wso2si',
        password = 'wso2',
        table.name = 'SweetProductionTable',
        @map(type = 'keyvalue' ))
    define stream SweetProductionStream (name string, amount double);

    @sink(type = 'log')
    define stream LogStream (name string, amount double);

    @info(name = 'query')
    from SweetProductionStream
    select *
    insert into LogStream;
    ```

    Here the `url` parameter currently specifies the URL `jdbc:mysql://localhost:3306/production_pol`. Change it to point to your MySQL server.

2. Save this file as `CDCPolling.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application polls the database periodically, captures the changes made to the `SweetProductionTable`
         database table during the polled interval and logs them. The polling interval is specified via the `polling.interval`
         parameter in the Siddhi application when defining the CDC source. In this example, the polling interval is 10 seconds.


3. Now let's perform an insert operation on the MySQL table. To do this, execute following MySQL query on the database.

    ```
    insert into SweetProductionTable(name,amount) values('chocolate',100.0);
    ```

    The following log appears in the SI console:

    ```
    INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CDCWithPollingMode : LogStream : Event{timestamp=1563378804914, data=[chocolate, 100.0], isExpired=false}
    ```

### Capturing updates

For capturing updates, you can use the same `CDCPolling.siddhi` Siddhi application that you deployed in the [Capturing inserts](#capturing-inserts_1) section.

Let's perform an update operation on the MySQL table. To do this, execute the following MySQL query on the database:

```
update SweetProductionTable SET name = 'Almond cookie' where name = 'chocolate';
```

The following log appears in the SI console:

```
INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CDCWithPollingMode : logStream : Event{timestamp=1563436388530, data=[Almond cookie, 100.0], isExpired=false}
```

### Preserving State of the application through a system failure

Let's try out a scenario in which you deploy a Siddhi application to count the total number of production runs.

!!!info
    In this scenario, the SI server is required to *remember* the current count through system failures so that when the system is restored, the count is not reset to zero.
    To achieve this, you can use the state persistence capability in the Streaming Integrator.

1. Enable state persistence feature in SI server as follows. Open the `<SI_HOME>/conf/server/deployment.yaml` file on a text editor and locate the `state.persistence` section.

    ```
      # Periodic Persistence Configuration
    state.persistence:
      enabled: true
      intervalInMin: 1
      revisionsToKeep: 2
      persistenceStore: org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore
      config:
        location: siddhi-app-persistence
    ```

    Set `enabled` parameter to `true` and save the file.

2. Enable state persistence debug logs as follows. Open the `<SI_HOME>/conf/server/log4j2.xml` file on a text editor and locate the following line in it.

    ```
     <Logger name="com.zaxxer.hikari" level="error"/>
    ```

    Add following `<Logger>` element below that.

    ```
    <Logger name="org.wso2.carbon.streaming.integrator.core.persistence" level="debug"/>
    ```

    Save the file.

3. Restart the Streaming Integrator server for above change to be effective.

4. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name("CountProductions_pol")

    @App:description("Siddhi application to count the total number of orders.")

    @source(type = 'cdc',
        url = 'jdbc:mysql://localhost:3306/production_pol?useSSL=false',
        mode = 'polling',
        jdbc.driver.name = 'com.mysql.jdbc.Driver',
        polling.column = 'last_update',
        polling.interval = '10',
        username = 'wso2si',
        password = 'wso2',
        table.name = 'SweetProductionTable',
        @map(type = 'keyvalue' ))
    define stream SweetProductionStream (name string, amount double);

    @sink(type = 'log')
    define stream LogStream (totalProductions double);

    @info(name = 'query')
    from SweetProductionStream
    select sum(amount) as totalProductions
    insert into LogStream;
    ```

5. Save this file as `CountProductions_pol.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory. When the
   Siddhi application is successfully deployed, the following `INFO` log appears in the Streaming Integrator console.

    ```
    INFO {org.wso2.carbon.stream.processor.core.internal.StreamProcessorService} - Siddhi App CountProductions_pol deployed successfully
    ```

6. Now let's perform a few insert operations on the MySQL table. Execute following MySQL queries on the database:

    ```
    insert into SweetProductionTable(name,amount) values('Almond cookie',100.0);
    ```

    ```
    insert into SweetProductionTable(name,amount) values('Baked alaska',20.0);
    ```

    Now you can see following logs on the SI console.

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions_pol : LogStream : Event{timestamp=1564385971323, data=[100.0], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions_pol : LogStream : Event{timestamp=1564386011344, data=[120.0], isExpired=false}
    ```

    These logs print the sweet production count. Note that the current count of sweet production runs is being printed as `120` in the second log. This is because we have so far produced `120` sweets: `100` Almond cookies and `20` Baked alaskas.

7. Now wait for following log to appear on the SI console.

    ```
    DEBUG {org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore} - Periodic persistence of CountProductions_pol persisted successfully
    ```

    This log indicates that the current state of the Siddhi application is successfully persisted. Siddhi application state is persisted every minute, therefore you can see this log appearing every minute.

    Next, you are going to insert two sweet production runs into the `SweetProductionTable` and shutdown the SI server before state persistence happens (in other words, before above log appears).

    !!!tip
        It is better to start pushing messages immediately after the state persistence log appears, so that you have plenty of time to push messages and shutdown the server before next log appears.

8. Now insert following sweets into the `SweetProductionTable` by executing following queries on the database :

    ```
    insert into SweetProductionTable(name,amount) values('Croissant',100.0);
    ```

    ```
    insert into SweetProductionTable(name,amount) values('Croutons',100.0);
    ```

9. Shutdown SI server. Here you are deliberately creating a scenario where the server crashes before the SI server could persist the latest production count.

    !!!info
        Here, the SI server crashes before the state is persisted. Therefore, the SI server cannot persist the latest count (which should include the last two production runs `100` Croissants and `100` Croutons). The good news is, the `CDC source` replays the last two messages, allowing the Streaming Integrator to successfully recover from the server crash.

10. Restart the SI server and wait for about one minute.

11. The following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions_pol : LogStream : Event{timestamp=1564386179998, data=[220.0], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions_pol : LogStream : Event{timestamp=1564386180004, data=[320.0], isExpired=false}
    ```

Note that the `CDC source` has replayed the last two messages. This indicates that the sweet production run count is correctly restored.
