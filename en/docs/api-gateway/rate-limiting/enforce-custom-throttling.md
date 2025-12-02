# Enforce Custom Throttling

Custom throttling policies allow system administrators to define dynamic rules for specific use cases, which are applied globally across all tenants. The Traffic Manager evaluates these policies using its Siddhi-based throttling engine.

## How the Gateway Enforces Custom Policies

When a custom throttling policy is created, it defines dynamic rules using Siddhi queries. The Gateway sends request data to the Traffic Manager, which evaluates the custom policies through its Siddhi runtime and takes throttling decisions based on the policy conditions.

## Key Template

The specific combination of attributes being checked in the policy must be defined as the key (also called the key template). The key template includes a predefined format and a set of predefined parameters. It contains a combination of allowed keys separated by a colon (:), where each key must start with the prefix $.

**Available keys for custom throttling policies:**

`resourceKey, userId, apiContext, apiVersion, appTenant, apiTenant, appId, clientIp`

## Siddhi Query Example

The following sample custom policy demonstrates how the Traffic Manager evaluates requests. This example allows the admin user to send 5 requests per minute to the Pizza Shack API:

**Key Template:** `$userId:$apiContext:$apiVersion`

**Siddhi Query:**

```sql
FROM RequestStream
SELECT userId, ( userId == 'admin@carbon.super'  and apiContext == '/pizzashack/1.0.0' and apiVersion == '1.0.0') AS isEligible ,
str:concat('admin@carbon.super',':','/pizzashack/1.0.0:1.0.0') as throttleKey
INSERT INTO EligibilityStream;
FROM EligibilityStream [isEligible==true] #throttler:timeBatch(1 min)
SELECT throttleKey, (count(throttleKey) >= 5) as isThrottled, expiryTimeStamp group by throttleKey
INSERT ALL EVENTS into ResultStream;
```

!!! important
    The throttle key in the Siddhi query must match the key template format. If there is a mismatch between the key template format and the throttle key, the Gateway will not throttle requests correctly.

## Related Topics

- [Custom Throttling Configuration]({{base_path}}/api-design-manage/design/rate-limiting/adding-new-throttling-policies/#adding-a-new-custom-throttling-policy) - How to create custom throttling policies
- [Siddhi Query Language Guide](https://docs.wso2.com/complex-event-processor/SiddhiQL+Guide+3.1) - Complete Siddhi query language reference
