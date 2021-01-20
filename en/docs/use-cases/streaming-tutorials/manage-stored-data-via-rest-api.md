# Manage Stored Data via Rest API

## Introduction 

The Siddhi Store Query API is the REST API exposed by the Streaming Integrator (SI) in order to perform actions on the stored data. 

Stored data includes,
- Siddhi Stores
- Siddhi Aggregations
- Siddhi Windows,
    that you have defined in Siddhi applications. 

You can perform actions such as,
- inserting
- searching
- updating
- deleting on those stored data, using the Rest API. 

For a comprehensive reference on the Siddhi query API, see [Streaming Integration REST API Guide](https://ei.docs.wso2.com/en/next/streaming-integrator/ref/si-rest-api-guide/).

This tutorial demonstrates how you can use the Siddhi Store Query API to perform a few essential operations in SI, using simple examples.

## Preparing the server

!!!tip"Before you begin:"
    - You need to have access to a MySQL instance.<br/>
    - Save the MySQL JDBC driver in the `<SI_HOME>/lib` directory as follows:
      1. Download the MySQL JDBC driver from [the MySQL site](https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz).
      2. Unzip the archive.
      3. Copy the `mysql-connector-java-5.1.45-bin.jar` to the `<SI_HOME>/lib` directory.
      4. Start the SI server.

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
    
## Managing Siddhi Store Data

#### Preparing an RDBMS Store

First let's create a Siddhi application with an RDBMS Store so that we can try out certain operations on it. 

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

2. Save this file as `SweetProduction-Store.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

### Inserting records

To insert a record into the `SweetProductionTable`, execute following `CURL` command:
```
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "select \"Almond cookie\" as name, 100.0 as amount insert into SweetProductionTable;" }' -k
```
On successful execution of the command, you will get following response on the terminal:
```
{"records":[]}
```
            
Let's insert a few more records by executing following `CURL` command:
```
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "select \"Baked alaska\" as name, 20.0 as amount insert into SweetProductionTable;" }' -k
```
```
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "select \"Cup cake\" as name, 30.0 as amount insert into SweetProductionTable;" }' -k
```   
```
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "select \"Doughnut\" as name, 500.0 as amount insert into SweetProductionTable;" }' -k
```   

    !!!info
        Above `CURL` commands, insert the following records into the `SweetProductionTable` table. In the next section, we will retrieve these record from the table.
            +---------------+--------+
            | name          | amount |
            +---------------+--------+
            | Almond cookie | 100.00 |
            +---------------+--------+
            | Baked alaska  |  20.00 |
            +---------------+--------+
            | Cup cake      |  30.00 |
            +---------------+--------+
            | Doughnut      | 500.00 |
            +---------------+--------+                             

### Searching records

To obtain all of the records from the `SweetProductionTable`, execute following `CURL` command:

```
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "from SweetProductionTable select name, amount; " }' -k
```
On successful execution of the command, you will get following response on the terminal:
```
{"records":[["Almond cookie",100.0],["Baked alaska",20.0],["Cup cake",30.0],["Doughnut",500.0]]}
```

Now let's obtain all of the records which has `amount` greater than `25` and order those by `amount`. 
```
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "from SweetProductionTable on amount > 25 select name, amount order by amount; " }' -k
```
On successful execution of the command, you will get following response on the terminal:
```
{"records":[["Cup cake",30.0],["Almond cookie",100.0],["Doughnut",500.0]]}
```

To get the top two records from above ouput, let's use the `limit` condition on the Store Query:
```
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "from SweetProductionTable on amount > 25 select name, amount order by amount limit 2; " }' -k
```
On successful execution of the command, you will get following response on the terminal:
```
{"records":[["Cup cake",30.0],["Almond cookie",100.0]]}
```

    !!! info
        For more information on search queries, refer [Store APIs: Streaming Integration REST API Guide](https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/si-rest-api-guide/#store-apis).

### Updating records 

Now let's update the following record in the `SweetProductionTable`. We will set the `name` to `Almond Cookie` and `amount` to `150.0`.
```
            +---------------+--------+
            | name          | amount |
            +---------------+--------+
            | Almond cookie | 100.00 |
            +---------------+--------+
