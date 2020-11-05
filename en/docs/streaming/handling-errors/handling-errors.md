# Handling Errors

WSO2 Streaming Integrator allows you to handle any errors that may occur when handling streaming data in a graceful manner. This section explains the different types of errors that can occur and how they can be handled.

## Supported on-error actions

The supported error actions are as follows:

### STORE

This stores the events with errors in the error store. 

Before using this on-error action, you need to enable the error store in the `<SI_HOME>/conf/server/deployment.yaml` file by adding the following configuration.

```
error.store:
  enabled: true
  bufferSize: 1024
  dropWhenBufferFull: true
  errorStore: org.wso2.carbon.streaming.integrator.core.siddhi.error.handler.DBErrorStore
  config:
    datasource: ERROR_STORE_DB
    table: ERROR_STORE_TABLE
```
- `bufferSize` denotes the size of the ring buffer that is used in the disruptor when publishing events to the ErrorStore. This has to be a power of two. If not, it throws an exception during initialization. The default buffer size is `1024`.
- If the `dropWhenBufferFull` is set to `true`, the event is dropped when the capacity of the ring buffer is insufficient.

This can be used with the following:

- Siddhi Streams

    This on-error action can be specified for a  stream via the `@OnError()` annotation. 

    The Siddhi query uses the `cast("abc", "double")` which intentionally generates an error for testing purposes. 

    ```
    @OnError(action='STORE')
    define stream StreamA (symbol string, amount double);
    
    from StreamA[cast("abc", "double") > 100]
    insert into StreamB;
    ```
  
    If you do not specify the on-error action for a stream  via the `@OnError()` annotation, the event is logged and dropped.
    
- Sinks

    You can specify an on-error action by including the `on-error` parameter within the sink configuration as shown below.
    
    ```
    @sink(type = 'http', on.error='STORE', blocking.io='true', 
          publisher.url = "http://localhost:8090/unavailableEndpoint", 
          method = "POST", @map(type = 'json'))
    define stream StreamA (name string, volume long);
    ```

- Source mappers

    If the `error.store` is enabled in the `<SI_HOME>/conf/server/deployment.yaml` file, mapping errors are automatically added to the error store.

### LOG

This logs the event with details of the error and then drops the event. This can be used with the following:

- Siddhi Streams

    You can specify this on-error action for streams via the `@OnError` annotation as shown below.

    ```
    @OnError(action='LOG')
    define stream StreamA (symbol string, volume long);
    ```
    If you do not specify the on-error action for a stream  via the `@OnError()` annotation, the event is logged and dropped.
    
- Sinks

    You can specify this on-error action by including the `on-error` parameter within the sink configuration as shown below.
    ```
    @sink(type = 'http', on.error='LOG', blocking.io='true', 
          publisher.url = "http://localhost:8090/unavailableEndpoint", 
          method = "POST", @map(type = 'json'))
    define stream TestPublisherStream (symbol string, volume long);
    ```
   If you do not specify the on-error action for a stream  via the `on.error` parameter, the event is logged and dropped.
   
- Source mappers 

    Logging is the default on-error action for source mappers when the error store is not enabled in the `<SI_HOME>/conf/server/deployment.yaml` file.
   
### STREAM

This can be used with the following:

- Siddhi Streams

    This on-error action can be specified for a  stream via the `@OnError()` annotation. 
    
    In the following example, the Siddhi query uses the `cast("abc", "double")` function that intentionally generates an error for testing purposes.

    ```
    @OnError(action='STREAM')
    define stream StreamA (symbol string, amount double);
    
    from StreamA[cast("abc", "double") > 100]
    insert into StreamB;
    
    -- consumes from the fault stream
    from !StreamA#log("Error Occured")
    select symbol, amount, _error
    insert into tempStream;
    ```
    If you do not specify the on-error action for a stream  via the `@OnError()` annotation, the event is logged and dropped.
    
- Sinks

    You can specify this on-error action by including the `on-error` parameter within the sink configuration as shown below.

    ```
    @OnError(action='STREAM')
    @sink(type = 'http', on.error='STREAM', blocking.io='true', 
          publisher.url = "http://localhost:8090/unavailableEndpoint", 
          method = "POST", @map(type = 'json'))
    define stream StreamA (name string, volume long);
   
    -- consumes from the fault stream
    from !StreamA#log("Error Occured")
    select symbol, volume, _error
    insert into tempStream;
    ```

    !!! Note
        This on.error action is not applicable for source mappers.

### WAIT

This on-error action is only applicable to errors that occur when publishing data, and therefore it can be only used with sinks. Here, the thread waits in the `back-off and re-trying` state, and reconnects once the connection is re-established.

```
@sink(type = 'http', on.error='WAIT', blocking.io='true', 
      publisher.url = "http://localhost:8090/unavailableEndpoint", 
      method = "POST", @map(type = 'json'))
define stream StreamA (name string, volume long);
```