# Guardrail Error Response

When a **guardrail policy intervenes** due to violations of organizational safety, security, or compliance standards downstream systems must be notified **clearly and reliably**. To enable this, **AI Guardrails in WSO2 AI Gateway emit structured error responses**, allowing applications to observe, react, and recover appropriately.

## Why Guardrail Error Responses Matter

AI models can return technically valid outputs (e.g., `200 OK`) that **fail application logic** or **breach organizational safety guidelines**. Guardrail error responses:

- **Enforce trust boundaries** in real time by detecting and blocking unsafe or non-compliant requests and responses.
- **Provide observability** for audit logs, dashboards, and alerts when a policy is triggered.
- **Enable adaptive client behavior** (retries with refined input, fallbacks, or user-facing error messaging).

By **standardizing** how interventions are communicated, API developers can build **robust, predictable client workflows** to handle violations.

## Default Guardrail Error Response

When a policy is violated, WSO2 AI Gateway returns an `HTTP 446` response with the following JSON structure:

```json
{
  "code": "900514",
  "type": "<intervening-guardrail-type>",
  "message": {
    "interveningGuardrail": "<intervening-guardrail-name>",
    "assessments": "<failure-insights>",
    "action": "GUARDRAIL_INTERVENED",
    "actionReason": "<error-message>",
    "direction": "<REQUEST or RESPONSE>"
  }
}
```

### Notes
- `446` is the default HTTP status code used for guardrail interventions.
- `actionReason` provides a human-readable explanation of the specific guardrail that was triggered.

This structure is **machine-readable** yet maintains **clear semantics** for developers and observability systems.

## Customizing the Guardrail Error Response

You can override the default error response to include **custom messaging**, **additional metadata**, or **alternative formatting**. Define your own guardrail fault sequence as follows:

### Step 1: Locate the fault sequence file

Path:
```
<API_HOME>/repository/deployment/server/synapse-configs/default/sequences/
```

Look for `guardrail_fault.xml`.

### Step 2: Customize the payload

The default guardrail fault sequence uses a **Synapse payloadFactory mediator** to construct the JSON response from **message context properties** populated by the guardrail policy:

```xml
<payloadFactory media-type="json">
    <format>{"code":"$1","type":"$2","message":$3}</format>
    <args>
        <arg expression="$ctx:ERROR_CODE"/>
        <arg expression="$ctx:ERROR_TYPE"/>
        <arg expression="$ctx:ERROR_MESSAGE"/>
    </args>
 </payloadFactory>
```

### Context properties
- `ERROR_CODE`: The unique **APIM guardrail exception code** (e.g., `900514`).
- `ERROR_TYPE`: The **type of the intervening guardrail** (e.g., `REGEX_GUARDRAIL`).
- `ERROR_MESSAGE`: A **JSON object** describing the violation. 

  ```json
  {
    "interveningGuardrail": "<intervening-guardrail-name>",
    "assessments": "<failure-insights>",
    "action": "GUARDRAIL_INTERVENED",
    "actionReason": "<error-message>",
    "direction": "<REQUEST or RESPONSE>"
  }
  ```

  Field meanings:

  - `interveningGuardrail`: Name of the guardrail that intervened.
  - `assessments`: Detailed explanation of the violation.
  - `action`: Enforcement action taken (`GUARDRAIL_INTERVENED`).
  - `actionReason`: Concise reason the action was triggered.
  - `direction`: Indicates whether the violation occurred in the **request** or **response** phase.

### (Optional) Step 3: Add custom fields
You may enrich the JSON (e.g., correlation IDs, remediation hints, classification labels) by extending the payload factory format and adding additional context properties.

## Observability and Intelligent Handling

Each guardrail-triggered error includes **structured metadata** suitable for integration with:

- **Logging and tracing pipelines** (ELK, OpenTelemetry, etc.)
- **Alerting systems** (paging when sensitive or unsafe content is blocked)
- **Client-side agents / orchestrators** that can:
  - Retry with refined prompts
  - Trigger fallback models or workflows
  - Surface user-friendly guidance
  - Record violations for governance or analytics

---
