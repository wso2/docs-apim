# URL Guardrail

The **URL Guardrail** is a custom Synapse mediator for the **WSO2 API Manager Universal Gateway** that validates URLs referenced in incoming AI API requests and GenAI responses. It extracts candidate URLs from a targeted JSON field and checks their basic reachability or resolvability to help prevent workflows from relying on malformed, inaccessible, or potentially malicious links.

## Features

- Extracts and validates URLs from a selected JSON field using **JSON Path**.
- Supports two validation strategies:
    - **HTTP HEAD** (default): attempts a HEAD request to confirm remote availability.
    - **DNS Resolution**: verifies that the hostname resolves (useful in restricted networks or when external calls should be minimized).
- Configurable **connection timeout** (milliseconds) to bound external checks.
- Works in **request** or **response** mediation flows.
- Emits a guardrail error response when one or more URLs fail validation.
- Provides an optional **Show Guardrail Assessment** feature to include **detailed validation results** in error responses for enhanced observability.

## Modes of Operation

### 1. HTTP Validation Mode
Performs an HTTP HEAD (or lightweight) call to each extracted URL. A failure (timeout, non-resolvable host, network error, disallowed scheme) triggers intervention.

### 2. DNS Lookup Mode
Enabled when **Perform DNS Lookup** is set to true. Only DNS resolution is performed (no HTTP call). Use this when outbound HTTP access is limited or you only need to assert host existence.

## How to Use

Follow these steps to integrate the **URL Guardrail** policy into your AI API:

- Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the **Policy List**
- Drag and drop the **URL Guardrail** policy into your desired mediation flow
- Fill in the required policy configuration
- **Save and Deploy** the AI API

## Example Policy Configuration

??? example "Click to expand configuration steps"
    Example: Validate that any URLs in the latest user message are reachable via HTTP within 3 seconds.

    1. Create an AI API using Mistral AI.
    2. Add the URL Guardrail policy to the API with the following configuration:

    | Field                       | Example                  |
    |-----------------------------|--------------------------|
    | `Guardrail Name`            | `URL Safety Guard`       |
    | `JSON Path`                 | `$.messages[-1].content` |
    | `Connection Timeout`        | `3000`                   |
    | `Perform DNS Lookup`        | `false`                  |
    | `Show Guardrail Assessment` | `false`                  |

    3. Save and re-deploy the API.
    4. Invoke the API's `chat/completion` endpoint with a prompt that violates the URL validity rule.

    Test Request (contains an invalid URL):
    ```json
    {
        "model": "mistral-small-latest",
        "messages": [
            {
                "role": "user",
                "content": "Please summarize content from http://test.fake"
            }
        ]
    }
    ```

    The following guardrail error response will be returned with HTTP status code `446`:

    ```json
    {
        "code": "900514",
        "type": "URL_GUARDRAIL",
        "message": {
            "interveningGuardrail": "URL Safety Guard",
            "action": "GUARDRAIL_INTERVENED",
            "actionReason": "Violation of url validity detected.",
            "direction": "REQUEST"
        }
    }
    ```

## Limitations
The **URL Guardrail** uses the following regular expression to extract URLs from the inspected content:

```regex
https?://[^\\s,"'{}\[\]\\`*]+
```

This pattern is designed to match common URL formats in textual content. However, it may **overmatch** or extract **unintended portions** as URLs in certain edge cases.

If such unintended content is matched as a URL and fails the validation (DNS/HTTP), the guardrail will **intervene** and block the mediation flow.