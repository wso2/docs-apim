# LLM Cost

The **LLM Cost** is a custom Synapse mediator for the **WSO2 API Manager Classic Gateway** that calculates the monetary cost of LLM API calls. It normalizes token usage from OpenAI, Anthropic, Gemini/Vertex AI, and Mistral responses, computes the cost using configurable pricing data, and exposes the cost value as context properties for downstream policy enforcement (such as rate limiting or analytics).

## Features

- Provider-specific token usage normalization for **OpenAI**, **Anthropic**, **Gemini/Vertex AI**, and **Mistral**
- Context window tiering (128k, 200k, 272k+ token thresholds)
- Service tier rate selection (priority, flex, batch)
- Cached input token cost calculation, including Anthropic 5-minute and 1-hour cache write TTLs
- Reasoning token pricing
- Audio/image modality cost support, and duration-based audio billing
- Web search and grounding cost calculation
- Anthropic geo-routing and `speed` multipliers
- Fuzzy model name matching with progressive suffix stripping
- Pricing data loaded from a **remote URL**, a **local file**, or a **bundled default**, with automatic hourly refresh for remote sources

## How to Use

Follow these steps to integrate the **LLM Cost** policy into your AI API:

- Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the **Policy List**
- Drag and drop the **LLM Cost** policy into **both** the request and response mediation flows
- Fill in the required policy configuration
- **Save and Deploy** the AI API

!!! warning "Attach the policy to both flows"
    The **LLM Cost** policy must be added to **both** the request and response mediation flows.

    The request flow buffers the request payload and URL path. The response flow needs them to read pricing inputs that the provider does not echo back in its response — the Anthropic `speed` flag, `web_search_options.search_context_size`, and the Gemini model name embedded in the request path.

    If the policy is attached only to the response flow it will still run, but those inputs are unavailable and the calculated cost may be **understated**. A warning is logged once per mediator instance when this is detected.

### Policy Configuration

| Field                              | Type    | Required | Default | Description                                                                                                                                                     |
|------------------------------------|---------|----------|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Pricing Remote URL`               | String  | No       | –       | HTTP/HTTPS URL to fetch the model pricing JSON from. Refreshed hourly in the background.                                                                          |
| `Pricing File Path`                | String  | No       | –       | Path to a local model pricing JSON file, read once at deployment. An `http(s)` value here is treated as a **Pricing Remote URL**.                                 |
| `Expose Cost in Response Headers`  | Boolean | No       | `false` | When enabled, the calculated cost is also returned to the API consumer as the `x-llm-cost` and `x-llm-cost-status` response headers.                              |

If neither **Pricing Remote URL** nor **Pricing File Path** is configured — or if both fail to load — the mediator falls back to the `model_prices.json` bundled inside the policy JAR, so it always has a usable pricing database.

### Pricing Load and Refresh Behavior

- **Initial load** happens once at deployment, in this order: **Pricing Remote URL** → **Pricing File Path** → bundled resource. The first source that yields a non-empty pricing map is used.
- **Refresh** applies only when a **Pricing Remote URL** is configured. It runs every hour on a background thread — never on a request thread — so a slow or unreachable pricing endpoint cannot delay API traffic.
- **A failed refresh keeps the previously loaded prices.** It does not fall back to the bundled resource, which would silently replace up-to-date remote prices with stale ones.
- Policies configured with the same source **share a single parsed pricing map and one refresh timer** across APIs, rather than each holding its own copy.

### Context Properties

The policy sets the following properties on the Synapse MessageContext:

| Property             | Description                                           | Example Value  |
|----------------------|-------------------------------------------------------|----------------|
| `x-llm-cost`         | Total calculated cost in USD, to 10 decimal places    | `0.0000423100` |
| `x-llm-cost-status`  | Calculation status (`calculated` or `not_calculated`) | `calculated`   |

These values are also returned as response headers of the same names when **Expose Cost in Response Headers** is enabled. It is disabled by default, since the cost of serving a request is operator information. Downstream policies should read the context properties.

!!! note "Always check the status property"
    `x-llm-cost-status` distinguishes a genuine zero cost from a failed calculation — both report `x-llm-cost` as `0.0000000000`. Downstream policies should check `x-llm-cost-status` before trusting the value.

    A cost of `0` with status `not_calculated` is produced when the response body is empty or is not a JSON object, the pricing database is unavailable, no model name can be determined, the model has no pricing entry, its provider is unsupported, or the response is streamed.

### Supported Providers

| Provider  | Calculator Class      | Response Usage Fields Used                        |
|-----------|-----------------------|---------------------------------------------------|
| OpenAI    | `OpenAICalculator`    | `usage.prompt_tokens`, `usage.completion_tokens`, `usage.prompt_tokens_details.cached_tokens`, `usage.completion_tokens_details.reasoning_tokens`, `service_tier` |
| Anthropic | `AnthropicCalculator` | `usage.input_tokens`, `usage.output_tokens`, `usage.cache_creation_input_tokens`, `usage.cache_read_input_tokens`, `usage.inference_geo`, `usage.server_tool_use` |
| Gemini    | `GeminiCalculator`    | `usageMetadata.promptTokenCount`, `usageMetadata.candidatesTokenCount`, `usageMetadata.cachedContentTokenCount`, `usageMetadata.thoughtsTokenCount`, `usageMetadata.promptTokensDetails`, `usageMetadata.trafficType`, `candidates[].groundingMetadata` |
| Mistral   | `MistralCalculator`   | `usage.prompt_tokens`, `usage.completion_tokens`, `usage.prompt_audio_seconds` |

## Limitations

!!! warning "Streaming responses are not supported"
    Responses with the content type `text/event-stream` are detected and reported as `not_calculated`. They are **not** silently mispriced.

    The Synapse mediator contract delivers a single fully built message rather than a stream of chunks, so token usage spread across server-sent events cannot be accumulated.

    To obtain cost data for an API, disable response streaming on it.

## Example Policy Configuration

??? example "Click to expand configuration steps"
    Example: Calculate cost for a Gemini model.

    1. Create an AI API using Gemini (Vertex AI).
    2. Add the **LLM Cost** policy to **both** the request and response mediation flows of the API, with the following configuration:

    | Field                             | Example                                                |
    |-----------------------------------|--------------------------------------------------------|
    | `Pricing Remote URL`              | *(leave empty to use the bundled pricing data)*        |
    | `Pricing File Path`               | `<PRODUCT_HOME>/configs/llm-pricing/model_prices.json` |
    | `Expose Cost in Response Headers` | `true`                                                 |

    3. Ensure the pricing file contains an entry for the model (e.g., `gemini-2.5-flash`). If you leave both pricing fields empty, the bundled pricing data is used instead.
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

    The policy calculates the cost and sets the following Synapse context properties:

    ```
    x-llm-cost: 0.0021668000
    x-llm-cost-status: calculated
    ```

    Because **Expose Cost in Response Headers** was enabled in this example, the same values are also returned as response headers. The cost value is available to downstream policies such as rate limiting or custom analytics through the context property, using `get-property('x-llm-cost')`.

## Notes

- The cost is calculated in **USD** using the rates defined in the active pricing data.
- The policy does not modify the response body or block requests — it only calculates and exposes the cost.
- If the model name cannot be determined from the response, the policy falls back to extracting it from the request payload (`$.model`) or the request path (`/models/{name}`). This fallback requires the policy to be attached to the request flow.
