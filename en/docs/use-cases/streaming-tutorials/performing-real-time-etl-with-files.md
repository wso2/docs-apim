# Performing Real-time ETL with Files

## Introduction

The Streaming Integrator (SI) allows you to perform real-time ETL with data that is stored in files.

This tutorial takes you through the different modes and options you could use, in order to perform real-time ETL with files using the SI.

!!!info "Before you begin:"
    - Start the SI server by navigating to the `<SI_HOME>/bin` directory and issuing one of the following commands as appropriate, based on your operating system:<br/>
      <br/>
        - For Windows: `streaming-integrator.bat`<br/>
      <br/>
        - For Linux:  `sh server.sh`<br/>
      <br/>
    The following log appears in the Streaming Integrator console once you have successfully started the server. <br/>
    <br/>
    `INFO {org.wso2.carbon.kernel.internal.CarbonStartupHandler} - WSO2 Streaming Integrator started in 4.240 sec`
    <br/>

## Tutorial steps
    
### Extracting data from a file

In this section of the tutorial, you are exploring the different ways in which you could extract data from a specific file.

#### Tailing a text file line by line

In this scenario, you are tailing a text file, line by line, in order to extract data from it. Each line is extracted as an event that undergoes a simple transformation thereafter. Let's write a simple Siddhi application to do this.

1. Download `productions.csv` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/productions.csv) and save it in a location of your choice.

2. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('TailFileLineByLine')
    
    @App:description('Tails a file line by line and does a simple transformation.')
    
    @source(type='file', mode='LINE',
        file.uri='file:/Users/foo/productions.csv',
        tailing='true',
        @map(type='csv'))
    define stream SweetProductionStream (name string, amount double);
    
    @sink(type = 'log')
    define stream LogStream (name string, amount double);
    
    from SweetProductionStream
    select str:upper(name) as name, amount
    insert into LogStream;
    ```

    Change the  value of the `file.uri` parameter in the above Siddhi application to the file path to which you downloaded `productions.csv` file in step 1.
    
3. Save this file as `TailFileLineByLine.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.   

    !!!info
        This Siddhi application tails the file `productions.csv` line by line. Each line is converted to an event in the `SweetProductionStream` stream. After that, a simple transformation is carried out for the sweet production runs. The transformation involves converting the value for the `name` attribute to upper case. Finally, the output is logged in the Streaming Integrator console.
        
    Upon successful deployment, following log appears in the SI console:

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App TailFileLineByLine deployed successfully
    ```
4. To install the extensions required for the `TailFileLineByLine` Siddhi application you deployed, open a new terminal window and navigate to the `<SI_HOME>/bin` directory and issue one of the following commands as appropriate, based on your operating system:
    <br/>
    - For Windows: `extension-installer.bat`<br/>
    <br/>
    - For Linux:  `sh extension-installer.sh`<br/>
    <br/>

5. Now the Siddhi application starts to process the `productions.csv` file. The file contains the following entries.

    ```
    Almond cookie,100.0
    Baked alaska,20.0
    ```

    As a result, the following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ReceiveEventsFromFile : LogStream : Event{timestamp=1564490830652, data=[ALMOND COOKIE, 100.0], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ReceiveEventsFromFile : LogStream : Event{timestamp=1564490830657, data=[BAKED ALASKA, 20.0], isExpired=false}
    ```     
            
6. Now append the following line to `productions.csv` file and save the file.

    ```
    Cup cake,300.0
    ```

7. The following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ReceiveEventsFromFile : LogStream : Event{timestamp=1564490869579, data=[CUP CAKE, 300.0], isExpired=false}
    ```
    
#### Tailing a text file using a regular expression

In this scenario, you are using a regular expression to extract data from the file. After data is extracted, a simple transformation is performed on them. Finally, the transformed event is logged in the SI console. Let's write a simple Siddhi application to do this.

1. Download `noisy_data.txt` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/noisy_data.txt) and save it in a location of your choice.

2. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('TailFileRegex')
    
    @App:description('Tails a file using a regex and does a simple transformation.')
    
    @source(type='file', mode='REGEX',
        file.uri='file:/Users/foo/noisy_data.txt',
        begin.regex='\<', end.regex='\>',
        tailing='true',
        @map(type='text', fail.on.missing.attribute = 'false', regex.A='(\w+)\s([-0-9]+)',regex.B='volume\s([-0-9]+)', @attributes(symbol = 'A[1]',price = 'A[2]',volume = 'B')))
    define stream StockStream (symbol string, price float, volume long);
    
    @sink(type = 'log')
    define stream LogStream (symbol string, price float, volume long);
    
    from StockStream[NOT(symbol is null)]
    select str:upper(symbol) as symbol, price, volume  
    insert into LogStream;
    ```

    Change the  value of the `file.uri` parameter in the above Siddhi application to the file path to which you downloaded `noisy_data.txt` file in step 1.
 
