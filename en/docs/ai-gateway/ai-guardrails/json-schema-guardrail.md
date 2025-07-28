# JSON Schema Guardrail

The **JSON Schema Guardrail** is a custom Synapse mediator for **WSO2 API Manager Universal Gateway**, designed to validate JSON payloads against a user-defined **JSON Schema**. This mediator enables API publishers to enforce structural and content compliance dynamically in both request and response flows.

## Features

- Validate payload structure and fields using **JSON Schema**
- Target specific segments of a payload using **JSON Path**
- Support for **inverted validation** (fail when schema matches)
- **Guardrail assessment** for better observability on violations
- Works on both **request and response** flows
- Integrates with WSO2 **fault sequences** on failure

## How to Use

!!! important
    This policy is available from the following WSO2 API Manager product update levels onward:

    - `wso2am`: Update level **greater than 12**
    - `wso2am-universal-gw`: Update level **greater than 12**
    - `wso2am-acp`: Update level **greater than 13**
    - `wso2am-tm`: Update level **greater than 12**

Follow these steps to integrate the JSON Schema Guardrail policy into your WSO2 API Manager instance:

1. Download the latest [**JSON Schema Guardrail**](https://github.com/wso2-extensions/apim-policies/releases/download/v1.0.0-json-schema-guardrail/org.wso2.am.policies.mediation.ai.json-schema-guardrail-1.0.0-distribution.zip) policy

    !!! tip
        The downloaded archive contains the following
        <table>
        <thead>
            <tr>
            <th>File Name</th>
            <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
            <td><code>org.wso2.am.policies.mediation.ai.json-schema-guardrail-&lt;version&gt;</code></td>
            <td>The compiled mediator JAR file</td>
            </tr>
            <tr>
            <td><code>policy-definition.json</code></td>
            <td>Policy metadata definition</td>
            </tr>
            <tr>
            <td><code>artifact.j2</code></td>
            <td>Synapse template file</td>
            </tr>
        </tbody>
        </table>

2. Copy the mediator JAR file into the API Manager's dropins directory
    ```<APIM_HOME>/repository/components/dropins```

3. Register the policy in the Publisher portal using the provided `policy-definition.json` and `artifact.j2` files via the Publisher REST APIs.
    - To register the policy common to all AI APIs, follow [Add a new common operation policy]({{base_path}}/reference/product-apis/publisher-apis/publisher-v4/publisher-v4/#tag/Operation-Policies/operation/addCommonOperationPolicy)  
    - To register the policy specific to a given API, follow [Add an API specific operation policy]({{base_path}}/reference/product-apis/publisher-apis/publisher-v4/publisher-v4/#tag/API-Operation-Policies/operation/addAPISpecificOperationPolicy)

4. Apply and Deploy the Policy
    - Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
    - Select your API
    - Navigate to **Develop > API Configurations > Policies > Request/Response Flow**
    - Click **Add Policy** and choose **JSON Schema Guardrail**
    - Drag and drop the policy into the response flow
    - Configure the policy parameters (name, JSONPath, schema, etc.)
    - **Save and Deploy** the API

## Example Policy Configuration
??? example "Click to expand configuration steps"

    1. Create an AI API using Mistral AI.
    2. Add the JSON Schema Guardrail policy to the API with the following configuration:

    | Field                       | Example                        |
    |-----------------------------|--------------------------------|
    | `Guardrail Name`            | `Form Validator`               |
    | `JSON Path`                 | `$.choices[0].message.content` |
    | `Invert the Decision`       | `false`                        |
    | `Show Guardrail Assessment` | `false`                        |

    `JSON Schema`
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


    3. Save and re-deploy the API.
    4. Invoke the API's `chat/completion` endpoint with a prompt that will generate a response that violates the enforced schema.

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

    The following guardrail error response will be returned with http status code `446`:

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

## ⚠️ Limitations

The **JSON Schema Guardrail** uses the following regular expression to extract json portions from the inspected content:

```regex
\{.*?\}
```

This pattern is designed to extract **JSON objects only**; **JSON arrays are not supported**.

> 🔒 If at least one JSON object match is found, mediation will proceed.
If no JSON object match is found, the guardrail will intervene and block the mediation flow.
