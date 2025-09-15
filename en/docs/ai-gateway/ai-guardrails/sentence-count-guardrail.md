# Sentence Count Guardrail

The **Sentence Count Guardrail** is a custom Synapse mediator for the **WSO2 API Manager Universal Gateway** that validates incoming AI API requests and GenAI responses by enforcing **minimum and/or maximum sentence count constraints** on a selected JSON field. It helps control verbosity, reduce prompt injection surface via overly long inputs, and enforce style or compliance limits.

## Features

- Validate payload content by counting sentences.
- Enforces configurable **minimum** and **maximum** sentence thresholds.
- Target specific fields in JSON payloads using **JSON Path**
- Optionally **invert validation logic** (e.g., allow only content *outside* the specified sentence range)
- Provides an optional **Show Guardrail Assessment** feature to include **detailed validation results** in error responses for enhanced observability.

## How to Use

Follow these steps to integrate the **Sentence Count Guardrail** policy into your AI API:

- Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the **Policy List**
- Drag and drop the **Sentence Count Guardrail** policy into your desired mediation flow
- Fill in the required policy configuration (name, minimum and maximum sentence count)
- **Save and Deploy** the AI API

## Example Policy Configuration

??? example "Click to expand configuration steps"
    Example: Restrict user prompts to between 2 and 5 sentences.

    1. Create an AI API using Mistral AI.
    2. Add the Sentence Count Guardrail policy to the API with the following configuration:

    | Field                           | Example                  |
    |---------------------------------|--------------------------|
    | `Guardrail Name`                | `Sentence Limiter`       |
    | `Minimum Sentence Count`        | `2`                      |
    | `Maximum Sentence Count`        | `5`                      |
    | `JSON Path`                     | `$.messages[-1].content` |
    | `Invert the Guardrail Decision` | `false`                  |
    | `Show Guardrail Assessment`     | `false`                  |

    3. Save and re-deploy the API.
    4. Invoke the API's `chat/completion` endpoint with a prompt that violates the sentence count, such as having only one sentence (if min is set to 2):

    Test Request (violates minimum of 2 sentences):
    ```json
    {
        "messages": [
            {
                "role": "user",
                "content": "This is a short prompt."
            }
        ]
    }
    ```

    The following guardrail error response will be returned with HTTP status code `446`:

    ```json
    {
        "code": "900514",
        "type": "SENTENCE_COUNT_GUARDRAIL",
        "message": {
            "interveningGuardrail": "Sentence Limiter",
            "action": "GUARDRAIL_INTERVENED",
            "actionReason": "Violation of applied sentence count constraints detected.",
            "direction": "REQUEST"
        }
    }
    ```

## Limitations

The **Sentence Count Guardrail** uses the following regular expression to split sentences from the inspected content:

```regex
\{.*?\}
```

This pattern **splits sentences** based on punctuation marks such as **periods**, **exclamation points**, and **question marks**. This approach may not handle all sentence boundaries accurately, especially in cases involving abbreviations, decimals, or other complex sentence structures.
