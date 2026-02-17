# Using SDKs to Integrate AI APIs from WSO2 API Manager

When working with AI APIs created through WSO2 API Manager's AI Gateway, you can integrate them into your applications using various SDKs. This guide covers how to use both **LangChain** and **provider-specific Python SDKs** to interact with your AI APIs.

## Overview

AI APIs created through WSO2 API Manager act as intermediaries between your application and AI service providers. These APIs provide:

- **Unified Interface**: Consistent API endpoints regardless of the underlying AI provider
- **Security**: Centralized authentication and authorization
- **Rate Limiting**: Built-in protection for AI backends
- **Monitoring**: Analytics and observability for AI API usage

## Prerequisites

Before using SDKs with your AI APIs, ensure you have:

1. **Created an AI API** in WSO2 API Manager
2. **Configured backend security** with appropriate API keys
3. **Deployed and published** your AI API
4. **Generated access tokens** for API authentication

## Using SDKs with AI APIs

The following sections provide SDK examples for all supported AI providers in WSO2 API Manager. Each provider includes both LangChain and provider-specific SDK examples, organized alphabetically.

### Anthropic

Anthropic provides the Claude family of advanced language models.

=== "Anthropic SDK"

    ```python
    import anthropic
    import httpx

    http_client = httpx.Client(
        headers={
            "ApiKey": "your-apim-api-key"
        }
    )

    # Configure Anthropic SDK to use your proxy API
    client = anthropic.Anthropic(
        api_key="dummy-api-key",
        base_url="your-apim-proxy-url", 
        http_client=http_client
    )

    # Example usage
    response = client.messages.create(
        model="claude-3-5-sonnet-20241022",
        max_tokens=1000,
        messages=[
            {"role": "user", "content": "What is WSO2 API Manager?"}
        ]
    )

    print(response.content[0].text)
    ```

=== "LangChain SDK"

    ```python
    from langchain_anthropic import ChatAnthropic
    from langchain_core.messages import HumanMessage

    # Configure LangChain for Anthropic through proxy
    llm = ChatAnthropic(
        model="claude-3-5-sonnet-20241022",
        anthropic_api_url="your-apim-proxy-url",
        anthropic_api_key="dummy-api-key",
        default_headers={
            "ApiKey": "your-apim-api-key"
        }
    )

    # Example usage
    messages = [HumanMessage(content="What is WSO2 API Manager?")]
    response = llm.invoke(messages)
    print(response.content)
    ```

### AWS Bedrock

AWS Bedrock provides access to multiple AI models from various providers through AWS infrastructure.

=== "Boto3 SDK"

    ```python
    import os
    import boto3
    
    # Set environment variables for dummy AWS credentials
    os.environ['AWS_ACCESS_KEY_ID'] = 'dummy-access-key'
    os.environ['AWS_SECRET_ACCESS_KEY'] = 'dummy-secret-key'

    # Configure bedrock client to use WSO2 API Manager proxy
    session = boto3.Session()
    bedrock_client = session.client(
        service_name='bedrock-runtime',
        endpoint_url="your-apim-proxy-url" ,
        region_name='dummy-region'
    )

    # Add API key to client's meta events for requests
    def add_api_key_header(request, **kwargs):
        request.headers['ApiKey'] = "your-apim-api-key" 

    bedrock_client.meta.events.register('before-sign.*.*', add_api_key_header)

    # Example usage
    response = bedrock_client.converse(
        modelId="meta.llama3-3-70b-instruct-v1:0",
        messages=[
            {
                "role": "user",
                "content": [{"text": "What is WSO2 API Manager?"}]
            }
        ],
        system=[{"text": "You are a helpful assistant."}],
        inferenceConfig={"temperature": 0.7}
    )

    print(response['output']['message']['content'][0]['text'])
    ```

