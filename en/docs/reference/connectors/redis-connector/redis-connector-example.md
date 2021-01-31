# Redis Connector Example

The Redis connector allows you to access the Redis commands through the WSO2 EI. 

## What you'll build

Given below is a sample scenario that demonstrates how to work with the WSO2 EI Redis Connector and access the Redis server, using Redis commands.

The user sends the request to invoke an API to get stock details. This REST call will get converted into a SOAP message and is sent to the back-end service. While the response from the backend service is converted back to JSON and sent back to the API caller, WSO2 EI will extract stock volume details from the response and store it into a configured Redis server.
When users need to retrieve stock volumes collected, they can invoke the `getstockvolumedetails` resource. This example also demonstrates how users can manipulate this stock volume details by removing unwanted items from the Redis server.

> **Note**: In this scenario you need to set up the Redis Server in your local machine. Please refer the [Setting up the Redis Connector]({{base_path}}/reference/connectors/redis-connector/redis-connector-configuration/) documentation. Follow the steps listed under `Setting up the Redis server` section to setup the Redis server and `Set up the back-end service` section to setup the Stockquote service. 
This example demonstrates how to use Redis connector to:

1. Retrieve stock volume details from the Stockquote back-end service. This is done while extracting the stock volume, creating a Redis hash map, and adding stock volume details to the Redis server. (In this example, Redis hashes are used to store different companies' stocks volume details. Since the “symbol” that is sent in the request is “WSO2”, the request is routed to the WSO2 endpoint. Once the response from the WSO2 endpoint is received, it is transformed according to the specified template and sent to the client. Then create a hash map and insert extracted details to the Redis hashmap).
2. Retrieve all stock volume details from the Redis server.
3. Remove stock volume details from Redis server.

All three operations are exposed via an `StockQuoteAPI` API. The API with the context `/stockquote` has four resources  

* `/getstockquote/{symbol}`: This is used to get stock volume details while extracting and sending details to the Redis hash map.
* `/getstockvolumedetails` : Retrieve information about the inserted stock volume details.
* `/deletestockvolumedetails` : Remove unwanted stock volume details.

The following diagram shows the overall solution. The user creates a hash map, stores WSO2 stock volume details into the list, and then receives it back and removes unwanted hash map items. To invoke each operation, the user uses the same API.

<img src="{{base_path}}/assets/img/integrate/connectors/redis-connector-example-updated.png" title="Redis connector example" width="800" alt="Redis connector example"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/), which is the tooling component of WSO2 EI. Once added, the operations of the connector can be dragged onto your canvas and added to your resources.

### Import the connector

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

### Add integration logic

First create an API, which will be where we configure the integration logic. Right click on the created Integration Project and select, **New** -> **Rest API** to create the REST API. Specify the API name as `SampleRdisAPI` and API context as `/resources`.
    
<img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

#### Configuring the API

##### Configure a resource for the getstockquote operation

Create a resource that sets up Redis hash map and sets a specific field in a hash to a specified value. In this sample, the user sends the request to invoke the created API to get WSO2 stock volume details. To achieve this, add the following components to the configuration.

1. Add an address endpoint using the send mediator to access SimpleStockQuoteService.
   
   <img src="{{base_path}}/assets/img/integrate/connectors/redis-address-endpoint.png" title="Address endpoint" width="500" alt="Address endpoint"/>  

2. Add a header to get a quote from the SimpleStockQuoteService.

   <img src="{{base_path}}/assets/img/integrate/connectors/redis-header.png" title="Add Header to get Quote" width="500" alt="Add Header to get Quote"/> 

3. Add a payload factory to extract the selected stock details. In this sample, we attempt to get WSO2 stock details from the SimpleStockQuoteService.
   
   <img src="{{base_path}}/assets/img/integrate/connectors/redis-payloadfactory.png" title="Add payloadfactory to extract WSO2 details" width="500" alt="Add payloadfactory to extract WSO2 details"/> 

4. In this example, we copy the original payload to a property using the Enrich mediator.
   
   <img src="{{base_path}}/assets/img/integrate/connectors/redis-enrich1.png" title="Add enrich mediator" width="500" alt="Add enrich mediator"/> 

   When we need the original payload, we replace the message body with this property value using the Enrich mediator as follows.
   
   <img src="{{base_path}}/assets/img/integrate/connectors/redis-enrich2.png" title="Add enrich mediator" width="500" alt="Add enrich mediator"/> 
    
