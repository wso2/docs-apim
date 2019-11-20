# Endpoint Suspension

In API Manager by default, gateway suspends API for 30 seconds when it cannot reach the endpoint. If another request comes to your API within that 30 seconds, it won't be sent to the backend. You might have seen the following response when the endpoint is suspended.

``` java
    <am:fault xmlns:am="http://wso2.org/apimanager">
    <am:code>303001</am:code>
    <am:type>Status report</am:type>
    <am:message>Runtime Error</am:message>
    <am:description>Currently , Address endpoint : [ Name : somename-AT-sometenant--test_me_APIproductionEndpoint_0 ] [ State : SUSPENDED ]</am:description>
    </am:fault>
```
For more information about [endpoint timeout configuration.](endpoint-timeouts.md)
You can also [prevent the API suspension](prevent-api-suspension.md) as well.