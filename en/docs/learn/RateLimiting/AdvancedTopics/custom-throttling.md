# Custom Throttling

Custom throttling allows system administrators to define dynamic rules for specific use cases, which are applied globally across all tenants. When a custom throttling policy is created, it is possible to define any policy you like. The Traffic Manager acts as the global throttling engine and is based on the same technology as WSO2 Complex Event Processor (CEP), which uses the [Siddhi query language](https://docs.wso2.com/complex-event-processor/SiddhiQL+Guide+3.1) . Users are therefore able to create their own custom throttling policies by writing custom Siddhi queries. The specific combination of attributes being checked in the policy need to be defined as the key (also called the key template). The key template usually includes a predefined format and a set of predefined parameters. It can contain a combination of allowed keys separated by a colon (:), where each key must start with the prefix $. The following keys can be used to create custom throttling policies:

`resourceKey, userId, apiContext, apiVersion, appTenant, apiTenant, appId        `
For example, the following sample custom policy allows the admin user to send 5 requests per minute to the Pizza Shack API.

**Key Template**

``` java
    $userId:$apiContext:$apiVersion
```

**Siddhi query**

``` java
    FROM RequestStream
    SELECT userId, ( userId == 'admin@carbon.super'  and apiContext == '/pizzashack/1.0.0' and apiVersion == '1.0.0') AS isEligible ,
    str:concat('admin@carbon.super',':','/pizzashack/1.0.0:1.0.0') as throttleKey
     
    INSERT INTO EligibilityStream;
    FROM EligibilityStream[isEligible==true]#window.time(1 min)
    SELECT throttleKey, (count(throttleKey) >= 5) as isThrottled group by throttleKey
    INSERT ALL EVENTS into ResultStream;
```

![]({{base_path}}/assets/attachments/126563088/126563087.png)

As shown in the above Siddhi query, the throttle key must match the key template format. If there is a mismatch between the key template format and the throttle key, requests will not be throttled.
