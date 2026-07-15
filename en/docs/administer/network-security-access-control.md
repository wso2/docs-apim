# Network Security Access Control

## Overview

Outbound host validation is a security mechanism that controls which external hosts WSO2 API Manager is permitted to connect to, preventing unintended or unauthorized outbound requests to internal or external systems.

In WSO2 API Manager, outbound requests such as endpoint validation, WSDL imports, and other internal HTTP calls are protected using configurable validation mechanisms.

This feature allows administrators to control outbound traffic using platform-level and tenant-level configurations.

---

## How It Works

When an outbound request is initiated:

1. The request URL is validated against platform-level configuration
2. If allowed, tenant-level validation is applied (if enabled)
3. The request proceeds only if all validations pass

Platform-level validation is activated automatically when the `[apim.network_security.access_control]` configuration block is present in `deployment.toml`. If the block is absent, platform-level validation is skipped entirely.

---

## Configuration

### Platform-Level Configuration

Global outbound request validation is configured in `deployment.toml`.

This controls system-wide behavior and is enforced for all tenants.

### Tenant-Level Configuration

Tenant-specific validation rules can be configured using `tenant-conf.json`.

These rules provide additional restrictions but cannot override platform-level configurations.

---

## Configuration Precedence

- Platform-level configuration has higher priority
- Tenant-level configuration cannot override platform restrictions
- Tenant rules apply only if the request is allowed at platform level
- If the platform-level configuration block is not present, platform validation is skipped

---

## Host Pattern Matching

Outbound request validation supports simple wildcard-based host matching.

| Pattern | Matches |
|--------|--------|
| `*.example.com` | sub.example.com |
| `api.*.com` | api.test.com |
| `*` | all hosts |

### Notes

- Matching is performed only against the hostname portion of the URL (not the full URL)
- `*` is treated as a wildcard
- Regular expressions are not required
- Matching is case-insensitive

### DNS Resolution During Validation

When the hostname in a request does not directly match any pattern in the `hosts` list, the hostname is resolved via DNS and the resulting IP addresses are also checked against the `hosts` list.

This means:

- `hosts = ["192.168.1.10"]` in `allow` mode — a request to `http://myserver.com/` that resolves to `192.168.1.10` **will be allowed**
- `hosts = ["mytestbackend.com"]` in `allow` mode — a request to `http://162.163.23.4/` **will be blocked** because the IP does not match the pattern

If DNS resolution fails at this stage, the request is **blocked**.

---

## Blocking Private Network Access

!!! note
    `block_private_network_access` is only applicable when the `[apim.network_security.access_control]` configuration block is present. In `allow` mode, this parameter has **no effect** — the hosts list is the sole authority for what is permitted and `block_private_network_access` is never evaluated. In `deny` mode, this check runs after host and resolved-IP list validation passes. When `mode` is absent, `block_private_network_access` is the only check applied.

When enabled, outbound requests to private or internal IP ranges are blocked after DNS resolution.

This protects against access to internal infrastructure such as:

- `127.0.0.1` / `::1` (loopback)
- `10.x.x.x`
- `172.16.x.x – 172.31.x.x`
- `192.168.x.x`
- `169.254.x.x` (link-local)
- `fc00::/7` (IPv6 unique local)
- Multicast addresses

### Behavior

1. Hostname is resolved to an IP address
2. The resolved IP is checked against private/reserved ranges
3. Request is blocked if it matches

If DNS resolution fails, the request is blocked.

---

## Platform-Level Configuration Reference

Configure in `deployment.toml`:

```toml
[apim.network_security.access_control]
mode = "allow"
hosts = ["api.github.com", "*.wso2.com"]
block_private_network_access = true
```

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `mode` | string | — | Determines the base filtering behavior. `allow`: only hosts whose hostname or resolved IP matches the `hosts` list are permitted; all others are blocked. `deny`: hosts whose hostname or resolved IP matches the `hosts` list are blocked; all others are allowed (subject to `block_private_network_access`). If absent or blank, the `hosts` list is ignored and only `block_private_network_access` is applied. |
| `hosts` | array | `[]` | List of host patterns matched against the hostname in the request URL. If the hostname does not match, DNS is resolved and the resulting IPs are also checked against this list. Supports wildcard matching (e.g., `*.example.com`). Behavior depends on `mode`. |
| `block_private_network_access` | boolean | `false` | When enabled, blocks requests whose resolved IP falls within a private or reserved network range. **Only evaluated in `deny` mode** (after host and resolved-IP list validation) and when `mode` is absent. Has no effect in `allow` mode. |

!!! note
    Validation is only active when the `[apim.network_security.access_control]` configuration block is explicitly added to `deployment.toml`. If the block is absent, platform-level validation is skipped entirely.

---

## Empty Hosts Behavior

### `allow` mode with empty `hosts`

```toml
[apim.network_security.access_control]
mode = "allow"
hosts = []
block_private_network_access = true
```

