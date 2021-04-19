# Gmail Connector Example

The Gmail Connector allows you to access the [Gmail REST API](https://developers.google.com/gmail/api/v1/reference) from an integration sequence. 

## What you'll build

<img src="{{base_path}}/assets/img/integrate/connectors/gmailconnector.png" title="Using Gmail Connector" width="800" alt="Using Gmail Connector"/>

This example demonstrates a scenario where a customer feedback Gmail account of a company can be easily managed using the WSO2 Gmail Connector. This application contains a service that can be invoked through an HTTP GET request. Once the service is invoked, it returns the contents of unread emails in the Inbox under the label of Customers, while sending an automated response to the customer, thanking them for their feedback. The number of emails that can be handled in a single invocation is specified in the application.

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

1. Follow these steps to set up the Integration Project and the Connector Exporter Project. 
{!reference/connectors/importing-connector-to-integration-studio.md!}

2. Right click on the created Integration Project and select, -> **New** -> **Rest API** to create the REST API. 
    <img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

3. Follow these steps to [configure the Gmail API]({{base_path}}/reference/connectors/gmail-connector/configuring-gmail-api/) and obtain the Client Id, Client Secret, Access Token and Refresh Token. 

4. Provide the API name as **SendMails**. You can go to the source view of the XML configuration file of the API and copy the following configuration. 
```xml
<?xml version="1.0" encoding="UTF-8"?>
<api context="/sendmails" name="SendMails" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="GET">
        <inSequence>
            <gmail.init>
                <userId></userId>
                <accessToken></accessToken>
                <apiUrl>https://www.googleapis.com/gmail</apiUrl>
                <clientId></clientId>
                <clientSecret></clientSecret>
                <refreshToken></refreshToken>
            </gmail.init>
            <gmail.listAllMails>
                <includeSpamTrash>false</includeSpamTrash>
                <maxResults>20</maxResults>
                <q>is:unread label:customers</q>
            </gmail.listAllMails>
            <iterate expression="json-eval($.messages)">
                <target>
                    <sequence>
                        <sequence key="reply"/>
                    </sequence>
                </target>
            </iterate>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
</api>
```

5. Right click on the created Integration Project and select **New** -> **Sequence** to create the defined sequence called **reply**. 

6. Provide the Sequence name as **reply**. You can go to the source view of the XML configuration file of the API and copy the following configuration. 
```xml
<?xml version="1.0" encoding="UTF-8"?>
<sequence name="reply" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
    <property expression="json-eval($.id)" name="msgId" scope="default" type="STRING"/>
    <gmail.getAccessTokenFromRefreshToken>
        <clientId></clientId>
        <clientSecret></clientSecret>
        <refreshToken></refreshToken>
    </gmail.getAccessTokenFromRefreshToken>
    <gmail.readMail>
        <id>{$ctx:msgId}</id>
    </gmail.readMail>
    <property expression="json-eval($.payload.headers[6].value)" name="response" scope="default" type="STRING"/>
    <log level="custom">
        <property expression="get-property('response')" name="response1"/>
    </log>
    <gmail.getAccessTokenFromRefreshToken>
        <clientId></clientId>
        <clientSecret></clientSecret>
        <refreshToken></refreshToken>
    </gmail.getAccessTokenFromRefreshToken>
    <gmail.sendMail>
        <to>{$ctx:response}</to>
        <subject>Best of Europe - 6 Countries in 9 Days</subject>
        <from>isurumuy@gmail.com</from>
        <messageBody>Thank you for your valuable feedback.</messageBody>
    </gmail.sendMail>
</sequence>
```
7. In the Rest API and in the Sequence, provide your obtained **Client ID**, **Client Secret**, **Access Token**, and **Refresh Token** accordingly. The **userID** should be your Gmail address. 

8. Follow these steps to export the artifacts. 
{!reference/connectors/exporting-artifacts.md !}

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/gmailconnector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the value of the access token and make other such changes before deploying and running this project.

## Deployment
Follow these steps to deploy the exported CApp in the integration runtime.<br>

{!reference/connectors/deploy-capp.md!}

## Testing
Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).

```
  curl -H "Content-Type: application/json" --request GET http://localhost:8290/sendmails
```

The senders should receive an email with a subject of "Best of Europe — 6 Countries in 9 Days", and a body of "Thank you for your valuable feedback."

## What's Next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
* To customize this example for your own scenario, see [Gmail Connector Configuration]({{base_path}}/reference/connectors/gmail-connector/gmail-connector-config/) documentation.