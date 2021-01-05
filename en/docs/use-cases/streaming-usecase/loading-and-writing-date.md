# Loading and Writing Data

Loading and writing data involves publishing the data in a destination where it can be extracted again at any given time for further processing. WSO2 Streaming Integrator supports loading and writing data to databases, files, and cloud storages.

## Loading data to databases

WSO2 Streaming allows you to load data into databases so that the data can be available in a static manner for further processing. You can load the data received from another source unchanged or after processing it. This is achieved by defining [Siddhi tables](https://siddhi.io/en/v5.1/docs/query-guide/#table) that are connected to database tables, and then writing queries to publish data into those tables so that it can be transferred to the connected database tables.

![Loading Data to Databases]({{base_path}}/assets/img/streaming/loading-and-writing-data/load-data-to_database.png)

To understand this, consider an example of an sweet shop that needs to save all its sales records in a database table. To address this, you can write a Siddhi application as follows:

- **Define a table**

    In this example, let's define a table named `SalesRecords` as follows:
    
    ```
    @primaryKey('ref')
    @index('name')
    @store(type='rdbms', jdbc.url="jdbc:mysql://localhost:3306/SalesRecordsDB", username="root", password="root" , jdbc.driver.name="com.mysql.jdbc.Driver")
    define table SalesRecords(ref string, name string, amount int);
    ```
  The above table definition captures sales records. The details captured in each sales record includes the transaction reference (`ref`), the name of the product (`name`), and sales amount (`amount`). The `ref` attribute is the primary key because there cannot be two or more records with the same transaction reference. The `name` attribute is an index attribute.
  
  A data store named `SalesRecordsDB` is connected to this table definition via the `@store` annotation. This is the data store to which you are loading data.

- **Add a query**

    You need to add a query to specify how events are selected to be inserted into the table you defined. You can add this query as shown below. 
    
    ```
    from SalesRecordsStream
    select *
    insert into SalesRecords;
    ``` 
    The above query gets all the input events from the `SalesRecordsStream` stream and loads them to the `SalesRecords` table.
    
### Try it out

To try out the example given above, follow the steps below:

1. Set up MySQL as follows:

    1. Download and install MySQL.    
    
    2. Start the MySQL server, create the database and the database table you require as follows:
    
        1. To create a new database, issue the following MySQL command.
        
            ```
            CREATE SCHEMA sales;
            ```
                            
        2. Switch to the `sales` database by issuing the following command.
            
           ```
           use sales;
           ```
           
        3. Create a new table, by issuing the following command.        
            
            ```
            CREATE TABLE sales.SalesRecords (
              ref INT NOT NULL AUTO_INCREMENT,
              name VARCHAR(45) NULL,
              amount INT NULL,
              PRIMARY KEY (ref));
            ```
        
2. [Start and access WSO2 Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

3. Install the `RDBMS - MySQL` extension in Streaming Integrator tooling. For instructions to install an extension, see [Installing Siddhi Extensions]({{base_path}}/develop/streaming-apps/installing-siddhi-extensions).

4. Open a new file in WSO2 Streaming Integrator Tooling and add the following Siddhi content to it.

    ```
    @App:name('SalesApp')
    
    define stream SalesRecordsStream (name string, amount int);
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/sales?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    @primaryKey('ref' )
    @index('name' )
    define table SalesRecords (name string, amount int);
    
    from SalesRecordsStream 
    select * 
    insert into SalesRecords;
    ```
   
   Save the Siddhi application.   
    
5. Simulate an event with the following values for the `SalesRecordsStream` stream of the `SalesApp` Siddhi application. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).
    
    | **Attribute** | **Value**        |
    |---------------|------------------|
    | **ref**       | `AA000000000001` |
    | **name**      | `fruit cake`     |
    | **amount**    | `100`            |
        
6. To check whether the `sales` mysql table is updated, issue the following command in the MySQL server.

    `select * from SalesRecords;`
    
    The table is displayed as follows, indicating that the event you generated is added as a record.
    
    ![Updated MySQL Table]({{base_path}}/assets/img/streaming/loading-and-writing-data/updated-mysql-table.png)
    
### Publishing data on demand via store queries

To understand how to publish data on demand, see [Correlating Data]({{base_path}}/correlating-data)

### Supported databases

WSO2 Streaming supports the following database types via Siddhi extensions:

| **Database Type** | **Siddhi Extension**                                                                |
|-------------------|-------------------------------------------------------------------------------------|
| RDBMS             | [rdbms](https://siddhi-io.github.io/siddhi-store-rdbms/api/latest/#store)           |
| MongoDB           | [mongodb](https://siddhi-io.github.io/siddhi-store-mongodb/api/latest/#store)       |
| Redis             | [redis](https://siddhi-io.github.io/siddhi-store-redis/api/latest/#store)           |
| elasticsearch     | [elasticsearch](https://siddhi-io.github.io/siddhi-store-elasticsearch/api/latest/) |

### Supported Mappers

Mappers determine the format in which the event is published. For information about transforming events by changing the format in which the data is published, see [Transforming Data]({{base_path}}/use-cases/streaming-usecase/transforming-data#transforming-the-message-format-when-publishing-data).

The mapper available for loading data to databases is [Keyvalue](https://siddhi-io.github.io/siddhi-map-keyvalue/api/2.1.0/#sinkmapper).

## Writing data to files

WSO2 Streaming allows you to write data into files so that the data can be available in a static manner for further processing. You can write the data received from another source unchanged or after processing it. This is achieved by defining an output [stream](https://ei.docs.wso2.com/en/7.2.0/streaming-integrator/guides/loading-and-writing-date/) and then connecting a [sink](https://siddhi.io/en/v5.1/docs/query-guide/#sink) of the [file](https://siddhi-io.github.io/siddhi-io-file/api/2.0.10/#sink) type.

![Loading Data to Databases]({{base_path}}/assets/img/streaming/loading-and-writing-data/load-data-to-file.png)

To understand this, consider the example of a lab with a sensor that reports the temperature at different times. These temperature readings need to be saved in a file for reference when carrying out further analysis.  

To address the above requirement via WSO2 Streaming Integrator, define an output stream and connect a file source to it as shown below.

```
@sink(type = 'file', 
    file.uri = "/users/temperature/temperature.csv",
	@map(type = 'passThrough'))
define stream TemperatureLogStream (timestamp long, temperature int);
```
Here, any event directed to the `TemperatureLogStream` is written into the `/users/temperature/temperature.csv` file.

### Try it out

To try out the above example by including the given output stream and the sink configuration in a complete Siddhi application, follow the steps below:

1. [Start and access WSO2 Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

2. Open a new file and copy the following Siddhi Application to it.

    ```
    @App:name('LabTemperatureApp')
    
    define stream LabTemperatureStream (timestamp long, temperature int);
    
    @sink(type = 'file', 
        file.uri = "/users/temperature/temperature.csv",
    	@map(type = 'passThrough'))
    define stream TemperatureLogStream (timestamp long, temperature int);
    
    from LabTemperatureStream 
    select * 
    insert into TemperatureLogStream;
    ```
   This Siddhi application includes the file sink from the previous example.
   
    !!! tip
        If required, you can replace the value for the `file.uri` parameter to a preferred location in your machine.
   
3. Simulate an event with the following values for the `LabTemperatureStream` stream of the `LabTemperatureApp` Siddhi application. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).  
    
    | **Attribute**   | **Value**       |
    |-----------------|-----------------|
    | **timestamp**   | `1603461542000` |
    | **temperature** | `27`            |
    
4. Open the `/users/temperature/temperature.csv` file. It contains a line as shown below.

    ![Updated File]({{base_path}}/assets/img/streaming/loading-and-writing-data/updated-file.png)

    This is the event that you simulated that has been written into the file by WSO2 Streaming Integrator.
    
### Supported Mappers

Mappers determine the format in which the event is published. For information about transforming events by changing the format in which the data is published, see [Transforming Data]({{base_path}}/use-cases/streaming-usecase/transforming-data/#transforming-message-formats).

The following mappers are supported for the File extension.

| **Transport** | **Supporting Siddhi Extension**                                                        |
|---------------|----------------------------------------------------------------------------------------|
| `csv`         | [csv](https://siddhi-io.github.io/siddhi-map-csv/api/2.1.0/#csv-source-mapper)         |
| `xml`         | [xml](https://siddhi-io.github.io/siddhi-map-xml/api/latest/#sourcemapper)             |
| `text`        | [text](https://siddhi-io.github.io/siddhi-map-text/api/latest/#sourcemapper)           |
    
## Storing data in Cloud storage

WSO2 SI allows you to store data in cloud storages in a static manner so that it can be accessed for further processing. The data you store can be the unprocessed data you received from another source or output data generated by WSO2 Streaming Integrator. This is achieved by defining an output [stream](https://ei.docs.wso2.com/en/7.2.0/streaming-integrator/guides/loading-and-writing-date/) and then connecting a [sink](https://siddhi.io/en/v5.1/docs/query-guide/#sink) of a type that links to cloud storages.

![Saving Data in Cloud Storages]({{base_path}}/assets/img/streaming/loading-and-writing-data/load-data-to-cloud.png)

To understand this, To understand this, consider the example of a lab with a sensor that reports the temperature at different times. These temperature readings need to be uploaded to a cloud-based application for reference when carrying out further analysis. 

To address the above requirement with WSO2 Streaming Integrator, configure an output stream, and connect a sink of the `google-cloud-storage` type to it as shown below.

```
@sink(type='google-cloud-storage', credential.path='<credential.path>', bucket.name='temperaturelog',
      object.name='temperature-object-{{name}}',
    @map(type='text'))
define stream TemperatureLogStream (timestamp long, temperature int);
```

Here, all events in the `TemperatureLogStream` stream are stored in a Google cloud bucket named `temperaturelog`. The `credential path` parameter needs to specify the location in your machine where you have stored the credentials file generated by Google Cloud Service.

### Try it out

To try out the above example, follow the steps below:

1. Set up a Google cloud as follows:

    1. Create an account in [Google Cloud](https://cloud.google.com/).
    
    2. Download the credential file that is generated through the GCP console and save it in a directory of your choice. For more information, see [Google Cloud Authentication Documentation](https://cloud.google.com/docs/authentication/?hl=en_US&_ga=2.203156947.-316765357.1568779091).
    
    3. Create a bucket named `temperaturelog` in the Google Cloud Console.
    
2. [Start and access WSO2 Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

3. Open a new file and copy the following Siddhi Application to it.

    ```
    @App:name('LabTemperatureApp')
    
    define stream LabTemperatureStream (timestamp long, temperature int);
    
    @sink(type='google-cloud-storage', credential.path='<credential.path>', bucket.name='temperaturelog',
          object.name='temperature-object-{{name}}',
        @map(type='text'))
    define stream TemperatureLogStream (timestamp long, temperature int);
    
    from LabTemperatureStream 
    select * 
    insert into TemperatureLogStream;
    ```
   
   Save the Siddhi application. 
   
   The above Siddhi application gets all the events in the `LabTemperatureStream` stream and inserts them into the `TemperatureLogStream` stream so that they can be stored in the `temperaturelog` bucket in the Google Cloud Console via the sink connected to the `TemperatureLogStream` stream.
   
4. Simulate an event to the `LabTemperatureStream` stream of the `LabTemperatureApp` Siddhi application with the following values via the Event Simulator tool. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application). 
    
    | **Attribute**   | **Value**       |
    |-----------------|-----------------|
    | **timestamp**   | `1603461542000` |
    | **temperature** | `27`            |       
    
    This generates an output event that is updated in the `temperaturelog`bucket.
    
### Supported cloud platforms

The following is a list of cloud platforms in which you can store data via WSO2 Streaming Integrator.

| **Cloud Platform**            | **Extension**                                                                                       |
|-------------------------------|-----------------------------------------------------------------------------------------------------|
| AWS SQS                       | [SQS](https://siddhi-io.github.io/siddhi-io-sqs/api/2.0.0/#sink)                                    |
| AWS Simple Cloud Storage (S3) | [S3](https://siddhi-io.github.io/siddhi-io-s3/api/latest/#s3-sink)                                  |
| Google Cloud Storage          | [GCS](https://siddhi-io.github.io/siddhi-io-gcs/)                                                   |
| CosmosDB                      | [CosmosDB](https://github.com/wso2-extensions/siddhi-store-cosmosdb/blob/master/docs/api/latest.md) |
| Azure Data Lake               | [azuredatalake](https://siddhi-io.github.io/siddhi-io-azuredatalake/api/latest/#sink)               |

### Supported mappers

Mappers determine the format in which the event is received. For information about transforming events by changing the format in which the data is received/published, see [Transforming Data]({{base_path}}/use-cases/streaming-usecase/transforming-data/#transforming-message-formats).

WSO2 Streaming Integrator supports the following mappers for the cloud-based storages in which it stores data.

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