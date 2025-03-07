# OWASP Top 10

The OWASP Top 10 ruleset enforces security best practices based on OWASP guidelines to prevent common vulnerabilities in API definitions. This ruleset ensures that API definitions comply with security standards, reducing the risk of security breaches.

## Rules Overview

| Rule Name | Severity | Description |
|-----------|----------|-------------|
| [owasp:api2:2023-no-http-basic](#owaspapi22023-no-http-basic) | Error | Prevents usage of HTTP Basic Authentication, which is vulnerable to interception. |
| [owasp:api2:2023-jwt-best-practice](#owaspapi22023-jwt-best-practice) | Error | Ensures JWT implementations explicitly reference RFC8725 to avoid known security issues. |
| [owasp:api3:2023-no-additionalproperties](#owaspapi32023-no-additionalProperties) | Warning | Prevents mass assignment issues by disallowing additional properties in JSON Schema. |
| [owasp:api3:2023-constrained-additionalProperties](#owaspapi32023-constrained-additionalproperties) | Warning | Ensures `maxProperties` is defined when `additionalProperties` is not strictly disabled. |
| [owasp:api3:2023-no-unevaluatedProperties](#owaspapi32023-no-unevaluatedproperties) | Warning | Prevents unvalidated properties in JSON Schema definitions. |
| [owasp:api3:2023-constrained-unevaluatedProperties](#owaspapi32023-constrained-unevaluatedproperties) | Warning | Ensures `maxProperties` is defined when `unevaluatedProperties` is not strictly disabled. |
| [owasp:api4:2023-rate-limit-retry-after](#owaspapi42023-rate-limit-retry-after) | Error | Ensures rate-limited responses include a `Retry-After` header. |
| [owasp:api4:2023-rate-limit-responses-429](#owaspapi42023-rate-limit-responses-429) | Warning | Ensures rate-limited responses include proper schemas. |
| [owasp:api8:2023-no-scheme-http](#owaspapi82023-no-scheme-http) | Error | Enforces HTTPS or WSS instead of HTTP for secure communication. |
| [owasp:api8:2023-no-server-http](#owaspapi82023-no-server-http) | Error | Prevents defining API server URLs with `http://`. |
| [owasp:api8:2023-define-error-validation](#owaspapi82023-define-error-validation) | Warning | Ensures `400`, `422`, or `4XX` responses are properly defined. |
| [owasp:api8:2023-define-error-responses-401](#owaspapi82023-define-error-responses-401) | Warning | Requires `401` response schema definitions. |
| [owasp:api8:2023-define-error-responses-500](#owaspapi82023-define-error-responses-500) | Warning | Requires `500` response schema definitions. |
| [owasp:api9:2023-inventory-access](#owaspapi92023-inventory-access) | Error | Enforces `x-internal` property to indicate API visibility. |
| [owasp:api9:2023-inventory-environment](#owaspapi92023-inventory-environment) | Error | Ensures API environments (e.g., local, staging, production) are clearly defined. |


## Detailed Rules

### owasp:api2:2023-no-http-basic

**Description:** Basic authentication credentials transported over network are more susceptible to interception than other forms of authentication, and as they are not encrypted it means passwords and tokens are more easily leaked.

**Severity:** Error

**Valid Example**

```yaml
components:
  securitySchemes:
    OAuth2:
      type: oauth2
      flows:
        authorizationCode:
          authorizationUrl: https://example.com/auth
          tokenUrl: https://example.com/token
          scopes:
            read: Grants read access
            write: Grants write access
```

**Invalid Example**

```yaml
components:
  securitySchemes:
    BasicAuth:
      type: http
      scheme: basic
```

---

### owasp-api2-2023-jwt-best-practices

**Description:**  
JSON Web Tokens (JWT), as defined in RFC7519, provide a compact and URL-safe way of representing claims between two parties. JWTs can be enclosed in encrypted or signed tokens such as JWS and JWE.  

The [JOSE IANA registry](https://www.iana.org/assignments/jose/jose.xhtml) provides information on cryptographic algorithms.  

RFC8725 highlights security pitfalls in JWT implementations, including:  
- The ability to ignore algorithms (e.g., `{"alg": "none"}`).  
- The use of insecure algorithms such as `RSASSA-PKCS1-v1_5` (e.g., `{"alg": "RS256"}`).  

APIs using JWTs must explicitly state in the `description` field that the implementation conforms to RFC8725.

**Severity:** Error  

**Invalid Example**  

```yaml
components:
  securitySchemes:
    JWTBearer:
      type: http
      scheme: bearer
      bearerFormat: JWT
      description: A bearer token in the format of a JWS.
```

**Valid Example**  

```yaml
components:
  securitySchemes:
    JWTBearer:
      type: http
      scheme: bearer
      bearerFormat: JWT
      description: A bearer token in the format of a JWS and conforming to the specifications included in RFC8725.
```

---

### owasp:api3:2023-no-additionalProperties

**Description:**  
By default, JSON Schema allows additional properties in objects, which can lead to security vulnerabilities such as mass assignment issues. This occurs when unspecified fields are passed to the API without validation, potentially exposing sensitive data or enabling unintended behavior.  

To mitigate this risk, the `additionalProperties` field should be explicitly set to `false`.

**Severity:** Warning  

**Invalid Example**  

```yaml
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
      additionalProperties: true
```

**Valid Example**  

```yaml
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
      additionalProperties: false
```

---

### owasp:api3:2023-constrained-additionalProperties

**Description:**  
By default, JSON Schema allows additional properties in objects, which can lead to security risks such as mass assignment vulnerabilities. This occurs when unspecified fields are passed to the API without validation.  

If `additionalProperties` is used with a schema instead of `true` or `false`, a constraint must be applied using `maxProperties` to limit the number of allowed properties.  

**Severity:** Warning  

**Invalid Example**  

```yaml
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
      additionalProperties:
        type: string
```

**Valid Example**  

```yaml
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
      additionalProperties:
        type: string
      maxProperties: 5
```

---

### owasp:api3:2023-no-unevaluatedProperties

**Description:**  
By default, JSON Schema allows `unevaluatedProperties`, which can introduce security risks such as mass assignment vulnerabilities. This occurs when unspecified fields are passed to the API without validation.  

To mitigate this risk, the `unevaluatedProperties` field should be explicitly set to `false`.  

**Severity:** Warning  

**Invalid Example**  

```yaml
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
      unevaluatedProperties: true
```

**Valid Example**  

```yaml
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
      unevaluatedProperties: false
```

---

### owasp:api3:2023-constrained-unevaluatedProperties

**Description:**  
By default, JSON Schema allows `unevaluatedProperties`, which can introduce security risks such as mass assignment vulnerabilities. This occurs when unspecified fields are passed to the API without validation.  

If `unevaluatedProperties` is used with a schema instead of `true` or `false`, a constraint must be applied using `maxProperties` to limit the number of allowed properties.  

**Severity:** Warning  

**Invalid Example**  

```yaml
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
      unevaluatedProperties:
        type: string
```

**Valid Example**  

```yaml
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
      unevaluatedProperties:
        type: string
      maxProperties: 5
```

---

### owasp:api4:2023-rate-limit-retry-after

**Description:**  
To prevent attackers from overloading an API, proper rate limiting should be implemented. As part of this, a `Retry-After` header should be included in `429 Too Many Requests` responses. This informs legitimate consumers when they can retry their request, preventing excessive polling that could worsen the issue.  

**Severity:** Error  

**Invalid Example**  

```yaml
paths:
  /api/resource:
    get:
      responses:
        429:
          description: Too Many Requests
          headers: {}
```

**Valid Example**  

```yaml
paths:
  /api/resource:
    get:
      responses:
        429:
          description: Too Many Requests
          headers:
            Retry-After:
              description: Time in seconds before retrying
              schema:
                type: integer
```

---

### owasp:api4:2023-rate-limit-responses-429

**Description:**  
OWASP API Security recommends defining schemas for all responses, including error responses. A `429 Too Many Requests` response indicates that the client is exceeding rate limits. This response should provide structured information about when the client can retry, allowing proper backoff mechanisms.  

Defining a `429` response is crucial for:  
- Ensuring proper documentation.  
- Enabling contract testing to verify the expected JSON structure.  
- Preventing unintended information leakage through backtraces.  
- Confirming that rate limiting is properly configured in the API, framework, or gateway.  

**Severity:** Warning  

**Invalid Example**  

```yaml
paths:
  /api/resource:
    get:
      responses:
        200:
          description: Successful response
        500:
          description: Internal Server Error
```

**Valid Example**  

```yaml
paths:
  /api/resource:
    get:
      responses:
        200:
          description: Successful response
        429:
          description: Too Many Requests
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: "Rate limit exceeded"
                  retry_after:
                    type: integer
                    example: 60
```

---

### owasp:api8:2023-no-scheme-http

**Description:**  
APIs must not use the `http` scheme, as it is inherently insecure. Unencrypted HTTP traffic can lead to the exposure of personally identifiable information (PII) and other sensitive data through traffic sniffing or man-in-the-middle attacks. Instead, APIs should enforce secure communication using `https` or `wss` (for WebSocket connections).  

For more information on secure transport protocols, refer to the [OWASP Transport Layer Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Security_Cheat_Sheet.html).  

**Severity:** Error  

**Invalid Example**  

```yaml
schemes:
  - http
  - https
```

**Valid Example**  

```yaml
schemes:
  - https
  - wss
```

---

### owasp:api8:2023-no-server-http

**Description:**  
APIs must not use `http://` in server URLs, as it is inherently insecure. Unencrypted HTTP traffic can expose personally identifiable information (PII) and other sensitive data to threats such as traffic sniffing or man-in-the-middle attacks. APIs should enforce secure communication using `https://` or `wss://` (for WebSocket connections).  

For more details on secure transport protocols, refer to the [OWASP Transport Layer Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Security_Cheat_Sheet.html).  

**Severity:** Error  

**Invalid Example**  

```yaml
servers:
  - url: http://api.example.com
```

**Valid Example**  

```yaml
servers:
  - url: https://api.example.com
```

**Valid Example for WebSockets**  

```yaml
servers:
  - url: wss://ws.example.com
```

---

### owasp:api8:2023-define-error-validation

**Description:**  
APIs should carefully define schemas for all responses, including error responses caused by invalid client requests. Specifically, at least one of the following response codes should be included:  

- `400 Bad Request` (used for generic client errors, such as malformed syntax)  
- `422 Unprocessable Entity` (used when the request is well-formed but contains invalid data)  
- `4XX` (a generic placeholder for client errors)  

Defining these responses ensures proper documentation, improves API usability, and enables better error handling by consumers.  

**Severity:** Warning  

**Invalid Example**  

```yaml
paths:
  /api/resource:
    post:
      responses:
        200:
          description: Successful response
```

**Valid Example**  

```yaml
paths:
  /api/resource:
    post:
      responses:
        200:
          description: Successful response
        400:
          description: Bad Request
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: "Invalid input data"
```

**Alternative Valid Example with `422`**  

```yaml
paths:
  /api/resource:
    post:
      responses:
        200:
          description: Successful response
        422:
          description: Unprocessable Entity
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: "Validation failed"
```

---

### owasp:api8:2023-define-error-responses-401

**Description:**  
APIs must define response schemas for all error cases, including `401 Unauthorized`. This response code indicates that authentication credentials are missing or invalid. Clearly defining the `401` response helps document API behavior and ensures that contract testing verifies the correct JSON structure, preventing the unintended exposure of implementation details through error messages.  

**Severity:** Warning  

**Invalid Example**  

```yaml
paths:
  /api/protected-resource:
    get:
      responses:
        200:
          description: Successful response
```

**Valid Example**  

```yaml
paths:
  /api/protected-resource:
    get:
      responses:
        200:
          description: Successful response
        401:
          description: Unauthorized
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: "Invalid authentication credentials"
```

---

### owasp:api8:2023-define-error-responses-500

**Description:**  
APIs should define response schemas for all errors, including `500 Internal Server Error`. This response code indicates a failure within the server and not the client. Defining the `500` error response is crucial for proper documentation, ensuring that consumers understand how the API will respond during server failures. It also supports contract testing to verify that the correct JSON structure is returned and prevents the leakage of internal server details through error messages.  

**Severity:** Warning  

**Invalid Example**  

```yaml
paths:
  /api/resource:
    get:
      responses:
        200:
          description: Successful response
```

**Valid Example**  

```yaml
paths:
  /api/resource:
    get:
      responses:
        200:
          description: Successful response
        500:
          description: Internal Server Error
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: "An unexpected error occurred"
```

---

### owasp:api9:2023-inventory-access

**Description:**  
APIs should explicitly declare the intended audience for each server by using the vendor extension `x-internal` with a value of `true` or `false`. This helps provide clarity on whether the API is intended for internal or external use. Many documentation tools rely on this information to present the API's purpose more clearly to consumers.  

**Severity:** Error  

**Invalid Example**  

```yaml
servers:
  - url: https://api.example.com
```

**Valid Example**  

```yaml
servers:
  - url: https://api.example.com
    x-internal: true
```  

**Alternative Valid Example**  

```yaml
servers:
  - url: https://api.internal.example.com
    x-internal: false
```

---

### owasp:api9:2023-inventory-environment

**Description:**  
It is crucial to specify the intended environment for each server in the API documentation to avoid issues such as exposing test data to the public or allowing unauthorized access to production-like environments. The server descriptions should clearly indicate whether the environment is for development, testing, staging, or production, using appropriate terms like `local`, `sandbox`, `alpha`, `beta`, `prod`, etc.  

**Severity:** Error  

**Invalid Example**  

```yaml
servers:
  - url: https://api.example.com
    description: API server
```

**Valid Example**  

```yaml
servers:
  - url: https://api.example.com
    description: Production API server
```

**Alternative Valid Example**  

```yaml
servers:
  - url: https://api.staging.example.com
    description: Staging environment
```  
