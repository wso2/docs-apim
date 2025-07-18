# Prompt Template

The **Prompt Template** is a custom Synapse mediator for the **WSO2 API Manager Universal Gateway**, designed to translate incoming requests into structured, context-aware instructions for AI services. It dynamically applies configurable **prompt templates** to user inputs, helping align requests with the desired format, tone, and task-specific guidance without violating the underlying AI service’s OpenAPI specification.

Prompt templates are a foundational **prompt engineering technique** used to standardize and structure prompts before they are sent to a language model. By combining user inputs with reusable instruction patterns, prompt templates guide the model’s behavior more effectively, helping ensure that responses are relevant, coherent, and contextually appropriate. They are especially valuable for applications that require task clarity, tone consistency, or compliance with operational rules.


## Features

- Apply structured **prompt templates** to both **text** and **chat-based payloads**
- Preserve compatibility with downstream AI service OpenAPI schemas
- Centrally manage templates at the **AI API level**
- Automatically substitute placeholders with user-provided values
- Improve clarity, consistency, and task alignment in LLM interactions

## How to Use

??? "Click to expand Prerequisites"

    - Java 11 (JDK)
    - Maven 3.6.x or later
    - WSO2 API Manager or Synapse-compatible runtime

Follow these steps to integrate the Prompt Template Guardrail policy into your WSO2 API Manager instance:

1. Clone and build the project from [**Prompt Decorator**](https://github.com/wso2-extensions/apim-policies/tree/main/mediation/ai/prompt-decorator/universal-gw/prompt-decorator)

    ```bash
    mvn clean install
    ```

    > ℹ️ This will generate a `.zip` file in the `target/` directory containing the mediator JAR, policy-definition.json and artifact.j2.

2. **Unzip the Build Artifact**  
    After the build, unzip the artifact generated in the `target/` directory:

    ```bash
    unzip target/org.wso2.apim.policies.mediation.ai.prompt-template-<version>-distribution.zip -d prompt-template-guardrail
    ```

3. **Copy the Mediator JAR**  
    Place the mediator JAR into your API Manager’s runtime libraries:

    ```bash
    cp prompt-template-guardrail/org.wso2.apim.policies.mediation.ai.prompt-template-<version>.jar $APIM_HOME/repository/components/lib/
    ```

4. **Register the Policy in Publisher**  
    Use the provided `policy-definition.json` and `artifact.j2` files to define the policy in the Publisher Portal.

    - Place these files in the appropriate directory structure for your deployment process or register them manually via REST APIs or UIs.

5. **Apply and Deploy the Policy**
    - Open the **API Publisher**
    - Select your API
    - Navigate to **Runtime > Request/Response Flow**
    - Click **Add Policy** and select **Prompt Template Guardrail**
    - Provide the required configuration (template, placeholder mapping, etc.)
    - **Save and Deploy** the API


## Example Policy Configuration

This example demonstrates how the Prompt Template policy can be used to standardize AI behavior across two distinct use cases: customer support and internal data analysis. By applying structured templates with dynamic placeholders (e.g., `[[customer_message]]`, `[[report_content]]`), the assistant is guided to respond professionally, empathetically, and task-appropriately. This ensures consistent tone, clarity of instruction, and relevance of output whether the AI is handling customer queries or summarizing internal reports.

1. Create an AI API with Mistral AI.
2. Add the Prompt Template policy to the API with the following configuration:

    | Field           | Example               |
    |-----------------|-----------------------|
    | `Template Name` | `Template Directives` |

    `Prompt Template Configuration`:
    ```json
    [
      {
        "name": "data-analyst-template",
        "prompt": "You are a professional customer support agent for SwiftTech Electronics. A customer has submitted the following message:\n\n\"[[customer_message]]\"\n\nCraft a helpful and empathetic response addressing the issue. Use a polite and understanding tone. If the issue is the company's fault, apologize sincerely. Offer a resolution or next steps where possible. Sign off in a friendly and professional manner."
      },
      {
        "name": "data-analyst-template",
        "prompt": "You are a data analyst at SwiftTech Electronics. Analyze the following internal report:\n\n\"[[report_content]]\"\n\nSummarize the key points in 3–5 bullet points. Identify any actionable insights or recommendations. At the end, classify the overall sentiment of the report as Positive, Neutral, or Negative based on its content. Keep the tone professional and concise."
      }
    ]
    ```

    > ℹ️ Note: Template names must be unique and comply with valid URL hostname rules, allowing only letters, digits, hyphens (`-`), and periods (`.`). Underscores (`_`) and other invalid characters are not permitted to ensure correct URI parsing and compatibility.

3. Save and re-deploy the API.
4. Invoke the API's `chat/completion` endpoint with the following payloads:

    **To invoke the data analysis template:**
    ```json
    {
      "model": "mistral-small-latest",
      "messages": [
        {
          "role": "system",
          "content": "You are an agent working for SwiftTech Electronics. Your responses must align with the company’s organizational guidelines:\n\n- Provide clear, concise, and professional summaries.\n- Ensure insights and recommendations are actionable and data-driven.\n- Maintain confidentiality and avoid speculation.\n- Use a formal tone suitable for internal business communication.\n- Highlight key trends and risks without exaggeration."
        },
        {
          "role": "user",
          "content": "template://data-analyst-template?report_content=Sales%20in%20Q2%20grew%20by%208%25%2C%20driven%20by%20strong%20performance%20in%20the%20accessories%20category.%20However%2C%20customer%20satisfaction%20scores%20dropped%20slightly%20due%20to%20shipping%20delays%20in%20May.%20Regional%20performance%20shows%20growth%20in%20Europe%2C%20while%20APAC%20lagged%20behind%20expectations.%20Inventory%20turnover%20improved%20by%2015%25%20following%20system%20upgrades."
        }
      ]
    }
    ```

    **To invoke the customer support template:**
    ```json
    {
      "model": "mistral-small-latest",
      "messages": [
        {
          "role": "system",
          "content": "You are an agent working for SwiftTech Electronics. Your responses must align with the company’s organizational guidelines:\n\n- Provide clear, concise, and professional summaries.\n- Ensure insights and recommendations are actionable and data-driven.\n- Maintain confidentiality and avoid speculation.\n- Use a formal tone suitable for internal business communication.\n- Highlight key trends and risks without exaggeration."
        },
        {
          "role": "user",
          "content": "template://customer-support-template?customer_message=I%20received%20my%20order%20today%2C%20but%20the%20charger%20is%20missing%20from%20the%20box.%20I%20need%20it%20urgently."
        }
      ]
    }
    ```
