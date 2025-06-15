# Content Usage Control Guardrails

## Overview

Content Usage Control Guardrails perform checks on both incoming prompts and LLM-generated responses to ensure all content adheres to organizational usage restrictions.

## 1. Word Count Guardrail

The **Word Count Guardrail** is a custom Synapse mediator for **WSO2 API Manager Universal Gateway**, designed to perform **word count-based validation** on incoming or outgoing JSON payloads. This component acts as a *guardrail* to enforce specific content moderation rules based on configurable minimum and maximum word counts and JSONPath expressions.

### ✨ Features

- ✅ Validate payload content by counting words
- ✅ Define **minimum and maximum word count thresholds**
- ✅ Target specific fields in JSON payloads using **JSONPath**
- ✅ Optionally **invert validation logic** (e.g., allow only content *outside* the specified word range)
- ✅ Trigger fault sequences on rule violations
- ✅ Include optional **assessment messages** in error responses for better observability

### 🚀 How to Use

Follow these steps to integrate the Word Count Guardrail policy into your WSO2 API Manager instance:

1. Download the latest **Word Count Guardrail Distribution** from @TODO

2. **Unzip the downloaded artifact:**  
   ```bash
   unzip target/org.wso2.apim.policies.mediation.ai.word-count-guardrail-<version>-distribution.zip -d word-count-guardrail
   ```

3. **Copy the mediator JAR into your API Manager’s runtime libraries:**   
   ```bash
   cp word-count-guardrail/org.wso2.apim.policies.mediation.ai.word-count-guardrail-<version>.jar $APIM_HOME/repository/components/lib/
   ```

4. **Register the Policy in Publisher**  
   - Use the provided `policy-definition.json` and `artifact.j2` files to register the policy through the Publisher Portal or via the Publisher REST APIs.

5. **Apply and Deploy the Policy**
   - Open the **API Publisher**
   - Select your API
   - Go to **Runtime > Request/Response Flow**
   - Click **Add Policy**, select the new **Word Count Guardrail** policy
   - Provide the required configuration (name, min, max, etc.)
   - **Save and Deploy** the API

### 🧾 Example Policy Configuration

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

### ⚠️ Limitations

The **Word Count Guardrail** uses the following regular expression to split words from the inspected content:

```regex
\s+
```

This pattern **splits words** based on **one or more whitespace characters**. This approach may not accurately handle cases with punctuation attached to words, special characters, or languages without clear whitespace delimiters.

## 2. Sentence Count Guardrail

The **Sentence Count Guardrail** is a custom Synapse mediator for **WSO2 API Manager Universal Gateway**, designed to perform **sentence count-based validation** on incoming or outgoing JSON payloads. This component acts as a *guardrail* to enforce specific content moderation rules based on configurable minimum and maximum sentence counts and JSONPath expressions.

### ✨ Features

- ✅ Validate payload content by counting sentences
- ✅ Define **minimum and maximum sentence thresholds**
- ✅ Target specific fields in JSON payloads using **JSONPath**
- ✅ Optionally **invert validation logic** (e.g., allow only content *outside* the specified sentence range)
- ✅ Trigger fault sequences on rule violations
- ✅ Include optional **assessment messages** in error responses for better observability

### 🚀 How to Use

Follow these steps to integrate the Sentence Count Guardrail policy into your WSO2 API Manager instance:

1. Download the latest **Sentence Count Guardrail Distribution** from @TODO

2. **Unzip the downloaded artifact:**  
   ```bash
   unzip org.wso2.apim.policies.mediation.ai.sentence-count-guardrail-<version>-distribution.zip -d sentence-count-guardrail
   ```

3. **Copy the Mediator JAR**  
   Place the mediator JAR into your API Manager’s runtime libraries:

   ```bash
   cp sentence-count-guardrail/org.wso2.apim.policies.mediation.ai.sentence-count-guardrail-<version>.jar $APIM_HOME/repository/components/lib/
   ```

4. **Register the Policy in Publisher**  
   - Use the provided `policy-definition.json` and `artifact.j2` files to register the policy through the Publisher Portal or via the Publisher REST APIs.

