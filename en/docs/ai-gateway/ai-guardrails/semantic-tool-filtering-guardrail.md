# Semantic Tool Filtering Policy

## Overview

The Semantic Tool Filtering policy dynamically filters the tools provided in an API request based on their semantic relevance to the user query. It uses vector embeddings and cosine similarity to select the most relevant tools, optimizing the request before it reaches the LLM. This policy supports both JSON and text-based tool definitions and works with embedding providers such as OpenAI, Mistral and Azure OpenAI.

## Features

- Semantic similarity matching between user query and tool definitions
- Flexible selection modes: By Rank (top-N) or By Threshold (similarity score)
- Multiple embedding provider support
- Configurable parameters for selection and extraction

## How It Works

1. Extracts the user query and tools from the request using JSONPath.
2. Generates embeddings for the query and each tool (using description).
3. Calculates cosine similarity between the query and each tool.
4. Selects tools based on the configured selection mode (top-N or threshold).
5. Replaces the original tools array with the filtered subset before forwarding to the LLM.

## How to Use

Follow these steps to integrate the Semantic Tool Filtering policy into your AI API:

- Open the API Publisher Portal (`https://<host>:<port>/publisher`)
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the Policy List
- Drag and drop the **Semantic Tool Filtering** policy into your request flow
- Fill in the required parameters 
- Save and Deploy the AI API

> Note: An embedding provider must be configured for semantic matching to work. See examples for more details.

## Example Policy Configuration

??? example "Click to expand configuration steps."
    Note: An embedding provider must be configured. Add one of the following to `$APIM_HOME/repository/conf/deployment.toml`:

    Generic template:
    ```toml
    [apim.ai.embedding_provider]
    type = "openai | mistral | azure-openai"
    [apim.ai.embedding_provider.properties]
    embedding_endpoint = "<embedding-endpoint>"
    apikey = "<api-key>"
    embedding_model = "<embedding-model>"
    ```

    MistralAI example:
    ```toml
	[apim.ai.embedding_provider]
	type = "mistral"
	[apim.ai.embedding_provider.properties]
	apikey = "<api-key>"
	embedding_endpoint = "https://api.mistral.ai/v1/embeddings"
	embedding_model = "mistral-embed"
    ```
	##Policy parameter configurations for text based and JSON formatted tools list.
	### Tools as JSON list

	JSON formatted Tool List Policy parameters Configuration

	| Field | Example |
	|---|---|
	| `Policy Name` | `semantic-tool-filtering` |
	| `selectionMode` | `By Rank` |
	| `Limit` | `2` |
	| `queryJSONPath` | `$.contents[0].parts[0].text` |
	| `toolsJSONPath` | `$.tools[0].function_declarations` |
	| `userQueryIsJson` | `true` |
	| `toolsIsJson` | `true` |
	
	Request Body Example (Tool List as JSON)

	```json
	{
		"contents": [
			{
				"role": "user",
				"parts": [
					{
						"text": "I'm planning a corporate retreat in Denver for next weekend. Can you find the weather forecast, book a conference room for 15 people, find a highly-rated catering service that offers vegan options, and then email the itinerary to my assistant at sarah@company.com?"
					}
				]
			}
		],
		"tools": [
			{
				"function_declarations": [
					{
						"name": "get_weather",
						"description": "Get current weather and 7-day forecast for a location.",
						"parameters": {
							"type": "OBJECT",
							"properties": {
								"location": { "type": "string", "description": "The city and state, e.g. Denver, CO" }
							},
							"required": ["location"]
						}
					},
					{
						"name": "book_venue",
						"description": "Reserve a conference room or meeting space.",
						"parameters": {
							"type": "OBJECT",
							"properties": {
								"location": { "type": "string" },
								"capacity": { "type": "integer", "description": "Number of people" },
								"date": { "type": "string", "description": "ISO date format" }
							},
							"required": ["location", "capacity", "date"]
						}
					},
					{
						"name": "find_restaurants",
						"description": "Locate dining options based on cuisine and dietary needs.",
						"parameters": {
							"type": "OBJECT",
							"properties": {
								"location": { "type": "string" },
								"dietary_options": { "type": "array", "items": { "type": "string" }, "description": "e.g. ['vegan', 'gluten-free']" }
							},
							"required": ["location"]
						}
					},
					{
						"name": "calendar_add",
						"description": "Create a new event on the user's primary calendar.",
						"parameters": {
							"type": "OBJECT",
							"properties": {
								"summary": { "type": "string" },
								"start_time": { "type": "string" },
								"end_time": { "type": "string" }
							},
							"required": ["summary", "start_time"]
						}
					},
					{
						"name": "send_email",
						"description": "Send an email to a specific recipient.",
						"parameters": {
							"type": "OBJECT",
							"properties": {
								"recipient": { "type": "string", "description": "Email address" },
								"subject": { "type": "string" },
								"body": { "type": "string" }
							},
							"required": ["recipient", "body"]
						}
					}
				]
			}
		]
	}
	```

	*After filtering, only the top 2 most relevant tools (e.g., `get_weather`, `book_venue`) are included in the forwarded request.*

	### Text-Based Tool List

	Text-based Tool List Policy parameters Configuration

	| Field | Example |
	|---|---|
	| `Policy Name` | `semantic-tool-filtering` |
	| `selectionMode` | `By Threshold` |
	| `Threshold` | `0.9` |
	| `queryJSONPath` | `$.contents[0].parts[0].text` |
	| `toolsJSONPath` | `$.contents[0].parts[0].text` |
	| `userQueryIsJson` | `false` |
	| `toolsIsJson` | `false` |

	Request Body Example (Text-Based Tool List)

	Note: After extraction, any inline tags used to mark tools or user queries (for example, `<toolname>`, `<tooldescription>`, and `<userq>`) are removed from the text before forwarding.

	```json
	{
		"contents": [
			{
				"parts": [
					{
						"text": "## Role: Executive Logistics Orchestrator ... <toolname>get_weather</toolname> (<tooldescription>Get current weather and 7-day forecast for a location</tooldescription>) ... <userq>I'm planning a corporate retreat in Denver for next weekend. ...</userq>"
					}
				]
			}
		]
	}
	```

	*Tools and query are extracted from tagged text. Only tools with similarity above 0.9 are included.*
 

