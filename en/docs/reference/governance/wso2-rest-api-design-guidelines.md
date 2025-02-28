# WSO2 REST API Design Guidelines

A set of guidelines focused on enforcing uniformity in API style, including naming conventions, formatting, and documentation to ensure clarity and maintainability across all APIs.

### ❌ operation-operationId-valid-in-url

Operation IDs must not contain characters that are invalid for URLs.

**Invalid Example**

The `operationId` in this example includes a pipe and space, which are invalid for URLs.

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

This `operationId` is valid for URLs.

```json
{
  "/users": {
    "get": {
      "operationId": "this-must-be-unique"
    }
  }
}
```

### ❌ path-declarations-must-exist

Path parameter declarations must not be empty.

**Invalid Example**

`/users/{}`

**Valid Example**

`/users/{userId}`


### ❌ paths-no-trailing-slash

Paths must not end with a trailing slash.

`/users` and `/users/` are separate paths. It's considered bad practice for them to differ based only on a trailing slash. It's usually preferred to not have a trailing slash.

**Invalid Example**

The `users` path ends with a slash.

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

### ❌ oas2-api-schemes

OpenAPI 2 host `schemes` reflect the transfer protocol of the API. 
Host schemes must be present and an array with one or more of these values: 
`http`, `https`, `ws`, or `wss`.

**Valid Example**

This example shows that host schemes are `http` and `https`.

```json
{
  "schemes": [
    "http",
    "https"
  ]
}
```

### ❌ array-items

Schemas with `type: array`, require a sibling `items` field.

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

### ❌ path-casing

Paths must be `kebab-case`, with hyphens separating words.

**Invalid Example**

`userInfo` must be separated with a hyphen.

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

### ❌ paths-no-http-verbs

Verbs such as `get`, `delete`, and `put` must not be included in paths because this information is conveyed by the HTTP method.

**Invalid Example**

The path contains the verb `get`. 

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

### ⚠️ contact-url

The `contact` object should have a valid organization URL. 

**Valid Example**

```json
{
  "contact": {
     ... ,
     "url": "https://acme.com",
     ... 
  },
```

### ⚠️ contact-email

The `contact` object should have a valid email. 

**Valid Example**

```json
{
  "contact": {
     ... ,
     "email": "support.contact@acme.com"
  },
```

### ⚠️ info-contact

The `info` object should include a `contact` object.

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

### ⚠️ info-description

The `info` object should have a `description` object.

**Valid Example**

```json
{
  "info": {
     ... ,
     "description": "This describes my API."
  }
}
```

### ⚠️ info-license

The `info` object should have a `license` object.

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

### ⚠️ license-url

The `license` object should include a valid url.

**Valid Example**

```json
{
  "license": {
    "name": "Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)",
    "url": "https://creativecommons.org/licenses/by-sa/4.0/"
  }
}
```

### ⚠️ no-eval-in-markdown

Markdown descriptions should not contain [`eval()` functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/eval),
which pose a security risk.

**Invalid Example**

```json
{
  "info": {
    ... ,
    "description": "API for users. eval()"
  }
}
```

### ⚠️ no-script-tags-in-markdown

Markdown descriptions should not contain `script` tags, which pose a security risk.

**Invalid Example**

```json
{
  "info": {
    ... ,
    "description": "API for users. <script>alert(\"You are Hacked\");</script>"
  }
}
```

### ⚠️ openapi-tags-alphabetical

Global tags specified at the root OpenAPI Document level should be in alphabetical order based on the `name` property.

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

### ⚠️ openapi-tags

At least one global tag should be specified at the root OpenAPI Document level.

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

### ⚠️ operation-description

Each operation should have a description.

**Valid Example**

```json
{
  "get": {
    "description": "Get a list of users."
  }
}
```

### ⚠️ operation-operationId

All operations should have an `operationId`.

**Valid Example**

```json
{
  "get": {
    "summary": "Get users",
    "operationId": "get-users"
  }
}
```

### ⚠️ operation-tags

At least one tag should be defined for each operation.

**Valid Example**

```json
{
  "get": {
    "tags": ["Users"]
  }
}
```

### ⚠️ contact-name

The `contact` object should have an organization name.

**Valid Example**

```json
{
  "contact": {
    "name": "ACME Corporation"
  }
}
```

### ⚠️ path-keys-no-trailing-slash

Path keys should not end in forward slashes. This is a best practice for working with web tooling, such as mock servers, code generators, application frameworks, and more.

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

### ⚠️ path-not-include-query

Paths should not include `query` string items. Instead, add them as parameters with `in: query`.

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

### ⚠️ tag-description

Tags defined at the global level should have a description.

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

### ⚠️ parameter-description

All `parameter` objects should have a description.

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

### ⚠️ oas2-anyOf

The `anyOf` keyword is not supported in OAS2. Only `allOf` is supported.

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

### ⚠️ oas2-oneOf

The `oneOf` keyword is not supported in OAS2. Only `allOf` is supported.

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

### ⚠️ oas3-examples-value-or-externalValue

The `examples` object should include a `value` or `externalValue` field, but cannot include both.

**Invalid Example**

This example includes both a `value` field and an `externalValue` field.

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

This example includes only a `value` field.

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

### ⚠️ path-parameters-on-path-only

Path parameters should be defined on the path level instead of the operation level.

**Invalid Example**

The `user_id` path parameter on line 8 should not be included with the `patch` operation.

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

The `user-id` path parameter is correctly located at the path level.

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

### ⚠️ paths-no-query-params

Paths should not have query parameters in them. They should be defined separately in the OpenAPI.

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

### ⚠️ resource-names-plural

Resource names should generally be plural. 

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

### ⚠️ paths-avoid-special-characters

Paths should not contain special characters, such as `$` `&` `+` `,` `;` `=` `?` and `@%`.

**Invalid Example**

The path contains an ampersand. 

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

### ℹ️ operation-singular-tag

Operation should not have more than a single tag.
