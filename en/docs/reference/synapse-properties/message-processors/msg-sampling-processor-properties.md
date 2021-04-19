# Message Sampling Processor Properties
## Introduction
The message sampling processor consumes messages in a <a href="#list-of-message-stores">message store</a> and sends them to a configured <a href="{{base_path}}/reference/synapse-properties/sequence-properties">sequence</a>. This process happens at a preconfigured interval. This message processor does not ensure reliable messaging.

## Properties

See the topics given below for the list of properties that can be configured for a Message Sampling Processor.

### Required Properties

Following are the required parameters you can set when [adding a Scheduled Message Forwarding Processor]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-processor.md):

<table>
	<tr>
		<th>Property</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>Message Processor Type</td>
		<td>
			Select <b>Message Sampling Processor</b> from the list of values.
		</td>
	</tr>
	<tr>
		<td>Message Processor Name</td>
		<td>
			Give a name for the message processor artifact.
		</td>
	</tr>
	<tr>
		<td>Message Store</td>
		<td>
			Select a pre-defined Message Store artifact from the available list.
		</td>
	</tr>
	<tr>
         <td>Processor State ( <code>             is.active            </code> )</td>
         <td>Activate (<code>true</code>) or Deactivate (<code>false</code>).
         	Activated by default.
         </td>
     </tr>
</table>

### Optional Properties

Following are the additional parameters you can set when [adding a message sampling processor]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-processor.md):

<table>
   <thead>
      <tr>
         <th>
            <p>Parameter Name</p>
         </th>
         <th>
            <p>Description</p>
         </th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>
            <p>Quartz Configuration File Path ( <code>quartz.conf             </code> )</p>
         </td>
         <td>
            <p>Quartz configuration file path. This properties file contains the Quartz configuration parameters for fine tuning the Quartz engine. More details of the configuration can be found at <a href="http://quartz-scheduler.org/documentation/quartz-2.x/configuration/ConfigMain">http://quartz-scheduler.org/documentation/quartz-2.x/configuration/ConfigMain</a> .
            </p>
         </td>
      </tr>
      <tr>
         <td>
            <p>Cron Expression ( <code>              cronExpression             </code> )</p>
         </td>
         <td>
            <p>Cron expression to be used to configure the retry pattern</p>
         </td>
      </tr>
   </tbody>
</table>