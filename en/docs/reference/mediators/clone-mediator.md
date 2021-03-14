# Clone Mediator

The **Clone Mediator** can be used to clone a message into several messages. It resembles the [Scatter-Gather enterprise integration pattern](http://docs.wso2.org/display/IntegrationPatterns/Scatter-Gather). The Clone mediator is similar to the [Iterate mediator]({{base_path}}/reference/mediators/iterate-mediator). The difference between the two mediators is that the Iterate mediator splits a message into different parts, whereas the Clone mediator makes multiple identical copies of the message.

!!! Info
    The Clone mediator is a [content-aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

``` java
<clone [continueParent=(true | false)]>
   <target [to="uri"] [soapAction="qname"] [sequence="sequence_ref"] [endpoint="endpoint_ref"]>
     <sequence>
       (mediator)+
     </sequence>?
     <endpoint>
       endpoint
     </endpoint>?
   </target>+
</clone>
```

## Configuration

The parameters available to configure the Clone mediator is as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Clone ID</strong></td>
<td>Identification of messages created by the clone mediator. This is particularly useful when aggregating responses of messages that are created using nested Clone mediators.</td>
</tr>
<tr class="even">
<td><strong>Sequential Mediation</strong></td>
<td><p>This parameter is used to specify whether the cloned messages should be processed sequentially or not. The processing is carried based on the information relating to the sequence and endpoint specified in the <a href="#target-configuration">target configuration</a>. The possible values are as follows.</p>
<ul>
<li><strong>Yes</strong>: If this is selected, the cloned messages will be processed sequentially. Note that selecting <strong>True</strong> might cause delays due to high resource consumption.</li>
<li><strong>No</strong>: If this is selected, the cloned messages will not be processed sequentially. This is the default value and it results in better performance.</li>
</ul></td>
</tr>
<tr class="odd">
<td><strong>Continue Parent</strong></td>
<td><p>This parameter is used to specify whether the original message should be preserved or not. Possible values are as follows.</p>
<ul>
<li><strong>Yes</strong>: If this is selected, the original message will be preserved.</li>
<li><strong>No</strong>: If this is selected, the original message will be discarded. This is the default value.</li>
</ul></td>
</tr>
<tr class="even">
<td><div class="content-wrapper">
<strong>Number of Clones</strong>
</div></td>
<td><div class="content-wrapper">
<p>The parameter indicates the number of targets which currently exist for the Clone mediator. Click <strong>Add Clone Target</strong> to add a new target. Each time you add a target, it will be added as a child of the Clone mediator in the mediator tree as shown below.</p>
<p>Click <strong>Target</strong> to add the target configuration as described below.</p>
</div></td>
</tr>
</tbody>
</table>

### Target configuration

The parameters available to configure the target are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>SOAP Action</strong></td>
<td>The SOAP action of the message.</td>
</tr>
<tr class="even">
<td><strong>To Address</strong></td>
<td>The target endpoint address.</td>
</tr>
<tr class="odd">
<td><strong>Sequence</strong></td>
<td><p>This parameter is used to specify whether cloned messages should be mediated via a <b>sequence</b> or not, and to specify the sequence if they are to be further mediated. Possible options are as follows.</p>
<ul>
<li><strong>None</strong>: If this is selected, no further mediation will be performed for the cloned messages.</li>
<li><strong>Anonymous</strong>: If this is selected, you can define an anonymous <b>sequence</b> for the cloned messages by adding the required mediators as children to <strong>Target</strong> in the mediator tree.</li>
<li><strong>Pick From Registry</strong>: If this is selected, you can refer to a pre-defined <b>sequence</b> that is currently saved as a resource in the registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required <b>sequence</b> from the resource tree.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Endpoint</strong></td>
<td><p>The <b>endpoint</b> to which the cloned messages should be sent. Possible options are as follows.</p>
<ul>
<li><strong>None</strong> : If this is selected, the cloned messages are not sent to an <b>endpoint</b>.</li>
<li><strong>Anonymous</strong> : If this is selected, you can define an anonymous endpoint within the iterate target configuration to which the cloned messages should be sent. Click the <strong>Add</strong> link which appears after selecting this option to add the anonymous endpoint. </li>
<li><strong>Pick from Registry</strong> : If this is selected, you can refer to a pre-defined endpoint that is currently saved as a resource in the registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required endpoint from the resource tree.</li>
</ul></td>
</tr>
</tbody>
</table>

## Example

In this example, the Clone Mediator clones messages and redirects them to a **Default** endpoint and an existing sequence.

``` java
<clone xmlns="http://ws.apache.org/ns/synapse">
   <target>
      <endpoint name="endpoint_urn_uuid_73A47733EB1E6F30812921609540392-849227072">
         <default />
      </endpoint>
   </target>
   <target sequence="test1" />
</clone>
```