5. **Apply and Deploy the Policy**
    - Open the **API Publisher**
    - Select your API
    - Go to **Runtime > Request/Response Flow**
    - Click **Add Policy**, select the new **Sentence Count Guardrail** policy
    - Provide the required configuration (name, min, max, etc.)
    - **Save and Deploy** the API

### 🧾 Example Policy Configuration

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

### ⚠️ Limitations

The **Sentence Count Guardrail** uses the following regular expression to split sentences from the inspected content:

```regex
\{.*?\}
```

This pattern **splits sentences** based on punctuation marks such as **periods**, **exclamation points**, and **question marks**. This approach may not handle all sentence boundaries accurately, especially in cases involving abbreviations, decimals, or other complex sentence structures.

## 3. Content Length Guardrail

The **Content Length Guardrail** is a custom Synapse mediator for **WSO2 API Manager Universal Gateway**, designed to perform **content-byte-length validation** on incoming or outgoing JSON payloads. This component acts as a *guardrail* to enforce specific content moderation rules based on configurable minimum and maximum byte sizes and JSONPath expressions.

### ✨ Features

- ✅ Validate payload content by checking byte length
- ✅ Define **minimum and maximum byte thresholds**
- ✅ Target specific fields in JSON payloads using **JSONPath**
- ✅ Optionally **invert validation logic** (e.g., allow only content *outside* the specified byte range)
- ✅ Trigger fault sequences on rule violations
- ✅ Include optional **assessment messages** in error responses for better observability

### 🚀 How to Use

Follow these steps to integrate the Content Length Guardrail policy into your WSO2 API Manager instance:

1. Download the latest **Content Length Guardrail Distribution** from @TODO

2. **Unzip the downloaded artifact:**  
   ```bash
   unzip target/org.wso2.apim.policies.mediation.ai.content-length-guardrail-<version>-distribution.zip -d content-length-guardrail
   ```

3. **Copy the mediator JAR into your API Manager’s runtime libraries:**  
   Place the mediator JAR into your API Manager’s runtime libraries:

   ```bash
   cp content-length-guardrail/org.wso2.apim.policies.mediation.ai.content-length-guardrail-<version>.jar $APIM_HOME/repository/components/lib/
   ```

4. **Register the Policy in Publisher**  
    - Use the provided `policy-definition.json` and `artifact.j2` files to register the policy through the Publisher Portal or via the Publisher REST APIs.

5. **Apply and Deploy the Policy**
   - Open the **API Publisher**
   - Select your API
   - Go to **Runtime > Request/Response Flow**
   - Click **Add Policy**, select the new **Content Length Guardrail** policy
   - Provide the required configuration (name, min, max, etc.)
   - **Save and Deploy** the API

### 🧾 Example Policy Configuration
??? example "Click to expand configuration steps"

    1. Create an AI API using Mistral AI.
    2. Add the Content Length Guardrail policy to the API with the following configuration:

    | Field                           | Example                  |
    |---------------------------------|--------------------------|
    | `Guardrail Name`                | `Content Limiter`        |
    | `Minimum Content Length`        | `20`                     |
    | `Maximum Content Length`        | `1500`                   |
    | `JSON Path`                     | `$.messages[-1].content` |
    | `Invert the Guardrail Decision` | `false`                  |
    | `Show Guardrail Assessment`     | `false`                  |

    3. Save and re-deploy the API.
    4. Invoke the API's `chat/completion` endpoint with a prompt that violates the byte count, such as a short string under the minimum threshold:

    ```json
    {
    "messages": [
        {
            "role": "user",
            "content": "Hi!"
        }
    ]
    }
    ```

    The following guardrail error response will be returned with http status code `446`:

    ```json
    {
    "code": "900514",
    "type": "CONTENT_LENGTH_GUARDRAIL",
    "message": {
        "interveningGuardrail": "Content Limiter",
        "action": "GUARDRAIL_INTERVENED",
        "actionReason": "Violation of applied content length constraints detected.",
        "direction": "REQUEST"
    }
    }
    ```
