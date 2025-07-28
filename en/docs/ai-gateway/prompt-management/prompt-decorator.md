# Prompt Decorator

The **Prompt Decorator** is a custom Synapse mediator for the **WSO2 API Manager Universal Gateway**, designed to enhance and standardize prompt inputs sent to AI services. It applies structured **prompt decoration techniques** to incoming text or chat-based payloads, enabling centralized control over prompt formatting, tone, behavior hints, and other guiding cues.

Prompt decoration is a specialized **prompt engineering technique** that uses explicit modifiers such as symbols, keywords, or formatting cues to direct the AI’s reasoning, structure, or output format. These “decorators” act as **meta-instructions**, clarifying how the AI should approach a task. Among emerging techniques, prompt decoration stands out as a **practical method** for guiding AI behavior with **precision and consistency**.


## Features

- Apply structured decorations to both **text** and **chat-based prompts**
- Support **prepend** and **append** modes for flexible decorator placement
- Centrally manage decorators at the **AI API level**
- Enforce prompt consistency across all AI API consumers
- Improve safety, predictability, and output control in LLM interactions

## How to Use

!!! important
    This policy is available from the following WSO2 API Manager product update levels onward:

    - `wso2am`: Update level **greater than 12**
    - `wso2am-universal-gw`: Update level **greater than 12**
    - `wso2am-acp`: Update level **greater than 13**
    - `wso2am-tm`: Update level **greater than 12**

Follow these steps to integrate the Prompt Decorator Guardrail policy into your WSO2 API Manager instance:

