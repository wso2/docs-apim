# Azure Content Safety Content Moderation Guardrail

The **Azure Content Safety Content Moderation Guardrail** is a custom Synapse mediator for the **WSO2 API Manager Universal Gateway**, to perform content moderation on both incoming AI API requests and GenAI responses using the **Azure Content Safety Service**.

This policy improves AI API safety by inspecting incoming prompts and AI-generated responses for harmful or disallowed material, and enforcing predefined severity thresholds per content category.

## Features

- Moderates **text content** in AI API requests and/or responses using the Azure Content Safety Service.
- Evaluates four harm categories: **Hate**, **Sexual**, **Self-Harm**, and **Violence**.
- Enforces customizable **maximum severity levels** per category.
- Returns **guardrail error responses** when content exceeds configured thresholds.
- Offers an optional **Passthrough on Error** mode to skip moderation when the Azure service is unreachable.
- Provides an optional **Show Guardrail Assessment** feature to include **detailed validation results** in error responses for enhanced observability.

## How to Use

!!! important
    ℹ️ You need an Azure Content Safety resource. Follow the official [prerequisites](https://learn.microsoft.com/azure/ai-services/content-safety/quickstart-text?tabs=visual-studio%2Cwindows&pivots=programming-language-rest#prerequisites) and configure the credentials in WSO2 API Manager as shown below.

    Add the following to the `$APIM_HOME/repository/conf/deployment.toml` file to register Azure Content Safety as a guardrail provider:

    ```toml
    [[apim.ai.guardrail_provider]]
    type = "azure-contentsafety"
    [apim.ai.guardrail_provider.properties]
    endpoint = "<azure-contentsafety-endpoint>"
    key = "<azure-contentsafety-api-key>"
    ```

Follow these steps to integrate the **Azure Content Safety Content Moderation Guardrail** policy into your AI API:

- Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the **Policy List**
- Drag and drop the **Azure Content Safety Content Moderation Guardrail** policy into your desired mediation flow
- Fill in the required policy configuration (name, category severity limits)
- **Save and Deploy** the AI API

## Example Policy Configuration

??? example "Click to expand configuration steps"
    This example shows how the Azure Content Safety Content Moderation Guardrail can protect a newsletter assistant from abusive or violent prompt content.

    1. Create an AI API with Mistral AI.
    2. Add the **Azure Content Safety Content Moderation Guardrail** policy in the request flow with the configuration below:

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

    3. Save and redeploy the API.
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

    Since the prompt contains violent intent, the guardrail blocks the request and returns an error similar to:
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
