# Content Length Guardrail

The **Content Length Guardrail** is a custom Synapse mediator for the **WSO2 API Manager Universal Gateway**, designed to enforce content byte-length constraints on incoming AI API requests and GenAI responses JSON payloads. This guardrail helps ensure that API requests and responses conform to configurable minimum and maximum byte size limits, targeting specific fields using JSON Path expressions.

## Features

- Validates payload content by checking its byte length.
- Supports configurable **minimum and maximum byte thresholds**.
- Targets specific fields in JSON payloads using **JSON Path**.
- Optionally **inverts validation logic** (e.g., only allow content outside the specified byte range).
- Triggers guardrail error responses when content violates the defined rules.
- Provides an optional **Show Guardrail Assessment** feature to include **detailed validation results** in error responses for enhanced observability.

## How to Use

Follow these steps to integrate the **Content Length Guardrail** policy into your AI API:

- Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the **Policy List**
- Drag and drop the **Content Length Guardrail** policy into your desired mediation flow
- Fill in the required policy configuration (name, minimum and maximum length)
- **Save and Deploy** the AI API

## Example Policy Configuration

??? example "Click to expand configuration steps"
    This example demonstrates how the Content Length Guardrail can be used to enforce prompt length requirements for an AI assistant.

    1. Create an AI API using Mistral AI.
    2. Add the **Content Length Guardrail** policy to the AI API's request mediation flow with the following configuration:

    | Field                           | Example                  |
    |---------------------------------|--------------------------|
    | `Guardrail Name`                | `Content Limiter`        |
    | `Minimum Content Length`        | `20`                     |
    | `Maximum Content Length`        | `1500`                   |
    | `JSON Path`                     | `$.messages[-1].content` |
    | `Invert the Guardrail Decision` | `false`                  |
    | `Show Guardrail Assessment`     | `false`                  |

    3. Save and redeploy the API.
    4. Invoke the API's `chat/completion` endpoint with a prompt that violates the byte count, such as a short string under the minimum threshold:

    ```json
    {
        "model": "mistral-small-latest",
        "messages": [
            {
                "role": "user",
                "content": "Hi!"
            }
        ]
    }
    ```

    The following guardrail error response will be returned with HTTP status code `446`:

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