```
In order to update above record, execute following `CURL` command:
```
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "select \"Almond Cookie\" as name, 150.0 as amount update or insert into SweetProductionTable  set SweetProductionTable.name = name, SweetProductionTable.amount = amount  on SweetProductionTable.name == \"Almond cookie\";"}' -k
```
On successful execution of the command, you will get following response on the terminal:
```
{"records":[]}
```
    !!! tip
        To verify whether the update is successful, you can execute following `CURL` command:
        ```
        curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "from SweetProductionTable select name, amount; " }' -k
        ```
        On successful execution of the command, you will get following response on the terminal:
        ```
        {"records":[["Almond Cookie",150.0],["Baked alaska",20.0],["Cup cake",30.0],["Doughnut",500.0]]}
        ```
        Notice that the `["Almond cookie",100.0]` has being changed to `["Almond Cookie",150.0]` 

### Deleting records
    
Let's delete the entry `["Almond Cookie",150.0]` from the `SweetProductionTable` by executing following `CURL` command:
```
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "select 150.0 as amount delete SweetProductionTable on SweetProductionTable.amount == amount;" }' -k
```
On successful execution of the command, you will get following response on the terminal:
```
{"records":[]}
```
    !!! tip
        To verify whether the delete is successful, you can execute following `CURL` command:
        ```
        curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Store", "query" : "from SweetProductionTable select name, amount; " }' -k
        ```
        On successful execution of the command, you will get following response on the terminal:
        ```
        {"records":[["Baked alaska",20.0],["Cup cake",30.0],["Doughnut",500.0]]}
        ```
        Notice that the `["Almond Cookie",150.0]` record has being deleted. 
    
    
## Managing Data in a Siddhi Aggregation

First let's create a Siddhi application with an Aggregation, so that we can try out search operations on it later. 

1. Open a text file and copy-paste following application to it.

    ```
    @App:name("AggregateDataIncrementally")
    
    @App:description('Aggregates values every second until year and gets statistics')
    
    @Source(type = 'http', receiver.url='http://localhost:8006/rawMaterialStream', basic.auth.enabled='false',
        @map(type='json'))
    define stream RawMaterialStream (name string, amount double);
    
    @store( type="rdbms",
            jdbc.url="jdbc:mysql://localhost:3306/production?useSSL=false",
            username="wso2si",
            password="wso2" ,
            jdbc.driver.name="com.mysql.jdbc.Driver")
    define aggregation RawMaterialAggregation
    from RawMaterialStream
    select name, avg(amount) as avgAmount, sum(amount) as totalAmount
    group by name
    aggregate every sec...year;
    ```

    Here the `jdbc.url` parameter has the value `jdbc:mysql://localhost:3306/production?useSSL=false`. Change it to point to your MySQL server. Similarly change `username` and `password` parameters as well.

