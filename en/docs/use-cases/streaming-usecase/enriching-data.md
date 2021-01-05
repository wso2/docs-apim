# Enriching Data

Enriching data involves integrated the data received into a streaming integration flow with data from other medium such as a data store, another data stream, or an external service to derive an expected result.

## Integrating data streams and static data

This involves enriching a data stream by joining it with a data store.

For example, consider a scenario where a sweet factory reports its production data in a streaming manner after each run. To update the stock with the latest amount produced, you need to add the latest production amounts to the stock amounts saved in a database.

To address this, you can write a query as follows.

```
from ProductionStream as p 
join StocksTable as s 
	on p.name == s.name 
select p.name as name, sum(p.amount) + s.amount as amount 
	group by p.name 
insert into UpdateStockwithProductionStream;
```

Here, the `ProductionStream` stream that has the production amounts for sweets after each production run is assigned the short name `p`. The `StocksTable` that has the current stock for each product before the latest production runs is given the short name `s`. This allows you to uniquely identify the attributes in each. The matching condition is `p.name == s.name `, which means that a match is identified when an event in the `ProductionStream` stream has the same value for the `name` attribute as a record in the `StockTable` table. 
`sum(p.amount)` calculates the total production per product. This total production amount for a product is then added to the stock amount of the product (i.e., `s.amount`). The resulting output is inserted into the `UpdateStockwithProductionStream` stream.

## Integrating multiple data streams

This involves enriching a data stream by joining it with another data stream.

