# Configure WebSocket Proxy Profiles

!!! note
    - This feature is available in WSO2 API Manager 4.7.0 starting from update level 6.
    - This feature is available in WSO2 API Manager Universal Gateway 4.7.0 starting from update level 6.

## Overview

WebSocket proxy profiles allow the Classic Gateway to route outbound WebSocket connections (gateway → backend) through one or more HTTP CONNECT proxies. Each profile matches a set of backend hostnames and directs traffic to a specific proxy. You can define multiple profiles to send different backends through different proxies, require proxy authentication on a per-profile basis, or bypass the proxy entirely for selected hostnames.

This configuration applies to both `ws://` and `wss://` backend endpoints and is independent of any inbound proxy or load balancer in front of API Manager.

## How It Works

When the gateway opens a connection to a WebSocket backend, it evaluates the configured proxy profiles against the backend hostname in the following order:

1. **Specific profiles are checked first.** A profile is specific if its `target_hosts` list contains explicit patterns (not `*`). The hostname is matched against each pattern as a Java regular expression.
2. **The first specific profile whose `target_hosts` matches wins.** Subsequent profiles are not evaluated.
3. **If no specific profile matches, the catch-all profile (`target_hosts = ["*"]`) is used**, if one is configured.
4. **If no profile matches at all, the connection is made directly** without a proxy.
5. **`bypass_hosts` is evaluated within the winning profile.** If the backend hostname matches any pattern in `bypass_hosts`, the proxy for that profile is skipped and the connection is made directly.

!!! note
    `bypass_hosts` takes precedence over `target_hosts`. A hostname that matches both is always connected directly.

## Configuration

Proxy profiles are configured in `<APIM_HOME>/repository/conf/deployment.toml`. Add one `[[transport.ws.proxy_profile]]` block per profile for `ws://` backends and one `[[transport.wss.proxy_profile]]` block per profile for `wss://` backends.

### Parameters

| Parameter | Required | Description |
|---|---|---|
| `target_hosts` | Yes | List of Java regex patterns matched against the backend hostname. Use `["*"]` for a catch-all profile. Escape dots: `"example\\.com"`. |
| `proxy_host` | Yes | Hostname or IP address of the HTTP CONNECT proxy. |
| `proxy_port` | Yes | Port of the HTTP CONNECT proxy. |
| `bypass_hosts` | No | List of Java regex patterns. Hosts matching any pattern connect directly, bypassing the proxy for this profile. |
| `proxy_username` | No | Username for `Proxy-Authorization: Basic` authentication. Omit for an unauthenticated proxy. |
| `proxy_password` | No | Password for proxy authentication. |

### Example: Multiple Profiles

```toml
# Route payments backend through a dedicated proxy
[[transport.ws.proxy_profile]]
target_hosts = ["payments\\.internal\\.corp"]
proxy_host = "proxy.payments.corp"
proxy_port = 3128
proxy_username = "gw_user"
proxy_password = "gw_pass"

# Route all other backends through the default proxy,
# except localhost which should connect directly
[[transport.ws.proxy_profile]]
target_hosts = ["*"]
proxy_host = "proxy.corp.internal"
proxy_port = 3128
bypass_hosts = ["localhost", "127\\.0\\.0\\.1"]
```

For `wss://` backends, use `[[transport.wss.proxy_profile]]` with the same parameters:

```toml
[[transport.wss.proxy_profile]]
target_hosts = ["payments\\.internal\\.corp"]
proxy_host = "proxy.payments.corp"
proxy_port = 3128
proxy_username = "gw_user"
proxy_password = "gw_pass"

[[transport.wss.proxy_profile]]
target_hosts = ["*"]
proxy_host = "proxy.corp.internal"
proxy_port = 3128
bypass_hosts = ["localhost", "127\\.0\\.0\\.1"]
```

!!! note
    `[[transport.ws.proxy_profile]]` and `[[transport.wss.proxy_profile]]` are independent. If your WebSocket API has a `ws://` backend endpoint, only the `ws` profiles are evaluated. If it has a `wss://` backend, only the `wss` profiles are evaluated. Configure both sections if you serve both protocols.

## Scenarios

### Route a Backend Through an Anonymous Proxy

Match a specific backend hostname and forward all traffic through a proxy. The proxy requires no authentication.

```toml
[[transport.ws.proxy_profile]]
target_hosts = ["analytics\\.backend\\.corp"]
proxy_host = "127.0.0.1"
proxy_port = 3128
```

