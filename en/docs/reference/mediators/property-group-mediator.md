# Property Group Mediator

The Property Group Mediator is similar to the [Property Mediator]({{base_path}}/reference/mediators/property-mediator). It sets or removes properties on the message context flowing through synapse. However, unlike the Property mediator, the Property Group mediator handles multiple properties as a
group. You can select the property action (i.e., whether the property
must be added to or removed from the message context) for each
individual property. Therefore, in a scenario where you need to
set/remove multiple properties, you can add a single Property Group
Mediator configuration instead of multiple Property Mediator
configurations.

!!! Info
    The Property Group mediator is a [conditionally content aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

```
<propertyGroup>
    <property name="name0" value="value0"/>
    <property name="name1" value="value1"/>
    <property name="name2" value="value2"/>
    ........
</propertyGroup>
```

## Configuration

The Property Group Mediator configuration includes a description and a set of properties grouped together.

In the source view, multiple Property Mediator configurations are
enclosed within the `         <propertyGroup>        ` element. You can
also add a description in the opening element. (e.g., `<propertyGroup description="A group of properties to include in the greeting message">`).

In the design view, you can configure the Property Group Mediator as
follows:

-   Enter a meaningful description for the property group in the
    **Description** field.
-   To add a new property, click the **Add a new element** icon.  
    ![]({{base_path}}/assets/img/integrate/mediators/119134127/119134143.png)  
    As a result, the **Property Mediator** dialog box opens. Here, you
    can select a predefined property from the list or configure a custom
    property.
-   To remove a property, click the **Delete selected element(s)**
    icon.  
    ![]({{base_path}}/assets/img/integrate/mediators/119134127/119134161.png)
-   To arrange the properties in the required order within the property
    group configuration, you can select any property and then click the
    following icons to move it up/down the list.  
    ![]({{base_path}}/assets/img/integrate/mediators/119134127/119134166.png)
    ![]({{base_path}}/assets/img/integrate/mediators/119134127/119134167.png)

## Example

The following Propert Group Mediator configuration adds the
`         From        ` , `         Message        ` , and
`         To        ` properties to the message context. It also removes
the `         MessageID        ` property from the context. All four
properties are handled together as a group.

``` xml
<propertyGroup description="A group of properties to include in the greeting.">
    <property action="remove" name="MessageID" scope="default"/>
    <property name="From" scope="default" type="STRING" value=""/>
    <property name="Message" scope="default" type="STRING" value="Welcome to XXX group!"/>
    <property name="To" scope="default" type="STRING" value=""/>
</propertyGroup>
```
