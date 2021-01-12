# Integrating Data Stores in Streaming Integration

## Introduction

WSO2 Streaming Integrator allows you to incorporate data stores when performing various streaming integration activities. The methods in which this is done include:

- Change data capture
- Storing received data/processed data in data stores
- Performing CRUD operations in data stores

[Performing Real-time Change Data Capture with MySQL] tutorial covers how to perform change data capture in details. Therefore, in this tutorial, let's learn how WSO2 Streaming Integrator can incorporate data stores in streaming operations by performing CRUD operations.

## Scenario

Let's consider the example of a Sweet Factory that stores the following information in three different databases:

- Records of material purchases to be used in production
- Records of material dispatches for production
- The current stock of materials

In order to manage the material stock and to maintain the required records, the Factory Manager needs to do the following activities:

- Record each material purchase in the store for purchases.
- Record each dispatch of material for production in the store for dispatches.
- Update the store with current stock for each material after each purchase and dispatch to keep it up to date.

Recording purchases and dispatches involve inserting new records into data stores. To maintain the current stock records, the Factory Manager needs to retrieve information about both purchases and dispatches, calculate the impact of both on the current stock and then perform an insert/update operation to the store with the stock records. 

To understand how the WSO2 Streaming Integrator performs these operations, follow the steps below.

## Tutorial steps

!!! tip  "Before you begin:"
    You need to complete the following prerequisites before you begin:<br/><br/>
    - You need to have access to a MySQL instance.<br/><br/>
    - Install `rdbms-mysql` extension in WSO2 Streaming Integrator as follows:<br/><br/>
        1. Start WSO2 Streaming Integrator by navigating to the `<SI_HOME>/bin` directory and issuing the appropriate command based on your operating system.<br/><br/>
            - **For Linux**  : `./server.sh`
            - **For Windows**: `server.bat --run`<br/><br/>
        2. To install the `rdbms-mysql` extension, navigate to the to the `<SI_HOME>/bin` directory and issue the appropriate command based on your operating system:<br/><br/>
            - **For Linux**  : `./extension-installer.sh`
            - **For Windows**: `extension-installer.bat --run`<br/><br/>
        3. Restart the WSO2 Streaming Integrator server.<br/><br/>
    - Install the `rdbms-mysql` extension in WSO2 Streaming Integrator as follows.<br/><br/>
        1. Start WSO2 Streaming Integrator Tooling by navigating to the `<SI_TOOLING_HOME>/bin` directory and issuing the appropriate command based on your operating system.<br/><br/>
            - **For Linux**  : `./tooling.sh`
            - **For Windows**: `tooling.bat --run`<br/><br/>
        2. Access Streaming Integrator Tooling. Then click **Tools** -> **Extension Installer** to open the **Extension Installer** dialog box.<br/><br/>
        3. In the **Extension Installer** dialog box, click **Install** for the **RDBMS-MYSQL** extension. Then click **Install** in the message that appears to confirm whether you want to proceed.<br/><br/>
        4. Restart WSO2 Streaming Integrator Tooling.<br/><br/>
    - Start the MySQL server.<br/><br/>
    - Create three MySQL databases by issuing the following commands.<br/><br/>
        `CREATE SCHEMA purchases;`<br/><br/>`CREATE SCHEMA dispatches;`<br/><br/>`CREATE SCHEMA closingstock;`<br/><br/>
        
### Connect a Siddhi application to data stores

In this section, let's learn the different ways in which you can connect a Siddhi application to a data store.

In Streaming Integrator Tooling, open a new file and start creating a new  Siddhi Application named `StockManagementApp`.

    ```
    @App:name("StockManagementApp")
    @App:description("Managing Raw Materials")
    ```
    
Now let's connect to the data stores (i.e., databases) you previously created to the Siddhi application. There are three methods in which this can be done. To learn them, let's connect each of the three databases in a different method.
      
#### Connect to a store via a data source

To connect to the `closingstock` database via a data source, follow the steps below:

