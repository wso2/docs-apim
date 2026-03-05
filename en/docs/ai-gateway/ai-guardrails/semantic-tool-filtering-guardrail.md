# Semantic Tool Filtering Policy

## Overview

The Semantic Tool Filtering policy dynamically filters the tools provided in an API request based on their semantic relevance to the user query. It uses vector embeddings and cosine similarity to select the most relevant tools, optimizing the request before it reaches the LLM. This policy supports both JSON and text-based tool definitions and works with embedding providers such as OpenAI, Mistral, Azure OpenAI, and Gemini.

## Features

- Semantic similarity matching between user query and tool definitions
- Flexible selection modes: By Rank (top-N) or By Threshold (similarity score)
- JSONPath extraction for queries and tools
- Multiple embedding provider support
- Configurable parameters for selection and extraction

## How It Works

1. Extracts the user query and tools from the request using JSONPath.
2. Generates embeddings for the query and each tool (using name + description).
3. Calculates cosine similarity between the query and each tool.
4. Selects tools based on the configured selection mode (top-N or threshold).
5. Replaces the original tools array with the filtered subset before forwarding to the LLM.

## How to Use

Follow these steps to integrate the Semantic Tool Filtering policy into your AI API:

- Open the API Publisher Portal (`https://<host>:<port>/publisher`)
- Select your AI API
- Go to **Develop > API Configurations > Policies**
- Expand **Common Policies** in the Policy List
- Drag and drop the **Semantic Tool Filtering** policy into your desired mediation flow
- Fill in the required parameters (see Parameters and System Parameters below)
- Save and Deploy the AI API

> Note: An embedding provider must be configured for semantic matching to work. See `System Parameters` for required fields.

## Example Policy Configuration

??? example "Click to expand configuration steps"
		Policy YAML (Gemini provider example):

		```yaml
		apiVersion: gateway.api-platform.wso2.com/v1alpha1
		kind: LlmProvider
		metadata:
			name: tool-filtered-agent
		spec:
			displayName: Gemini tool filtered agent
			version: v1.0
			template: "gemini"
			upstream:
				url: "https://generativelanguage.googleapis.com/v1beta/models"
				auth:
					type: api-key
					header: x-goog-api-key
					value: "<api-key>"
			accessControl:
				mode: deny_all
				exceptions:
					- path: /gemini-3-flash-preview:generateContent
						methods: [POST]
			policies:
				- name: semantic-tool-filtering
					version: v0.1.0
					paths:
						- path: /gemini-3-flash-preview:generateContent
							methods: [POST]
							params:
								selectionMode: "By Rank"
								Limit: 2
								queryJSONPath: "$.contents[0].parts[0].text"
								toolsJSONPath: "$.tools[0].function_declarations"
								userQueryIsJson: true
								toolsIsJson: true
		```

## Request Body Example (Tools as JSON List)

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

## Example: Gemini API with JSON Tool List

**Policy Configuration:**

```yaml
policies:
	- name: semantic-tool-filtering
		version: v0.1.0
		paths:
			- path: /gemini-3-flash-preview:generateContent
				methods: [POST]
				params:
					selectionMode: "By Rank"
					Limit: 2
					queryJSONPath: "$.contents[0].parts[0].text"
					toolsJSONPath: "$.tools[0].function_declarations"
					userQueryIsJson: true
					toolsIsJson: true
```

**Request Body Example:**

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
				{ "name": "get_weather", "description": "Get current weather and 7-day forecast for a location." },
				{ "name": "book_venue", "description": "Reserve a conference room or meeting space." },
				{ "name": "find_restaurants", "description": "Locate dining options based on cuisine and dietary needs." },
				{ "name": "calendar_add", "description": "Create a new event on the user's primary calendar." },
				{ "name": "send_email", "description": "Send an email to a specific recipient." }
			]
		}
	]
}
```

*After filtering, only the top 2 most relevant tools (e.g., `get_weather`, `book_venue`) are included in the forwarded request.*

## Example: Text-Based Tool List

**Policy Configuration:**

```yaml
policies:
	- name: semantic-tool-filtering
		version: v0.1.0
		paths:
			- path: /gemini-3-flash-preview:generateContent
				methods: [POST]
				params:
					selectionMode: "By Threshold"
					Threshold: 0.9
					queryJSONPath: "$.contents[0].parts[0].text"
					toolsJSONPath: "$.contents[0].parts[0].text"
					userQueryIsJson: false
					toolsIsJson: false
```

**Request Body Example (shortened):**

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

## Error Response

If no tools meet the selection criteria, or extraction fails, the policy returns an HTTP 422 error:

```json
{
	"type": "SEMANTIC_TOOL_FILTERING",
	"message": {
		"action": "GUARDRAIL_INTERVENED",
		"interveningGuardrail": "semantic-tool-filtering",
		"actionReason": "No tools matched the selection criteria.",
		"direction": "REQUEST"
	}
}
```

Extraction or embedding errors are reported in `actionReason`:

```json
{
	"type": "SEMANTIC_TOOL_FILTERING",
	"message": {
		"action": "GUARDRAIL_INTERVENED",
		"interveningGuardrail": "semantic-tool-filtering",
		"actionReason": "Error extracting tools from JSONPath",
		"direction": "REQUEST"
	}
}
```

### Parameters

| Parameter         | Type    | Required | Default | Description |
|-------------------|---------|----------|---------|-------------|
| `selectionMode`   | string  | Yes      | "By Rank" | "By Rank" or "By Threshold" |
| `Limit`           | integer | No       | 5       | Number of top tools to select (By Rank) |
| `Threshold`       | number  | No       | 0.7     | Similarity threshold (By Threshold) |
| `queryJSONPath`   | string  | No       | `$.messages[-1].content` | JSONPath to extract user query |
| `toolsJSONPath`   | string  | No       | `$.tools` | JSONPath to extract tools array |
| `userQueryIsJson` | boolean | No       | true    | If true, extract query using JSONPath; if false, use `<userq>` tags |
| `toolsIsJson`     | boolean | No       | true    | If true, extract tools using JSONPath; if false, use `<toolname>` and `<tooldescription>` tags |

### System Parameters

| Parameter         | Type    | Required | Description |
|-------------------|---------|----------|-------------|
| `embeddingProvider` | string | Yes      | Embedding provider: OPENAI, MISTRAL, AZURE_OPENAI, GEMINI |
| `embeddingEndpoint` | string | Yes      | Endpoint URL for embedding service |
| `embeddingModel`    | string | Conditional | Model name (required for OPENAI/MISTRAL) |
| `apiKey`            | string | Yes      | API key for embedding service |

## Evaluation Results

Before diving into the performance metrics, it is important to understand the four types of user queries used to test the semantic filtering capabilities:

- **Direct / Formal:** Explicit requests that clearly ask for a specific tool invocation.
- **Natural / Conversational:**: Indirect or informal queries where the user's intent to use a tool is expressed through casual language.
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

## Performance Considerations

- **Embedding Latency**: Each request incurs embedding generation for the query and all tools (~100-500ms).
- **Batch Processing**: All tool embeddings are generated in batch for efficiency.
- **Similarity Calculation**: Fast, even with large tool lists.

## Notes

- At least one tool must be present in the request for filtering.
- JSONPath and text extraction are configurable for flexible integration.
- Monitor tool selection results and adjust thresholds/limits for optimal performance.