3. Save this file as `TailFileRegex.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application tails the `noisy_data.txt` file to find matches according to the regular expressions given: `begin.regex` and `end.regex`. Each match is converted to an event in the `StockStream` stream. After that, a simple transformation is carried out on the `StockStream` stream where the value for the `symbol` attribute from the event is converted to upper case. Finally, the output is logged in the SI console.
        
    Once the Siddhi application is successfully deployed, the following log appears in the SI console.

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App TailFileRegex deployed successfully
    ```
    
4. Now the Siddhi application starts to process the `noisy_data.txt` file. 
    
    As a result, the following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - TailFileRegex : LogStream : Event{timestamp=1564583307974, data=[WSO2, 75.0, 100], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - TailFileRegex : LogStream : Event{timestamp=1564583307975, data=[ORCL, 95.0, 200], isExpired=false}
    ```
            
5. Now append the following text to `noisy_data.txt` file and save the file.

    ```
    IBM <ibm 88 volume 150> 1 New Orchard Rd  Armonk, NY 10504 
    Phone Number: (914) 499-1900
    Fax Number: (914) 765-6021
    ```

6. The following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - TailFileRegex : LogStream : Event{timestamp=1564588585214, data=[IBM, 88.0, 150], isExpired=false}
    ```

#### Reading a remote text file and moving it after processing

In the previous scenarios, you tailed a file and each file generated multiple events. In this scenario, you are reading the complete file to build a single event.

Furthermore, to try out the capability of processing remote files, you are processing a remote file instead of a file located in the local file system.

1. Download `portfolio.txt` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/portfolio.txt) and upload it into an FTP server.

2. Create a directory on the FTP server.  The `portfolio.txt` file is moved to this folder after the processing is complete.
 
3. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('TextFullFileProcessing')
        
    @App:description('Reads a text file and moves it after processing.')
    
    @source(type='file', mode='TEXT.FULL',
        file.uri="ftp://<username>:<password>@<ftp_hostname>:<ftp_port>/Users/foo/portfolio.txt",
        action.after.process='MOVE', move.after.process="ftp://<username>:<password>@<ftp_hostname>:<ftp_port>/Users/foo/move.after.process", 
        @map(type='json', enclosing.element="$.portfolio", @attributes(symbol = "stock.company.symbol", price = "stock.price", volume = "stock.volume")))
    define stream StockStream (symbol string, price float, volume long);
     
    @sink(type = 'log')
    define stream LogStream (symbol string, price float, volume long);
     
    from StockStream
    select str:upper(symbol) as symbol, price, volume   
    insert into LogStream;
    ```
 
    Change the value of the `file.uri` parameter in the above Siddhi application to the remote file path to which you uploaded the `portfolio.txt` file in step 1.
    In addition to that, change `move.after.process` so that it points to the remote folder you created in step 2.
    When configuring both of the above parameters, change the values for `<username>`, `<password>`, `<ftp_hostname>`, and `<ftp_port>` parameters accordingly.
 
4. Save this file as `TextFullFileProcessing.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application reads the complete `portfolio.txt` remote file to create a `StockStream` event. After that, a simple transformation is carried out on the `StockStream` stream where the value for the `symbol` attribute in each event is converted ito upper case. Finally, the output is logged in the SI console.
        
    Once the Siddhi application is successfully deployed, following log appears in the SI console:

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App TextFullFileProcessing deployed successfully
    ```
 
5. Now the Siddhi application starts to process the `portfolio.txt` file. 
    
    As a result, the following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - TextFullFileProcessing :  LogStream : Event{timestamp=1564660443519, data=[WSO2, 55.6, 100], isExpired=false} 
    ```
 