=== "LangChain SDK"

    ```python
    from langchain_aws import ChatBedrockConverse
    from langchain_core.messages import HumanMessage
    import boto3

    # Configure bedrock client to use WSO2 API Manager proxy
    session = boto3.Session()
    bedrock_client = session.client(
        service_name='bedrock-runtime',
        endpoint_url="your-apim-proxy-url",
        region_name='dummy-region',
    )

    # Add API key to client's meta events for requests
    def add_api_key_header(request, **kwargs):
        request.headers['ApiKey'] = "your-apim-api-key"

    bedrock_client.meta.events.register('before-sign.*.*', add_api_key_header)

    # Configure LangChain for AWS Bedrock through proxy using custom client
    llm = ChatBedrockConverse(
        model="meta.llama3-3-70b-instruct-v1:0",
        region_name="us-east-2",
        client=bedrock_client,  # Use our custom configured client
    )

    # Example usage
    messages = [HumanMessage(content="What is WSO2 API Manager?")]
    response = llm.invoke(messages)
    print(response.content)
    ```

### Azure AI Foundry

Azure AI Foundry provides access to multiple AI models from various providers through Azure infrastructure.

=== "Azure AI SDK"

    ```python
    from azure.ai.inference import ChatCompletionsClient
    from azure.ai.inference.models import SystemMessage, UserMessage
    from azure.core.credentials import AzureKeyCredential

    # Configure Azure AI SDK to use your proxy API
    client = ChatCompletionsClient(
        endpoint="your-apim-proxy-url/models",
        credential=AzureKeyCredential("dummy-api-key"),
        headers={
            "ApiKey": "your-apim-api-key"
        }
    )

    # Example usage
    response = client.complete(
      messages=[
        SystemMessage(content="You are a helpful assistant."),
        UserMessage(content="What is WSO2 API Manager?")
      ],
      model = "your-deployment",
      max_tokens=1000
    )

    print(response.output[0].content[0].text)
    ```

=== "LangChain SDK"

    ```python
    from langchain_azure_ai.chat_models import AzureAIChatCompletionsModel
    from azure.core.credentials import AzureKeyCredential

    # Configure Langchain SDK to use WSO2 API Manager proxy
    llm = AzureAIChatCompletionsModel(
        endpoint="your-apim-proxy-url/models",
        credential=AzureKeyCredential("your-apim-api-key"),
        model="your-deployment",
        api_version="2024-05-01-preview",
    )

    # Example usage
    response = llm.invoke("What is WSO2 API Manager?")
    print(response.content)
    ```

### Azure OpenAI

Azure OpenAI provides OpenAI models through Azure's infrastructure.

**Note:** The provided SDKs are for Azure OpenAI version 2.0.0 in API Manager.

=== "OpenAI SDK"

    ```python
    from openai import AzureOpenAI

    # Configure Azure OpenAI SDK to use your proxy API
    client = AzureOpenAI(
        api_key="dummy-api-key",
        base_url="your-apim-proxy-url/openai",
        api_version="2025-03-01-preview",
        default_headers={
            "ApiKey": "your-apim-api-key"
        }
    )

    # Example usage of the responses API
    response = client.responses.create(
        model="your-deployment",
        input="What is WSO2 API Manager?",
    )

    print(response.model_dump_json(indent=2))
    ```

=== "LangChain SDK"

    ```python
    from langchain_openai import AzureChatOpenAI
    from langchain_core.messages import HumanMessage

    # Configure LangChain for Azure OpenAI through proxy
    llm = AzureChatOpenAI(
        azure_deployment="your-deployment",
        api_version="2025-04-01-preview",
        azure_endpoint="your-apim-proxy-url",
        output_version="responses/v1",
        default_headers={
            "ApiKey": "your-apim-api-key"
        }
    )

    # Example usage
    messages = [HumanMessage(content="What is WSO2 API Manager?")]
    response = llm.invoke(messages)
    print(response.content)
    ```

### Gemini

Google's advanced language models through the Gemini API.

