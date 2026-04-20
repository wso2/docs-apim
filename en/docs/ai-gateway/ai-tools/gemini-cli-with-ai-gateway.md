# Configuring Google Gemini CLI with AI Gateway

It is possible to proxy Google Gemini API calls through WSO2 API Manager using the AI Gateway, enabling tools such as Gemini CLI to access Google Gemini services through the AI Gateway.

By routing requests through the AI Gateway instead of invoking Google Gemini directly, you can apply security, traffic control, and governance policies such as guardrails, rate limiting, and monitoring. The Gateway acts as an intermediary, forwarding requests from Google Gemini CLI to Google Gemini while enforcing these controls.

This section provides step-by-step instructions for proxying Google Gemini API calls through WSO2 API Manager.

---

## Step 0: Prerequisites

Before continuing with the setup, make sure you have the following: 

- [Google Gemini CLI](https://geminicli.com/docs/get-started/installation/) installed  
- A [Gemini API key](https://aistudio.google.com/app/api-keys)

---

## Step 1: Deploy the Google AI API in WSO2 API Manager

1. **Log in to the Publisher Portal**.  
    Navigate to the WSO2 API Manager Publisher portal:  
    `https://<APIM-HOST>:<APIM-PORT>/publisher`

2. **Create a New AI API**.  
    Create a new AI API by selecting **Gemini** as the AI service provider.  
    Configure the remaining settings as required.

3. **Configure the Endpoint**.  
    1. Navigate to **Develop → API Configurations → Endpoints**.
    2. Create a new endpoint or edit the existing production endpoint.
    3. Ensure the following configurations are set:
        - **Endpoint URL**: `https://generativelanguage.googleapis.com`  
        - **API Key**: `<GEMINI API KEY>`

4. **Configure the x-goog-api-key Header**.  
    Gemini CLI sends the API key using the `x-goog-api-key` header. Instead of introducing a custom `ApiKey` header expected by APIM, configure the gateway to accept this existing header:  
      
    1. Navigate to **Develop → API Configurations → Runtime**.
    2. Under **Application Level Security**, set the **ApiKey Header** to:

        ```
        x-goog-api-key
        ```

5. **Deploy and Publish**.  
    Deploy and publish the Google AI API.

---

## Step 2: Obtain an API Key from WSO2 API Manager

1. **Log in to the Developer Portal**.  
    Navigate to the WSO2 API Manager Developer portal:  
    `https://<APIM-HOST>:<APIM-PORT>/devportal`

2. **Select the API**.  
    Select the Google AI API you just published.

3. **Subscribe to the API**.  
    Subscribe to the API using an application of your choice.

4. **Generate and Note the API Key**.  
    Generate an API Key for the application and make sure to save it for later use.

---

## Step 4: Configure Gemini to Use the AI Gateway

Unlike Claude Code, Gemini relies entirely on environment variables for configuration and does not use a settings file.

1. **Open a Terminal**.  
    Open a new terminal session.

2. **Set Environment Variables**.  
    Run the following commands, replacing placeholders with your values:

    ```bash
    export GOOGLE_GEMINI_BASE_URL="<GEMINI AI API EXPOSED URL>"
    export GEMINI_API_KEY="<WSO2 API KEY>"
    ```

    !!! note
        These environment variables must be set in the same session where the Gemini CLI is executed. Alternatively, they can be configured as permanent environment variables.

### Apply Temporary SSL Fix (For Testing Only)

To bypass SSL certificate validation during testing, run:

```bash
export NODE_TLS_REJECT_UNAUTHORIZED=0
```

!!! warning
    This should only be used in development environments.

---

### Run the Gemini CLI Client

Execute the Gemini CLI.

Requests will now be routed through the WSO2 API Manager AI Gateway.
