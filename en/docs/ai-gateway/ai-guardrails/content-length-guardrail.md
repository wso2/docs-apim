# Content Length Guardrail

The **Content Length Guardrail** is a custom Synapse mediator for **WSO2 API Manager Universal Gateway**, designed to perform **content-byte-length validation** on incoming or outgoing JSON payloads. This component acts as a *guardrail* to enforce specific content moderation rules based on configurable minimum and maximum byte sizes and JSON Path expressions.

## Features

- Validate payload content by checking byte length
- Define **minimum and maximum byte thresholds**
- Target specific fields in JSON payloads using **JSON Path**
- Optionally **invert validation logic** (e.g., allow only content *outside* the specified byte range)
- Trigger fault sequences on rule violations
- Include optional **assessment messages** in error responses for better observability

## How to Use

??? "Click to expand Prerequisites"

    - Java 11 (JDK)
    - Maven 3.6.x or later
    - WSO2 API Manager or Synapse-compatible runtime

Follow these steps to integrate the Content Length Guardrail policy into your WSO2 API Manager instance:

1. Clone and build the project from [**Content Length Guardrail**](https://github.com/wso2-extensions/apim-policies/tree/main/mediation/ai/content-length-guardrail/universal-gw/content-length-guardrail)

    ```bash
    mvn clean install
    ```

    > ℹ️ This will generate a `.zip` file in the `target/` directory containing the mediator JAR, policy-definition.json and artifact.j2.

2. **Unzip the build artifact** 
   ```bash
   unzip target/org.wso2.apim.policies.mediation.ai.content-length-guardrail-<version>-distribution.zip -d content-length-guardrail
   ```

3. **Copy the mediator JAR into your API Manager’s runtime libraries**  
   Place the mediator JAR into your API Manager’s runtime libraries using the following command.

   ```bash
   cp content-length-guardrail/org.wso2.apim.policies.mediation.ai.content-length-guardrail-<version>.jar $APIM_HOME/repository/components/lib/
   ```

4. **Register the Policy in Publisher**  
    - Use the provided `policy-definition.json` and `artifact.j2` files to register the policy through the Publisher Portal or via the Publisher REST APIs.

5. **Apply and Deploy the Policy**
   - Open the **API Publisher Portal (https://<host>:<port>/publisher)**
   - Select your API
   - Go to **Runtime > Request/Response Flow**
   - Click **Add Policy**, select the new **Content Length Guardrail** policy
   - Provide the required configuration (name, min, max, etc.)
   - **Save and Deploy** the API

## Example Policy Configuration
??? example "Click to expand configuration steps"

    1. Create an AI API using Mistral AI.
    2. Add the Content Length Guardrail policy to the API with the following configuration:

    | Field                           | Example                  |
    |---------------------------------|--------------------------|
    | `Guardrail Name`                | `Content Limiter`        |
    | `Minimum Content Length`        | `20`                     |
    | `Maximum Content Length`        | `1500`                   |
    | `JSON Path`                     | `$.messages[-1].content` |
    | `Invert the Guardrail Decision` | `false`                  |
    | `Show Guardrail Assessment`     | `false`                  |

    3. Save and re-deploy the API.
    4. Invoke the API's `chat/completion` endpoint with a prompt that violates the byte count, such as a short string under the minimum threshold:

    ```json
    {
    "messages": [
        {
            "role": "user",
            "content": "Hi!"
        }
    ]
    }
    ```

    The following guardrail error response will be returned with http status code `446`:

    ```json
    {
    "code": "900514",
    "type": "CONTENT_LENGTH_GUARDRAIL",
    "message": {
        "interveningGuardrail": "Content Limiter",
        "action": "GUARDRAIL_INTERVENED",
        "actionReason": "Violation of applied content length constraints detected.",
        "direction": "REQUEST"
    }
    }
    ```
