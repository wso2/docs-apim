# EJB Mediator

The **EJB mediator** calls an external Enterprise JavaBean(EJB) and stores the result in the message payload or in a message context property. Currently, this mediator supports EJB3 Stateless Session Beans and Stateful Session Beans.

!!! Info
    The EJB mediator is a [content-aware]({{base_path}}/concepts/message-processing-units/#classification-of-mediators) mediator.

## Syntax

``` java
<ejb beanstalk="string" class="string" [sessionId="string"] [remove="true | false"] 
  [method="string"] [target="string | {xpath}"] [jndiName="string"] /> 
    <args> 
      <arg (value="string | {xpath}")/>* 
    </args> 
</ejb>
```

## Configuration

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Beanstalk ID</td>
<td>Reference to the application server specific connection source information, which is defined at the synapse.properties.</td>
</tr>
<tr class="even">
<td>Class</td>
<td>This required the remote interface definition provided in the EJB 3.0 (EJB service invocation remote/home interface).</td>
</tr>
<tr class="odd">
<td>Session ID</td>
<td><p>When the EJB context is invoked in the form state-full bean then the related ejb session status specified will be stored in here. Possible values are as follows.</p>
<ul>
<li><strong>Value</strong>: If this is selected, the session ID can be entered as a static value.</li>
<li><strong>Expression</strong>: If this is selected, an XPath expression can be entered to evaluate the session ID.</li>
</ul></td>
</tr>
<tr class="even">
<td>Remove</td>
<td><p>This parameter specifies whether the Enterprise Entity Manager should remove the EJB context related parameters once the state full/stateless session is invoked.</p></td>
</tr>
<tr class="odd">
<td>Target</td>
<td><p>If a particular EJB method returns, then the return object can be saved against the the name provided in the target at the synapse property context.</p></td>
</tr>
<tr class="even">
<td>JNDI Name</td>
<td><p>The Java Naming and Directory Interface (JNDI) is an application programming interface (API) for accessing different kinds of naming and directory services. JNDI is not specific to a particular naming or directory service. It can be used to access many different kinds of systems including file systems; distributed objects systems such as CORBA, Java RMI, and EJB; and directory services such as LDAP, Novell NetWare, and NIS+.</p></td>
</tr>
<tr class="odd">
<td>Add Argument</td>
<td>Can be used to define the arguments which is required for the particular ejb method to be invoked Expression/Value.</td>
</tr>
</tbody>
</table>

!!! Info
    You can click the "Namespaces" link to add namespaces if you are providing an expression. You will be provided another panel named "Namespace Editor" where you can provide any number of namespace prefixes and the URL used in the XPath expression.

## Example

``` java
<ejb beanstalk="jack" class="org.ejb.wso2.test.StoreRegister" method="getStoreById" target="store" jndiName="ejb:/EJBDemo/StoreRegsiterBean!org.ejb.wso2.test.StoreRegister">
   <args>
     <arg xmlns:ns="http://org.apache.synapse/xsd" xmlns:ns3="http://org.apache.synapse/xsd" value="{get-property('loc_id')}"/>
   </args>
</ejb>
```

In this example, the EJB Mediator does the EJB service invocation by calling **getStoreById** pubished at the application server and exposed via `         ejb:/EJBDemo/StoreRegsiterBean!org.ejb.wso2.test.StoreRegister`. The response will then be assigned to the **target** specified (variable/expression).
