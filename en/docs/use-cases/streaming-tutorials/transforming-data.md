# Transforming Streaming Data

## Introduction

In this tutorial, you can try out a few scenarios that involve transforming data from one format to another to understand how the Streaming Integrator component can perform transforming activities on streaming data.

## Transforming data from one format to another

To understand how the Streaming Integrator can transform streaming data from one format to another, let's convert events in CSV format to JSON format. To do this, follow the steps below:

1. Download `productions.csv` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/productions.csv) and save it in a location of your choice.

2. Start the Streaming Integrator Tooling by navigating to the `<SI_TOOLING_HOME>/bin` directory and issuing one of the following commands as appropriate, based on your operating system:
   
    - For Windows: `streaming-integrator-tooling.bat`
    
    - For Linux: `./streaming-integrator-tooling.sh`

3. Open a new file and create a Siddhi application named `ConvertStreamingEventsApp`. You can specify the Siddhi application name via the `@App:name` annotation as shown below.

    ```
    @App:name("ConvertStreamingEventsApp")
    ```
   
4. Create a stream that consumes events from the `productions.csv` file in the CSV format as follows:

    ```
    @source(type='file', mode='LINE',
        file.uri='file:/Users/foo/productions.csv',
        tailing='true',
        @map(type='csv'))
    define stream ProductionStream(name string, amount double);
    ```
   
   The above stream definition receives events with values for the `name` and `amount` fields. The source annotation connected to it specifies that these events are counsumed from a file named `productions.csv` in the `/Users/foo/` directory in the `CSV` format. This file is tailed for new events. 
   
5. To generate the output in `JSON`, define an output stream as follows.

    ```
    @sink(type = 'file', file.uri = "file:/Users/foo/output.csv",
    	@map(type = 'json'))
    define stream OutputStream(name string, amount double);
    ```
   
   The above stream generates output events with values for the `name` and `amount` attributes. The connected sink annotation of the `file` type specifies that output events generated in the stream are published to the `Users/foo/output.csv` file in JSON format.
   
6. To direct the events from the `ProductionStream` stream to the `OutputStream` stream, write a query as follows.

    ```
    @info(name = 'Generate JSON Events')
    from ProductionStream 
    select * 
    insert into OutputStream;
    ```
   
   The above query selects all the events in the `ProductionStream` stream and inserts them into the `OutputStream` stream.
   
7. Save the Siddhi application. The complete Siddhi application is as follows:

    ```
    @App:name('ConvertStreamingEventsApp')
    @App:description('Description of the plan')
    
    @source(type='file', mode='LINE',
        file.uri='file:/Users/foo/productions.csv',
        tailing='true',
        @map(type='csv'))
    define stream ProductionStream(name string, amount double);
    
    @sink(type = 'file', file.uri = "file:/Users/foo/output.csv",
    	@map(type = 'json'))
    define stream OutputStream(name string, amount double);
    
    @info(name = 'Generate JSON Events')
    from ProductionStream 
    select * 
    insert into OutputStream;
    ```
   
8. Start the Siddhi application by clicking on the **Play** icon.

    ![Play]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/play.png)
    
9. Open the `Users/foo/productions.csv` file and add a new row as follows.

    ```
    Chocolate cake,30.0
    ```
      
    Save the change you made.
    
10. Open the `Users/foo/output.csv`. It contains the output events in JSON format as shown in the following extract.

    ![Converted JSON Events](({{base_path}}/assets/img/streaming/transforming-data-tutorial/json-events-extract.png))

## Transforming JSON

### Converting one JSON format to another JSON format

### Converting one JSON format to another JSON format

### Manipulating a JSON object using execution JSON

### Splitting a JSON array to multiple events

## Transforming XML

### Converting one XML format to another XML format

### Performing XSLT like transformation

### Splitting an XML array to multiple events

## Manipulating strings