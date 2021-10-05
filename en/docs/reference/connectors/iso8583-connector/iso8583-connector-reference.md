# ISO8583 Connector Reference

The following operations allow you to work with the ISO8583 Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the ISO8583 connector, add the <iso8583.init> element in your configuration before connecting with Testserver.

??? note "init"
    The init operation is used to initialize the connection to ISO8583.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>serverHost</td>
            <td>Here the host is localhost.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>serverPort</td>
            <td>Here the port is 5010 , The Testserver will start to listen on that port.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonsqs.init>
       <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <version>{$ctx:version}</version>
        <region>{$ctx:region}</region>
        <enableSSL>{$ctx:enableSSL}</enableSSL>
        <contentType>{$ctx:contentType}</contentType>
        <blocking>{$ctx:blocking}</blocking>
    </amazonsqs.init>
    ```
    
To send the messages, use </iso8583.sendMessage> operation and using Rest-client to send the XML format messages. In Rest-client set the header application/xml as Content-Type.

POST the body in XML format and XML format message should be in the following structure.

```xml
<ISOMessage>
      <data>
        <field id="0">0200</field>
        <field id="3">568893</field>
        <field id="4">000000020000</field>
        <field id="7">0110563280</field>
        <field id="11">456893</field>
        <field id="44">DFGHT</field>
        <field id="105">ABCDEFGHIJ 9871236548</field>
      </data>
</ISOMessage>
```