1. Define a data source in the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file as follows:

    ```
      - name: Stock_DB
        description: The datasource used for stock records
        jndiConfig:
          name: jdbc/closingstock
        definition:
          type: RDBMS
          configuration:
            jdbcUrl: 'jdbc:mysql://localhost:3306/closingstock?useSSL=false'
            username: root
            password: root
            driverClassName: com.mysql.jdbc.Driver
            minIdle: 5
            maxPoolSize: 50
            idleTimeout: 60000
            connectionTestQuery: SELECT 1
            validationTimeout: 30000
            isAutoCommit: false
    ```
   The above data source connects to the `closingstock` database you previously created via the `jdbcUrl` specified.
   
2. Now include the following table definition in the `StockManagementApp` Siddhi application that you started creating.

    ```
    @store(type = 'rdbms', datasource = "Stock_DB")
    @primaryKey('name' )
    define table StockTable (name string, amount double);
    ```
    
    In the above table definition:
    
    - The table has the two attributes `name` and `amount` to match the `closingstock` database you previously created.
    
    - The `@store`annotation specifies the database type as `rdbms` and connects the table to the `Stock_DB` data source you configured. Thus, you are connected to the `closingstock` database via the data source.
    
    - The `@primaryKey` annotation specifies `name` as the primary key of the table, requiring each record in the table to have a unique value for `name`.

#### Refer to an externally defined store

To connect to the `purchases` database via a reference, follow the steps below:

1. In the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file, add a subsection for refs, and then add a ref as shown below:

    ```
    siddhi:
      refs:
        -
          ref:
            name: 'purchases'
            type: 'rdbms'
            properties:
              jdbc.url: "jdbc:mysql://localhost:3306/purchases?useSSL=false"
              username: 'root'
              password: 'root'
              jdbc.driver.name: 'com.mysql.jdbc.Driver'
    ```
   The above reference connects to the `purchases` database that you previously created.
   
2. Now include the following table definition in the `StockManagementApp` Siddhi application.

    ```
    @store(type = 'rdbms', ref = "purchases")
    define table PurchasesTable (timestamp long, name string, amount double);
    ```

#### Configure the data store inline

You can define the data store configuration for the `dispatches` database by adding a table definition in the `StockManagementApp` Siddhi application as follows:

```
@store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/dispatches?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
define table DispatchesTable (timestamp long, name string, amount double);
```
Here, you are configuring the data store configuration in the Siddhi application itself. The Siddhi application connects to the `dispatches` database via the specified JDBC URL.

### Perform CRUD operations via Siddhi queries

In this section, let's complete the `StockManagementApp` Siddhi application by adding the streams and queries to perform CRUD operations.

1. First, let's define the streams that receive information about material purchases and dispatches as follows.

    - For purchases:
    
        ```
        define stream MaterialPurchasesStream (timestamp long, name string, amount double);
        ```
    
    - For dispatches:
    
        ```
        define stream MaterialDispatchesStream (timestamp long, name string, amount double);
        ```
Now let's write Siddhi queries to perform different CRUD operations as follows:

#### Insert records
 
To insert values into `purchases` and `dispatches` databases, let's write two queries as follows:

- For purchases:

    ```
    @info(name = 'Save purchase records')
    from MaterialPurchasesStream 
    select * 
    insert into PurchasesTable;
    ```

- For dispatches:

    ```
    @info(name = 'Save purchase records')
    from MaterialPurchasesStream 
    select * 
    insert into PurchasesTable;
    ```
To try out these queries, simulate events for the streams via the Event Simulator as follows:

