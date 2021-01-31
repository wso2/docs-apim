# Asynchronous Message Processing

Asynchronous messaging is a communication method wherein the system puts a message in a message queue and does not require an immediate response to continue processing. Asynchronous messaging is useful for the following:

- Delegate the request to some external system for processing
- Ensure delivery of a message to an external system
- Throttle message rates between two systems
- Batch processing of messages

Note the following about asynchronous message processing:

- Asynchronous messaging solves the problem of intermittent connectivity. The message receiving party does not need to be online to receive the message as the message is stored in a middle layer. This allows the receiver to retrieve the message when it comes online.
- Message consumers do not need to know about the message publishers. They can operate independently.

Disadvantages of asynchronous messaging includes the additional component of a message broker or transfer agent to ensure the message is received. This may affect both performance and reliability. There are various levels of message delivery reliability grantees from publisher to broker and from broker to subscriber. Wire level protocols like AMQP and MQTT can provide those.

<table>
	<tr>
		<td>
			<b>Tutorials</b></br>
			<ul>
				<li>
					Try the end-to-end use case on <a href="{{base_path}}/tutorials/integration-tutorials/storing-and-forwarding-messages">asynchronous messaging</a>
				</li>
			</ul>
		</td>
		<td>
			<b>RabbitMQ Examples</b>
            <ul>
                <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/point-to-point-rabbitmq">Point to Point</a></li>
                <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/pub-sub-rabbitmq">Publish/Subscribe</a></li>
                <li>Guaranteed Delivery 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/store-forward-rabbitmq">Message Store and Message Processor</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/retry-delay-failed-msgs-rabbitmq">Retry failed messages with a delay</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/requeue-msgs-with-errors-rabbitmq">Requeue a message preserving the order</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/move-msgs-to-dlq-rabbitmq">Publish messages to DLX</a></li>
                    </ul>
                </li>
                <li>
                	<a href="{{base_path}}/integrate/examples/rabbitmq_examples/request-response-rabbitmq">Dual Channel</a>
                </li>
            </ul>
		</td>
		<td>
			<b>JMS Examples</b>
			<ul>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/consuming-jms">Consuming JMS Messages</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/producing-jms">Producing JMS Messages</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/consume-produce-jms">Consumining and Producing JMS Messages</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/dual-channel-http-to-jms">Dual Channel HTTP to JMS</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/quad-channel-jms-to-jms">Quad Channel JMS to JMS</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/guaranteed-delivery-with-failover">Guaranteed Delivery with Failover</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/publish-subscribe-with-jms">Publish and Subscribe with JMS</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/shared-topic-subscription">Shared Topic Subscriptions</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/detecting-repeatedly-redelivered-messages">Detecting Repeatedly Redilivered Messages</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/jms_examples/specifying-a-delivery-delay-on-messages">Delivery Delay on Messages</a>
				</li>
			</ul>
		</td>
	</tr>
</table>