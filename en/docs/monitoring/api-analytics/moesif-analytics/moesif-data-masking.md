# Privacy and Data Masking

Analytics events carry identity information about the client that invoked the API, and, if you have enabled
header capture, whatever your headers happen to contain. This page covers how to mask that information
before it is published to Moesif.

!!! warning "Protect your Moesif API key"
    Ensure that you **do not** expose your Moesif API Key in public repositories or logs, as it can lead
    to unauthorized access to your analytics data.

## Understanding Data Privacy Requirements

WSO2 Analytics data may contain PII (Personally Identifiable Information) such as user IP addresses and usernames. Additionally, when `send_headers` is set to `true`, request and response headers may contain sensitive information.

To comply with data privacy regulations (GDPR, CCPA, etc.) and protect user privacy, it is strongly recommended to mask or anonymize such sensitive information before sending it to Moesif.

!!! warning "What masking covers"
    Masking applies **only** to the identity fields listed below and to the request and response
    headers you name explicitly. It does **not** apply to request or response bodies. If you have
    enabled body capture with `send_payloads`, every captured body is published to Moesif in full, see [Bodies Are Never Masked]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-capture/#bodies-are-never-masked).

## Configuring Data Masking

Add the following configuration to your `deployment.toml` file to enable data masking:

```toml
[apim.analytics.mask]
"userIp" = "IPV4"
"userName" = "EMAIL"
"userId" = "EMAIL"
"userAgent" = "STRING"
"applicationOwner" = "EMAIL"
request_headers = ["X-Custom-Auth", "X-API-Key"]
response_headers = ["X-Account-Number"]
```

A masked header is published to Moesif with its value replaced by `*****`; the header name itself is
still visible. As with the headers excluded above, masking applies only to the published event, the
header reaches the backend or the client with its real value intact. Header names in
`request_headers` and `response_headers` are matched case-insensitively.

!!! note
    You do not need to list `Authorization`, `apikey`, `Cookie` or `Set-Cookie` here. Those headers
    are removed from analytics events entirely, whether or not you configure masking, see
    [Headers That Are Never Published]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-capture/#headers-that-are-never-published). Use `request_headers` and
    `response_headers` for headers specific to your deployment, such as a custom authorization
    header name or a header carrying customer identifiers.

## Masking Configuration Reference

| **Name** | **Description** | **Accepted Values** |
|----------|-----------------|---------------------|
| userIp | Defines the format used to capture and store the user's IP address in analytics records | IPV4, IPV6 |
| userName | Specifies the format of the username field used for analytics or identification | EMAIL, STRING |
| userId | Identifies how the user ID is represented in analytics data | EMAIL, STRING |
| userAgent | Represents the type of the user agent string recorded from the client request | STRING |
| applicationOwner | Specifies the format of the application owner's identifier | EMAIL, STRING |
| response_headers | List of response headers to be masked for analytics or logging purposes | Header keys as strings |
| request_headers | List of request headers to be masked for analytics or logging purposes | Header keys as strings |

## Masking Behavior Examples

- **IPV4**: Masks the 3rd octet of an IPv4 address
    - Original: `192.168.1.98`
    - Masked: `192.168.***.98`

- **IPV6**: Masks the 4th, 5th, 6th and 7th segments of an IPv6 address
    - Original: `2001:0db8:85a3:0000:0000:8a2e:0370:7334`
    - Masked: `2001:0db8:85a3:****:****:****:****:7334`

- **EMAIL**: Masks the local part of an email address
    - Original: `john.doe@gmail.com`
    - Masked: `*****@gmail.com`

- **STRING**: Masks the entire string value
    - Original: `JohnDoe`
    - Masked: `*****`