1. Save the Siddhi application.

    The complete Siddhi application looks as follows:
    
    ```
    @App:name('StockManagementApp')
    
    @App:description('Managing Raw Materials')
    
    define stream MaterialDispatchesStream (timestamp long, name string, amount double);
    
    define stream MaterialPurchasesStream (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/dispatches?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    define table DispatchesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', ref = "purchases")
    define table PurchasesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', datasource = "Stock_DB")
    @primaryKey("name")
    define table StockTable (name string, amount double);
    
    @info(name = 'Save material dispatch records')
    from MaterialDispatchesStream 
    select * 
    insert into DispatchesTable;
    
    @info(name = 'Save purchase records')
    from MaterialPurchasesStream 
    select * 
    insert into PurchasesTable;
    ```

    Then start it by clicking the play icon for it in the top panel.   
       
2. Click the **Event Simulator** icon to open the event simulator.

    ![Event Simulation icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/event-simulation-icon.png)
    
    It opens the left panel for event simulation as follows.
    
    ![Event Simulation Panel]({{base_path}}/assets/img/streaming//testing-siddhi-applications/event-simulation-panel.png)
    
3. To simulate purchase events, select `StockManagementApp` for the **Siddhi App Name** field, and `MaterialPurchasesStream` for the **Stream Name** field.

    Then enter values for the attribute fields as follows and click **Send**.        
    
    | **timestamp**   | **name** | **amount** |
    |-----------------|----------|------------|
    | `1608023646000` | `honey`  | `150`      |        
        
4. To simulate an event for material dispatches, select `StockManagementApp` for the **Siddhi App Name** field, and `MaterialDispatchesStream` for the **Stream Name** field. 

    Then enter values for the attribute fields as follows and click **Send**.  
    
    | **timestamp**   | **name** | **amount**|
    |-----------------|----------|-----------|
    | `1608023646000` | `honey`  | `100`     |        
        
5. To check whether the above insertions were successful, issue the following MySQL commands in the terminal in which you are running the MySQL server.

    - For the `purchases` database:
    
        ```
        use purchases;
        ```
      
        ```
        select * from PurchasesTable;
        ```
      
      The following table is displayed.
      
      ![Saved Purchase Records]({{base_path}}/assets/img/streaming/integrating-stores/saved-purchase-records.png)
    
    - For the `dispatches` database:
    
        ```
        use dispatches;
        ```
      
        ```
        select * from DispatchesTable;
        ```
      
      The following table is displayed.
    
      ![Saved Dispatch Records]({{base_path}}/assets/img/streaming/integrating-stores/saved-dispatch-records.png)
         
#### Retrieve Records
 
Assume that the Factory Manager needs to view all the purchase records for honey. This can be done by following the steps below:

1. To receive the record retrieval requests as input events, define an input stream as follows:

    ```
    define stream PurchaseRecordRetrievalStream (name string);
    ```
   
   This stream only has the `name` attribute because only the name is needed to filter the search results

2. To present the retrieved records, define an output stream as follows:

    ```text
    @sink(type = 'log', prefix = "Search Results",
        @map(type = 'passThrough'))
    define stream SearchResultsStream (timestamp long, name string, amount double);
    ```

    The `SearchResultsStream` output stream has all the attributes of the `PurchasesTable` table to retrieve the complete record. Also, the `@sink` annotation connects this stream to a log sink so that the search results can be logged.
    
3. Now lets add a join query to join the `PurchaseRecordRetrievalStream` and the `PurchasesTable` table.

    ```
    @info(name = 'Retrieve purchase records')
    from PurchaseRecordRetrievalStream as s 
    join PurchasesTable as p 
        on s.name == p.name 
    select p.timestamp as timestamp, s.name as name, p.amount as amount 
        group by p.name 
    insert into SearchResultsStream;
    ```
   
   Note the following about the above join query.
   
   - The stream is assigned the short name `s` and the table is assigned the short name `p`.
   
   - Based on the previous point, `on s.name == p.name ` condition specifies that a matching event is identified when the `PurchasesTable` has a record where the value for the `name` attribute is the same as that of the stream.
   
   - The `select` clause the query specifies that when such a matching event is identified, attribute values for the output event should be selected as follows:
   
        - The timestamp from the table
        - The name from the stream
        - The amount from the table
        
   - The `insert into` clause specifies that the output events derived as stated above should be inserted into the `SearchResultsStream`.
   
4. Save the Siddhi application. The complete Siddhi application after the above changes looks as follows:

    ```
    @App:name('StockManagementApp')
    @App:description('Managing Raw Materials')
    
    define stream MaterialDispatchesStream (timestamp long, name string, amount double);
    
    @sink(type = 'log', prefix = "Search Results",
        @map(type = 'passThrough'))
    define stream SearchResultsStream (timestamp long, name string, amount double);
    
    define stream MaterialPurchasesStream (timestamp long, name string, amount double);
    
    define stream PurchaseRecordRetrievalStream (name string);
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/dispatches?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    define table DispatchesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', ref = "purchases")
    define table PurchasesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', datasource = "Stock_DB")
    @primaryKey("name")
    define table StockTable (name string, amount double);
    
    @info(name = 'Save material dispatch records')
    from MaterialDispatchesStream 
    select * 
    insert into DispatchesTable;
    
    @info(name = 'Save purchase records')
    from MaterialPurchasesStream 
    select * 
    insert into PurchasesTable;
    
    @info(name = 'Retrieve purchase records')
    from PurchaseRecordRetrievalStream as s 
    join PurchasesTable as p 
        on s.name == p.name 
    select p.timestamp as timestamp, s.name as name, p.amount as amount 
        group by p.name 
    insert into SearchResultsStream;
    ```
5. Open the Event Simulator and simulate an event for the `PurchaseRecordRetrievalStream` stream of the `StockManagementApp` Siddhi application with `honey` as the value for the **name** attribute.

    The following is logged in the terminal.
    
    ![Retrieved Event]({{base_path}}/assets/img/streaming/integrating-stores/retrieved-event.png)
        
#### Update or insert records
 
The `Stock Table` table at any given time contains a single record per product, showing the current closing stock for the relevant product. When you send a new event reporting a stock value to the table, the outcome is one of the following:

- If a record with the same value for `name` already exists, the event updates the value for the `amount` attribute in that record.
- If a record with the same value for `name` does not exist, the new event is inserted into the table as a new record.

To try this, follow the steps below:

1. Add a new stream as follows:

    ```
    define stream LatestStockStream (name string, amount double);
    ```
   
2. Now add a query to update or insert values into the `StockTable` stream as follows:

    ```
    @info(name = 'Update or Record Stock')
    from LatestStockStream
    select name, amount
    update or insert into StockTable
     set LatestStockStream.amount = amount
     on StockTable.name == name 
    ```
    
    Here, the Streaming Integrator checks whether an event in the `LatestStockStream` has a matching record in the `StockTable` table where the value for the `name` attribute is the same. If such a record exists, the value for the `amount` attribute in that record is set to the amount reported via the stream event. If no matching event exists, the stream event is inserted as a new event
     
3. Save the Siddhi application. The complete Siddhi application is as follows:

    ```
    @App:name('StockManagementApp')
    
    @App:description('Managing Raw Materials')
    
    define stream MaterialDispatchesStream (timestamp long, name string, amount double);
    
    @sink(type = 'log', prefix = "Search Results",
        @map(type = 'passThrough'))
    define stream SearchResultsStream (timestamp long, name string, amount double);
    
    define stream MaterialPurchasesStream (timestamp long, name string, amount double);
    
    define stream PurchaseRecordRetrievalStream (name string);
    
    define stream LatestStockStream (name string, amount double);
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/dispatches?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    define table DispatchesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', ref = "purchases")
    define table PurchasesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', datasource = "Stock_DB")
    @primaryKey("name")
    define table StockTable (name string, amount double);
    
    @info(name = 'Save material dispatch records')
    from MaterialDispatchesStream 
    select * 
    insert into DispatchesTable;
    
    @info(name = 'Save purchase records')
    from MaterialPurchasesStream 
    select * 
    insert into PurchasesTable;
    
    
    @info(name = 'Retrieve purchase records')
    from PurchaseRecordRetrievalStream as s 
    join PurchasesTable as p 
        on s.name == p.name 
    select p.timestamp as timestamp, s.name as name, p.amount as amount 
        group by p.name 
    insert into SearchResultsStream;
    
    @info(name = ''Update or Record Stock'')
    from LatestStockStream
    select name, amount
    update or insert into StockTable
     set LatestStockStream.amount = amount
     on StockTable.name == name 
    ```
   
4. Simulate events as follows:

    1. In the event simulator, select **StockManagementApp** for the **Siddhi App Name** field, and select **LatestStockStream** for the **Stream Name** field.
    
    2. Enter the following values for the attribute fields and send the event.
    
        | **name** | **amount**|
        |----------|-----------|
        | `flour`  | `150`     | 
        
    3. Execute the following MySQL queries:
     
        ```
        use closing stock
        ``` 

        ```
        select * from StockTable
        ``` 
       
        The following is  displayed.
        
        ![Saved Stock Records]({{base_path}}/assets/img/streaming/integrating-stores/saved-stock-records.png)
        
        Here, the single record displayed is the event you sent. This event is inserted as a new record because the `StockTable` table did not have any records.
       
    4. Now simulate another event for the same stream with the following attribute values:
    
        | **name** | **amount**|
        |----------|-----------|
        | `flour`  | `200`     | 
       
    5. Execute the following MySQL queries:
                
        ```
        use closing stock
        ``` 
        
        ```
        select * from StockTable
        ``` 
        
        The following is  displayed.
        
        ![Updated Stock Records]({{base_path}}/assets/img/streaming/integrating-stores/updated-stock-records.png)
        
        Again, a single record  is displayed. Although value for the `name` attribute is the same, the value for the `amount` attribute has been updated from `150` to `200`. This is because `name` is the primary key of the `StockTable` table and at any given time, there can be only one record with a specific name for the `name` attribute. Therefore, because you simulated two events with the same value for the `name` attribute, the second event updated the first one.
    
#### Update records
 
To update the `StockTable` table via streams, follow the steps below:

1. Add a new stream as follows:

    ```
    define stream UpdateStockStream (name string, amount double);
    ```
   
2. Now add a query to update the values in the `StockTable` stream as follows:

    ```
    @info(name = 'Update Stock')
    from UpdateStockStream
    select name, amount
    update StockTable
     set UpdateStockStream.amount = amount
     on StockTable.name == name;
    ```
    Here, the Streaming Integrator checks whether an event in the `UpdateStockStream` has a matching record in the `StockTable` table where the value for the `name` attribute is the same. If such a record exists, the value for the `amount` attribute in that record is set to the amount reported via the stream event.
    
3. Save the Siddhi application. The complete Siddhi application is as follows:

    ```
    @App:name('StockManagementApp')
    
    @App:description('Managing Raw Materials')
    
    define stream MaterialDispatchesStream (timestamp long, name string, amount double);
    
    @sink(type = 'log', prefix = "Search Results",
        @map(type = 'passThrough'))
    define stream SearchResultsStream (timestamp long, name string, amount double);
    
    define stream MaterialPurchasesStream (timestamp long, name string, amount double);
    
    define stream PurchaseRecordRetrievalStream (name string);
    
    define stream LatestStockStream (name string, amount double);
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/dispatches?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    define table DispatchesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', ref = "purchases")
    define table PurchasesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', datasource = "Stock_DB")
    @primaryKey("name")
    define table StockTable (name string, amount double);
    
    @info(name = 'Save material dispatch records')
    from MaterialDispatchesStream 
    select * 
    insert into DispatchesTable;
    
    @info(name = 'Save purchase records')
    from MaterialPurchasesStream 
    select * 
    insert into PurchasesTable;
    
    
    @info(name = 'Retrieve purchase records')
    from PurchaseRecordRetrievalStream as s 
    join PurchasesTable as p 
        on s.name == p.name 
    select p.timestamp as timestamp, s.name as name, p.amount as amount 
        group by p.name 
    insert into SearchResultsStream;
    
    @info(name = ''Update or Record Stock'')
    from LatestStockStream
    select name, amount
    update or insert into StockTable
     set LatestStockStream.amount = amount
     on StockTable.name == name 
   
    @info(name = 'Update Stock')
    from UpdateStockStream
    select name, amount
    update StockTable
     set UpdateStockStream.amount = amount
     on StockTable.name == name;
    ```
   
4. Simulate events as follows:

    1. In the event simulator, select **StockManagementApp** for the **Siddhi App Name** field, and select **UpdateStockStream** for the **Stream Name** field.
    
    2. Enter the following values for the attribute fields and send the event.
    
        | **name** | **amount**|
        |----------|-----------|
        | `flour`  | `129`     | 
        
    3. Execute the following MySQL queries:
     
        ```
        use closing stock
        ``` 

        ```
        select * from StockTable
        ``` 
       
       The following is  displayed.
       
       ![Saved Stock Records]({{base_path}}/assets/img/streaming/integrating-stores/edited-stock-records.png)
       
       Here, the single record displayed is the event you sent. This event is inserted as a new record because the `StockTable` table did not have any records. 
 
#### Delete records
    
To delete records in the `StockTable` table via streams, follow the steps below:

1. Add a new stream as follows:

    ```
    define stream DeleteStream (name string, amount double);
    ```
   
2. Now add a query to update the values in the `StockTable` stream as follows:

    ```
    @info(name = 'Delete Stock')
    from DeleteStream
    select name, amount
    delete StockTable 
      on StockTable.name == name;
    ```
    Here, the Streaming Integrator checks whether an event in the `DeleteStream` has a matching record in the `StockTable` table where the value for the `name` attribute is the same. If such a record exists, it is deleted.
    
3. Save the Siddhi application. The complete Siddhi application is as follows:

    ```
    @App:name('StockManagementApp')
    
    @App:description('Managing Raw Materials')
    
    define stream MaterialDispatchesStream (timestamp long, name string, amount double);
    
    @sink(type = 'log', prefix = "Search Results",
        @map(type = 'passThrough'))
    define stream SearchResultsStream (timestamp long, name string, amount double);
    
    define stream MaterialPurchasesStream (timestamp long, name string, amount double);
    
    define stream PurchaseRecordRetrievalStream (name string);
    
    define stream LatestStockStream (name string, amount double);
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/dispatches?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    define table DispatchesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', ref = "purchases")
    define table PurchasesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', datasource = "Stock_DB")
    @primaryKey("name")
    define table StockTable (name string, amount double);
    
    @info(name = 'Save material dispatch records')
    from MaterialDispatchesStream 
    select * 
    insert into DispatchesTable;
    
    @info(name = 'Save purchase records')
    from MaterialPurchasesStream 
    select * 
    insert into PurchasesTable;
    
    
    @info(name = 'Retrieve purchase records')
    from PurchaseRecordRetrievalStream as s 
    join PurchasesTable as p 
        on s.name == p.name 
    select p.timestamp as timestamp, s.name as name, p.amount as amount 
        group by p.name 
    insert into SearchResultsStream;
    
    @info(name = ''Update or Record Stock'')
    from LatestStockStream
    select name, amount
    update or insert into StockTable
     set LatestStockStream.amount = amount
     on StockTable.name == name 
   
    @info(name = 'Update Stock')
    from UpdateStockStream
    select name, amount
    update StockTable
     set UpdateStockStream.amount = amount
     on StockTable.name == name;
   
    @info(name = 'Delete Stock')
    from DeleteStream
    select name, amount
    delete StockTable 
      on StockTable.name == name;
    ```
   
4. Simulate events as follows:

    1. In the event simulator, select **StockManagementApp** for the **Siddhi App Name** field, and select **DeleteStream** for the **Stream Name** field.
    
    2. Enter the following values for the attribute fields and send the event.
    
        | **name** | **amount**|
        |----------|-----------|
        | `flour`  | `129`     | 
        
    3. Execute the following MySQL queries:
     
        ```
        use closing stock
        ``` 

        ```
        select * from StockTable
        ``` 
       
       The `StockTable` is displayed as an empty set. This is because the event you sent to the `DeleteStream` stream matched the record in the table, and as a result, the record was deleted by the `Delete Stock` query.
       
### Perform CRUD operations via REST API

In this section, let's perform CRUD operations via the [Store API]({{base_path}}/ref/store-APIs)

#### Insert records

To insert a record into the `StockTable` table, issue the following CURL command:

```
curl -X POST http://localhost:7370/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "StockManagementApp", "query" : "select \"sugar\" as name, 200.0 as amount insert into StockTable;" }' -k
```

Then issue the following commands in the terminal where you are running the MySQL server.

```
use closingstock;
```

```
select * from StockTable;
```

The following is displayed:

![Results for Insert operation]({{base_path}}/assets/img/streaming/integrating-stores/insert-operation-results.png)

#### Retrieve records

To retrieve a record from the `StockTable` table, issue the following CURL command:

```
curl -X POST http://localhost:7370/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "StockManagementApp", "query" : "from StockTable on name == \"sugar\" select name, amount;  " }' -k
```

This returns the following response:

```
{"records":[["sugar",200.0]]
```

#### Update or inserts records

First, let's send an event that has the same value for the `name` attribute as the existing record in the `StockTable` table. To do this, issue the following command:

```
curl -X POST http://localhost:7370/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "StockManagementApp", "query" : "select \"sugar\" as name, 260.0 as amount update or insert into StockTable  set amount = amount  on StockTable.name == name;" }' -k
```

Then issue the following commands in the terminal where you are running the MySQL server.

```
use closingstock;
```

```
select * from StockTable;
```

The following is displayed:

![Results for Insert operation]({{base_path}}/assets/img/streaming/integrating-stores/upsert-operation-results-for-update.png)

Now let's send an event where the value for the `name` attribute is different to that of the existing value in the `StockTable` table as follows:

```
curl -X POST http://localhost:7370/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "StockManagementApp", "query" : "select \"vanilla\" as name, 100.0 as amount update or insert into StockTable  set amount = amount  on StockTable.name == name;" }' -k
```

Then issue the following commands in the terminal where you are running the MySQL server.

```
use closingstock;
```

```
select * from StockTable;
```

The following is displayed:

![Results for Insert operation]({{base_path}}/assets/img/streaming/integrating-stores/upsert-operation-results-for-insert.png)

#### Update records

To update an existing record in the `StockTable` table, issue the following CURL command:

```
curl -X POST http://localhost:7370/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "StockManagementApp", "query" : "select \"vanilla\" as name, 127.0 as amount update StockTable  set amount = amount on StockTable.name == name;" }' -k
```

Then issue the following commands in the terminal where you are running the MySQL server.

```
use closingstock;
```

```
select * from StockTable;
```

The following is displayed:

![Results for Update operation]({{base_path}}/assets/img/streaming/integrating-stores/update-operation-results.png)

#### Delete records

To delete an existing record in the `StockTable` table, issue the following CURL command:

```
curl -X POST http://localhost:7370/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "StockManagementApp", "query" : "select \"vanilla\" as name delete StockTable on StockTable.name == name;" }' -k
```

Then issue the following commands in the terminal where you are running the MySQL server.

```
use closingstock;
```

```
select * from StockTable;
```       

The following is displayed:

![Results for Delete operation]({{base_path}}/assets/img/streaming/integrating-stores/delete-operation-results.png)   

### Manipulate data in stores via SQL queries

You can execute SQL queries via WSO2 Streaming Integrator to manipulate data in data stores. This is supported via the [siddhi-store-rdbms extension](https://siddhi-io.github.io/siddhi-store-rdbms/).

!!! tip "Before you begin:"
    To allow Streaming Integrator Tooling to perform CRUD operations, open `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file, and add an extract as shown below with the `perform.CRUD.operations` parameter set to `true` as shown below:<br/><br/>
        ```
        siddhi:
          extensions:
            -
              extension:
                name: cud
                namespace: rdbms
                properties:
                  perform.CUD.operations: true
        ```<br/><br/>
        
To perform CRUD operations in multiple tables via WSO2 Streaming Integrator, follow the steps below:

To start creating the Siddhi application with the required tables, follow the steps below:

1. In WSO2 Streaming Integrator Tooling, open the `StockManagementApp` that you previously created.

2. Define a new stream in it named `StockStream` as follows.

    `define stream TriggerStream (name string, amount double);`
    
3. Add a query as follows:

    ```
    from TriggerStream#rdbms:cud("Stock_DB", "UPDATE StockTable SET name='sugarsyrup' where name='sugar'")
    select name, amount
    insert into OutputStream
    ```
    This query updates the record in the `StockTable` table where the value for the `name` attribute is `sugar` by changing that same value to `sugarsyrup`.
    
4. Save the Siddhi application. The complete Siddhi application is now as follows:

    ```
    @App:name('StockManagementApp')
    
    define stream MaterialDispatchesStream (timestamp long, name string, amount double);
    
    @sink(type = 'log', prefix = "Search Results",
    	@map(type = 'passThrough'))
    define stream SearchResultsStream (timestamp long, name string, amount double);
    
    define stream MaterialPurchasesStream (timestamp long, name string, amount double);
    
    define stream PurchaseRecordRetrievalStream (name string);
    
    define stream LatestStockStream (name string, amount double);
    
    define stream UpdateStockStream (name string, amount double);
    
    define stream DeleteStream (name string, amount double);
    
    define stream TriggerStream (name string, amount double);
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/dispatches?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    define table DispatchesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', ref = "purchases")
    define table PurchasesTable (timestamp long, name string, amount double);
    
    @store(type = 'rdbms', datasource = "Stock_DB")
    @primaryKey("name")
    define table StockTable (name string, amount double);
    
    @info(name = 'Save material dispatch records')
    from MaterialDispatchesStream 
    select * 
    insert into DispatchesTable;
    
    @info(name = 'Save purchase records')
    from MaterialPurchasesStream 
    select * 
    insert into PurchasesTable;
    
    
    @info(name = 'Retrieve purchase records')
    from PurchaseRecordRetrievalStream as s 
    join PurchasesTable as p 
    	on s.name == p.name 
    select p.timestamp as timestamp, s.name as name, p.amount as amount 
    	group by p.name 
    insert into SearchResultsStream;
    
    @info(name = 'Update or Record Stock')
    from LatestStockStream
    select name, amount
    update or insert into StockTable
     set LatestStockStream.amount = amount
     on StockTable.name == name;
     
    @info(name = 'Update Stock')
    from UpdateStockStream
    select name, amount
    update StockTable
     set UpdateStockStream.amount = amount
     on StockTable.name == name;
     
    @info(name = 'Delete Stock')
    from DeleteStream
    select name, amount
    delete StockTable 
      on StockTable.name == name;
      
    from TriggerStream#rdbms:cud("Stock_DB", "UPDATE StockTable SET name='sugarsyrup' where name='sugar'")
    select name, amount
    insert into OutputStream
    ```
    
5. Simulate an event for the `TriggerStream` stream of the `StockManagementApp` Siddhi application. You can enter any values of your choice as the attribute values.

6. To check the database table, issue the following MySQL commands.

    ```
    use closingstock;
    ```
   
    ```
    select * from StockTable;
    ```
   
   The following is displayed:
   
   ![Updated Stock]({{base_path}}/assets/img/streaming/integrating-stores/updated-table-after-sql-query.png)
