# URL Guardrail

The **URL Guardrail** is a custom Synapse mediator for **WSO2 API Manager Universal Gateway**, designed to perform **URL validity checks** on incoming or outgoing JSON payloads. This component acts as a *guardrail* to enforce content safety by validating embedded URLs for accessibility or DNS resolution.


## Features

- Validate payload content by extracting and checking URLs
- Perform either **DNS resolution** or **HTTP HEAD** validation
- Target specific fields in JSON payloads using **JSON Path**
- Configure custom **timeout** for validation checks
- Trigger fault sequences on rule violations
- Include optional **assessment messages** in error responses for better observability

## How to Use

Follow these steps to integrate the URL Guardrail policy into your WSO2 API Manager instance:

1. Download the latest [**URL Guardrail**](https://github.com/wso2-extensions/apim-policies/releases/download/v1.0.0-url-guardrail/org.wso2.am.policies.mediation.ai.url-guardrail-1.0.0-distribution.zip) policy

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
            <td><code>org.wso2.am.policies.mediation.ai.url-guardrail-&lt;version&gt;</code></td>
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
    - Navigate to **Runtime > Request/Response Flow**
    - Click **Add Policy** and choose **URL Guardrail**
    - Configure the policy parameters (name, JSONPath, timeout, etc.)
    - **Save and Deploy** the API

## Example Policy Configuration
??? example "Click to expand configuration steps"

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

    ```json
    {
        "model": "mistral-small-latest",
        "messages": [
            {
            "role": "user",
            "content": "Please summerize content from http://test.fake"
            }
        ]
    }
    ```

    The following guardrail error response will be returned with http status code `446`:

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

## ⚠️ Limitations
The **URL Guardrail** uses the following regular expression to extract URLs from the inspected content:

```regex
https?://[^\\s,"'{}\[\]\\`*]+
```

This pattern is designed to match common URL formats in textual content. However, it may **overmatch** or extract **unintended portions** as URLs in certain edge cases.

> 🔒 If such unintended content is matched as a URL and fails the validation (DNS/HTTP), the guardrail will **intervene** and block the mediation flow.