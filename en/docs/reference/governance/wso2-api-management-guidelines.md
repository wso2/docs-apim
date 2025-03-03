# WSO2 API Management Guidelines

A guide detailing best practices for creating robust, scalable, and secure APIs, ensuring alignment with industry standards for optimal design.

## Rules Overview

| Rule Name | Severity | Description |
|-----------|----------|-------------|
| [api-name-required](#api-name-required) | Error | API `name` is required. |
| [api-name-no-special-characters](#api-name-no-special-characters) | Error | API `name` should not contain whitespaces or special characters except for hyphens, underscores, and periods. |
| [api-name-length](#api-name-length) | Error | API `name` should be between 1 and 50 characters. |
| [api-context-required](#api-context-required) | Error | The API `context` field must be present and start with a slash (`/`). |
| [api-context-no-special-characters](#api-context-no-special-characters) | Error | API `context` should not contain whitespaces or special characters except for hyphens, underscores, periods, and forward slashes. |
| [api-context-length](#api-context-length) | Error | API `context` should be between 1 and 200 characters. |
| [api-context-cannot-end-with-slash](#api-context-cannot-end-with-slash) | Error | API `context` should not end with a trailing slash (`/`). |
| [api-version-required](#api-version-required) | Error | The API `version` must be specified and not empty. |
| [api-business-owner-email-format](#api-business-owner-email-format) | Error | The business owner's email must be in a valid format. |
| [api-technical-owner-email-format](#api-technical-owner-email-format) | Error | The technical owner's email must be in a valid format. |
| [api-endpointConfig-production-required](#api-endpointconfig-production-required) | Error | A production endpoint must be provided. |
| [api-resources-security-required](#api-resources-security-required) | Error | Security must be enabled for all API resources. |
| [api-name-cannot-contain-version](#api-name-cannot-contain-version) | Warn | API `name` should not contain a semantic version substring (e.g., x.y.z). |
| [api-context-cannot-contain-version](#api-context-cannot-contain-version) | Warn | API `context` should not contain the version (e.g., x.y.z). |
| [api-no-unlimited-business-plan](#api-no-unlimited-business-plan) | Warn | API should not have an unlimited business plan. |
| [api-no-insecure-transports](#api-no-insecure-transports) | Warn | API should not allow insecure transports. |
| [api-tags](#api-tags) | Warn | API should have tags. |
| [api-tags-count](#api-tags-count) | Warn | API should have at least one tag. |
| [api-tags-alphabetical](#api-tags-alphabetical) | Warn | API tags should be listed in alphabetical order. |
| [api-business-owner-email](#api-business-owner-email) | Warn | The business owner's email must be provided. |
| [api-business-owner](#api-business-owner) | Warn | The business owner must be set. |
| [api-technical-owner](#api-technical-owner) | Warn | The technical owner must be set. |
| [api-technical-owner-email](#api-technical-owner-email) | Warn | The technical owner's email must be provided. |
| [api-no-unlimited-throttling-policy](#api-no-unlimited-throttling-policy) | Warn | API should not have an unlimited throttling policy. |
| [api-endpointConfig-sandbox-suggestion](#api-endpointconfig-sandbox-suggestion) | Info | A sandbox endpoint for testing is recommended. |

## Detailed Rules

### api-name-required

**Description:** API `name` is required.

**Severity:** Error

**Invalid Example**

```yaml
data:
  description: Sample description.
```

**Valid Example**

```yaml
data:
  name: CustomerProfileAPI
  description: Sample description.
```

---

### api-name-no-special-characters

**Description:** API `name` should not contain whitespaces or special characters except for hyphens, underscores, and periods.

**Severity:** Error

**Invalid Example**

```yaml
data:
  name: Customer Profile!@#
  description: Sample description.
```

**Valid Example**

```yaml
data:
  name: Customer_Profile-API
  description: Sample description.
```

---

### api-name-length

**Description:** API `name` should be between 1 and 50 characters.

**Severity:** Error

**Invalid Example**

```yaml
data:
  name: 
  description: Sample description.
```

**Valid Example**

```yaml
data:
  name: CustomerProfileAPI
  description: Sample description.
```

---

### api-context-required

**Description:** The API `context` field must be present and start with a slash (`/`).

**Severity:** Error

**Invalid Example**

```yaml
data:
  context: customer
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  context: /customer
  description: Sample API description.
```

---

### api-context-no-special-characters

**Description:** API `context` should not contain whitespaces or special characters except for hyphens, underscores, periods, and forward slashes.

**Severity:** Error

**Invalid Example**

```yaml
data:
  context: /customer api@!
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  context: /customer_api
  description: Sample API description.
```

---

### api-context-length

**Description:** API `context` should be between 1 and 200 characters.

**Severity:** Error

**Invalid Example**

```yaml
data:
  context: 
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  context: /customer-api
  description: Sample API description.
```

---

### api-context-cannot-end-with-slash

**Description:** API context should not end with a trailing slash (`/`).

**Severity:** Error

**Invalid Example**

```yaml
data:
  context: /customer-api/
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  context: /customer-api
  description: Sample API description.
```

---

### api-version-required

**Description:** The API version must be specified and not empty.

**Severity:** Error

**Invalid Example**

```yaml
data:
  version: 
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  version: 1.0.0
  description: Sample API description.
```

---

### api-business-owner-email-format

**Description:** The business owner's email must be in a valid format.

**Severity:** Error

**Invalid Example**

```yaml
data:
  businessInformation:
    businessOwnerEmail: invalid-email
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  businessInformation:
    businessOwnerEmail: owner@example.com
  description: Sample API description.
```

---

### api-technical-owner-email-format

**Description:** The technical owner's email must be in a valid format.

**Severity:** Error

**Invalid Example**

```yaml
data:
  businessInformation:
    technicalOwnerEmail: "invalid-email"
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  businessInformation:
    technicalOwnerEmail: "tech@example.com"
  description: Sample API description.
```

---

### api-endpointConfig-production-required

**Description:** A production endpoint must be provided.

**Severity:** Error

**Invalid Example**

```yaml
data:
  endpointConfig: 
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  endpointConfig:
    production_endpoints:
      url: "https://api.example.com"
  description: Sample API description.
```

---

### api-resources-security-required

**Description:** Security must be enabled for all API resources.

**Severity:** Error

**Invalid Example**

```yaml
data:
  operations:
    - name: getCustomerData
      authType: None
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  operations:
    - name: getCustomerData
      authType: OAuth2
  description: Sample API description.
```

### api-name-cannot-contain-version

**Description:** API `name` should not contain a semantic version substring (e.g., x.y.z).

**Severity:** Warn

**Invalid Example**

```yaml
data:
  name: CustomerProfileAPI-1.2.3
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  name: CustomerProfileAPI
  description: Sample API description.
```

---

### api-context-cannot-contain-version

**Description:** API context should not contain the version (e.g., x.y.z).

**Severity:** Warn

**Invalid Example**

```yaml
data:
  context: /customer/1.2.3
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  context: /customer
  description: Sample API description.
```

---

### api-no-unlimited-business-plan

**Description:** API should not have an unlimited business plan.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  policies:
    - Unlimited
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  policies:
    - Gold
    - Silver
  description: Sample API description.
```

---

### api-no-insecure-transports

**Description:** API should not allow insecure transports.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  transport:
    - http
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  transport:
    - https
  description: Sample API description.
```

---

### api-tags

**Description:** API should have tags.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  tags: []
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  tags:
    - customer
    - finance
  description: Sample API description.
```

---

### api-tags-count

**Description:** API should have at least one tag.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  tags: []
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  tags:
    - finance
  description: Sample API description.
```

---

### api-tags-alphabetical

**Description:** API tags should be listed in alphabetical order.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  tags:
    - finance
    - customer
    - analytics
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  tags:
    - analytics
    - customer
    - finance
  description: Sample API description.
```

---

### api-business-owner-email

**Description:** The business owner's email must be provided.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  businessInformation:
    businessOwnerEmail: 
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  businessInformation:
    businessOwnerEmail: owner@example.com
  description: Sample API description.
```

---

### api-business-owner

**Description:** The business owner must be set.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  businessInformation:
    businessOwner: 
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  businessInformation:
    businessOwner: John Doe
  description: Sample API description.
```

---

### api-technical-owner

**Description:** The technical owner must be set.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  businessInformation:
    technicalOwner: 
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  businessInformation:
    technicalOwner: Jane Doe
  description: Sample API description.
```

---

### api-technical-owner-email

**Description:** The technical owner's email must be provided.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  businessInformation:
    technicalOwnerEmail: 
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  businessInformation:
    technicalOwnerEmail: tech@example.com
  description: Sample API description.
```

---

### api-no-unlimited-throttling-policy

**Description:** API should not have an unlimited throttling policy.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  operations:
    - name: getCustomerData
      throttlingPolicy: Unlimited
  description: Sample API description.
```

**Valid Example**

```yaml
data:
  operations:
    - name: getCustomerData
      throttlingPolicy: Gold
  description: Sample API description.
```

---

### api-endpointConfig-sandbox-suggestion

**Description:** A sandbox endpoint for testing is recommended.

**Severity:** Info


