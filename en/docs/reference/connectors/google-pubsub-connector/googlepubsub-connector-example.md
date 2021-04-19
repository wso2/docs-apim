# Google Pub Sub Connector Example  

The Google Pub/Sub connector allows you to access the [Google Cloud Pub/Sub API Version v1](https://cloud.google.com/pubsub/docs/reference/rest/) from an integration sequence. 

## What you'll build

Given below is a sample scenario that demonstrates how to work with the WSO2 Google Pub Sub Connector to:

1. Create a Topic to store company update notifications.
2. Insert company update notifications to the created topic.
3. Retrieve company updates from the created topic.

To work with the Google Pub/Sub connector, you need to have a Google Cloud Platform account. Please refer the [Setting up the Google Pub Sub Environment]({{base_path}}/reference/connectors/google-pubsub-connector/googlepubsub-connector-configuration/) documentation to setup an account.

In this scenario the user needs to create a **Topic** in **Google Cloud Platform account** under **Big Data**. This topic is used to store notifications related to the company updates. Once the user invokes the `createTopic` resource, the subscribing operation also gets triggered simultaneously. Then the user can insert company update notifications to the created topic. Finally the user can retrieve the company updates from the subscribed topic while invoking the API.

All three operations are exposed via an API. The API with the context `/resources` has six resources.

* `/createTopic` : Used to create a Topic for store company notifications and subscribe to the topic. 
* `/insertCompanyNotifications` : Used to insert company update notifications to the subscribed topic.
* `/getcompanynotifictions` : Used to retrieve information about the company updates.

> **Note**: In this example we will be using XPath 2.0 which needs to be enabled in the product as shown below before starting the integration service. If you are using **EI 7** or **APIM 4.0.0**, you need to enable this property by adding the following to the PRODUCT-HOME/conf/deployment.toml file. You can further refer to the [Product Configurations]({{base_path}}/reference/config-catalog/#http-transport). If you are using **EI 6**, you can enable this property by uncommenting **synapse.xpath.dom.failover.enabled=true** property in PRODUCT-HOME/conf/synapse.properties file. 
   ```   
   [mediation]
   synapse.enable_xpath_dom_failover=true
   ```
   
The following diagram shows the overall solution. The user creates a topic, stores some company update notifications, and then receives it back. To invoke each operation, the user uses the same API.

<img src="{{base_path}}/assets/img/integrate/connectors/google-pubsub-connector1.png" title="pub-sub connector example" width="700" alt="pub-sub connector example"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/). Once added, the operations of the connector can be dragged onto your canvas and added to your resources.

### Import the connector

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

### Add integration logic

First create an API, which will be where we configure the integration logic. Right click on the created Integration Project and select, **New** -> **Rest API** to create the REST API. Specify the API name as `pubsubApi` and API context as `/resources`.
    
<img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

#### Configuring the API

**Configure a resource for the createTopic operation**

1. Initialize the connector.
    
    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Googlepubsub Connector** section. Then drag and drop the `init` operation into the Design pane.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-drag-and-drop-init.png" title="Drag and drop init operation" width="500" alt="Drag and drop init operation"/>   
    
    2. Add the property values into the `init` operation as shown below. Replace the `accessToken`, `apiUrl`, `apiVersion` with your values.
        
        - **accessToken** : The access token that grants access to the Google Pub/Sub API on behalf of a user.
        - **apiUrl** : The application URL of Google Pub/Sub.
        - **apiVersion** : The version of the Google Pub/Sub API.     
    
        <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-api-init-operation.png" title="Add values to the init operation" width="800" alt="Add values to the init operation"/>

2. Set up the **createTopic** operation.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Googlepubsub Connector** section. Then drag and drop the `createTopic` operation into the Design pane.
           
    2. The createTopic operation creates a new topic with the name that you specify.
              
        - **projectId** : The unique ID of the project within which you want to create a topic.
        - **topicName** : The name that you want to give the topic that you are creating.
        
        While invoking the API, topicName values is populated as an input value for the operation.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-drag-and-drop.createtopic.png" title="Drag and drop createTopic operation" width="500" alt="Drag and drop createTopic operation"/>    
    
    3. To get the input values in to the API we can use the [property mediator]({{base_path}}/reference/mediators/property-mediator). Navigate into the **Palette** pane and select the graphical mediators icons listed under **Mediators** section. Then drag and drop the `Property` mediators into the Design pane as shown below.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-api-drag-and-drop-property-mediator.png" title="Add property mediators" width="800" alt="Add property mediators"/>

        The parameters available for configuring the Property mediator are as follows:
    
        > **Note**: The properties should be added to the pallet before creating the operation.
    
    4. Add the property mediator to capture the `topicName` value. The topicName contains the name that you want to give the topic that you are creating.
   
        - **name** : topicName
        - **expression** : json-eval($.topicName)
   
        <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-api-property-mediator-property1-value1.png" title="Add property mediators topicName" width="600" alt="Add property mediators topicName"/>

3. Set up the **createTopicSubscription** operation.
    
    1. Initialize the connector. You can use the same configuration to initialize the connector. Please follow the steps given in section 1 for setting up the init operation to the createTopic operation.
    
    2. Set up the `createTopicSubscription` operation. Navigate into the **Palette** pane and select the graphical operations icons listed under **Googlepubsub Connector** section. Then drag and drop the `createTopicSubscription` operation into the **Design pane**.
    
         - **projectId** : The unique ID of the project within which the topic is created.
         - **subscriptionName** : The name of the subscription.
         - **topicName** : The name of the topic for which you want to create a subscription.
         - **ackDeadlineSeconds** :  The maximum time a subscriber can take to acknowledge a message that is received.
            
         <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-api-createtopicsubscription-operation.png" title="Add values to the createTopicSubscription operation" width="800" alt="Add values to the createTopicSubscription operation"/>
    
    3. Add the property mediator to capture the `subscriptionName` values. This contains the name of the subscription.
   
        - **name** : subscriptionName
        - **expression** : json-eval($.subscriptionName)
     
        <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-api-property-mediator-property2-value2.png" title="Add values to capture subscriptionName" width="600" alt="Add values to capture subscriptionName"/>  
    
    4. Add the property mediator to store the name of the created Topic value from the response of the createTopic operation. 
    
        - **name** : nameforsubscription
        - **expression** : json-eval($.name)
        
        <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-api-property-mediator-nameforsubscription.png" title="Add values to capture nameforsubscription" width="600" alt="Add values to capture nameforsubscription"/>
        
    5. Add the property mediator to capture the Topic name from the response using the splitting separators in the results.  
        
         - **name** : nameforsubscription
         - **expression** : json-eval($.name)
            
        <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-api-property-mediator-splitting.png" title="Add values to capture splitting value" width="600" alt="Add values to capture splitting value"/>    

4. Forward the backend response to the API caller.
    
    When you are invoking the created resource, the request of the message is going through the `/createTopic` resource. Finally, it is passed to the [Respond mediator]({{base_path}}/reference/mediators/respond-Mediator/). The Respond Mediator stops the processing on the current message and sends the message back to the client as a response.            
    
    1. Drag and drop the **respond mediator** to the **Design view**. 
    
         <img src="{{base_path}}/assets/img/integrate/connectors/smpp-drag-and-drop-respond-mediator.png" title="Add Respond mediator" width="800" alt="Add Respond mediator"/> 

    2. Once you have setup the sequences and API, you can see the `/createTopic` resource as shown below.
    
         <img src="{{base_path}}/assets/img/integrate/connectors/createtopic-design-view.png" title="API Design view" width="600" alt="API Design view"/>
               
**Configure a resource for the publishMessage operation**

1. Initialize the connector.
   
   1. Initialize the connector. You can use the same configuration to initialize the connector. Please follow the steps given in section 1 for setting up the init operation to the createTopic operation.
    
   2. Set up the `publishMessage` operation. Navigate into the **Palette** pane and select the graphical operations icons listed under **Googlepubsub Connector** section. Then drag and drop the `publishMessage` operation into the **Design pane**.
       
       - **projectId** : The unique ID of the project within which the topic is created.
       - **topicName** : The name of the topic for which you want to create a subscription.
       - **data** :  The message payload.
            
       <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-api-publishmessage-operation.png" title="Add values to the createTopicSubscription operation" width="800" alt="Add values to the createTopicSubscription operation"/>
               
   3. Add the property mediator to capture the `topicName` values.               
           
       - **name** : topicName
       - **expression** : json-eval($.topicName)
       
       <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-topicname1.png" title="Add values to the topicName operation" width="800" alt="Add values to the topicName operation"/>
       
   4. Add the property mediator to capture the `data` values.    
       
       - **name** : data
       - **expression** : json-eval($.data)
       
       <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-data.png" title="Add values to the data operation" width="800" alt="Add values to the data operation"/>

**Configure a resource for the pullMessage operation**

1. Initialize the connector.
   
   1. Initialize the connector. You can use the same configuration to initialize the connector. Please follow the steps given in section 1 for setting up the init operation to the createTopic operation
    
   2. Set up the `publishMessage` operation. Navigate into the **Palette** pane and select the graphical operations icons listed under **Googlepubsub Connector** section. Then drag and drop the `publishMessage` operation into the **Design pane**.
       
       - **projectId** : The unique ID of the project within which the topic is created.
       - **subscriptionName** : The name of the topic for which you want to create a subscription.
       - **maxMessages** :  The maximum number of messages to retrieve.
       - **returnImmediately** : Set this to true if you want the server to respond immediately.
            
       <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-pullmessages.png" title="Add values to the pull messages operation" width="800" alt="Add values to the pull messages operation"/>
               
   3. Add the property mediator to capture the `subscriptionName` values. Follow the steps given in createTopicSubscription operation.     
           
Now you can switch into the Source view and check the XML configuration files of the created API and sequences.    
    !!! note "pubsubApi.xml"
        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <api context="/resources" name="pubsubApi" xmlns="http://ws.apache.org/ns/synapse">
            <resource methods="POST" url-mapping="/createTopic">
                <inSequence>
                    <property expression="json-eval($.topicName)" name="topicName" scope="default" type="STRING"/>
                    <property expression="json-eval($.subscriptionName)" name="subscriptionName" scope="default" type="STRING"/>
                    <googlepubsub.init>
                        <accessToken>ya29.a0AfH6SMA0MU0Frk_7gNnA79QUWQGnalPXvmkoA4MYS8p8Mt9OSC5SUqqcqIjcrP-_ollVB9gpeg3SufbCpASMCWyHcVCN6ZMCbqz4IdQqRVi8Kt22tI6gR5zvgtWn1qFWnYnGQ6Ehqi_mS9k0PL_R-kQcl-AkqveA8ZY</accessToken>
                        <apiUrl>https://pubsub.googleapis.com</apiUrl>
                        <apiVersion>v1</apiVersion>
                    </googlepubsub.init>
                    <googlepubsub.createTopic>
                        <projectId>ei-connector-improvement</projectId>
                        <topicName>{$ctx:topicName}</topicName>
                    </googlepubsub.createTopic>
                    <property expression="json-eval($.name)" name="nameforsubscription" scope="default" type="STRING"/>
                    <property expression="fn:tokenize($ctx:nameforsubscription,'/')[last()]" name="test" scope="default" type="STRING" xmlns:fn="http://www.w3.org/2005/xpath-functions"/>
                    <googlepubsub.init>
                        <accessToken>ya29.a0AfH6SMA0MU0Frk_7gNnA79QUWQGnalPXvmkoA4MYS8p8Mt9OSC5SUqqcqIjcrP-_ollVB9gpeg3SufbCpASMCWyHcVCN6ZMCbqz4IdQqRVi8Kt22tI6gR5zvgtWn1qFWnYnGQ6Ehqi_mS9k0PL_R-kQcl-AkqveA8ZY</accessToken>
                        <apiUrl>https://pubsub.googleapis.com</apiUrl>
                        <apiVersion>v1</apiVersion>
                    </googlepubsub.init>
                    <googlepubsub.createTopicSubscription>
                        <projectId>ei-connector-improvement</projectId>
                        <subscriptionName>{$ctx:subscriptionName}</subscriptionName>
                        <topicName>{$ctx:test}</topicName>
                        <ackDeadlineSeconds>30</ackDeadlineSeconds>
                    </googlepubsub.createTopicSubscription>
                    <respond/>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </resource>
            <resource methods="POST" url-mapping="/insertcompanynotifications">
                <inSequence>
                    <property expression="json-eval($.topicName)" name="topicName" scope="default" type="STRING"/>
                    <property expression="json-eval($.data)" name="data" scope="default" type="STRING"/>
                    <googlepubsub.init>
                        <accessToken>ya29.a0AfH6SMA0MU0Frk_7gNnA79QUWQGnalPXvmkoA4MYS8p8Mt9OSC5SUqqcqIjcrP-_ollVB9gpeg3SufbCpASMCWyHcVCN6ZMCbqz4IdQqRVi8Kt22tI6gR5zvgtWn1qFWnYnGQ6Ehqi_mS9k0PL_R-kQcl-AkqveA8ZY</accessToken>
                        <apiUrl>https://pubsub.googleapis.com</apiUrl>
                        <apiVersion>v1</apiVersion>
                    </googlepubsub.init>
                    <googlepubsub.publishMessage>
                        <projectId>ei-connector-improvement</projectId>
                        <topicName>{$ctx:topicName}</topicName>
                        <data>{$ctx:data}</data>
                    </googlepubsub.publishMessage>
                    <respond/>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </resource>
            <resource methods="POST" url-mapping="/getcompanynotifictions">
                <inSequence>
                    <property expression="json-eval($.subscriptionName)" name="subscriptionName" scope="default" type="STRING"/>
                    <googlepubsub.init>
                        <accessToken>ya29.a0AfH6SMDDFZCdoo37Tb48MrJU-ZnNoyrYqNY8r5cgWX0kD7n3GBhZr_TbicfvywjKwGYaZEBV50_yGINVOhZr_4jFMu2O03c87NiDCBpKW5zdsnl3x9iWdsosjDoE7uAGEKKLikPgnKfcgilGB2d-MBzu_c2e53kXG6A</accessToken>
                        <apiUrl>https://pubsub.googleapis.com</apiUrl>
                        <apiVersion>v1</apiVersion>
                    </googlepubsub.init>
                    <googlepubsub.pullMessage>
                        <projectId>ei-connector-improvement</projectId>
                        <subscriptionName>{$ctx:subscriptionName}</subscriptionName>
                        <maxMessages>2</maxMessages>
                        <returnImmediately>false</returnImmediately>
                    </googlepubsub.pullMessage>
                    <respond/>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </resource>
        </api>
        ```

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/googlepubsub-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the simulator details and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!reference/connectors/deploy-capp.md!}   

## Testing

Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).

1. Create a Topic for store company update notifications.

**Sample request**

  ```
    curl -v POST -d '{"topicName":"CompanyUpdates","subscriptionName": "SubscriptionForCompanyUpdates"}' "http://localhost:8290/resources/createTopic" -H "Content-Type:application/json"
  ```
**Expected response**

  ```json
  {
      "name": "projects/ei-connector-improvement/subscriptions/SubscriptionForCompanyUpdates",
      "topic": "projects/ei-connector-improvement/topics/CompanyUpdates",
      "pushConfig": {},
      "ackDeadlineSeconds": 30,
      "messageRetentionDuration": "604800s",
      "expirationPolicy": {
          "ttl": "2678400s"
      }
  }
  ```
**You will see the results from G-Cloud console**
  
  - Created Topic.
  
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-gcloudtopic.png" title="pubsub-gcloudTopic" width="800" alt="pubsub-gcloudTopic"/>
    
  - Created subscription for the Topic that you specify in the G-Cloud.
    
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-gcloudsubscription.png" title="pubsub-gcloudSubscription" width="800" alt="pubsub-gcloudSubscription"/>
  
2. Insert company update notifications to the created topic.

**Sample request**

  ```
    curl -v POST -d '{"topicName":"CompanyUpdates", "data":"This is first notification"}' "http://localhost:8290/resources/insertcompanynotifications" -H "Content-Type:application/json"
  ```
**Expected response**

  ```json
  {
      "messageIds": [
          "1268617220412368"
      ]
  }
  ```
3. Retrieve company updates from the created topic.

**Sample request**

  ```
    curl -v POST -d '{"subscriptionName":"SubscriptionForCompanyUpdates"}' "http://localhost:8290/resources/getcompanynotifictions" -H "Content-Type:application/json"
  ```
**Expected response**

  ```json
  {
      "receivedMessages": [
          {
              "ackId": "ISE-MD5FU0RQBhYsXUZIUTcZCGhRDk9eIz81IChFEgIIFAV8fXFYW3VfVBoHUQ0Zcnxmd2NTQQhXRFB_VVsRDXptXFcnUA8fentgcmhYEwUDR1B4V3Pr67-C9PCXYxclSpuLu6xvM8byp5xMZho9XxJLLD5-NjNFQV5AEkw9BkRJUytDCypYEU4E",
              "message": {
                  "data": "VGhpcyBpcyBmaXJzdCBub3RpZmljYXRpb24=",
                  "messageId": "1268617220412368",
                  "publishTime": "2020-06-09T15:36:35.632Z"
              }
          }
      ]
  }
  ```  
**You will see the results from G-Cloud console**
  
  - View published company update notification.
  
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-viewmessages.png" title="pubsub-viewmessages" width="800" alt="pubsub-viewmessages"/>  
    
## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).