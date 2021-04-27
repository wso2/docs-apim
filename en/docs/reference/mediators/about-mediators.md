# About Mediators

Mediators are individual processing units that perform a specific function on messages that pass through the Micro Integrator. The mediator takes the message received by the proxy service or REST API, carries out some predefined actions on it (such as transforming, enriching, filtering), and outputs the modified message. 

For example, the [Clone]({{base_path}}/reference/mediators/clone-mediator) mediator splits a message into several clones, the [Send]({{base_path}}/reference/mediators/send-Mediator) mediator sends the messages, and the [Aggregate]({{base_path}}/reference/mediators/aggregate-mediator) mediator collects and merges the responses before sending them back to the client. 

Mediators also include functionality to match incompatible protocols, data formats, and interaction patterns across different resources. [XQuery]({{base_path}}/reference/mediators/xquery-mediator) and [XSLT]({{base_path}}/reference/mediators/xslt-mediator) mediators allow rich transformations on the messages. Content-based routing using XPath filtering is supported in different flavors, allowing users to get the most convenient configuration experience. Built-in capability to handle transactions allow message mediation to be done transactionally inside the Micro Integrator.

Mediators are always defined within a [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties).

## Classification of Mediators

Mediators are classified as follows based on whether or not they access the message's content: 

<table>
  <col width="140">
  <tr>
    <th>Classification</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><b>Content-Aware</b> mediators</td>
    <td>
      These mediators always access the message content when mediating messages (e.g., <a href="..{{base_path}}/reference/mediators/enrich-Mediator">Enrich</a> mediator).
    </td>
  </tr>
  <tr>
    <td><b>Content-Unaware</b> mediators</td>
    <td>
      These mediators never access the message content when mediating messages (e.g., <a href="..{{base_path}}/reference/mediators/send-Mediator">Send</a> mediator).
    </td>
  </tr>
  <tr>
    <td><b>Conditionally Content-Aware</b> mediators</td>
    <td>
      These mediators could be either content-aware or content-unaware depending on their exact instance configuration. For example, a simple <a href="{{base_path}}/reference/mediators/log-Mediator"></a> mediator instance (i.e. configured as <log/>) is content-unaware. However a log mediator configured as <log level=”full”/> would be content-aware since it is expected to log the message payload.
    </td>
  </tr>
</table>

## List of Mediators

WSO2 Micro Integrator includes a comprehensive library of mediators that provide functionality for implementing widely used **Enterprise Integration Patterns** (EIPs). You can also easily write a custom mediator to provide additional functionality using various technologies such as Java, scripting, and Spring.

**Core Mediators**

[Call]({{base_path}}/reference/mediators/call-mediator) | [Send]({{base_path}}/reference/mediators/send-mediator) | [Loopback]({{base_path}}/reference/mediators/loopback-mediator) | [Sequence]({{base_path}}/reference/mediators/sequence-mediator) | [Respond]({{base_path}}/reference/mediators/respond-mediator) | [Drop]({{base_path}}/reference/mediators/drop-mediator) | [Call Template]({{base_path}}/reference/mediators/call-template-mediator) | [Enrich]({{base_path}}/reference/mediators/enrich-mediator) | [Property]({{base_path}}/reference/mediators/property-mediator) | [Property Group]({{base_path}}/reference/mediators/property-group-mediator) | [Log]({{base_path}}/reference/mediators/log-mediator) | 

**Filter Mediators**

[Filter]({{base_path}}/reference/mediators/filter-mediator) | [Validate]({{base_path}}/reference/mediators/validate-mediator) | [Switch]({{base_path}}/reference/mediators/switch-mediator) | 

**Transform Mediators**

[XSLT]({{base_path}}/reference/mediators/xslt-mediator) | [FastXSLT]({{base_path}}/reference/mediators/fastxslt-mediator) | [URLRewrite]({{base_path}}/reference/mediators/urlrewrite-mediator) | [XQuery]({{base_path}}/reference/mediators/xquery-mediator) | [Header]({{base_path}}/reference/mediators/header-mediator) | [Fault]({{base_path}}/reference/mediators/fault-mediator) | [PayloadFactory]({{base_path}}/reference/mediators/payloadfactory-mediator) | [JSONTransform](json-transform-mediator) |

**Advanced Mediators**

[Cache]({{base_path}}/reference/mediators/cache-mediator) | [ForEach]({{base_path}}/reference/mediators/foreach-mediator) | [Clone]({{base_path}}/reference/mediators/clone-mediator) | [Store]({{base_path}}/reference/mediators/store-mediator) | [Iterate]({{base_path}}/reference/mediators/iterate-mediator) | [Aggregate]({{base_path}}/reference/mediators/aggregate-mediator) | [Callout]({{base_path}}/reference/mediators/callout-mediator) | [Transaction]({{base_path}}/reference/mediators/transaction-mediator) | [Throttle]({{base_path}}/reference/mediators/throttle-mediator) | [DBReport]({{base_path}}/reference/mediators/db-report-mediator) | [DBLookup]({{base_path}}/reference/mediators/dblookup-mediator) | [EJB]({{base_path}}/reference/mediators/ejb-mediator) | [Binder]({{base_path}}/reference/mediators/builder-mediator) | [Entitlement]({{base_path}}/reference/mediators/call-mediator) | [OAuth]({{base_path}}/reference/mediators/call-mediator) | [Smooks]({{base_path}}/reference/mediators/smooks-mediator) | [Data Mapper]({{base_path}}/reference/mediators/data-mapper-mediator) | 

**Extension Mediators**

[Class]({{base_path}}/reference/mediators/class-mediator) | [Script]({{base_path}}/reference/mediators/script-mgiediator) |
