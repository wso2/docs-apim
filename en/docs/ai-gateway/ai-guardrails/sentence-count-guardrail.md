# Sentence Count Guardrail

The **Sentence Count Guardrail** is a custom Synapse mediator for **WSO2 API Manager Universal Gateway**, designed to perform **sentence count-based validation** on incoming or outgoing JSON payloads. This component acts as a *guardrail* to enforce specific content moderation rules based on configurable minimum and maximum sentence counts and JSON Path expressions.

## Features

- Validate payload content by counting sentences
- Define **minimum and maximum sentence thresholds**
- Target specific fields in JSON payloads using **JSON Path**
- Optionally **invert validation logic** (e.g., allow only content *outside* the specified sentence range)
- Trigger fault sequences on rule violations
- Include optional **assessment messages** in error responses for better observability

## How to Use

Follow these steps to integrate the Sentence Count Guardrail policy into your WSO2 API Manager instance:

1. Download the latest [**Sentence Count Guardrail**](https://github.com/wso2-extensions/apim-policies/releases/download/v1.0.0-sentence-count-guardrail/org.wso2.am.policies.mediation.ai.sentence-count-guardrail-1.0.0-distribution.zip) policy

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
            <td><code>org.wso2.am.policies.mediation.ai.sentence-count-guardrail-&lt;version&gt;</code></td>
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

2. Copy the mediator JAR into your API Manager’s dropins directory:
    ```<APIM_HOME>/repository/components/dropins```

3. Register the policy in the Publisher portal using the provided `policy-definition.json` and `artifact.j2` files via the Publisher REST APIs.
    - To register the policy common to all AI APIs, follow [Add a new common operation policy]({{base_path}}/reference/product-apis/publisher-apis/publisher-v4/publisher-v4/#tag/Operation-Policies/operation/addCommonOperationPolicy)  
    - To register the policy specific to a given API, follow [Add an API specific operation policy]({{base_path}}/reference/product-apis/publisher-apis/publisher-v4/publisher-v4/#tag/API-Operation-Policies/operation/addAPISpecificOperationPolicy)

4. Apply and Deploy the Policy
    - Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
    - Select your API
    - Go to **Develop > API Configurations > Policies > Request/Response Flow**
    - Click **Add Policy**, select the new **Sentence Count Guardrail** policy
    - Provide the required configuration (name, min, max, etc.)
    - **Save and Deploy** the API

## Example Policy Configuration

??? example "Click to expand configuration steps"

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

    The following guardrail error response will be returned with http status code `446`:

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

## ⚠️ Limitations

The **Sentence Count Guardrail** uses the following regular expression to split sentences from the inspected content:

```regex
\{.*?\}
```

This pattern **splits sentences** based on punctuation marks such as **periods**, **exclamation points**, and **question marks**. This approach may not handle all sentence boundaries accurately, especially in cases involving abbreviations, decimals, or other complex sentence structures.
