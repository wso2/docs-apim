# Google Firebase Connector Reference

## Initializing Google Firebase Connector

```
<googlefirebase.init>
```

```
<googlefirebase.init>
    <accountType>{$ctx:accountType}</accountType>
    <projectId>{$ctx:projectId}</projectId>
    <privateKeyId>{$ctx:privateKeyId}</privateKeyId>
    <privateKey>{$ctx:privateKey}</privateKey>
    <clientEmail>{$ctx:clientEmail}</clientEmail>
    <clientId>{$ctx:clientId}</clientId>
    <authUri>{$ctx:authUri}</authUri>
    <tokenUri>{$ctx:tokenUri}</tokenUri>
    <authProviderCertUrl>{$ctx:authProviderCertUrl}</authProviderCertUrl>
    <clientCertUrl>{$ctx:clientCertUrl}</clientCertUrl>
</googlefirebase.init>
```

**NOTE:**
The parameters under `<init>` section of the configuration above are referring to the credentials we obtained from Google Firebase. The parameters are mapped to the keys contained in the Json file that you have downloaded from Firebase.  

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
<br/>

## Sending Cloud Messaging messages to Firebase 

```
<googlefirebase.sendMessage>
```

It allows you to send Firebase Cloud Messaging messages to end-user devices. Specifically, you can send messages to individual devices, named topics, or condition statements that match one or more topics. The Admin FCM API enables constructing message payloads tailored to different target platforms (Android, iOS and Web). If a message payload contains configuration options for multiple platforms, the FCM service customizes the message for each platform when delivering. Firebase Cloud Messaging (FCM) offers different types of FCM messages. With FCM, you can send two types of messages to clients:

* Notification messages, sometimes thought of as "display messages."
* Data messages, which are handled by the client app.

