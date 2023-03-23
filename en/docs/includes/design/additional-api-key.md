
#### 1) IP address restriction

The IP address restriction allows only the clients with specific IP addresses to use the token. The IP addresses can be specified
in the following formats.

- IPv4 (e.g., `192.168.1.2`)
- IPv6 (e.g., `2002:eb8::2`)
- IP range in CIDR notation (e.g. `152.12.0.0/13`, `1001:ab8::/14`)

**Generating an API key with an IP restriction**

1. Navigate to API key generation window of the specific application in the Developer Portal.

2. Select `IP Addresses`, add the IP addresses in the text input as shown below, and generate the key.

   [![IP Restricted API key](https://apim.docs.wso2.com/en/4.2.0/assets/img/learn/ip-api-key.png)](https://apim.docs.wso2.com/en/4.2.0/assets/img/learn/ip-api-key.png)

#### 2) HTTP referrer restriction

When the HTTP referrer restriction has been enabled, only the specific HTTP referrers can use the token. Therefore, by using this restriction, when API clients run on web browsers, you can limit the access to an API through only specific web pages. The referrer can be specified in the following formats.

- A specific URL with an exact path: `www.example.com/path`
- Any URL in a single subdomain, using a wildcard asterisk (*): `sub.example.com/*`
- Any subdomain or path URLs in a single domain, using wildcard asterisks (\*): `*.example.com/*`

**Generating an API key with the HTTP referrer restriction**

1. Navigate to API key generation window of that specific application in the Developer Portal.

2. Select `HTTP Referrers (Web Sites)` and add the referrers in the text input as shown below and generate the key.

   [![HTTP Referer Restricted API key](https://apim.docs.wso2.com/en/4.2.0/assets/img/learn/http-referer-api-key.png)](https://apim.docs.wso2.com/en/4.2.0/assets/img/learn/http-referer-api-key.png)