All outbound destinations are blocked. In `allow` mode, only explicitly listed hosts are permitted — an empty list means no host is allowed (fail-closed behavior).

### `deny` mode with empty `hosts`

```toml
[apim.network_security.access_control]
mode = "deny"
hosts = []
block_private_network_access = true
```

No explicit denylist is applied. Only the private network check is enforced.

---

## Tenant-Level Configuration Reference

Behaves the same as the Platform-Level Configuration. 

Configure in `tenant-conf.json`:

```json
{
  "NetworkSecurityAccessControl": {
    "Mode": "allow",
    "Hosts": ["api.github.com", "*.wso2.com"],
    "BlockPrivateNetworkAccess": true
  }
}
```

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `Mode` | string | — | Determines the base filtering behavior. `allow`: only hosts whose hostname or resolved IP matches the `hosts` list are permitted; all others are blocked. `deny`: hosts whose hostname or resolved IP matches the `hosts` list are blocked; all others are allowed (subject to `block_private_network_access`). If absent or blank, the `hosts` list is ignored and only `block_private_network_access` is applied. |
| `Hosts` | array | `[]` | List of host patterns matched against the hostname in the request URL. If the hostname does not match, DNS is resolved and the resulting IPs are also checked against this list. Supports wildcard matching (e.g., `*.example.com`). Behavior depends on `mode`. |
| `BlockPrivateNetworkAccess` | boolean | `false` | When enabled, blocks requests whose resolved IP falls within a private or reserved network range. **Only evaluated in `deny` mode** (after host and resolved-IP list validation) and when `mode` is absent. Has no effect in `allow` mode. |

!!! note
    Tenant-level validation is applied only after the request passes platform-level validation. Tenant configuration cannot override platform restrictions. The `NetworkSecurityAccessControl` key is **not present** in the default `tenant-conf.json` — tenant-level validation is disabled by default and activates only when the key is explicitly added by an admin.

---

## Example Scenarios

### 1. Allow only trusted external hosts

```toml
[apim.network_security.access_control]
mode = "allow"
hosts = ["api.github.com", "*.wso2.com", "localhost"]
block_private_network_access = true
```

Results:

| Request | Result |
|---------|--------|
| `https://api.github.com` | Allowed |
| `https://publisher.wso2.com` | Allowed |
| `http://localhost` | Allowed (`localhost` matches the hosts list directly; `block_private_network_access` is not evaluated in `allow` mode) |
| `http://127.0.0.1` | Blocked (not in hosts) |
| `http://192.168.1.10` | Blocked (not in hosts) |
| `https://example.com` | Blocked (not in hosts) |

---

### 2. Block specific hosts, allow everything else

```toml
[apim.network_security.access_control]
mode = "deny"
hosts = ["localhost", "*.internal"]
block_private_network_access = true
```

Results:

| Request | Result |
|---------|--------|
| `http://localhost` | Blocked (denylist match) |
| `http://service.internal` | Blocked (denylist match) |
| `http://127.0.0.1` | Blocked (private network) |
| `http://192.168.1.10` | Blocked (private network) |
| `https://api.github.com` | Allowed |

---

### 3. Tenant-specific restrictions

```json
{
  "NetworkSecurityAccessControl": {
    "Mode": "allow",
    "Hosts": ["*.example.com"],
    "BlockPrivateNetworkAccess": true
  }
}
```

Behavior:

- Tenant can only access hosts matching `*.example.com`
- Applied only after the platform-level check allows the request

---

### 4. Deny mode with no denylist (private network protection only)

```toml
[apim.network_security.access_control]
mode = "deny"
hosts = []
block_private_network_access = true
```

Results:

| Request | Result |
|---------|--------|
| `http://127.0.0.1` | Blocked (private network) |
| `http://192.168.1.10` | Blocked (private network) |
| `https://api.github.com` | Allowed |

---

## Remote OpenAPI `$ref` Resolution

The network access-control policy is also enforced on remote `$ref` URLs embedded inside OpenAPI/Swagger definitions. When an API definition contains external `$ref` references (for example, `$ref: 'https://schemas.example.com/common.yaml#/components/schemas/Foo'`), WSO2 API Manager validates each referenced URL against the configured policy before fetching it.

This enforcement applies during the OpenAPI/Swagger validate and import operations, for OAS 2.0, OAS 3.0, and OAS 3.1. The same `[apim.network_security.access_control]` platform-level configuration and `NetworkSecurityAccessControl` tenant-level configuration described above apply. No additional configuration is required.

#### Behavior

- If a `$ref` URL resolves to a disallowed or private-network host, the validation or import request fails with HTTP 400.
- If a `$ref` URL resolves to an allow-listed host, the reference is fetched normally.
- Only remote `http` and `https` `$ref` URLs are validated. Local and relative `$ref` references (for example, `$ref: '#/components/schemas/Foo'` or `$ref: './models.yaml#/Bar'`) are unaffected.

