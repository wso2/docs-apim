# Handling Errors

WSO2 Streaming Integrator allows you to handle any errors that may occur when handling streaming data in a graceful manner. This section explains the different types of errors that can occur and how they can be handled.

## Types of errors

### Runtime errors

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>These are errors identified based on Siddhi logic when processing events.<br/><br/>To specify how the system should handle errors that occur at runtime, you need to add an <code>@OnError</code> annotation to a stream definition as shown below.<br/><br/><code>@OnError(action='on_error_action')<br/>define stream <stream name> (<attribute name> <attribute type>, <attribute name> <attribute type>, ... );</code>Events with such errors are collected and stored only if the <code>@OnError(action='STORE')</code> annotation is connected to a stream or if the `on.error='STORE'`parameter is set within a sink annotation.</td>
</tr>
<tr class="even">
<th>Supported actions</th>
<td><ul><li><code>LOG</code></li><li><code>STREAM</code></li><li><code>STORE</code> (</li></ul><br/><br/>For more information about these on-error actions, see [Supported on-error actions](#supported-on-error-actions).</td>
</tr>
<tr class="odd">
<th>Example</th>
<td>In the following Siddhi application, the sink annotation specifies <code>STORE</code> as the on-error action. If you send the <code>{"event": {"name": "Cake2", "amount": 20.222}}</code> event to the `http://localhost:8007/testUnavailableEP` endpoint, the event is collected and stored in the error store because the `unavailableEndpoint` does not exist.<br/><br/><code>@App:name("SinkTransportErrorTest")<br/><br/>@sink(type = 'http', on.error='STORE', blocking.io='true', publisher.url = "http://localhost:8090/unavailableEndpoint", method = "POST", @map(type = 'json'))<br/>define stream TestPublisherStream (name string, amount double);<br/><br/>@Source(type = 'http', receiver.url='http://localhost:8007/testUnavailableEP', basic.auth.enabled='false', @map(type='json', enclosing.element='$.event', @attributes(name='name', amount='amount')))<br/>define stream TestInput(name string, amount double);<br/><br/>from TestInput<br/>select name, amount<br/>insert into TestPublisherStream;</code></td>
</tr>
</tbody>
</table>

### Publishing errors

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>These errors occur at the time of publishing streaming data. The errors can be identified based on the Siddhi logic defined by the Siddhi extensions via which the events are published, or they may occur due to connection errors.<br/><br/>To specify the error handling methods for errors that occur at the time the output is published, you can include the <code>on.error</code> parameter in the sink configuration as shown below.<br/><br/><code>@sink(type='sink_type', on.error='on.error.action')<br/><br/>define stream <stream name> (<attribute name> <attribute type>, <attribute name> <attribute type>, ... );</code></td>
</tr>
<tr class="even">
<th>Supported actions</th>
<td><ul><li><code>LOG</code></li><li><code>STREAM</code></li><li><code>WAIT</code></li><li><code>STORE</code></li></ul><br/><br/>For more information about these on-error actions, see [Supported on-error actions](#supported-on-error-actions).</td>
</tr>
<tr class="odd">
<th>Example</th>
<td>The following is a sink annotation of the <code>tcp</code> type of which on-error type is <code>WAIT</code>. If an error occurs at publishing, the system would keep retrying to send the events until the connection is re-established.<br/><br/><code>@Sink(type = 'tcp', url='tcp://localhost:8080/abc', sync='true'<br/>   @map(type='binary'))<br/>define stream SalesStream (productName string, amount int);</code></td>
</tr>
</tbody>
</table>

### Mapping errors<table>

<tbody>
<tr class="odd">
<th>Description</th>
<td>A mapping error occurs when the payload of an event is missing a value for one or more attributes of the event schema (as per the stream definition). Events with such errors are collected when the error store is enabled. For more information, see the <code>STORE</code> on-error type described under [Supported on-error actions](#supported-on-error-actions).</td>
</tr>
<tr class="even">
<th>Supported actions</th>
<td><code>STORE</code><br/><br/>For more information, see [Supported on-error actions](#supported-on-error-actions).</td>
</tr>
<tr class="odd">
<th>Example</th>
<td>The source annotation in the following Siddhi application defines a mapping with two attributes named `name` and `amount` for JSON events. If you send the `{"foo": "Cake", "amount": 20.02}` event to the `http://localhost:8006/productionStream` endpoint, a mapping error occurs because the event includes an attribute named `foo` instead of `name`.<br/><br/><code>@App:name("MappingErrorTest")<br/><br/>@Source(type = 'http', receiver.url='http://localhost:8006/productionStream', basic.auth.enabled='false', @map(type='json', @attributes(name='name', amount='amount')))<br/>define stream InvalidMappingCaller(name string, amount double);<br/><br/>@sink(type='log', prefix='Successful mapping: ')<br/>define stream LogStream(name string, amount double);<br/><br/>from InvalidMappingCaller<br/>select *<br/>insert into LogStream;</code></td>
</tr>
</tbody>
</table>

## Supported on-error actions

The supported error actions are as follows:

### LOG

This logs the event with details of the error and then drops the event. This is the default on-error action if you do not specify an on-error action via the `@OnError` annotation (for streams) or via the `on.error='STORE` parameter (for sinks).

### STREAM

This automatically creates an error stream for the base stream. The definition of the error stream includes all the attributes of the base stream as well as an additional attribute named `_error`. The events are inserted into the error stream during a failure. The error identified is captured as the value for the `_error` attribute.

e.g., The following is a Siddhi application that includes the `@OnError` annotation to handle failures during runtime.

```
@OnError(name='STREAM')

define stream StreamA (symbol string, volume long);

from StreamA[custom:fault() > volume]
insert into StreamB;

from !StreamA#log("Error Occured")
select symbol, volume long, _error
insert into tempStream;
```    

Here, if an error occurs for the base stream named `StreamA` , a stream named `!StreamA` is automatically created. The base stream has two attributes named symbol and volume. Therefore, `!StreamA` has the same two attributes, and in addition, another attribute named `_error`.

The Siddhi query uses the `custom:fault()` extension generates the error detected based on the specified condition (i.e., if the volume is less than a specified amount). If no error is detected, the output is inserted into the `StreamB` stream. However, if an error is detected, it is logged with the `Error Occured` text. The output is inserted into a stream named `tempStream`, and the error details are presented via the `_error` stream attribute (which is automatically included in the `!StreamA` error stream and then inserted into the `TempStream` which is the inferred output stream).

### WAIT

This on-error type is only applicable to publishing errors. Here, the thread waits in the `back-off and re-trying` state, and reconnects once the connection is re-established.

### STORE

This stores the events with errors in the error store. Before using this on-error action, you need to enable the error store in the `<SI_HOME>/conf/server/deployment.yaml` file by adding the following configuration.

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
