# Message Relay

**Message Relay** enables WSO2 Micro Integrator to pass messages along without building or processing them
unless specifically requested to do so. When Message Relay is enabled,
an incoming message is wrapped inside a default SOAP envelope as binary
content and sent through the Micro Integrator. This is useful for scenarios where the
Micro Integrator does not need to work on the full message but can work on [message properties]({{base_path}}/reference/mediators/property-mediator)
like request URLs or transport headers instead. With Message Relay, the
Micro Integrator can achieve a very high throughput.

See also [PassThrough Transport]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/#configuring-the-httphttps-transport).

## Configuring Message Relay

The user can replace the expected content types with the Message Relay builder and formatter to pass these
messages through WSO2 Micro Integrator without building them.

!!! Warning 
    Content cannot be altered once the binary relay is enabled. Therefore, if you are enabling the binary relay, content-aware

### Message Relay Builder and Formatter Class Names

-   Builder: `org.wso2.carbon.relay.BinaryRelayBuilder `
-   Formatter: `org.wso2.carbon.relay.ExpandingMessageFormatter `

### Sample Configuration for Message Builder

```toml
[message_builders]
application_xml = "org.wso2.carbon.relay.BinaryRelayBuilder"
form_urlencoded = "org.wso2.carbon.relay.BinaryRelayBuilder"
multipart_form_data = "org.wso2.carbon.relay.BinaryRelayBuilder"
text_plain = "org.wso2.carbon.relay.BinaryRelayBuilder"
application_json = "org.wso2.micro.integrator.core.json.JsonStreamBuilder"
json_badgerfish = "org.apache.axis2.json.JSONBadgerfishOMBuilder"
text_javascript = "org.apache.axis2.json.JSONBuilder"
octet_stream =  "org.wso2.carbon.relay.BinaryRelayBuilder"
application_binary = "org.apache.axis2.format.BinaryBuilder"
```

### Sample Configuration for Message Formatter

```toml
[message_formatters]
form_urlencoded =  "org.wso2.carbon.relay.ExpandingMessageFormatter"
multipart_form_data =  "org.wso2.carbon.relay.ExpandingMessageFormatter"
application_xml = "org.wso2.carbon.relay.ExpandingMessageFormatter"
text_xml = "org.wso2.carbon.relay.ExpandingMessageFormatter"
text_plain = "org.wso2.carbon.relay.ExpandingMessageFormatter"
application_json =  "org.wso2.carbon.relay.ExpandingMessageFormatter"
json_badgerfish = "org.wso2.carbon.relay.ExpandingMessageFormatter"
```

## Example

If you want the Micro Integrator to receive messages of the `image/png` content type, add the following to the deployment.toml file:

```toml tab='Message Builder'
[[custom_message_builders]]
class = "org.wso2.carbon.relay.BinaryRelayBuilder"
content_type = "image/png"
```

```toml tab='Message Formatter'
[[custom_message_formatters]]
class = "org.wso2.carbon.relay.ExpandingMessageFormatter"
content_type = "image/png"
```

## Message Relay Module Policy

Syntax of Relay Module Policy.

```xml
<wsp:Policy wsu:Id="MessageRelayPolicy" xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy"
                    xmlns:wsmr="http://www.wso2.org/ns/2010/01/carbon/message-relay"
                    xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
            <wsmr:RelayAssertion>
                <wsp:Policy>
                    <wsp:All>
                        <wsmr:includeHiddenServices>false | false</wsmr:includeHiddenServices>
                        <wsmr:services>
                            <wsmr:service>Name of the service</wsmr:service>*
                        </wsmr:services>
                        <wsmr:builders>
                            <wsmr:messageBuilder contentType="content type of the message" class="message builder implementation class" class="message formatter implementation class"/>
                        </wsmr:builders>
                    </wsp:All>
                </wsp:Policy>
            </wsmr:RelayAssertion>
</wsp:Policy>
```

These are the assertions:

-   **includeHiddenServices** - If this is true message going to the
    services with `          hiddenService         ` parameter will be
    built.
-   **wsmr:services** - Messages going to these services will be built.
-   **wsmr:service** - Name of the service.
-   **wsmr:builders** - Message builders to be used for building the
    message.
-   **wsmr:builder** - A message builder to be used for a content type.

After changing the policy, the user has to restart the Micro Integrator for the changes to take effect.

If the Message Relay is enabled for particular content type, there
cannot be any services with security enabled for that content type.
