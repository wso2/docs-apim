# Handle Rate Limiting Errors

When your application exceeds rate limits, the API Gateway returns HTTP 429 (Too Many Requests) responses.

## Recognizing Rate Limiting Responses

When a request is throttled, you receive an HTTP **429 Too Many Requests** status code with a response body containing details about why the request was blocked.

**Example throttled response:**

```json
{
    "code": "900800",
    "message": "Message throttled out",
    "description": "You have exceeded your quota"
}
```

## Rate Limiting Error Codes

The error code in the response indicates which specific limit was exceeded:

| Error Code | Error Message | Description |
|------------|---------------|-------------|
| `900800` | Message throttled out | The maximum number of requests that can be made to the API within a designated time period is reached and the API is throttled for the user. |
| `900801` | Hard limit exceeded | Hard throttle limit has been reached |
| `900802` | Resource level throttle out | Message is throttled out because resource level has exceeded |
| `900803` | Application level throttle out | Message is throttled out because application level is exceeded |
| `900804` | Subscription level throttled out | Message throttled out due to subscription level throttling limit reached. |
| `900805` | Message blocked | Accessing an API which is blocked on user, IP, application, or API Context. |
| `900806` | Custom policy throttled out | Message throttled out due to exceeding the limit configured through the custom throttling policy rules. |
| `900807` | Message throttled out | Messaged throttled out because of exceeding the burst control/rate limit (requests per second) in the subscription level policy. |

For complete information on all error codes, see [Error Handling]({{base_path}}/reference/troubleshooting/error-handling/#api-handlers-error-codes).

## Retrying a Throttled Request

Inspect the `Retry-After` response header before retrying a throttled request. When the Gateway has a next-access timestamp for the throttled request, it includes this header as an HTTP date in GMT. For example:

```http
HTTP/1.1 429 Too Many Requests
Retry-After: Fri, 31 Dec 1999 23:59:59 GMT
```

The date above illustrates the header format; an actual response contains the next-access time for that request. Parse the value as an HTTP date and wait until that time before retrying. Do not assume that the Gateway returns an integer number of seconds.

The header is not guaranteed for every throttling condition. If it is absent, use bounded retries with increasing delays rather than retrying immediately in a loop. A retry can still be throttled if another applicable limit has been reached.

If your application also handles rate-limit responses from backend services, their `Retry-After` values can use either an HTTP date or a delay in seconds. Handle both formats, and ensure that repeating the operation is safe before retrying a request that changes backend state.

## See Also

- Learn about rate limiting tiers: [Rate Limiting for App Developers]({{base_path}}/api-developer-portal/rate-limiting/rate-limiting-for-app-developers/)
- Reset user quotas in your application: [Reset Application Throttling Policies]({{base_path}}/api-developer-portal/rate-limiting/resetting-application-throttling-policies/)
- Manage your applications: [Manage Application Rate Limits]({{base_path}}/api-developer-portal/rate-limiting/manage-application-rate-limits/)
