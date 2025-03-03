# WSO2 REST API Design Guidelines

A set of guidelines focused on enforcing uniformity in API style, including naming conventions, formatting, and documentation to ensure clarity and maintainability across all APIs.

## Rules Overview

| Rule Name | Severity Level | Description |
|-----------|----------|-------------|
| [operation-operationId-valid-in-url](#operation-operationid-valid-in-url) | Error | Operation IDs must not contain characters that are invalid for URLs. |
| [path-declarations-must-exist](#path-declarations-must-exist) | Error | Path parameter declarations must not be empty. |
| [paths-no-trailing-slash](#paths-no-trailing-slash) | Error | Paths must not end with a trailing slash. |
| [oas2-api-schemes](#oas2-api-schemes) | Error | OpenAPI 2 APIs must specify `schemes` with valid transfer protocols. |
| [array-items](#array-items) | Error | Schemas with `type: array` must have a sibling `items` field. |
| [path-casing](#path-casing) | Error | Paths must follow `kebab-case`, using hyphens to separate words. |
| [paths-no-http-verbs](#paths-no-http-verbs) | Error | Paths must not contain HTTP verbs such as `get`, `delete`, or `put`. |
| [contact-url](#contact-url) | Warn | The `contact` object should have a valid organization URL. |
| [contact-email](#contact-email) | Warn | The `contact` object should have a valid email. |
| [info-contact](#info-contact) | Warn | The `info` object should include a `contact` object. |
| [info-description](#info-description) | Warn | The `info` object should have a `description` field. |
| [info-license](#info-license) | Warn | The `info` object should have a `license` field. |
| [license-url](#license-url) | Warn | The `license` object should include a valid URL. |
| [no-eval-in-markdown](#no-eval-in-markdown) | Warn | Markdown descriptions should not contain `eval()` functions. |
| [no-script-tags-in-markdown](#no-script-tags-in-markdown) | Warn | Markdown descriptions should not contain `<script>` tags. |
| [openapi-tags-alphabetical](#openapi-tags-alphabetical) | Warn | Global tags should be in alphabetical order. |
| [openapi-tags](#openapi-tags) | Warn | At least one global tag should be specified in the OpenAPI Document. |
| [operation-description](#operation-description) | Warn | Each operation should have a description. |
| [operation-operationId](#operation-operationId) | Warn | All operations should have an `operationId`. |
| [operation-tags](#operation-tags) | Warn | Each operation should have at least one tag. |
| [contact-name](#contact-name) | Warn | The `contact` object should have an organization name. |
| [path-keys-no-trailing-slash](#path-keys-no-trailing-slash) | Warn | Path keys should not end in a forward slash. |
| [path-not-include-query](#path-not-include-query) | Warn | Paths should not include query string items. |
| [tag-description](#tag-description) | Warn | Tags at the global level should have a description. |
| [parameter-description](#parameter-description) | Warn | All `parameter` objects should have a description. |
| [oas2-anyOf](#oas2-anyOf) | Warn | The `anyOf` keyword is not supported in OAS2. |
| [oas2-oneOf](#oas2-oneOf) | Warn | The `oneOf` keyword is not supported in OAS2. |
| [oas3-examples-value-or-externalValue](#oas3-examples-value-or-externalValue) | Warn | The `examples` object should include either `value` or `externalValue`, but not both. |
| [path-parameters-on-path-only](#path-parameters-on-path-only) | Warn | Path parameters should be defined at the path level, not the operation level. |
| [paths-no-query-params](#paths-no-query-params) | Warn | Paths should not contain query parameters. |
| [resource-names-plural](#resource-names-plural) | Warn | Resource names should generally be plural. |
| [paths-avoid-special-characters](#paths-avoid-special-characters) | Warn | Paths should not contain special characters like `$`, `&`, `+`, `,`, `;`, `=`, `?`, or `@`. |

## Detailed Rules

### operation-operationId-valid-in-url

**Description:** Operation IDs must not contain characters that are invalid for URLs.

**Severity:** Error

**Invalid Example**

- The `operationId` in this example includes a pipe and space, which are invalid for URLs.

```json
{
  "/users": {
    "get": {
      "operationId": "invalid|operationID"
    }
  }
}
```

**Valid Example**

- This `operationId` is valid for URLs.

```json
{
  "/users": {
    "get": {
      "operationId": "this-must-be-unique"
    }
  }
}
```

---

### path-declarations-must-exist

**Description:** Path parameter declarations must not be empty.

**Severity:** Error

**Invalid Example**

`/users/{}`

**Valid Example**

`/users/{userId}`

---


### paths-no-trailing-slash

**Description:** Paths must not end with a trailing slash. `/users` and `/users/` are separate paths. It's considered bad practice for them to differ based only on a trailing slash. It's usually preferred to not have a trailing slash.

**Severity:** Error

**Invalid Example**

- The `users` path ends with a slash.

```json
{
  "/users/": {
    "post": {}
  }
}
```

**Valid Example**

```json
{
  "/user": {
    "post": {}
  }
}
```

---

### oas2-api-schemes

**Description:** OpenAPI 2 host `schemes` reflect the transfer protocol of the API. 
Host schemes must be present and an array with one or more of these values: 
`http`, `https`, `ws`, or `wss`.

**Severity:** Error

**Valid Example**

- This example shows that host schemes are `http` and `https`.

```json
{
  "schemes": [
    "http",
    "https"
  ]
}
```

---

### array-items

**Description:** Schemas with `type: array`, require a sibling `items` field.

**Severity:** Error

**Recommended:** Yes

**Good Example**

```yaml
TheGoodModel:
  type: object
  properties:
    favoriteColorSets:
      type: array
      items:
        type: array
        items: {}
```

**Bad Example**

```yaml
TheBadModel:
  type: object
  properties:
    favoriteColorSets:
      type: array
      items:
        type: array
```

---

### path-casing

**Description:** Paths must be `kebab-case`, with hyphens separating words.

**Severity:** Error

**Invalid Example**

- `userInfo` must be separated with a hyphen.

```json
{
    "/userInfo": {
        "post: }
       ....
}
``` 

**Valid Example**

```json
{
    "/user-info": {
       "post: }
       ....
}
```

---

### paths-no-http-verbs

**Description:** Verbs such as `get`, `delete`, and `put` must not be included in paths because this information is conveyed by the HTTP method.

**Severity:** Error

**Invalid Example**

- The path contains the verb `get`. 

```json
{
    "/getUsers": {
       "post: }
       ....
}
``` 

**Valid Example**

```json
{
    "/user": {
       "post: }
       ....
}
```

---

### contact-url

**Description:** The `contact` object should have a valid organization URL. 

**Severity:** Warn

**Valid Example**

```json
{
  "contact": {
     ... ,
     "url": "https://acme.com",
     ... 
  },
```

### contact-email

**Description:** The `contact` object should have a valid email. 

**Severity:** Warn

**Valid Example**

```json
{
  "contact": {
     ... ,
     "email": "support.contact@acme.com"
  },
```

### info-contact

**Description:** The `info` object should include a `contact` object.

**Severity:** Warn

**Valid Example**

```json
{
  "info": {
    ... ,
    "contact": {
      "name": "ACME Corporation",
      "url": "https://acme.com",
      "email": "support.contact@acme.com"
    }
  }
}
```

### info-description

**Description:** The `info` object should have a `description` object.

**Severity:** Warn

**Valid Example**

```json
{
  "info": {
     ... ,
     "description": "This describes my API."
  }
}
```

### info-license

**Description:** The `info` object should have a `license` object.

**Severity:** Warn

**Valid Example**

```json
{
  "info": {
    ... ,
    "license": {
      "name": "Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)",
      "url": "https://creativecommons.org/licenses/by-sa/4.0/"
    }
  }
}
```

### license-url

**Description:** The `license` object should include a valid url.

**Severity:** Warn

**Valid Example**

```json
{
  "license": {
    "name": "Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)",
    "url": "https://creativecommons.org/licenses/by-sa/4.0/"
  }
}
```

### no-eval-in-markdown

**Description:** Markdown descriptions should not contain [`eval()` functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/eval),
which pose a security risk.

**Severity:** Warn

**Invalid Example**

```json
{
  "info": {
    ... ,
    "description": "API for users. eval()"
  }
}
```

### no-script-tags-in-markdown

**Description:** Markdown descriptions should not contain `script` tags, which pose a security risk.

**Severity:** Warn

**Invalid Example**

```json
{
  "info": {
    ... ,
    "description": "API for users. <script>alert(\"You are Hacked\");</script>"
  }
}
```

### openapi-tags-alphabetical

**Description:** Global tags specified at the root OpenAPI Document level should be in alphabetical order based on the `name` property.

**Severity:** Warn

**Invalid Example**

```json
{
  "tags":[
    {
      "name":"Z Global Tag"
    },
    {
      "name":"A Global Tag"
    }
  ]
}
```

**Valid Example**

```json
{
  "tags":[
    {
      "name":"A Global Tag"
    },
    {
      "name":"Z Global Tag"
    }
  ]
}
```

### openapi-tags

**Description:** At least one global tag should be specified at the root OpenAPI Document level.

**Severity:** Warn

**Valid Example**

```json
{
  "tags":[
    {
      "name":"Global Tag #1"
    },
    {
      "name":"Global Tag #2"
    }
  ]
}
```

### operation-description

**Description:** Each operation should have a description.

**Severity:** Warn

**Valid Example**

```json
{
  "get": {
    "description": "Get a list of users."
  }
}
```

### operation-operationId

**Description:** All operations should have an `operationId`.

**Severity:** Warn

**Valid Example**

```json
{
  "get": {
    "summary": "Get users",
    "operationId": "get-users"
  }
}
```

### operation-tags

**Description:** At least one tag should be defined for each operation.

**Severity:** Warn

**Valid Example**

```json
{
  "get": {
    "tags": ["Users"]
  }
}
```

### contact-name

**Description:** The `contact` object should have an organization name.

**Severity:** Warn

**Valid Example**

```json
{
  "contact": {
    "name": "ACME Corporation"
  }
}
```

### path-keys-no-trailing-slash

**Description:** Path keys should not end in forward slashes. This is a best practice for working with web tooling, such as mock servers, code generators, application frameworks, and more.

**Severity:** Warn

**Invalid Example**

```json
{
  "/users/": {
  }
}
```

**Valid Example**

```json
{
  "/users": {
  }
}
```

### path-not-include-query

**Description:** Paths should not include `query` string items. Instead, add them as parameters with `in: query`.

**Severity:** Warn

**Invalid Example**

```json
{
  "/users/{?id}": {
  }
}
```

**Valid Example**

```json
{
  "parameters": [
    {
      "schema": {
        "type": "string"
      },
      "name": "id",
      "in": "path",
      "required": true,
      "description": "User's ID"
    }
  ]
}
```

### tag-description

**Description:** Tags defined at the global level should have a description.

**Severity:** Warn

**Valid Example**

```json
{
  "tags": [
    {
      "name": "Users",
      "description": "End-user information"
    }
  ]
}
```

### parameter-description

**Description:** All `parameter` objects should have a description.

**Severity:** Warn

**Valid Example**

```json
{
  "parameters": [
    {
      "schema": {
        "type": "integer"
      },
      ... ,
      ... ,
      "description": "The number of days to include in the response."
    }
  ]
}
```

### oas2-anyOf

**Description:** The `anyOf` keyword is not supported in OAS2. Only `allOf` is supported.

**Severity:** Warn

**Invalid Example**

```json
{
  "schema": {
    "anyOf": [
      {
        "properties": {
          "firstName": {
            "type": "string"
          },
          "lastName": {
            "type": "string"
          }
        }
      },
      {}
    ]
  }
}
```

**Valid Example**

```json
{
  "schema": {
    "type": "object",
    "properties": {
      "firstName": {
        "type": "string"
      },
      "lastName": {
        "type": "string"
      }
    }
  }
}
```

### oas2-oneOf

**Description:** The `oneOf` keyword is not supported in OAS2. Only `allOf` is supported.

**Severity:** Warn

**Invalid Example**

```json
{
  "schema": {
    "oneOf": [
      {
        "properties": {
          "firstName": {
            "type": "string"
          },
          "lastName": {
            "type": "string"
          }
        }
      },
      {}
    ]
  }
}
```

**Valid Example**

```json
{
  "schema": {
    "type": "object",
    "properties": {
      "firstName": {
        "type": "string"
      },
      "lastName": {
        "type": "string"
      }
    }
  }
}
```

### oas3-examples-value-or-externalValue

**Description:** The `examples` object should include a `value` or `externalValue` field, but cannot include both.

**Severity:** Warn

**Invalid Example**

- This example includes both a `value` field and an `externalValue` field.

```json
{
  "examples": {
    "example-1": {
      "value": {
        "id": "string",
        "name": "string"
      },
      "externalValue": {
        "id": "string",
        "name": "string"
      }
    }
  }
}
```

**Valid Example**

- This example includes only a `value` field.

```json
{
  "examples": {
    "example-1": {
      "value": {
        "id": "string",
        "name": "string"
      }
    }
  }
}
```

### path-parameters-on-path-only

**Description:** Path parameters should be defined on the path level instead of the operation level.

**Severity:** Warn

**Invalid Example**

- The `user_id` path parameter on line 8 should not be included with the `patch` operation.

```json
{      
  "patch": {
    "parameters": [
      {
        "schema": {
          "type": "integer"
        },
        "name": "user_id",
        "in": "path"
      }
    ]
  }
}
```

**Valid Example**

- The `user-id` path parameter is correctly located at the path level.

```json
{
  "paths": {
    "/users/{userId}": {
      "parameters": [
        {
          "schema": {
            "type": "integer"
          },
          "name": "user_id",
          "in": "path"
        }
      ]
    }
  }
}
```

### paths-no-query-params

**Description:** Paths should not have query parameters in them. They should be defined separately in the OpenAPI.

**Severity:** Warn

**Invalid Example**

```json
{
  "/users/{?id}": {
```

**Valid Example**

```json
{
  "parameters": [
    {
      "schema": {
        "type": "string"
      },
      "name": "id",
      "in": "path",
      "required": true,
      "description": "User's ID"
    }
  ]
}
```

### resource-names-plural

**Description:** Resource names should generally be plural. 

**Severity:** Warn

**Invalid Example**

```json
{
    "paths": {
      "/user": 
    }
  }
```

**Valid Example**

```json
{
    "paths": {
      "/users": 
    }
}
```

### paths-avoid-special-characters

**Description:** Paths should not contain special characters, such as `$` `&` `+` `,` `;` `=` `?` and `@%`.

**Severity:** Warn

**Invalid Example**

- The path contains an ampersand. 

```json
{
    "/user&info": {
       "post: }
       ....
}
``` 

**Valid Example**

```json
{
    "/user": {
       "post: }
       ....
}
```