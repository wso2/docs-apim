# SMPP Connector Reference

The following operations allow you to work with the SMPP Connector. Click an operation name to see parameter details and samples on how to use it.

## Initialize the connector

To use the SMPP connector, add the `<SMPP.init>` element in your configuration before carrying out any other SMPP operations. This is used to bind with the SMSC (Short Message service center). 

??? note "init"
    The init operation appends content to an existing file in a specified location.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>host</td>
            <td>IP address of the SMSC.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>port</td>
            <td>Port to access the SMSC.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>systemId</td>
            <td>username to access the SMSC.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>password</td>
            <td>password to access the SMSC.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>enquireLinkTimer</td>
            <td>Used to check the connectivity between the SMPP connector and SMSC.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>transactionTimer</td>
            <td>Time elapsed between SMPP connector request and corresponding response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>systemType</td>
            <td>It is used to categorize the type of ESME that is binding to the SMSC. Examples include “CP” (Content providers), “VMS” (voice mail system) and “OTA” (over-the-air activation system).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>addressTon</td>
            <td>Indicates Type of Number of the ESME address.  </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>addressNpi</td>
            <td>Numbering Plan Indicator for ESME address.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <SMPP.init>
        <host>{$ctx:host}</host>
        <port>{$ctx:port}</port>
        <systemId>{$ctx:systemId}</systemId>
        <password>{$ctx:password}</password>
        <enquireLinkTimer>{$ctx:enquireLinkTimer}</enquireLinkTimer>
        <transactionTimer>{$ctx:transactionTimer}</transactionTimer>
        <systemType>{$ctx:systemType}</systemType>
        <addressTon>{$ctx:addressTon}</addressTon>
        <addressNpi>{$ctx:addressNpi}</addressNpi>
    </SMPP.init>
    ```
    
    **Sample request**
    
    Following is a sample REST/JSON request that can be handled by the init operation.
    ```json
    {
      "host": "127.0.0.1",
      "port": 2775,
      "systemId": "DAMIEN",
      "password": "neimad",
      "systemType": "UNKNOWN",
      "addressTon": "UNKNOWN",
      "addressNpi": "UNKNOWN",
      "enquireLinkTimer": "50000",
    }
    ```
## Send SMS Message

??? note "sendSMS"
    Use to send SMS Message to the SMSC (Short Message Service Center),
    <table>
    <tr>
       <th>Parameter Name</th>
       <th>Description</th>
       <th>Required</th>
    </tr>
    <tr>
       <td>serviceType</td>
       <td>
          Indicates SMS application service. The following generic service_types are defined:
          <table>
             <tr>
                <td>"" (NULL)	</td>
                <td>Default</td>
             </tr>
             <tr>
                <td>"CMT"</td>
                <td>Cellular Messaging</td>
             </tr>
             <tr>
                <td>"CPT"	</td>
                <td>Cellular Paging</td>
             </tr>
             <tr>
                <td>"VMN"</td>
                <td>Voice Mail Notification</td>
             </tr>
             <tr>
                <td>"VMA"</td>
                <td>Voice Mail Alerting</td>
             </tr>
             <tr>
                <td>"WAP"</td>
                <td>Wireless Application Protocol</td>
             </tr>
             <tr>
                <td>"USSD"</td>
                <td>Unstructured Supplementary Services Data</td>
             </tr>
          </table>
       </td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>sourceAddressTon</td>
       <td>Type of number for source address.</td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>sourceAddressNpi</td>
       <td>Numbering plan indicator for source address.</td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>sourceAddress</td>
       <td>Source address of the SMS message.</td>
       <td>Yes</td>
    </tr>
    <tr>
       <td>destinationAddressTon</td>
       <td>Type of number for destination. Used as a default for the destination address.</td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>destinationAddressNpi</td>
       <td>numbering plan indicator for destination.</td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>distinationAddress</td>
       <td>
          Destination address of the SMS message.
          Source address TON, Destination address TON
          <table>
             <tr>
                <th>TON</th>
                <th>VALUE</th>
             </tr>
             <tr>
                <td>Unknown</td>
                <td>0</td>
             </tr>
             <tr>
                <td>International</td>
                <td>1</td>
             </tr>
             <tr>
                <td>National</td>
                <td>2</td>
             </tr>
             <tr>
                <td>Network Specific</td>
                <td>3</td>
             </tr>
             <tr>
                <td>Subscriber Number</td>
                <td>4</td>
             </tr>
             <tr>
                <td>Alphanumeric</td>
                <td>5</td>
             </tr>
             <tr>
                <td>Abbreviated</td>
                <td>6</td>
             </tr>
             <tr>
                <td>All other values reserved</td>
          </table>
          Source address NPI, Destination address NPI
          <table>
             <tr>
                <th>NPI</th>
                <th>VALUE</th>
             </tr>
             <tr>
                <td>Data (X.121)</td>
                <td>2</td>
             </tr>
             <tr>
                <td>ERMES</td>
                <td>16</td>
             </tr>
             <tr>
                <td>Internet (IP)</td>
                <td>20</td>
             </tr>
             <tr>
                <td>ISDN (E163/E164)</td>
                <td>1</td>
             </tr>
             <tr>
                <td>Land Mobile (E.212)</td>
                <td>4</td>
             </tr>
             <tr>
                <td>National</td>
                <td>8</td>
             </tr>
             <tr>
                <td>Private</td>
                <td>9</td>
             </tr>
             <tr>
             <tr>
                <td>Telex (F.69)</td>
                <td>3</td>
             </tr>
             <tr>
                <td>Unknown</td>
                <td>0</td>
             </tr>
             <tr>
             <tr>
                <td>WAP Client Id (to be defined by WAP Forum)</td>
                <td>24</td>
             </tr>
             <tr>
          </table>
       </td>
       <td>Yes</td>
    </tr>
    <tr>
       <td>message</td>
       <td>Content of the SMS message.</td>
       <td>Yes</td>
    </tr>
    <tr>
       <td>esmClass</td>
       <td>
          The esmClass parameter is used to indicate special message attributes associated with the short Message(message mode and type).
          <table>
             <tr>
                <th>Bits 7 6 5 4 3 2 1</th>
                <th>Meanning</th>
             </tr>
             <tr>
                <td>
                   x x x x x x 0 0<br>
                   x x x x x x 0 1<br>
                   x x x x x x 1 0<br>
                   x x x x x x 1 1<br>
                </td>
                <td>Messaging Mode (bits 1-0)<br>
                   Default SMSC Mode (e.g. Store and Forward)<br>
                   Datagram mode<br>
                   Forward (i.e. Transaction) mode<br>
                   Store and Forward mode<br>
                   (use to select Store and Forward mode if Default SMSC Mode is non Store and Forward)<br>
                </td>
             </tr>
             <tr>
                <td>x x 0 0 0 0 x x<br>
                   x x 0 0 1 0 x x<br>
                   x x 0 1 0 0 x x<br>
                </td>
                <td>Message Type (bits 5-2)<br>
                   Default message Type (i.e. normal message)<br>
                   Short Message contains ESME Delivery Acknowledgement<br>
                   Short Message contains ESME Manual/User Acknowledgement<br>
                </td>
             </tr>
             <tr>
                <td>0 0 x x x x x x<br>
                   0 1 x x x x x x<br>
                   1 0 x x x x x x<br>
                   1 1 x x x x x x<br>
                </td>
                <td>GSM Network Specific Features (bits 7-6)<br>
                   No specific features selected<br>
                   UDHI Indicator (only relevant for MT short messages)<br>
                   Set Reply Path (only relevant for GSM network)<br>
                   Set UDHI and Reply Path (only relevant for GSM network)<br>
                </td>
             </tr>
          </table>
       </td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>protocolId</td>
       <td>protocol identifier (network specific).<br>
          GSM - Set according to GSM 03.40 [ GSM 03.40]<br>
          ANSI-136 (TDMA)<br>
          For mobile terminated messages, this field is not used and is therefore ignored by the SMSC.<br>
          For ANSI-136 mobile originated messages, the SMSC should set this value to NULL.<br>
          IS-95 (CDMA)<br>
          For mobile terminated messages, this field is not used and is therefore ignored by the SMSC.<br>
          For IS-95 mobile originated messages, the SMSC should set this value to NULL.<br>
       </td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>priorityFlag</td>
       <td>
          sets the priority of the message.
          <table>
             <tr>
                <th>Priority Level</th>
                <th>GSM</th>
                <th>ANSI-136</th>
                <th>IS-95</th>
             </tr>
             <tr>
                <td>0</td>
                <td>Non-priority</td>
                <td>Bulk</td>
                <td>Normal</td>
             </tr>
             <tr>
                <td>1</td>
                <td>Priority</td>
                <td>Normal</td>
                <td>Interactive</td>
             </tr>
             <tr>
                <td>2</td>
                <td>Priority</td>
                <td>Urgent</td>
                <td>Urgent</td>
             </tr>
             <tr>
                <td>3</td>
                <td>Priority</td>
                <td>Very Urgent</td>
                <td>Emergency</td>
             </tr>
             <tr>All other values reserved
             </tr>
          </table>
          Priority<br>
          There are two types of priority. 
          <ol>
             <li>Delivery priority - Message delivery is attempted even if the mobile is temporarily absent.
                E.g., Temporarily out of reach or another short message is being delivered at the same time.
             </li>
             <li>Content priority - No free message memory capacity.
                E.g., The user does not delete any received message and maximum storage space has been reached. 
             </li>
          </ol>
          Non-priority<br>
          It will attempt delivery if the mobile has not been identified as temporarily absent.
       </td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>host</td>
       <td>IP address of the SMSC.</td>
       <td>Yes</td>
    </tr>
    <tr>
       <td>scheduleDeliveryTime</td>
       <td>This parameter specifies the scheduled time at which the message delivery should be first attempted. Set to NULL for immediate delivery.</td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>validityPeriod</td>
       <td>The validity_period parameter indicates the SMSC expiration time, after which the message should be discarded if not delivered to the destination. It can be defined in absolute time format or relative time format.</td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>registeredDelivery</td>
       <td>Indicator to signify if an SMSC delivery receipt or acknowledgment is required - Value other than 0 represents delivery report request.</td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>validityPeriod</td>
       <td>The validity_period parameter indicates the SMSC expiration time, after which the message should be discarded if not delivered to the destination. It can be defined in absolute time format or relative time format.</td>
       <td>Optional</td>
    </tr>
    <tr>
       <td>replaceIfPresentFlag</td>
       <td>
          The replace_if_present_flag parameter is used to request the SMSC to replace a previously submitted message, that is still pending delivery. The SMSC will replace an existing message provided that the source address, destination address and service_type match the same fields in the new message.
          <table>
             <tr>
                <td>Value</td>
                <td>Description</td>
             </tr>
             <tr>
                <td>0</td>
                <td>Don't replace (default)</td>
             </tr>
             <tr>
                <td>1</td>
                <td>Replace</td>
             </tr>
             <tr>
                <td>2-255</td>
                <td>reserved</td>
             </tr>
             <td>Optional</td>
             <tr>
                <td>alphabet</td>
                <td>
                   Alphabet is used in the data encoding of SMS message. Following alphabets are supported.
                   <ol>
                      <li>ALPHA_DEFAULT</li>
                      <li>ALPHA_8_BIT</li>
                      <li>ALPHA_UCS2</li>
                      <li>ALPHA_RESERVED</li>
                   </ol>
                </td>
                <td>Optional</td>
             </tr>
             <tr>
                <td>isCompressed</td>
                <td>It allows SMS message compression.</td>
                <td>Optional</td>
             </tr>
             <tr>
                <td>messageClass</td>
                <td>
                   <table>
                      <tr>
                         <th>Value</th>
                         <th>Message Class</th>
                      </tr>
                      <tr>
                         <td>CLASS0</td>
                         <td>Flash messages. Display only not store into the phone</td>
                      </tr>
                      <tr>
                         <td>CLASS1</td>
                         <td>ME specific - the SMS is stored in the mobile phone memory</td>
                      </tr>
                      <tr>
                         <td>CLASS2</td>
                         <td>SIM specific - the SMS is stored on the SIM</td>
                      </tr>
                      <tr>
                         <td>CLASS3</td>
                         <td>TE specific - this means the SMS is sent to a computer attached to the receiving mobile phone</td>
                      </tr>
                   </table>
                   Data encoding - defines the encoding scheme of the SMS message. You can find general data coding scheme from [here](https://en.wikipedia.org/wiki/Data_Coding_Scheme) for different combination of alphabet, message class, isCompressed values.
                </td>
                <td>Optional</td>
             </tr>
             <tr>
                <td>submitDefaultMsgId</td>
                <td>
                   Indicates short message to send from a predefined list of messages stored on SMSC.<br>
                   <table>
                      <tr>
                         <th>Value</th>
                         <th>Description</th>
                      </tr>
                      <tr>
                         <td>0</td>
                         <td>reserved</td>
                      </tr>
                      <tr>
                         <td>1 - 254</td>
                         <td>Allowed values</td>
                      </tr>
                      <tr>
                         <td>255</td>
                         <td>reserved</td>
                      </tr>
                   </table>
                </td>
                <td>Optional</td>
             </tr>
          </table>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    </table>

    **Sample configuration**

    ```xml
    <SMPP.sendSMS>
    <serviceType>{$ctx:serviceType}</serviceType>
    <sourceAddressTon>{$ctx:sourceAddressTon}</sourceAddressTon>
    <sourceAddressNpi>{$ctx:sourceAddressNpi}</sourceAddressNpi>
    <sourceAddress>{$ctx:sourceAddress}</sourceAddress>
    <distinationAddressTon>{$ctx:distinationAddressTon}</distinationAddressTon>
    <distinationAddressNpi>{$ctx:distinationAddressNpi}</distinationAddressNpi>
    <distinationAddress>{$ctx:distinationAddress}</distinationAddress>
    <alphabet>{$ctx:alphabet}</alphabet>
    <message>{$ctx:message}</message>
    <smscDeliveryReceipt>{$ctx:smscDeliveryReceipt}</smscDeliveryReceipt>
    <messageClass>{$ctx:messageClass}</messageClass>
    <isCompressed>{$ctx:isCompressed}</isCompressed>
    <esmclass>{$ctx:esmclass}</esmclass>
    <protocolid>{$ctx:protocolid}</protocolid>
    <priorityflag>{$ctx:priorityflag}</priorityflag>
    <replaceIfPresentFlag>{$ctx:replaceIfPresentFlag}</replaceIfPresentFlag>
    <submitDefaultMsgId>{$ctx:submitDefaultMsgId}</submitDefaultMsgId>
    <validityPeriod>{$ctx:validityPeriod}</validityPeriod>
    </SMPP.sendSMS>
    ```
    
    **Sample request**
    
    Following is a sample REST/JSON request that can be handled by the sendSMS operation.
    ```json
    {
      "host": "127.0.0.1",
      "port": 2775,
      "systemId": "DAMIEN",
      "password": "neimad",
      "systemType": "UNKNOWN",
      "addressTon": "UNKNOWN",
      "addressNpi": "UNKNOWN",
      "serviceType": "CMT",
      "sourceAddressTon": "NETWORK_SPECIFIC",
      "sourceAddressNpi": "INTERNET",
      "sourceAddress": "16116",
      "distinationAddressTon": "SUBSCRIBER_NUMBER",
      "distinationAddressNpi": "LAND_MOBILE",
      "distinationAddress": "628176504657",
      "messageClass":"CLASS1",
      "alphabet": "ALPHA_DEFAULT",
      "isCompressed":"true",
      "esmclass": "0",
      "protocolid": "0",
      "priorityflag":"1",
      "replaceIfPresentFlag": "0",
      "submitDefaultMsgId": "1",
      "validityPeriod": “020610233429000R”,
      "message": "hi hru",
      "smscDeliveryReceipt": "SUCCESS_FAILURE",
      "enquireLinkTimer": "50000",
      "transactionTimer": "100"
    }
    ```
### Sample configuration in a scenario

The following is a sample proxy service that illustrates how to connect to the SMPP connector and use the sendSMS operation to send a SMS message to the SMSC (Short Message Service Center). You can use this sample as a template for using other operations in this category.

**Sample Proxy**
```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
      name="SMPP"
      transports="http,https,local"
      statistics="disable"
      trace="disable"
      startOnLoad="true">
   <target>
       <inSequence>
           <property name="OUT_ONLY" value="true"/>
           <property name="host" expression="json-eval($.host)"/>
           <property name="port" expression="json-eval($.port)"/>
           <property name="systemId" expression="json-eval($.systemId)"/>
           <property name="password" expression="json-eval($.password)"/>
           <property name="systemType" expression="json-eval($.systemType)"/>
           <property name="addressTon" expression="json-eval($.addressTon)"/>
           <property name="addressNpi" expression="json-eval($.addressNpi)"/>
           <property name="serviceType" expression="json-eval($.serviceType)"/>
           <property name="sourceAddressTon" expression="json-eval($.sourceAddressTon)"/>
           <property name="sourceAddressNpi" expression="json-eval($.sourceAddressNpi)"/>
           <property name="sourceAddress" expression="json-eval($.sourceAddress)"/>
           <property name="distinationAddressTon" expression="json-eval($.distinationAddressTon)"/>
           <property name="distinationAddressNpi" expression="json-eval($.distinationAddressNpi)"/>
           <property name="distinationAddress" expression="json-eval($.distinationAddress)"/>
           <property name="alphabet" expression="json-eval($.alphabet)"/>
           <property name="message" expression="json-eval($.message)"/>
           <property name="smscDeliveryReceipt" expression="json-eval($.smscDeliveryReceipt)"/>
           <property name="messageClass" expression="json-eval($.messageClass)"/>
           <property name="isCompressed" expression="json-eval($.isCompressed)"/>
           <property name="esmclass" expression="json-eval($.esmclass)"/>
           <property name="protocolid" expression="json-eval($.protocolid)"/>
           <property name="priorityflag" expression="json-eval($.priorityflag)"/>
           <property name="replaceIfPresentFlag" expression="json-eval($.replaceIfPresentFlag)"/>
           <property name="submitDefaultMsgId" expression="json-eval($.submitDefaultMsgId)"/>
           <property name="validityPeriod" expression="json-eval($.validityPeriod)"/>
           <property name="enquireLinkTimer" expression="json-eval($.enquireLinkTimer)"/>
           <property name="transactionTimer" expression="json-eval($.transactionTimer)"/>
           <SMPP.init>
               <host>{$ctx:host}</host>
               <port>{$ctx:port}</port>
               <systemId>{$ctx:systemId}</systemId>
               <password>{$ctx:password}</password>
               <enquireLinkTimer>{$ctx:enquireLinkTimer}</enquireLinkTimer>
               <transactionTimer>{$ctx:transactionTimer}</transactionTimer>
               <systemType>{$ctx:systemType}</systemType>
               <addressTon>{$ctx:addressTon}</addressTon>
               <addressNpi>{$ctx:addressNpi}</addressNpi>
           </SMPP.init>
           <SMPP.sendSMS>
               <serviceType>{$ctx:serviceType}</serviceType>
               <sourceAddressTon>{$ctx:sourceAddressTon}</sourceAddressTon>
               <sourceAddressNpi>{$ctx:sourceAddressNpi}</sourceAddressNpi>
               <sourceAddress>{$ctx:sourceAddress}</sourceAddress>
               <distinationAddressTon>{$ctx:distinationAddressTon}</distinationAddressTon>
               <distinationAddressNpi>{$ctx:distinationAddressNpi}</distinationAddressNpi>
               <distinationAddress>{$ctx:distinationAddress}</distinationAddress>
               <alphabet>{$ctx:alphabet}</alphabet>
               <message>{$ctx:message}</message>
               <smscDeliveryReceipt>{$ctx:smscDeliveryReceipt}</smscDeliveryReceipt>
               <messageClass>{$ctx:messageClass}</messageClass>
               <isCompressed>{$ctx:isCompressed}</isCompressed>
               <esmclass>{$ctx:esmclass}</esmclass>
               <protocolid>{$ctx:protocolid}</protocolid>
               <priorityflag>{$ctx:priorityflag}</priorityflag>
               <replaceIfPresentFlag>{$ctx:replaceIfPresentFlag}</replaceIfPresentFlag>
               <submitDefaultMsgId>{$ctx:submitDefaultMsgId}</submitDefaultMsgId>
               <validityPeriod>{$ctx:validityPeriod}</validityPeriod>
           </SMPP.sendSMS>
           <respond/>
       </inSequence>
   </target>
   <description/>
</proxy>       
```
**Note**: For more information on how this works in an actual scenario, see [SMPP Connector Example]({{base_path}}/reference/connectors/smpp-connector/smpp-connector-example/).