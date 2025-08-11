# Semantic Cache

## Overview

Semantic Cache in WSO2 AI Gateway is an intelligent cache mechanism that goes beyond traditional key-based cache by understanding the **semantic meaning** of AI requests and responses. Instead of requiring exact matches, semantic cache identifies similar or contextually equivalent queries and serves cached responses, significantly improving performance and reducing costs for AI API calls.

## Features

- **Intelligent Similarity Detection**: Uses embedding models to understand semantic similarity between queries
- **Cost Optimization**: Reduces AI provider API calls by serving cached responses for similar queries
- **Performance Enhancement**: Faster response times for semantically similar requests
- **Multiple Embedding Providers**: Support for Mistral, Azure OpenAI, and OpenAI embedding models
- **Vector Database Integration**: Leverages Zilliz for efficient similarity search
- **Configurable Similarity Thresholds**: Fine-tune cache behavior based on your use case

## Prerequisites

Before configuring semantic cache, ensure you have:

- Java 11 (JDK)
- Maven 3.6.x or later
- WSO2 API Manager with AI Gateway capabilities
- Access to one of the supported embedding providers (Mistral, Azure OpenAI, or OpenAI)
- A Zilliz vector database instance

## Configuration

Semantic cache requires configuration of two key components in your `deployment.toml` file:

### 1. Embedding Provider Configuration

Choose one of the following embedding providers:

=== "Mistral"

    ```toml
    [apim.ai.embedding_provider]
    type = "mistral"
    [apim.ai.embedding_provider.properties]
    apikey = "<your-mistral-api-key>"
    embedding_endpoint = "https://api.mistral.ai/v1/embeddings"
    embedding_model = "mistral-embed"
    ```

=== "Azure OpenAI"

    ```toml
    [apim.ai.embedding_provider]
    type = "azure"
    [apim.ai.embedding_provider.properties]
    apikey = "<your-azure-openai-api-key>"
    embedding_endpoint = "<your-azure-openai-embedding-endpoint>"
    ```

=== "OpenAI"

    ```toml
    [apim.ai.embedding_provider]
    type = "openai"
    [apim.ai.embedding_provider.properties]
    apikey = "<your-openai-api-key>"
    embedding_endpoint = "https://api.openai.com/v1/embeddings"
    embedding_model = "<openai-embedding-model>"
    ```

### 2. Vector Database Configuration
Configure Zilliz as your vector database provider:

```toml
[apim.ai.vector_db_provider]
type = "zilliz"
[apim.ai.vector_db_provider.properties]
uri = "your-zilliz-instance-uri"
token = "your-zilliz-token"
```

You can optionally specify a `ttl` property to control the time-to-live for cached entries. If not set, the default TTL is 3600 seconds.

## How to Use

Follow these steps to integrate the Semantic cache policy into your WSO2 API Manager instance:

1. **Clone and build the project** from [**Semantic Cache Policy**](https://github.com/wso2-extensions/apim-policies/tree/main/mediation/ai/semantic-cache):

    ```bash
    mvn clean install
    ```

    > ℹ️ This will generate a `.zip` file in the `target/` directory containing the mediator JAR, policy-definition.json and artifact.j2.

2. **Unzip the build artifact:**  
    ```bash
    unzip target/org.wso2.apim.policies.mediation.ai.semantic-cache-<version>-distribution -d semantic-cache
    ```

3. **Copy the mediator JAR into your API Manager's runtime libraries:**  
    ```bash
    cp semantic-cache/org.wso2.apim.policies.mediation.ai.semantic-cache-<version>.jar $APIM_HOME/repository/components/lib/
    ```

4. **Register the Policy in Publisher**  
    - Use the provided `policy-definition.json` and `artifact.j2` files to register the policy through the Publisher Portal or via the Publisher REST APIs.

5. **Apply and Deploy the Policy**
    - Open the **API Publisher**
    - Select your AI API
    - Go to **Runtime > Request/Response Flow**
    - Click **Add Policy**, select the **Semantic Cache** policy
    - Provide the required configuration (cache name, similarity threshold, etc.)
    - **Save and Deploy** the API

## Example Policy Configuration

??? example "Click to expand configuration steps"
    1. Create an AI API using OpenAI or any supported AI provider.  
    2. Add the Semantic Cache policy to the API with the following configuration:

    | Field                         | Example Value              | Description |
    |-------------------------------|----------------------------|--------------------------------------------------------|
    | `Semantic Cache Policy Name`   | `SemanticCache`            | Unique name for the semantic cache policy |
    | `Threshold`                   | `0.35`                     | Dissimilarity threshold for semantic matching (decimal value)|
    | `JSONPath`                    | `$.messages[-1].content`   | JSONPath expression to extract content for cache|

    **Threshold**:  
    The threshold sets the maximum allowed dissimilarity for semantic cache matches, measured using L2 (Euclidean) distance between embeddings.

    - For **normalized embeddings** (unit length vectors), the typical threshold range is **0.0** (exact match) to **2.0** (maximum distance).
    - For **unnormalized embeddings**, the range depends on your embedding model and data.

    Lower values (closer to 0) enforce stricter semantic similarity; higher values allow weaker matches. Refer to your embedding provider's documentation for recommended threshold values and normalization details.


    3. Save and re-deploy the API.  
    4. Invoke the API with similar queries to test semantic cache:

    **First Request:**
    ```json
    {
      "messages": [
        {
          "role": "user",
          "content": "What is the capital of France?"
        }
      ]
    }
    ```

    **Semantically Similar Request (Cache Hit):**
    ```json
    {
      "messages": [
        {
          "role": "user",
          "content": "Tell me the capital city of France"
        }
      ]
    }
    ```

    The second request will return a cached response much faster and with reduced costs, as it's semantically similar to the first query.


## Troubleshooting

### Common Issues

| Issue | Possible Cause | Solution |
|-------|----------------|----------|
| Low cache hit rate | Threshold too low | Increase the similarity threshold |
| Irrelevant cached responses | Threshold too high | Descrease the similarity threshold |
| Vector database connection errors | Invalid credentials | Verify Zilliz URI and token |
