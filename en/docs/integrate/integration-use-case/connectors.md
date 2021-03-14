# SaaS and B2B Integration

Connectors are a means of interacting with various SaaS applications on the cloud, databases, and popular B2B protocols. See [Connectors Overview]({{base_path}}/reference/connectors/connectors-overview) for more information.

The following are of documented connectors available from the [connector store](https://store.wso2.com/store/assets/esbconnector/list). Click the link of the connector to view the documentation for each connector.

!!! Info
    For details on connectors not mentioned in this documentation, you can find more information in [WSO2 ESB Connectors documentation](https://docs.wso2.com/display/ESBCONNECTORS/WSO2+ESB+Connectors+Documentation) or in the [GitHub repository of the connector](https://github.com/wso2-extensions) you are looking for.

## SaaS Connectors

<table>
        <tr>
            <th>Connector</th>
            <th>Description</th>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/amazondynamodb-connector/amazondynamodb-connector-overview/">Amazon DynamoDB</a></td>
            <td>Amazon DynamoDB Connector allows you to access the <a href="https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.API.html">Amazon DynamoDB REST API</a> through WSO2 EI.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/amazonlambda-connector/amazonlambda-connector-overview/">Amazon Lambda</a></td>
            <td>The AmazonLambda Connector allows you to access the REST API of <a href="https://docs.aws.amazon.com/lambda/latest/dg/welcome.html">Amazon Web Service Lambda (AWS Lambda)</a>, which lets you run code without provisioning or managing servers.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/amazons3-connector/amazons3-connector-overview/">Amazon S3</a></td>
            <td>The AmazonS3 Connector allows you to access the REST API of <a href="https://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html">Amazon Storage Service S3</a>, which lets you store your information and retrieve them back when needed.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/amazonsqs-connector/amazonsqs-connector-overview/">Amazon SQS</a></td>
            <td>This connector enables you to perform CRUD operations for queues in Amazon SQS instance, update permissions and can work with messages through the <a href="https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/Welcome.html">Amazon SQS API</a>.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/ceridiandayforce-connector/ceridiandayforce-overview/">Ceridian Dayforce</a></td>
            <td>The Ceridian Dayforce connector allows you to  access the REST API of Ceridian Dayforce HCM.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/gmail-connector/gmail-connector-overview/">Gmail</a></td>
            <td>The Gmail Connector allows you to integrate with the <a href="https://developers.google.com/gmail/api/v1/reference">Gmail REST API</a> through WSO2 EI.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/google-firebase-connector/google-firebase-overview/">Google Firebase</a></td>
            <td>Google Firebase Connector is useful for integrating Google Firebase with other enterprise applications, on-premise or cloud using the <a href="https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages">Google Firebase API</a>.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/google-spreadsheet-connector/google-spreadsheet-overview/">Google Spreadsheet</a></td>
            <td>The WSO2 Google Spreadsheet Connector allows you to access the <a href="https://developers.google.com/sheets/api/guides/concepts">Google Spreadsheet API Version v4</a> through WSO2 EI.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/microsoft-azure-storage-connector/microsoft-azure-storage-connector-example/">Microsoft Azure Storage</a></td>
            <td>The Microsoft Azure Storage Connector allows you to access the Azure Storage services using Microsoft Azure Storage Java SDK through WSO2 EI.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/salesforce-connectors/sf-overview/">Salesforce REST</a></td>
            <td>The connector uses the <a href="https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_what_is_rest_api.htm">Salesforce REST API</a> to interact with Salesforce.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/salesforce-connectors/sf-inbound-endpoint-example/">Salesforce REST</a></td>
            <td>The Salesforce streaming Inbound Endpoint allows you to perform various operations on Salesforce streaming data via WSO2 EI. The <a href="https://developer.salesforce.com/docs/atlas.en-us.api_streaming.meta/api_streaming/intro_stream.htm">Salesforce streaming API</a> receives notifications based on the changes that happen to Salesforce data with respect to an SQQL (Salesforce Object Query Language) query you define, in a secured and scalable way.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/servicenow-connector/servicenow-overview/">ServiceNow</a></td>
            <td>Using ServiceNow connector you can work with <a href="https://developer.servicenow.com/dev.do#!/reference/api/orlando/rest/c_TableAPI">Aggregate API, Import Set API and Table API in ServiceNow</a>.</td>
        </tr>
</table>


## Technology Connectors

<table>
        <tr>
            <th>Connector</th>
            <th>Description</th>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/db-event-inbound-endpoint/db-event-inbound-endpoint-overview/">DB Event Listener</a></td>
            <td>DB Event Inbound Endpoint is the DB event listener for WSO2 Enterprise Integrator. You can configure it with any popular Database systems such as `MySQL` and `Oracle` etc.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/fhir-connector/fhir-connector-overview/">FHIR</a></td>
            <td>This connector uses the <a href="https://hapifhir.io">HAPI FHIR APIs</a> to connect with a Test Server, which is an open source server licensed under the Apache Software License 2.0 (Java-based implementation of the FHIR specification).</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/file-connector/file-connector-overview/">File</a></td>
            <td>The File Connector uses the <a href="https://commons.apache.org/proper/commons-vfs/">Apache Commons VFS</a> I/O functionalities to execute operations related to the file system and allows you to easily manipulate files based on your requirement.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/ISO8583-connector/ISO8583-connector-overview/">ISO8583</a></td>
            <td>The ISO8583 message format is used for financial transactions such as ATM, POS, Credit Card, Mobile Banking, Internet Banking, KIOSK, e-commerce, etc.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/ISO8583-connector/ISO8583-inbound-endpoint-example/">ISO8583 Inbound Endpoint</a></td>
            <td>The ISO8583 inbound endpoint supported via the WSO2 EI is a listening inbound endpoint that can consume ISO8583 standard messages.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/kafka-connector/kafka-connector-overview/">Kafka Producer</a></td>
            <td>This connector enables you to send messages to a Kafka broker via Kafka topics. This uses the <a href="http://kafka.apache.org/documentation.html#producerapi">Producer API</a>.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/kafka-connector/kafka-inbound-endpoint-example/">Kafka Inbound Endpoint</a></td>
            <td>The Kafka inbound endpoint of WSO2 EI acts as a message consumer. It creates a connection to ZooKeeper and requests messages for either a topic/s or topic filters.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/ldap-connector/ldap-connector-overview/">LDAP</a></td>
            <td>The LDAP connector allows you to connect to any LDAP server through a simple web services interface and perform CRUD (Create, Read, Update, Delete) operations on LDAP entries.</td>
        </tr>
        <tr>
            <td><a href="{{base_path}}/reference/connectors/smpp-connector/smpp-connector-overview/">SMPP</a></td>
            <td>SMPP (Short Message Peer-to-Peer Protocol) Connector allows you to send an SMS through the WSO2 EI. It uses the <a href="https://jsmpp.org/">jsmpp API</a> to communicate with an SMSC (Short Message Service Center)</td>
        </tr>
</table>