A WebSocket API with endpoint `ws://analytics.backend.corp:9090` will route its outbound connection through `127.0.0.1:3128` via an HTTP CONNECT tunnel.

### Route a Backend Through an Authenticated Proxy

Include `proxy_username` and `proxy_password`. The gateway sends a `Proxy-Authorization: Basic` header in the CONNECT request.

```toml
[[transport.ws.proxy_profile]]
target_hosts = ["secure\\.backend\\.corp"]
proxy_host = "proxy.corp.internal"
proxy_port = 3128
proxy_username = "gateway"
proxy_password = "s3cr3t"
```

### Bypass the Proxy for Selected Hosts

Use `bypass_hosts` within a profile to exclude specific backends from proxying. The host matches `target_hosts` so the profile applies, but `bypass_hosts` suppresses the proxy for that host.

```toml
[[transport.ws.proxy_profile]]
target_hosts = [".*\\.internal\\.corp"]
proxy_host = "proxy.corp.internal"
proxy_port = 3128
# dev-backend.internal.corp can be reached directly; bypass the proxy for it
bypass_hosts = ["dev-backend\\.internal\\.corp"]
```

### Use a Catch-All Profile With Exclusions

A `*` profile routes any backend not matched by a specific profile. Combine with `bypass_hosts` to carve out hosts that should connect directly.

```toml
# Specific profile: payments cluster has its own proxy
[[transport.ws.proxy_profile]]
target_hosts = [".*\\.payments\\.internal"]
proxy_host = "payments-proxy.corp"
proxy_port = 3128

# Catch-all: everything else goes through the corporate proxy,
# except the staging server which is reachable directly
[[transport.ws.proxy_profile]]
target_hosts = ["*"]
proxy_host = "proxy.corp.internal"
proxy_port = 3128
bypass_hosts = ["staging\\.ws\\.corp"]
```

### Connect to a WSS Backend Through a Proxy

For `wss://` backend endpoints, the gateway opens a raw TCP tunnel through the proxy (HTTP CONNECT), then performs the TLS handshake with the backend directly inside that tunnel. The proxy does not terminate or inspect TLS.

**Prerequisites:**

1. Import the backend's TLS certificate (or the signing CA) into the API Manager client truststore:

    ```bash
    keytool -import -trustcacerts \
      -alias my-backend \
      -file /path/to/backend.crt \
      -keystore <APIM_HOME>/repository/resources/security/client-truststore.jks \
      -storepass wso2carbon -noprompt
    ```

2. Restart the server so the truststore change takes effect.

3. Configure the `wss` proxy profile:

    ```toml
    [[transport.wss.proxy_profile]]
    target_hosts = ["secure-backend\\.corp"]
    proxy_host = "proxy.corp.internal"
    proxy_port = 3128
    ```

## Limitations and Things to Note

- **Server restart required.** Proxy profile configuration is read at startup. Changes to `deployment.toml` require a server restart to take effect.

- **Regex matching is on the hostname string, not the resolved IP.** A profile with `target_hosts = ["127\\.0\\.0\\.1"]` matches only when the backend endpoint uses the IP `127.0.0.1` literally. It does not match `localhost` even though both resolve to the same address.

- **Profile order matters only within the same priority class.** Among specific profiles (no `*`), the first matching profile wins. Declare more-specific patterns before broader ones to ensure the intended profile is selected.

- **A single `*` catch-all is supported.** Defining more than one catch-all profile is allowed syntactically, but only the first one is applied.

- **Only Basic authentication is supported** for `proxy_username` / `proxy_password`. The gateway sends `Proxy-Authorization: Basic <base64(user:pass)>`.

- **`ws` and `wss` profiles are independent.** `[[transport.ws.proxy_profile]]` entries have no effect on `wss://` backends and vice versa. Define both if you use both protocols.

- **WSS backend certificates must be trusted by the gateway.** When connecting to a `wss://` backend through a proxy, the gateway performs TLS with the backend after the CONNECT tunnel is established. The backend's certificate must be present in the client truststore (`client-truststore.jks`), and the server must be restarted after importing the certificate.

- **Proxy profiles apply to outbound backend connections only.** They do not affect inbound traffic from API clients to the gateway, or HTTP/REST API backends. Only WebSocket transport senders (`ws` and `wss`) use this configuration.
