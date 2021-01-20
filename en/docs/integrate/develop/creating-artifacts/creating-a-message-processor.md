# Creating a Message Processor

Follow the instructions given below to create a new [Message Processor]({{base_path}}/reference/synapse-properties/about-message-stores-processors) artifact in WSO2 Integration Studio.

## Instructions

### Creating the Message Processor artifact

1.  Right-click the [ESB Config project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project) and go to **New → Message Processor** to open the **New Message Processor Artifact** dialog box.

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_message_processor/select-message-processor.png">

2.  Select **Create a new message-processor artifact** and click **Next**.

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_message_processor/new-message-processor-wizard-1.png" width="500">

3.  Enter a unique name for this message processor, specify the type of processor you're creating.

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_message_processor/new-message-processor-wizard-2.png" width="500">

	See the links given below for descriptions of properties for each message processor type:

	-	[Message Sampling Processor properties]({{base_path}}/reference/synapse-properties/message-processors/msg-sampling-processor-properties)
	-	[Scheduled Message Forwarding Processor properties]({{base_path}}/reference/synapse-properties/message-processors/msg-sched-forwarding-processor-properties)
	-	[Scheduled Failover Message Forwarding Processor properties]({{base_path}}/reference/synapse-properties/message-processors/msg-sched-failover-forwarding-processor-properties)

4.  Do one of the following to save the artifact:

  	-   To save the message processor in an existing ESB Config project in your workspace, click **Browse** and select that project.
  	-   To save the message processor in a new ESB Config project, click **Create new Project** and create the new project.

5.  Click **Finish**. 

The message processor is created in the `src/main/synapse-config/message-processors` folder under the ESB Config project you specified.

### Updating the properties

Open the new message processor artifact from the project explorer. You can use the **Form** view or the **Source** view to update message processor properties.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_message_processor/message-processor-form-view.png" width="800">

See the links given below for descriptions of properties for each processor type:

-	[Message Sampling Processor properties]({{base_path}}/reference/synapse-properties/message-processors/msg-sampling-processor-properties)
-	[Scheduled Message Forwarding Processor properties]({{base_path}}/reference/synapse-properties/message-processors/msg-sched-forwarding-processor-properties)
-	[Scheduled Failover Message Forwarding Processor properties]({{base_path}}/reference/synapse-properties/message-processors/msg-sched-failover-forwarding-processor-properties)

## Examples

<ul>
	<li>
		<a href="{{base_path}}/integrate/examples/message_store_processor_examples/using-message-forwarding-processor">Using the Message Forwarding Processor</a>
	</li>
	<li>
		<a href="{{base_path}}/integrate/examples/message_store_processor_examples/using-message-sampling-processor">Using the Message Sampling Processor</a>
	</li>
	<li>
		<a href="{{base_path}}/integrate/examples/message_store_processor_examples/securing-message-processor">Securing the Message Forwarding Processor</a>
	</li>
	<li>
		<a href="{{base_path}}/integrate/examples/message_store_processor_examples/loadbalancing-with-message-processor">Load Balancing with Message Forwarding Processor</a>
	</li>
</ul>

## Tutorials

-	See the tutorial on [using message stores and processors]({{base_path}}/integrate/tutorials/storing-and-forwarding-messages)
