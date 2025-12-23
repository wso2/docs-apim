# Semantic Caching

The Semantic Cache is a custom policy for the WSO2 API Manager Universal Gateway that provides intelligent, meaning-based caching for AI requests. Unlike traditional caches that rely on exact matches, the Semantic Cache uses vector embeddings to identify and serve responses for semantically similar queries. This reduces latency, lowers costs associated with calling backend AI models, and improves overall API performance.

## Features

- **Intelligent Similarity Detection**: Uses embedding models to understand semantic similarity between queries.
- **Cost Optimization**: Reduces AI provider API calls by serving cached responses for similar queries.
- **Performance Enhancement**: Faster response times for semantically similar requests.
- **Multiple Embedding Providers**: Support for Mistral, Azure OpenAI, and OpenAI embedding models.
- **Vector Database Integration**: Leverages Zilliz for efficient similarity search.
- **Configurable Similarity Thresholds**: Fine-tune cache behavior based on your use case.

## Configure the Environment

Before using the Semantic Cache policy, you must configure an embedding provider and a vector database in the `deployment.toml` file.

### 1. Embedding Provider Configuration

Choose one of the following embedding providers and add the configuration to your `<APIM_HOME>/repository/conf/deployment.toml` file:

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
    type = "azure-openai"
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

The Semantic Cache supports Zilliz and Milvus as vector database providers (**Support for additional vector database providers will be added soon**). Configure the desired provider in your `<APIM_HOME>/repository/conf/deployment.toml` file:

=== "Zilliz"

    ```toml
    [apim.ai.vector_db_provider]
    type = "zilliz"
    [apim.ai.vector_db_provider.properties]
    uri = "your-zilliz-instance-uri"
    token = "your-zilliz-token"
    ```

=== "Milvus"

    ```toml
    [apim.ai.vector_db_provider]
    type = "zilliz"
    [apim.ai.vector_db_provider.properties]
    uri = "http://localhost:19530"
    token = "root:Milvus"
    ```

You can optionally specify a `ttl` property to control the time-to-live for cached entries. If not set, the default TTL is 3600 seconds.

## How to Use

Follow these steps to integrate the Semantic Cache policy into your WSO2 API Manager AI APIs:

1. Log in to the API Publisher Portal at `https://<host>:<port>/publisher`.
2. Select the API you want to configure.
3. Navigate to **Develop > API Configurations > Policies > Request/Response Flow**.
4. **Add the policy to both Request and Response flows:**
   - **Request Flow**: Click **Add Policy** and choose **Semantic Cache** from the list. Configure the cache policy name, similarity threshold, and JSONPath expression.
   - **Response Flow**: Click **Add Policy** and choose **Semantic Cache** from the list. Configure the cache policy name and similarity threshold (JSONPath is not required for response flow).
5. Save your changes and deploy the API.

!!! note "Important"
    The Semantic Cache policy must be added to both request and response flows to function properly. The request flow handles cache lookup using the JSONPath to extract content for semantic similarity checking, while the response flow handles cache storage.

## Example Policy Configuration

??? example "Click to expand configuration steps"
    1. Create an AI API using OpenAI or any supported AI provider.  
    2. Add the Semantic Cache policy to both request and response flows with the following configuration:

    **Request Flow Configuration:**
    
    | Field                         | Example Value              | Description |
    |-------------------------------|----------------------------|--------------------------------------------------------|
    | `Semantic Cache Policy Name`   | `SemanticCache`            | Unique name for the semantic cache policy |
    | `Threshold`                   | `0.35`                     | Dissimilarity threshold for semantic matching (decimal value)|
    | `JSONPath`                    | `$.messages[-1].content`   | JSONPath expression to extract content for semantic similarity checking|

    **Response Flow Configuration:**

    | Field                         | Example Value              | Description |
    |-------------------------------|----------------------------|--------------------------------------------------------|
    | `Semantic Cache Policy Name`   | `SemanticCache`            | Unique name for the semantic cache policy (should match request flow) |
    | `Threshold`                   | `0.35`                     | Dissimilarity threshold for semantic matching (decimal value)|
    | `JSONPath`                    | Not required               | JSONPath is not needed in response flow as it only handles cache storage|

    **JSONPath Usage**:  
    The JSONPath expression is used to extract the specific content from the request payload that will be used for semantic similarity comparison. This should only be configured in the request flow where the cache lookup occurs.

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
| Low cache hit rate | Threshold (dissimilarity) too low | Increase the dissimilarity/distance threshold. |
| Irrelevant cached responses | Threshold too high | Decrease the dissimilarity/distance threshold. |
| Vector database connection errors | Invalid credentials or endpoint | Verify your Zilliz URI and token in the `deployment.toml` file. |
