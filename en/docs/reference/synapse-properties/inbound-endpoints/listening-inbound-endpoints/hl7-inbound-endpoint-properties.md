# HL7 Inbound Endpoint Properties
## Introduction

The HL7 inbound protocol is an alternative to the HL7 transport. The HL7 inbound endpoint implementation is fully asynchronous and is based on the <b>Minimal Lower Layer Protocol(MLLP)</b> implemented on top of event driven I/O.

## Syntax

``` java tab='HL7'
<inboundEndpoint xmlns="http://ws.apache.org/ns/synapse"
                    name="InboundHL7"
                    sequence="main"
                    onError="fault"
                    protocol="hl7"
                    suspend="false">
    <parameters>
         <parameter name="inbound.hl7.Port">20000</parameter>
         <parameter name="inbound.hl7.AutoAck">true</parameter>
         <parameter name="inbound.hl7.ValidateMessage">true</parameter>
         <parameter name="inbound.hl7.TimeOut">10000</parameter>
         <parameter name="inbound.hl7.CharSet">UTF-8</parameter>
         <parameter name="inbound.hl7.BuildInvalidMessages">false</parameter>
         <parameter name="inbound.hl7.PassThroughInvalidMessages">false</parameter>  
    </parameters>
</inboundEndpoint>
```

## Properties

Listed below are the properties used for [creating a HL7 inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

### Optional Properties

The following properties can be configured when [creating a HL7 inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
   <thead>
      <tr>
         <th>Property</th>
         <th>Description</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>inbound.hl7.Port</td>
         <td>The port on which you need to run the MLLP listener.</td>
      </tr>
      <tr>
         <td>inbound.hl7.AutoAck</td>
         <td>Whether or not an auto acknowledgement should be sent on message receipt. If set to false, you can define the type of HL7 acknowledgement to be sent. For more information, see <a href="#hl7-mediation-level-properties">HL7 inbound endpoint mediation level properties</a>.</br></br> The default setting is <code>true</code>.</td>
      </tr>
      <tr>
         <td>inbound.hl7.ValidateMessage</td>
         <td>This enables HL7 message validation.</br></br> The default setting is <code>true</code>.</td>
      </tr>
      <tr>
         <td>inbound.hl7.TimeOut</td>
         <td>The timeout interval in milliseconds to trigger a NACK message.</br></br> The default values is 10000.</td>
      </tr>
      <tr>
         <td>inbound.hl7.CharSet</td>
         <td>
          The character set used for encoding and decoding messages. Some multi-byte character encodings (e.g. UTF-16, UTF-32) may result in byte values equal to the MLLP framing characters or byte values lower than 0x1F, which results in errors. Possible values are <code>UTF-8</code>, <code>UTF-8</code>, and <code>US-ASCII</code>.</br></br> Default value is <code>US-ASCII</code>.
        </td>
      </tr>
      <tr>
         <td>inbound.hl7.BuildInvalidMessages</td>
         <td>If the <code>inbound.hl7.ValidateMessage</code> parameter is set to <code>false</code> and the incoming message is invalid, this parameter specifies whether the raw message received through the MLLP transport should be passed onto the mediation layer.</br></br> The default setting is <code>false</code>.</td>
      </tr>
      <tr>
         <td>inbound.hl7.PassthroughInvalidMessages</td>
         <td>If the <code>inbound.hl7.BuildInvalidMessages</code> parameter is set to <code>true</code>, this parameter notifies the Axis2 HL7 transport sender whether to use the raw message. The default setting is <code>false</code>.</td>
      </tr>
      <tr>
         <td>inbound.hl7.MessagePreProcessor</td>
         <td>
          An implementation of the <code>org.wso2.carbon.inbound.endpoint.protocol.hl7.HL7MessagePreprocessor</code> interface can be defined here. It provides an extension point to intercept incoming messages before any type of message parsing occurs. You can use any fully qualified class name.
        </td>
      </tr>
      <tr>
         <td>sequential</td>
         <td>The behavior when executing the given sequence.<br />
            When set as <code>true</code> , mediation will happen within the same thread. When set as <code>false</code> , the mediation engine will use the inbound thread pool. The default thread pool values can be found in the <code>MI_HOME/conf/deployment.toml</code> file, under the `[mediation]` section. The default setting is <code>true</code>.
         </td>
      </tr>
      <tr>
        <td>Suspend</td>
        <td>
          If the inbound listener should pause when accepting incoming requests, set this to <code>true</code>. If the inbound listener should not pause when accepting incoming requests, set this to <code>false</code>.
        </td>
      </tr>
   </tbody>
</table>

### Mediation-Level Properties

Following are the mediation level properties that you can set in the HL7 inbound endpoint:

!!! Note
    The scope of these properties is the `default` scope.

| **Property**                                                                                            | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|---------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `<property name="HL7_RESULT_MODE" value="ACK|NACK" scope="default"/>`          | This is use to define the type of HL7 acknowledgement to be sent. If the `             inbound.hl7.AutoAck            ` parameter is set to `             true            ` this property has no effect.                                                                                                                                                                                                                                                                                                             |
| `             <property name="HL7_NACK_MESSAGE" value="<ERROR MESSAGE>" scope="default" />            ` | This is used to define a custom error message to be sent if you have set the property `             HL7_RESULT_MODE            ` as `             NACK            ` .                                                                                                                                                                                                                                                                                                                                                |
| `             <property name="HL7_APPLICATION_ACK" value="true" scope="default"/>            `          | If the `             inbound.hl7.AutoAck            ` parameter is set to `             false            ` and no immediate auto generated ACK is sent back to the client, this property defines whether we should automatically generate the ACK for the request once the mediation flow is complete. If both the `             inbound.hl7.AutoAck            ` parameter and this property are set to `             false            `, you need to generate an ACK message in the correct format as a response. |
