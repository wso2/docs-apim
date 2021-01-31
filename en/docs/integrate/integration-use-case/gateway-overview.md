# Gateway

The Gateway pattern is used for securely exposing APIs (representing business functionalities) to external and internal consumers. In technical terms, APIs provide an abstract layer for the internal business services, which allows you to meet consumer demand. APIs and proxy services in WSO2 Micro Integrator aggregates the back-end services/micro services into a unified services layer and the security policies for authentication and autharization are applied at the services layer. This ensures that only authorized consumers have access to the services and that the back-end is simplified.

You can implement the Gateway pattern by deploying WSO2 Micro Integrator in a “DMZ” (demilitarized zone) and thereby exposing the services to external service consumers. The DMZ pre-processes service requests coming from the public and routes only valid and authorized messages to the actual service platforms. Pre-processing typically consist of message validation, filtering, and transformation, orchestration, etc.

Proxy services in the Micro Integrator act as Messaging Gateways, abstracting the details of the actual back-end services from implementing clients.

<img src="{{base_path}}/assets/img/integrate/use-cases-overview/message-gateway.png" title="Message Gateway" width="600" alt="Message Gateway"/>

<!--
<table>
	<tr>
		<td>
			<b>Tutorials</b></br>
			<ul>
				<li>
					Try the end-to-end use case on <a href="{{base_path}}/tutorials/integration-tutorials/integration/service-gateway-tutorial">using the Micro Integrator as a service gateway</a>
				</li>
			</ul>
		</td>
		<td>
			<b>Examples</b>
			<ul>
				<li>
					<a href="{{base_path}}/integrate/examples/gateway/expose-http-app-as-soap">Expose HTTP-based Applications as a SOAP Service</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/gateway/expose-http-app-as-rest-api">Expose HTTP-based Applications as a REST Api</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/gateway/expose-file-based-system-over-http">Expose File-based Systems over HTTP</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/gateway/expose-proprietary-prot-over-stand-protocols">Expose Services on Proprietary Protocols over Standard Protocols</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/gateway/securing-backend-with-request-throttling">Securing Backend with Request Throttling</a>
				</li>
			</ul>
		</td>
	</tr>
</table>
-->