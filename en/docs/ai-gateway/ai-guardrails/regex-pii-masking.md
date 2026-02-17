# Regex PII Masking Guardrail

The **Regex PII Masking Guardrail** is a custom Synapse mediator for the **WSO2 API Manager Universal Gateway** that safeguards Personally Identifiable Information (PII) in incoming AI API requests and GenAI responses using user‑defined regular expressions. It enables flexible, rule‑driven detection, anonymization, and optional redaction of sensitive data across request and response flows.

This guardrail helps organizations automate consistent PII handling to support privacy, compliance, and anonymization requirements without disrupting downstream processing.

## Features

- Detects and processes PII using configurable **regex patterns**.
- Supports two modes: **Masking** (reversible) and **Redaction** (irreversible).
- Keeps transformations configurable per entity using a list of PII pattern definitions.

## Modes of Operation

### 1. **Masking Mode**
PII detected in the request flow is anonymized (e.g., `Alex` → `Person_0001`). A reversible mapping is stored in the Synapse message context. In the response flow, anonymized placeholders are replaced with the original values, preserving fidelity for the client while shielding downstream systems.

!!! note
    The policy needs to be applied in the request flow for PII anonymization and in the response flow for restoration.

Use this when downstream components should not see raw PII but the client should receive unaltered final content.

### 2. **Redaction Mode**
PII detected in either request or response flows is permanently obfuscated or removed (e.g., `Alex` → `*****`). No restoration occurs. 

Use this for strict compliance scenarios where sensitive data must never leave or reappear in the processing pipeline.

## How to Use

Follow these steps to integrate the **Regex PII Masking Guardrail** into your AI API:

- Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the **Policy List**
- Drag and drop the **Regex PII Masking Guardrail** policy into your desired mediation flow
- Fill in the required parameters (name, PII Entities list)
- **Save and Deploy** the AI API

## Example Policy Configuration

??? example "Click to expand configuration steps"
    ### Masking Mode

    This setup anonymizes PII in the request flow and restores it in the response flow using a reversible mapping.

    1. Create an AI API using Mistral AI.
    2. Add the **Regex PII Masking Guardrail** to the request flow:

    | Field                      | Example                   |
    |----------------------------|---------------------------|
    | `Guardrail Name`           | `Mask Email PII`          |
    | `JSON Path`                | `$.messages[-1].content`  |
    | `Redact PII`               | `false`                   |

    PII Entities:
    ```json
    [
        {
            "piiEntity": "EMAIL",
            "piiRegex": "([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\\.[a-zA-Z0-9_-]+)"
        }
    ]
    ```

    3. Add another PII Masking with Regex policy in the response flow with the following configuration:


    | Field            | Example                        |
    |------------------|--------------------------------|
    | `Guardrail Name` | `Mask Email PII`               |
    | `JSON Path`      | `$.choices[0].message.content` |
    | `Redact PII`     | `false`                        |

    PII Entities:
    ```json
    [
        {
            "piiEntity": "EMAIL",
            "piiRegex": "([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\\.[a-zA-Z0-9_-]+)"
        }
    ]
    ```

    4. Save and re-deploy the API.
    5. Invoke the API's `chat/completion` endpoint with the following payload:

    ```json
    {
        "model": "mistral-small-latest",
        "messages": [
            {
                "role": "user",
                "content": "Summarize the following email:\n\nFrom: jane.doe@confidential-client.com\nTo: project-team@yourcompany.com\nSubject: Q3 Budget & Deliverables\n\nHi team,\n\nPlease ensure that all documents related to Q3 targets are reviewed by John Smith (john.smith@confidential-client.com) and forwarded to our legal team. Also loop in our finance contact, Emily Rose (emily.rose@confidential-client.com), for final budget approvals.\n\nRegards,\nJane"
            }
        ]
    }
    ```

    > ℹ️ Note: The policy attached in the request flow identifies and anonymizes PIIs in the request message and store the mapping in the synapse message context. The policy attached in the response flow retrieves the mapping from the synapse message context and restores the original PII entities in the response message.

    ### Mode: Redacting

    Redacting mode can be applied to both request and response flows to permanently remove PII from messages. This example demonstrates how the policy can be used to redact PII in the request flow.

    1. Create an AI API with Mistral AI.
    2. Add the `PII Masking with Regex` policy in the request flow with the following configuration:

    | Field            | Example                  |
    |------------------|--------------------------|
    | `Guardrail Name` | `Mask Email PII`         |
    | `JSON Path`      | `$.messages[-1].content` |
    | `Redact PII`     | `true`                   |

    `PII Entities`:
    ```json
    [
        {
            "piiEntity": "EMAIL",
            "piiRegex": "([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\\.[a-zA-Z0-9_-]+)"
        }
    ]
    ```

    3. Save and re-deploy the API.
    4. Invoke the API's `chat/completion` endpoint with the following payload:

    ```json
    {
        "model": "mistral-small-latest",
        "messages": [
            {
                "role": "user",
                "content": "Summarize the following email:\n\nFrom: jane.doe@confidential-client.com\nTo: project-team@yourcompany.com\nSubject: Q3 Budget & Deliverables\n\nHi team,\n\nPlease ensure that all documents related to Q3 targets are reviewed by John Smith (john.smith@confidential-client.com) and forwarded to our legal team. Also loop in our finance contact, Emily Rose (emily.rose@confidential-client.com), for final budget approvals.\n\nRegards,\nJane"
            }
        ]
    }
    ```
