# Create a Policy

Listed below are two ways of creating a new policy. Depending on whether you need the policy to be accessible only within a specific API or available for all APIs, you can decide on the option you need to follow.

* Creating a Common Policy
* Creating an API Specific Policy

## Creating a Common Policy

A common policy is a globally maintained policy and you can easily utilize this policy at the operation level of any desired API. Note that these policies are not bound to any API and they are merely templates that you can easily use. Now let’s see how you can create such a policy. Follow the instructions below to create a new common policy.

1. Sign in to the WSO2 API Publisher.
    `https://<hostname>:9443/publisher`

2. Navigate to **Policies** tab from the left menu and click **Add New Policy**.

3. Let’s create a policy named **Sample Add Header** for demo purposes. First let’s fill the **General Details** section using the following details.

    <table>
        <th>
            <td>Field</td>
            <td>Sample Value</td>
        </th>
        <tr>
            <td>Name</td>
            <td>Sample Add Header</td>
        </tr>
        <tr>
            <td>Description</td>
            <td>Description of sample add header policy</td>
        </tr>
        <tr>
            <td>Applicable Flows</td>
            <td>Request, Response</td>
        </tr>
    </table>

4. Next, we move on to the **Gateway Specific Details** section. This is where we upload the policy file that contains the business logic of the policy. The sample policy that we are creating here will be for the regular Gateway (Synapse Gateway), and hence, the policy should be a .j2 or .xml file.

5. Final section in the form is the **Policy Attributes** section. These attributes are derived from the policy file that you uploaded in the previous step. If you observe the policy content you should notice two dynamic values embedded into that policy, namely the headerName and headerValue. Those are the attributes that we should include when creating our policy (note that you can have a static policy with no attributes if the policy content is static). Let’s fill the **Policy Attributes** section using the following details.

6. Once that is done, the completed form should look like the below screenshot. We can now click on **Save**.

7. Now the newly created policy will appear in the table. You can go ahead and search for this policy to verify.

8. Try viewing this policy by clicking on **View** action. Notice that you can download the policy as a .zip file using the **Download Policy** button.

## Creating an API Specific Policy

If you would rather create a policy that is local to the API, you can follow the below provided steps to create such a policy.

1. Sign in to the WSO2 API Publisher.
    `https://<hostname>:9443/publisher`

2. Click on any API (e.g., `PizzaShackAPI 1.0.0`) and navigate to the **Policies** tab. You will see a screen like below. Click on the **Add New Policy** button in order to create an API specific policy.

3. Then you will be prompted to enter the policy details. Let’s name this API specific policy as **Local Add Header**. Please refer to steps 3 to 5 from the common policy creation guide above to fill the rest of the form. Fully filled form should look like the below screenshot. Then click on **Save**.

4. You should be able to see a policy named **Local Add Header** under the **Request** tab and **Response** tab of the **Policy List**.

5. Once you hover over the Local Add Header policy that you created, you should be able to see the view icon and delete icon as shown through the screenshot below. If you click on the View action, you will be prompted with a populated policy form with the details you entered. If you choose to Delete the policy, you can click on the delete icon that appears on policy hover. Let’s go ahead and click on the delete action.

    !!! note 
        The common policies only permit the view action as opposed to the API specific policies that permit both view and delete actions. If you wish to delete a common policy, you need to navigate to the globally maintained common policy list to do so.

6. It will ask for your consent before deleting the API specific policy. On confirmation that policy will be deleted.

