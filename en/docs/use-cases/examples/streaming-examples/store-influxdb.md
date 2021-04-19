# Working with an influxDB Store

## Purpose:
This application demostrates how to perform InfluxDB operations using Siddhi queries.The following streams can be used to insert, search, delete, and update or insert  data into the InfluxDB store.  
insert - insertStream,stockStream  
delete - deleteStream  
search - searchStream  
update or insert - updateStream  
contains - containStream (verifies whether all the attributes that enter in the stream exists in the store).

## Prerequisites:
1. Ensure that InfluxDB is installed in your machine (https://portal.influxdata.com/downloads/)
2. Create a database named 'aTimeSeries' in InfluxDB. Replace influxdb.database in store configuration of this application with this database name.
3. In the store configuration of this application, replace username and password with your influxDB credentials.
4. Save this sample.

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following message is shown on the console,
    * store-influxdb.siddhi - Started Successfully!
## Note:
If you want to edit this application while it's running, stop the application, make your edits and save the application, and then start it again.

## Testing the Sample :
1. Simulate single events:
    1. Click on 'Event Simulator' (double arrows on left tab) and click 'Single Simulation'
    2. Select 'store-influxdb' as 'Siddhi App Name' and select 'insertStream' as 'Stream Name'.
    3. Provide attribute values, and then click send.
2. Send events to the other corresponding streams to delete, update or insert, and  search events.

## Notes: 
After a change in the store, you can use the search stream to see whether the operation is successful.

## Viewing the Results :
You can use searchStream to check for inserted,deleted, and updated events.
See the console for output events for searchStream.


```sql
@App:name("store-influxdb")
@App:description("Perform inserting,deleting,updating Or inserting and reading events from influxDB store")


define stream stockStream (symbol string,volume long,price float,time long);
define stream insertStream(symbol string,volume long,price float);
define stream deleteStream(symbol string);
define stream updateStream(symbol string,volume long,price float,time long);
define stream searchStream(symbols string);
define stream containStream(name string,value long);

@sink (type='log') 
define stream OutputStream (checkName string, checkCategory float, checkVolume long,checkTime long);

@sink (type='log')
define stream logStream(name string,value long);

@Store (type = "influxdb",
       url = "http://localhost:8086",
       username = "root",
       password = "root" ,
       influxdb.database ="aTimeSeries")
@Index("time","symbol")
define table StockTable(symbol string,volume long,price float,time long) ;    

/* Inserting event into influxDB store */
@info(name='query0')
from insertStream
select symbol,volume,price,currentTimeMillis() as time
insert into StockTable;

/* Inserting event into influxDB store */
@info(name = 'query1')  
from stockStream 
select symbol,  volume, price, time
insert into StockTable ;  
 
 /* deleting events from influxDB store */
@info(name= 'query2') 
from deleteStream 
delete StockTable on StockTable.symbol==symbol;

/* Inserting or updating event into influxDB store */
@info(name='query3')
from updateStream#window.timeBatch(1 sec)  
update or insert into StockTable 
on StockTable.symbol==symbol and StockTable.time==time;
 
 /* Reading events from influxDB store */
 @info(name = 'query4')
from searchStream#window.length(1) join StockTable on StockTable.symbol==symbols 
select StockTable.symbol as checkName, StockTable.price as checkCategory,
StockTable.volume as checkVolume,StockTable.time as checkTime
insert into OutputStream;

/* Siddhi In in influxDB store */
@info(name = 'query6')
from containStream 
[(StockTable.symbol == name) in StockTable]
insert into logStream;
```