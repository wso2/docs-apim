# Streaming Integrator Connectors Overview

WSO2 Streaming Integrator is powered by Siddhi. Siddhi supports an extension architecture to enhance its functionality by incorporating other libraries in a seamless manner.

## Purpose

Streaming Integration use cases may require a wide range of functionalities. Extensions are supported because it is not possible to have all this functionality within the Siddhi core. If the functionality covered by the supported extensions have gaps when addressing the requirements of your use cases, you can [write a custom extension]({{base_path}}/streaming/connectors/writing-custom-siddhi-extensions.md).

All extensions have a namespace. This is used to identify the relevant extensions together, and to let you specifically call the extension.


## Syntax

The syntax of an extension is as follows:

```sql
    <namespace>:<function name>(<parameter>, <parameter>, ... )
```

The following parameters are configured when referring a script function.

|**Parameter**  |**Description**                                          |
|---------------|---------------------------------------------------------|
|`namespace`    |Allows Siddhi to identify the extension without conflict.|
|`function name`|The name of the function referred.                       |
|`parameter`    |The function input parameter for function execution.     |

## Extension Types

Siddhi supports the following extension types:

- **Function**

    For each event, this consumes zero or more parameters as input parameters and returns a single attribute. This can be used to manipulate existing event attributes to generate new attributes like any Function operation.
    This is implemented by extending `io.siddhi.core.executor.function.FunctionExecutor`.
    
    e.g., `math:sin(x)`
    
    Here, the `sin` function of math extension returns the sin value for the `x` parameter.
    
- **Aggregate Function**

    For each event, this consumes zero or more parameters as input parameters and returns a single attribute with aggregated results. This can be used in conjunction with a window in order to find the aggregated results based on the given window like any Aggregate Function operation.
    
    This is implemented by extending `io.siddhi.core.query.selector.attribute.aggregator.AttributeAggregatorExecutor`.
    
    e.g., `custom:std(x)`
    
    Here, the std aggregate function of the `custom` extension returns the standard deviation of the `x` value based on its assigned window query.

- **Window**

    This allows events to be collected, generated, dropped and expired anytime without altering the event format based on the given input parameters, similar to any other Window operator.
    
    This is implemented by extending `io.siddhi.core.query.processor.stream.window.WindowProcessor`.
    
    e.g., `custom:unique(key)`
    
    Here, the `unique` window of the `custom` extension retains one event for each unique `key` parameter.
    
- **Stream Function**

    This allows events to be generated or dropped only during event arrival. It also allows events to be altered by adding one or more attributes to it.
    
    This is implemented by extending `io.siddhi.core.query.processor.stream.function.StreamFunctionProcessor`.
    
    e.g., `custom:pol2cart(theta,rho)`
    
    Here, the `pol2cart` function of the `custom` extension returns all the events by calculating the cartesian coordinates `x` & `y` and adding them as new attributes to the events.

- **Stream Processor**

    This allows events to be collected, generated, dropped and expired anytime by altering the event format. Altering the event format is done by adding one or more attributes to it based on the given input parameters.
    
    This is implemented by extending `io.siddhi.core.query.processor.stream.StreamProcessor`.
    
    e.g., `custom:perMinResults(<parameter>, <parameter>, ...)`
    
    Here, the `perMinResults` function of the `custom` extension returns all events by adding one or more attributes to the events based on the conversion logic. Altered events are output every minute regardless of event arrivals.

- **Sink**

    Sinks provide a way to publish Siddhi events to external systems in the preferred data format. Sinks publish events from the streams to external endpoints via multiple transports and in various data formats.
    
    This is implemented by extending `io.siddhi.core.stream.output.sink.Sink`.
    
    e.g., @sink(type='sink_type', static_option_key1='static_option_value1')
    
    To configure a stream to publish events via a sink, connect the sink configuration to a stream definition by adding the `@sink` annotation with the required parameter values. The sink syntax is as given above.

- **Source**

    Source allows Siddhi to consume events from external systems and map the events to adhere to the associated stream. Sources receive events via multiple transports and in various data formats, and direct them into streams for processing.
    
    This is implemented by extending `io.siddhi.core.stream.input.source.Source`.
    
    e.g., `@source(type='source_type', static.option.key1='static_option_value1')`
    
    To configure a stream that consumes events via a source, connect a source configuration to a stream definition by adding the `@source` annotation with the required parameter values. The source syntax is as given above.
    
- **Store**

    You can use the Store extension type to work with data/events stored in various data stores through the table abstraction.
    
    This is implemented by extending `io.siddhi.core.table.record.AbstractRecordTable`.

- **Script**

    Scripts allow you to define a function operation that is not provided in Siddhi core or its extension. It is not required to write an extension to define the function logic. Scripts allow you to write functions in other programming languages and execute them within Siddhi queries. Functions defined via scripts can be accessed in queries similar to any other inbuilt function.
    
    This is implemented by extending `io.siddhi.core.function.Script`.

- **Source Mapper**

    Each `@source` configuration has a mapping denoted by the `@map` annotation that converts the format of incoming messages to Siddhi events. The `type` parameter of `@map` defines the map type to be used to map the data. The other parameters to be configured depends on the mapper selected. Some of these parameters are optional.
    
    This is implemented by extending `io.siddhi.core.stream.output.sink.SourceMapper`.
    
    e.g., `@map(type='map_type', static_option_key1='static_option_value1')`

- **Sink Mapper**

    Each `@sink` configuration has a mapping denoted by the `@map` annotation that converts the outgoing Siddhi events to the format of the configured message. The `type` parameter of `@map` defines the map type to be used to map the data. The other parameters to be configured depends on the mapper selected. Some of these parameters are optional.
    
    This is implemented by extending `io.siddhi.core.stream.output.sink.SinkMapper`.
    
    e.g., `@map(type='map_type', static_option_key1='static_option_value1')`
    
## Example

A window extension created with `foo`as the namespace and `unique` as the function name can be referred in a Siddhi query as shown below.

```sql
    from StockExchangeStream[price >= 20]#window.foo:unique(symbol)
    select symbol, price
    insert into StockQuote
```

## Available Extensions

For the complete list of pre-written Siddhi extensions that are currently available, see [Siddhi Query Guide -  Extensions](https://siddhi.io/en/v5.0/docs/extensions/).

## Further References

- For instructions to download and install a Siddhi extension, see [Downloading and Installing Siddhi Extensions]({{base_path}}/streaming/connectors/downloading-and-installing-siddhi-extensions).
- If you want to install/uninstall one or more Siddhi extensions in Streaming Integrator Tooling, see [Installing Siddhi Extensions]({{base_path}}/develop/streaming-apps/installing-siddhi-extensions.md).