## Evaluation Results

??? Click to expand evaluation results "Evaluation Results"
	Before diving into the performance metrics, it is important to understand the four types of user queries used to test the semantic filtering capabilities:

	- **Direct / Formal:** Explicit requests that clearly ask for a specific tool invocation.
	- **Natural / Conversational:** Indirect or informal queries where the user's intent to use a tool is expressed through casual language.
	- **User Query 200 Words:** Large, detailed queries (approximately 200 words) that provide significant context and background information before reaching the core request.
	- **Multiple Tools Query:** Complex queries that refer to and require the retrieval of three distinct tools within a single request.

	### Performance Comparison: 200 Tools
	This evaluation measures the Hit Rate (tool appeared in the top five results) and Average Confidence (cosine similarity) across a dataset of 200 tools.

	| Input Query Type | Azure OpenAI Hit Rate (%) | Azure OpenAI Avg. Confidence | Mistral AI Hit Rate (%) | Mistral AI Avg. Confidence |
	|---|---:|---:|---:|---:|
	| Formal (Direct) | 99.5 | 0.8584 | 100 | 0.8662 |
	| Conversational (Indirect) | 94.5 | 0.7485 | 100 | 0.7727 |
	| User Query (200 words) | 97 | 0.8381 | 100 | 0.8959 |
	| Multiple Tool Filtering | 78 | 0.63 | 89.5 | 0.7486 |

	### Performance Comparison: 400 Tools (High Similarity)
	In this scenario, 200 additional tools were added that are semantically similar to the original set to increase search difficulty.

	| Input Query Type | Azure OpenAI Hit Rate (%) | Azure OpenAI Avg. Confidence | Mistral AI Hit Rate (%) | Mistral AI Avg. Confidence |
	|---|---:|---:|---:|---:|
	| Formal (Direct) | 99.5 | 0.8621 | 99.75 | 0.8624 |
	| Conversational (Indirect) | 90.5 | 0.7267 | 97.75 | 0.7556 |
	| User Query (200 words) | 98 | 0.8675 | 100 | 0.9 |
	| Multiple Tool Filtering | 63.75 | 0.5335 | 76 | 0.6411 |

	*Interpretation: Hit Rate shows percentage of cases where the expected tool appeared in the top-5 results; Avg. Confidence is mean cosine similarity.*


	### Performance Considerations

	- **Batch Processing**: All tool embeddings are generated in batch for efficiency.
	- **Similarity Calculation**: Fast, even with large tool lists.

