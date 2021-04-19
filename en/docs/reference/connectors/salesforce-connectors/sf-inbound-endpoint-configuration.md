# Setting up the PushTopic in Salesforce

This documentation explains how to set up the Salesforce environment to connect with WSO2 Salesforce Inbound Endpoint. Please follow up the steps given below

* Create a custom object or object in Salesforce.
* Creating a PushTopic.
* Subscribing to the PushTopic Channel
* Testing the PushTopic Channel.
* Reset Security Token.
 
## Create a custom object or object in Salesforce.

As first step you need to [create a custom object in Salesforce](https://developer.salesforce.com/docs/atlas.en-us.202.0.api_streaming.meta/api_streaming/create_object.htm). In this scenario we use the `Account` object to store the records.
 
## Creating a PushTopic  

The [PushTopic](https://developer.salesforce.com/docs/atlas.en-us.202.0.api_streaming.meta/api_streaming/create_a_pushtopic.htm) record contains a SOQL query. Event notifications are generated for updates that match the query. Alternatively, you can also use Workbench to create a PushTopic. In this sample we using Salesforce Developer Console to create a Push Topic.

1. **Login** to the **Salesforce Account**. Navigate to the top right corner of the **Home page** and click the **Setup** icon. Then select **Developer Console**.

    <img src="{{base_path}}/assets/img/integrate/connectors/open-the-developer-console-updated.png" title="Open the Developer Console." width="500" alt="Open the Developer Console."/>

2. After populating the Developer console, click **Debug** -> Open **Execute Anonymous Window**.   
   
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-execute-anonymous-window-updated.png" title="Open the Anonymous Window." width="500" alt="Open the Anonymous Window."/>
   
3. Add the following entry in the **Enter Apex Code** window and click **Execute**.  
   
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-enter-apex-code-updated.png" title="Enter Apex code." width="700" alt="Enter Apex code."/> 
   
    ```
    PushTopic pushTopic = new PushTopic();
    pushTopic.Name = 'Account';
    pushTopic.Query = 'SELECT Id, Name FROM Account';
    pushTopic.ApiVersion = 37.0;
    pushTopic.NotifyForOperationCreate = true;
    pushTopic.NotifyForOperationUpdate = true;
    pushTopic.NotifyForOperationUndelete = true;
    pushTopic.NotifyForOperationDelete = true;
    pushTopic.NotifyForFields = 'Referenced';
    insert pushTopic;
    ```
   We are essentially creating a SOQL query with a few extra parameters that watch for changes in a specified object. If the Push Topic is executed successfully then Salesforce is ready to post notification to WSO2 Salesforce Inbound Endpoint, if any changes are made in the Account object in Salesforce. This is because the below Push Topic has been created for Salesforce's Account object. 
   
## Subscribing to the PushTopic Channel

In this step, we need to [subscribe](https://developer.salesforce.com/docs/atlas.en-us.202.0.api_streaming.meta/api_streaming/subscribe_to_pushtopic_channel.htm) to the channel that we created with the PushTopic record in the previous step. For this can be done through the `Workbench`. Workbench is a free, open source, community-supported tool that helps administrators and developers to interact with Salesforce for Data Insert, Update, Upsert, Delete, and Export purposes. 

> **Note**: Salesforce provides a hosted instance of Workbench for demonstration purposes only - Salesforce recommends that you do not use this hosted instance of Workbench to access data in a production database.

1. Using your browser, navigate to the [workbench](https://developer.salesforce.com/page/Workbench).

    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-slaesforce-login-workbench.png" title="Login Workbench." width="700" alt="Login Workbench."/> 

2. Select **Environment** as **Production** and **API Version** as **37.0**.
   
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-select-environment-updated.png" title="Select Environment." width="700" alt="Select Environment."/>

3. **Accept the terms of service**, and click **Login with Salesforce**.

4. After logging in with Salesforce, you establish a connection to your database, and land on the **Select page**.

    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-landing-page.png" title="Select page." width="700" alt="Select page."/>

5. Select **queries** -> **Streaming Push Topics**.

    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-streaming-push-topics-updated.png" title="Streaming PushTopic." width="700" alt="Streaming PushTopic."/>
   
6. In the **Push Topic** field, select **Account**.   
  
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-select-pushtopic-Account-updated.png" title="Select created PushTopic." width="700" alt="Select created PushTopic."/>

7. Click **Subscribe**. You’ll see the connection and response information and a response like `Subscribed to /topic/Account`.

    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-subscribe-updated.png" title="Subscribe to the PushTopic." width="700" alt="Subscribe to the PushTopic."/>
   
   > **Note**: Keep this browser window open and make sure that the connection does not time out. You’ll be able to see the event notifications triggered by the Account record you create when testing the PushTopic channel.
   
## Testing the PushTopic Channel.

1. Open new browser window and navigate to the [workbench](https://developer.salesforce.com/page/Workbench) using the same username and password. Please follow the steps given in `Subscribe to the PushTopic Channel` `Step 1`.

2. Select **data** -> **Insert**.

    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-data-insert-updated.png" title="Insert data to test the PushTopic." width="700" alt="Insert data to test the PudhTopic."/>

3. For **Object Type**, select *Account*. Ensure that the **Single Record** field is selected, and click **Next**. 
   
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-select-single-record-updated.png" title="Select single record." width="700" alt="Select single record."/>
   
4. Type in a value for the `Name` field. Then click **Confirm Insert**.
  
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-insert-values-to-Name-updated.png" title="Insert value to the object." width="500" alt="Insert value to the object."/>

5. Switch to your **Streaming Push Topics** browser window. You’ll see a notification that the *Account* update was created. The notification returns the `Id` and `Name` fields that we defined in the SELECT statement of our **PushTopic query**. Please find the notification message as shown bellow.
   
    ```
    Message received from: /topic/Account
    {
      "data": {
        "event": {
          "createdDate": "2020-04-21T13:02:56.967Z",
          "replayId": 11,
          "type": "created"
        },
        "sobject": {
          "Id": "0012x0000048qhUAAQ",
          "Name": "Doctor"
        }
      },
      "channel": "/topic/Account"
    }
    ```
## Reset Security Token

1. **Login** to the **Salesforce Account**. Navigate to the top right corner of the **Home page** and click **Settings**.

    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-click-settings-updated.png" title="Select Settings." width="400" alt="Select Settings"/> 

2. Select **Reset My Security Token** and then click **Reset Security Token** button.   
   
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-resetsecurity-token-updated.png" title="Reset Security Token." width="700" alt="Reset Security Token."/>
      
    When setting up the Inbound Endpoint you need to provide the Salesforce password in the following manner. The password provided here is a concatenation of the user password and the security token provided by Salesforce. For more information, see [information on creating a security token in Salesforce](https://help.salesforce.com/articleView?id=user_security_token.htm&type=5).
   
    Example : 
   
    | Field              | Value           |   
    | ------------------ |-----------------|
    |salesforce password | test123         |
    |Security Token      | XXXXXXXXXX      |
   
    ```<parameter name="connection.salesforce.password">test123XXXXXXXXXX</parameter>```