# Word Count Guardrail

The **Word Count Guardrail** is a custom Synapse mediator for **WSO2 API Manager Universal Gateway**, designed to perform **word count-based validation** on incoming or outgoing JSON payloads. This component acts as a *guardrail* to enforce specific content moderation rules based on configurable minimum and maximum word counts and JSON Path expressions.

## Features

- Validate payload content by counting words
- Define **minimum and maximum word count thresholds**
- Target specific fields in JSON payloads using **JSON Path**
- Optionally **invert validation logic** (e.g., allow only content *outside* the specified word range)
- Trigger fault sequences on rule violations
- Include optional **assessment messages** in error responses for better observability

## How to Use

??? "Click to expand Prerequisites"

    - Java 11 (JDK)
    - Maven 3.6.x or later
    - WSO2 API Manager or Synapse-compatible runtime

Follow these steps to integrate the Word Count Guardrail policy into your WSO2 API Manager instance:

1. Clone and build the project from [**Word Count Guardrail**](https://github.com/wso2-extensions/apim-policies/tree/main/mediation/ai/word-count-guardrail/universal-gw/word-count-guardrail)

    ```bash
    mvn clean install
    ```

    > ℹ️ This will generate a `.zip` file in the `target/` directory containing the mediator JAR, policy-definition.json and artifact.j2.

2. **Unzip the build artifact** 
   ```bash
   unzip target/org.wso2.apim.policies.mediation.ai.word-count-guardrail-<version>-distribution.zip -d word-count-guardrail
   ```

3. **Copy the mediator JAR into your API Manager’s runtime libraries**   
    ```bash
    cp word-count-guardrail/org.wso2.apim.policies.mediation.ai.word-count-guardrail-<version>.jar $APIM_HOME/repository/components/lib/
    ```

4. **Register the Policy in Publisher**  
    - Use the provided `policy-definition.json` and `artifact.j2` files to register the policy through the Publisher Portal or via the Publisher REST APIs.

5. **Apply and Deploy the Policy**
    - Open the **API Publisher Portal** `(https://<host>:<port>/publisher)`
    - Select your API
    - Go to **Develop > API Configurations > Policies > Request/Response Flow**
    - Click **Add Policy**, select the new **Word Count Guardrail** policy
    - Provide the required configuration (name, min, max, etc.)
    - **Save and Deploy** the API

### Example Policy Configuration

??? example "Click to expand configuration steps"

    1. Create an AI API using Mistral AI.
    2. Add the Word Count Guardrail policy to the API with the following configuration:

    | Field                           | Example                  |
    |---------------------------------|--------------------------|
    | `Guardrail Name`                | `Word Limiter`           |
    | `Minimum Word Count`            | `2`                      |
    | `Maximum Word Count`            | `5`                      |
    | `JSON Path`                     | `$.messages[-1].content` |
    | `Invert the Guardrail Decision` | `false`                  |
    | `Show Guardrail Assessment`     | `true`                   |

    3. Save and re-deploy the API.
    4. Invoke the API's `chat/completion` endpoint with a prompt that violates the word count, such as having only one word (if min is set to 2):

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
    "type": "WORD_COUNT_GUARDRAIL",
    "message": {
        "interveningGuardrail": "Word Limiter",
        "action": "GUARDRAIL_INTERVENED",
        "actionReason": "Violation of applied word count constraints detected.",
        "direction": "REQUEST"
    }
    }
    ```

## ⚠️ Limitations

The **Word Count Guardrail** uses the following regular expression to split words from the inspected content:

```regex
\s+
```

This pattern **splits words** based on **one or more whitespace characters**. This approach may not accurately handle cases with punctuation attached to words, special characters, or languages without clear whitespace delimiters.