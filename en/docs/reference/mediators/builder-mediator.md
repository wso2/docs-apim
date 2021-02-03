# Builder Mediator

The **Builder Mediator** can be used to build the actual SOAP message from a message coming into the Micro Integrator through the Binary Relay. One usage is to use this before trying to log the actual message in case of an error. Also the Builder Mediator in the Micro Integrator can be configured to build some of the messages while passing the others along.

!!! Info
    In order to use the Builder mediator, `BinaryRealyBuilder` should be specified as the message builder in the `MI_HOME/conf/ei.toml` file for at least one content type. The message formatter specified for the same content types should be `ExpandingMessageFormatter`. Unlike other message builders, the BinaryRelayBuilder works by passing through a binary stream of the received content. The Builder mediator is used in conjunction with the BinaryRelayBuilder when we require to build the binary stream into a particular content type during mediation. We can specify the message builder that should be used to build the binary stream using the Builder mediator.

By default, the Builder Mediator uses the `         axis2        ` default Message builders for the content types. Users can override those by using the optional `         messageBuilder        ` configuration. For more information, see [Configuring Message Builders and Formatters]({{base_path}}/install-and-setup/message_builders_formatters/message-builders-and-formatters.md).

A user has to specify the content type and the implementation class of the `         messageBuilder        `. Also, users can specify the message `formatter` for this content type. This is used by the `         ExpandingMessageFormatter        ` to format the message before sending to the destination.

## Syntax

``` java
<builder>
        <messageBuilder contentType="" class="" [formatterClass=""]/>
</builder>
```

  
  