1. Download the latest [**Prompt Decorator**](https://github.com/wso2-extensions/apim-policies/releases/download/v1.0.0-prompt-decorator/org.wso2.am.policies.mediation.ai.prompt-decorator-1.0.0-distribution.zip) policy

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
            <td><code>org.wso2.am.policies.mediation.ai.prompt-decorator-&lt;version&gt;</code></td>
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
    - Click **Add Policy** and select **Prompt Decorator Guardrail**
    - Provide the required configuration (mode, decorator content, fields to apply on, etc.)
    - **Save and Deploy** the API

## Example Policy Configuration

### Mode: Text Prompt Decoration

This example demonstrates how the Prompt Decorator policy can be used to inject summarization instructions into a raw prompt that contains a large block of text. The decorator is applied at the text level, specifically targeting the last message in the conversation using a JSONPath expression. By prepending a consistent summarization directive, the assistant is guided to produce summaries that align with organizational tone and expectations, such as being concise, neutral, and professionally structured.

1. Create an AI API with Mistral AI.
2. Add the Prompt Decorator policy to the API with the following configuration:

      | Field                        | Example                    |
      |------------------------------|----------------------------|
      | `Decorator Name`             | `Summarizer Directive`     |
      | `JSON Path`                  | `$.messages[-1].content`   |
      | `Append Decorated Content`   | `false`                    |

      `Prompt Decorator Configuration`:
      ```json
      {
        "decoration": "Summarize the following content in a concise, neutral, and professional tone. Structure the summary using bullet points if appropriate.\n\n"
      }
      ```

3. Save and re-deploy the API.
4. Invoke the API's `chat/completion` endpoint with a large text to summerize in the payload:

      ```json
      {
        "model": "mistral-small-latest",
        "messages": [
            {
                "role": "user",
                "content": "<Large text to summarize>"
            }
        ]
      }
      ```

      The policy will inject the configured prompt decorator and the following will be sent to the AI service:

      ```json
      {
        "model": "mistral-small-latest",
            "messages": [
                {
                    "role": "user",
                    "content": "Summarize the following content in a concise, neutral, and professional tone. Structure the summary using bullet points if appropriate.\n\n<Large text to summarize>"
                }
            ]
      }
      ```


### Mode: Chat Prompt Decoration

This example demonstrates how the Prompt Decorator policy can be used to inject a receptionist persona into an AI-powered hotel booking agent. By applying a structured decorator at the chat level, the assistant is guided to interact in a professional, friendly, and conversational manner, similar to a real hotel receptionist. This ensures an improved user experience while the assistant gathers booking details and completes the reservation using a tool call.

1. Create an AI API with Mistral AI.
2. Add the Prompt Decorator policy to the API with the following configuration:

    | Field                        | Example                |
    |------------------------------|------------------------|
    | `Decorator Name`             | `Receptionist Persona` |
    | `JSON Path`                  | `$.messages`           |
    | `Append Decorated Content`   | `false`                |

    `Prompt Decorator Configuration`:
    ```json
    {
        "decoration": [
            {
                "role": "system",
                "content": "You are a helpful hotel booking receptionist for the imaginary hotel 'Azure Horizon Resort'. Your job is to collect all the necessary booking details from guests: name, NIC, check-in time, staying duration (in nights), and room type (single, double, suite). Ask one detail at a time in a friendly and professional tone. Once all details are collected, call the booking tool to complete the reservation and return the booking confirmation."
            }
        ]
    }
    ```

3. Save and re-deploy the API.
4. Invoke the API's `chat/completion` endpoint with the following payload:

    ```json
    {
        "model": "mistral-small-latest",
        "messages": [
            {
                "role": "user",
                "content": "Hi, I’d like to book a room."
            }
        ],
        "tools": [
            {
                "type": "function",
                "function": {
                    "name": "book_hotel_room",
                    "description": "Finalizes a hotel room reservation based on guest-provided details.",
                    "parameters": {
                        "type": "object",
                        "properties": {
                            "name": {
                                "type": "string",
                                "description": "Full name of the guest"
                            },
                            "nic": {
                                "type": "string",
                                "description": "National Identity Card number"
                            },
                            "check_in": {
                                "type": "string",
                                "format": "date-time",
                                "description": "Check-in date and time (e.g., 2025-08-01T14:00:00)"
                            },
                            "nights": {
                                "type": "integer",
                                "description": "Number of nights the guest wants to stay"
                            },
                            "room_type": {
                                "type": "string",
                                "enum": ["single", "double", "suite"],
                                "description": "Type of room requested"
                            }
                        },
                        "required": ["name", "nic", "check_in", "nights", "room_type"]
                    }
                }
            }
        ],
        "tool_choice": "auto"
    }
    ```

    The policy will inject the configured prompt decorator and the following will be send to the AI service:

    ```json
    {
        "model": "mistral-small-latest",
        "messages": [
            {
                "role": "system",
                "content": "You are a helpful hotel booking receptionist for the imaginary hotel 'Azure Horizon Resort'. Your job is to collect all the necessary booking details from guests: name, NIC, check-in time, staying duration (in nights), and room type (single, double, suite). Ask one detail at a time in a friendly and professional tone. Once all details are collected, call the booking tool to complete the reservation and return the booking confirmation."
            },
            {
                "role": "user",
                "content": "Hi, I’d like to book a room."
            }
        ],
        "tools": [
            {
                "type": "function",
                "function": {
                    "name": "book_hotel_room",
                    "description": "Finalizes a hotel room reservation based on guest-provided details.",
                    "parameters": {
                        "type": "object",
                        "properties": {
                            "name": {
                                "type": "string",
                                "description": "Full name of the guest"
                            },
                            "nic": {
                                "type": "string",
                                "description": "National Identity Card number"
                            },
                            "check_in": {
                                "type": "string",
                                "format": "date-time",
                                "description": "Check-in date and time (e.g., 2025-08-01T14:00:00)"
                            },
                            "nights": {
                                "type": "integer",
                                "description": "Number of nights the guest wants to stay"
                            },
                            "room_type": {
                                "type": "string",
                                "enum": ["single", "double", "suite"],
                                "description": "Type of room requested"
                            }
                        },
                        "required": ["name", "nic", "check_in", "nights", "room_type"]
                    }
                }
            }
        ],
        "tool_choice": "auto"
    }
    ```
    