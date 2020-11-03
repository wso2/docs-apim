# Creating a Message Store

Follow the instructions given below to create a new [Message Store](../../../references/synapse-properties/about-message-stores-processors) artifact in WSO2 Integration Studio.

## Instructions

### Creating the Message Store artifact

1.	Right-click the [ESB Config project](../../creating-projects/#esb-config-project) and go to **New → Message Store** to open the **New Message Store Artifact** dialog box.

	<img src="../../../assets/img/create_artifacts/new_message_store/select-message-store.png" width="600">

2.	Select the **Create a new message-store artifact** option and click **Next**.

	<img src="../../../assets/img/create_artifacts/new_message_store/new-message-store-wizard-1.png" width="500">

3.	Enter a unique name for the message store, and then select the type of message store you are creating.

	<img src="../../../assets/img/create_artifacts/new_message_store/new-message-store-wizard-2.png" width="500">

	See the links given below for descriptions of message store properties for each store type:

	-	[JMS properties](../../../references/synapse-properties/message-stores/jms-msg-store-properties)
	-	[JDBC properties](../../../references/synapse-properties/message-stores/jdbc-msg-store-properties)
	-	[RabbitMQ properties](../../../references/synapse-properties/message-stores/rabbitmq-msg-store-properties)
	-	[Resequence properties](../../../references/synapse-properties/message-stores/resequence-msg-store-properties)
	-	[WSO2 MB properties](../../../references/synapse-properties/message-stores/wso2mb-msg-store-properties)
	-	[In-Memory properties](../../../references/synapse-properties/message-stores/in-memory-msg-store-properties)
	-	[Custom properties](../../../references/synapse-properties/message-stores/custom-msg-store-properties)

5. Do one of the following to save the artifact:

	-   To save the message store in an existing ESB Config project in your workspace, click **Browse** and select that project.
	-   To save the message store in a new ESB Config project, click **Create new Project** and create the new project.

6. Click **Finish**. 

The message store is created in the `src/main/synapse-config/message-stores` folder under the ESB Config project you specified.

### Designing the integration

To add a message store to the integration sequence, use the [Store Mediator](../../../references/mediators/store-Mediator):

1.	Open to the **Design View** of your [mediation sequence](../../../references/synapse-properties/sequence-properties).
2.	Drag the [Store Mediator](../../../references/mediators/store-Mediator) from the **Palette** and drop it to the relevant position in the [mediation sequence](../../../references/synapse-properties/sequence-properties):

	<img src="../../../assets/img/create_artifacts/new_message_store/message-store-graphical-editor.png" width="700">

3.	Double-click the **Store Mediator** to open the **Properties** tab:

	<img src="../../../assets/img/create_artifacts/new_message_store/message-store-properties.png" width="700">

4.	Select your message store artifact from the list in the **Available Message Stores** field as shown above.

The message store is now linked to your integration sequence.

### Updating the properties

Open the new message store artifact from the project explorer. You can use the **Form** view or the **Source** view to update message store properties.

<img src="../../../assets/img/create_artifacts/new_message_store/message-store-form-view.png" width="700">

## Examples

-   [Introduction to Message Stores and Processors](../../../use-cases/examples/message_store_processor_examples/intro-message-stores-processors)
-   [JDBC Message Store](../../../use-cases/examples/message_store_processor_examples/using-jdbc-message-store)
-   [JMS Message Store](../../../use-cases/examples/message_store_processor_examples/using-jms-message-stores)
-   [RabbitMQ Message Store](../../../use-cases/examples/message_store_processor_examples/using-rabbitmq-message-stores)

## Tutorials

-	See the tutorial on [using message stores and processors](../../../use-cases/tutorials/storing-and-forwarding-messages)
