# Google PubSub Connector Overview

The Google Pub/Sub connector allows you to access the [Google Cloud Pub/Sub API Version v1](https://cloud.google.com/pubsub/docs/reference/rest/) from an integration sequence. Google Cloud Pub/Sub is a fully-managed real-time messaging service that allows you to send and receive messages between independent applications.

The Google Pub/Sub Connector allows developers to make asynchronous messaging flows inside the mediation. It facilitates the following use-cases.

1. One-to-many messaging. The WSO2 integration runtime can place a message in a topic and many other parties can consume it.
2. Distributing event notifications - The WSO2 integration runtime can send events to Google Pub Sub and interested event listeners will get triggered.
3. Streaming sensor data to Google cloud using the WSO2 integration runtime.
4. Reliability improvement in processing messages. Messages received by the WSO2 integration runtime can be sent to Google Pub Sub and later received and processed by a WSO2 integration runtime in a different region.

Inspired from: [Google Pub/Sub docs](https://cloud.google.com/pubsub/docs/overview)

To see the Google Pub/Sub Connector, navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for "pubsub".

<img src="{{base_path}}/assets/img/integrate/connectors/pubsub-store.png" title="Google PubSub Connector Store" width="200" alt="Google PubSub Connector Store"/>

## Compatibility

| Connector Version | Supported product versions |
| ------------- |-------------|
| 1.0.2    | APIM 4.0.0, EI 7.1.0, EI 7.0.x, EI 6.6.0, EI 6.5.0 |

For older versions, see the details in the connector store.

## Google Pub/Sub Connector documentation

* **[Setting up the Google Pub/Sub Environment]({{base_path}}/reference/connectors/google-pubsub-connector/googlepubsub-connector-configuration/)**: You need to first generate user credentials and access tokens in order to interact with Google PubSub.

* **[Google Pub/Sub Connector Example]({{base_path}}/reference/connectors/google-pubsub-connector/googlepubsub-connector-example/)**: This example demonstrates how to work with the Google Pub/Sub Connector. 

* **[Google Pub/Sub Connector Reference]({{base_path}}/reference/connectors/google-pubsub-connector/googlepubsub-connector-reference/)**: This documentation provides a reference guide for the Google Pub/Sub Connector.

## How to contribute

As an open source project, WSO2 extensions welcome contributions from the community. 

To contribute to the code for this connector, create a pull request in the following repository. 

* [Google Pub/Sub Connector GitHub repository](https://github.com/wso2-extensions/esb-connector-googlepubsub)

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.
