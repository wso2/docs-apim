# AI Assistants

WSO2 API Manager includes three AI-assisted capabilities that let API creators, publishers, and consumers work in natural language instead of navigating every screen manually:

- **Marketplace Assistant**: Helps API consumers discover published APIs in the Developer Portal by describing what they need instead of searching manually.
- **Design Assistant**: Generates and refines API specifications from a natural-language description of the API you want to build.
- **API Chat**: Prepares a REST API definition and lets you exercise its resources conversationally, without configuring a test client by hand.

## The AI Assistants

| Assistant | What it does |
| :--- | :--- |
| Marketplace Assistant | Find published APIs by describing what you need |
| Design Assistant | Generate or refine an API specification from a description |
| API Chat | Test an API's resources through conversation |

## Choose how the assistants are powered

By default, all three assistants are backed by AI services that WSO2 hosts and manages for you. You can also deploy the AI services yourself.

[![Choose how the AI Assistants are powered]({{base_path}}/assets/img/learn/ai-assistants/ai-assistants-deployment-options.png)]({{base_path}}/assets/img/learn/ai-assistants/ai-assistants-deployment-options.png)

### 1. Use the WSO2-hosted AI services

This is the default, and it requires no additional setup. Each assistant's own guide covers how to use it:

- [Marketplace Assistant]({{base_path}}/api-developer-portal/discover-apis/marketplace-assistant/)
- [Design Assistant: Create APIs with AI]({{base_path}}/api-design-manage/design/create-api/create-api-with-ai/)
- [API Chat]({{base_path}}/api-developer-portal/invoke-apis/invoke-apis-using-tools/test-apis-with-apichat/)

### 2. Deploy your own AI services

If your requirements go beyond the WSO2-hosted services, or you need to keep AI processing within your own environment, you can implement and deploy the AI services yourself. API Manager invokes your implementation through an API Gateway, as long as it follows the published OpenAPI contract for the assistant you're replacing.

See [Integrate a self-hosted AI service]({{base_path}}/reference/customize-product/extending-api-manager/extending-ai-services/#integrate-a-user-owned-ai-service) for the contracts, deployment steps, and configuration required.

#### Add custom properties to AI service requests

Your self-hosted service can also receive extra request context, such as a username or organization, without adding it in your own service code. Configure an AI request property enricher in API Manager to add these fields before the request reaches your service.

See [Add custom properties to AI service requests]({{base_path}}/reference/customize-product/extending-api-manager/extending-ai-services/#add-custom-properties-to-ai-service-requests) for how to implement a request property enricher.

## Next Steps

- New to the AI Assistants? Start with [Marketplace Assistant]({{base_path}}/api-developer-portal/discover-apis/marketplace-assistant/), the simplest to try from the Developer Portal.
- Need to run the AI services in your own environment? See [Integrate a self-hosted AI service]({{base_path}}/reference/customize-product/extending-api-manager/extending-ai-services/#integrate-a-user-owned-ai-service).
- Need your self-hosted service to receive extra request context? See [Add custom properties to AI service requests]({{base_path}}/reference/customize-product/extending-api-manager/extending-ai-services/#add-custom-properties-to-ai-service-requests).
