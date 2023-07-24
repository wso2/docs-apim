# Attaching Policies

Follow the instructions below to attach one or more default policies that are shipped with WSO2 API Manager to an existing API.

1. Sign in to the WSO2 API Publisher.

    `https://<hostname>:9443/publisher`

2. Click on the API for which you want to attach policies to (e.g., `PizzaShackAPI 1.0.0`). Navigate to **API Configurations** --> **Policies**.

3. Select the appropriate `API Gateway` based on the Gateway that your API is deployed in. Note that API Manager supports the following two Gateway types: `Regular Gateway (Synapse Gateway)` and `Choreo Connect`.

    [![Select Gateway]({{base_path}}/assets/img/design/api-policies/attach-policies-1.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-1.png)

    !!! note
        Keep in mind that the policies attached under a given `API Gateway` will be removed when you switch between Gateways. However, this policy removal will be reflected in your API only if you click on the **Save** button found at the bottom of the Policies page.

    !!! tip
        * The policy list is dependant on the selected Gateway (i.e. policy list under `Regular Gateway` is different to that of `Choreo Connect`).
        
        * Given below is the key difference between the two types apart from the actual policy logic.

        | Gateway         | Supported Flows         |
        |-----------------|-------------------------|
        | Regular Gateway | `Request`, `Response`, `Fault` |
        | Choreo Connect  | `Request`, `Response` |

        * Choreo Connect supports policies at **Operation level** 1.2.0 version onwards, while the older version Choreo Connect 1.1.0 only supports policies at resource level.

4. First let us consider the **API Level Policies** tab. You can attach any number of policies by dragging and dropping from the policy list to the dropzone appearing under the desired flow (i.e. request, response or fault). Since these policies are attached to the API level, upon API invocation these policies are engaged regardless of the resource that was invoked. 

    !!! note
        API level policies will execute before operation level policies

    [![Adding API level policies]({{base_path}}/assets/img/design/api-policies/attach-api-level-policies.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-api-level-policies.png)

5. Now let us consider the **Operation Level Policies** tab. Pick out the desired operation and flow to which you want to attach policies. Once that is decided, you can expand that API operation. At this point you will notice that by default the UI will open up the first API operation on initial page visit (for PizzaShack API, `/order POST` is expanded by default).

6.  Let’s attach a policy to the `/menu GET` operation. Scroll down through the left side column of the UI and click on `/menu GET` API operation. You should be able to see the below screen when the API operation is expanded.

    [![Operation for adding policies]({{base_path}}/assets/img/design/api-policies/attach-policies-2.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-2.png)

7. Drag the **Add Header** policy from the **Request** tab of the **Policy List** and drop that to the **Request Flow** dropzone of `/menu GET` operation. You will notice a side panel appearing from the right hand side. Fill the required details using the values provided below. Then, click **Save**.

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
        You can optionally use the **Apply to all** resources option to attach the same policy to all the resources. This will attach the same policy to all the API operations along with the values you entered to configure the policy (if any). It is important to note that if the policy was applied to the `Request Flow`, it will only be applied to all the request flows of all operations.

8. Now that we have saved the dropped policy, you should be able to see the attached **Add Header** policy (depicted with the initials `AH`).

    [![API Header policy]({{base_path}}/assets/img/design/api-policies/attach-policies-3.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-3.png)

9. If you click on this newly attached **AH** (i.e. Add Header) policy, you should still be able to view/edit values that you entered initially.

    [![API Header policy]({{base_path}}/assets/img/design/api-policies/attach-policies-4.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-4.png)

10. Let’s go ahead and attach a few more policies to the same **Request Flow**. Pick any amount of policies from the **Request** tab of the **Policy List**.

    [![Attach policies]({{base_path}}/assets/img/design/api-policies/attach-policies-5.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/attach-policies-5.png)

    !!! note
        * You can rearrange the dropped policies that are attached to the **Request Flow** of `/menu GET`

        * You can download the policy source as a `.zip` file by clicking the cloud download icon

        * If you click on the delete icon, the dropped policy is cancelled

11. Finally, when you are satisfied with the dragged and dropped policies, you can go ahead and click on the **Save** button at the bottom of the page. Note that if you do not click on save, none of the dropped policies will be saved to the API.

    [![Attach policies]({{base_path}}/assets/img/design/api-policies/save-attached-policies.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/save-attached-policies.png)

Once you drag and drop a default policy (Common policy that is accessible to all APIs) and save, to maintain the consistency of API object, the attached policy will be revisioned specific to the API. 
In case you delete the Common Policy from the publisher portal from the policies tab, this revision will be preserved as an API specific policy and once the policy is detached from the API, this revision will be cleared from the data storage.
If you have created a different policy with the same name after deleting the original policy, you have to detach and reattach the policy to the resources if you need to apply the new policy.
