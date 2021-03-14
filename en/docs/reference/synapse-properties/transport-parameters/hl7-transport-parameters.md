# HL7 Parameters

When you implement an integration use case that handles HL7 messsages, you can use the following HL7 parameters in your [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) artifact.

!!! Info
    The Micro Integrator can receive HL7 messages or send HL7 messages only if the HL7 transport listener and sender are enabled and configured at the server level. Read about the [HL7 transport]({{base_path}}/install-and-setup/transport_configurations/configuring-transports/#configuring-the-hl7-transport).

{!reference/synapse-properties/pull/proxy-service-add-properties-pull.md!}

See [Creating a Proxy Service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) for instructions.

## Service-level Parameters

### HL7 receiver port (Required)

<table>
  <tr>
    <th>
      Parameter
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      transport.hl7.Port
    </td>
    <td>
      Add this parameter to specify the port on which the Micro Integrator listens to incoming HL7 messages.
    </td>
  </tr>
</table>

### HL7 Conformance profile path

<table>
  <tr>
    <th>
      Parameter
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      transport.hl7.ConformanceProfilePath
    </td>
    <td>
      Add this parameter to the proxy service to specify the URL of the HL7 conformance profile (XML file).
    </td>
  </tr>
</table>

### Message acknowledgement

<table>
  <tr>
    <th>
      Parameter
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      transport.hl7.AutoAck
    </td>
    <td>
      Add this parameter to the proxy service to disable auto acknowledgement of HL7 messages. You can disable auto acknowledgement by setting this parameter to 'false'.</br></br>
      By default, auto acknowledgement is enabled in the Micro Integrator, which means that an ACK message is sent to the client as soon as the message is received by the mediation sequence.</br></br>
      <b>Note</b>: When automatic acknowledgment is disabled, you can manually configure ACK/NACK messages for HL7 in the mediation sequence by using the following mediation properties:
      <ul>
      	<li>
      		<a href="{{base_path}}/reference/mediators/property-reference/axis2-properties/#hl7_generate_ack">HL7_GENERATE_ACK</a>
      	</li>
      	<li>
      		<a href="{{base_path}}/reference/mediators/property-reference/axis2-properties/#hl7_result_mode">HL7_RESULT_MODE</a>
      	</li>
      	<li>
      		<a href="{{base_path}}/reference/mediators/property-reference/axis2-properties/#hl7_nack_message">HL7_NACK_MESSAGE</a>
      	</li>
      	<li>
      		<a href="{{base_path}}/reference/mediators/property-reference/axis2-properties/#hl7_application_ack">HL7_APPLICATION_ACK</a>
      	</li>
      	<li>
      		<a href="{{base_path}}/reference/mediators/property-reference/axis2-properties/#hl7_raw_message">HL7_RAW_MESSAGE</a>
      	</li>
      </ul> 
      See <a href="{{base_path}}/integrate/examples/hl7-examples/acknowledge_hl7_messages">Message Acknowledgement for HL7 Messages</a> for details.
    </td>
  </tr>
</table>

### Message pre-processing

<table>
  <tr>
    <th>
      Parameter
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      transport.hl7.MessagePreprocessorClass
    </td>
    <td>
      Add this parameter to the proxy service to specify an implementation class of the <code>org.wso2.micro.integrator.business.messaging.hl7.common.HL7MessagePreprocessor</code> interface. This will be used for processing raw HL7 messages before parsing them. This allows potential errors in the messages to be rectified using the transport.
    </td>
  </tr>
</table>

### Message validation

By default, the HL7 transport validates messages before building their XML representation. You configure validation with the following parameter in the proxy service:

<table>
   <tr>
      <th>
         Parameter
      </th>
      <th>
         Description
      </th>
   </tr>
   <tr>
     <td>
       transport.hl7.ValidateMessage
     </td>
     <td>
       By default, the HL7 transport validates messages before building their XML representation. You can set this parameter to false if you want to disable message validation.
     </td>
   </tr>
   <tr>
      <td>
         transport.hl7.BuildInvalidMessages
      </td>
      <td>
         When transport.hl7.ValidateMessage is set to false, you can set this parameter to handle invalid messages.</br></br> When this parameter is set to true, builds a SOAP envelope with the contents of the raw HL7 message inside the element.
      </td>
   </tr>
   <tr>
      <td>
         transport.hl7.PassThroughInvalidMessages
      </td>
      <td>
         When transport.hl7.ValidateMessage is set to false, you can set this parameter to handle invalid messages.</br></br> When this parameter (BuildInvalidMessages) is set to true, you use this parameter to specify whether to pass this message through (true) or to throw a fault (false).
      </td>
   </tr>
</table>

### Thread pool configurations

The HL7 transport uses a thread pool to manage connections. A larger thread pool provides greater performance, because the transport can process more messages simultaneously, but it also uses more memory. You can add the following properties to the proxy service to configure the thread pool to suit your environment:

<table>
   <tr>
      <th>
         Parameter
      </th>
      <th>
         Description
      </th>
   </tr>
   <tr>
      <td>
         transport.hl7.corePoolSize
      </td>
      <td>
         The core number of threads in the pool. Default is 10.
      </td>
   </tr>
   <tr>
      <td>
         transport.hl7.maxPoolSize
      </td>
      <td>
         The maximum number of threads that can be in the pool. Default is 20.
      </td>
   </tr>
   <tr>
      <td>
         transport.hl7.idleThreadKeepAlive
      </td>
      <td>
         The time in milliseconds to keep idle threads alive before releasing them. Default is 10000 (10 seconds). 
      </td>
   </tr>
</table>

## Related topics

See the following examples demonstrating HL7 use cases:

- [Enabling HL7]({{base_path}}/install-and-setup/transport_configurations/configuring-transports/#configuring-the-hl7-transport)
- [Mediating HL7 Messages]({{base_path}}/integrate/examples/hl7-examples/HL7_proxy_service)
- [Configuring Message Acknowledgement for HL7 Messages]({{base_path}}/integrate/examples/hl7-examples/acknowledge_hl7_messages)
- [Using HL7 Messages with File Systems]({{base_path}}/integrate/examples/hl7-examples/file_transfer_using_hl7)