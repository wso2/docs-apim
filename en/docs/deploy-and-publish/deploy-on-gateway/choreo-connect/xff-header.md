# XFF Header Manipulation

`x-forwarded-for` (XFF) is a standard proxy header defined by [RFC 7239](https://datatracker.ietf.org/doc/html/rfc7239.html), which indicates the IP addresses that a request has flowed through on its way from the client to the server. Choreo Connect supports x-forwarded-for header manipulation using `use_remote_address` field in the Router configuration.

## `x-forwarded-for` header manipulation when the router is configured with `use_remote_address = false` (Default configuration)

Router operates in a transparent mode where it does not add/modify `x-forwarded-for` header.

#### 1. Incoming HTTP request does not contain a `x-forwarded-for` header.

Since the incoming HTTP request does not contain a `x-forwarded-for` header, upstream service does not receive a `x-forwarded-for` header in this scenario.

[![xff-scenario-1]({{base_path}}/assets/img/deploy/mgw/xff-scenario-1.png)]({{base_path}}/assets/img/deploy/mgw/xff-scenario-1.png)

#### 2. Incoming HTTP request contains a `x-forwarded-for` header.

Upstream service receives the `x-forwarded-for` header of the incoming HTTP request without any modifications.

[![xff-scenario-2]({{base_path}}/assets/img/deploy/mgw/xff-scenario-2.png)]({{base_path}}/assets/img/deploy/mgw/xff-scenario-2.png)

## x-forwarded-for header manipulation when the router is configured with `use_remote_address = true`

#### 1. Incoming HTTP request does not contain a `x-forwarded-for` header.

Router adds a new `x-forwarded-for` header and sets the value to the immediate downstream IP address. Upstream service receives the `x-forwarded-for` header added by the router.

[![xff-scenario-3]({{base_path}}/assets/img/deploy/mgw/xff-scenario-3.png)]({{base_path}}/assets/img/deploy/mgw/xff-scenario-3.png)

#### 2. Incoming HTTP request contains a `x-forwarded-for` header.

Router appends the IP address of the immediate downstream to the `x-forwarded-for` header of the incoming HTTP request. Upstream service receives the `x-forwarded-for` header modified by the router.

[![xff-scenario-4]({{base_path}}/assets/img/deploy/mgw/xff-scenario-4.png)]({{base_path}}/assets/img/deploy/mgw/xff-scenario-4.png)
