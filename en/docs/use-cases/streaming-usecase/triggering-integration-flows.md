# Triggering Integration Flows

## Introduction

Once the Streaming Integrator processes streaming data and generates an output, you are often required to take some action based on that output. The action required could be executing some code, calling an external service or triggering a complex integration flow. When it is required to trigger an integration flow, the Streaming Integrator can send a request to the Micro integrator to initiate such action.


## Triggering integration via Streaming Integrator as fire and forget manner

In order to allow the Streaming Integrator to trigger an integration flow in the Micro Integrator, you need to do the following:

- Design a Siddhi application with a `grpc-call` sink that allows an output event to be generated as a request that is sent to the Micro Integrator.

- Deploy the required artifacts in the Micro Integrator so that the Micro Integrator is triggered to take the required action when it receives the request from the Streaming Integrator.

### Designing the Siddhi application in the Streaming Integrator

`gRPC` sink is a Siddhi extension via which you can send messages in a fire and forget manner from SI to MI and trigger a sequence.

The following is a sample Siddhi application with a `gRPC` sink that triggers a sequence named `inSeq` in the micro integrator.

```siddhi
@App:name("grpc-call")
@App:description("This siddhi application will trigger inSeq in the MicroIntegrator")

@Source(type = 'http',
        receiver.url='http://localhost:8006/productionStream',
        basic.auth.enabled='false',
        @map(type='json'))
define stream InputStream(message string, headers string);

@sink(
    type='grpc',
    publisher.url = 'grpc://localhost:8888/org.wso2.grpc.EventService/consume/inSeq',
    headers='Content-Type:json',
    metadata='Authorization:Basic YWRtaW46YWRtaW4=',
    @map(type='json')
)
define stream FooStream (message string, headers string);

from InputStream
select *
insert into FooStream;

```

Note the following about the `grpc-call` sink configuration:

- `consume` in the publisher URL path: This indicates that the gRPC request invokes the `consume` method of the Micro Integrator's gRPC inbound endpoint. This method does not send a response back to the client.

- `headers` parameter: This is required to pass the content type so that the system can construct and read the message from the Micro Integrator.

!!!tip "After creating the Siddhi application:"
    To deploy the above Siddhi application, save it as a `.siddhi` file in the `<SI_HOME>/WSO2/server/deployment/siddhi-files` directory.

### Deploying the required artifacts in the Micro Integrator

The following artifacts need to be deployed in the Micro Integrator.

- To start  gRPC server in the Micro Integrator son that it can receive the gRPC event sent by the Streaming Integrator, you need to deploy a gRPC inbound endpoint (similar to the sample configuration given below) by saving it as a `.xml` file in the `<MI_HOME>/repository/deployment/server/synapse-configs/default/inbound-endpoints` directory.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <inboundEndpoint xmlns="http://ws.apache.org/ns/synapse"
                     name="GrpcInboundEndpoint"
                     sequence="inSeq"
                     onError="fault"
                     protocol="grpc"
                     suspend="false">
       <parameters>
          <parameter name="inbound.grpc.port">8888</parameter>
       </parameters>
    </inboundEndpoint>
    ```
    !!! info
        Currently, WSO2 Integration Studio does not support GRPC Inbound Endpoint. This capability will be available in a future [release](https://github.com/wso2/devstudio-tooling-ei/issues/1238). 
        For now, you need to create the inbound endpoint manually as an XML file.

- Both the inbound endpoint and the `grpc-call` sink in the Siddhi application refers to a sequence (`inSeq` in this example). A sequence with the same name and the required configuration should be added to the `<MI_HOME>/repository/deployment/server/synapse-configs/default/sequences` directory. The following is a sample configuration.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="inSeq">
       <log level="full"/>
       <respond/>
    </sequence>
    ```

## Triggering integration via Streaming Integrator and receiving a response from MI

The `gRPC-call` sink allows the Streaming Integrator to send messages to the Micro Integrator, trigger a sequence, and get a response back. In order to receive that response, the Streaming Integrator needs to use the `grpc-call-response` source.

The following is a sample Siddhi application with a  `gRPC-call` sink that triggers a sequence named  `inSeq` in the Micro Integrator and then uses the `grpc-call response` source to process the response received from the Micro Integrator.

```siddhi
@App:name("grpc-call-response")
@App:description("Description of the plan")

@sink(
    type='grpc-call', 
    publisher.url = 'grpc://localhost:8888/org.wso2.grpc.EventService/process/inSeq', 
    sink.id= '1', 
    headers='Content-Type:json', 
    @map(type='json')) 
define stream FooStream (message string, headers string);

@source(type='grpc-call-response', sink.id= '1', @map(type='json'))
define stream BarStream (message string);

@Source(type = 'http',
        receiver.url='http://localhost:8006/productionStream',
        basic.auth.enabled='false',
        @map(type='json'))
define stream InputStream(message string, headers string);

from InputStream
select *
insert into FooStream;

from BarStream
select *
insert into TempStream;
```

Note the following about the `grpc-call` sink configuration:

- `process` in the publisher URL path: This indicates that the gRPC request invokes the `process` method of the gRPC server of the Micro Integrator's inbound endpoint that sends a response back to the client.

- `sink.id` parameter: This is required when using the gRPC-call sink in order to map the request with its corresponding response.


!!!tip "After creating the Siddhi application:"
    To deploy the above Siddhi application, save it as a `.siddhi` file in the `<SI_HOME>/WSO2/server/deployment/siddhi-files` directory.

Once the Siddhib application is created and deployed, deploy the following artifacts in the Micro Integrator:

- In order to start a gRPC server in the Micro Integrator to receive the gRPC event sent by the Streaming Integrator, deploy a GRPC inbound endpoint by adding the following sample configuration as a `.xml` file to the `<MI_Home>/repository/deployment/server/synapse-configs/default/inbound-endpoints` directory.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <inboundEndpoint xmlns="http://ws.apache.org/ns/synapse"
                     name="GrpcInboundEndpoint"
                     sequence="inSeq"
                     onError="fault"
                     protocol="grpc"
                     suspend="false">
       <parameters>
          <parameter name="inbound.grpc.port">8888</parameter>
       </parameters>
    </inboundEndpoint>
    ```


- Add the following sample `inSeq` sequence to the `<MI_HOME>/repository/deployment/server/synapse-configs/default/sequences` directory.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="inSeq">
       <log level="full"/>
       <respond/>
    </sequence>
    ```

   The respond mediator sends the response back to the Streaming Integrator.