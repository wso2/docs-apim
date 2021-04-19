# AmazonSQS Connector Example

The WSO2 Amazon SQS connector allows you to access the exposed Amazon SQS API from an integration sequence.

## What you'll build

This example explains how to use Amazon SQS Connector to create a queue in the Amazon SQS, send a message to the queue, forward it to Simple Stock Quote Service Backend and send the response to the user. 

It has a single HTTP API resource, which is `sendToQueue`. 

<img src="{{base_path}}/assets/img/integrate/connectors/amazonsqs-connector.png" title="AmazonSQS-Connector" width="800" alt="AmazonSQS-Connector"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Setting up the environment 

1. Please follow the steps mentioned in the [Setting up the Amazon S3 Environment ]({{base_path}}/reference/connectors/amazonsqs-connector/amazonsqs-connector-config) document in order to create a Amazon account and obtain access key id and secret access key. Keep them saved to be used in the next steps.  

2. In this example we will be using XPath 2.0 which needs to be enabled in the product as shown below before starting the integration service. 

    If you are using the Micro Integrator of **EI 7** or **APIM 4.0.0**, you need to enable this property by adding the following to the PRODUCT-HOME/conf/deployment.toml file. You can further refer to the [Product Configurations]({{base_path}}/reference/config-catalog/#http-transport).
    
      ```
        [mediation]
        synapse.enable_xpath_dom_failover="true"
      ```

    If you are using **EI 6**, you can enable this property by uncommenting **synapse.xpath.dom.failover.enabled=true** property in PRODUCT-HOME/conf/synapse.properties file. 

3. In this example we use the SimpleStockQuote service backend. Therefore, the SimpleStockQuote service needs to be started. 

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

1. First let's create the following sequences, which are buildMessage, createQueue, sendMessage and ReceiveAndForwardMessage. Right click on the created Integration Project and select, -> **New** -> **Sequence** to create the Sequence. 
    <img src="{{base_path}}/assets/img/integrate/connectors/add-sequence.png" title="Adding a Sequence" width="800" alt="Adding a Sequence"/>

2. Provide the Sequence name as buildMessage. You can go to the source view of the XML configuration file of the API and copy the following configuration. In this sequence we are taking the user's input `companyName` and we build the message using a Payload Factory Mediator. 
    ```
      <?xml version="1.0" encoding="UTF-8"?>
      <sequence name="buildMessage" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
          <property expression="json-eval($.companyName)" name="companyName" scope="default" type="STRING"/>
          <payloadFactory media-type="xml">
              <format>
                  <m0:getQuote xmlns:m0="http://services.samples">
                      <m0:request>
                          <m0:symbol>$1</m0:symbol>
                      </m0:request>
                  </m0:getQuote>
              </format>
              <args>
                  <arg evaluator="xml" expression="get-property('companyName')"/>
              </args>
          </payloadFactory>
          <header name="Action" scope="default" value="urn:getQuote"/>
          <enrich>
              <source clone="true" type="body"/>
              <target property="target_property" type="property"/>
          </enrich>
      </sequence>
    ```
3. Create the createQueue sequence as shown below. In this sequence, we create a queue in the Amazon SQS instance. 
  ```
    <?xml version="1.0" encoding="UTF-8"?>
    <sequence name="createQueue" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
        <amazonsqs.init>
            <accessKeyId>AKIAJRM3ROHOPXQ4V6QA</accessKeyId>
            <secretAccessKey>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</secretAccessKey>
            <version>2009-02-01</version>
            <region>us-east-2</region>
        </amazonsqs.init>
        <amazonsqs.createQueue>
            <queueName>{$ctx:queueName}</queueName>
        </amazonsqs.createQueue>
        <property expression="json-eval($.CreateQueueResponse.CreateQueueResult.QueueUrl)" name="queueURL" scope="default" type="STRING"/>
        <log level="custom">
            <property expression="$ctx:queueURL" name="queueURL"/>
        </log>
        <property expression="fn:substring($ctx:queueURL,39,12)" name="queueId" scope="default" type="STRING" xmlns:fn="http://www.w3.org/2005/xpath-functions"/>
        <log level="custom">
            <property expression="$ctx:queueId" name="queueId"/>
        </log>
    </sequence>
  ```

  4. Create sendMessage sequence as shown below. In this sequence, we send the message that we built in step 1 to the Amazon SQS Queue. 
    ```
      <?xml version="1.0" encoding="UTF-8"?>
      <sequence name="sendMessage" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
          <amazonsqs.init>
              <accessKeyId>AKIAJRM3ROJKJJXQ4V6QA</accessKeyId>
              <secretAccessKey>r7hfmtqVjdwieILi4mq7MJ2kkUZ2GlcCkBNg</secretAccessKey>
              <version>2009-02-01</version>
              <region>us-east-2</region>
          </amazonsqs.init>
          <amazonsqs.sendMessage>
              <queueId>{$ctx:queueId}</queueId>
              <queueName>{$ctx:queueName}</queueName>
              <messageBody>{$ctx:target_property}</messageBody>
          </amazonsqs.sendMessage>
      </sequence>
    ```

  5. Create the ReceiveAndForwardMessage sequence as shown below. In this sequence, we will receive the message from the Amazon SQS queue and forward it into the StockQuote Endpoint. 
    ```
      <?xml version="1.0" encoding="UTF-8"?>
      <sequence name="ReceiveAndForwardMessage" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
          <amazonsqs.init>
              <accessKeyId>AKIAJRM3ROJKJJXQ4V6QA</accessKeyId>
              <secretAccessKey>r7hfmtqVjdwieILi4mq7MJ2kkUZ2GlcCkBNg</secretAccessKey>
              <version>2009-02-01</version>
              <region>us-east-2</region>
          </amazonsqs.init>
          <amazonsqs.receiveMessage>
              <maxNumberOfMessages>5</maxNumberOfMessages>
              <queueId>{$ctx:queueId}</queueId>
              <queueName>{$ctx:queueName}</queueName>
          </amazonsqs.receiveMessage>
          <property expression="json-eval($.ReceiveMessageResponse.ReceiveMessageResult.Message.Body)" name="messageBody" scope="default" type="STRING"/>
          <payloadFactory media-type="xml">
              <format>
                  <soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope">
                      <soapenv:Body>$1</soapenv:Body>
                  </soapenv:Envelope>
              </format>
              <args>
                  <arg evaluator="xml" expression="$ctx:messageBody"/>
              </args>
          </payloadFactory>
          <header name="Action" scope="default" value="urn:getQuote"/>
          <call>
              <endpoint key="SimpleStockQuote"/>
          </call>
      </sequence>
    ```

  6. Now right click on the created Integration Project and select **New** -> **Rest API** to create the REST API. 
  
  7. Provide the API name as SQSAPI and the API context as `/sqs`. You can go to the source view of the XML configuration file of the API and copy the following configuration. 
    ```
      <?xml version="1.0" encoding="UTF-8"?>
      <api context="/sqs" name="SQSAPI" xmlns="http://ws.apache.org/ns/synapse">
          <resource methods="POST" uri-template="/sendToQueue">
              <inSequence>
                  <property expression="json-eval($.queueName)" name="queueName" scope="default" type="STRING"/>
                  <sequence key="buildMessage"/>
                  <sequence key="createQueue"/>
                  <sequence key="sendMessage"/>
                  <sequence key="ReceiveAndForwardMessage"/>
                  <respond/>
              </inSequence>
              <outSequence/>
              <faultSequence/>
          </resource>
      </api>
    ```

{!reference/connectors/exporting-artifacts.md!}

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/amazonsqs.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the value of the access key and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!reference/connectors/deploy-capp.md!}

