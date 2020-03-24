# Open tracing

OpenTracing aims to be an open, vendor-neutral standard for distributed systems instrumentation. It offers a way for developers to follow the thread — to trace requests from beginning to end across touchpoints and understand distributed systems at scale. Open tracing will also help to trace the message and identify the latencies happened in each process/ method. This will help to do the time-related analysis.

 In WSO2-APIM, We supports following types of ways to retrieve instrumented data.

 1. Jaeger
 2. Zipkin
 3. Log

### How to Enable Jaeger Tracing.

1. Copy following configuration into the deployment.toml and start the server.

```toml
[apim.open_tracer]
remote_tracer.enable = true
remote_tracer.name = "jaeger"
remote_tracer.properties.hostname = "<hostname of jaeger endpoint>"
remote_tracer.properties.port = "<port of jaeger endpoint>"
```
2. Start the Server.
3. Once you invoke the APIS you'll be able to see tracing data in jaeger as follow.

![Distributed tracing jaeger]({{base_path}}/assets/img/administer/opentracing-jaeger.png)


### How to Enable Zipkin Tracing.

1. Copy following configuration into the deployment.toml and start the server.

```toml
[apim.open_tracer]
remote_tracer.enable = true
remote_tracer.name = "zipkin"
remote_tracer.properties.hostname = "<hostname of zikin endpoint>"
remote_tracer.properties.port = "<port of zipkin endpoint>"
```
2. Start the Server.
3. Once you invoke the APIS you'll be able to see tracing data in zipkin as follow.

![Distributed tracing zipkin]({{base_path}}/assets/img/administer/opentracing-zipkin.png)


### How to Enable Log Tracing.
1. Copy following configuration into the deployment.toml and start the server.

```toml
[apim.open_tracer]
remote_tracer.enable = false
log_tracer.enable = true
```
2. Start the Server.
3. Once you invoke the APIS you'll be able to see tracing data in the __wso2-apimgt-open-tracing.log__ under __\<API-M_HOME>/repository/logs__    folder.

```log
20:19:46,937 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":0,"Operation":"API:CORS_Request_Handler","Tags":{}}
n20:19:46,938 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":0,"Operation":"API:Get_Client_Domain()","Tags":{}}
n20:19:46,939 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":0,"Operation":"API:Find_matching_verb()","Tags":{}}
n20:19:46,939 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":1,"Operation":"API:Get_Resource_Authentication_Scheme()","Tags":{}}
n20:19:46,956 [-] [https-jsse-nio-9443-exec-23] TRACE {"Latency":0,"Operation":"API:Get_Access_Token_Cache_key()","Tags":{}}
n20:19:46,958 [-] [https-jsse-nio-9443-exec-23] TRACE {"Latency":0,"Operation":"API:Fetching_API_iNFO_DTO_FROM_CACHE()","Tags":{}}
n20:19:46,959 [-] [https-jsse-nio-9443-exec-23] TRACE {"Latency":0,"Operation":"API:Validate_Token()","Tags":{}}
n20:19:46,972 [-] [https-jsse-nio-9443-exec-23] TRACE {"Latency":12,"Operation":"API:Validate_Subscription()","Tags":{}}
n20:19:46,973 [-] [https-jsse-nio-9443-exec-23] TRACE {"Latency":0,"Operation":"API:Validate_Scopes()","Tags":{}}
n20:19:46,974 [-] [https-jsse-nio-9443-exec-23] TRACE {"Latency":0,"Operation":"API:Write_To_Key_Manager_Cache()","Tags":{}}
n20:19:46,975 [-] [https-jsse-nio-9443-exec-23] TRACE {"Latency":0,"Operation":"API:Publishing_Key_Validation_Response","Tags":{}}
n20:19:46,976 [-] [https-jsse-nio-9443-exec-23] TRACE {"Latency":20,"Operation":"API:Validate_Main","Tags":{}}
n20:19:46,991 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":51,"Operation":"API:Key_Validation_From_Gateway_Node","Tags":{}}
n20:19:46,992 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":52,"Operation":"API:Get_Key_Validation_Info()","Tags":{}}
n20:19:46,993 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":56,"Operation":"API:Key_Validation_Latency","Tags":{}}
n20:19:46,994 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":0,"Operation":"API:Throttle_Latency","Tags":{}}
n20:19:46,995 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":0,"Operation":"API:API_Mgt_Usage_Handler","Tags":{}}
n20:19:46,996 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":1,"Operation":"API:Google_Analytics_Handler","Tags":{}}
n20:19:46,996 [-] [PassThroughMessageProcessor-14] TRACE {"Latency":0,"Operation":"API:Request_Mediation_Latency","Tags":{}}
n20:19:47,016 [-] [PassThroughMessageProcessor-15] TRACE {"Latency":19,"Operation":"API:Backend_Latency","Tags":{"span.endpoint":"https://localhost:9443/am/sample/pizzashack/v1/api/"}}
n20:19:47,017 [-] [PassThroughMessageProcessor-15] TRACE {"Latency":0,"Operation":"API:Response_Mediation_Latency","Tags":{}}
n20:19:47,018 [-] [PassThroughMessageProcessor-15] TRACE {"Latency":0,"Operation":"API:API_MGT_Response_Handler","Tags":{}}
n20:19:47,019 [-] [PassThroughMessageProcessor-15] TRACE {"Latency":83,"Operation":"API:Response_Latency","Tags":{"span.resource":"/menu","span.kind":"server","span.api.name":"PizzaShackAPI","span.consumerkey":"Fn9RGuFeefEe7W07jOq_mvQvLJwa","span.request.method":"GET","span.request.path":"pizzashack/1.0.0/menu","span.api.version":"1.0.0","span.activity.id":"urn:uuid:339f337a-8848-41ec-adba-73da367fa66e"}}
n
```
