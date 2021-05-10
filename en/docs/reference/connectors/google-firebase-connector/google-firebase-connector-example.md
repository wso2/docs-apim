# Google Firebase Connector Example   

**Google Firebase Connector** is useful for integrating Google Firebase with other enterprise applications, on-premise or cloud. You can generate notifications and send them to Firebase so that they will be triggered to all the registered devices on that topic.

Please refer to the links below for more use cases. 

* [Android Topic Messaging](https://firebase.google.com/docs/cloud-messaging/android/topic-messaging)
* [Android Firebase Push Notifications with Topic Message Subscription](https://inducesmile.com/android/android-firebase-push-notification-with-topic-message-subscription/)
* [Android Firebase Push Notifications video](https://www.youtube.com/watch?v=aG2JC8c9EK0)


## What you'll build

In this example let us see how we can use Google Firebase Connector to generate a push notification based on an HTTP API invocation. The integration logic will extract information from HTTP message to the API to generate the push notification. 

> **Note**: The connector can also be used to register a device to a particular topic on Firebase. We will not cover it here. We will also not cover how the notifications can be received using Android or IOS apps. Please refer to online resources to get know about them. 

Overall integration scenario would look like below. 
<br/><br/>
<img src="{{base_path}}/assets/img/integrate/connectors/google-firebase-scenario.png" title="Google Firebase Connector scenario" width="800" alt="Google Firebase Connector scenario"/>

## Setting up the environment

You need to create an application at Google Firebase and get the credentials required. Please follow [Setting up Google Firebase]({{base_path}}/reference/connectors/google-firebase-connector/google-firebase-setup/) on how to do that. 

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and import Google Firebase connector into it.

{!reference/connectors/importing-connector-to-integration-studio.md!} 

1. Right click on the created Integration Project and select, -> **New** -> **Rest API** to create the REST API.
2. Specify the API name as `FirebaseNotify` and API context as `/firebasenotify`. You can go to the source view of the XML configuration file of the API and copy the following configuration. 
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
    <api context="/firebasenotify" name="FirebaseNotify" xmlns="http://ws.apache.org/ns/synapse">
        <resource methods="POST" uri-template="/send">
            <inSequence>
                <log description="log message">
                    <property name="message" value="Google Firebase send notification"/>
                </log>
                <sequence key="MessageCreateSeq"/>
                <googlefirebase.init>
                    <accountType>service_account</accountType>
                    <projectId>teststatusapp</projectId>
                    <privateKeyId>4109637cc1c5c274p811db07d85769f902eb7341</privateKeyId>
                    <privateKey>-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCyw7v4edhZ4xcm\nzXiTuJHC8Km7AHMqX2UH7yuEf5t2TmPrC3B2l/BA5PY6wwSqA4aoF04rBm0eWW3E\ny8sSUhP7Jkm4yEq16N0IfCsyP04u6pOxSdV2hHlVg8xWwQVJwxMZ19bQjJQIONV2\n7epm6GLnBbZX+sx+HSoOtxFTV5BAsu1blfiyrx/Epvoyw7cicPj0uiPx6R1a+qK+\n2h7wFapLZMsdilvJpcj57S+huwI+G7qSH79kRehyWTfqDKrPHzrdNJ5j880vahM9\n+JhZS8lXHOZt/UA1p2IvsISKP03iFJxrBggWtyW1ld+0qc8QTKQmyQFk6GIhdchp\n5HZ+omqJAgMBAAECggEABrUP9qlECCUHFjmqeE4aFPtV6PpB4pv973u72/le5kQC\ncnwamgPb0TmDW24kpjDWmB8OESXzyT+FKMzrMi/8x9p2dL26H47B9VVVrb7WPS3S\nwQ8Hw04XkIZ05SfnSIQD3FSUKX1uzqCq8g7dnG3EITjTsBkiRqnrjS4KqGrTiCPb\npFREwyePsAx4v2KnI9TL77K9mtZ93Hys+bDj5477FwZ76zqiy56H+v0MzxpSdV0x\nJrTe5VVpgZFi+q1qPMdCUmtx+MTMzCT1ZsOXPCLJqXkpCuVsdLZjNwyfUT3URCdV\nZ3Aw6CQ8YIBmb1eApCdqoxuIZiIsfgaCbrAqPlAnYQKBgQD1D9DhH17NEbfcWxmz\n9lhfIgh/2BgliS4D9w060D3QNR9680gACZC5FjDxWDB490/zUZ+Vj7jiNO9AtXFP\nhLVxIklzh2uJc7YdlEOXSQ8STrgQaBv4MUg2S31XvUtVu5ziuf9f9eBJvMt+cEQk\niNBnS0yivXWcJoRetDa411szYQKBgQC6vmCYd1k0wq5qppvUSAsBDnJ3oAQS1W9X\nphZbLs7Kvkcfno5xOOfsuqF4JJy1vN/yqJ7Y+zVXlf3ZBkfYC5r9piNtkriSsDzB\nFhk1tIpHq2meeq02N7SK2+avn6DrePEr259tT6A2izMp6Y4wIxMgaU/+F8mayNpz\n3Ib69oUwKQKBgQCJ4PksAGNtS7+/qj3+4+Z6uAJCM8n6LIGIV5LI+Wsd3xW0Lnbf\nFoKnsFWfJHg5RyRjiRQZqQBjvVazeKKlE8ymN51N8+5MKp9XaxjQYJmrOkETcg/y\nh3/SlIyUNfvR47n0UqPdUNB9jEyN+gpM5/EhfNtEYQZv8bfeNNTpELnOJQKBgH34\niI6xC8MUhLW6+ClmA85NoZfioHzX74jvp+sQkzyeyLmiqrHj0keVyfCSuge6hlNZ\nvfXe16firV+l5fbuNTpfxUxYChwhuIoDzzOepP0du1zFomyNfUDvvBjClLnjVsTg\nHRaO/SNuGTBvtZPxRSi7AdQE1eGNFhfMLl3CyCupAoGATNzKTIbNVDVTlEECBr0s\nu9VsEJvgunEVhIqf8HPJdqhc3gz7zsvDi5CIrkbKlVJ0gFcOk0zF3VeXBLNgW99S\nbVGnHve/hCnta4DJI6/AOvHR8FXgjEg7Oq8KvbpjSret2BxM9bqypcw4rFSlbjNr\nDxoPamy2NZkhs+pm+IFQNPs=\n-----END PRIVATE KEY-----\n</privateKey>
                    <clientEmail>firebase-adminsdk-slyr1@teststatusapp.iam.gserviceaccount.com</clientEmail>
                    <clientId>110823266879433001255</clientId>
                    <authUri>https://accounts.google.com/o/oauth2/auth</authUri>
                    <tokenUri>https://oauth2.googleapis.com/token</tokenUri>
                    <authProviderCertUrl>https://www.googleapis.com/oauth2/v1/certs</authProviderCertUrl>
                    <clientCertUrl>https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-slyr1%40teststatusapp.iam.gserviceaccount.com</clientCertUrl>
                </googlefirebase.init>
                <googlefirebase.sendMessage>
                    <messagingType>topic</messagingType>
                    <dryRunMode>false</dryRunMode>
                    <topicName>status</topicName>
                    <condition>'status' in topics</condition>
                    <dataFieldsOfMessage>{$ctx:dataFieldsOfMessage}</dataFieldsOfMessage>
                    <notificationTitle>{$ctx:notificationTitle}</notificationTitle>
                    <notificationBody>{$ctx:notificationBody}</notificationBody>
                    <androidPriority>{$ctx:androidPriority}</androidPriority>
                    <timeToLiveDuration>{$ctx:timeToLiveDuration}</timeToLiveDuration>
                    <restrictedPackageName>{$ctx:restrictedPackageName}</restrictedPackageName>
                    <collapseKey>{$ctx:collapseKey}</collapseKey>
                    <dataFieldsOfAndroidConfig>{$ctx:dataFieldsOfAndroidConfig}</dataFieldsOfAndroidConfig>
                    <androidNotificationTitle>{$ctx:androidNotificationTitle}</androidNotificationTitle>
                    <androidNotificationBody>{$ctx:androidNotificationBody}</androidNotificationBody>
                    <androidClickAction>{$ctx:androidClickAction}</androidClickAction>
                    <androidIcon>{$ctx:androidIcon}</androidIcon>
                    <androidColor>{$ctx:androidColor}</androidColor>
                    <androidTag>{$ctx:androidTag}</androidTag>
                    <androidSound>{$ctx:androidSound}</androidSound>
                    <androidTitleLocalizationKey>{$ctx:androidTitleLocalizationKey}</androidTitleLocalizationKey>
                    <androidBodyLocalizationKey>{$ctx:androidBodyLocalizationKey}</androidBodyLocalizationKey>
                    <androidTitleLocalizationArgs>{$ctx:androidTitleLocalizationArgs}</androidTitleLocalizationArgs>
                    <androidBodyLocalizationArgs>{$ctx:androidBodyLocalizationArgs}</androidBodyLocalizationArgs>
                    <apnsHeaders>{$ctx:apnsHeaders}</apnsHeaders>
                    <apnsCustomData>{$ctx:apnsCustomData}</apnsCustomData>
                    <apnsBadge>{$ctx:apnsBadge}</apnsBadge>
                    <apnsSound>{$ctx:apnsSound}</apnsSound>
                    <apnsContentAvailable>{$ctx:apnsContentAvailable}</apnsContentAvailable>
                    <apnsCategory>{$ctx:apnsCategory}</apnsCategory>
                    <apnsThreadId>{$ctx:apnsThreadId}</apnsThreadId>
                    <apnsAlertTitle>{$ctx:apnsAlertTitle}</apnsAlertTitle>
                    <apnsAlertBody>{$ctx:apnsAlertBody}</apnsAlertBody>
                    <webPushHeaders>{$ctx:webPushHeaders}</webPushHeaders>
                    <webPushData>{$ctx:webPushData}</webPushData>
                    <webPushNotificationTitle>{$ctx:webPushNotificationTitle}</webPushNotificationTitle>
                    <webPushNotificationBody>{$ctx:webPushNotificationBody}</webPushNotificationBody>
                    <webPushNotificationIcon>{$ctx:webPushNotificationIcon}</webPushNotificationIcon>
                    <webPushNotificationBadge>{$ctx:webPushNotificationBadge}</webPushNotificationBadge>
                    <webPushNotificationImage>{$ctx:webPushNotificationImage}</webPushNotificationImage>
                    <webPushNotificationLanguage>{$ctx:webPushNotificationLanguage}</webPushNotificationLanguage>
                    <webPushNotificationTag>{$ctx:webPushNotificationTag}</webPushNotificationTag>
                    <webPushNotificationDirection>{$ctx:webPushNotificationDirection}</webPushNotificationDirection>
                    <webPushNotificationRenotify>{$ctx:webPushNotificationRenotify}</webPushNotificationRenotify>
                    <webPushNotificationInteraction>{$ctx:webPushNotificationInteraction}</webPushNotificationInteraction>
                    <webPushNotificationSilent>{$ctx:webPushNotificationSilent}</webPushNotificationSilent>
                    <webPushNotificationTimestamp>{$ctx:webPushNotificationTimestamp}</webPushNotificationTimestamp>
                    <webPushNotificationVibrate>{$ctx:webPushNotificationVibrate}</webPushNotificationVibrate>
                </googlefirebase.sendMessage>
                <log description="log message">
                    <property name="message" value="Google Firebase sucessuflly sent notification"/>
                </log>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
    </api>
   ```
3. Right click on the created Integration Project and select, -> **New** -> **Sequence** to create a sequence. Here we will define the logic how the push notification should be constructed. You can extract the information from the incoming HTTP message and set to the properties so that they will be picked up by the connector to construct push notification message. All the fields are not mandatory - some are specific to Android devices and some are specific to Web apps.  Note how this sequence is called by the API. 
   ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <sequence name="MessageCreateSeq" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
        <propertyGroup>
            <property expression="json-eval($.dataFieldsOfMessage)" name="dataFieldsOfMessage" scope="default" type="STRING"/>
            <property expression="json-eval($.notificationTitle)" name="notificationTitle" scope="default" type="STRING"/>
            <property expression="json-eval($.notificationBody)" name="notificationBody" scope="default" type="STRING"/>
            <property expression="json-eval($.androidPriority)" name="androidPriority" scope="default" type="STRING"/>
            <property expression="json-eval($.timeToLiveDuration)" name="timeToLiveDuration" scope="default" type="STRING"/>
            <property expression="json-eval($.restrictedPackageName)" name="restrictedPackageName" scope="default" type="STRING"/>
            <property expression="json-eval($.collapseKey)" name="collapseKey" scope="default" type="STRING"/>
            <property expression="json-eval($.dataFieldsOfAndroidConfig)" name="dataFieldsOfAndroidConfig" scope="default" type="STRING"/>
            <property expression="json-eval($.androidNotificationTitle)" name="androidNotificationTitle" scope="default" type="STRING"/>
            <property expression="json-eval($.androidNotificationBody)" name="androidNotificationBody" scope="default" type="STRING"/>
            <property expression="json-eval($.androidClickAction)" name="androidClickAction" scope="default" type="STRING"/>
            <property expression="json-eval($.androidIcon)" name="androidIcon" scope="default" type="STRING"/>
            <property expression="json-eval($.androidColor)" name="androidColor" scope="default" type="STRING"/>
            <property expression="json-eval($.androidTag)" name="androidTag" scope="default" type="STRING"/>
            <property expression="json-eval($.androidSound)" name="androidSound" scope="default" type="STRING"/>
            <property expression="json-eval($.androidTitleLocalizationKey)" name="androidTitleLocalizationKey" scope="default" type="STRING"/>
            <property expression="json-eval($.androidBodyLocalizationKey)" name="androidBodyLocalizationKey" scope="default" type="STRING"/>
            <property expression="json-eval($.androidTitleLocalizationArgs)" name="androidTitleLocalizationArgs" scope="default" type="STRING"/>
            <property expression="json-eval($.androidBodyLocalizationArgs)" name="androidBodyLocalizationArgs" scope="default" type="STRING"/>
            <property expression="json-eval($.apnsHeaders)" name="apnsHeaders" scope="default" type="STRING"/>
            <property expression="json-eval($.apnsCustomData)" name="apnsCustomData" scope="default" type="STRING"/>
            <property expression="json-eval($.apnsBadge)" name="apnsBadge" scope="default" type="STRING"/>
            <property expression="json-eval($.apnsSound)" name="apnsSound" scope="default" type="STRING"/>
            <property expression="json-eval($.apnsContentAvailable)" name="apnsContentAvailable" scope="default" type="STRING"/>
            <property expression="json-eval($.apnsCategory)" name="apnsCategory" scope="default" type="STRING"/>
            <property expression="json-eval($.apnsThreadId)" name="apnsThreadId" scope="default" type="STRING"/>
            <property expression="json-eval($.apnsAlertTitle)" name="apnsAlertTitle" scope="default" type="STRING"/>
            <property expression="json-eval($.apnsAlertBody)" name="apnsAlertBody" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushHeaders)" name="webPushHeaders" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushData)" name="webPushData" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationTitle)" name="webPushNotificationTitle" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationBody)" name="webPushNotificationBody" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationIcon)" name="webPushNotificationIcon" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationBadge)" name="webPushNotificationBadge" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationImage)" name="webPushNotificationImage" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationLanguage)" name="webPushNotificationLanguage" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationTag)" name="webPushNotificationTag" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationDirection)" name="webPushNotificationDirection" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationRenotify)" name="webPushNotificationRenotify" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationInteraction)" name="webPushNotificationInteraction" scope="default" type="STRING"/>
            <property expression="json-eval($.webPushNotificationSilent)" name="webPushNotificationSilent" scope="default" type="STRING"/>
        </propertyGroup>
    </sequence>
   ```

> **Note**: The parameters under `<init>` section of the configuration above are referring to the credentials we obtained from Google Firebase in above steps. The parameters are mapped to the keys of the JSON file that you have downloaded as below. 

```
accountType --> type
projectId --> project_id
privateKeyId --> private_key_id
privateKey --> private_key
clientEmail --> client_email
clientId --> client_id
authUri --> auth_uri
tokenUri --> token_uri
authProviderCertUrl --> auth_provider_x509_cert_url
clientCertUrl --> client_x509_cert_url
```

Now we can export the imported connector, sequence, and the API into a single CAR application. CAR application is the one we are going to deploy to server runtime.


{!reference/connectors/exporting-artifacts.md!}

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/google-firebase-test-project.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the value of the credentials and make other such changes before deploying and running this project.

## Deployment

Now the exported CApp can be deployed in the integration runtime so that we can run it and test. 

**Note**: Download the following .jar files. 
1. [firebase-admin-6.5.0.jar](https://mvnrepository.com/artifact/com.google.firebase/firebase-admin/6.5.0)
2. [google-auth-library-credentials-0.11.0.jar](https://mvnrepository.com/artifact/com.google.auth/google-auth-library-credentials/0.11.0)
3. [google-auth-library-oauth2-http-0.11.0.jar](https://mvnrepository.com/artifact/com.google.auth/google-auth-library-oauth2-http/0.11.0)
4. [api-common-1.7.0.jar](https://mvnrepository.com/artifact/com.google.api/api-common/1.7.0)
and place those into `<Product_HOME>/lib` folder.

{!reference/connectors/deploy-capp.md!}

## Testing

We can use Curl or Postman to try the API. The testing steps are provided for curl. Steps for Postman should be straightforward and can be derived from the curl requests.

1. Create a file called data.xml with the following content. 
    ```
     {
        "dataFieldsOfMessage":"key1:value1,key2:value2",
        "notificationTitle":"test title",
        "notificationBody":"test body",
        "androidPriority":"normal",
        "timeToLiveDuration":"123",
        "restrictedPackageName":"com.google.firebase.quickstart.fcm",
        "collapseKey":"test-key",
        "dataFieldsOfAndroidConfig":"key3:value3,key4:value4",
        "androidNotificationTitle":"Android Notification title",
        "androidNotificationBody":"Android Notification body",
        "androidClickAction":"android.intent.action.SHOW_APP_INFO",
        "androidIcon":"@mipmap/ic_launcher",
        "androidColor":"#112233",
        "androidTag":"test-tag",
        "androidSound":"@raw/bryan_sample",
        "androidTitleLocalizationKey":"notification_title_string",
        "androidBodyLocalizationKey":"notification_message_string",
        "androidTitleLocalizationArgs":"t-arg2,t-arg3",
        "androidBodyLocalizationArgs":"b-arg2,b-arg3",
        "apnsHeaders":"header1:value1,header2:value2",
        "apnsCustomData":"key5:value5,key6:value6",
        "apnsBadge":"42",
        "apnsSound":"apnsSound",
        "apnsContentAvailable":true,
        "apnsCategory":"category",
        "apnsThreadId":"Thread-Id",
        "apnsAlertTitle":"alert-title",
        "apnsAlertBody":"alert-body",
        "webPushHeaders":"header3:value3,header4:value4",
        "webPushData":"key7:value7,key8:value8",
        "webPushNotificationTitle":"web-notification-title",
        "webPushNotificationBody":"web-notification-body",
        "webPushNotificationIcon":"https://img.icons8.com/color/2x/baby-app.png",
        "webPushNotificationBadge":"https://img.icons8.com/color/2x/ipad.png",
        "webPushNotificationImage":"https://img.icons8.com/color/2x/ios-photos.png",
        "webPushNotificationLanguage":"TA",
        "webPushNotificationTag":"web-Tag",
        "webPushNotificationDirection":"AUTO",
        "webPushNotificationRenotify":true,
        "webPushNotificationInteraction":false,
        "webPushNotificationSilent":false,
        "webPushNotificationTimestamp":"100",
        "webPushNotificationVibrate":"200,100,200"
    }
    ```
2. Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).
    ```
    curl -H "Content-Type: application/json" --request POST --data @data.xml http://127.0.0.1:8280/firebasenotify/send
    ```
**Expected Response**:
    ```
    {
        "Result": {
            "MessageID": "projects/teststatusapp/messages/1079202156867212695"
        }
    }
    ```
If you have registered some devices to your application, the notification will appear on that device. 

## What's Next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/setup/installation/run_in_containers).
* Please read the [Google Firebase Connector reference guide]({{base_path}}/reference/connectors/google-firebase-connector/google-firebase-configuration/) to learn more about the operations you can perform with the connector.