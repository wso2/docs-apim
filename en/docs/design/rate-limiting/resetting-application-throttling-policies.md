# Reset Application Throttling Policies

With reset support, You can reset application-level rate limiting tier for a specific user. Applications issue a single access token to each user according to the grant type they have defined. For each user a request counter will be initialized to track the number of requests coming from the user and the specific application. Resetting will set the counter of a specific user back to zero. This can be done at anytime (after the specified user's tier is throttled out or before) by the application owner or the shared owner.

[![Operation level advanced policy]({{base_path}}/assets/img/learn/application-create-policy.png){: style="width:65%"}]({{base_path}}/assets/img/learn/application-create-policy.png)