!!!info
    In this scenario, you moved the file after processing. To delete a file after processing, remove the `action.after.process` and `move.after.process` parameters from the Siddhi application. For other configuration options, see [Siddhi File Source documentation](https://siddhi-io.github.io/siddhi-io-file/api/latest/#file-source).

#### Reading a binary file and moving it after processing

In the previous scenarios, you processed text files in order to extract data. In this scenario, you are reading a binary file. The content of the file generates a single event.

1. Download `wso2.bin` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/wso2.bin) and save it in a location of your choice.

2. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('BinaryFullFileProcessing')
        
    @App:description('Reads a binary file and moves it after processing.')
    
    @source(type='file', mode='TEXT.FULL',
        file.uri='file:/Users/foo/wso2.bin',
        action.after.process='MOVE', move.after.process='file:/Users/foo/move.after.process', 
        @map(type='json', enclosing.element="$.portfolio", @attributes(symbol = "stock.company.symbol", price = "stock.price", volume = "stock.volume")))
    define stream StockStream (symbol string, price float, volume long);
     
    @sink(type = 'log')
    define stream LogStream (symbol string, price float, volume long);
     
    from StockStream
    select str:upper(symbol) as symbol, price, volume   
    insert into LogStream;
    ```
 
    In the above Siddhi application, change the value for the `file.uri` parameter to the file path to which you downloaded the `wso2.bin` file in step 1.

3. Save this file as `BinaryFullFileProcessing.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application reads the file `wso2.bin` fully to create a `StockStream` event. After that, a simple transformation is carried out for the `StockStream` stream where the value for the `symbol` attribute is converted to upper case. Finally, the output is logged in the SI console.
        
    Once the Siddhi application is successfully deployed, following log appears in the SI console.

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App BinaryFullFileProcessing deployed successfully
    ```

4. Now the Siddhi application starts to process the `wso2.bin` file.
    
    As a result, the following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - BinaryFullFileProcessing :  LogStream : Event{timestamp=1564660553623, data=[WSO2, 55.6, 100], isExpired=false} 
    ```

#### Reading a file line by line and delete it after processing

In this scenario, you are reading a text file completely, and then deleting it after  processing. In other words, the file is not tailed. You read the file line by line where each line generates an event.

1. Download `productions.csv` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/productions.csv) and save it in a location of your choice.

2. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('ReadFileLineByLine')
    
    @App:description('Reads a file line by line and does a simple transformation.')
    
    @source(type='file', mode='LINE',
        file.uri='file:/Users/foo/productions.csv',
        tailing='false',
        @map(type='csv'))
    define stream SweetProductionStream (name string, amount double);
    
    @sink(type = 'log')
    define stream LogStream (name string, amount double);
    
    from SweetProductionStream
    select str:upper(name) as name, amount
    insert into LogStream;
    ```

    In the above Siddhi application, change the value for the `file.uri` parameter to the file path to which you downloaded the `productions.csv` file in step 1.
    
3. Save this file as `ReadFileLineByLine.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.   

    !!!info
        This Siddhi application tails the `productions.csv` file line by line. Each line is converted to an event in the `SweetProductionStream` stream. After that, a simple transformation is carried out for the sweet production runs where the value for the `name` attribute from the event is converted into upper case. Finally, the output is logged in the SI console.
        
    Once the Siddhi application is successfully deployed, the following log appears in the SI console:

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App ReadFileLineByLine deployed successfully
    ```

4. Now the Siddhi application starts to process the `productions.csv` file. The file has below two entries:

    ```
    Almond cookie,100.0
    Baked alaska,20.0
    ```

    As a result, the following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ReadFileLineByLine : LogStream : Event{timestamp=1564490867341, data=[ALMOND COOKIE, 100.0], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ReadFileLineByLine : LogStream : Event{timestamp=1564490867341, data=[BAKED ALASKA, 20.0], isExpired=false}
    ```

5. Note that `productions.csv` file is not present in the `file.uri` location.

6. Next, create a new `productions.csv` file in the `file.uri` location that includes the latest set of productions. Download `productions.csv` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/productions.csv) and save it in the `file.uri` location.