!!! note "Backwards compatibility: enforcement requires a configured policy"
    Remote `$ref` enforcement is active only when a network access-control policy is configured (a platform-level `[apim.network_security.access_control]` block in `deployment.toml`, or a tenant-level `NetworkSecurityAccessControl` policy in `tenant-conf.json`). If neither is present, remote `$ref` resolution is unrestricted and behaves exactly as in earlier releases: references are resolved without any host validation, including private-network and link-local addresses. This preserves backwards compatibility for deployments that have not opted into the policy. To enable `$ref` enforcement, configure the policy as described above.

### Limitations

!!! note
    The following limitations apply specifically to `$ref` URL enforcement. They do not affect top-level definition URL validation (the URL used to import or validate the API definition itself).

Once a policy is configured, private-network addresses are always blocked for embedded `$ref`s. Private, internal, loopback, and link-local addresses are unconditionally blocked for remote `$ref` URLs, independent of the `block_private_network_access` setting in `deployment.toml` (which controls only the top-level URL check). Setting `mode = "allow"` and listing specific hosts in the `hosts` array is the only way to permit a `$ref` that resolves to a private-range address.

## Remote WSDL Reference Resolution

The network access-control policy is also enforced on remote references embedded inside WSDL documents when creating a SOAP API from a WSDL. This covers:

- **Nested WSDL/XSD imports (WSDL 1.1 and WSDL 2.0)**: `wsdl:import`, `xsd:import`, and `xsd:include` (plus `xsd:redefine` for WSDL 1.1) whose `location`/`schemaLocation` points at a remote host.
- **SOAP-to-REST type resolution**: the namespace-derived schema fetch performed when generating REST APIs from a WSDL (`implementationType=SOAPTOREST`).

Enforcement applies during the WSDL validate and import operations, using the same `[apim.network_security.access_control]` platform-level and `NetworkSecurityAccessControl` tenant-level configuration described above. No additional configuration is required.

#### Behavior

- If a nested reference resolves to a disallowed or private-network host, the validate or import operation fails with a "URL is not trusted" error. Validate returns `isValid: false` with the error; import returns HTTP 400.
- If the reference resolves to an allow-listed host, it is fetched normally.
- Only remote `http`/`https` references are gated. The top-level WSDL URL is validated separately by the top-level URL check described earlier on this page.

!!! note "Backwards compatibility: enforcement requires a configured policy"
    As with OpenAPI `$ref` resolution, nested WSDL/XSD reference enforcement is active only when a network access-control policy is configured (a platform-level `[apim.network_security.access_control]` block in `deployment.toml`, or a tenant-level `NetworkSecurityAccessControl` policy in `tenant-conf.json`). If neither is present, nested references resolve exactly as in earlier releases, with no host validation.

### Limitations

!!! warning "`allow` mode with WSDL 2.0: allow-list the XML-standards hosts"
    A WSDL 2.0 document that uses any XML Schema type (for example `xs:string`) causes the XML parser to resolve the standard XML Schema definitions (the schema-for-schemas, `xml.xsd`, and related DTDs) from the W3C standards host `www.w3.org`. These are fixed public standards identifiers referenced by virtually every typed WSDL 2.0, not user-supplied endpoints.

    When `mode = "allow"` is used, every host that is not in the `hosts` array is blocked, including `www.w3.org`. As a result, validating or importing a WSDL 2.0 service under an `allow`-mode policy fails with "The provided URL is not trusted". The blocked host, `www.w3.org`, is recorded in `repository/logs/wso2carbon.log`, not in the user-facing message.

    To import WSDL 2.0 services under `allow` mode, add the XML-standards hosts to the allow-list:

    ```toml
    [apim.network_security.access_control]
    mode = "allow"
    hosts = ["api.github.com", "www.w3.org", "schemas.xmlsoap.org"]
    block_private_network_access = true
    ```

    This limitation applies only to `mode = "allow"` with WSDL 2.0. It does not affect:

    - **WSDL 1.1** documents (the vast majority of SOAP services): these do not resolve the standard schema definitions, so they are unaffected.
    - **`deny` mode**: `www.w3.org` is not in the deny-list, so it is permitted automatically.
    - Deployments with no policy configured: no validation is performed.

    Malicious nested references (for example, a `wsdl:import` to an internal or loopback host) remain blocked in all cases; only the fixed public standards hosts need to be allow-listed.

!!! warning "Redirects are followed without re-validation"
    Only the host of the reference as written in the document is validated. If an allow-listed host responds with an HTTP redirect (`3xx`) to a different target, the redirect is followed without re-validating the redirect target. Allow-list a host only if you trust it not to redirect nested-reference fetches to internal or otherwise-blocked endpoints. Addresses reached via the initial reference (private, internal, loopback, and link-local) are still blocked as described above. This limitation concerns only server-issued redirects from an already-permitted host.
