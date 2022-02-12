# Add a Third-party API

WSO2 API Manager provides the capability to publish APIs that are deployed in an external gateway. Since these APIs are not deployed in the WSO2 API gateway, the API will not be proxied through the gateway.

In previous versions of API Manager, third-party APIs were available when importing APIs from [AWS API Gateway]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-aws-apis-in-the-dev-portal/) and when [publishing through external developer portals]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-to-multiple-external-api-stores/).


## Creating a Third-party API

1. A regular API can be converted to a third-party API from the **Basic Info** section in the API Publisher portal.

!!! note
    An API cannot be converted to a third party API when there are active deployments.

[![Convert to third-party API]({{base_path}}/assets/img/develop/convert-to-third-party.png)]({{base_path}}/assets/img/develop/convert-to-third-party.png)

2. In addition to the streaming APIs supported in API Manager (WebSocket, SSE and WebSub), the **Other** option provided when importing AsyncAPI definitions can be used to import a third-party API.

!!! note
    APIs created from ‘Other’ option cannot be converted to a regular API. (can be only used as a third party API)

[![Create Async API using the Other option]({{base_path}}/assets/img/develop/async-api.png)]({{base_path}}/assets/img/develop/async-api.png)


Listed below are the fields available when adding third-party API details to the API Manager.

| Name                             | Mandatory/Optional | Description                                                                        |
|----------------------------------|--------------------|------------------------------------------------------------------------------------|
| API External Production Endpoint | Mandatory          | Production endpoint of the externally deployed API.                                 |
| API External Sandbox Endpoint    | Optional           | Sandbox endpoint of the externally deployed API                                    |
| Original Developer Portal URL    | Optional           | A link to the third party developer portal where the API is published if available |

You can see an indicator added to the API thumbnail in the API Publisher Portal to distinguish whether an API is from a third-party, as shown below.


<a href="{{base_path}}/assets/img/develop/third-party-tag.png"><img src="{{base_path}}/assets/img/develop/third-party-tag.png" width="20%"></a>

You can use the new default property `thirdParty` to search for APIs that are from a third-party.
