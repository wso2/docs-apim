# JWT Claim Based Access Validator

This policy provides the capability to restrict access to an API resource based on a custom claim value provided in the JWT access token.
The policy allows configuring a custom claim name and its value along with an optional regex.
If a regex is configured, the configured claim value and token claim value will be matched using the regex. Otherwise, the claims will be matched for equality.

To apply this policy, follow the below steps:

1.  Select any API and from the Left Menu, go to **API Configurations** --> **Policies**.
2.  Under the **Policy List** that appear on the right side of the screen, look for the **JWT claim based access validator** policy from the `Request` tab.

    [![JWT claim based access validator]({{base_path}}/assets/img/design/api-policies/jwt-claim-based-access-validation-policy.png)]({{base_path}}/assets/img/design/api-policies/jwt-claim-based-access-validation-policy.png)

3.  Drag and drop the **JWT claim based access validator** policy from the policy list to the request flow of any desired API operation. In the below screenshot, the policy was dropped to the `/order POST` operation.

    Configure the custom claim name and value. If required, configure a regex so the claim value will be validated using it.

    In the policy configuring panel that appears from the right, select `Apply to all resources` option if you wish to attach the JWT claim based access validation policy to each and every resource of the current API. If you only wish to attach the policy to a particular API operation, leave the checkbox as it is. Then, click on **Save** button.

    [![JWT claim based access validator]({{base_path}}/assets/img/design/api-policies/configure-jwt-claim-based-access-validation-policy.png)]({{base_path}}/assets/img/design/api-policies/configure-jwt-claim-based-access-validation-policy.png)

4.  Finally, scroll down and click on the **Save** button in order to apply the attached policies to the API.

    [![JWT claim based access validator]({{base_path}}/assets/img/design/api-policies/save-attached-policies.png)]({{base_path}}/assets/img/design/api-policies/save-attached-policies.png)

Once the API is deployed and published, every request that goes to this API resource will be validated against the custom claim that comes in the access token before sending it to the backend.

!!! tip
To invert the above validation, you can tick the **Allow flow when claims are not matching** of the policy. This will only allow the flow if the claim values are not matching.
