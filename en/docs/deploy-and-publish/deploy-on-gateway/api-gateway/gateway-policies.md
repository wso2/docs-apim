#Gateway Policies

In WSO2 API Manager, managing Global Level Policies within the gateway infrastructure is made easier. This streamlines policy handling, eliminating the need for administrators to manually create XML-type policy files. This feature facilitates a user-friendly approach to handling policies, eliminates the requirement for manual XML creation and placement in specific directories, and enhances control by providing a clear interface for creating, deploying, and undeploying policies, offering administrators better control over policy management.

!!! note
    Policies added globally using the older approach: creating XML files following the naming pattern `WSO2AM--Ext--<DIRECTION>` and saving them in the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences` directory, will not be overridden by the global policies added through the UI. Initially, the system will execute the policies added via manual files and then proceed to execute the policies deployed from the UI.

!!! warning
    A specific gateway with active global policy deployments will apply to all the APIs deployed on that gateway. Similarly, this applies to tenants within the tenant available setup. Global policies will be applied to all APIs belonging to a specific gateway in the tenant corresponding to the logged-in tenant during the deployment of the global policy.

!!!info
    Although all managing actions can be taken by Admin users with specific scopes, API creators and publishers can view the meta information of global policies such as names, descriptions, policy mappings, and deployed gateway labels.

## Step 1 - Create a gateway policy

Follow the instructions provided below to create a gateway policy:

1. {!includes/sign-in-publisher.md!}

2. Navigate to **Global Policies** in the left menu and proceed to select **Global Policies**.

    The **Create A New Global Policy** page appears.

    [![Global policies startup]({{base_path}}/assets/img/deploy/gateway/global-polices-fresh-start.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/gateway/global-polices-fresh-start.png)

3. Update the policy name and description, then simply drag and drop the desired policies onto the respective flows to attach them.

    Let's create a sample gateway policy mapping following the steps below:

    - Navigate to the Request tab of the Policy List.
    - Drag the **Add Header** policy and drop it into the Request Flow dropzone. This action triggers a side panel to appear on the right-hand side.
    - Fill in the necessary details using the provided values below.

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

    - Finally, click **Save** to complete the process.

        [![Save individual policy data]({{base_path}}/assets/img/deploy/gateway/global-polices-add-header-policy.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/gateway/global-polices-add-header-policy.png)

        !!!note
            All the policies listed for addition as global policies are [common policies]({{base_path}}/design/api-policies/create-policy/).

    - After saving the dropped policy, you should now be able to view the associated **Add Header** policy indicated by the initials **AH**.

    - If you click on the recently attached **AH (Add Header)** policy, you'll still have access to view and edit the initially entered values.

        [![View added common policy]({{base_path}}/assets/img/deploy/gateway/global-polices-add-header-policy-view.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/gateway/global-polices-add-header-policy-view.png)

    - Let's proceed by adding several more policies to the existing Request Flow. Choose any number of policies from the Request tab within the Policy List.

        [![Add multiple common policies to a flow]({{base_path}}/assets/img/deploy/gateway/global-polices-add-multiple-policies.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/gateway/global-polices-add-multiple-policies.png)

        !!! note
            - You can rearrange the dropped policies that are attached to the Request Flow.
            - You can download the policy source as a .zip file by clicking the cloud download icon.
            - Clicking on the delete icon cancels the dropped policy.

4. When you have finalized the dragged and dropped policies to your preference, proceed by clicking the **Save** button situated at the bottom of the page.

    [![Save global policy]({{base_path}}/assets/img/deploy/gateway/global-polices-save-policy-mapping.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/gateway/global-polices-save-policy-mapping.png)

## Step 2 - Deploy a gateway policy

- Upon the existence of at least one gateway policy in the queue, it will be displayed in the **Global Policies** tab.

    [![Global policy listing]({{base_path}}/assets/img/deploy/gateway/global-polices-list.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/gateway/global-polices-list.png)

- Click on the expandable button at the beginning of the policy entry row to choose from available gateway labels for deploying the respective global policy.

    !!! note
        The selection will not display gateway labels that have active global policy deployment. This is because a particular gateway can have only one active gateway policy deployment.

- After selecting the required gateway labels, click the **Deploy** button. A confirmation dialog box will appear, and upon clicking the **Deploy** button within the dialog, the selected gateway policy will be deployed to the chosen gateway environments.

    [![Deploy global policy]({{base_path}}/assets/img/deploy/gateway/global-polices-deploy-to-gateway.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/gateway/global-polices-deploy-to-gateway.png)

To undeploy a gateway policy from any gateway environment, simply click on the cloud off button placed in front of each gateway label. Similarly, just as during deployment, an undeployment confirmation dialog box will prompt you for confirmation.

[![Undeploy gateway policy]({{base_path}}/assets/img/deploy/gateway/global-polices-undeploy.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/gateway/global-polices-undeploy.png)

## See Also

You can engage policies with APIs and their resources:

[Attaching API Policies]({{base_path}}/design/api-policies/attach-policy/)
