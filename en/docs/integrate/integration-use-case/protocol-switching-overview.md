# Protocol Switching

The Micro Integrator offers a wide range of integration capabilities from simple message routing to complicated systems that use integrated solutions. Different applications typically use different protocols for communication. Therefore, for two systems to successfully communicate, it is necessary to switch the protocol (that passes from one system) to the protocol compatible with the receiving application.
<!--
![protocol switching]({{base_path}}/assets/img/integrate/use-cases-overview/protocol-switching-new.png)
-->

For example, messages that are received via HTTP may need to be sent to a JMS queue. Further, you can couple the protocol switching feature with the message transformation feature to handle use cases where the content of messages received via one protocol (such as HTTP) are first processed, and then sent out in a completely different message format and protocol.

<table>
	<tr>
		<td>
			<b>Examples</b>
			<ul>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_JMS_to_HTTP">Switching from JMS to HTTP/S</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_HTTPS_to_JMS">Switching from HTTP/S to JMS</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_FTP_listener_to_mail_sender">Switching from FTP Listener to Mail Sender</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_HTTP_to_FIX">Switching from HTTP to FIX</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_FIX_to_HTTP">Switching from FIX to HTTP</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_FIX_to_AMQP">Switching from FIX to AMQP</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_between_FIX_versions">Switching between FIX Versions</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_TCP_to_HTTPS">Switching from TCP to HTTP/S</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_UDP_to_HTTPS">Switching from UDP to HTTP/S</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/protocol-switching/switching_between_HTTP_and_MSMQ">Switching between HTTP to MSMQ</a>
				</li>
			</ul>
		</td>
	</tr>
</table>