To understand this, consider the example you used in the previous [Integrating data streams and static data section](#integrating-data-streams-and-static-data) where you directed the stock amounts updated with the latest production amounts into a stream. Assume another stream reports the sale of stock in a streaming manner. To further update the stock by deducting the amounts sold, you need to join the data stream that has the latest stock amounts with the data stream that has the sales amounts.

To address the above requirement, you can write a query as follows.

```text
from UpdateStockwithProductionStream as u 
join SalesStream as s 
	on u.name == s.name 
select u.name as name, sum(u.amount) - sum(s.amount) as amount 
insert into LatestStockStream;
```

Here, `u` is the short name for the `UpdateStockwithProductionStream` stream that has the total stock amounts for each product updated with the latest production amounts. `s` is the short name for the `SalesStream` stream that reports the sales for all the products in a streaming manner. Matching events are the events with the same value for the `name` attribute.
To calculate the latest stock amount for each product, the total sales amount is deducted from the total stock amount updated with production amounts. The resulting output is inserted into the `LatestStockStream`.

## Integrating data streams with external services

This involves enriching a data stream by incorporating information received from an external service to it.

To understand this, consider that in order to value the stock, a Sweet Factory obtains the value of one unit of a product from an external application named `StockValuingApp`. When you submit the name of the product, it returns the unit value. To value the stock based on this information, you can create a Siddhi application as follows:

```
@App:name("StockValuingApp")

@sink(type='http-request',publisher.url='http://localhost:5005/CheckProductValueEP',method='POST', headers="'Content-Type:application/x-www-form-urlencoded'",
sink.id="unitvalueSink",
@map(type='keyvalue', @payload(Sweet='{{name}}')))
define stream CheckUnitValueStream (name string);

@source(type='http-response' ,sink.id='unitvalueSink',    
@map(type='xml', namespaces = "xmlns=http://localhost:5005/CheckProductValueEP/",    
@attributes(name = 'trp:name',unitValue = ".")))        
define stream StoreUnitValueStream (name string,unitValue double);

from StoreUnitValueStream
select *
update or insert into ProductValueTable;
```

In the above application, events in the `CheckUnitValueStream` stream are published to the `http://localhost:5005/CheckProductValueEP` URL via the connected `http-request` sink to invoke a service that returns the unit value for the name of the product sent. WSO2 Streaming Integrator captures this response (i.e., unit value) in the `StoreUnitValueStream` stream via the `http-response` source connected to the stream. In orcder to allow WSO2 Streaming Integrator to identify the response as the result of the request it previously sent, the same value is specified for the `sink.id` parameter in both the source configuration and the sink configuration.
To store the unit values obtained for further processing, all the events in the `StoreUnitValueStream` stream are inserted into a table named `ProductValueTable`.

## Enriching data with built-in extensions

The following is a list of Siddhi extensions with which you can enrich data.

 - [Siddhi-execution-streamingml](https://siddhi-io.github.io/siddhi-execution-streamingml/)
 - [Siddhi-execution-env](https://wso2-extensions.github.io/siddhi-execution-env/)
 - [Siddhi-execution-math](https://wso2-extensions.github.io/siddhi-execution-math/)
 - [Siddhi-execution-string](https://siddhi-io.github.io/siddhi-execution-string/)
 - [Siddhi-execution-time](https://siddhi-io.github.io/siddhi-execution-time/)
 - [Siddhi-execution-json](https://siddhi-io.github.io/siddhi-execution-json/)

## Try it out

To try out the examples given above, follow the steps below.

1. Set up your database as follows:

    1. Download and install MySQL. Then start the MySQL server and create a new database in it by issuing the following command:
    
        `CREATE SCHEMA stock;`
        
    2. Create a table in the `stock` database you created by issuing the following two commands.
    
        `use stock;`
        
        `CREATE TABLE StockTable (name VARCHAR(20),amount double(10,2));`
    
    3. Insert two records into the `StockTable` you created by issuing the following commands.
    
        `insert into StockTable values('gingerbread',8.0);`
        
        `insert into StockTable values('coffee cake',6.0);`   
    
    4. Then open the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file and add the following data source configuration under `datasources`.
    
        ```
          - name: Stock_DB
            description: The datasource used for Stock Valuation
            jndiConfig:
              name: jdbc/stock
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:mysql://localhost:3306/stock?useSSL=false'
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
    
2. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

3. Open a new file in Streaming Integrator Tooling. Then add and save the following Siddhi application.

    ```
    @App:name('StockValuingApp')
    @App:description('Description of the plan')
    
    define stream ProductionStream (name string, amount double);
    
    @source(type = 'http-response', sink.id = "unitvalueSink",
    	@map(type = 'xml', namespaces = "xmlns=http://localhost:5005/CheckProductValueEP/",
    		@attributes(name = "trp:name", unitValue = ".")))
    define stream GetUnitValueStream (name string, unitValue double);
    
    @sink(type = 'log', prefix = "Stock Update After Production",
    	@map(type = 'text'))
    
    define stream UpdateStockwithProductionStream (name string, amount double);
    
    define stream SalesStream (name string, amount double);
    
    @sink(type = 'http-request', publisher.url = "http://localhost:5005/CheckProductValueEP", method = "POST", headers = "'Content-Type:application/x-www-form-urlencoded'", sink.id = "unitvalueSink",
    	@map(type = 'keyvalue'))
    define stream CheckUnitValueStream (name string);
    
    @sink(type = 'log', prefix = "Latest Stock",
    	@map(type = 'text'))
    define stream LatestStockStream (name string, amount double);
    
    @sink(type = 'log', prefix = "Stock Value",
    	@map(type = 'text'))
    define stream StockValueStream (name string, value double);
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/stock?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    @primaryKey("name")
    define table StockTable (name string, amount double);
    
    @info(name = 'UpdateStockwithProduction')
    from ProductionStream as p 
    join StockTable as s 
    	on p.name == s.name 
    select p.name as name, sum(p.amount) + s.amount as amount 
    	group by p.name 
    insert into UpdateStockwithProductionStream;
    
    @info(name='UpdateStockwithSales') 
    from UpdateStockwithProductionStream#window.time(5 min) as u 
    join SalesStream as s 
    	on u.name == s.name 
    select u.name as name, sum(u.amount) - sum(s.amount) as amount 
    insert into LatestStockStream;
    
    
    @info(name='CalculateStockValue') 
    from LatestStockStream as l 
    join GetUnitValueStream as g 
    	on l.name == g.name 
    select l.name as name, g.unitValue * l.amount as value 
    insert into StockValueStream;  
    ```
   
   The above Siddhi application does the following:
   
   1. Updates the stock amount for each product by adding the total production amount to the stock amount. This is done by joining the `StockTable` table with the `ProductionStream` stream. Then it logs the result with the `Stock Update After Production` prefix.
   
   2. Calculates the latest stock by deducting the total sales for a product from the updated stock derived by adding the total production amount with the current stock amount. This is done by joining the `UpdateStockwithProductionStream` stream with the `SalesStream` stream. The result is logged with the `Latest Stock` prefix.
   
   3. Sends requests with the product name to an external service with the `http://localhost:5005/CheckProductValueEP` endpoint and receives the unit value of the submitted product name as a response. This response is captured in the `GetUnitValueStream` stream.
   
   4. Calculates the stock value by multiplying the latest stock with the unit value obtained from the external service. This is done by joining the `GetUnitValueStream` stream with the `LatestStockStream` stream. The result is then logges with the `Stock Value` prefix.
   
4. In Streaming Integrator Tooling, create a new Siddhi application as follows, save it, and then start it.

    ```
    @App:name('ReturnUnitValueApp')
    
    @source(type='http-service' , source.id='unitValue', receiver.url='http://localhost:5005/CheckProductValueEP/',
        @map(type = 'json')) 
    define stream RequestStream (name string);
    
    @sink(type='http-service-response', source.id='unitValue',
          message.id='{{name}}', @map(type = 'json'))
    define stream ResultStream (name string, unitValue double);
    
    from RequestStream
    select name, ifThenElse(name == 'gingerbread', 10.0, 20.0) as unitValue
    insert into ResultStream;
    ```
    This application functions as the external service for testing purposes.
    
5. Simulate events for the `StockValuingApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).

    1. First, simulate two events for the `ProductionStream` stream with the following values.
    
        | **Name**      | **Amount** |
        |---------------|------------|
        | `gingerbread` | `10`       |
        | `coffee cake` | `10`       |
        
        As a result, the following logs appear in the terminal.
        
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Stock Update After Production : name:"gingerbread",
        amount:18.0 (Encoded) 
        ```
       
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Stock Update After Production : name:"coffee cake",
        amount:16.0 (Encoded) 
        ```
       
       Here, the `StockUpdateAfterProduction` value is calculated by adding the production value to the stock value saved in the database.
       
    2. Now simulate the following two events to the `SalesStream` stream.
    
        | **Name**      | **Amount** |
        |---------------|------------|
        | `gingerbread` | `12`       |
        | `coffee cake` | `13`       |
        
        As a result, the following logs appear in the terminal.
        
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Latest Stock : name:"gingerbread",
        amount:6.0 (Encoded) 
        ```
       
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Latest Stock : name:"coffee cake",
        amount:3.0 (Encoded) 
        ```
       
    3. Now simulate two events to the `CheckUnitValueStream` stream. Enter `gingerbread` and `coffee cake` as the `name` for the first and the second event respectively.
    
        As a result, the following logs appear in the terminal.
                
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Stock Value : name:"gingerbread",
        value:60.0 (Encoded) 
        ```
       
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Stock Value : name:"coffee cake",
        value:60.0 (Encoded) 
        ```