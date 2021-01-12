# About Mediators

Mediators are individual processing units that perform a specific function on messages that pass through the Micro Integrator. The mediator takes the message received by the proxy service or REST API, carries out some predefined actions on it (such as transforming, enriching, filtering), and outputs the modified message. 

For example, the [Clone](../../references/mediators/clone-Mediator.md) mediator splits a message into several clones, the [Send](../../references/mediators/send-Mediator.md) mediator sends the messages, and the [Aggregate](../../references/mediators/aggregate-Mediator.md) mediator collects and merges the responses before sending them back to the client. 

Mediators also include functionality to match incompatible protocols, data formats, and interaction patterns across different resources. [XQuery](../../references/mediators/xQuery-Mediator.md) and [XSLT](../../references/mediators/xSLT-Mediator.md) mediators allow rich transformations on the messages. The [Rule](../../references/mediators/rule-Mediator.md) mediator allows users to cope with the uncertainty of business logic through rule-based message mediation. Content-based routing using XPath filtering is supported in different flavors, allowing users to get the most convenient configuration experience. Built-in capability to handle transactions allow message mediation to be done transactionally inside the Micro Integrator.

Mediators are always defined within a [mediation sequence](../../references/synapse-properties/sequence-properties.md).

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
      These mediators always access the message content when mediating messages (e.g., <a href="../../../../references/mediators/enrich-Mediator">Enrich</a> mediator).
    </td>
  </tr>
  <tr>
    <td><b>Content-Unaware</b> mediators</td>
    <td>
      These mediators never access the message content when mediating messages (e.g., <a href="../../../../references/mediators/send-Mediator">Send</a> mediator).
    </td>
  </tr>
  <tr>
    <td><b>Conditionally Content-Aware</b> mediators</td>
    <td>
      These mediators could be either content-aware or content-unaware depending on their exact instance configuration. For example, a simple <a href="../../../../references/mediators/log-Mediator"></a> mediator instance (i.e. configured as <log/>) is content-unaware. However a log mediator configured as <log level=”full”/> would be content-aware since it is expected to log the message payload.
    </td>
  </tr>
</table>

## List of Mediators

WSO2 Micro Integrator includes a comprehensive library of mediators that provide functionality for implementing widely used **Enterprise Integration Patterns** (EIPs). You can also easily write a custom mediator to provide additional functionality using various technologies such as Java, scripting, and Spring.

**Core Mediators**

[Call](../../references/mediators/call-Mediator.md) | [Send](../../references/mediators/send-Mediator.md) | [Loopback](../../references/mediators/loopback-Mediator.md) | [Sequence](../../references/mediators/sequence-Mediator.md) | [Respond](../../references/mediators/respond-Mediator.md) | [Drop](../../references/mediators/drop-Mediator.md) | [Call Template](../../references/mediators/call-Template-Mediator.md) | [Enrich](../../references/mediators/enrich-Mediator.md) | [Property](../../references/mediators/property-Mediator.md) | [Property Group](../../references/mediators/property-Group-Mediator.md) | [Log](../../references/mediators/log-Mediator.md) | 

**Filter Mediators**

[Filter](../../references/mediators/filter-Mediator.md) | [Validate](../../references/mediators/validate-Mediator.md) | [Switch](../../references/mediators/switch-Mediator.md) | 

**Transform Mediators**

[XSLT](../../references/mediators/xSLT-Mediator.md) | [FastXSLT](../../references/mediators/fastXSLT-Mediator.md) | [URLRewrite](../../references/mediators/uRLRewrite-Mediator.md) | [XQuery](../../references/mediators/xQuery-Mediator.md) | [Header](../../references/mediators/header-Mediator.md) | [Fault](../../references/mediators/fault-Mediator.md) | [PayloadFactory](../../references/mediators/payloadFactory-Mediator.md) | [JSONTransform](json-Transform-Mediator.md) |

**Advanced Mediators**

[Cache](../../references/mediators/cache-Mediator.md) | [ForEach](../../references/mediators/forEach-Mediator.md) | [Clone](../../references/mediators/clone-Mediator.md) | [Store](../../references/mediators/store-Mediator.md) | [Iterate](../../references/mediators/iterate-Mediator.md) | [Aggregate](../../references/mediators/aggregate-Mediator.md) | [Callout](../../references/mediators/callout-Mediator.md) | [Transaction](../../references/mediators/transaction-Mediator.md) | [Throttle](../../references/mediators/throttle-Mediator.md) | [DBReport](../../references/mediators/dB-Report-Mediator.md) | [DBLookup](../../references/mediators/dBLookup-Mediator.md) | [EJB](../../references/mediators/eJB-Mediator.md) | [Rule](../../references/mediators/rule-Mediator.md) | [Binder](../../references/mediators/builder-Mediator.md) | [Entitlement](../../references/mediators/call-Mediator.md) | [OAuth](../../references/mediators/call-Mediator.md) | [Smooks](../../references/mediators/smooks-Mediator.md) | [Data Mapper](../../references/mediators/data-Mapper-Mediator.md) | 

**Extension Mediators**

[Class](../../references/mediators/class-Mediator.md) | [Script](../../references/mediators/script-Mediator.md) |
