# Add a Third-party API

WSO2 API Manager provides the capability to publish APIs that are deployed in an external gateway. Since these APIs are not deployed in the WSO2 API gateway, the API will not be proxied through the gateway.

In previous versions of API Manager, third-party APIs were available when importing APIs from [AWS API Gateway]({{base_path}}/api-design-manage/deploy-and-publish/publish-on-dev-portal/publish-aws-apis-in-the-dev-portal/) and when [publishing through external developer portals]({{base_path}}/api-design-manage/deploy-and-publish/publish-on-dev-portal/publish-to-multiple-external-api-stores/).


## Creating a Third-party API

#### Method 1 - API types already supported by API Manager

A regular API can be converted to a third-party API from the **Basic Info** section in the API Publisher portal.

!!! note
    An API cannot be converted to a third-party API when there are active deployments.
        [![Convert to third-party API]({{base_path}}/assets/img/develop/convert-to-third-party.png)]({{base_path}}/assets/img/develop/convert-to-third-party.png)

#### Method 2 - Streaming APIs

In addition to the streaming APIs supported in API Manager (WebSocket, SSE, and WebSub) the **Other** option provided when importing API definitions can be used to import a third-party API.

!!! note
    The APIs created using the ‘Other’ option cannot be converted to a regular API. It can be only used as a third-party API.
        [![Create AsyncAPIs using the Other option]({{base_path}}/assets/img/develop/async-api.png)]({{base_path}}/assets/img/develop/async-api.png)

For more information on creating streaming APIs from AsyncAPI definitions, see [Create a Streaming API from an AsyncAPI Definition]({{base_path}}/manage-apis/design/create-api/create-streaming-api/create-a-streaming-api-from-an-asyncapi-definition/).


Listed below are the fields available when adding third-party API details to the API Manager.

| Name                             | Mandatory/Optional | Description                                                                        |
|----------------------------------|--------------------|------------------------------------------------------------------------------------|
| API External Production Endpoint | Mandatory          | Production endpoint of the externally deployed API.                                 |
| API External Sandbox Endpoint    | Optional           | Sandbox endpoint of the externally deployed API.                                    |
| Original Developer Portal URL    | Optional           | A link to the third-party Developer Portal where the API is published if available. |

You can see an indicator added to the API thumbnail in the API Publisher Portal to distinguish whether an API is from a third-party, as shown below.


<a href="{{base_path}}/assets/img/develop/third-party-tag-with-business-info.png"><img src="{{base_path}}/assets/img/develop/third-party-tag-with-business-info.png" width="20%"></a>

You can use the new default property `thirdParty` to search for APIs that are from a third-party.

!!! note
    Third-party API (REST API) resources can be used in API products. External Production/Sandbox endpoints of the APIs will be added as the endpoints for the API product. Endpoint security is not added for third-party API resources.

!!! note
    In API Manager, Third-party APIs are primarily used to advertise APIs that are deployed on external gateways. These APIs forward requests directly to the external gateways. Consequently, features that are available for APIs deployed through our gateway such as subscriptions, token generation, and other functionalities do not apply to third-party APIs.