7. Now the Siddhi application starts to process the new set of production runs in the `productions.csv` file. The file has the following two entries.

    ```
    Cup cake,300.0
    Doughnut,500.0
    ```

    As a result, the following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ReadFileLineByLine : LogStream : Event{timestamp=1564902130543, data=[CUP CAKE, 300.0], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ReadFileLineByLine : LogStream : Event{timestamp=1564902130543, data=[DOUGHNUT, 500.0], isExpired=false}
    ```

#### Reading a file using a regular expression and deleting it after processing

In this scenario, you are using a regular expression to extract data from the content of the file. Here, you do not tail the file.  Instead, you read the full content of the file and generate a single event. After this is done, the file is deleted. To generate an event stream, you can keep re-creating the file with new data.

1. Download `noisy_data.txt` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/noisy_data.txt) and save it in a location of your choice.

2. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('ReadFileRegex')
    
    @App:description('Reads a file using a regex and does a simple transformation.')
    
    @source(type='file', mode='REGEX',
        file.uri='file:/Users/foo/noisy_data.txt',
        begin.regex='\<', end.regex='\>',
        tailing='false',
        @map(type='text', fail.on.missing.attribute = 'false', regex.A='(\w+)\s([-0-9]+)',regex.B='volume\s([-0-9]+)', @attributes(symbol = 'A[1]',price = 'A[2]',volume = 'B')))
    define stream StockStream (symbol string, price float, volume long);
    
    @sink(type = 'log')
    define stream LogStream (symbol string, price float, volume long);
    
    from StockStream[NOT(symbol is null)]
    select str:upper(symbol) as symbol, price, volume  
    insert into LogStream;
    ```

    In the above Siddhi application, change the value of the `file.uri` parameter to the file path to which you downloaded the `noisy_data.txt` file in step 1.
 
3. Save this file as `ReadFileRegex.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application tails the `noisy_data.txt` file to find matches based on the `begin.regex` and `end.regex` regular expressions. Each match is converted to an event in the `StockStream` stream. After that, a simple transformation is carried out for the `StockStream` stream where value for the `symbol` attribute converted to upper case. Finally, the output is logged in the SI console.
        
    Once the Siddhi application is successfully deployed, following log appears in the SI console:

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App ReadFileRegex deployed successfully
    ```
    
4. Now the Siddhi application starts to process the `noisy_data.txt` file. 
    
    As a result, the following log appears in the SI console.

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ReadFileRegex : LogStream : Event{timestamp=1564906475623, data=[WSO2, 75.0, 100], isExpired=false}
    ```

    Note that `noisy_data.txt` file is not present in the `file.uri` location.

5. Next, let's create a new `noisy_data.txt` file in the `file.uri` location that includes the latest set of productions. Download `noisy_data.txt` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/noisy_data.txt) and save it in the `file.uri` location.

    Now the Siddhi application starts to process the new content in the `noisy_data.txt` file. The file has the following content.

    ```
    Oracle Corporation <orcl 95 volume 200> 500 Oracle Parkway.
    Redwood Shores CA, 94065.
    Corporate Phone: 650.506.7000.
    HQ-Security: 650.506.5555
    ```

    As a result, the following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ReadFileRegex : LogStream : Event{timestamp=1564906713176, data=[ORCL, 95.0, 200], isExpired=false}
    ```

### Extracting data from a folder

#### Processing all files in the folder

In this scenario, you extract data from a specific folder. All of the files are processed sequentially, where each file generates a single event.

1. Download `productions.zip` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/productions.zip) and extract it. Now you have a folder named `productions`. Place it in a location of your choice.

2. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('ProcessFolder')
    
    @App:description('Process all files in the folder and delete files after processing.')
            
    @source(type='file', mode='text.full',
        dir.uri='file:/Users/foo/productions',  
        @map(type='json', enclosing.element="$.portfolio", @attributes(symbol = "stock.company.symbol", price = "stock.price", volume = "stock.volume")))
    define stream StockStream (symbol string, price float, volume long);
    
    @sink(type = 'log')
    define stream LogStream (symbol string, price float, volume long);
    
    from StockStream
    select str:upper(symbol) as symbol, price, volume    
    insert into LogStream;
    ```

    In the above Siddhi application, change the value for the `dir.uri` parameter so that it points to the `productions` folder you created in step 1.
 
3. Save this file as `ProcessFolder.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application processes each file in `productions` folder. Each file generates an event in the `StockStream` stream. After that, a simple transformation is carried out for the `StockStream` stream where the value for the `symbol` attribute is converted to upper case. Finally, the output is logged in the SI console.
        
    Once the Siddhi application is successfully deployed, following log appears in the SI console:

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App ProcessFolder deployed successfully
    ```

    Now the Siddhi application starts to process each file in the `productions` directory.
    
    As a result, the following logs appear in the SI console:
    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ProcessFolder : LogStream : Event{timestamp=1564932255417, data=[WSO2, 75.0, 100], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ProcessFolder : LogStream : Event{timestamp=1564932255417, data=[ORCL, 95.0, 200], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ProcessFolder : LogStream : Event{timestamp=1564932255417, data=[IBM, 88.0, 150], isExpired=false}
    ```