5. Initialize the connector.
    
    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Redis Connector** section. Then drag and drop the `init` operation into the Design pane.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/redis-init-drag-and-shop.png" title="Drag and drop init operation" width="500" alt="Drag and drop init operation"/>   
    
    2. Add the property values into the `init` operation as shown below. Replace the `redisHost`, `redisPort`, `redisTimeout` with your values.
        
        - **redisHost**: The Redis host name (default localhost).
        - **redisPort**: The port on which the Redis server is running (the default port is 6379).
        - **redisTimeout** : The server TTL (Time to live) in milliseconds.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/redis-init-parameterspng.png" title="Add values to the init operation" width="800" alt="Add values to the init operation"/>

6. Set up the hSet operation. This operation sets a specific field in a hash to a specified value.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Redis Connector** section. Then drag and drop the `hSet` operation into the Design pane.
           
        <img src="{{base_path}}/assets/img/integrate/connectors/redis-hset-drag-and-drop.png" title="Drag and drop hSet operation" width="500" alt="Drag and drop hSet operation"/>    

    2. In this operation we are going to set a hash map to the Redis server. The hSet operation sets a specific field in a hash to a specified value.
                                                                                 
        - **redisKey** : The name of the key where the hash is stored.
        - **redisField** : The field for which you want to set a value.
        - **redisValue** : The value that you want to set for the field.
        
        In this example, `redisKey` value is configured as **StockVolume**. While invoking the API, the above `redisField`,`redisValue` parameter values are extracted from the response of the SimpleStockQuoteService. Then they are populated as an input value for the Redis `hSet` operation.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/redis-hset-drag-and-drop-parameter.png" title="hSet parameters" width="500" alt="hSet parameters"/> 
    
7. To get the input values in to the `hSet`, we can use the [property mediator]({{base_path}}/reference/mediators/property-mediator). Navigate into the **Palette** pane and select the graphical mediators icons listed under **Mediators** section. Then drag and drop the `Property` mediators onto the Design pane as shown below.    
      > **Note**: The properties should be added to the pallet before creating the operation.
        
        The parameters available for configuring the Property mediator are as follows:
    
     1. Add the property mediator to capture the `symbol` value from the response of SimpleStockQuoteService. The 'symbol' contains the company name of the stock quote. 
   
        - **name** : symbol
        - **value expression** : $body/soapenv:Envelope/soapenv:Body/ns:getQuoteResponse/ax21:symbol
   
        <img src="{{base_path}}/assets/img/integrate/connectors/redis-getsymbol-properties1.png" title="Add property mediators to get symbol" width="600" alt="Add property mediators to get symbol"/>
    
    2. Add the property mediator to capture the `volume` values. The 'volume' contains stock quote volume of the selected company.              
   
        - **name** : volume
        - **value expression** : $body/soapenv:Envelope/soapenv:Body/ns:getQuoteResponse/ax21:volume
     
        <img src="{{base_path}}/assets/img/integrate/connectors/redis-getvolume-properties1.png" title="Add property mediators to get volume" width="600" alt="Add property mediators to get volume"/>  
        
8. Forward the backend response to the API caller.
    
    When you are invoking the created resource, the request of the message is going through the `/getstockquote` resource. Finally, it is passed to the [Respond mediator]({{base_path}}/reference/mediators/respond-mediator/). The Respond Mediator stops the processing on the current message and sends the message back to the client as a response.            
    
    1. Drag and drop **respond mediator** to the **Design view**. 
    
         <img src="{{base_path}}/assets/img/integrate/connectors/redis-respond-mediator.png" title="Add Respond mediator" width="800" alt="Add Respond mediator"/> 

    2. Once you have setup the resource, you can see the `getstockquote` resource as shown below.
    
         <img src="{{base_path}}/assets/img/integrate/connectors/redis-createstockvolume-resource.png" title="Resource design view" width="600" alt="Resource design view"/>

##### Configure a resource for the getstockvolumedetails operation
    
1. Initialize the connector.
   You can use the same configuration to initialize the connector. Please follow the steps given in section 5 for setting up the `init` operation to the `getstockquote` operation.
   
      - **redisKey** : The name of the key where the hash is stored.

