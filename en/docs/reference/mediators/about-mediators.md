# About Mediators

Mediators are individual processing units that perform a specific function on messages that pass through the Micro Integrator. The mediator takes the message received by the proxy service or REST API, carries out some predefined actions on it (such as transforming, enriching, filtering), and outputs the modified message. 

For example, the [Clone]({{base_path}}/reference/mediators/clone-Mediator) mediator splits a message into several clones, the [Send]({{base_path}}/reference/mediators/send-Mediator) mediator sends the messages, and the [Aggregate]({{base_path}}/reference/mediators/aggregate-Mediator) mediator collects and merges the responses before sending them back to the client. 

Mediators also include functionality to match incompatible protocols, data formats, and interaction patterns across different resources. [XQuery]({{base_path}}/reference/mediators/xQuery-Mediator) and [XSLT]({{base_path}}/reference/mediators/xSLT-Mediator) mediators allow rich transformations on the messages. The [Rule]({{base_path}}/reference/mediators/rule-Mediator) mediator allows users to cope with the uncertainty of business logic through rule-based message mediation. Content-based routing using XPath filtering is supported in different flavors, allowing users to get the most convenient configuration experience. Built-in capability to handle transactions allow message mediation to be done transactionally inside the Micro Integrator.

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
      These mediators could be either content-aware or content-unaware depending on their exact instance configuration. For example, a simple <a href="..{{base_path}}/reference/mediators/log-Mediator"></a> mediator instance (i.e. configured as <log/>) is content-unaware. However a log mediator configured as <log level=”full”/> would be content-aware since it is expected to log the message payload.
    </td>
  </tr>
</table>

## List of Mediators

WSO2 Micro Integrator includes a comprehensive library of mediators that provide functionality for implementing widely used **Enterprise Integration Patterns** (EIPs). You can also easily write a custom mediator to provide additional functionality using various technologies such as Java, scripting, and Spring.

**Core Mediators**

[Call]({{base_path}}/reference/mediators/call-Mediator) | [Send]({{base_path}}/reference/mediators/send-Mediator) | [Loopback]({{base_path}}/reference/mediators/loopback-Mediator) | [Sequence]({{base_path}}/reference/mediators/sequence-Mediator) | [Respond]({{base_path}}/reference/mediators/respond-Mediator) | [Drop]({{base_path}}/reference/mediators/drop-Mediator) | [Call Template]({{base_path}}/reference/mediators/call-Template-Mediator) | [Enrich]({{base_path}}/reference/mediators/enrich-Mediator) | [Property]({{base_path}}/reference/mediators/property-Mediator) | [Property Group]({{base_path}}/reference/mediators/property-Group-Mediator) | [Log]({{base_path}}/reference/mediators/log-Mediator) | 

**Filter Mediators**

[Filter]({{base_path}}/reference/mediators/filter-Mediator) | [Validate]({{base_path}}/reference/mediators/validate-Mediator) | [Switch]({{base_path}}/reference/mediators/switch-Mediator) | 

**Transform Mediators**

[XSLT]({{base_path}}/reference/mediators/xSLT-Mediator) | [FastXSLT]({{base_path}}/reference/mediators/fastXSLT-Mediator) | [URLRewrite]({{base_path}}/reference/mediators/uRLRewrite-Mediator) | [XQuery]({{base_path}}/reference/mediators/xQuery-Mediator) | [Header]({{base_path}}/reference/mediators/header-Mediator) | [Fault]({{base_path}}/reference/mediators/fault-Mediator) | [PayloadFactory]({{base_path}}/reference/mediators/payloadFactory-Mediator) | [JSONTransform](json-Transform-Mediator) |

**Advanced Mediators**

[Cache]({{base_path}}/reference/mediators/cache-Mediator) | [ForEach]({{base_path}}/reference/mediators/forEach-Mediator) | [Clone]({{base_path}}/reference/mediators/clone-Mediator) | [Store]({{base_path}}/reference/mediators/store-Mediator) | [Iterate]({{base_path}}/reference/mediators/iterate-Mediator) | [Aggregate]({{base_path}}/reference/mediators/aggregate-Mediator) | [Callout]({{base_path}}/reference/mediators/callout-Mediator) | [Transaction]({{base_path}}/reference/mediators/transaction-Mediator) | [Throttle]({{base_path}}/reference/mediators/throttle-Mediator) | [DBReport]({{base_path}}/reference/mediators/dB-Report-Mediator) | [DBLookup]({{base_path}}/reference/mediators/dBLookup-Mediator) | [EJB]({{base_path}}/reference/mediators/eJB-Mediator) | [Rule]({{base_path}}/reference/mediators/rule-Mediator) | [Binder]({{base_path}}/reference/mediators/builder-Mediator) | [Entitlement]({{base_path}}/reference/mediators/call-Mediator) | [OAuth]({{base_path}}/reference/mediators/call-Mediator) | [Smooks]({{base_path}}/reference/mediators/smooks-Mediator) | [Data Mapper]({{base_path}}/reference/mediators/data-Mapper-Mediator) | 

**Extension Mediators**

[Class]({{base_path}}/reference/mediators/class-Mediator) | [Script]({{base_path}}/reference/mediators/script-Mediator) |
