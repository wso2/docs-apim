# Step 6: Handle Errors

The events handled by Siddhi applications can result in errors due to multiple reasons such as errors in the transport, mapping errors, etc. WSO2 Streeaming Integrator allows you to specify how you want such errors to be managed if they occur It provides an error store in which you can store events with errors so that you can later view them, correct the error (i.e., if they are mapping errors) and replay them. For the different types of actions you can take to manage errors, see the [Error Handling Guide]({{base_path}}/use-cases/streaming-usecase/handling-errors).

Let's assume that the foreman of the Sweet Factory in this scenario requires errors to be stored in an error store so that they can be checked and replayed after making a correction.

To implement the above, follow the topics below.

## Configuring the error store

To configure a new error store in which you can store the events with errors, follow the steps below:

1. Start the MySQL server if it is not already started.

2. Create a new database named `siddhierrorstoredb`; by issuing the following command in the MySQL console.

    `mysql> create database siddhierrorstoredb;`
    
3. To switch to the new database, issue the following command.

    `mysql> use siddhierrorstoredb;`
    
4. To enable the error store, open the `<SI_HOME>/conf/server/deployment.yaml` file and add a configuration as follows:

    ```
    error.store:
      enabled: true
      bufferSize: 1024
      dropWhenBufferFull: true
      errorStore: org.wso2.carbon.streaming.integrator.core.siddhi.error.handler.DBErrorStore
      config:
        datasource: SIDDHI_ERROR_STORE_DB
        table: SIDDHI_ERROR_STORE_TABLE
    ```
5. The above configuration refers to a data source named `SIDDHI_ERROR_STORE_DB`. Define this data source as follows under `Data sources` in the `<SI_HOME>/conf/server/deployment.yaml` file.

    ```
    - name: SIDDHI_ERROR_STORE_DB
      description: The datasource used for Siddhi error handling feature
      jndiConfig:
        name: jdbc/SiddhiErrorStoreDB
      definition:
        type: RDBMS
        configuration:
          jdbcUrl: 'jdbc:mysql://localhost:3306/siddhierrorstoredb?useSSL=false'
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

## Configuring the Siddhi application to store events with errors

In this section, let's update the `SweetFactoryApp` Siddhi application to store mapping errors that may occur when it reads events  from the `production.csv` file.

The stream that reads the events from the file is `FilterStream`. Therefore, add the `@OnError` annotation to it as shown below.

```
@source(type='file', mode='LINE',
   file.uri='file:/Users/foo/productioninserts.csv',
   tailing='true',
   @map(type='csv'))
@OnError(action='STORE')
define stream FilterStream (name string,amount double);
```


The completed Siddhi application looks as follows

```
@App:name('SweetFactoryApp')

@App:statistics(reporter = 'prometheus')


@source(type='cdc',url = "jdbc:mysql://localhost:3306/production",username = "wso2si",password = "wso2",table.name = "SweetProductionTable",operation = "insert",
	@map(type='keyvalue'))
define stream InsertSweetProductionStream (name string,amount double);

@source(type='file', mode='LINE',
   file.uri='file:/Users/foo/productioninserts.csv',
   tailing='true',
   @map(type='csv'))
@OnError(action='STORE')
define stream FilterStream (name string,amount double);

@sink(type='file',file.uri = "/Users/foo/productioninserts.csv",
	@map(type='text'))
define stream ProductionUpdatesStream (name string,amount double);

@sink(type = 'kafka', bootstrap.servers = "localhost:9092", topic = "eclair_production", is.binary.message = "false", partition.no = "0",
         @map(type = 'json'))
define stream PublishFilteredDataStream (name string,amount double);

@info(name='query1')
from InsertSweetProductionStream 
select str:upper(name) as name, amount 
group by name 
insert  into ProductionUpdatesStream;

from FilterStream [name=='Eclairs']
select * 
group by name 
insert  into PublishFilteredDataStream;
```

## Testing the Siddhi aplication

For testing purposes, let's generate an error with a mapping error as follows:

1. Open the `/Users/foo/productioninserts.csv`, and manually enter an erroneous row in it as follows:

    `ECLAIRS,TOFFEE,40.0`
    
    Here, you are creating a file event with values for three attributes whereas the event schema (as defined via the `FilterStream` stream) has only two attributes. This results in a mapping error which is logged as follows in the terminal window in which you are running the Streaming Integrator server.
    
2. If you have not already started the Streaming Integrator Tooling server, start it by navigating to the `<SI_TOOLING_HOME>/bin` directory and issuing one of the following commands as appropriate, based on your operating system:
                                                 
     - For Windows: `tooling.bat`
    
     - For Linux: `./tooling.sh`
     
    Then Access the Streaming Integrator Tooling via the URL that appears in the start up log with the text `Editor Started on:`.
    
3. To open the Error Store Explorer, click **Tools** and then click **Error Store Explorer**.
   
    The Error Store Explorer opens as shown below. 
      
    ![Access Error Store]({{base_path}}/assets/img/streaming/handling-requests-with-errors/error-store-explorer-without-server.png)
    
4. Click **Connect to Server**. Then enter information as follows:

    To check the port of the Streaming Integrator Server, Open <SI_HOME>/conf/server/deployment.yaml file. Under Listener Configurations of wso2.transport.http, locate the listener configuration with msf4j-https as the ID and specify its port as shown in the extract below.
   
    ![Server Configuration]({{base_path}}/assets/img/streaming/quick-start-guide-101/connect-error-store.png)
    
    |**Parameter**|**Value**    |
    |-------------|-------------|
    |**Host**     | `localhost` |
    |**Port**     | `9443`      |
    |**Username** | `admin`     |
    |**Password** | `admin`     |
    
    Then click **Connect**.
    
    As a result, one error is displayed as shown below.
    
    ![View Mapping Error]({{base_path}}/assets/img/streaming/quick-start-guide-101/view-mapping-error.png)
    
    The single error displayed is the mapping error that you previously generated by adding a row with an additional value in the `production.csv` file.
       
    
5. To view details of the error, click **Detailed Info**. The following is displayed.

    ![View Mapping Error Details]({{base_path}}/assets/img/streaming/quick-start-guide-101/view-mapping-error-details.png)
    
4. You can correct the mapping and replay the event. To do this, remove one of the additional values (i.e., one of the sweet names) as shown below, and click **Replay**.

    ![Correct Mapping Error and Replay]({{base_path}}/assets/img/streaming/quick-start-guide-101/remove-additional-value.png)
    
    As a result, the **Error Entry** dialog box closes, and the **Error Store Explorer** dialog box is displayed with no errors.

!!!tip "What's Next?"
    To view the statistics generated by the `SweetFactoryApp` Siddhi application, proceed to [Step 8: Monitor Statistics]({{base_path}}/streaming/getting-started/monitor-statistics).




