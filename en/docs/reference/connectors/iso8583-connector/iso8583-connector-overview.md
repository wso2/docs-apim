# ISO8583 Connector Overview

The ISO8583 message format is used for financial transactions such as ATM, POS, Credit Card, Mobile Banking, Internet Banking, KIOSK, e-commerce, etc. transactions.

The financial transaction involves communication between two systems through a socket connection. After the connection is established, each system can send messages in ISO8583 format, which commonly will be requested and the other system will send a response. 

For example, the purchase made in a store may travel from the merchant terminal through another terminal such as banking systems. This requires a network or networks to the issuing bank where the card holder's account is held.
Cardholder-originated transactions include purchase, withdrawal, deposit, refund, reversal, balance inquiry, payments, and inter-account transfers. ISO8583 also defines system-to-system messages for secure key exchanges, reconciliation of totals, and other administrative purposes. The response on authorizing or declining the transaction needs to be returned by the same route to the terminal.

To see the ISO8583 Connector, navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for "ISO8583".

<img src="{{base_path}}/assets/img/integrate/connectors/iso8583-store.png" title="ISO8583 Connector Store" width="200" alt="ISO8583 Connector Store"/>

## Compatibility

| Connector Version | Supported product versions |
| ------------- |-------------|
| 1.0.3    | APIM 4.0.0, EI 7.1.0, EI 7.0.x, EI 6.6.0, EI 6.5.0 |

For older versions, see the details in the connector store.

## ISO8583 Connector documentation

The ISO8583 Connector allows you to send ISO8583 standard messages from an integration sequence. ISO8583 is an international messaging standard for financial transaction card originated messages, and is commonly used in transactions between devices such as point-of-sale(POS) terminals and automated teller machines(ATMs). Although there are various versions of the ISO8583 standard, this connector is developed based on the 1987 version. 

* **[Setting up ISO8583 Connector]({{base_path}}/reference/connectors/ISO8583-connector/ISO8583-connector-configuration/)**: This includes instructions on setting up the environment and the test server in order to try this out. 

* **[ISO8583 Connector Example]({{base_path}}/reference/connectors/ISO8583-connector/ISO8583-connector-example/)**: This example demonstrates how to expose core banking system functionality working with ISO8583 protocol as an API. 

* **[ISO8583 Connector Reference]({{base_path}}/reference/connectors/ISO8583-connector/ISO8583-connector-reference/)**: This documentation provides a reference guide for the ISO8583 Connector.

## ISO8583 Inbound Endpoint documentation

The ISO8583 inbound endpoint acts as a message consumer. This is bundled with the ISO8583 connector and can be obtained from the connector store. The ISO8583 inbound endpoint supported via the integration runtime of WSO2 is a listening inbound endpoint that can consume ISO8583 standard messages. The ISO8583 connector allows outbound messages from the integration runtime to third-party applications, while the inbound endpoint only allows incoming messages. The inbound endpoint converts the messages to XML format and injects messages to a sequence.

* **[ISO8583 Inbound Endpoint Example]({{base_path}}/reference/connectors/ISO8583-connector/ISO8583-inbound-endpoint-example/)**: This example demonstrates how the ISO8583 inbound endpoint works as an ISO8583 message consumer. 

* **[ISO8583 Inbound Endpoint Reference]({{base_path}}/reference/connectors/ISO8583-connector/ISO8583-inbound-endpoint-config/)**: This documentation provides a reference guide for the ISO8583 Inbound Endpoint.

## How to contribute

As an open source project, WSO2 extensions welcome contributions from the community. 

To contribute to the code for this connector, create a pull request in one of the following repositories. 

* [ISO8583 Connector GitHub repository](https://github.com/wso2-extensions/esb-connector-iso8583)
* [ISO8583 Inbound Endpoint GitHub repository](https://github.com/wso2-extensions/esb-inbound-iso8583)

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.
