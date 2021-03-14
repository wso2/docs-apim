# Setting up ISO8583 Connector 

ISO8583 is an international standard for financial transaction messaging protocol. It is the International Organization for Standardization standard for systems that exchange electronic transactions initiated by cardholders using payment cards.

Typically, whenever we use a credit card, debit card, or ATM card, the data travels from one system to another system. A card-based transaction typically needs to travel between a number of systems. The WSO2 ISO8583 connector allows you to maintain the common transaction messaging standards.

## Setting up the environment

Before you start configuring the ISO8583 connector, you also need WSO2 MI, and we refer to that location as <PRODUCT_HOME>.

To configure the ISO8583 connector, copy the following client libraries from the given locations to the `<PRODUCT_HOME>/repository/components/lib` directory.

* [jpos-1.9.4.jar](http://mvnrepository.com/artifact/org.jpos/jpos/1.9.4)  
* [jdom-1.1.3.jar](http://mvnrepository.com/artifact/org.jdom/jdom/1.1.3) 
* [commons-cli-1.3.1.jar](http://mvnrepository.com/artifact/commons-cli/commons-cli/1.3.1) 

## Configure the test server

For testing purposes, you need to have a test server (basically a Java socket connection that listens on port 5010) to handle ISO8583 requests that come from the connector. You also need to generate responses by changing the relevant response fields, and then send the responses back to the connector. You can test the connector with the sample Java server program that is provided in the following [git location](https://github.com/wso2-docs/CONNECTORS/tree/master/ISO8583/ISO8583TestServer). To test the ISO8583 Inbound operation scenario, you can use the sample Java client program that is provided in the following [git location](https://github.com/wso2-docs/CONNECTORS/tree/master/ISO8583/ISO8583TestClient/1.0.0).

You can include required header information within the header tag. It supports 2-byte or 4-byte headers. To include header information, you need to convert the 2-byte or 4-byte header into a string using base64 encoding, and then specify the string value within the header tag. For more information on the ISO8583 standard, see [ISO8583 Documentation](https://en.wikipedia.org/wiki/ISO_8583).

If you use the [sample Java server program](https://github.com/wso2-docs/CONNECTORS/tree/master/ISO8583/ISO8583TestServer) to send an ISO8583 request with a header value from the connector, you need to update the iso87ascii.xml file with the relevant headerLength information.

The ISO8583 connector uses the jpos library, which is a third party library that provides a high-performance bridge between card messages generated at point of sale terminals, ATMs, and internal systems across the entire financial messaging network. The jposdef.xml file has the field definitions of standard ISO8583 messages. According to the field definitions, each ISO8583 message in XML format coming from the REST client is packed and sent to the test server. Therefore, you need to create a file called jposdef.xml (with the contents given [here](https://github.com/wso2-extensions/esb-connector-iso8583/blob/master/src/main/resources/jposdef.xml)) in the <EI_HOME> directory.
 
Now you have connected to the test server. For more information, see [ISO8583 Connector Example]({{base_path}}/reference/connectors/ISO8583-connector/ISO8583-connector-example/).