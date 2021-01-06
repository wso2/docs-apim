# Siddhi Application Overview

A Siddhi application (.siddhi) file is the deployment artifact containing the Streaming Integration logic for WSO2 Streaming Integrator.

The format of a Siddhi application is as follows:

``` sql
    @App:name("ReceiveAndCount")
    @App:description('Receive events via HTTP transport and view the output on the console')
    
    /* 
        Sample Siddhi App block comment
    */
    
    -- Sample Siddhi App line comment
    
    @Source(type = 'http',
            receiver.url='http://localhost:8006/productionStream',
            basic.auth.enabled='false',
            @map(type='json'))
    define stream SweetProductionStream (name string, amount double);
    
    @sink(type='log')
    define stream TotalCountStream (totalCount long);
    
    -- Count the incoming events
    @info(name='query1')
    from SweetProductionStream
    select count() as totalCount
    insert into TotalCountStream;
```

## Basic information about Siddhi applications

Following are some important things to note about Siddhi applications:

-   The file name of each Siddhi application must be equal to the name specified via the `@App:name()` annotation.  
    e.g., In the sample Siddhi application given above, the application name is `ReceiveAndCount`. Therefore, the Siddhi file name must be `ReceiveAndCount.Siddhi`.

-   It is optional to provide a description via the `@App:description()` annotation.

-   The definitions of the required streams, windows, tables, triggers and aggregations need to be included before the Siddhi queries.  
    e.g., In the above sample Siddhi file, the streams  (lines 14 and 17) are defined before the queries (lines 21-23).
    
-   Siddhi can infer the definition of the streams. It is not required to define all the streams. However, if annotations need to be added to a stream, that stream must be defined.
    
-   In the above sample, lines 4-6 nd 8 demonstrate how to include comments within Siddhi applications.

For more information about Siddhi applications, see [Siddhi Application at Siddhi Streaming SQL Guide](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#siddhi-application).

## Common elements of a Siddhi application

This section explains the common types of definitions and queries that are included in  Siddhi application:

### Queries

Queries define the logical processing and selections that must be executed for streaming events. They consume from the pre-defined streams/ windows/ tables/ aggregations, process them in a streaming manner, and insert the output to another stream, window or table. For more information about Siddhi queries, see [Queries at Siddhi Streaming SQL Guide](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#query).

### Streams

Streams are one of the core elements of a stream processing application. A stream is a logical series of events ordered in time with a uniquely identifiable name and set of defined attributes with specific data types defining its schema. In Siddhi, streams are defined by giving it a name and the set of attributes it contains. Lines 14 and 17 of the above sample are examples of defined streams. For more information on Siddhi streams, see [Streams at Siddhi Streaming SQL Guide](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#stream).

### Tables

A table is a collection of events that can be used to store streaming data. The capability to store events in a table allows you to query for stored events later or process them again with a different stream. Thegeneric table concept holds here as well, however, Siddhi tables also support numerous table specific data manipulations such as defining primary keys, indexing, etc. For more information on Siddhi tables, see [Storage Integration](_Storage_Integration_) and [Tables at Siddhi Streaming SQL Guide](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#table).

### Windows

Windows allow you to retain a collection of streaming events based on a time duration (time window), or a given number of events (length window). It allows you to process events that fall into the defined window or expire from it. For more information on Siddhi windows, see [Windows at Siddhi Streaming SQL Guide](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#defined-window).

### Aggregations

Aggregation allows you to aggregate streaming events for different time granularities. The time granularities supported are seconds, minutes, hours, days, months and years. Aggregations such as sum, min, avg can be calculated for the desired duration(s) via Siddhi aggregation. For more information on Siddhi aggregations, see [Aggregations at Siddhi Streaming SQL Guide](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#incremental-aggregation).

  

The elements mentioned above work together in a Siddhi application to form an event flow. To understand how the elements os a Siddhi application are interconnected, you can view the design view of a Siddhi application. For more information, see [Streaming Integrator Tooling Overview]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview).

  
