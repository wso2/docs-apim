# Reusing Endpoints

## Using Indirect Endpoints

In the following [Send
mediator]({{base_path}}/reference/mediators/send-mediator)
configuration, the `         PersonInfoEpr        ` key refers to a
specific endpoint configured.

```
<send>
   <endpoint key="PersonInfoEpr"/>
</send>
```

## Using Resolving Endpoints

!!! Info
	The XPath expression specified in a Resolving endpoint configuration derives an existing endpoint rather than the URL of the endpoint to which the message is sent. To derive the endpoint URL to which the message is sent via an XPath expression, use the **Header** mediator.

In the following [Send
mediator]({{base_path}}/reference/mediators/send-mediator)
configuration, the endpoint to which the message is sent is determined
by the `         get-property('Mail')        ` expression.

```
<send>
  <endpoint key-expression="get-property('Mail')"/>
</send>
```
