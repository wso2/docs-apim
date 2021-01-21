# Scheduled Failover Message Forwarding Processor
## Introduction
The scheduled failover message forwarding processor ensures reliable message delivery. This helps ensure guaranteed message delivery even when there is a failure in the message store.</br></br>
The only difference between the scheduled failover message forwarding processor and the scheduled message forwarding processor is that the scheduled message forwarding processor forwards messages to a defined endpoint, whereas the scheduled failover message forwarding processor forwards messages to a target message store.

## Properties

See the topics given below for the list of properties that can be configured for a Scheduled Failover Message Forwarding Processor.

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

Following are the additional parameters you can set when [adding a Scheduled Failover Message Forwarding Processor]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-processor.md):

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
         <td>Forwarding interval ( <code>             interval            </code> )</td>
         <td>
            <p>Interval in milliseconds in which processor consumes messages. The default value is 1000.</p>
         </td>
      </tr>
      <tr>
         <td>
            <p>Retry interval ( <code>              client.retry.interval             </code> )</p>
         </td>
         <td>
            <p>Message retry interval in milliseconds. The default is value is 1000</p>
         </td>
      </tr>
      <tr>
         <td>
            <p>Maximum delivery attempts ( <code>              max.delivery.attempts             </code> )</p>
         </td>
         <td>
            <p>Maximum redelivery attempts before deactivating the processor. This is used when the backend server is inactive and the ESB profile tries to resend the message. If you set the value of this property to -1, it deactivates the message processor without retrying, after the first attempt fails. The default value is <code>4</code>.</p>
         </td>
      </tr>
      <tr>
         <td>Drop message after maximum delivery attempts ( <code>             max.delivery.drop            </code> )</td>
         <td>
            <p>If this parameter is set to <code>              Enabled             </code> , the message will be dropped from the message store after the maximum number of delivery attempts are made, and the message processor will remain activated. This parameter would have no effect when no value is specified for the <strong>Maximum Delivery Attempts</strong> parameter.</p>
            <p>The <strong>Maximum Delivery Attempts</strong> parameter can be used when the backend is inactive and the message is resent.<br />
               <br />
               If this parameter is disabled, the undeliverable message will not be dropped and the message processor will be deactivated.
            The default value is <code>Disabled</code>.
            </p>
         </td>
      </tr>
      <tr>
         <td>
            <p>Fault sequence name ( <code>              message.processor.fault.sequence             </code> )</p>
         </td>
         <td>
            <p>The name of the sequence where the fault message should be sent to in case of a SOAP fault.</p>
         </td>
      </tr>
      <tr>
         <td>
            <p>Deactivate sequence name ( <code>              message.processor.deactivate.sequence             </code> )</p>
         </td>
         <td>
            <p>The deactivate sequence that will be executed when the processor is deactivated automatically. Automatic deactivation occurs when the maximum delivery attempts is exceeded and the Drop message after maximum delivery attempts parameter is disabled.</p>
         </td>
      </tr>
      <tr>
         <td>
            <p>Quartz configuration file path ( <code>              quartz.conf             </code> )</p>
         </td>
         <td>
            <p>The Quartz configuration file path. This properties file contains the Quartz configuration<br />
               parameters for fine tuning the Quartz engine. More details of the configuration can be<br />
               found at <a href="http://quartz-scheduler.org/documentation/quartz-2.x/configuration/ConfigMain">http://quartz-scheduler.org/documentation/quartz-2.x/configuration/ConfigMain</a> .
            </p>
         </td>
      </tr>
      <tr>
         <td>
            <p>Cron Expression ( <code>              cronExpression             </code> )</p>
         </td>
         <td>
            <p>The cron expression to be used to configure the retry pattern.</p>
         </td>
      </tr>
      <tr>
         <td>
            Task Count (Cluster Mode)
            <p><br /></p>
         </td>
         <td>The required number of worker nodes when you need to run the processor in more than 1 worker node. Specifying this will not guarantee that the processor will run on each worker node. There can be instances where the processor will not run in some workers nodes. The default value is 1.</td>
      </tr>
   </tbody>
</table>