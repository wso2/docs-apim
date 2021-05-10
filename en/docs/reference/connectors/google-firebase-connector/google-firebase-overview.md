# Google Firebase Connector Overview

Google Firebase is a rich modern platform to create quick mobile app back-ends, with a ton of built-in and ready-to-integrate features. The most used feature of Firebase is as a back-end. However, along with this back-end, one of the popular features is **push notifications**. We can register Android, IOS, and Web-based backend to Google Firebase applications and push notifications to them. Firebase being a Google product, a lot of people use it for reliable push notifications. In the mobile world, push notifications are very popular.  

You can use the Firebase console itself to trigger out messages to the registered devices or you can even schedule a CRON job. Firebase provides a `Messaging Console`, which you can use to send all kinds of push messages, filter target users, schedule messages, and much more. Needless to state, it provides notification history and reports as well. However, when it come to integration scenarios we should be able to generate a notification externally and send it to Google Firebase.

To see the Google Firebase Connector, navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for "firebase".

<img src="{{base_path}}/assets/img/integrate/connectors/google-firebase-store.png" title="Google Firebase Connector Store" width="200" alt="Google Firebase Connector Store"/>

## Compatibility

| Connector Version | Supported product versions |
| ------------- |-------------|
| 1.0.2    | APIM 4.0.0, EI 7.1.0, EI 7.0.x, EI 6.6.0, EI 6.5.0 |

For older versions, see the details in the connector store.

## Google Firebase Connector documentation

* **[Setting up Google Firebase Environment]({{base_path}}/reference/connectors/google-firebase-connector/google-firebase-setup/)**: You need to first create a project and generate private keys for the connector to use in order to interact with Google Firebase.

* **[Google Firebase Connector Example]({{base_path}}/reference/connectors/google-firebase-connector/google-firebase-connector-example/)**: This example demonstrates how to use Google Firebase Connector to generate a push notification based on an HTTP API invocation. 

* **[Google Firebase Connector Reference]({{base_path}}/reference/connectors/google-firebase-connector/google-firebase-configuration/)**: This documentation provides a reference guide for the Google Firebase Connector.

## How to contribute

As an open source project, WSO2 extensions welcome contributions from the community. 

To contribute to the code for this connector, create a pull request in the following repository. 

* [Google Firebase Connector GitHub repository](https://github.com/wso2-extensions/esb-connector-googlefirebase)

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.
