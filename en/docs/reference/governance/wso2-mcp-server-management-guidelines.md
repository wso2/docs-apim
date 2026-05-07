# WSO2 MCP Server Management Guidelines

A guide detailing best practices for creating robust, scalable, and secure MCP Servers, ensuring alignment with industry standards for optimal design.

| Rule Name | Severity | Description |
|-----------|----------|-------------|
| [mcp-name-required](#mcp-name-required) | Error | MCP Server `name` is required. |
| [mcp-name-no-special-characters](#mcp-name-no-special-characters) | Error | MCP Server `name` must use only letters, numbers, hyphens, underscores, and periods. |
| [mcp-name-length](#mcp-name-length) | Error | MCP Server `name` must be between 1 and 50 characters. |
| [mcp-name-cannot-contain-version](#mcp-name-cannot-contain-version) | Warn | MCP Server `name` should not contain a semantic version substring (for example, `x.y.z`). |
| [mcp-context-required](#mcp-context-required) | Error | MCP Server `context` is required and must start with `/`. |
| [mcp-context-no-special-characters](#mcp-context-no-special-characters) | Error | MCP Server `context` must use only supported path characters. |
| [mcp-context-length](#mcp-context-length) | Error | MCP Server `context` must be between 1 and 200 characters. |
| [mcp-context-cannot-end-with-slash](#mcp-context-cannot-end-with-slash) | Error | MCP Server `context` must not end with `/`. |
| [mcp-context-cannot-contain-version](#mcp-context-cannot-contain-version) | Warn | MCP Server `context` should not contain a semantic version substring. |
| [mcp-version-required](#mcp-version-required) | Error | MCP Server `version` is required. |
| [mcp-tool-name-character-length](#mcp-tool-name-character-length) | Error | When `feature` is `TOOL`, `target` must be present and 1 to 128 characters long. |
| [mcp-tool-name-allowed-characters](#mcp-tool-name-allowed-characters) | Error | When `feature` is `TOOL`, `target` may contain only ASCII letters, digits, underscores, hyphens, and periods. |
| [mcp-no-insecure-transports](#mcp-no-insecure-transports) | Warn | MCP Server should not use insecure transports. |
| [mcp-tags](#mcp-tags) | Warn | MCP Server should have tags. |
| [mcp-tags-count](#mcp-tags-count) | Warn | MCP Server should have at least one tag. |
| [mcp-business-owner-email](#mcp-business-owner-email) | Warn | Business owner email should be provided. |
| [mcp-business-owner-email-format](#mcp-business-owner-email-format) | Error | Business owner email must be in a valid format. |
| [mcp-business-owner](#mcp-business-owner) | Warn | Business owner should be provided. |
| [mcp-technical-owner](#mcp-technical-owner) | Warn | Technical owner should be provided. |
| [mcp-technical-owner-email](#mcp-technical-owner-email) | Warn | Technical owner email should be provided. |
| [mcp-technical-owner-email-format](#mcp-technical-owner-email-format) | Error | Technical owner email must be in a valid format. |
| [mcp-resources-security-required](#mcp-resources-security-required) | Error | Security must be enabled for all MCP Server operations. |
| [mcp-operations-description-defined](#mcp-operations-description-defined) | Error | All MCP Server operations must define a `description`. |
| [mcp-operations-description-provided](#mcp-operations-description-provided) | Error | All MCP Server operations must provide a non-empty `description`. |

## Detailed Rules

### mcp-name-required

**Description:** MCP Server `name` is required.

**Severity:** Error

**Invalid Example**

```yaml
data:
  context: /book-catalog
  version: 1.0.0
```

**Valid Example**

```yaml
data:
  name: BookCatalog
  context: /book-catalog
  version: 1.0.0
```

---

### mcp-name-no-special-characters

**Description:** MCP Server `name` should not contain whitespaces or special characters except for hyphens, underscores, and periods.

**Severity:** Error

**Invalid Example**

```yaml
data:
  name: Book Catalog!
  context: /book-catalog
```

**Valid Example**

```yaml
data:
  name: Book_Catalog-Service
  context: /book-catalog
```

---

### mcp-name-length

**Description:** MCP Server `name` should be between 1 and 50 characters.

**Severity:** Error

**Invalid Example**

```yaml
data:
  name: ""
  context: /book-catalog
```

**Valid Example**

```yaml
data:
  name: BookCatalog
  context: /book-catalog
```

---

### mcp-name-cannot-contain-version

**Description:** MCP Server `name` should not contain a semantic version substring such as `1.2.3`.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  name: BookCatalog-1.2.3
  context: /book-catalog
```

**Valid Example**

```yaml
data:
  name: BookCatalog
  context: /book-catalog
```

---

### mcp-context-required

**Description:** MCP Server `context` must be present and begin with a slash (`/`).

**Severity:** Error

**Invalid Example**

```yaml
data:
  name: BookCatalog
  context: book-catalog
```

**Valid Example**

```yaml
data:
  name: BookCatalog
  context: /book-catalog
```

---

### mcp-context-no-special-characters

**Description:** MCP Server `context` should not contain whitespaces or unsupported special characters. Letters, numbers, forward slashes, curly braces, hyphens, underscores, and periods are allowed.

**Severity:** Error

**Invalid Example**

```yaml
data:
  context: /book catalog!
  version: 1.0.0
```

**Valid Example**

```yaml
data:
  context: /book-catalog/{id}
  version: 1.0.0
```

---

### mcp-context-length

**Description:** MCP Server `context` should be between 1 and 200 characters.

**Severity:** Error

**Invalid Example**

```yaml
data:
  context: ""
  version: 1.0.0
```

**Valid Example**

```yaml
data:
  context: /book-catalog
  version: 1.0.0
```

---

### mcp-context-cannot-end-with-slash

**Description:** MCP Server `context` should not end with a trailing slash (`/`).

**Severity:** Error

**Invalid Example**

```yaml
data:
  context: /book-catalog/
  version: 1.0.0
```

**Valid Example**

```yaml
data:
  context: /book-catalog
  version: 1.0.0
```

---

### mcp-context-cannot-contain-version

**Description:** MCP Server `context` should not contain a semantic version substring such as `1.2.3`.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  context: /book-catalog/1.2.3
  version: 1.0.0
```

**Valid Example**

```yaml
data:
  context: /book-catalog
  version: 1.0.0
```

---

### mcp-version-required

**Description:** MCP Server `version` must be specified and not be empty.

**Severity:** Error

**Invalid Example**

```yaml
data:
  name: BookCatalog
  version: ""
```

**Valid Example**

```yaml
data:
  name: BookCatalog
  version: 1.0.0
```

---

### mcp-tool-name-character-length

**Description:** When an operation `feature` is `TOOL`, its `target` must be present and between 1 and 128 characters long.

**Severity:** Error

**Invalid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: ""
      authType: Application & Application User
```

**Valid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: listBooks
      authType: Application & Application User
```

---

### mcp-tool-name-allowed-characters

**Description:** When an operation `feature` is `TOOL`, its `target` may contain only ASCII letters, digits, underscores, hyphens, and periods.

**Severity:** Error

**Invalid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: list books!
      authType: Application & Application User
```

**Valid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: list_books.v1
      authType: Application & Application User
```

---

### mcp-no-insecure-transports

**Description:** MCP Server should not allow insecure transports such as `http`.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  transport:
    - http
```

**Valid Example**

```yaml
data:
  transport:
    - https
```

---

### mcp-tags

**Description:** MCP Server should have tags.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  name: BookCatalog
  version: 1.0.0
```

**Valid Example**

```yaml
data:
  name: BookCatalog
  version: 1.0.0
  tags:
    - books
    - catalog
```

---

### mcp-tags-count

**Description:** MCP Server should have at least one tag.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  tags: []
```

**Valid Example**

```yaml
data:
  tags:
    - books
```

---

### mcp-business-owner-email

**Description:** The business owner's email should be provided.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  businessInformation:
    businessOwnerEmail: ""
```

**Valid Example**

```yaml
data:
  businessInformation:
    businessOwnerEmail: owner@example.com
```

---

### mcp-business-owner-email-format

**Description:** The business owner's email must be in a valid format.

**Severity:** Error

**Invalid Example**

```yaml
data:
  businessInformation:
    businessOwnerEmail: owner-at-example.com
```

**Valid Example**

```yaml
data:
  businessInformation:
    businessOwnerEmail: owner@example.com
```

---

### mcp-business-owner

**Description:** The business owner should be provided.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  businessInformation:
    businessOwner: ""
```

**Valid Example**

```yaml
data:
  businessInformation:
    businessOwner: ProductTeam
```

---

### mcp-technical-owner

**Description:** The technical owner should be provided.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  businessInformation:
    technicalOwner: ""
```

**Valid Example**

```yaml
data:
  businessInformation:
    technicalOwner: PlatformEngineering
```

---

### mcp-technical-owner-email

**Description:** The technical owner's email should be provided.

**Severity:** Warn

**Invalid Example**

```yaml
data:
  businessInformation:
    technicalOwnerEmail: ""
```

**Valid Example**

```yaml
data:
  businessInformation:
    technicalOwnerEmail: tech@example.com
```

---

### mcp-technical-owner-email-format

**Description:** The technical owner's email must be in a valid format.

**Severity:** Error

**Invalid Example**

```yaml
data:
  businessInformation:
    technicalOwnerEmail: invalid-email
```

**Valid Example**

```yaml
data:
  businessInformation:
    technicalOwnerEmail: tech@example.com
```

---

### mcp-resources-security-required

**Description:** Security must be enabled for all MCP Server operations.

**Severity:** Error

**Invalid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: listBooks
      authType: None
```

**Valid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: listBooks
      authType: Application & Application User
```

---

### mcp-operations-description-defined

**Description:** Every MCP Server operation must define a `description` field.

**Severity:** Error

**Invalid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: listBooks
      authType: Application & Application User
```

**Valid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: listBooks
      authType: Application & Application User
      description: Retrieve the available books in the catalog.
```

---

### mcp-operations-description-provided

**Description:** Every MCP Server operation must provide a non-empty `description`.

**Severity:** Error

**Invalid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: listBooks
      authType: Application & Application User
      description: ""
```

**Valid Example**

```yaml
data:
  operations:
    - feature: TOOL
      target: listBooks
      authType: Application & Application User
      description: Retrieve the available books in the catalog.
```
