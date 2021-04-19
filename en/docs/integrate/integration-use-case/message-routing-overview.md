# Message Routing and Transformation

## Message routing

Message routing is one of the most fundamental requirements when integrating systems/services. It considers content-based routing, header-based routing, rules-based routing, and policy-based routing as ways of routing a message. WSO2 Micro Integrator enables these routing capabilities using the concepts of mediators and endpoints.

The following image depicts a form of message routing where a message is routed through the Micro Integrator to the apropriate service. In this case, the Switch/Send mediator can be used.

<img src="{{base_path}}/assets/img/integrate/use-cases-overview/message-routing.png" title="Message Routing" width="500" alt="Message Routing"/>

<!--
![message routing]({{base_path}}/assets/img/integrate/use-cases-overview/message-routing-new.png)
-->

<table>
	<tr>
		<td>
			<b>Tutorials</b></br>
			<ul>
				<li>
					Try the end-to-end use case on <a href="{{base_path}}/tutorials/integration-tutorials/routing-requests-based-on-message-content">message routing</a>
				</li>
			</ul>
		</td>
		<!--
		<td>
			<b>Examples</b>
			<ul>
				<li>
					<a href="{{base_path}}/integrate/examples/message-routing/header-based-routing">Routing based on message header</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/message-routing/payload-based-routing">Routing based on message payload</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/message-routing/split-and-aggregate-responses">Splitting and aggregating response messages</a>
				</li>
			</ul>
		</td>
	-->
	</tr>
</table>

## Message transformation

The integration of systems that communicate in various message formats is a common business case in enterprise integration. WSO2 Micro Integrator facilitates this use case as the intermediary system bridging the communication gap among the systems.

The following image depicts a typical message transormation scenario using the Transform mediator. 

<img src="{{base_path}}/assets/img/integrate/use-cases-overview/message-transformation.png" title="Message Transformation" width="600" alt="Message Transformation"/>

<!--
![message transformation]({{base_path}}/assets/img/integrate/use-cases-overview/message-transformation-new.png) 
-->
<table>
	<tr>
		<td>
			<b>Tutorials</b></br>
			<ul>
				<li>
					Try the end-to-end use case on <a href="{{base_path}}/tutorials/integration-tutorials/transforming-message-content">message transformation</a>
				</li>
			</ul>
		</td>
		<!--
		<td>
			<b>Examples</b>
			<ul>
				<li>
					<a href="{{base_path}}/integrate/examples/message-transformations/soap-to-json-conversion">Converting SOAP Messages to JSON</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/message-transformations/pox-to-json-conversion">Converting POX Messages to JSON</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/message-transformations/json-to-soap-conversion">Converting JSON Messages to SOAP</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/message-transformations/csv-to-other-formats-conversion">Converting CSV Messages to Other Formats</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/message-transformations/csv-conversion">Converting to CSV Message Formats</a>
				</li>
			</ul>
		</td>
	-->
	</tr>
</table>

For example, consider a service that returns data in XML format and a mobile client that accepts messages only in JSON format. To allow these two systems to communicate, the intermediary system needs to convert message formats during the communication. This allows the systems to communicate with each other without depending on the message formats supported by each system.