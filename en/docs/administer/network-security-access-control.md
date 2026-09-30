# Network Security Access Control

WSO2 API Manager supports network access control from version 4.7.0 onwards. Network access control governs which external hosts the product is permitted to connect to when it resolves a user-supplied URL, so that outbound requests are restricted to the destinations an administrator has approved.

In WSO2 API Manager, outbound requests such as endpoint validation, WSDL imports, and remote reference resolution are governed by this configurable validation mechanism.

This feature allows administrators to control outbound traffic using platform-level and tenant-level configurations.

!!! info
    Network access control is a configurable security enhancement that gives administrators granular control over outbound destinations. See [Recommended Configuration](#recommended-configuration) for the configuration WSO2 recommends.

---

## How It Works

When an outbound request is initiated:

1. The request URL is validated against platform-level configuration
2. If allowed, tenant-level validation is applied (if enabled)
3. The request proceeds only if all validations pass

Platform-level validation is activated automatically when the `[server.network_security.access_control]` configuration block is present in `deployment.toml`. If the block is absent, platform-level validation is skipped entirely.

---

## Enforcement Scope

Network access control is applied at the following points when WSO2 API Manager processes a user-supplied URL or definition.

| Enforcement point | Applies to | Active when |
|-------------------|------------|-------------|
| Outbound URL validation | <ul><li>Endpoint validation, and the production, sandbox, and failover endpoint URLs of an API, an API endpoint, or an MCP Server when it is created, updated, or imported</li><li>OpenAPI, WSDL, AsyncAPI, and GraphQL definitions that are validated or imported by URL</li><li>GraphQL schema retrieval through introspection</li><li>MCP Server URL validation</li><li>Key Manager discovery, and the endpoint URLs configured for a Key Manager</li></ul> | A policy is configured |
| Remote reference resolution | <ul><li>Remote `$ref` URLs in OpenAPI and Swagger definitions, including references in documents that are fetched while resolving another reference</li><li>Nested WSDL and XSD imports, and the schema retrieval performed for SOAP-to-REST APIs</li></ul>This applies when a definition is validated, imported, or updated in the Publisher, when an API project is imported, and when an MCP Server or a Service Catalog entry is created or updated. | A policy is configured |
| Archive reference containment | Local references inside OpenAPI archives and WSDL 1.1 archives uploaded as ZIP files. See [Archive Reference Containment](#archive-reference-containment). | Always |

### Validation Errors

When a URL or reference is not permitted, the operation fails with one of the following errors. Depending on the operation, the error is returned as an HTTP 400 response or as a validation result with `isValid: false`. In the Publisher portal, the error description is displayed with the validation results of the corresponding create or import flow. Key Manager configuration requests are rejected with HTTP 400 and a message that identifies the endpoint field that is not permitted.

| Code | Description | Returned when |
|------|-------------|---------------|
| `900405` | The provided URL could not be resolved. | An outbound URL is not permitted by the policy. |
| `900407` | A remote reference in the definition could not be resolved. | A reference inside a definition is not permitted by the policy, or a local reference in an archive resolves outside the archive. |

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

!!! note
    - Matching is performed only against the hostname portion of the URL (not the full URL)
    - `*` is treated as a wildcard
    - Regular expressions are not required
    - Matching is case-insensitive

### DNS Resolution During Validation

When the hostname in a request does not directly match any pattern in the `hosts` list, the hostname is resolved via DNS and the resulting IP addresses are also checked against the `hosts` list.

This means:

- `hosts = ["192.168.1.10"]` in `allow` mode: a request to `http://myserver.com/` that resolves to `192.168.1.10` **will be allowed**
- `hosts = ["mytestbackend.com"]` in `allow` mode: a request to `http://162.163.23.4/` **will be blocked** because the IP does not match the pattern

If DNS resolution fails at this stage, the request is **blocked**.

---

## Blocking Private Network Access

!!! note
    `block_private_network_access` is only applicable when the `[server.network_security.access_control]` configuration block is present. In `allow` mode, this parameter has **no effect**. The hosts list is the sole authority for what is permitted, and `block_private_network_access` is never evaluated. In `deny` mode, this check runs after host and resolved-IP list validation passes. When `mode` is absent, `block_private_network_access` is the only check applied.

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
[server.network_security.access_control]
mode = "allow"
hosts = ["api.github.com", "*.wso2.com"]
block_private_network_access = true
```

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `mode` | string | none | Determines the base filtering behavior. `allow`: only hosts whose hostname or resolved IP matches the `hosts` list are permitted; all others are blocked. `deny`: hosts whose hostname or resolved IP matches the `hosts` list are blocked; all others are allowed (subject to `block_private_network_access`). If absent or blank, the `hosts` list is ignored and only `block_private_network_access` is applied. |
| `hosts` | array | `[]` | List of host patterns matched against the hostname in the request URL. If the hostname does not match, DNS is resolved and the resulting IPs are also checked against this list. Supports wildcard matching (e.g., `*.example.com`). Behavior depends on `mode`. |
| `block_private_network_access` | boolean | `false` | When enabled, blocks requests whose resolved IP falls within a private or reserved network range. **Only evaluated in `deny` mode** (after host and resolved-IP list validation) and when `mode` is absent. Has no effect in `allow` mode. |

!!! note
    Validation is only active when the `[server.network_security.access_control]` configuration block is explicitly added to `deployment.toml`. If the block is absent, platform-level validation is skipped entirely.

---

## Empty Hosts Behavior

### `allow` mode with empty `hosts`

```toml
[server.network_security.access_control]
mode = "allow"
hosts = []
block_private_network_access = true
```

All outbound destinations are blocked. In `allow` mode, only explicitly listed hosts are permitted, so an empty list means no host is allowed (fail-closed behavior).

### `deny` mode with empty `hosts`

```toml
[server.network_security.access_control]
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
| `Mode` | string | none | Determines the base filtering behavior. `allow`: only hosts whose hostname or resolved IP matches the `hosts` list are permitted; all others are blocked. `deny`: hosts whose hostname or resolved IP matches the `hosts` list are blocked; all others are allowed (subject to `block_private_network_access`). If absent or blank, the `hosts` list is ignored and only `block_private_network_access` is applied. |
| `Hosts` | array | `[]` | List of host patterns matched against the hostname in the request URL. If the hostname does not match, DNS is resolved and the resulting IPs are also checked against this list. Supports wildcard matching (e.g., `*.example.com`). Behavior depends on `mode`. |
| `BlockPrivateNetworkAccess` | boolean | `false` | When enabled, blocks requests whose resolved IP falls within a private or reserved network range. **Only evaluated in `deny` mode** (after host and resolved-IP list validation) and when `mode` is absent. Has no effect in `allow` mode. |

!!! note
    The `NetworkSecurityAccessControl` key is **not present** in the default `tenant-conf.json`, so tenant-level validation is disabled by default and activates only when the key is explicitly added by an admin.

---

## Recommended Configuration

WSO2 recommends configuring network access control in `allow` mode with an explicit `hosts` list. This is the recommended mode for all deployments, and particularly for single-tenant deployments, where the set of legitimate outbound destinations is known and stable.

`allow` mode is fail-closed: only the hosts that are explicitly listed are permitted, and every other destination is blocked. The permitted set of outbound destinations is therefore explicit and auditable, and the policy does not need to be revised each time a new internal service is introduced into the surrounding network.

```toml
[server.network_security.access_control]
mode = "allow"
hosts = ["api.github.com", "*.wso2.com"]
```

In `allow` mode the `hosts` list is the sole authority for what is permitted, so `block_private_network_access` is not evaluated and does not need to be set.

When defining the allow list:

- List only the hosts that endpoint validation, definition imports, and API creation legitimately require, and review the list periodically.
- Include only hosts that are trusted to serve the content they are listed for. An allow-listed host is permitted for every outbound flow described on this page.
- List an internal or private-network host only when the deployment requires it. Such a host is then permitted for every flow described on this page.
- Add `www.w3.org` if SOAP APIs are created from WSDL 2.0 documents. See [Remote WSDL Reference Resolution](#remote-wsdl-reference-resolution).
- In multi-tenant deployments, define the platform-level policy as the outer bound for all tenants, and use tenant-level policies to further restrict individual tenants.

If the set of outbound destinations cannot be enumerated in advance, configure `deny` mode with `block_private_network_access = true` as a baseline, and list the internal hosts that must never be reached. Move to `allow` mode once the required destinations are known.

---

## Example Scenarios

### 1. Allow only trusted external hosts

```toml
[server.network_security.access_control]
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
[server.network_security.access_control]
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
[server.network_security.access_control]
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

This enforcement applies wherever an OpenAPI/Swagger definition is validated, imported, or updated, as listed in [Enforcement Scope](#enforcement-scope), for OAS 2.0, OAS 3.0, and OAS 3.1. The same `[server.network_security.access_control]` platform-level configuration and `NetworkSecurityAccessControl` tenant-level configuration described above apply. No additional configuration is required.

#### Behavior

- If a `$ref` URL resolves to a disallowed or private-network host, the validation or import request fails with HTTP 400.
- If a `$ref` URL resolves to an allow-listed host, the reference is fetched normally.
- Only remote `http` and `https` `$ref` URLs are validated against the policy. References within the same document (for example, `$ref: '#/components/schemas/Foo'`) do not make a network request and are unaffected.
- In a definition that is imported by URL, a relative reference (for example, `$ref: './models.yaml#/Bar'`) is resolved against the definition URL and validated as a remote reference.
- In a definition that is uploaded as a ZIP archive, relative references are resolved within the archive, as described in [Archive Reference Containment](#archive-reference-containment).

!!! note "Backwards compatibility: enforcement requires a configured policy"
    Remote `$ref` enforcement is active only when a network access-control policy is configured (a platform-level `[server.network_security.access_control]` block in `deployment.toml`, or a tenant-level `NetworkSecurityAccessControl` policy in `tenant-conf.json`). If neither is present, remote `$ref` references are resolved exactly as in earlier releases, without host validation. This preserves backwards compatibility for deployments that have not yet defined a policy. To enable `$ref` enforcement, configure the policy as described above.

### Private Network Addresses in `$ref` URLs

!!! note
    The behavior described below applies specifically to `$ref` URL enforcement. It does not affect top-level definition URL validation (the URL used to import or validate the API definition itself).

Once a policy is configured, private, internal, loopback, and link-local addresses are blocked for embedded `$ref` URLs independently of the `block_private_network_access` setting in `deployment.toml`, which governs only the top-level URL check. To permit a `$ref` that resolves to an address in a private range, set `mode = "allow"` and list the host explicitly in the `hosts` array.

## Remote WSDL Reference Resolution

The network access-control policy is also enforced on remote references embedded inside WSDL documents when creating a SOAP API from a WSDL. This covers:

- **Nested schema references (WSDL 1.1)**: `xsd:import`, `xsd:include`, and `xsd:redefine` elements whose `schemaLocation` points at a remote host.
- **Nested WSDL references (WSDL 2.0)**: `wsdl:import` and `wsdl:include` elements whose `location` points at a remote host.
- **SOAP-to-REST type resolution**: the namespace-derived schema fetch performed when generating REST APIs from a WSDL (`implementationType=SOAPTOREST`).

Enforcement applies during the WSDL validate and import operations, using the same `[server.network_security.access_control]` platform-level and `NetworkSecurityAccessControl` tenant-level configuration described above. No additional configuration is required.

#### Behavior

- If a nested reference resolves to a host that the policy does not permit, the validate or import operation fails with a "remote reference in the definition could not be resolved" error. Validate returns `isValid: false` with the error; import returns HTTP 400.
- If the reference resolves to an allow-listed host, it is fetched normally.
- Only remote `http`/`https` references are validated against the policy. Local references in a WSDL archive are handled as described in [Archive Reference Containment](#archive-reference-containment). The top-level WSDL URL is validated separately by the top-level URL check described earlier on this page.
- Nested references are evaluated with the same rules as top-level URLs, including the `block_private_network_access` setting in `deny` mode.

!!! note "Backwards compatibility: enforcement requires a configured policy"
    As with OpenAPI `$ref` resolution, nested WSDL/XSD reference enforcement is active only when a network access-control policy is configured (a platform-level `[server.network_security.access_control]` block in `deployment.toml`, or a tenant-level `NetworkSecurityAccessControl` policy in `tenant-conf.json`). If neither is present, nested references are resolved exactly as in earlier releases, without host validation.

### Considerations

!!! warning "WSDL 2.0 in `allow` mode"
    WSDL 2.0 documents that use XML Schema types resolve the standard schema definitions from `www.w3.org`. In `allow` mode, this host is blocked unless it is listed, and validating or importing the WSDL fails with "A remote reference in the definition could not be resolved". To import WSDL 2.0 services in `allow` mode, add the XML standards hosts to the `hosts` list:

    ```toml
    [server.network_security.access_control]
    mode = "allow"
    hosts = ["api.github.com", "www.w3.org", "schemas.xmlsoap.org"]
    ```

    This does not apply to WSDL 1.1 documents, to `deny` mode, or to deployments without a configured policy.

!!! note
    The host of a nested reference is validated as it is written in the document. Add a host to the allow list only if it is trusted to serve the references it is listed for, as recommended in [Recommended Configuration](#recommended-configuration).

## Archive Reference Containment

When an OpenAPI definition or a WSDL 1.1 service is uploaded as a ZIP archive, references from one file in the archive to another are resolved only within the extracted archive.

- A relative reference is resolved against the directory of the document that contains it, and must remain within the root of the extracted archive. Archives that reference sibling files or files in subdirectories resolve normally.
- `file:` references and absolute file system paths are not resolved.
- A reference that resolves to a location outside the root of the extracted archive is not resolved.

Archive reference containment applies whether or not a network access-control policy is configured. A reference that is not resolved fails the validate or import operation with the "remote reference in the definition could not be resolved" error (`900407`).

Remote `http` and `https` references inside an archive are validated against the network access-control policy, as described in [Remote OpenAPI `$ref` Resolution](#remote-openapi-ref-resolution) and [Remote WSDL Reference Resolution](#remote-wsdl-reference-resolution).
