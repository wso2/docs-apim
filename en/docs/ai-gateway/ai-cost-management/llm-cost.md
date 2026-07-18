# LLM Cost

The **LLM Cost** is a custom Synapse mediator for the **WSO2 API Manager Classic Gateway** that calculates the monetary cost of LLM API requests and responses. It normalizes token usage from OpenAI, Anthropic, Gemini/Vertex AI, and Mistral responses, computes the cost using configurable pricing data, and exposes the cost value as context properties and transport headers for downstream policy enforcement (such as rate limiting or analytics).

## Features

- Provider-specific token usage normalization for **OpenAI**, **Anthropic**, **Gemini/Vertex AI**, and **Mistral**
- Supports both **streaming (SSE)** and **non-streaming** response payloads
- Context window tiering (128k, 200k, 272k+ token thresholds)
- Service tier rate selection (priority, flex, batch)
- Cached input token cost calculation
- Reasoning token pricing
- Audio/image modality cost support
- Web search grounding cost calculation
- Fuzzy model name matching with progressive suffix stripping
- SSE event merging for streaming response cost calculation

## How to Use

Follow these steps to integrate the **LLM Cost** policy into your AI API:

- Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the **Policy List**
- Drag and drop the **LLM Cost** policy into your desired mediation flow
- Fill in the required policy configuration
- **Save and Deploy** the AI API

### Policy Configuration

| Field               | Example                                                        |
|---------------------|----------------------------------------------------------------|
| `Pricing File Path` | `<PRODUCT_HOME>/configs/llm-pricing/model_prices.json` |

### Context Properties

The policy sets the following properties on the Synapse MessageContext and transport headers:

| Property / Header        | Description                                      | Example Value          |
|--------------------------|--------------------------------------------------|------------------------|
| `x-llm-cost`             | Total calculated cost in USD                     | `0.0000423100`         |
| `x-llm-cost-status`      | Calculation status (`calculated` or `not_calculated`) | `calculated`      |

### Supported Providers

| Provider  | Calculator Class      | Response Usage Fields Used                        |
|-----------|-----------------------|---------------------------------------------------|
| OpenAI    | `OpenAICalculator`    | `usage.prompt_tokens`, `usage.completion_tokens`, `usage.prompt_tokens_details.cached_tokens`, `usage.completion_tokens_details.reasoning_tokens`, `service_tier` |
| Anthropic | `AnthropicCalculator` | `usage.input_tokens`, `usage.output_tokens`, `usage.cache_creation_input_tokens`, `usage.cache_read_input_tokens` |
| Gemini    | `GeminiCalculator`    | `usageMetadata.promptTokenCount`, `usageMetadata.candidatesTokenCount`, `usageMetadata.cachedContentTokenCount`, `usageMetadata.thoughtsTokenCount`, `usageMetadata.promptTokensDetails`, `candidates[].groundingMetadata` |
| Mistral   | `MistralCalculator`   | `usage.prompt_tokens`, `usage.completion_tokens` |

## Example Policy Configuration

??? example "Click to expand configuration steps"
    Example: Calculate cost for a Gemini model.

    1. Create an AI API using Gemini (Vertex AI).
    2. Add the LLM Cost policy to the API with the following configuration:

    | Field               | Example                                                        |
    |---------------------|----------------------------------------------------------------|
    | `Pricing File Path` | `<PRODUCT_HOME>/configs/llm-pricing/model_prices.json` |

    3. Ensure the pricing file contains an entry for the model (e.g., `gemini-2.5-flash`).
    4. Save and re-deploy the API.
    5. Invoke the API's content generation endpoint:

    ```json
    {
      "contents": [
        {
          "parts": [
            {
              "text": "Hello, how are you?"
            }
          ]
        }
      ]
    }
    ```

    The policy calculates the cost and sets the following transport headers on the response:

    ```
    x-llm-cost: 0.0021668000000000004
    x-llm-cost-status: calculated
    ```

    The cost value is also available as a Synapse context property (`get-property('x-llm-cost')`) for use by downstream policies such as rate limiting or custom analytics.

## Notes

- The cost is calculated in **USD** using the rates defined in the pricing file.
- The policy does not modify the response body or block requests — it only calculates and exposes the cost.
- If the pricing file path is not configured, the policy logs an error and sets `x-llm-cost-status` to `not_calculated`.
- If the model name cannot be determined from the response, the policy falls back to extracting it from the request payload (`$.model`) or the request path (`/models/{name}`).