!!!info
    In this scenario, you deleted each file in the folder after processing. You can choose to move the files instead of deleting them. To do this, set the `action.after.process` parameter to `MOVE` and specify the directory to which the files should be moved via the `move.after.process` parameter. For more information about these parameters, see [Siddhi File Source documentation](https://siddhi-io.github.io/siddhi-io-file/api/latest/#file-source).

### Loading data into a file

In this section of the tutorial, you are exploring the different ways in which you could load data into a file.  

#### Appending or over-writing events to a file

In this scenario, you are appending a stream of events to the end of a file.

1. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('AppendToFile')
    
    @App:description('Append incoming events in to a file.')
    
    @Source(type = 'http', receiver.url='http://localhost:8006/SweetProductionStream', basic.auth.enabled='false',
            @map(type='json'))
    define stream SweetProductionStream (name string, amount double);
    
    @sink(type='file', @map(type='json'), file.uri='/Users/foo/low_productions.txt')
    define stream LowProductionStream (name string, amount double);
    
    -- Query to filter productions which have amount < 500.0
    @info(name='query1') 
    from SweetProductionStream[amount < 500.0]
    select *
    insert into LowProductionStream;
    ```

    Create an empty file and specify the location of the file as the value for the `file.uri` parameter. If this file does not exist, it is created at runtime.

2. Save this file as `AppendToFile.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    !!!info
        This Siddhi application filters incoming `SweetProductionStream` events, selects the production runs of which the value for the `amount` attribute is less than `500.0`, and inserts the results into the `LowProductionStream`. Finally, all the events in the `LowProductionStream` events are appended to the file specified via the `file.uri` parameter in the Siddhi application.
        
    Once the Siddhi application is successfully deployed, the following log appears in the SI console:

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App AppendToFile deployed successfully
    ```

3. To insert a few events into `SweetProductionStream`,  let's issue the following `CURL` commands:

    ```
    curl -X POST -d "{\"event\": {\"name\":\"Almond cookie\",\"amount\": 100.0}}"  http://localhost:8006/SweetProductionStream --header "Content-Type:application/json"
    ```

    ```
    curl -X POST -d "{\"event\": {\"name\":\"Baked alaska\",\"amount\": 20.0}}"  http://localhost:8006/SweetProductionStream --header "Content-Type:application/json"
    ```

    ```
    curl -X POST -d "{\"event\": {\"name\":\"Cup cake\",\"amount\": 300.0}}"  http://localhost:8006/SweetProductionStream --header "Content-Type:application/json"
    ```

4. Now open the file that you specified via the `file.uri` parameter. Note that the file has following content.

    ```
    {"event":{"name":"Almond cookie","amount":100.0}}
    {"event":{"name":"Baked alaska","amount":20.0}}
    {"event":{"name":"Cup cake","amount":300.0}}
    ```

!!!info
    Instead of appending each event to the end of the file, you can configure your Siddhi application to over-write the file. To do this, set the `append='false'` configuration in the Siddhi application as shown in the sample `file` sink configuration below.

    ```
    @sink(type='file', append='false',  @map(type='json'), file.uri='/Users/foo/low_productions.txt')
       define stream LowProductionAlertStream (name string, amount double);
    ```

    For other configuration options, see [Siddhi File Sink documentation](https://siddhi-io.github.io/siddhi-io-file/api/latest/#file-sink).
    
#### Preserving the state of the application through a system failure

Let's try out a scenario where you deploy a Siddhi application to count the total number of production runs of a sweet factory.

The production data is updated in a file and therefore you have to keep tailing this file, in order to get updates on the productions. 

!!!info
    In this scenario, the Streaming Integrator server needs to *remember* the current count through system failures so that when the system is restored, the count is not reset to zero.
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

2. To enable the state persistence debug logs, open the `<SI_HOME>/conf/server/log4j2.xml` file on a text editor and locate following line in it.

    ```
     <Logger name="com.zaxxer.hikari" level="error"/>
    ```

    Then add following `<Logger>` element below that line.

    ```
    <Logger name="org.wso2.carbon.streaming.integrator.core.persistence" level="debug"/>
    ```

    Save the file.

3. Restart the Streaming Integrator server for above change to be effective.

4. Download `productions.csv` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/productions.csv) and save it in a location of your choice.

5. Open a text file and copy-paste following Siddhi application to it.

    ```
    @App:name('CountProductions')
    
    @App:description('Siddhi application to count the total number of orders.')
    
    @source(type='file', mode='LINE',
        file.uri='file:/Users/foo/productions.csv',
        tailing='true',
        @map(type='csv'))
    define stream SweetProductionStream (name string, amount double);
    
    @sink(type = 'log')
    define stream LogStream (totalProductions double);
    
    -- Following query counts the number of sweet productions.
    @info(name = 'query')
    from SweetProductionStream
    select sum(amount) as totalProductions
    insert into LogStream;
    ```

    Change the `file.uri` parameter in the above Siddhi application to the file path to which you downloaded the `productions.csv` file in step 4.
    
6. Save this file as `CountProductions.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.   

    !!!info
        This Siddhi application tails the file `productions.csv` line by line. Each line is converted to an event in the `SweetProductionStream` stream. After that, a simple transformation is carried out for the sweet production runs. This transformation involves converting the value for the `name` attribute to upper case. Finally, the output is logged in the SI console.
        
    Once the Siddhi application is successfully deployed, the following log appears in the SI console.

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App CountProductions deployed successfully
    ```

7. Now the Siddhi application starts to process the `productions.csv` file. The file two entries as follows.

    ```
    Almond cookie,100.0
    Baked alaska,20.0
    ```

    As a result, the following log appears in the SI console.

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1565097506866, data=[100.0], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1565097506866, data=[120.0], isExpired=false}
    ```

    These logs print the sweet production count. Note that the current count of sweet productions is being printed as `120` in the second log. This is because the factory has so far produced `120` sweets: `100` Almond cookies and `20` Baked alaskas.
    
8. Now wait for following log to appear in the SI console.

    ```
    DEBUG {org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore} - Periodic persistence of CountProductions persisted successfully
    ```

    This log indicates that the current state of the Siddhi application is successfully persisted. The Siddhi application state is persisted every minute. Therefore, you can see this log appearing every minute.
    
    Next, let's append two sweet production entries into the `productions.csv` file and shutdown the SI server before the state persistence happens (i.e., before the above log appears).
    
    !!!tip
        It is better to start appending the records immediately after the state persistence log appears so that you have plenty of time to append the records and shutdown the server before next log appears.
        
9. Now append following content into the `productions.csv` file:

    ```
    Croissant,100.0
    Croutons,100.0
    ```   

10. Shutdown SI server. Here you are deliberately creating a scenario where the server crashes before the SI server could persist the latest production count.
    
    !!!Info
        Here, the SI server crashes before the state is persisted. Therefore, the Streaming Integrator server cannot persist the latest count (which includes the last two production runs that produced `100` Croissants and `100` Croutons). The good news is, the `File source` source replays the last two messages, allowing the Streaming Integrator to successfully recover from the server crash.
 
11. Restart the SI server and wait for about one minute.

    The following log appears in the SI console:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1565097846807, data=[220.0], isExpired=false}
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CountProductions : LogStream : Event{timestamp=1565097846812, data=[320.0], isExpired=false}
    ```

Note that the `File source` has replayed the last two messages. This indicates that the sweet productions count has been correctly restored.