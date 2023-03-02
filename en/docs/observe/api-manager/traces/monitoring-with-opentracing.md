# Monitoring with OpenTracing

In a distributed API Manager architecture, tracing a message is important to debug and observe a message path. This is known as distributed tracing. OpenTracing allows you to enable distributed tracing for WSO2 API Manager.

OpenTracing aims to be an open, vendor-neutral standard for distributed systems instrumentation. It offers a way for developers to follow the thread — to trace requests from beginning to end across touchpoints and understand distributed systems at scale. OpenTracing will also help to trace the message and identify the latencies that took place in each process or method. Thereby, OpenTracing will help you to carry out a time-related analysis.

 WSO2 API Manager supports the following types of ways to retrieve instrumented data.

 - Jaeger
 - Zipkin
 - Log

For more information, see [OpenTracer Configurations]({{base_path}}/reference/config-catalog/#api-m-open-tracer-configurations).

## Enabling Jaeger Tracing

1. Copy the following configuration into the `deployment.toml` file.

    ```toml tab="Format"
	[apim.open_tracer]
	remote_tracer.enable = true
	remote_tracer.name = "jaeger"
	remote_tracer.properties.hostname = "<hostname-of-jaeger-endpoint>"
	remote_tracer.properties.port = "<port-of-jaeger-endpoint>"
	```

	```toml tab="Example"
	[apim.open_tracer]
	remote_tracer.enable = true
	remote_tracer.name = "jaeger"
	remote_tracer.properties.hostname = "localhost"
	remote_tracer.properties.port = "6831"
	```

2. Start the server.

     After you invoke the APIs you will see the tracing data in Jaeger as follow:

    [![Distributed tracing jaeger]({{base_path}}/assets/img/administer/opentracing-jaeger.png)]({{base_path}}/assets/img/administer/opentracing-jaeger.png)

## Enabling Zipkin Tracing

1. Copy the following configuration into the `deployment.toml` file.

    ```toml tab="Format"
	[apim.open_tracer]
	remote_tracer.enable = true
	remote_tracer.name = "zipkin"
	remote_tracer.properties.hostname = "<hostname-of-zikin-endpoint>"
	remote_tracer.properties.port = "<port-o-zipkin-endpoint>"
	```

	```toml tab="Example"
	[apim.open_tracer]
	remote_tracer.enable = true
	remote_tracer.name = "zipkin"
	remote_tracer.properties.hostname = "localhost"
	remote_tracer.properties.port = "9411"
	```

2. Start the server.

     After you invoke the APIs you will see the tracing data in Zipkin as follow:

[![Distributed tracing zipkin]({{base_path}}/assets/img/administer/opentracing-zipkin.png)]({{base_path}}/assets/img/administer/opentracing-zipkin.png)


## Enabling Log Tracing

1. Copy the following configuration into the `deployment.toml` file.

    ```toml
	[apim.open_tracer]
	remote_tracer.enable = false
	log_tracer.enable = true
	```


2. Start the server.

    After you invoke the APIs you will be able to see tracing data in the `wso2-apimgt-open-tracing.log` in the `<API-M_HOME>/repository/logs` folder.

    ```log
    15:19:53,258 [-] [PassThroughMessageProcessor-1] TRACE {"Latency":29,"Operation":"OPTIONS--/menu","Tags":{}}
    15:19:53,260 [-] [PassThroughMessageProcessor-1] TRACE {"Latency":33,"Operation":"PizzaShackAPI--1.0.0--carbon.super","Tags":{"span.resource":"/menu","span.kind":"server","span.api.name":"PizzaShackAPI","span.request.method":"OPTIONS","span.request.path":"pizzashack/1.0.0/menu","span.api.version":"1.0.0","span.activity.id":"d83769e1-ff5f-461a-b918-4653e87dbfc7"}}
    15:19:53,270 [-] [PassThroughMessageProcessor-1] TRACE {"Latency":36,"Operation":"API:CORS_Request_Latency","Tags":{}}
    15:19:53,292 [-] [PassThroughMessageProcessor-2] TRACE {"Latency":0,"Operation":"API:CORS_Request_Latency","Tags":{}}
    15:19:53,887 [-] [PassThroughMessageProcessor-2] TRACE {"Latency":589,"Operation":"API:Key_Validation_Latency","Tags":{}}
    15:19:53,895 [-] [PassThroughMessageProcessor-2] TRACE {"Latency":8,"Operation":"API:Throttle_Latency","Tags":{}}
    15:19:53,898 [-] [PassThroughMessageProcessor-2] TRACE {"Latency":2,"Operation":"API:Google_Analytics_Latency","Tags":{}}
    15:19:53,900 [-] [PassThroughMessageProcessor-2] TRACE {"Latency":1,"Operation":"API:Request_Mediation_Latency","Tags":{}}
    15:19:54,671 [-] [PassThroughMessageProcessor-3] TRACE {"Latency":742,"Operation":"API:Backend_Latency","Tags":{"span.endpoint":"https://localhost:9443/am/sample/pizzashack/v1/api/"}}
    15:19:54,672 [-] [PassThroughMessageProcessor-3] TRACE {"Latency":0,"Operation":"API:Response_Mediation_Latency","Tags":{}}
    15:19:54,672 [-] [PassThroughMessageProcessor-3] TRACE {"Latency":1380,"Operation":"GET--/menu","Tags":{}}
    15:19:54,673 [-] [PassThroughMessageProcessor-3] TRACE {"Latency":1380,"Operation":"PizzaShackAPI--1.0.0--carbon.super","Tags":{"span.resource":"/menu","span.kind":"server","span.api.name":"PizzaShackAPI","span.consumerkey":"xTShCMSaKY04lhxY4b0lMfLYHewa","span.request.method":"GET","span.request.path":"pizzashack/1.0.0/menu","span.api.version":"1.0.0","span.activity.id":"b6ce4efa-042c-4367-93e9-fe3672b19e07"}}
    
    ```

## Using the Custom Tracer Implementation

You can use any tracing server with a custom tracer implementation in WSO2 API Manager to publish your tracing data. As an example, let's use the Elastic APM (Application Performance Monitoring), which is a tracing server, and let's implement a custom tracer in WSO2 API Manager for it using the instructions given below:

1. Implement the `org.wso2.carbon.apimgt.tracing.OpenTracer` interface and add your implementation. The getTracer method should contain the generation of the `Tracer` instance. Also, the getName method should return the tracer name to be configured in the `deployment.toml` file. In this specific scenario let's name this tracer `elastic`. This tracer needs to be loaded as an osgi service using a module activator. The sample project for the elastic APM tracer can be downloaded from [here]({{base_path}}/assets/attachments/administer/custom.tracing.client.zip).

2. Build the Maven project and add the JAR file to the `dropins` directory. (`<API-M_HOME>/repository/components/dropins`)

3. Add the following configuration into the `deployment.toml` file.

    ```toml tab="Format"
    [apim.open_tracer]
    remote_tracer.enable = true
    remote_tracer.name = <custom_tracer_name>
    ```

    ```toml tab="Example"
    [apim.open_tracer]
    remote_tracer.enable = true
    remote_tracer.name = "elastic"
    ```

4. Add the Elastic Opentracer JAR file in to the `lib` directory (`<API-M_HOME>/repository/components/lib`). You can download it from [here](https://mvnrepository.com/artifact/co.elastic.apm/apm-opentracing). 

    !!! tip
        Elastic opentracing also requires the addition of a Java Agent. This can be added by altering the startup script. Make sure to check the documentation for the tracer you are using so that such requirements can be satisfied. 

5. Start the server.

     After you invoke the APIs, the tracing data will be published to the configured tracing server, which in this example is the Elastic APM.