2. Set up the lLen operation.
   Navigate into the **Palette** pane and select the graphical operations icons listed under **Redis Connector** section. Then drag and drop the `hGetAll` operation into the Design pane. The `hGetAll` operation retrieves all the fields and values in a hash.
   
   You only need to send redisKey as parameter. In this example `redisKey` value is configured as **StockVolume**

   <img src="{{base_path}}/assets/img/integrate/connectors/redis-hgetall-drag-and-drop.png" title="Drag and drop hGetAll operation" width="500" alt="Drag and drop hGetAll operation"/>
   
3. Forward the backend response to the API caller. Please follow the steps given in section 8 in the `getstockquote` operation.   

##### Configure a resource for the deletestockvolumedetails operation
    
1. Initialize the connector.
   You can use the same configuration to initialize the connector. Please follow the steps given in section 5 for setting up the `init` operation to the `getstockquote` operation.
   
2. Set up the  operation.
   
   Navigate into the **Palette** pane and select the graphical operations icons listed under **Redis Connector** section. Then drag and drop the `hDel` operation into the Design pane.The `hDel` operation deletes one or more hash fields
        
      - **redisKey** : The name of the key where the hash is stored.
      - **redisFields** : The fields that you want to delete.
      
      <img src="{{base_path}}/assets/img/integrate/connectors/redis-hdell-drag-and-drop.png" title="Drag and drop hDell operation" width="500" alt="Drag and drop hDell operation"/>
   
3. Forward the backend response to the API caller. Please follow the steps given in section 8 in the `getstockquote` operation.     
               
Now you can switch into the Source view and check the XML configuration files of the created API and sequences. 
    
  ??? note "StockQuoteAPI.xml"
      ```
        <?xml version="1.0" encoding="UTF-8"?>
        <api context="/stockquote" name="StockQuoteAPI" xmlns="http://ws.apache.org/ns/synapse">
            <resource methods="GET" uri-template="/getstockquote/{symbol}">
                <inSequence>
                    <payloadFactory media-type="xml">
                        <format>
                            <m0:getQuote xmlns:m0="http://services.samples">
                                <m0:request>
                                    <m0:symbol>$1</m0:symbol>
                                </m0:request>
                            </m0:getQuote>
                        </format>
                        <args>
                            <arg evaluator="xml" expression="get-property('uri.var.symbol')"/>
                        </args>
                    </payloadFactory>
                    <header name="Action" scope="default" value="urn:getQuote"/>
                    <call>
                        <endpoint>
                            <address format="soap11" uri="http://localhost:9000/services/SimpleStockQuoteService">
                                <suspendOnFailure>
                                    <initialDuration>-1</initialDuration>
                                    <progressionFactor>1</progressionFactor>
                                </suspendOnFailure>
                                <markForSuspension>
                                    <retriesBeforeSuspension>0</retriesBeforeSuspension>
                                </markForSuspension>
                            </address>
                        </endpoint>
                    </call>
                    <enrich>
                        <source clone="false" type="body"/>
                        <target property="ORIGINAL_PAYLOAD" type="property"/>
                    </enrich>
                    <property expression="$body/soapenv:Envelope/soapenv:Body/ns:getQuoteResponse/ax21:symbol" name="symbol" scope="default" type="STRING" xmlns:ax21="http://services.samples/xsd" xmlns:ns="http://services.samples" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"/>
                    <property expression="$body/soapenv:Envelope/soapenv:Body/ns:getQuoteResponse/ax21:volume" name="volume" scope="default" type="STRING" xmlns:ax21="http://services.samples/xsd" xmlns:ns="http://services.samples" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"/>
                    <redis.init>
                        <redisHost>127.0.0.1</redisHost>
                        <redisPort>6379</redisPort>
                        <redisTimeout>10000000000</redisTimeout>
                    </redis.init>
                    <redis.hSet>
                        <redisKey>StockVolume</redisKey>
                        <redisField>{$ctx:symbol}</redisField>
                        <redisValue>{$ctx:volume}</redisValue>
                    </redis.hSet>
                    <enrich>
                        <source clone="false" property="ORIGINAL_PAYLOAD" type="property"/>
                        <target type="body"/>
                    </enrich>
                    <log level="full"/>
                    <respond/>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </resource>
            <resource methods="GET" uri-template="/getstockvolumedetails">
                <inSequence>
                    <redis.init>
                        <redisHost>127.0.0.1</redisHost>
                        <redisPort>6379</redisPort>
                        <redisTimeout>10000000000</redisTimeout>
                    </redis.init>
                    <redis.hGetAll>
                        <redisKey>StockVolume</redisKey>
                    </redis.hGetAll>
                    <respond/>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </resource>
            <resource methods="POST" uri-template="/deletestockvolumedetails">
                <inSequence>
                    <property expression="json-eval($.redisFields)" name="redisFields" scope="default" type="STRING"/>
                    <redis.init>
                        <redisHost>127.0.0.1</redisHost>
                        <redisPort>6379</redisPort>
                        <redisTimeout>10000000000</redisTimeout>
                    </redis.init>
                    <redis.hDel>
                        <redisKey>StockVolume</redisKey>
                        <redisFields>{$ctx:redisFields}</redisFields>
                    </redis.hDel>
                    <respond/>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </resource>
        </api>
        ```
## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/smpp-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

Follow these steps to deploy the exported CApp in the Enterprise Integrator Runtime. 

{!reference/connectors/deploy-capp.md!}   

## Testing

Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).

1. Retrieve stock volume details from the Stockquote back-end service.
 
   **Sample request 1**

    ```
     curl -v GET "http://localhost:8290/stockquote/view/WSO2" -H "Content-Type:application/json"    
    ```

   **Expected Response**
    
     ```json
     {
         "Envelope": {
             "Body": {
                 "getQuoteResponse": {
                     "change": -2.86843917118114,
                     "earnings": -8.540305401672558,
                     "high": -176.67958828498735,
                     "last": 177.66987465262923,
                     "low": -176.30898912339075,
                     "marketCap": 56495579.98178506,
                     "name": "WSO2 Company",
                     "open": 185.62740369461244,
                     "peRatio": 24.341353665128693,
                     "percentageChange": -1.4930577008849097,
                     "prevClose": 192.11844053187397,
                     "symbol": "WSO2",
                     "volume": 7791
                 }
             }
         }
     }
     ```
     
   **Sample request 2**
     
     ```
      curl -v GET "http://localhost:8290/stockquote/view/IBM" -H "Content-Type:application/json"    
     ```
     
   **Expected Response**
         
     ```json
     {
         "Envelope": {
             "Body": {
                 "getQuoteResponse": {
                     "change": -2.86843917118114,
                     "earnings": -8.540305401672558,
                     "high": -176.67958828498735,
                     "last": 177.66987465262923,
                     "low": -176.30898912339075,
                     "marketCap": 56495579.98178506,
                     "name": "IBM Company",
                     "open": 185.62740369461244,
                     "peRatio": 24.341353665128693,
                     "percentageChange": -1.4930577008849097,
                     "prevClose": 192.11844053187397,
                     "symbol": "IBM",
                     "volume": 7791
                 }
             }
         }
     }      
        
     ```
   **Inserted hash map can check using `redis-cli`**  
   
     Log in to the `redis-cli` and execute `HGETALL StockVolume` command to retrieve inserted hash map details.
   
     ```
     127.0.0.1:6379> HGETALL StockVolume
     1) "IBM"
     2) "7791"
     3) "WSO2"
     4) "7791"
     127.0.0.1:6379>
     ```
2. Retrieve all stock volume details from the redis server.
 
   **Sample request**

    ```
     curl -v GET "http://localhost:8290/stockquote/getstockvolumedetails" -H "Content-Type:application/json"    
    ```

   **Expected Response**
    
     ```json
     {
         "output": "{IBM=7791, WSO2=7791}"
     }
     ```
3. Remove stock volume details.
 
   **Sample request 1**

    ```
     curl -v POST -d {"redisFields":"WSO2"}  "http://localhost:8290/stockquote/deletestockvolumedetails" -H "Content-Type:application/json"    
    ```

   **Expected Response**
    
     ```json
     {
         "output": 1
     }
     ```
     
   **Sample request 2 : Check the remainning stock volume details**
    
   **Sample request**
   
     ```
       curl -v GET "http://localhost:8290/stockquote/getstockvolumedetails" -H "Content-Type:application/json"    
     ```
   
   **Expected Response**
       
     ```json
     {
          "output": "{IBM=7791}"
     }
     ``` 
      
   **Inserted list can retrieve using `redis-cli`**  
   
     Log in to the `redis-cli` and execute `HGETALL StockVolume` command to retrieve list length.
   
     ```
     127.0.0.1:6379> HGETALL StockVolume
     1) "IBM"
     2) "7791"
     127.0.0.1:6379>
     ```     
## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).