2. Save this file as `AggregateDataIncrementally.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

3. Let's insert a few records into the `RawMaterialStream` so that those data will be summarized and you can query for the summary later.

    !!! info
        Unlike RDBMS Stores, you cannot insert records into a Aggregation table straight away. In order to put records, you need to insert data into the event stream which is associated to the Aggregation. In this example, the `RawMaterialAggregation` aggregation table is associated to the event stream 'RawMaterialStream`. Therefore, in order to insert into the aggregation table, you need to insert into the 'RawMaterialStream`.  
 
    Execute following `CURL` command on a terminal: 
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Almond cookie\",\"amount\": 20.5}}"  http://localhost:8006/rawMaterialStream --header "Content-Type:application/json"
    ```
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Almond cookie\",\"amount\": 100.0}}"  http://localhost:8006/rawMaterialStream --header "Content-Type:application/json"
    ```
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Almond cookie\",\"amount\": 30.0}}"  http://localhost:8006/rawMaterialStream --header "Content-Type:application/json"
    ```

4. Now let's use the Store Query API, in order to find out the average and total amount of `Almond cookie` productions. 

    Issue following `CURL` command on the terminal:
    ```
    curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "AggregateDataIncrementally", "query" : "from RawMaterialAggregation on name==\"Almond cookie\" within \"2019-**-** **:**:** +05:30\" per \"hours\" select AGG_TIMESTAMP, name, avgAmount, totalAmount" }' -k
    ```
    !!! info
        Above, you have executed following Store Query:
        ```
        from RawMaterialAggregation on name=="Almond cookie" 
        within "2019-**-** **:**:** +05:30" 
        per "hours" 
        select AGG_TIMESTAMP, name, avgAmount, totalAmount" 
        ```
        This query retrieves the average and total `Almond cookie` productions happened within the year `2019`. The average and total is calculated for every hour.   

5. You will get following response:
    ```
    {"records":[[1571234400000,"Almond cookie",50.166666666666664,150.5]]}
    ```
    !!! info
        The value `1571234400000` indicates the Unix timestamp for which the result set belong. In this example, the result set belongs to `October 16, 2019 7:30:00 PM GMT+05:30`. 
        `50.166666666666664` is the average amount of `Almond cookie` productions happened within the hour, while `150.5` is the total amount of `Almond cookie` productions happened within the hour.  
    
## Managing Data in a Siddhi Window

Let's create a Siddhi application with a Window and then query the status of the Window, using a Store query. 

1. Open a text file and copy-paste following application to it.

    ```
    @App:name("SweetProduction-Window")

    @Source(type = 'http', receiver.url='http://localhost:8008/productionStream', basic.auth.enabled='false',
        @map(type='json'))
    define stream SweetProductionStream (name string, amount double);

    define window LastFourProductions (name string, amount double) lengthBatch(4);

    @sink(type='log')
    define stream LogStream (name string, sumAmount double);

    @info(name = 'query1')
    from SweetProductionStream
    select name, amount
    insert into LastFourProductions;

    @info(name = 'query2')
    from LastFourProductions
    select name,sum(amount) as sumAmount
    insert into LogStream;
    ```
    
!!!info
    The above Siddhi application calculates the sum of last four productions (in batches). The last four productions are retained in the `LastFourProductions` window which is a `lengthBatch` window of size four. `query1` inserts all of the incoming sweet productions into the `LastFourProductions` window. `query2` calculates the sum of the batch of four productions, within the window. 
    
2. Save this file as `SweetProduction-Window.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

3. Let's insert four events into `SweetProductionStream`. Execute following `CURL` commands on the terminal:
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Almond cookie\",\"amount\": 100.0}}"  http://localhost:8008/productionStream --header "Content-Type:application/json"
    ```
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Baked alaska\",\"amount\": 20.0}}"  http://localhost:8008/productionStream --header "Content-Type:application/json"
    ```
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Cup cake\",\"amount\": 300.0}}"  http://localhost:8008/productionStream --header "Content-Type:application/json"
    ```
    ```
    curl -X POST -d "{\"event\": {\"name\":\"Doughnut\",\"amount\": 500.0}}"  http://localhost:8008/productionStream --header "Content-Type:application/json"
    ```
    Once you send the fourth event, a batch of four productions completes; hence the following log appears on the SI console. The log prints the sum of amounts of the four productions.
    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - SweetProduction-Window : LogStream : Event{timestamp=1571675148391, data=[Doughnut, 920.0], isExpired=false}
    ```
    
4. Now, using the Store Query API, you will be querying the contents in the `LastFourProductions` window. 

    Let's select all events in the window by executing following `CURL` command:
    ```
    curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Window", "query" : "from LastFourProductions select *" }' -k
    ``` 
    On successful execution of the command, you get following response on the terminal. The output shows the last four sweet productions. 
    ```
    {"records":[["Almond cookie",100.0],["Baked alaska",20.0],["Cup cake",300.0],["Doughnut",500.0]]}
    ```     
   
5. Next, using the Store Query API, you will be querying for the maximum production amount, among the four productions that are in the `LastFourProductions` window.

    Execute following `CURL` command on the terminal:
    ```
    curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "SweetProduction-Window", "query" : "from LastFourProductions select max(amount) as maxAmount" }' -k
    ```
    On successful execution of the command, you get following response on the terminal. The output shows the maximum amount of the four sweet productions. 
    ```
    {"records":[[500.0]]}
    ```   
