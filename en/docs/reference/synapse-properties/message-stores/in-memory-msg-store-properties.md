# In Memory Message Store
## Introduction
This is a basic <b>message store</b> that stores messages in an in-memory queue. This means that all the stored messages will be lost when the server restarts. The in memory message store is a lot faster than a persistent message store. Therefore, it can be used to temporarily store messages for high-speed <b>store and forward</b> integrations where message persistence is not a requirement.</br></br>

<b>Note</b>: In memory message stores are not recommended for use in production as well as in scenarios where large scale message storing is required. You can use an external message store (e.g., <b>JMS message store</b>) for such scenarios.

## Properties

Listed below are the properties that can be configured when [creating an In-Memory Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Message Store Name</td>
    <td>A name to identify the In-Memory message store.</td>
  </tr>
  <tr>
    <td>Message Store Type</td>
    <td>
      Select <b>In-Memory Message Store</b> from the drop-down list.
    </td>
  </tr>
</table>