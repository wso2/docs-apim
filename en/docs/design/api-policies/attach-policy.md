# Attaching Policies

Follow the instructions below to attach one or more default policies that are shipped with WSO2 API Manager to an API operation(s) of an existing API.

1. Sign in to the WSO2 API Publisher.

    `https://<hostname>:9443/publisher`

2. Click on the API for which you want to attach policies to (e.g., `PizzaShackAPI 1.0.0`). Navigate to **API Configurations** --> **Policies**.

3. Under the `API Gateway` section, make sure to select the correct Gateway. API Manager supports the following two Gateway types: `Regular Gateway (Synapse Gateway)` and `Choreo Connect`. Select the Gateway depending on the Gateway that your API is deployed in.

    [![Select Gateway]({{base_path}}/assets/img/design/api-policies/attach-policies-1.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-1.png)

    !!! note
        Keep in mind that the policies attached under a given `API Gateway` will be removed when you switch between Gateways. However, this policy removal will be reflected in your API only if you click on the **Save** button found at the bottom of the Policies page.

    !!! tip
        * The policy list is dependant on the selected Gateway (i.e. policy list under `Regular Gateway` is different to that of `Choreo Connect`).
        
        * Given below is the key difference between the two types.

        | Gateway         | Supported Flows         |
        |-----------------|-------------------------|
        | Regular Gateway | `Request`, `Response`, `Fault` |
        | Choreo Connect  | `Request`, `Response` |

        * Choreo Connect supports policies at **Operation level** 1.2.0 version onwards, while the older version Choreo Connect 1.1.0 only supports at resource level.

4. Pick out the desired operation and flow to which you want to attach policies. Once that is decided, you can expand that API operation. At this point you will notice that by default the UI will open up the first API operation on initial page visit (for PizzaShack API, `/order POST` is expanded by default).

5.  Let’s attach a policy to the `/menu GET` operation. Scroll down through the left side column of the UI and click on `/menu GET` API operation. You should be able to see the below screen when the API operation is expanded.

    [![Operation for adding policies]({{base_path}}/assets/img/design/api-policies/attach-policies-2.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-2.png)

6. Drag the **Add Header** policy from the **Request** tab of the **Policy List** and drop that to the **Request Flow** dropzone of `/menu GET` operation. You will notice a side panel appearing from the right hand side. Fill the required details using the values provided below. Then, click **Save**.

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
            <td>Bar</td>
        </tr>
    </table>

    !!! note 
        You can optionally use the **Apply to all** resources option to attach the same policy to all the resources when you save your settings. This will attach the same policy to all the API operations along with the values you entered to configure the policy (if any). It is important to note that if the policy was applied to the `Request Flow`, it will only be applied to all the `Request Flows` of all operations.

7. Now that we have saved the dropped policy, you should be able to see the attached **Add Header** policy (depicted with the initials `AH`).

    [![API Header policy]({{base_path}}/assets/img/design/api-policies/attach-policies-3.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-3.png)

8. If you click on this newly attached **AH** (i.e. Add Header) policy, you should still be able to view/edit values that you entered initially.

    [![API Header policy]({{base_path}}/assets/img/design/api-policies/attach-policies-4.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-4.png)

9. Let’s go ahead and attach a few more policies to the same **Request Flow**. Pick any amount of policies from the **Request** tab of the **Policy List**.

    [![Attach policies]({{base_path}}/assets/img/design/api-policies/attach-policies-5.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-5.png)

    !!! note
        * You can rearrange the dropped policies that are attached to the **Request Flow** of `/menu GET`

        * You can download the policy source as a `.zip` file by clicking the cloud download icon

        * If you click on the delete icon, the dropped policy is cancelled

10. Finally, when you are satisfied with the dragged and dropped policies, you can go ahead and click on the **Save** button at the bottom of the page. Note that if you do not click on save, none of the dropped policies will be saved to the API.

    [![Attach policies]({{base_path}}/assets/img/design/api-policies/save-attached-policies.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/save-attached-policies.png)
