# Choreo Connect Supported Features

The latest version v0.9.0 of Choreo Connect does not support all the features provided by 
API Manager product. In contrast to API gateway Choreo Connect(the API Microgateway) support subset of features offered by the 
API Manager product. Following is a list of key features supported by Choreo Connect

- Deploying APIs from publisher portal.
- Deploy new revisions of APIs from publisher portal.
- Deploy APIs with prototype endpoints.
- Test APIs with internal test keys from publisher portal 
- Deploy/undeploy APIs using the command line tool APICTL.
- Web socket APIS (JWT authentication and throttling supported) 
- JWT based oauth2 authentication.
- JWT revocation.  
- Subscription validation.
- Subscription blocking/unblocking from publisher portal.
- Scope validation for JWT oauth2 bearer tokens.
- Applying CORS configuration from publisher portal.
- Support full lifecycle states of APIs like created, prototyped, blocked, deprecated, published and etc.
- Support virtual hosts(Vhosts) to expose the APIs.  
- API/Resource, application and subscription level throttling.
- Advance throttling, custom policies and the blocking conditions.
- Publish analytics to the Choreo cloud.
- Back end JWT generation (Passing end user details to the back end services).
- Provide custom header name for authentication header and configuration to enable/disable authentication header from outbound request.   
- Fetch and deploy key managers added by API Manager admin portal.
- Define multiple key managers from the configurations.
- Subscription validation with self-contained tokens.
- Integrate with Consul for service discovery.
- Integrate with Consul Service Mesh.
- Support basic auth protected basic end services
- Support publishing APIs to multiple gateway environments

The following key features are not supported by the Choreo Connect as of now they will be added in the future releases.

- Streaming APIs like SSE, web sub and etc.
- Create streaming APIs from Async API specifications.
- Analytics for the web socket APIs.
- GraphQL APIs
- API Products.  
- Mutual SSL authentication for APIs.
- Application level securities like basic auth and api keys.
- Message transformation and mediation.
- Bandwidth based throttling.
  

