# WSO2 API Management Guidelines

A guide detailing best practices for creating robust, scalable, and secure APIs, ensuring alignment with industry standards for optimal design.

### ❌ api-name-required

API name is required.

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

### ❌ api-name-no-special-characters

API name should not contain whitespaces or special characters except for hyphens, underscores, and periods.


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

### ❌ api-name-length

API name should be between 1 and 50 characters.

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

### ❌ api-context-required

The API context field must be present and start with a slash (`/`).

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

### ❌ api-context-no-special-characters

API context should not contain whitespaces or special characters except for hyphens, underscores, periods, and forward slashes.

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

### ❌ api-context-length

API context should be between 1 and 200 characters.

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

### ❌ api-context-cannot-end-with-slash

API context should not end with a trailing slash (`/`).

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

### ❌ api-version-required

The API version must be specified and not empty.

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

### ❌ api-business-owner-email-format

The business owner's email must be in a valid format.

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

### ❌ api-technical-owner-email-format

The technical owner's email must be in a valid format.

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

### ❌ api-endpointConfig-production-required

A production endpoint must be provided.

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

### ❌ api-resources-security-required

Security must be enabled for all API resources.

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

### ⚠️ api-name-cannot-contain-version

API name should not contain a semantic version substring (e.g., x.y.z).

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

### ⚠️ api-context-cannot-contain-version

API context should not contain the version (e.g., x.y.z).

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

### ⚠️ api-no-unlimited-business-plan

API should not have an unlimited business plan.

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

### ⚠️ api-no-insecure-transports

API should not allow insecure transports.

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

### ⚠️ api-tags

API should have tags.

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

### ⚠️ api-tags-count

API should have at least one tag.

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

### ⚠️ api-tags-alphabetical

API tags should be listed in alphabetical order.

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

### ⚠️ api-business-owner-email

The business owner's email must be provided.

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

### ⚠️ api-business-owner

The business owner must be set.

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

### ⚠️ api-technical-owner

The technical owner must be set.

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

### ⚠️ api-technical-owner-email

The technical owner's email must be provided.

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

### ⚠️ api-no-unlimited-throttling-policy

API should not have an unlimited throttling policy.

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

### ℹ️ api-endpointConfig-sandbox-suggestion

A sandbox endpoint for testing is recommended.