For more info, see [https://firebase.google.com/docs/cloud-messaging/concept-options](https://firebase.google.com/docs/cloud-messaging/concept-options)

```
<googlefirebase.sendMessage>
    <messagingType>{$ctx:messagingType}</messagingType>
    <dryRunMode>{$ctx:dryRunMode}</dryRunMode>
    <registrationToken>{$ctx:registrationToken}</registrationToken>
    <topicName>{$ctx:topicName}</topicName>
    <condition>{$ctx:condition}</condition>
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
```


**Properties**

* messagingType - This will define the messaging type. It must contain exactly one of the "token", "topic" or "condition" value.
* registrationToken - If you specify "messagingType" as token, you must provide this value. FCM API allows you to send messages to individual devices by specifying a registration token for the target device. Registration tokens are strings generated by the client FCM SDKs for each end-user client app instance.
* topicName - If you specify "messagingType" as topic, you must provide this value. Name of the topic. Based on the publish/subscribe model, FCM topic messaging allows you to send a message to multiple devices that have opted in to a particular topic. You compose topic messages as needed, and FCM handles routing and delivering the message reliably to the right devices.
* condition - If you specify "messagingType" as condition, you must provide this value. And if you want to send a message to a combination of topics, you must specify this value. This is done by specifying a condition, which is a boolean expression that specifies the target topics.
* dryRunMode - It is used to send FCM messages in the dry run mode. It performs all the usual validations on the messages sent in this mode, but they are not actually delivered to the target devices.
* dataFieldsOfMessage - It defines key-value pair to the message as a data field. Eg: "key1:value1,key2:value2"
* notificationTitle - Sets the notification information (notification title) to be included in the message.
* notificationBody - Sets the notification information (notification body) to be included in the message
* androidPriority - Message priority. Must be one of "normal" and "high" values.
* timeToLiveDuration - The time-to-live duration of the message. This is how long the message will be kept in FCM storage if the target devices are offline. Maximum allowed is 4 weeks, which is also the default. Set to 0 to send the message immediately (fire and forget).
restrictedPackageName - Package name of the application where the registration tokens must match in order to receive the message.
* collapseKey - An identifier of a group of messages that can be collapsed, so that only the last message gets sent when delivery can be resumed. A maximum of 4 different collapse keys is allowed at any given time.
* dataFieldsOfAndroidConfig - A map of key-value pairs where each key and value are strings. If specified, overrides the data field set on the "dataFieldsOfMessage" property (top-level message). Eg: "key1:value1, key2:value2",
* androidNotificationTitle - Sets notification title that is specific to Android notifications.
* androidNotificationBody - Sets notification body that is specific to Android notifications.
* androidClickAction - Sets the action associated with a user click on the notification. If specified, an activity with a matching Intent Filter is launched when a user clicks on the notification.
* androidIcon - The notification icon. If not specified, FCM displays the launcher icon specified in your app manifest.
* androidColor - The notification's icon color, expressed in #rrggbb format.
* androidTag - Identifier used to replace existing notifications in the notification drawer. If not specified, each request creates a new notification. If specified and a notification with the same tag is already being shown, the new notification replaces the existing one in the notification drawer.
* androidSound - The sound to play when the device receives the notification. Supports default or the filename of a sound resource bundled in the app.
* androidTitleLocalizationKey - The key of the title string in the app's string resources to use to localize the title text to the user's current localization.
* androidBodyLocalizationKey - The key of the body string in the app's string resources to use to localize the body text to the user's current localization.
* androidTitleLocalizationArgs - A list of string values to be used in place of the format specifiers in "androidTitleLocalizationKey" to use to localize the title text to the user's current localization.
* androidBodyLocalizationArgs - A list of string values to be used in place of the format specifiers in "androidBodyLocalizationKey" to use to localize the body text to the user's current localization.
* apnsHeaders - HTTP request headers defined in Apple Push Notification Service. Refer to APNS request headers for supported headers. Eg: "header1:value1, header2:value2"
* apnsCustomData - A map of key-value pairs where each key and value are strings. If specified, overrides the data field set on the "dataFieldsOfMessage" (top-level message). Eg: "key1:value1, key2:value2"
* apnsBadge - Include this key when you want the system to modify the badge of your app icon. If this key is not included in the dictionary, the badge is not changed. To remove the badge, set the value of this key to 0.
* apnsSound - Include this key when you want the system to play a sound. The value of this key is the name of a sound file.
apnsContentAvailable - Include this key with a value of 1 to configure a background update notification. When this key is present, the system wakes up your app in the background and delivers the notification to its app delegate.
* apnsCategory - Provide this key with a string value that represents the notification’s type.
* apnsThreadId - Provide this key with a string value that represents the app-specific identifier for grouping notifications.
* apnsAlertTitle - Include this key when you want the system to display a standard alert. A short string describing the purpose of the notification.
* apnsAlertBody - Include this key when you want the system to display a standard alert. The text of the alert message.
* webPushHeaders - Adds the given key-value pair as a Webpush HTTP header. Refer to WebPush specification for supported headers. Eg:"header1:value1,header2:value2"
* webPushData - A map of key-value pairs where each key and value are strings. If specified, overrides the data field set on the "dataFieldsOfMessage" (top-level message). Eg: "key1:value1, key2:value2"
* webPushNotificationTitle - The title of the notification. This title overrides the corresponding field on the "notificationTitle" (top-level message notification).
* webPushNotificationBody - The body of the notification. This body overrides the corresponding field on the "notificationBody" (top-level message notification).
* webPushNotificationIcon - It contains the URL of an icon to be displayed as part of the web notification.
* webPushNotificationBadge - The URL of the image used to represent the notification when there is not enough space to display the notification itself.
* webPushNotificationImage - The URL of an image to be displayed as part of the notification.
* webPushNotificationLanguage - Sets the language of the notification.
* webPushNotificationTag - Sets an identifying tag on the notification. The idea of notification tags is that more than one notification can share the same tag, linking them together. One notification can then be programmatically replaced with another to avoid the users' screen being filled up with a huge number of similar notifications.
* webPushNotificationDirection - The text direction of the notification.
* webPushNotificationRenotify - Specifies whether the user should be notified after a new notification replaces an old one.
* webPushNotificationInteraction - A Boolean indicating that a notification should remain active until the user clicks or dismisses it, rather than closing automatically.
* webPushNotificationSilent - Specifies whether the notification should be silent. i.e., no sounds or vibrations should be issued, regardless of the device settings.
* webPushNotificationTimestamp - Specifies the time at which a notification is created or applicable.
* webPushNotificationVibrate - Specifies a vibration pattern for devices with vibration hardware to emit.


**Sample message**

```
{
   "accountType": "service_account",
   "projectId": "wso2-42209",
   "privateKeyId": "8d4ed1af9c0dsfdsfgdgdgsf55a7197b0ac9afe",
   "privateKey": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBdasfsggdgfhfjjkljlC3wkCC\nGKRvlPH1wqXPMhhsWEMH0k9OgiQ+XMdfsfnjgntenjtQ2VtTmCNBWyg/r+ff59KuqhQBs\nHy3ixWbSYW5XYd0ww6fT/UOH1dLYKSKLidEO6v2Rd2Xh+bxSwqi3IuyjuDy8WBJ6\n5NlV1HdKC5jZWrGZjVgooAHFs5WxhnTiYVWL4egOjzPzBiujWIJGfZCL91oPlqyf\nS4hn+JYh3yhOoCy2MpeDsreAcy9LuPdiR3u7Kqb49/e6pGf0Z2KjL4375OUEEK6S\nCixuZQPFHlnqXi6OcmsLqa+A0kmjkLlVHPe9iH6n5Ku7Ikd+P+7ycRS2W8SF6+fg\nIt7oO9LpAgMBAAECggEACQy65kOIq+W2gFYcSfLHjhwqj/FKiaexd94l91slYPpV\n44v2ghxpOqmDTFRNA1rdgTM0NlFbFnCx8wc3TWOuZTN+0RoMHouPZo2GKX7Epepg\nSiVNW9NSaVQZHbTuAHV8ST41U7M4AyG+t6i1JEx2recStG+QCfqi2/xV2V0kN6ZL\neUdGIznl6CmfOdz2mU9JDOVLMpGBEfjEv8B9QukO0odTAJTTlP/XFHVbjHn14B+O\nn2YSIqzXD0aBAJxsecxkDwRsXP3wlg0viAu/wa8b7m6vKMJPYTf85/TThiZNloer\nl1PHuvLfCSlgV0XltyMoUzcNBw8mQgP7ggq4bR1etQKBgQDdGixkmQNIs8X78qAC\nonH6dFG8lUbDbOQCmM1UgijyZHiUNCC0pO6tKCHv9XVkhv845xdv+uIBtxixnETT\njiAQchiy+KaBEUrFY2XPkJt4XKTY8hOhg60IMk4fD9QIl8GUMqp/6ut4YcFe3ldL\nPXWQBsKXLWH7G4GV7Cb9OwEsRQKBgQDDG/Amuxc5vodv78DGDop1BIixW4FXqowD\nYs7LCbzSCTeZ3NF3gqXkF8GJRmBj6GOkrOBfleeffyjeVAuyX/K6PbXUFzrn0bHi\nYG1zDLMXUZEIguK3aJwl3sDnqNYr5GK92Yt6nMmZwXY/0E60b54PJpg1oKy8hfug\nZBC/N8mgVQKBgCn4BeUyhkUOms4wR984Jpp76ef6Deyahs1XY+JespcQKzM2kd64\nT/XeYFLELPxgA6Ixe2luHehlcPKFzyq5F60He1i9ih2FwsOlEnZL5Lb8Hu5vRPqr\nm/SqV9ndj0nyRHR1CZguZ3P6WlI/siI+EEq+fcFkg+y+U+K5aM04nghhAoGBAKSR\n+TPCFWoYgobxVMn6U+E2LNJkm6nFagolGsZ59TG4opR+hJRot+K4Av/2Q7GhwAKT\n60HU4KVRDbjSbXdMpSFgkfFOktocrw2CRm+Ho7wkidADDpajfyoWROJiMByfrIX0\nbEjE3Ot7GnHjE6/wggLHjBWX7HusC72TCekwdjptAoGAZO2GhJq72eaKs4WoaQys\nkzUTlYxzeP3/hOJbJiD/p2VJkNfwSV5AkOYcPFAyEV5kydA7DwzAKLGaTk9a04Wx\nWXm7wCSVm8QMCYirFU7HTpjnge96fSpO12w6tQ0PB2EIVZ4hFVRVW3sy1i67saqi\nzbNQ+/qgESIWS+7KXf2otwQ=\n-----END PRIVATE KEY-----\n",
   "clientEmail": "firebase-adminsdk-yr45b@wso2-42209.iam.gserviceaccount.com",
   "clientId": "1080514883273363474",
   "authUri": "https://accounts.google.com/o/oauth2/auth",
   "tokenUri": "https://oauth2.googleapis.com/token",
   "authProviderCertUrl": "https://www.googleapis.com/oauth2/v1/certs",
   "clientCertUrl": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-yr86b%40wso2-42209.iam.gserviceaccount.com",
   "messagingType":"token",
   "dryRunMode":false,
   "registrationToken":"dTOJJxAyOBA:APA91bG776j90xEViBzejzy-Ije_FzAAudqY7T67Z52jEsPiANkTA4R5-C7xkx-DkOAzrw9s_YXbTjrbLttiO5rOUsYxcBTYZ684C74aCg6oQWzqrfC9fvSMmDXHR8v_8dPuH1eYIvv1",
   "topicName":"test2",
   "condition":"'test2' in topics",
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
<br/>

## Subscribe a device to a Firebase topic

```
<googlefirebase.subscribeToTopic>
```

```
<googlefirebase.subscribeToTopic>
    <topicName>{$ctx:topicName}</topicName>
    <tokenList>{$ctx:tokenList}</tokenList>
</googlefirebase.subscribeToTopic>
```

**Properties**

* topicName - The topic name that need to be subscribe by devices.
* tokenList - List of registration tokens as comma separated values which are generated by the client FCM SDKs for each end-user client app instance. (Eg:- "YOUR_REGISTRATION_TOKEN_1,YOUR_REGISTRATION_TOKEN_2, ----,YOUR_REGISTRATION_TOKEN_n")

**Sample request**

```
{
  "accountType": "service_account",
  "projectId": "Test-42xx9",
  "privateKeyId": "8d4ed1afsfsg56jiyu5ggfhgc02b3055a7197b0ac9afe",
  "privateKey": "-----BEGIN PRIVATE KEY-----\nMI3sfsgfgdhgdhgogxD9TEC3wkCC\nGKRvlPH1wqXPMhhsWEMHdhhghghgNBWyg/r+ff59KuqhQBs\nHy3ixWbSYW5XYd0ww6fT/UOH1dLYKSKLidEO6v2Rd2Xh+bxSwqi3IuyjuDy8WBJ6\asafrfrsfrsgtyuy\nS4hn+hfhgfhf/e6pGf0Z2KjL4375OUEEK6S\nCixuZQPFHlnqXi6OcmsLqa+A0kmjkLlVHPe9iH6n5Ku7Ikd+P+7ycRS2W8SF6+fg\nIt7oO9LpAgMBAAECggEACQy65kOIq+W2gFYcSfLHjhwqj/FKiaexd94l91slYPpV\n44v2ghxpOqmDTFRNA1rdgTM0NlFbFnCx8wc3TWOuZTN+0RoMHouPZo2GKX7Epepg\nSiVNW9NSaVQZHbTuAHV8ST41U7M4AyG+t6i1JEx2recStG+QCfqi2/xV2V0kN6ZL\neUdGIznl6CmfOdz2mU9JDOVLMpGBEfjEv8B9QukO0odTAJTTlP/XFHVbjHn14B+O\nn2YSIqzXD0aBAJxsecxkDwRsXP3wlg0viAu/wa8b7m6vKMJPYTf85/TThiZNloer\nl1PHuvLfCSlgV0XltyMoUzcNBw8mQgP7ggq4bR1etQKBgQDdGixkmQNIs8X78qAC\nonH6dFG8lUbDbOQCmM1UgijyZHiUNCC0pO6tKCHv9XVkhv845xdv+uIBtxixnETT\njiAQchiy+KaBEUrFY2XPkJt4XKTY8hOhg60IMk4fD9QIl8GUMqp/6ut4YcFe3ldL\nPXWQBsKXLWH7G4GV7Cb9OwEsRQKBgQDDG/Amuxc5vodv78DGDop1BIixW4FXqowD\nYs7LCbzSCTeZ3NF3gqXkF8GJRmBj6GOkrOBfleeffyjeVAuyX/K6PbXUFzrn0bHi\nYG1zDLMXUZEIguK3aJwl3sDnqNYr5GK92Yt6nMmZwXY/0E60b54PJpg1oKy8hfug\nZBC/N8mgVQKBgCn4BeUyhkUOms4wR984Jpp76ef6Deyahs1XY+JespcQKzM2kd64\nT/XeYFLELPxgA6Ixe2luHehlcPKFzyq5F60He1i9ih2FwsOlEnZL5Lb8Hu5vRPqr\nm/SqV9ndj0nyRHR1CZguZ3P6WlI/siI+EEq+fcFkg+y+U+K5aM04nghhAoGBAKSR\n+TPCFWoYgobxVMn6U+E2LNJkm6nFagolGsZ59TG4opR+hJRot+K4Av/2Q7GhwAKT\n60HU4KVRDbjSbXdMpSFgkfFOktocrw2CRm+Ho7wkidADDpajfyoWROJiMByfrIX0\nbEjE3Ot7GnHjE6/wggLHjBWX7HusC72TCekwdjptAoGAZO2GhJq72eaKs4WoaQys\nkzUTlYxzeP3/hOJbJiD/p2VJkNfwSV5AkOYcPFAyEV5kydA7DwzAKLGaTk9a04Wx\nWXm7wCSVm8QMCYirFU7HTpjnge96fSpO12w6tQ0PB2EIVZ4hFVRVW3sy1i67saqi\nzbNQ+/qgESIWS+7KXf2otwQ=\n-----END PRIVATE KEY-----\n",
  "clientEmail": "firebase-adminsdk-yr86b@Test-42xx9.iam.gserviceaccount.com",
  "clientId": "10805155677889363474",
  "authUri": "https://accounts.google.com/o/oauth2/auth",
  "tokenUri": "https://oauth2.googleapis.com/token",
  "authProviderCertUrl": "https://www.googleapis.com/oauth2/v1/certs",
  "clientCertUrl": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-yr86b%40Test-42xx9.iam.gserviceaccount.com",
  "topicName":"test2",
  "tokenList":"dlDIxxxxxxxxxxxxBHM:APA9cdfgdghhfjhjjkgkjkjklolooOI6ri8bwHafgNXDjX2n2kKwo4fK8hmuoamVddJfAwWr4xymkLZea_wVfLlENk,dlAIxxxxxxxxxxxxBHM:APAxvvfsojnwgfgwnwkww8bwHafgNXDjX2n2kKwo4fK8hmuRTBJJbksea_wVfLlENk"
}
```

**Sample Response**

```
{
    "Result": {
        "SuccessCount":1,
        "FailureCount":0,
        "Errors":[]
    }
}
```
<br/>

## Unsubscribe a device from a Firebase topic

```
<googlefirebase.unsubscribeFromTopic>
```

This operation allows you to unsubscribe devices from a topic by passing list of registration tokens. Registration tokens are strings generated by the client FCM SDKs for each end-user client app instance.

```
<googlefirebase.unsubscribeFromTopic>
    <topicName>{$ctx:topicName}</topicName>
    <tokenList>{$ctx:tokenList}</tokenList>
</googlefirebase.unsubscribeFromTopic>
```

**Properties**

* topicName - The topic name that need to be subscribe by devices.
* tokenList - List of registration tokens as comma separated values which are generated by the client FCM SDKs for each end-user client app instance. (Eg:- "YOUR_REGISTRATION_TOKEN_1,YOUR_REGISTRATION_TOKEN_2, ----,YOUR_REGISTRATION_TOKEN_n")

**Sample request**

```
{
  "accountType": "service_account",
  "projectId": "Test-42xx9",
  "privateKeyId": "8d4ed1afsfsg56jiyu5ggfhgc02b3055a7197b0ac9afe",
  "privateKey": "-----BEGIN PRIVATE KEY-----\nMI3sfsgfgdhgdhgogxD9TEC3wkCC\nGKRvlPH1wqXPMhhsWEMHdhhghghgNBWyg/r+ff59KuqhQBs\nHy3ixWbSYW5XYd0ww6fT/UOH1dLYKSKLidEO6v2Rd2Xh+bxSwqi3IuyjuDy8WBJ6\asafrfrsfrsgtyuy\nS4hn+hfhgfhf/e6pGf0Z2KjL4375OUEEK6S\nCixuZQPFHlnqXi6OcmsLqa+A0kmjkLlVHPe9iH6n5Ku7Ikd+P+7ycRS2W8SF6+fg\nIt7oO9LpAgMBAAECggEACQy65kOIq+W2gFYcSfLHjhwqj/FKiaexd94l91slYPpV\n44v2ghxpOqmDTFRNA1rdgTM0NlFbFnCx8wc3TWOuZTN+0RoMHouPZo2GKX7Epepg\nSiVNW9NSaVQZHbTuAHV8ST41U7M4AyG+t6i1JEx2recStG+QCfqi2/xV2V0kN6ZL\neUdGIznl6CmfOdz2mU9JDOVLMpGBEfjEv8B9QukO0odTAJTTlP/XFHVbjHn14B+O\nn2YSIqzXD0aBAJxsecxkDwRsXP3wlg0viAu/wa8b7m6vKMJPYTf85/TThiZNloer\nl1PHuvLfCSlgV0XltyMoUzcNBw8mQgP7ggq4bR1etQKBgQDdGixkmQNIs8X78qAC\nonH6dFG8lUbDbOQCmM1UgijyZHiUNCC0pO6tKCHv9XVkhv845xdv+uIBtxixnETT\njiAQchiy+KaBEUrFY2XPkJt4XKTY8hOhg60IMk4fD9QIl8GUMqp/6ut4YcFe3ldL\nPXWQBsKXLWH7G4GV7Cb9OwEsRQKBgQDDG/Amuxc5vodv78DGDop1BIixW4FXqowD\nYs7LCbzSCTeZ3NF3gqXkF8GJRmBj6GOkrOBfleeffyjeVAuyX/K6PbXUFzrn0bHi\nYG1zDLMXUZEIguK3aJwl3sDnqNYr5GK92Yt6nMmZwXY/0E60b54PJpg1oKy8hfug\nZBC/N8mgVQKBgCn4BeUyhkUOms4wR984Jpp76ef6Deyahs1XY+JespcQKzM2kd64\nT/XeYFLELPxgA6Ixe2luHehlcPKFzyq5F60He1i9ih2FwsOlEnZL5Lb8Hu5vRPqr\nm/SqV9ndj0nyRHR1CZguZ3P6WlI/siI+EEq+fcFkg+y+U+K5aM04nghhAoGBAKSR\n+TPCFWoYgobxVMn6U+E2LNJkm6nFagolGsZ59TG4opR+hJRot+K4Av/2Q7GhwAKT\n60HU4KVRDbjSbXdMpSFgkfFOktocrw2CRm+Ho7wkidADDpajfyoWROJiMByfrIX0\nbEjE3Ot7GnHjE6/wggLHjBWX7HusC72TCekwdjptAoGAZO2GhJq72eaKs4WoaQys\nkzUTlYxzeP3/hOJbJiD/p2VJkNfwSV5AkOYcPFAyEV5kydA7DwzAKLGaTk9a04Wx\nWXm7wCSVm8QMCYirFU7HTpjnge96fSpO12w6tQ0PB2EIVZ4hFVRVW3sy1i67saqi\nzbNQ+/qgESIWS+7KXf2otwQ=\n-----END PRIVATE KEY-----\n",
  "clientEmail": "firebase-adminsdk-yr86b@Test-42xx9.iam.gserviceaccount.com",
  "clientId": "10805155677889363474",
  "authUri": "https://accounts.google.com/o/oauth2/auth",
  "tokenUri": "https://oauth2.googleapis.com/token",
  "authProviderCertUrl": "https://www.googleapis.com/oauth2/v1/certs",
  "clientCertUrl": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-yr86b%40Test-42xx9.iam.gserviceaccount.com",
  "topicName":"test2",
  "tokenList":"dlDIxxxxxxxxxxxxBHM:APA9cdfgdghhfjhjjkgkjkjklolooOI6ri8bwHafgNXDjX2n2kKwo4fK8hmuoamVddJfAwWr4xymkLZea_wVfLlENk,dlAIxxxxxxxxxxxxBHM:APAxvvfsojnwgfgwnwkww8bwHafgNXDjX2n2kKwo4fK8hmuRTBJJbksea_wVfLlENk"
}
```

**Sample Response**

```
{
    "Result": {
        "SuccessCount":1,
        "FailureCount":0,
        "Errors":[]
    }
}
```

