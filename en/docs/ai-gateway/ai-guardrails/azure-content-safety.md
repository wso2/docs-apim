# Azure Content Safety Guardrail

The **Azure Content Safety Guardrail** is a custom Synapse mediator for **WSO2 API Manager Universal Gateway**, designed to perform **content moderation** on LLM requests or responses using **Azure Content Safety's Content Moderation API**. 

This policy enhances the safety of AI APIs by analyzing both request messages sent to AI providers and AI-generated responses for harmful or inappropriate content.

---
## Features

- Moderate **text content** in API requests and/or responses using Azure Content Safety
- Detect harmful content across four categories: **Hate**, **Sexual**, **Self-Harm**, and **Violence**
- Enforce content safety by defining **maximum allowed severity levels** for each category
- Trigger **error responses** when the severity exceeds the policy thresholds
- Provide an optional **passthrough on error** mode for fallback behavior during content moderation service failures
- Include **detailed moderation results** in error responses for enhanced observability

---
## How to Use

!!! important
    This policy is available from the following WSO2 API Manager product update levels onward:

    - `wso2am`: Update level **greater than 13**
    - `wso2am-universal-gw`: Update level **greater than 13**
    - `wso2am-acp`: Update level **greater than 14**
    - `wso2am-tm`: Update level **greater than 13**

Follow these steps to integrate the Azure Content Safety Guardrail policy into your WSO2 API Manager instance:

1. Download the latest [**Azure Content Safety Guardrail**](https://github.com/wso2-extensions/apim-policies/releases/download/v1.0.0-azure-content-safety-guardrail/org.wso2.am.policies.mediation.ai.azure-content-safety-guardrail-1.0.0-distribution.zip):

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
            <td><code>org.wso2.am.policies.mediation.ai.azure-content-safety-guardrail-&lt;version&gt;</code></td>
            <td>The compiled mediator JAR file</td>
            </tr>
            <tr>
            <td><code>content-moderation/policy-definition.json</code></td>
            <td>Policy metadata definition</td>
            </tr>
            <tr>
            <td><code>content-moderation/artifact.j2</code></td>
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
    - Click **Add Policy**, select the new **Azure Content Safety Content Moderation** policy
    - Provide the required configuration (name, pii entities, etc.)
    - **Save and Deploy** the API

## Example Policy Configuration

??? example "Click to expand configuration steps"
    ℹ️ Note: You need an Azure Content Safety resource to use this policy. Follow the [prerequisites](https://learn.microsoft.com/en-us/azure/ai-services/content-safety/quickstart-text?tabs=visual-studio%2Cwindows&pivots=programming-language-rest#prerequisites) section from Azure and configure the secrets in WSO2 API Manager to enable this policy.  
    
    Add the following to the `$APIM_HOME/repository/conf/deployment.toml` file:


    ```toml
    [[apim.ai.guardrail_provider]]
    type = "azure-contentsafety"
    [apim.ai.guardrail_provider.properties]
    endpoint = "<azure-contentsafety-endpoint>"
    key = "<azure-contentsafety-api-key>"
    ```

    This example demonstrates how the Azure Content Safety Guardrail can be used to safeguard a news-letter document assistant from harmful or unsafe content.

    1. Create an AI API with Mistral AI.
    2. Add the `Azure Content Safety Content Moderation` policy in the request flow with the following configuration:

    | Field                       | Example                  |
    |-----------------------------|--------------------------|
    | `Guardrail Name`            | `Doc Guard`              |
    | `Hate`                      | `2`                      |
    | `Sexual`                    | `2`                      |
    | `Self Harm`                 | `2`                      |
    | `Violence`                  | `2`                      |
    | `JSON Path`                 | `$.messages[-1].content` |
    | `Passthrough on Error`      | `false`                  |
    | `Show Guardrail Assessment` | `false`                  |

    3. Save and re-deploy the API.
    4. Invoke the API's `chat/completion` endpoint with the following payload:

    ```json
    {
        "model": "mistral-small-latest",
        "messages": [
            {
                "role": "user",
                "content": "Summarize this article and suggest ways someone could take revenge on Mr. Anonymous Senator violently."
            }
        ]
    }
    ```

    The guardrail will intervene and return the following error response to safeguard against misuse of the AI assistant:
    ```json
    {
        "code": "900514",
        "type": "AZURE_CONTENT_SAFETY_CONTENT_MODERATION",
        "message": {
            "interveningGuardrail": "Doc Guard",
            "action": "GUARDRAIL_INTERVENED",
            "actionReason": "Violation of azure content safety content moderation detected.",
            "direction": "REQUEST"
        }
    }
    ```
