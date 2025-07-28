# AI Guardrails

Generative AI brings immense potential—but without the right controls, it also introduces significant risks.

LLMs (Large Language Models) are fundamentally **non-deterministic**. A request may succeed technically (returning a `200 OK`), but semantically **fail** your application’s logic, output expectations, safety guidelines, or compliance mandates. This disconnect creates a growing need for **real-time enforcement** of AI behavior.

### What Can Go Wrong: Risks of AI API Integration

| Problem | Description |
|--------|-------------|
| **Unpredictable Outputs** | LLMs may generate factually incorrect, incoherent, or harmful content—even when inputs seem safe. |
| **Bias and Fairness** | AI systems can amplify biases from training data, leading to discriminatory or offensive results. |
| **Security Vulnerabilities** | Attacks like **prompt injection** can subvert your prompts and redirect model behavior maliciously. |
| **Privacy Leaks** | Generated outputs can expose sensitive or personally identifiable information (PII) unintentionally. |
| **Regulatory Risk** | Lack of content moderation or auditability can breach compliance frameworks such as GDPR, HIPAA, or internal ethical standards. |

As adoption of LLMs and AI services accelerates across sectors, it’s critical for organizations to move beyond experimentation and toward **safe, reliable production usage**. This requires governing AI systems a through a **structured behavioral control framework** that ensure:

- **AI outputs remain aligned** with organizational values, policies, and formatting standards.  
- **Requests are inspected and validated** before reaching the model to prevent abuse or misuse.  
- **Responses are evaluated and refined** to uphold quality, safety, and compliance.  
- **Systems can respond intelligently**—through retries, fallbacks, or logging—when model behavior deviates from expected norms.

These practices help establish **trustworthy AI integrations**, minimize unexpected failures, and enable organizations to confidently scale their AI workloads in production.

## Safeguard AI API Integrations with **WSO2 AI Guardrails**

AI Guardrails in WSO2 AI Gateway are **real-time validation and enforcement layers** that sit between your application and the underlying AI provider.

They act as intelligent filters that:

- Inspect both **inputs** and **outputs** to AI models.
- Apply **policy-driven checks** to assess safety, quality, and compliance.
- Enable client applications to implement **adaptive response strategies** based on given guardrail error responses.

[![AI Gateway]({{base_path}}/assets/img/learn/ai-gateway/ai-guardrail-offerings.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/ai-guardrail-offerings.png)

---

## Supported Guardrails

<div style="display: flex; flex-wrap: wrap; gap: 1.5rem; margin-top: 1.5rem;">

  <a href="../content-length-guardrail" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">Content Length Guardrail</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Restricts the maximum length of LLM requests or responses.</div>
  </a>

  <a href="../regex-guardrail" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">Regex Guardrail</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Validates LLM requests or responses using custom regular expressions.</div>
  </a>

  <a href="../json-schema-guardrail" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">JSON Schema Guardrail</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Ensures LLM requests or responses match a specified JSON schema.</div>
  </a>

  <a href="../sentence-count-guardrail" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">Sentence Count Guardrail</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Limits the number of sentences in LLM requests or responses.</div>
  </a>

  <a href="../url-guardrail" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">URL Guardrail</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Validates URLs in LLM responses, useful to detect hallucinated URLs.</div>
  </a>

  <a href="../word-count-guardrail" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">Word Count Guardrail</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Restricts the number of words in LLM requests or responses.</div>
  </a>

  <a href="../regex-pii-masking" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">PII Masking with Regex</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Safeguard Personally Identifiable Information (PII) in LLM requests or responses by leveraging user-defined regular expressions.</div>
  </a>

  <a href="../semantic-prompt-guardrail" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">Semantic Prompt Guardrail</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Evaluate the semantic similarity of incoming prompts against a predefined list to allow or deny LLM requests.</div>
  </a>

  <a href="../azure-content-safety" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">Azure Content Safety Content Moderation</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Perform content moderation on LLM requests or responses using Azure Content Safety's Content Moderation API.</div>
  </a>

  <a href="../aws-bedrock-guardrail" style="flex: 1 1 300px; min-width: 280px; max-width: 333px; min-height: 200px; background: var(--md-primary-fg-color--lightest, #f5f5f5); border: 2px solid var(--md-primary-fg-color, #2196f3); border-radius: 12px; padding: 1.5rem; text-decoration: none; color: inherit; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: block;">
    <div style="font-size: 0.8rem; font-weight: bold; margin-bottom: 0.5rem;">AWS Bedrock Guardrail</div>
    <div style="font-size: 0.6rem; color: var(--md-default-fg-color--light, #333);">Enforce AI API Safeguards with AWS Bedrock Guardrails</div>
  </a>

</div>