## Testing

1. Create a file called data.json with the following payload. 
    ```
    {
      "companyName":"WSO2",
      "queueName":"Queue1"
    }
    ```
2. Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).
    ```
    curl -H "Content-Type: application/json" --request POST --data @body.json http://localhost:8290/sqs/sendToQueue
    ```

**Expected Response**: 

You should get the following response with the 'sys_id' and keep it saved. 

```
<ns:getQuoteResponse xmlns:ns="http://services.samples">
    <ns:return xmlns:ax21="http://services.samples/xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ax21:GetQuoteResponse">
        <ax21:change>4.233604086603518</ax21:change>
        <ax21:earnings>-8.707965767387106</ax21:earnings>
        <ax21:high>-150.5908765590026</ax21:high>
        <ax21:last>153.98353327622493</ax21:last>
        <ax21:lastTradeTimestamp>Wed Apr 08 10:38:56 IST 2020</ax21:lastTradeTimestamp>
        <ax21:low>158.9975778178183</ax21:low>
        <ax21:marketCap>-565228.6001002677</ax21:marketCap>
        <ax21:name>WSO2 Company</ax21:name>
        <ax21:open>-151.38099715271312</ax21:open>
        <ax21:peRatio>23.761940918708092</ax21:peRatio>
        <ax21:percentageChange>-2.8310759126772127</ax21:percentageChange>
        <ax21:prevClose>-149.5404650806414</ax21:prevClose>
        <ax21:symbol>WSO2</ax21:symbol>
        <ax21:volume>9834</ax21:volume>
    </ns:return>
</ns:getQuoteResponse>
```

## What's Next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).

