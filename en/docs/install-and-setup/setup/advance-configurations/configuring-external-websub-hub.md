# Configuring an External WebSub Hub

By default, WSO2 API Manager handles the WebSub protocol (topic registration, subscription, unsubscription, and content publishing) inside the Universal Gateway itself. This works well for most deployments, but there are situations where you may want to delegate the hub responsibility to a dedicated external WebSub hub — for example, to reuse an existing hub that already serves other systems, to scale hub traffic independently of API traffic, or to take advantage of hub-specific features such as guaranteed deliveries.

When an external hub is configured, WebSub APIs deployed from the Publisher continue to handle authentication, authorization, and throttling at the Gateway as usual, but the hub requests (`subscribe`, `unsubscribe`, and `publish`) are forwarded to the external hub instead of being processed internally.

!!! note
    This feature requires the following minimum update levels for WSO2 API Manager 4.6.0:

    - All-in-One (`wso2am`): 4.6.0.32
    - Control Plane (`wso2am-acp`): 4.6.0.33
    - Universal Gateway (`wso2am-universal-gw`): 4.6.0.32

    Run the [WSO2 Update Tool](https://updates.docs.wso2.com/en/latest/updates/update-tool/) to get the latest updates.

!!! note
    This configuration applies to WebSub APIs only. REST, GraphQL, WebSocket, and SSE APIs are not affected.

## Configuration

Add the following section to the `<API-M_HOME>/repository/conf/deployment.toml` file.

```toml
[apim.external_websub_hub]
url = "https://external-hub.example.com/hub"
type = "external"
disable_topic_context_prefix = false
```

### Configuration reference

<table>
<colgroup>
<col width="25%" />
<col width="60%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th><b>Property</b></th>
<th><b>Description</b></th>
<th><b>Required</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>url</code></p></td>
<td><p>The base HTTP(S) URL of your external WebSub hub. Setting this value activates external-hub delegation for newly deployed WebSub APIs. If the URL is empty or the section is omitted, the gateway uses its built-in hub.</p></td>
<td><p>Yes</p></td>
</tr>
<tr class="even">
<td><p><code>type</code></p></td>
<td><p>An identifier for the hub implementation (for example, <code>external</code>). Informational; used by custom extensions if you need to branch on hub type.</p></td>
<td><p>No</p></td>
</tr>
<tr class="odd">
<td><p><code>disable_topic_context_prefix</code></p></td>
<td><p>Controls how topic names are sent to the external hub.
<br/><br/>
<code>false</code> (default) — topics are prefixed with the API context to avoid collisions between different APIs that expose the same topic name.
<br/><br/>
<code>true</code> — topics are sent to the hub verbatim. Use this when the external hub already provides namespacing, or when multiple APIs must intentionally share the same topic.</p></td>
<td><p>No</p></td>
</tr>
</tbody>
</table>

### Topic naming

When the topic-context prefix is enabled (the default), the gateway rewrites each topic before sending it to the external hub, so that topics with the same name from different WebSub APIs do not collide on a shared hub. The rewritten topic uses the API context as a prefix, with `/` characters replaced by `_`.

For example, the publish request to the `commits` topic of the `/repo-watcher/1.0.0` WebSub API is forwarded to the `repo-watcher_1.0.0_commits` topic of the external WebSub Hub. Publish and subscribe requests are rewritten the same way, so publishers and subscribers stay consistent.

!!! warning
    Because `_` is used as the separator, avoid embedding `_` in API contexts, API versions, and topic names when the prefix is enabled. Otherwise the resulting topic strings can become ambiguous.

## Distributed deployment

!!! note
    In a fully distributed setup, add this configuration to the **Control Plane (Publisher)** node only. The hub URL is baked into the API's Gateway artifact when the API is deployed from the Publisher; Gateway nodes pick it up automatically. No configuration is required on the Gateway, Traffic Manager, or Key Manager nodes.

!!! important
    The configuration is read only when a WebSub API is deployed. Any WebSub API that was already deployed before you enable, disable, or change the external hub URL will continue to use its previous setup. To pick up the change, redeploy the affected APIs by creating and deploying a new revision from the Publisher.

## Verifying the configuration

1. Add the `[apim.external_websub_hub]` block to `deployment.toml` on the Control Plane and restart the node.
2. [Create a WebSub API]({{base_path}}/api-design-manage/design/create-api/create-streaming-api/create-a-websub-streaming-api/) with one or more topics from the Publisher and deploy a new revision to a Gateway environment.
3. Send a subscription request against the API's callback endpoint (`POST /<context>/<version>?hub.mode=subscribe&hub.topic=<topic>&hub.callback=<callback-url>`) and confirm that:
    - Your external hub receives the subscription request.
    - The subscriber receives the WebSub verification callback from the external hub.
4. Publish an event through the API (`POST /<context>/<version>/<topic>?hub.mode=publish`) and confirm that the external hub receives it and fans it out to the subscribed callback.

## Reverting to the built-in hub

Remove (or comment out) the `[apim.external_websub_hub]` block from `deployment.toml`, restart the Control Plane, and redeploy the affected WebSub APIs. New revisions will use the Gateway's built-in WebSub hub.

## See also

- [Create a WebSub/WebHook API]({{base_path}}/api-design-manage/design/create-api/create-streaming-api/create-a-websub-streaming-api/)
- [Test a WebSub/WebHook API]({{base_path}}/api-design-manage/design/create-api/create-streaming-api/test-a-websub-api/)
- [Extend WebSub Topic Matching]({{base_path}}/reference/customize-product/extending-api-manager/extending-gateway/extending-websub-topic-matching/)
