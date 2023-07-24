# API Policies Overview

Policies generally enforce some business logic that needs to be executed on the `Request`, `Response`, or `Fault` flow of an API invocation. A policy is a collection of rules that will be executed at the API Gateway. Using policies we can make API invocations undergo slight behavioural modifications before reaching the backend. In a similar manner, we can modify the API response a client recieves.

Policy is dependent on the API Gateway that you have configured with WSO2 API Manager. The API Policy feature supports the following two Gateway types:

- **Regular Gateway (Synapse Gateway)**

- **Choreo Connect**

API Manager ships a default set of policies that cover most of the common use cases that you will need, while also giving you the ability to create your own. Note that the common policy list is more robust when compared with previous API Manager versions. There are three main flows that you can utilize to attach any policy that you need. Namely, `Request Flow`, `Response Flow` and `Fault Flow`. You can also attach multiple policies under each of these flows, and are free to swap and rearrange the attached policies.

Note the following architectural changes brought about by this feature:

- Concept of attaching a single policy to a particular flow (i.e. request, response or fault) at the API level was a bottleneck with the previous versions of WSO2 API Manager.
- With the new and improved feature, we can attach multiple policies either at **API Level** or **Operation Level** as opposed to just attaching a single policy for the whole API.
- We can manipulate the order in which the attached policies engage with the configured API gateway. The order in which you have arranged the policies is guaranteed to be honored by the gateway.
- You can easily expect dynamic inputs for policy attributes as opposed to static policies that were supported through the deprecated mediation policies feature.