=== "Google Generative AI SDK"

    ```python
    import google.generativeai as genai

    # Configure Gemini SDK to use your proxy API
    client = genai.Client(
        api_key="dummy-api-key",
        http_options={
            "base_url": "your-apim-proxy-url",
            "api_version": "v1beta",
            "headers": {
                "ApiKey": "your-apim-api-key"
            }
        }
    )

    # Example usage
    response = client.models.generate_content(
        model="gemini-2.5-flash",
        contents="What is WSO2 API Manager?",
    )
    print(response.text)
    ```

=== "LangChain SDK"

    ```python
    from langchain_google_genai import ChatGoogleGenerativeAI
    from langchain_core.messages import HumanMessage

    # Configure LangChain for Gemini through proxy
    llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-flash",
        client_options={
            "api_endpoint": "your-apim-proxy-url"
        },
        google_api_key="dummy-api-key", 
        additional_headers={
            "ApiKey": "your-apim-api-key"
        },
        transport="rest"
    )

    # Example usage
    messages = [HumanMessage(content="What is WSO2 API Manager?")]
    response = llm.invoke(messages)
    print(response.content)
    ```

### Mistral AI

High-performance language models through Mistral's API.

=== "OpenAI SDK"

    ```python
    from openai import OpenAI

    # Configure openai SDK to use your proxy API
    client = OpenAI(
        api_key="dummy_api_key",
        base_url="your-apim-proxy-url",
        default_headers={
            "ApiKey": "your-apim-api-key"
        }
    )

    # Example usage
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "user", "content": "What is WSO2 API Manager?"}
        ]
    )

    print(response.choices[0].message.content)
    ```

=== "Mistral AI SDK"

    ```python
    import httpx
    from mistralai import Mistral

    # Monkey patch httpx Client to add relevant headers
    original_httpx_client_send = httpx.Client.send

    def patched_httpx_client_send(self, request, **kwargs):
        request.headers.update({
            'ApiKey': "your-apim-api-key"
        })
        return original_httpx_client_send(self, request, **kwargs)

    httpx.Client.send = patched_httpx_client_send

    # Configure mistral SDK to use your proxy API
    client = Mistral(
        api_key="dummy-api-key",
        server_url="your-apim-proxy-url",
    )

    # Example usage
    chat_response = client.chat.complete(
        model = "mistral-small-latest",
        messages = [
            {
                "role": "user",
                "content": "What is WSO2 API Manager?",
            },
        ]
    )

    print(chat_response.choices[0].message.content)
    ```

=== "LangChain SDK"

    ```python
    from langchain_openai import ChatOpenAI
    from langchain_core.messages import HumanMessage

    # Configure LangChain OpenAI to use Mistral through WSO2 proxy
    llm = ChatOpenAI(
        model="mistral-small-latest",
        api_key="dummy-api-key",
        base_url="your-apim-proxy-url/v1",
        temperature=0.7,
        default_headers={
            "ApiKey": "your-apim-api-key"
        }
    )

    # Example usage
    messages = [HumanMessage(content="What is WSO2 API Manager?")]
    response = llm.invoke(messages)
    print(response.content)
    ```

### OpenAI

OpenAI provides advanced language models including the GPT series.

=== "OpenAI SDK"

    ```python
    from openai import OpenAI

    # Configure OpenAI SDK to use your proxy API
    client = OpenAI(
        api_key="dummy-api-key",
        base_url="your-apim-proxy-url",
        default_headers={
            "ApiKey": "your-apim-api-key"
        }
    )

    # Example usage
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "user", "content": "What is WSO2 API Manager?"}
        ]
    )

    print(response.choices[0].message.content)
    ```

=== "LangChain SDK"

    ```python
    from langchain_openai import ChatOpenAI
    from langchain_core.messages import HumanMessage

    # Configure LangChain for OpenAI through proxy
    llm = ChatOpenAI(
        model="gpt-4o",
        openai_api_base="your-apim-proxy-url",
        openai_api_key="dummy-api-key",
        temperature=0.7,
        default_headers={
            "ApiKey": "your-apim-api-key",
        }
    )

    # Example usage
    messages = [HumanMessage(content="What is WSO2 API Manager?")]
    response = llm.invoke(messages)
    print(response.content)
    ```
