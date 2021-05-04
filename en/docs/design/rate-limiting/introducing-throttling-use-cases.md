# Introducing Throttling Use-Cases

Throttling allows you to limit the number of successful hits to an API during a given period, typically in cases such as the following:

-   To protect your APIs from common types of security attacks such as certain types of denial of service (DOS) attacks
-   To regulate traffic according to infrastructure availability
-   To make an API, application, or a resource available to a consumer at different levels of service, usually for monetization purpose


The API Gateway architecture model, which solves the API management problem, comprises the following:

-   The back-end services/systems hosting the actual business logic
-   The APIs in the API Gateway that proxy the back-end services
-   The applications that consume the APIs in the API Gateway
-   The users of the applications

[![Throttling types]({{base_path}}/assets/img/learn/throttling-types.png)]({{base_path}}/assets/img/learn/throttling-types.png)

The following sections describe the type of throttling policy applicable to each of the above areas and why the relevant stakeholders must consider each of them carefully.

-   Implications on back-end services/systems
-   Implications on the APIs in the Gateway
-   Advanced throttling policies: API Publisher
-   Implications on applications that consume APIs

### Implications on back-end services/systems

#### Maximum backend throughput ( **Applies per API** ): API Publisher

According to the API Gateway architecture, an API in the Gateway is actually a proxy to an actual service hosted within your organization, cloud, etc. This usually means that there is a physical capacity that your backend services can handle. Although you expose your API on defined limits (subscription tiers), as the number of applications that consume your API grows, the number of requests being served by your API rise, which in turn means that the number of requests served by your backend system rise as well. Therefore, although none of the applications may exceed their own allocated quotas, their combined load might hit the maximum capacity that can be handled by your backend system.

To prevent your backend system from getting overloaded, the limits enforced by the **Maximum Backend Throughput** in the API act as a hard stop on the number of requests that your backend system can serve within a given time period. The counters maintained when evaluating the maximum backend throughput are shared across all nodes of the Gateway cluster and apply across all users using any application that accesses that particular API. For information on how to specify maximum backend throughput limits, see [Setting Maximum Backend Throughput Limits]({{base_path}}/design/rate-limiting/setting-maximum-backend-throughput-limits).

### Implications on the APIs in the Gateway

#### Subscription tiers: API Publisher

