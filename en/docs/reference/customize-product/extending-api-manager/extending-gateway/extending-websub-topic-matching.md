# Extending WebSub Topic Matching

When a subscriber sends a request to a WebSub API, the Universal Gateway decides whether the topic the subscriber asked for matches one of the topics defined on the API. Out of the box, this decision is based on two rules:

1. An **exact string match** against the topics defined on the API.
2. A **URI-template match** (so dynamic patterns such as `orders/{id}/updates` are supported).

If neither rule accepts the subscriber's topic, the request is rejected as invalid.

These rules cover most use cases, but sometimes the topic scheme used by an external system cannot be expressed as an exact string or a URI template. Common examples include topics with versioning suffixes (`orders.v2`), hierarchical wildcards not supported by URI templates, or topics that need to be looked up against an external registry. For these cases, WSO2 API Manager exposes an extension point that lets you plug in your own topic-matching logic for WebSub APIs.

!!! note
    This feature requires the following minimum update levels for WSO2 API Manager 4.6.0:

    - All-in-One (`wso2am`): 4.6.0.32
    - Universal Gateway (`wso2am-universal-gw`): 4.6.0.32

    Run the [WSO2 Update Tool](https://updates.docs.wso2.com/en/latest/updates/update-tool/) to get the latest updates.

## How it works

Before the built-in matcher runs, the Gateway invokes your custom matcher and passes it two pieces of information:

- **The topic that the subscriber requested**, taken from the `hub.topic` value in the request.
- **The list of topics defined on the API**.

Your matcher returns either the topic it considers a match (in which case the Gateway accepts the request) or nothing (in which case the Gateway falls back to the built-in rules). Because the built-in rules still run as a fallback, your matcher only needs to handle the extra cases you want to support — you do not need to reimplement exact and URI-template matching.

## Implementing a custom matcher

### Step 1 - Add the dependency

Create a Java project and add the following Maven dependency. Set `${carbon.apimgt.version}` to the version that ships with your WSO2 API Manager release (you can find it in `<API-M_HOME>/repository/components/plugins/` by looking at the version suffix of `org.wso2.carbon.apimgt.common.gateway_<version>.jar`).

```xml
<dependency>
    <groupId>org.wso2.carbon.apimgt</groupId>
    <artifactId>org.wso2.carbon.apimgt.common.gateway</artifactId>
    <version>${carbon.apimgt.version}</version>
    <scope>provided</scope>
</dependency>
```

### Step 2 - Implement the ExtensionListener interface

Implement `org.wso2.carbon.apimgt.common.gateway.extensionlistener.ExtensionListener` and put your topic-matching logic in `preProcessRequest`. The other methods can return a "continue" response unchanged.

```java
package com.example.apim.websub;

import org.wso2.carbon.apimgt.common.gateway.dto.ExtensionResponseDTO;
import org.wso2.carbon.apimgt.common.gateway.dto.ExtensionResponseStatus;
import org.wso2.carbon.apimgt.common.gateway.dto.ExtensionType;
import org.wso2.carbon.apimgt.common.gateway.dto.RequestContextDTO;
import org.wso2.carbon.apimgt.common.gateway.dto.ResponseContextDTO;
import org.wso2.carbon.apimgt.common.gateway.extensionlistener.ExtensionListener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomWebSubTopicMatcher implements ExtensionListener {

    private static final String WEBSUB_REQUESTED_TOPIC = "WEBSUB_REQUESTED_TOPIC";
    private static final String WEBSUB_URL_PATTERNS = "WEBSUB_URL_PATTERNS";
    private static final String WEBSUB_MATCHED_TOPIC = "WEBSUB_MATCHED_TOPIC";

    @Override
    public ExtensionResponseDTO preProcessRequest(RequestContextDTO requestContextDTO) {
        Map<String, Object> customProps = requestContextDTO.getCustomProperty();
        if (customProps == null) {
            customProps = new HashMap<>();
        }

        String requestedTopic = (String) customProps.get(WEBSUB_REQUESTED_TOPIC);
        @SuppressWarnings("unchecked")
        List<String> apiTopics = (List<String>) customProps.get(WEBSUB_URL_PATTERNS);

        String matchedTopic = match(requestedTopic, apiTopics);
        if (matchedTopic != null) {
            customProps.put(WEBSUB_MATCHED_TOPIC, matchedTopic);
        }

        ExtensionResponseDTO response = new ExtensionResponseDTO();
        response.setCustomProperty(customProps);
        response.setResponseStatus(ExtensionResponseStatus.CONTINUE.toString());
        return response;
    }

    private String match(String requestedTopic, List<String> apiTopics) {
        if (requestedTopic == null || apiTopics == null) {
            return null;
        }
        // Example: match case-insensitively, ignoring any '.v<n>' version suffix.
        // Replace this block with your own matching logic.
        String normalized = requestedTopic.replaceAll("\\.v\\d+$", "").toLowerCase();
        for (String topic : apiTopics) {
            if (topic.equalsIgnoreCase(normalized)) {
                return topic;
            }
        }
        return null;
    }

    @Override
    public ExtensionResponseDTO postProcessRequest(RequestContextDTO requestContextDTO) {
        return continueResponse();
    }

    @Override
    public ExtensionResponseDTO preProcessResponse(ResponseContextDTO responseContextDTO) {
        return continueResponse();
    }

    @Override
    public ExtensionResponseDTO postProcessResponse(ResponseContextDTO responseContextDTO) {
        return continueResponse();
    }

    @Override
    public String getType() {
        return ExtensionType.WEBSUB_TOPIC_RESOLVER.toString();
    }

    private static ExtensionResponseDTO continueResponse() {
        ExtensionResponseDTO response = new ExtensionResponseDTO();
        response.setResponseStatus(ExtensionResponseStatus.CONTINUE.toString());
        return response;
    }
}
```

The values your matcher exchanges with the Gateway are passed through the request's custom-property map.

<table>
<colgroup>
<col width="30%" />
<col width="15%" />
<col width="55%" />
</colgroup>
<thead>
<tr class="header">
<th><b>Key</b></th>
<th><b>Type</b></th>
<th><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>WEBSUB_REQUESTED_TOPIC</code></p></td>
<td><p><code>String</code></p></td>
<td><p>The topic value the subscriber requested. Provided by the Gateway.</p></td>
</tr>
<tr class="even">
<td><p><code>WEBSUB_URL_PATTERNS</code></p></td>
<td><p><code>List&lt;String&gt;</code></p></td>
<td><p>The list of topics defined on the API. Provided by the Gateway.</p></td>
</tr>
<tr class="odd">
<td><p><code>WEBSUB_MATCHED_TOPIC</code></p></td>
<td><p><code>String</code></p></td>
<td><p>Set this to the topic you consider a match. Leave it unset (or <code>null</code>) to let the built-in matcher take over.</p></td>
</tr>
</tbody>
</table>

!!! note
    Your implementation must expose a public no-argument constructor. The class is instantiated by API Manager at startup.

### Step 3 - Deploy the extension

1. Build the project as a plain JAR (not an OSGi bundle):
    ```bash
    mvn clean package
    ```
2. Copy the JAR into `<API-M_HOME>/repository/components/lib/` on every Gateway node.
3. Register the class in `<API-M_HOME>/repository/conf/deployment.toml` on every Gateway node:
    ```toml
    [[apim.extension.listener]]
    type = "WEBSUB_TOPIC_RESOLVER"
    class = "com.example.apim.websub.CustomWebSubTopicMatcher"
    enable_extension_fault_sequence_mediation = false
    ```
4. Restart the Gateway nodes.

## Distributed deployment

!!! note
    In a fully distributed setup, add the JAR and the `[[apim.extension.listener]]` configuration to every **Gateway** node. Custom topic matching runs at request-processing time on the Gateway; the Control Plane, Traffic Manager, and Key Manager nodes are not involved.

!!! warning
    Only one custom matcher can be registered at a time. If more than one `[[apim.extension.listener]]` block uses `type = "WEBSUB_TOPIC_RESOLVER"`, the last one wins.

## Verifying the extension

1. Deploy a WebSub API that has at least one topic defined (see [Create a WebSub/WebHook API]({{base_path}}/api-design-manage/design/create-api/create-streaming-api/create-a-websub-streaming-api/)).
2. Enable `DEBUG` logging for your extension package by adding the following to `<API-M_HOME>/repository/conf/log4j2.properties` on the Gateway:
    ```
    logger.custom-websub.name = com.example.apim.websub
    logger.custom-websub.level = DEBUG
    ```
    Append `custom-websub` to the `loggers` list.
3. Send a subscription request whose `hub.topic` value only your custom matcher (not the built-in matcher) would accept, and confirm that the Gateway accepts it.
4. Send a subscription request whose `hub.topic` value neither matcher would accept, and confirm that the Gateway rejects it.

## See also

- [Configuring an External WebSub Hub]({{base_path}}/install-and-setup/setup/advance-configurations/configuring-external-websub-hub/)
- [Write Custom Handlers]({{base_path}}/reference/customize-product/extending-api-manager/extending-gateway/writing-custom-handlers/)
- [Create a WebSub/WebHook API]({{base_path}}/api-design-manage/design/create-api/create-streaming-api/create-a-websub-streaming-api/)
