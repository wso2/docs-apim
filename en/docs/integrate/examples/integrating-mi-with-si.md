# Integrating Micro Integrator with WSO2 Streaming Integrator

You can publish events from the integration flow to WSO2 Streaming Integrator using an http or http-service source configured in a Siddhi application deployed in Streaming Integrator server. The http or http-service source receive POST requests via HTTP and HTTPS protocols in a format such as text, xml, or json. In the case of http-service source, it will send responses via its corresponding http-service-response sink correlated through a unique `source.id`.   

In this example, we are using a simple rest api to publish events to the Streaming Integrator, which is configured to receive POST requests via HTTP protocol in JSON format and send responses accordingly.

## Set up the Siddhi Application

Follow the instructions below to set up and configure.

1.  [Download and install the Streaming Integrator](https://ei.docs.wso2.com/en/latest/streaming-integrator/quick-start-guide/getting-started/getting-started-guide-overview/).

2.  [Start and create the following Siddhi application](https://ei.docs.wso2.com/en/latest/streaming-integrator/quick-start-guide/getting-started/create-the-siddhi-application/).

    !!! Note
        This “ShoppingCart” siddhi app demonstrates a simple scenario where you can add an item to a shopping cart and see the total cost. The siddhi app will receive events via HTTP protocol in JSON format with a custom mapping.
         
    ```
    @App:name("ShoppingCart")
    
    @App:description('Receive events via HTTP transport in JSON format with custom mapping and view the output on the console')
    
    @source(type='http-service', receiver.url='http://localhost:5005/addToCart',
          source.id='adder', basic.auth.enabled='false', @map(type='json', 
          @attributes(messageId='trp:messageId', name='$.event.name', price='$.event.price')))
    define stream AddStream (messageId string, name String, price double);
    
    @sink(type='http-service-response', source.id='adder', message.id='{{messageId}}', @map(type = 'json'))
    define stream ResultStream (messageId string, message string, numOfItems long, totalCost double);
    
    @info(name = 'query1')
    from AddStream 
    select  messageId, str:concat('Successfully added ', name, ' to the cart') as message, count() as numOfItems, sum(price) as totalCost
    insert into ResultStream;
    ```

    The **http-service source** on stream `AddStream` listens on url `http://localhost:5005/addToCart` for JSON messages with format:

    ```json
    {
      "event": {
        "name": "Cheese",
        "Price": 390
      }
    }
    ```

    and when events arrive, it maps to `AddStream` events and passes them to query named `query1` for processing. The query results produced on `ResultStream` are sent as a response via **http-service-response sink** with format:

    ```json
    {
      "event": {
        "messageId":"741f30af-89c8-44ce-abbc-8ded26a4c4b7",
        "message":"Successfully added Cheese to the cart",
        "numOfItems":1,
        "totalCost":390.0
      }
    }
    ```

3. [Deploy the application in the Streaming Integrator](https://ei.docs.wso2.com/en/latest/streaming-integrator/quick-start-guide/getting-started/deploy-siddhi-application/).

## Synapse configuration

Following is the sample rest api configuration that we can use to implement this scenario. See the instructions on how to [build and run](#build-and-run) run this example.


```xml
<api xmlns="http://ws.apache.org/ns/synapse" name="OrderAPI" context="/addToCart"> 
   <resource methods="POST" url-mapping="/"> 
      <inSequence> 
         <send> 
            <endpoint>
               <address uri="http://localhost:5005/addToCart"/>
         </endpoint>
         </send> 
      </inSequence> 
   </resource> 
</api>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an ESB Solution project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project).
3. [Create the rest api]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-and-run) in your Micro Integrator.

Invoke the sample Api:

- Open a terminal and execute the following CURL command. This sends a simple POST request to the Micro Integrator.

    ```bash
    curl -X POST -d "{\"event\":{\"name\":\"snacks\",\"price\":10.0}}" http://localhost:8290/addToCart --header "Content-Type:application/json"
    ```

- You will receive the following response in the console in which you are running the MI server:
    ```json
    {"event":{"messageId":"7b0da3c2-ddae-4627-8c43-fa09faa1abb7","message":"Successfully added snacks to the cart","numOfItems":1,"totalCost":10.0}}
    ```

