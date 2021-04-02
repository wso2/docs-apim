# Email Connector Example

Email Connector can be used to perform operations using protocols SMTP, IMAP and POP3. 

## What you'll build

This example explains how to use Email Connector to send an email and retrieve the same email from Gmail. The user sends a payload with the recipients and content of the email. Then, by invoking another API resource, the content of the sent email will be retrieved. 

The example consists of an API named as EmailConnector API with two resources `send` and `retrieve`. 

* `/send `: The user sends the request payload which includes the recipients, content and attachments of the email. This request is sent to the integration runtime by invoking the EmailConnector API. It will send the email to the relevant recipients. 

    <p><img src="{{base_path}}/assets/img/integrate/connectors/email-conn-14.png" title="Send function" width="800" alt="Send function" /></p>

* `/retrieve `: The user sends the request payload, containing the filter to search the received email. This request is sent to the integration runtime where the EmailConnector API resides. Once the API is invoked, it returns the filtered emails.

    <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-15.png" title="Retrieve function" width="800" alt="Retrieve function"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

## Creating the Integration Logic

1. Right click on the created Integration Project and select, -> **New** -> **Rest API** to create the REST API. 
   <img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

2. Provide the API name as Email Connector and the API context as `/emailconnector`.

3. First we will create the `/send` resource. This API resource will retrieve information from the incoming HTTP post request such as recipients and content and construct the email and send to the mentioned recipients.<br/>
   Right click on the API Resource and go to **Properties** view. We use a URL template called `/send` as we have two API resources inside single API. The method will be `Post`. 
   <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-1.png" title="Adding the API resource." width="800" alt="Adding the API resource."/>

4. In this operation we are going to receive following inputs from the user. 
    - from - Sender of the email.
    - to - Recipient of the email. 
    - subject - Subject of the email.
    - content - Content to be included in the email.
    - contentType - Content Type of the email

5. Drag and drop the 'send' operation of the Email Connector to the Design View as shown below.
   <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-2.png" title="Adding the send operation." width="800" alt="Adding the send operation."/>

