# JSON Schema Guardrail

The **JSON Schema Guardrail** is a custom Synapse mediator for the **WSO2 API Manager Universal Gateway** that validates incoming AI API requests and GenAI responses JSON payloads against a user‑defined **JSON Schema**. It enables creators to enforce structural and field-level compliance in both request and response flows using JSON Path targeting.

## Features

- Validates payload structure and field constraints using a given **JSON Schema**.
- Targets specific JSON segments via **JSON Path** expressions.
- Supports **inverted validation** (optionally fail when the schema matches instead of when it doesn't).
- Works in both **request** and **response** mediation flows.
- Emits **guardrail error responses** on validation failure and triggers the configured fault sequence.
- Provides an optional **Show Guardrail Assessment** feature to include **detailed validation results** in error responses for enhanced observability.

## How to Use

Follow these steps to integrate the **JSON Schema Guardrail** into your AI API:

- Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the **Policy List**
- Drag and drop the **JSON Schema Guardrail** policy into your desired mediation flow
- Fill in the required policy parameters (name, schema)
- **Save and Deploy** the AI API

## Example Policy Configuration

??? example "Click to expand configuration steps"
    This example shows how the JSON Schema Guardrail can enforce a structured form-like JSON response for an AI assistant.

    1. Create an AI API using Mistral AI.
    2. Add the **JSON Schema Guardrail** policy to the response flow (or request, based on use case) with the following configuration:

    | Field                       | Example                        |
    |-----------------------------|--------------------------------|
    | `Guardrail Name`            | `Form Validator`               |
    | `JSON Path`                 | `$.choices[0].message.content` |
    | `Invert the Decision`       | `false`                        |
    | `Show Guardrail Assessment` | `false`                        |

    JSON Schema:
    ```json
    {
        "$schema": "http://json-schema.org/draft-07/schema#",
        "type": "object",
        "properties": {
            "fullName": {
                "type": "string",
                "minLength": 1
            },
            "email": {
                "type": "string",
                "format": "email"
            },
            "phoneNumber": {
                "type": "string",
                "pattern": "^\\+?[0-9\\-\\s]{7,20}$"
            },
            "organization": {
                "type": "string",
                "minLength": 1
            },
            "preferredPlan": {
                "type": "string",
                "enum": ["Free", "Pro", "Enterprise"]
            },
            "referralCode": {
                "type": "string",
                "minLength": 1
            }
        },
        "required": ["fullName", "email"],
        "additionalProperties": false
    }
    ```

    3. Save and redeploy the API.
    4. Invoke the API's `chat/completion` endpoint with a prompt that attempts to elicit a response not conforming to the enforced schema (e.g., missing required fields or including disallowed properties).

    ```json
    {
        "model": "mistral-large-latest",
        "messages": [
            {
            "role": "user",
            "content": "Extract the following fields from the given text and return a JSON object matching this format:\n\n{\n  \"fullName\": \"string\",\n  \"email\": \"string\",\n  \"phoneNumber\": \"string\",\n  \"organization\": \"string\",\n  \"preferredPlan\": \"Free | Pro | Enterprise\",\n  \"referralCode\": \"string\"\n}\n\nOnly include the keys that are present in the input. The JSON should not contain any extra text or explanation.\n\nInput:\nPlease register a new client with the following details:\n\n- Full Name: John Doe\n- - Phone Number: +1-555-123-4567\n- Organization: Acme Corp\n- Preferred Plan: Enterprise\n- Referral Code: ACME2025"
            }
        ]
    }
    ```

    A guardrail error response similar to the following will be returned with HTTP status code `446` if the generated output violates the schema:
    ```json
    {
        "code": "900514",
        "type": "JSON_SCHEMA_GUARDRAIL",
        "message": {
            "interveningGuardrail": "Form Validator",
            "action": "GUARDRAIL_INTERVENED",
            "actionReason": "Violation of enforced JSON schema detected.",
            "direction": "RESPONSE"
        }
    }
    ```

## Limitations

The **JSON Schema Guardrail** currently extracts candidate JSON fragments from the inspected content using the following regular expression:

```regex
\{.*?\}
```

Notes:
- Only JSON object snippets are captured; **JSON arrays are not supported**.
- Nested or multi-line objects may produce multiple partial matches; the guardrail validates each extracted object until one passes (or all fail).
- If at least one JSON object match is found, mediation proceeds validation. If no JSON object match is found, the guardrail intervenes.
