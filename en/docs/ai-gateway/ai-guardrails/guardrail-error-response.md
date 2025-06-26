# Guardrail Error Response

When a **guardrail policy intervenes**—due to violations of organizational safety, security, or compliance standards—it is essential that downstream systems are notified **clearly and reliably**. To facilitate this, **AI Guardrails in WSO2 AI Gateway emit structured error responses**, enabling applications to observe, react, and recover appropriately.

## Why Guardrail Error Responses Matter

AI models can return technically valid outputs (e.g., `200 OK`) that **fail your application's logic** or **breach your organization's safety guidelines**. Guardrail error responses serve a critical role in:

- **Enforcing trust boundaries** in real time by detecting and blocking unsafe or non-compliant requests and responses.
- **Providing observability** for audit logs, dashboards, and alerts when a policy is triggered.
- **Enabling agentic behavior** in clients—such as retries with refined input, fallbacks to alternative logic, or user-facing error messaging.

By **standardizing** how these guardrail interventions are communicated, api developers can build **robust and intelligent client-side workflows** to handle violations predictably.

---

## Default Guardrail Error Response

When a policy is violated, WSO2 AI Gateway returns a structured `HTTP 446` error response with the following format:

```json
{
  "code": "900514",
  "type": "Status report",
  "message": "Runtime Error",
  "description": "Violation of <intervened-guardrail-name> detected."
}
```

### Notes:
- `446` is the default HTTP status code used by guardrail interventions.
- The `description` field provides a human-readable explanation of the specific guardrail that was triggered.

This structure enables **machine-readable processing** while retaining **clear semantics** for developers and observability systems.

---

## Customizing Guardrail Error Response

You can override the default error response to **include custom messaging, additional metadata, or specific formatting** for downstream systems. Follow these steps to define your own guardrail fault sequence:

### Step 1: Download the sample error sequence

Download the [sample fault sequence template]({{base_path}}/assets/attachments/guardrails/guardrail_fault.xml) provided by WSO2. This template includes customizable logic for formatting the error message, logging, and header propagation.

### Step 2: Customize the error response

The sample fault sequence leverages a **Synapse payloadFactory mediator** to construct a structured JSON error response using values from the **Synapse message context**, which are populated by the guardrail policy.

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

**Context Properties**  
- `ERROR_CODE`:  
  The unique **APIM guardrail exception code** (e.g., `900514`).  
- `ERROR_TYPE`:  
  The **type of the intervening guardrail** that triggered the response (e.g., `REGEX_GUARDRAIL`).  
- `ERROR_MESSAGE`:  
  A **JSON object** providing rich context on the policy violation. Example format:

  ```json
  {
    "interveningGuardrail": "<intervening-guardrail-name>",
    "assessments": "<failure-insights>",
    "action": "GUARDRAIL_INTERVENED",
    "actionReason": "<error-message>",
    "direction": "<REQUEST or RESPONSE>"
  }
  ```

  - `interveningGuardrail`: The name of the specific guardrail that intervened.
  - `assessments`: Detailed explainion of the violation.
  - `action`: The enforcement action taken (`GUARDRAIL_INTERVENED`).
  - `actionReason`: A short explanation describing why the action was triggered.
  - `direction`: Indicates whether the violation occurred during the **request** or **response** phase.

### Step 3: Place the sequence in the following path

Place the sequence file in your deployment directory:

```bash
<API_HOME>/repository/deployment/server/synapse-configs/default/sequences/
```

Make sure the file is named appropriately (e.g., `guardrail_fault.xml`).

### Step 4: Update `deployment.toml` configuration

Open your `deployment.toml` file and add or update the following configuration to register your custom sequence as the default handler for guardrail errors:

```toml
[apim.sync_runtime_artifacts.gateway.skip_list]
sequences = ["guardrail_fault.xml"]
```

> This instructs the AI Gateway to invoke your custom fault sequence whenever a guardrail policy violation occurs.

---

## Observability & Intelligent Handling

Each guardrail-triggered error includes **structured metadata** suitable for integration with:

- **Logging and tracing tools** (e.g., ELK, OpenTelemetry)
- **Alerting systems** to notify teams when sensitive or unsafe content is blocked
- **Client-side agents** that can:
    - Retry requests with refined prompts
    - Trigger fallback models or workflows
    - Present clear error messages to users
    - Record violations for governance or analytics

---
