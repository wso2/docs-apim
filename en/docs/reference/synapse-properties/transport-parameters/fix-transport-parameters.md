# FIX Parameters

When you implement an integration use case that requires a FIX connection, you can use the following FIX parameters in your [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) artifact.

!!! Info
    The Micro Integrator can use the FIX transport only if the FIX transport listener and sender are enabled and configured at the server level. Read about the [FIX transport]({{base_path}}/install-and-setup/transport_configurations/configuring-transports/#configuring-the-fix-transport).

{!reference/synapse-properties/pull/proxy-service-add-properties-pull.md!}

See [Creating a Proxy Service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) for instructions.

## Service-Level Parameters

<table>
      <tr>
         <th>
          Parameter
         </th>
         <th>
           Description
         </th>
      </tr>
   <tbody>
      <tr>
         <td>
			   transport.fix.AcceptorConfigURL
         </td>
         <td>
            URL to the Quickfix/J acceptor configuration file (see notes below).</br></br> This is required for receiving messages over FIX.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.InitiatorConfigURL
         </td>
         <td>
            URL to the Quickfix/J initiator configuration file (see notes below).</br></br>
            Required for sendingmessages over FIX.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.AcceptorLogFactory
         </td>
         <td>
            Log factory implementation to be used for the FIX acceptor (Determines how logging is done at the acceptor level).</br></br>
            Possible values are <code>console</code>, <code>file</code>, and <code>jdbc</code>.</br></br>
            Logging is disabled by default.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.InitiatorLogFactory
         </td>
         <td>
            Log factory implementation to be used for the FIX acceptor (Determines how logging is done at the acceptor level).</br></br>
            Possible values are <code>console</code>, <code>file</code>, and <code>jdbc</code>.</br></br>
            Logging is disabled by default.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.AcceptorMessageStore
         </td>
         <td>
            Message store mechanism to be used with the acceptor (determines how the FIX message store is maintained).</br></br>
            Possible values are <code>memory</code>, <code>file</code>, <code>sleepycat</code>, and <code>jdbc</code>.</br></br>
            The default value is <code>memory</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.InitiatorMessageStore
         </td>
         <td>
            Message store mechanism to be used with the initiator (determines how the FIX message store is maintained).</br></br>
            Possible values are <code>memory</code>, <code>file</code>, <code>sleepycat</code>, and <code>jdbc</code>.</br></br>
            The default value is <code>memory</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.ResponseDeliverToCompID
         </td>
         <td>
            If the response FIX messages should be delivered to a location different from the location from where the request originated, use this property to set the DeliverToCompID field of the FIX messages.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.ResponseDeliverToSubID
         </td>
         <td>
            If the response FIX messages should be delivered to a location different from the location from where the request originated, use this property to set the DeliverToSubID field of the FIX messages.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.ResponseDeliverToLocationID
         </td>
         <td>
            If the response FIX messages should be delivered to a location different from the location from where the request was originated, use this property to set the DeliverToLocationID field of the FIX messages.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.endAllToInSequence
         </td>
         <td>
            By default, all received FIX messages (including responses) will be directed to the in sequence of the proxy service. Use this property to override that behavior.<br/><br/>
            By default, this setting is <code>true</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.BeginStringValidation
         </td>
         <td>
            Whether the transport should validate <code>BeginString</code> values when forwrding FIX messages across sessions.<br/><br/>
            By default, this setting is <code>true</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.fix.DropExtraResponses
         </td>
         <td>
            In situations where the FIX recipient sends multiple responses per request, use this parameter to drop excessive responses and use only the first one.<br/><br/>
            By default, this setting is <code>false</code>.
         </td>
      </tr>
   </tbody>
</table>
