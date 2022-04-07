# Attaching Policies

Follow the instructions below to attach one or more default policies that are shipped with WSO2 API Manager to an API operation of an existing API.

1. Sign in to the WSO2 API Publisher.
    `https://<hostname>:9443/publisher`

2. Click on the API (e.g., `PizzaShackAPI 1.0.0`) for which you want to attach policies to and navigate to the Policies tab.

    [![API to add policies]({{base_path}}/assets/img/design/api-policies/attach-policies-1.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-1.png)

3. Pick out the desired operation and flow to which you want to attach policies to. Once that is decided, you can expand that API operation. At this point you will notice that by default the UI will open up the first API operation on initial page visit (for PizzaShack API, post `/order` is expanded by default). Let’s attach our first policy to the get resource of `/menu`. Scroll down through the left side column of the UI and click on get /menu API operation. You should be able to see the below screen.

    [![Operation for adding policies]({{base_path}}/assets/img/design/api-policies/attach-policies-2.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-2.png)

4. Drag the **Add Header Policy** from the **Request** tab of the **Policy List** and drop that to the **Request Flow** dropzone. You will notice a side panel appearing from the right hand side. Enter the following details to attach a custom header to the request flow of the get resource of `/menu` operation. Then, click **Save**.

    <table>
        <tr>
            <th>Field</th>
            <th>Sample Value</th>
        </tr>
        <tr>
            <td>Header Name</td>
            <td>Foo</td>
        </tr>
        <tr>
            <td>Header Value</td>
            <td>Foo</td>
        </tr>
    </table>

    !!! note 
        You can optionally use the **Apply to all** resources option to attach the same policy to all the resources on Save. This will attach the same policy to all the API operations along with the values you entered to configure the policy (if any). It is important to note that if the policy was applied to the Request Flow, it will only be applied to all the Request Flows of all operations.

5. Now that we have saved the dropped policy, you should be able to see the attached **Add Header** policy (depicted with the initials AH).

    [![API Header policy]({{base_path}}/assets/img/design/api-policies/attach-policies-3.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-3.png)

6. If you click on this newly attached AH (i.e. Add Header) policy, you should still be able to view/edit the initially added values.

7. Let’s go ahead and attach a few more policies to the same **Request Flow**. Pick any amount of policies from the **Request** tab of the **Policy List**.

    [![Attach policies]({{base_path}}/assets/img/design/api-policies/attach-policies-4.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-4.png)

    !!! note
        * You can rearrange the dropped policies that are attached to the **Request Flow** of `/menu get`.

        * You can download the policy source as a .zip file by clicking the cloud download icon.

        * If you click on the delete icon, the dropped policy is cancelled.

8. Finally, when you are satisfied with the dragged and dropped policies, you can go ahead and click on the **Save** button at the bottom of the page. Note that if you do not click on save, none of the dropped policies will be saved to the API.

## Call interceptor service - Choro Connect

You can use interceptors in Choreo Connect to carry out transformations and mediation on the requests and responses. Learn more about [Message Transformation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/message-transformation-overview/) in Choreo Connect.

[![Call Interceptor API]({{base_path}}/assets/img/design/api-policies/call-interceptor.png){: style="width:50%"}]({{base_path}}/assets/img/design/api-policies/call-interceptor.png)

The policy attribute “Includes to Payload” in the Call Interceptor Service supports the following values in the request flow.

- response_headers
- response_body
- response_trailers
- Invocation_context

For more information, see [Request flow interceptor]({{base_path}}/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptors-in-an-open-api-definition/#request-flow-interceptor).

Following values in response flow.

- request_headers
- request_body
- request_trailers
- response_headers
- response_body
- response_trailers
- Invocation_context

For more information, see [Response flow interceptor]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptors-in-an-open-api-definition/#response-flow-interceptor).