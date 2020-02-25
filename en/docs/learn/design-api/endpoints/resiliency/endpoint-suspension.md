# Endpoint Suspension

In API Manager, by default, the gateway suspends an API for 30 seconds when it cannot reach the endpoint. If another request is made to your API within those 30 seconds, it will not be sent to the backend. The following response appears when the endpoint is suspended.

``` java
    <am:fault xmlns:am="http://wso2.org/apimanager">
    <am:code>303001</am:code>
    <am:type>Status report</am:type>
    <am:message>Runtime Error</am:message>
    <am:description>Currently , Address endpoint : [ Name : somename-AT-sometenant--test_me_APIproductionEndpoint_0 ] [ State : SUSPENDED ]</am:description>
    </am:fault>
```

 <div class="admonition note">
 <p class="admonition-title">What's Next?</p>

 <p>For more information on endpoint timeout configurations, see -
 <ul><li><a href="{{base_path}}/learn/design-api/endpoints/resiliency/endpoint-timeouts">Endpoint Timeouts</a>
 </li>
<li><a href="{{base_path}}/learn/design-api/endpoints/resiliency/prevent-api-suspension">Prevent API Suspension</a></li></ul></p>
 </div>

