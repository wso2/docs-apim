# Word Count Guardrail

The **Word Count Guardrail** is a custom Synapse mediator for the **WSO2 API Manager Universal Gateway** that enforces **minimum and/or maximum word count limits** on a selected JSON field in AI API requests or GenAI responses. It helps control verbosity, prompt injection surface, and output consistency.

## Features

- Validate payload content by counting words.
- Enforces configurable **minimum** and **maximum** sentence thresholds.
- Target specific fields in JSON payloads using **JSON Path**
- Optionally **invert validation logic** (e.g., allow only content *outside* the specified sentence range)
- Provides an optional **Show Guardrail Assessment** feature to include **detailed validation results** in error responses for enhanced observability.

## How to Use

Follow these steps to integrate the **Word Count Guardrail** policy into your AI API:

- Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the **Policy List**
- Drag and drop the **Word Count Guardrail** policy into your desired mediation flow
- Fill in the required policy configuration (name, minimum and maximum word count)
- **Save and Deploy** the AI API

### Example Policy Configuration

??? example "Click to expand configuration steps"
    Example: Enforce prompts to contain between 2 and 5 words.

    1. Create an AI API using Mistral AI.
    2. Add the Word Count Guardrail policy to the API with the following configuration:

    | Field                           | Example                  |
    |---------------------------------|--------------------------|
    | `Guardrail Name`                | `Word Limiter`           |
    | `Minimum Word Count`            | `2`                      |
    | `Maximum Word Count`            | `5`                      |
    | `JSON Path`                     | `$.messages[-1].content` |
    | `Invert the Guardrail Decision` | `false`                  |
    | `Show Guardrail Assessment`     | `true`                   |

    3. Save and re-deploy the API.
    4. Invoke the API's `chat/completion` endpoint with a prompt that violates the word count, such as having only one word (if min is set to 2):

    Test Request:
    ```json
    {
        "model": "mistral-small-latest",
        "messages": [
            {
                "role": "user",
                "content": "This is a short prompt."
            }
        ]
    }
    ```

    The following guardrail error response will be returned with http status code `446`:

    ```json
    {
        "code": "900514",
        "type": "WORD_COUNT_GUARDRAIL",
        "message": {
            "interveningGuardrail": "Word Limiter",
            "action": "GUARDRAIL_INTERVENED",
            "actionReason": "Violation of applied word count constraints detected.",
            "direction": "REQUEST"
        }
    }
    ```

## Limitations

The **Word Count Guardrail** uses the following regular expression to split words from the inspected content:

```regex
\s+
```

This pattern **splits words** based on **one or more whitespace characters**. This approach may not accurately handle cases with punctuation attached to words, special characters, or languages without clear whitespace delimiters.