When an API Publisher publishes an API to be consumed by applications, they can choose to make the API available over different limits. For example, the **Gold** tier allows an application to access the API at 5000 requests per minute while a **Silver** tier allows an application to access the API at 2000 requests per minute. For information on how to define a throttling tier to an API, see [API-level throttling (API publisher)]({{base_path}}/design/rate-limiting/setting-throttling-limits/#subscription-level-throttling-api-publisher).

The subscription tiers are used to gain monetary value for the API; you can charge more from app developers who require larger quotas of your API’s functionality and lesser from developers who require less. The limits can be enforced either by the number of requests over time (5000 req/min) or the amount of data bandwidth over time (500 mb/hour). The limits enforced by subscription tiers are applied across all users of the application that use that particular API and can be considered as a shared quota among all users of an application that access that API. When using a cluster of Gateway nodes, the counters maintained while evaluating the subscription tiers are shared across all nodes. For information on how to define a subscription tier to an API, see [Subscription-level throttling (API publisher)]({{base_path}}/design/rate-limiting/setting-throttling-limits/#subscription-level-throttling-api-subscriber).

**Burst Control**

Burst control limits are enforced for subscription tiers in order to distribute the load across the specified time period. For example, if you have a subscription tier that allows you to send 1000 requests per hour, you can ensure that a particular application does not consume the full quota of 1000 requests within the first 2 minutes by setting a burst control limit within the subscription tier allowing only a maximum of 25 requests per minute. Therefore, the time periods set for burst control limits must always be smaller than the time period specified for its corresponding subscription tier. Burst control limits can be set only to control the number of requests for a given period of time and does not allow you to control the data bandwidth for a given time period. The burst control limits are enforced for each individual Gateway node. Although the request counters are replicated across the cluster, since burst control time periods are usually quite small, the replication frequency can be quite high compared to the burst rate of incoming requests. Therefore, it is safe to assume that the burst control values are applied on a per-node basis. For information on how to define burst control limits, see [Rate limiting (burst control)]({{base_path}}/design/rate-limiting/setting-throttling-limits/#rate-limiting-burst-control).

### Advanced throttling policies: API Publisher

Advanced throttling policies allow an API Publisher to control access per API or API resource using advanced rules. Advanced policies include the ability to apply limits by filtering requests based on the following properties and their combinations. The counters maintained when evaluating advanced throttling policies are shared across all nodes in the Gateway cluster.

-   IP address and address range
-   HTTP request headers
-   IntroducingThrottlingUse-Cases-JWTclaims
-   Query parameters

Let’s look at how each of these can be important for serving requests through your APIs.

##### IP address and address range

You can control/restrict access to your API or its selected resources for a given IP address or address range. For example, if you need to grant permission for internal applications to consume a larger quota of your API resource than your external consumers, you can define an advanced policy with higher limits for your internal IP address range and lower limits for the rest. 

Here is a sample for configuring an IP condition by limiting the number of requests for a specific IP address.

[![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/new-allow-specific-ip.png)]({{base_path}}/assets/img/learn/new-allow-specific-ip.png)

##### HTTP request headers

Advanced policies allow you to apply limits to APIs by filtering requests based on HTTP headers. For example, assume you need to apply a special limit for JSON requests. To do that, you can filter JSON messages by using a policy that inspects the HTTP request headers and checks if the `Content-Type` header is `application/json` and apply a special limit for those requests while allowing a default value for the rest.

Here is a sample for configuring a header condition by considering the "Content-Type" header.

[![New header condition regex]({{base_path}}/assets/img/learn/new-header-condition-regex.png)]({{base_path}}/assets/img/learn/new-header-condition-regex.png)
##### JWT claims

A JWT claim contains meta information of an API request. It can include application details, API details, user claims, etc. Advanced throttling policies based on JWT claims allow you to filter requests by JWT claim values and apply limits for requests. For example, if you need to allow special limits for users in a specific user role, you can create an advanced policy that checks for a particular regular expression on the role claim of the user and apply special limits for the ones that match.

The following image shows an example for configuring JWT claim condition by considering the version of the API (http://wso2.org/claims/subscribe).

[![New JWT condition regex]({{base_path}}/assets/img/learn/new-jwt-condition-regex.png)]({{base_path}}/assets/img/learn/new-jwt-condition-regex.png)
##### Query parameters

Filtering based on query parameters almost always apply to HTTP GET requests when doing search type of operations. For example, if you have a search API with `category` as a query parameter, you can have different limits for searching different categories.

[![New advanced throttling query condition]({{base_path}}/assets/img/learn/new-advanced-throttling-query-conidtion.png)]({{base_path}}/assets/img/learn/new-advanced-throttling-query-conidtion.png)
Eg : 'sales' category can be allocated with more requests than 'hr' category

### Implications on applications that consume APIs

#### Per token quota: Application Developer

When an application developer subscribes their application to an API, they select a tier (limit) for their application to invoke the API. This limit applies across all users of the application when accessing the particular API. To ensure that a fair distribution of the quota is available among all the users, it is important to consider setting a per user quota for the application, since a user is identified by a token (in OAuth2.0, this limit is known as the per token quota). It is important to note that the limit enforced by this setting applies to a single user (token) accessing all APIs of the application. The counters maintained when evaluating a per token quota are shared across all nodes in the Gateway cluster. For information on how to define a throttling tier to an application, see [Application-level throttling (application developer)]({{base_path}}/design/rate-limiting/setting-throttling-limits/#application-level-throttling-application-developer)).


The following diagram shows how throttle policies are applied at different levels.


[![Throttling levels]({{base_path}}/assets/img/learn/throttling-levels.png)]({{base_path}}/assets/img/learn/throttling-levels.png)

If [advanced throttling](#advanced-throttling-policies-api-publisher) policies are added and engaged to a specific API or API resource, it will also be applied here. i.e. Requests will be allowed/rejected based on the conditions specified in advanced throttling policies as well.