6. Create a connection from the properties window by clicking on the '+' icon as shown below.
    <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-3.png" title="Adding the connection." width="800" alt="Adding the connection."/>

    In the pop up window, following parameters must be provided. <br/>
    
    - Connection Name - Unique name to identify the connection by.
    - Connection Type - Type of the connection which specifies the protocol to be used.
    - Host - Host name of the mail server.
    - Port - The port number of the mail server.
    - Username - Username used to connect with the mail server.
    - Password - Password to connect with the mail server.

    Following values can be provided to connect to Gmail. <br/>
    
    - Connection Name - smtpsconnection
    - Connection Type - SMTP Secured Connection
    - Host - smtp.gmail.com
    - Port - 465
    - Username - &lt;your_email_address&gt;
    - Password - &lt;your_email_password&gt; 
    > **NOTE**: If you have enabled 2-factor authentication, an app password should be obtained as instructed [here](https://support.google.com/accounts/answer/185833?hl=en).

    <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-4.png" title="Connection parameters." width="400" alt="Connection parameters."/>
    
7. After the connection is successfully created, select the created connection as 'Connection' from the drop down in the properties window.
   <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-5.png" title="Selecting the connection." width="800" alt="Selecting the connection."/>

8. Next, provide the expressions as below to the following properties in the properties window to obtain respective values from the JSON request payload.
    - to - json-eval($.to)
    - from - json-eval($.from)
    - subject - json-eval($.subject)
    - content - json-eval($.content)
    - contentType - json-eval($.contentType)
 
9. Drag and drop the [Respond Mediator]({{base_path}}/reference/mediators/respond-mediator/) to respond the response from sending the email as shown below.
   <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-6.png" title="Adding the respond mediator." width="800" alt="Adding the respond mediator."/>

10. Create the next API resource, which is `/retrieve` by dragging and dropping another API resource to the design view. This API resource will retrieve filters from the incoming HTTP post request from which to filter the email messages such as the subject, retrieve the emails, retrieve email body and respond back.
   This will be used to retrieve the email we just sent. This will also be a `POST` request.
   <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-7.png" title="Adding new resource." width="800" alt="Adding new resource."/>

11. Drag and drop the 'list' operation of the Email Connector to the Design View as shown below.
    <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-8.png" title="Adding list operation." width="800" alt="Adding list operation."/>

12. Next, we will create a IMAP connection to list emails similar to step 6. Following are the values to be provided when creating the connection.

    - Connection Name - imapsconnection
    - Connection Type - IMAP Secured Connection
    - Host - imap.gmail.com
    - Port - 993
    - Username - &lt;your_email_address&gt;
    - Password - &lt;your_email_password&gt;

13. In this operation we are going to receive following inputs from the user. 
    - subjectRegex - Subject Regex to filter the email from. <br/>
    
    Therefore, provide the expressions as below to the following properties in the properties window to obtain respective values from the JSON request payload.<br/>
    
    - Subject Regex: json-eval($.subjectRegex)
    
14. We will next iterate the response received and obtain the email content of each email using the `getEmailBody` operation. In order to do this, drag and drop the [Foreach Mediator]({{base_path}}/reference/mediators/foreach-mediator/) as shown below and enter `//emails/email` as the Foreach Expression in the properties window.
    <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-9.png" title="Adding foreach mediator." width="800" alt="Adding foreach mediator."/>

15. Inside the [Foreach Mediator]({{base_path}}/reference/mediators/foreach-mediator/), drag and drop the `getEmailBody` operation as shown below and provide the `//email/index/text()` expression as the Email Index.
    <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-10.png" title="Adding getEmailBody operation." width="800" alt="Adding getEmailBody operation."/>

    > **NOTE**: Further, you can use `getAttachment` operation to retrieve attachment content if there are any. Refer [Reference Documentation](email-connector-config/) to learn more.

16. Next, we will use a [Payload Factory Mediator]({{base_path}}/reference/mediators/payloadfactory-mediator/), to add the email content to the same response we received from `list` operation and configure the Payload mediator as shown below.
    <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-11.png" title="Adding payload factory mediator." width="800" alt="Adding payload facotry mediator."/>
    
    Enter following as the payload:
    ```xml
    <email>
        <emailID>$1</emailID>
        <to>$2</to>
        <from>$3</from>
        <subject>$4</subject>
        <textContent>$5</textContent>
    </email>
    ```
    
    Here, you may observe that we are obtaining `TEXT_CONTENT` property which is being set when getEmailBody is invoked to retrieve the email content. You can find the list of similar properties set in this operation [here]({{base_path}}/reference/connectors/email-connector/email-connector-config/).

17. Drag and drop a [Property Mediator]({{base_path}}/reference/mediators/property-mediator/) and set the Property name as 'messageType' and the value as application/json. This is added so that the response will be in json.
    <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-12.png" title="Adding property mediator." width="800" alt="Adding property mediator."/>

18. Finally, drag and drop the [Respond Mediator]({{base_path}}/reference/mediators/respond-mediator/) after the 'foreach' mediator to respond the response of retrieved emails.
    <img src="{{base_path}}/assets/img/integrate/connectors/email-conn-13.png" title="Adding property mediator." width="800" alt="Adding property mediator."/>

19. You can find the complete API XML configuration below. You can go to the source view and copy paste the following config.
```xml
<?xml version="1.0" encoding="UTF-8"?>
<api context="/emailconnector" name="EmailConnector" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="POST" uri-template="/send">
        <inSequence>
            <email.send configKey="smtpsconnection">
                <from>{json-eval($.from)}</from>
                <to>{json-eval($.to)}</to>
                <subject>{json-eval($.subject)}</subject>
                <content>{json-eval($.content)}</content>
                <contentType>{json-eval($.contentType)}</contentType>
            </email.send>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
    <resource methods="POST" uri-template="/retrieve">
        <inSequence>
            <email.list configKey="imapsconnection">
                <subjectRegex>{json-eval($.subjectRegex)}</subjectRegex>
            </email.list>
            <foreach expression="//emails/email">
                <sequence>
                    <email.getEmailBody>
                        <emailIndex>{//email/index/text()}</emailIndex>
                    </email.getEmailBody>
                    <payloadFactory media-type="xml">
                        <format>
                            <email xmlns="">
                                <emailID>$1</emailID>
                                <to>$2</to>
                                <from>$3</from>
                                <subject>$4</subject>
                                <textContent>$5</textContent>
                            </email>
                        </format>
                        <args>
                            <arg evaluator="xml" expression="//email/emailID"/>
                            <arg evaluator="xml" expression="//email/to"/>
                            <arg evaluator="xml" expression="//email/from"/>
                            <arg evaluator="xml" expression="//email/subject"/>
                            <arg evaluator="xml" expression="$ctx:TEXT_CONTENT"/>
                        </args>
                    </payloadFactory>
                </sequence>
            </foreach>
            <property name="messageType" scope="axis2" type="STRING" value="application/json"/>
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

<a href="{{base_path}}/assets/attachments/connectors/emailconnector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!reference/connectors/deploy-capp.md!}

## Testing

### Email Send Operation

1. Create a file called data.json with the following payload. We will send the email to ourself so that we can retrieve it later.
    ```
    {
        "from": "<your-email>@gmail.com",
        "to": "<your-email>@gmail.com",
        "subject": "Sample email",
        "content": "This is the body of the sample email",
        "contentType":"text/plain"
    }
    ```
2. Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).
    ```
    curl -H "Content-Type: application/json" --request POST --data @body.json http://localhost:8290/emailconnector/send
    ```
**Expected Response**: 
You should get a 'Success' response as below and you will receive the email.
    ```
    {
        "result": {
            "success": true
        }
    }
    ``` 

### Email List Operation

1. Create a file called data.json with the following payload. 
    ```
    {
        "subjectRegex":"Sample email"
    }
    ```
2. Invoke the API as shown below using the curl command.
    ```
    curl -H "Content-Type: application/json" --request POST --data @body.json http://localhost:8290/emailconnector/retrieve
    ```
**Expected Response**: 
You should get a response like below.
    ```
    {
        "emails": {
            "email": [
                {
                    "index": 0,
                    "emailID": "<1623446944.0.152334336343@localhost>",
                    "to": "<your-email>@gmail.com",
                    "from": "<your-email>@gmail.com",
                    "subject": "Sample email",
                    "textContent": "This is the body of the sample email"
                }
            ]
        }
    }
    ``` 

## What's Next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
* To customize this example for your own scenario, see [Email Connector Configuration]({{base_path}}/reference/connectors/email-connector/email-connector-config/) documentation for all operation details of the connector.
