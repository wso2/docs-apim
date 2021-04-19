# Extracting Data from Static Sources in Real Time

WSO2 Streaming Integrator can extract data from static sources such as databases, files and cloud storages in real-tme. 

## Consuming data from RDBMS databases

A database table is a stored collection of records of a specific schema. Each record can be equivalent to an event. WSO2 Streaming Integrator can integrate databases into the streaming flow by extracting records in database tables as streaming events. This can be done via change data capture or by polling a database.

![Extracting data from databases]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/extract-data-from-databases.png)

To understand how data is extracted from a database into a streaming flow, consider a scenario where an online booking site automatically save all online bookings of vacation packages in a database. The company wants to monitor the bookings in real-time. Therefore, this data stored in the database needs to be extracted in real time. You can either capture this data as change data or poll the database. The `cdc` Siddhi extensions can be used for both methods as explained in the following subsections.

### Change data capture

Change data capture involves extracting any change that takes place in a selected database (i.e., any insert, update or a deletion) in real-time.

To capture change data via the [WSO2 Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview), define an input [stream](https://siddhi.io/en/v5.1/docs/query-guide/#stream) with the appropriate schema to capture the information you require, and then connect a [source](https://siddhi.io/en/v5.1/docs/query-guide/#source) of the `cdc` type as shown in the example below.

```
@source(type = 'cdc', 
    url = "jdbc:mysql://localhost:3306/tours?useSSL=false", 
    username = "wso2si", 
    password = "wso2", 
    table.name = "OnlineBookingsTable", 
    operation = "insert", 
    mode = "listening", jdbc.driver.name = "com.mysql.jdbc.Driver",
	@map(type = 'keyvalue'))
define stream OnlineBookingsStream (ref int, timestamp int, name string, package string, people int);
```
Here, note that the `mode` parameter of the `cdc` source is set to `listening`. This mode involves listening to the database for the specified database operation. In this example, the `operation` parameter is set to `insert`. Therefore, the source listens to new records inserted into the `OnlineBookingsTable` table and generates an input event in the `OnlineBookingsStream` stream for each insert.

If you want to capture updates to the records in the `OnlineBookingsTable` database table in real time, you can change the value for the `operation` parameter to `update` as shown below.

```
@source(type = 'cdc', 
    url = "jdbc:mysql://localhost:3306/tours?useSSL=false", 
    username = "wso2si", 
    password = "wso2", 
    table.name = "OnlineBookingsTable", 
    operation = "update", 
    mode = "listening", 
    jdbc.driver.name = "com.mysql.jdbc.Driver",
	@map(type = 'keyvalue'))
define stream OnlineBookingsStream (ref int, timestamp int, name string, package string, people int);
```
Similarly, if you want to capture deletions in the `OnlineBookingsTable` database table in real time, you can change the value for the `operation` parameter to `delete` as shown below.

```
@source(type = 'cdc', 
    url = "jdbc:mysql://localhost:3306/tours?useSSL=false", 
    username = "wso2si", 
    password = "wso2", 
    table.name = "OnlineBookingsTable", 
    operation = "delete", 
    mode = "listening", 
    jdbc.driver.name = "com.mysql.jdbc.Driver",
	@map(type = 'keyvalue'))
define stream OnlineBookingsStream (ref int, timestamp int, name string, package string, people int);
```

### Polling databases

This method involves periodically polling a database table to capture changes in the data. Similar to change data capture, you can  define an input [stream](https://siddhi.io/en/v5.1/docs/query-guide/#stream) with the appropriate schema to capture the information you require, and then connect a [source](https://siddhi.io/en/v5.1/docs/query-guide/#source) of the `cdc` type as shown in the example below. However, for polling, the value for the `mode` parameter must be `polling`

```
@source(type = 'cdc',
    url = 'jdbc:mysql://localhost:3306/tours?useSSL=false',
    mode = 'polling',
    jdbc.driver.name = 'com.mysql.jdbc.Driver',
    polling.column = 'timestamp',
    polling.interval = '10',
    username = 'wso2si',
    password = 'wso2',
    table.name = 'OnlineBookingsTable',
    @map(type = 'keyvalue' ))
define stream OnlineBookingsStream (ref int, timestamp long, name string, package string, people int);
```
The above source polls the `OnlineBookingsTable`table every 10 seconds and captures all inserts and updates to the database table that take place during that time interval. An input event is generated in the `OnlineBookingsStream` stream for each insert and update.

!!! tip
    - The `polling` mode only captures insert and update operations. Unlike in the `listening` mode, you do not need to specify the operation.
    

### Try out an example

Let's try out the example where you want to view the online bookings saved in a database in real time. To do this, follow the steps below:

1. Download and install MySQL.

2. Enable binary logging in the MySQL server. For detailed instructions, see [Debezium documentation - Enabling the binlog](https://debezium.io/docs/connectors/mysql/#enabling-the-binlog).<br/>
    !!! info
        If you are using MySQL 8.0, use the following query to check the binlog status.<br/>
        ```
        SELECT variable_value as "BINARY LOGGING STATUS (log-bin) ::"
        FROM performance_schema.global_variables WHERE variable_name='log_bin';
        ```<br/>
3. Start the MySQL server, create the database and the database table you require as follows:

    1. To create a new database, issue the following MySQL command.
    
        ```
        CREATE SCHEMA tours;
        ```
                        
    2. Create a new user by executing the following SQL query.
        
       ```
       GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'wso2si' IDENTIFIED BY 'wso2';
       ```
       
    3. Switch to the `tours` database and create a new table, by executing the following queries.
    
        `use tours;`
        
        `CREATE TABLE tours.tours (
          ref INT NOT NULL AUTO_INCREMENT,
          timestamp LONGTEXT NULL,
          name VARCHAR(45) NULL,
          package VARCHAR(45) NULL,
          people INT NULL,
          PRIMARY KEY (ref));`
          
    4. [Start the Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).
    
    5. Download the `cdc-mysql`Siddhi extension for Streaming Integrator Tooling. For instructions, see [Installing Siddhi Extensions]({{base_path}}/develop/streaming-apps/installing-siddhi-extensions/#installing-an-extension).
    
    6. In Streaming Integrator Tooling, open a new file. Copy and paste the following Siddhi application to it.
    
        ```
        @App:name("VacationsApp")
        @App:description("Captures cdc events from MySQL table")
               
        @source(type = 'cdc', url = "jdbc:mysql://localhost:3306/tours?useSSL=false", username = "wso2si", password = "wso2", table.name = "OnlineBookingsTable", operation = "insert", mode = "listening", jdbc.driver.name = "com.mysql.jdbc.Driver",
            @map(type = 'keyvalue'))
        define stream OnlineBookingsStream (ref int, timestamp long, name string, package string, people int);
                  
        @sink(type = 'log')
        define stream LogStream (ref int, timestamp long, name string, package string, people int);
              
        @info(name = 'query')
        from OnlineBookingsStream
        select *
        insert into LogStream;
        ```
       
        Then save the Siddhi application.<br/><br/>This Siddhi application uses a `cdc` source that extracts events in the change data capturing (i.e., listening) mode and logs the captured records in the console via a `log` sink.
        
    7. Start the Siddhi Application by clicking the play button.
    
        ![Play]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/play.png)
        
    8. To insert a record into the `OnlineBookingsTable`, issue the following MySQL command:
    
        `insert into OnlineBookingsTable(ref,timestamp,name,package,people) values('1',1602506738000,'jem','best of rome',2);`
        
        The following is logged in the Streaming Integrator Tooling terminal.
                   
        ```
        INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - VacationsApp : LogStream : Event{timestamp=1563378804914, data=[1, 1602506738000, jem, best of rome, 2], isExpired=false}
        ```

### Supported databases

[siddhi-io-cdc source](https://siddhi-io.github.io/siddhi-io-cdc/api/latest/) via which the WSO2 Steaming Integrator extracts database records supports the following database types.

The following is a list of Siddhi extensions that support change data capturing to allow you to extract database records as input events in real time.

| **Database Type** | **Extension Name** | **Description**                                 |
|-------------------|--------------------|-------------------------------------------------|
| Mongo DB          | `cdc-mongodb`      | Captures change data from Mongo DB databases.   | 
| MS SQL            | `cdc-mssql`        | Captures change data from MS SQL databases.     |
| MySQL             | `cdc-mysql`        | Captures change data from MySQL databases.      | 
| Oracle            | `cdc-oracle`       | Captures change data from Oracle databases.     |
| PostgreSQL        | `cdc-postgresql`   | Captures change data from PostgreSQL databases. |

### Supported mappers

Mappers determine the format in which the event is received. For information about transforming events by changing the format in which the data is received/published, see [Transforming Data]({{base_path}}/use-cases/streaming-usecase/transforming-data/#transforming-message-formats).

The mapper available for extracting data from databases is [Keyvalue](https://siddhi-io.github.io/siddhi-map-keyvalue/api/2.1.0/#sourcemapper).

## File Processing

File Processing involves two types of operations related to files:

- **Extracting data from files**: This involves extracting the content of file as input data for further processing.

- **Managed file transfer**: This involves using statistics of operations carried out for files (e.g., creating, editing, moving, deleting, etc.) as input data for further processing.

e.g., In a sweet factory where the production bots publishes the production statistics in a file after each production run. Extracting the production statistics from the files for further processing can be considered reading files and extracting data. Checking whether a file is generated to indicate a completed production run, and checking whether a file is moved to a different location after its content is processed can be considered as managed file transfer.

To understand how you can perform these file processing activities via the WSO2 Streaming Integrator, see the subtopics below.


### Extracting data from files

WSO2 Streaming Integrator extracts data from files via the [File Source](https://siddhi-io.github.io/siddhi-io-file/api/latest/#file-source). Once it extracts the data, it can publish it in a streaming manner so that other streaming applications that cannot read static data from files.

![Extracting data from databases]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/file-content-processing.png)

To further understand this, let's try out designing a solution for the Sweet Factory that needs to expose its production statitstics in the file generated by production bots in a streaming manner to the production manager so thyat the statistics can be viewed and analyzed in real time.

#### Selecting the file(s) to read

You can extract data from a single file or from multiple files in a directory. This is specified via the `file.uri` and `dir.uri` parameters as shown below:

- **Reading a single file**

    In the following example, the `file.uri` parameter specifies the `productioninserts.csv` file in the `/Users/foo` directory as the file from which the source should extract data. 
    
    ```
    @source(type = 'file',file.uri = "file:/Users/foo/productioninserts.csv",
        @map(type = 'csv'))
    define stream ProductionStream (name string, amount double);
    ```
    
- **Reading multiple files within a directory**

    In the following example, the `dir.uri` parameter specifies the `/Users/foo/production` as the directory with the files from which the source extracts information. According to the following configuration, all the files in the directory are read.
    
    ```
    @source(type = 'file',
        dir.uri = "file:/Users/foo/production",
        @map(type = 'csv'))
    define stream ProductionStream (name string, amount double);
    ```
  
    If you want the source to read only specific files within the directory, you need to specify the required files via the `file.name.list` parameter as shown below.
    
    ```
    @source(type = 'file', 
        dir.uri = "file:/Users/foo/production", 
        file.name.list = "productioninserts.csv,AssistantFile.csv,ManagerFile.csv",
    	@map(type = 'csv'))
    define stream ProductionStream (name string, amount double);
    ```
#### Selecting the mode in which the file is read
 
The `file` source can read the selected file(s) in many modes. The available modes are as follows.

| **Mode**          | **Description**                                    |
|-------------------|----------------------------------------------------|
| `TEXT.FULL`       | Reads a text file completely in one reading.       |
| `BINARY.FULL`     | Reads a binary file completely in one reading.     |
| `BINARY.CHUNKED`  | Reads a binary file chunk by chunk.                |
| `LINE`            | Reads a text file line by line                     |
| `REGEX`           | Reads a text file and extracts data using a regex. |

You can specify the required mode via the `mode` parameter as shown in the example below.

```
@source(type = 'file',
    file.uri = "file:/Users/foo/productioninserts.csv",
    mode='LINE'
    @map(type = 'csv'))
define stream ProductionStream (name string, amount double);
```
#### Moving or deleting files after reading/failure

If required, you can configure a `file` source to move or delete the files after they are read or after an attempt to read them has resulted in a failure. In both scenarios, the defauly action is to delete the file.

e.g., If you want to move the `productioninserts.csv` file in the previous example after it is read, specify `move` as the value for `action.after.process`. Then add the `move.after.process` to specify the location to which the file should be moved after processing.

```
@source(type = 'file', file.uri = "file:/Users/foo/productioninserts.csv", 
    mode = "line",
    tailing = "false",
    action.after.process = "move", 
    move.after.process = "file:/Users/processedfiles/productioninserts.csv", 
	@map(type = 'csv'))
define stream ProductionStream (name string, amount double);
```
Here, you are  moving the `productioninserts.csv` file from the `/Users/foo` directory to the `/Users/processedfiles` after it is processed. 

Note that this extract also includes `tailing = "false"`. When tailing is enabled, the source reports any change made to the file immediately. Tailing is available only when the mode is set to `LINE` or `REGEX`, and it is enabled for these modes by default. Therefore, if you are using one of these modes and you want to set the `action.after.process` to `move` you need to disable tailing.

#### Supporting Siddhi extension

Reading content in files are supported via the [file Siddhi extension](https://siddhi-io.github.io/siddhi-io-file/api/latest/#source).

#### Supporting mappers

The following mappers are supported for the File extension.

| **Transport** | **Supporting Siddhi Extension**                                                        |
|---------------|----------------------------------------------------------------------------------------|
| `csv`         | [csv](https://siddhi-io.github.io/siddhi-map-csv/api/2.1.0/#csv-source-mapper)         |
| `xml`         | [xml](https://siddhi-io.github.io/siddhi-map-xml/api/latest/#sourcemapper)             |
| `text`        | [text](https://siddhi-io.github.io/siddhi-map-text/api/latest/#sourcemapper)           |

### Performing managed file transfers

WSO2 Streaming Integrator supports managed file transfers which involves detecting whether a file is created/modified/removed.

![Managed File Transfers]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/file-events-processing.png)


To check whether any file is created, modified or removed in a specific directory, you can configure a source of the `fileeventlistener` connected to an event stream as follows.

```
@source(type = 'fileeventlistener', 
    dir.uri = "file:/Users/foo",
	@map(type = 'passThrough'))
define stream FileListenerStream (filepath string, filename string, status string);
```
The above configuration monitors whether any activity is generated for any file in the `/Users/foo` directory. If any file was created/modified/removed in the directory, an event is generated in the `FileListenerStream` stream. This event reports the name of the file, the file path, and the status of the file.

If you want to monitor only activities generated for a specific file, you need to specify the names of the files via the  `file.name.list` parameter as shown in the example below.

```
@source(type = 'fileeventlistener', 
    dir.uri = "file:/Users/foo",
    file.name.list = "productioninserts 18.01.22.csv,materialconsumption.txt",
	@map(type = 'passThrough'))
define stream FileListenerStream (filepath string, filename string, status string);
```
The above source configuration generates an event in the `FileListenerStream` only when the `productioninserts 18.01.22.csv` and `materialconsumption.txt` are created, modified, and/or removed.

If you want the directory to be monitored for file events periodically, you can specify the required monitoring interval in milliseconds via the `monitoring.interval` parameter as shown in the example below.

```
@source(type = 'fileeventlistener', 
        dir.uri = "file:/Users/foo", 
        monitoring.interval = "200", 
        file.name.list = "productioninserts 18.01.22.csv,materialconsumption.txt",
        @map(type = 'passThrough'))
define stream FileListenerStream (filepath string, filename string, status string);
```
The above source configuration checks the `/Users/foo` directory every 200 milliseconds, and an event is generated in the `FileListenerStream` for each file transaction that involved creating/modifying/removing a file named `productioninserts 18.01.22.csv` or `materialconsumption.txt`.

#### Supporting Siddhi extension

Capturing file events is supported via the [fileeventlistener Siddhi extension](https://siddhi-io.github.io/siddhi-io-file/api/latest/#fileeventlistener-source).

### Try out an example

To try out reading the content of a file and file events, let's address the requirement of the example mentioned before of a sweet factory that publishes production details in a file. 

1. Start and access [WSO2 Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview).

2. Open a new file and add the following Siddhi application. 

    ```
        @App:name('LogFileEventsApp')
        @App:description('Description of the plan')
        
        @source(type = 'fileeventlistener', 
                dir.uri = "file:/Users/production", 
                @map(type = 'passThrough'))
        define stream FileListenerStream (filepath string, filename string, status string);
        
        @sink(type = 'log',
        	@map(type = 'passThrough'))
        define stream LogFileEventsStream (filepath string, filename string, status string);
        
        @info(name = 'Query')
        from FileListenerStream 
        select * 
        insert into LogFileEventsStream;
    ```
   
    !!! tip
        You can change the `Users/production` directory path to the path of a preferred directory in your machine.

    Then save the file as `LogFileEventsApp`.
    
    The above Siddhi Application monitors the `Users/production` directory and generates an event in the `FileListenerStream` if any file is created/modified/removed in it.
    
2. Start the `LogFileEventsApp` Siddhi application you created by clicking on the play icon in the top panel.

    ![Play]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/play.png)
    
3. Open a new file in a text editor of your choice, and save it as `productionstats.csv` in the `Users/production` directory.

    As a result, the following is logged in the Streaming Integrator Tooling terminal to indicate that the `productionstats.csv` is created in the `Users/production` directory.
    
    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - LogFileEventsApp : LogFileEventsStream : Event{timestamp=1603105747423, data=[/Users/production/productionstats.csv, productionstats.csv, created], isExpired=false} 
    ```
   
4. Create and save the following Siddhi application in Streaming Integrator Tooling.

    ```
    @App:name("FileReadingApp")
    
    @source(type = 'file', 
        file.uri = "file:/Users/production/productionstats.csv", 
        mode = "line", 
        tailing = "false", 
        action.after.process = "move", 
        move.after.process = "file:/Users/processedfiles/productionstats.csv",
        @map(type = 'csv'))
    define stream ProductionStream (name string, amount double);
    
    @sink(type = 'log',
    @map(type = 'passThrough'))
    define stream LogStream (name string, amount double);
    
    @info(name = 'Query')
    from ProductionStream 
    select * 
    insert into LogStream;
    ```
   
   This Siddhi application reads the content of the `/Users/production/productionstats.csv` file that you previously created and generates an event per row in the `ProductionStream` stream. After reading the file, the Siddhi app moves it to the `/Users/processedfiles` directory.
   
5. Start the `FileReadingApp` Siddhi application.

6. Open the `/Users/production/productionstats.csv` file, add the following content to it, and then save the file.

    ```
    Almond cookie,100.0
    Baked alaska,20.0
    ```
    The following is logged in the Streaming Integrator Tooling terminal:
    
    - **For the `FileReadingApp` Siddhi application**
    
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - FileReadingApp : LogStream : Event{timestamp=1603106006720, data=[Almond cookie, 100.0], isExpired=false} 
        ```
      
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - FileReadingApp : LogStream : Event{timestamp=1603106006720, data=[Baked alaska, 20.0], isExpired=false} 
        ```
      
        These logs show the content of the `productionstats.csv` file that is read by WSO2 Streaming Integrator.
    
    - **For the `LogFileEventsApp` Siddhi application**

        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - LogFileEventsApp : LogFileEventsStream : Event{timestamp=1603106006807, data=[/Users/production/productionstats.csv, productionstats.csv, removed], isExpired=false}
        ```
      
        This log indicates that the WSO2 Streaming Integrator has detected that the 'productionstats.csv` file is removed from the `/Users/production` directory.    

## Consuming data from cloud storages

WSO2 Streaming Integrator allows you to access data in cloud storages (such as Amazon Web Services - SQS, Amazon Web Services - S3, and Google Cloud Platform) and expose it in a streaming manner to applications that cannot access cloud storages. Cloud-based data sources generally cannot be tailed and therefore, it is challenging to expose changes to the stored data in real time. WSO2 Streaming Integrator addresses this issue by periodically polling the cloud storage, transferring the changes detected during those polling intervals to a file, and then tailing the file to expose the data in a streaming manner as illustrated in the following diagram.

![Accessing Data in Cloud Storages]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/cloud-storages.png)

The following is an example where the WSO2 Streaming Integrator retrieves messages from an SQS queue. A source of the `sqs`type is used for this purpose where you can provide the URL to the SQS queue that you want to subscribe to, and provide the access key and the secret to access it. the queue is polled periodically (i.e., every 5000 milliseconds). The source generates an event in the `InStream` stream for each message it retrieves.

```
@source(type='sqs',
    queue='http://aws.sqs.queue.url',
    access.key='aws.access.key',
    secret.key='aws.secret.key',
    region='us-east-2',
    polling.interval='5000',
    max.number.of.messages='10',
    number.of.parallel.consumers='1',
    purge.messages='true',
    wait.time='2',
    visibility.timeout='30',
    delete.retry.interval='1000',
    max.number.of.delete.retry.attempts='10',
    @map(type='xml',enclosing.element="//events",@attributes(symbol='symbol', message_id='trp:MESSAGE_ID') ))
define stream InStream (symbol string, message_id string);
```

To transfer the content of the cloud storage to a file, add another stream with a sink of the `file` type as shown in the example below.

!!! tip
    To learn more about publishing data to files, see [Loading and Writing Data]({{base_path}}/use-cases/streaming-usecase/loading-and-writing-date).

```
@sink(type = 'file', 
    file.uri = "/Users/messages/messages.csv",
	@map(type = 'json'))
define stream ExtractCloudDataStream (symbol string, message_id string);
```

Then write a query as follows to send all the events in the `InStream` stream to the `ExtractCloudDataStream` stream so that all the events extracted from the cloud can be transferred to the `/Users/messages/messages.csv` file.

```
@info(name = 'MoveCloudContentToFile')
from InStream 
select * 
insert into ExtractCloudDataStream;
```
The complete Siddhi application with the above configurations is as follows.

```
@App:name('CloudProcessingApp')
@App:description('Description of the plan')

@source(type = 'sqs', queue = "http://aws.sqs.queue.url", access.key = "aws.access.key", secret.key = "aws.secret.key", region = "us-east-2", polling.interval = "5000", max.number.of.messages = "10", number.of.parallel.consumers = "1", purge.messages = "true", wait.time = "2", visibility.timeout = "30", delete.retry.interval = "1000", max.number.of.delete.retry.attempts = "10",
	@map(type = 'xml', enclosing.element = "//events",
		@attributes(symbol = "symbol", message_id = "trp:MESSAGE_ID")))
define stream InStream (symbol string, message_id string);

@sink(type = 'file', 
    file.uri = "/Users/messages/messages.csv",
	@map(type = 'json'))

define stream ExtractCloudDataStream (symbol string, message_id string);

@info(name = 'MoveCloudContentToFile')
from InStream 
select * 
insert into ExtractCloudDataStream;
```

Now you can tail the data that is stored in the cloud by tailing the `/Users/messages/messages.csv` file. For more information about extracting information from files, see [Extracting data from files](#extracting-data-from-files).


### Supported cloud platforms

The following is a list of cloud platforms from which you can extract stored data via WSO2 Streaming Integrator.

| **Cloud Platform**            | **Extension**                                                                                         |
|-------------------------------|-------------------------------------------------------------------------------------------------------|
| AWS SQS                       | [SQS](https://siddhi-io.github.io/siddhi-io-sqs/api/2.0.0/#source)                                    |
| AWS Simple Cloud Storage (S3) | [S3](https://siddhi-io.github.io/siddhi-io-s3/api/latest/)                                            |
| Google Cloud Storage          | [GCS](https://siddhi-io.github.io/siddhi-io-gcs/api/latest/)                                          |
| CosmosDB                      | [CosmosDB](https://github.com/wso2-extensions/siddhi-store-cosmosdb/blob/master/docs/api/latest.md)   |
| Azure Data Lake               | [azuredatalake](https://siddhi-io.github.io/siddhi-io-azuredatalake/api/latest/#source)               |

### Supported mappers

Mappers determine the format in which the event is received. For information about transforming events by changing the format in which the data is received/published, see [Transforming Data]({{base_path}}/use-cases/streaming-usecase/transforming-data/#transforming-message-formats).

WSO2 Streaming Integrator supports the following mappers for the cloud-based storages from which it extracts data.

| **Mapper** | **Supporting Siddhi Extension**                                                                  |
|---------------|-----------------------------------------------------------------------------------------------|
| `json`        | [json](https://siddhi-io.github.io/siddhi-map-json/api/latest/#sinkmapper)                    |
| `xml`         | [xml](https://siddhi-io.github.io/siddhi-map-xml/api/latest/#sinkmapper)                      |
| `text`        | [text](https://siddhi-io.github.io/siddhi-map-text/api/latest/#sinkmapper)                    |
| `avro`        | [avro](https://siddhi-io.github.io/siddhi-map-avro/api/latest/#sinkmapper)                    |
| `binary`      | [binary](https://siddhi-io.github.io/siddhi-map-binary/api/latest/#binary-sink-mapper)        | 
| `keyvalue`    | [keyvalue](https://siddhi-io.github.io/siddhi-map-keyvalue/api/2.1.0/#sourcemapper)           |
| `csv`         | [csv](https://siddhi-io.github.io/siddhi-map-csv/api/2.1.0/#sourcemapper)                     |
| `protobuf`    | [protobuf](https://siddhi-io.github.io/siddhi-map-protobuf/api/1.1.0/#protobuf-source-mapper) |


