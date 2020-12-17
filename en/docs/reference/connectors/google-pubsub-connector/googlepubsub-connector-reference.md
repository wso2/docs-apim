# Google Pub/Sub Connector Reference

The following operations allow you to work with the Google Pub/Sub Connector. Click an operation name to see parameter details and samples on how to use it.

---

To use the Google Pub/Sub connector, add the <googlepubsub.init> element in your configuration before any other Google Pub/Sub operation. This configuration authenticates with Google Pub/Sub via user credentials.

Google Pub/Sub uses the OAuth 2.0 protocol for authentication and authorization. All requests to the Google Cloud Pub/Sub API must be authorized by an authenticated user.

??? note "googlepubsub.init"
    This operation allows you to initialize the connection to Google Pub/Sub.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>The application URL of Google Pub/Sub.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>apiVersion</td>
            <td>The version of the Google Pub/Sub API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accessToken</td>
            <td>The access token that grants access to the Google Pub/Sub API on behalf of a user.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientId</td>
            <td>The client id provided by the Google developer console.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientSecret</td>
            <td>The client secret provided by the Google developer console.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>refreshToken</td>
            <td>The refresh token provided by the Google developer console, which can be used to obtain new access tokens.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>blocking</td>
            <td>Set this to true if you want the connector to perform blocking invocations to Google Pub/Sub.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>tokenEndpoint</td>
            <td>The token endpoint of the Google API. The default will be set to https://www.googleapis.com/oauth2/v4/token if not provided.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <googlepubsub.init>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <apiVersion>{$ctx:apiVersion}</apiVersion>
        <accessToken>{$ctx:accessToken}</accessToken>
        <clientId>{$ctx:clientId}</clientId>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <refreshToken>{$ctx:refreshToken}</refreshToken>
        <blocking>{$ctx:blocking}</blocking>
        <tokenEndpoint>{$ctx:tokenEndpoint}</tokenEndpoint>
    </googlepubsub.init>
    ```

---

### Project Topics

??? note "createTopic"
    The createTopic operation creates a new topic with a name that you specify. See the [related API documentation](https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.topics/create) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>topicName</td>
            <td>The name of the topic that you are creating.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The unique ID of the project within which you want to create the topic.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <googlepubsub.createTopic>
        <topicName>{$ctx:topicName}</topicName>
        <projectId>{$ctx:projectId}</projectId>
    </googlepubsub.createTopic>
    ```
    
    **Sample request**

    ```json
    {
        "apiUrl":"https://pubsub.googleapis.com",
        "apiVersion":"v1",
        "accessToken": "ya29.GlwG2NhgX_NQhxjtF_0G9bzf0FEj_shNWgF_GXmjeYQF0XQXrBjjcrJukforOeyTAHoFfSQW0x-OrrZ2lj47Z6k6DAYZuUv3ZhJMl-ll4mvouAbc",
        "topicName":"topicA",
        "projectId":"rising-parser-123456"
    }
    ```

??? note "publishMessage"
    The publishMessage operation publishes messages to a specified topic. See the [related API documentation](https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.topics/publish) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>topicName</td>
            <td>The unique name of the topic to which messages should be published.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The unique ID of the project within which the topic is created.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>data</td>
            <td>The message payload.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>attributes</td>
            <td>Additional attributes of the message.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <googlepubsub.publishMessage>
        <topicName>{$ctx:topicName}</topicName>
        <projectId>{$ctx:projectId}</projectId>
        <data>{$ctx:data}</data>
        <attributes>{$ctx:attributes}</attributes>
    </googlepubsub.publishMessage>
    ```
    
    **Sample request**

    ```json
    {
        "apiUrl":"https://pubsub.googleapis.com",
        "apiVersion":"v1",
        "accessToken": "ya29.GlwG2NhgX_NQhxjtF_0G9bzf0FEj_shNWgF_GXmjeYQF0XQXrBjjcrJukforOeyTAHoFfSQW0x-OrrZ2lj47Z6k6DAYZuUv3ZhJMl-ll4mvouAbc",
        "topicName":"topicA",
        "projectId":"rising-parser-123456"
    }
    ```

### Project Subscriptions

??? note "createTopicSubscription"
    The createTopicSubscription operation creates a subscription to a topic that you specify. See the [related API documentation](https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.subscriptions/create) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>topicName</td>
            <td>The name of the topic that you are creating.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The unique ID of the project within which you want to create the topic.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>subscriptionName</td>
            <td>The name of the subscription.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ackDeadlineSeconds</td>
            <td>The maximum time a subscriber can take to acknowledge a message that is received.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>pushEndpoint</td>
            <td>The URL that specifies the endpoint to which messages should be pushed.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>attributes</td>
            <td>Additional endpoint configuration attributes.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <googlepubsub.createTopicSubscription>
        <topicName>{$ctx:topicName}</topicName>
        <projectId>{$ctx:projectId}</projectId>
        <subscriptionName>{$ctx:subscriptionName}</subscriptionName>
        <ackDeadlineSeconds>{$ctx:ackDeadlineSeconds}</ackDeadlineSeconds>
        <pushEndpoint>{$ctx:pushEndpoint}</pushEndpoint>
        <attributes>{$ctx:attributes}</attributes>
    </googlepubsub.createTopicSubscription>
    ```
    
    **Sample request**

    ```json
    {
        "apiUrl":"https://pubsub.googleapis.com",
        "apiVersion":"v1",
        "accessToken": "ya29.GlwAJG2NhgX_NQhxjtF_0G9bzf0FEj_shNWgF_GXmYFpwIxjeYQF0XQXukforOeyTAHoFfSQW0x-OrrZ2lj47Z6k6DAYZuUv3ZhJMl-ll4mvouAbc",
        "projectId":"rising-parser-123456",
        "topicName":"topicA",
        "subscriptionName":"mysubA",
        "ackDeadlineSeconds":"30",
        "pushEndpoint": "https://example.com/push",
        "attributes": {"key": "value1","key2":"values2"}
    }
    ```

??? note "pullMessage"
    The pullMessage operation retrieves messages that are published to a topic. See the [related API documentation](https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.subscriptions/pull) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>topicName</td>
            <td>The name of the topic to which the subscription belongs.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The unique ID of the project within which the topic is created.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>subscriptionName</td>
            <td>The name of the subscription from which messages should be retrieved.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxMessages</td>
            <td>The maximum number of messages to retrieve.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnImmediately</td>
            <td>Set this to true if you want the server to respond immediately.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <googlepubsub.pullMessage>
        <topicName>{$ctx:topicName}</topicName>
        <projectId>{$ctx:projectId}</projectId>
        <subscriptionName>{$ctx:subscriptionName}</subscriptionName>
        <maxMessages>{$ctx:maxMessages}</maxMessages>
        <returnImmediately>{$ctx:returnImmediately}</returnImmediately>
    </googlepubsub.pullMessage>
    ```
    
    **Sample request**

    ```json
    {
        "apiUrl":"https://pubsub.googleapis.com",
        "apiVersion":"v1",
        "accessToken": "ya29.GlwABbJG2NhgX_NQhxjtF_0G9bzf0FEj_shNWgF_GXmYFpwIxjeYQF0XjcrJukforOeyTAHoFfSQW0x-OrrZ2lj47Z6k6DAYZuUv3ZhJMl-ll4mvouAbc",
        "topicName":"topicA",
        "projectId":"rising-parser-123456",
        "subscriptionName":"mysubA",
        "maxMessages":"2",
        "returnImmediately":"false"
    }
    ```