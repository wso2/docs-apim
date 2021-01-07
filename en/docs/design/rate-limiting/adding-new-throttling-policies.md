# Adding New Throttling Policies

WSO2 API Manager admins can add new throttling policies and define extra properties to the throttling policies. To get started, click on the level of throttling that you want to add a new policy to:

-   [Advanced throttling policy](#adding-a-new-advanced-throttling-policy)
-   [Application-level throttling tier](#adding-a-new-application-level-throttling-tier)
-   [New subscription-level throttling tier](#adding-a-new-subscription-level-throttling-tier)

## Adding a new advanced throttling policy

You can add advanced throttling policies to both APIs and resources.

1.  Sign in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials (admin/admin by default).
2.  Click **Advanced Throttling** under the **Rate Limiting Policies** section to see the set of existing throttling tiers.
3.  To add a new tier, click **Add New Policy**.
    
    [![Add advanced policy page]({{base_path}}/assets/img/learn/new-advanced-throttling-tier.png)]({{base_path}}/assets/img/learn/new-advanced-throttling-tier.png)
    
4.  Fill in the required details and click **Add**.
    
    [![Add advanced policy page]({{base_path}}/assets/img/learn/save-advanced-policy.png)]({{base_path}}/assets/img/learn/save-advanced-policy.png)

    <div class="admonition info">
    <p class="admonition-title">Note</p>
    <p><b>Rate limiting based on request count or bandwidth</b></p>
    <p>
       <b>Request Count</b> and <b>Request Bandwidth</b> are the two options for default limit. You can use the option according to your requirement. Request Count is commonly used as the limiting option for API requests. If you are using APIs for File sharing and Data transmission you can use Request Bandwidth as your default limiting option.
    </p>
    </div>
   

    [![Add advanced policy page]({{base_path}}/assets/img/learn/add-request-bandwith-advanced-policy.png)]({{base_path}}/assets/img/learn/add-request-bandwith-advanced-policy.png)


4.  To add throttling limits with different parameters to the conditions below, click **Add Conditional Group**.

    <div class="admonition info">
    <p class="admonition-title">Note</p>

    <p><b>Enabling header, query param or JWT based rate limiting</b></p>

    <p>
        Note that if you want to add a header, query param, or JSON Web Token (JWT) claim condition, you need to set the `enable_header_based_throttling` , `enable_jwt_claim_based_throttling` or `enable_query_param_based_throttling` element to `true` (depending on which condition you need) under `[apim.throttling]` in the `repository/conf/deployment.toml` file.
        </p>
    </div>

    You can add Description about condition group by click **Description** under **Condition Group**.
    
    [![Add advanced policy page]({{base_path}}/assets/img/learn/new-conditional-groups.png)]({{base_path}}/assets/img/learn/new-conditional-groups.png)

     | Condition    | Description value |
    |---------------|-------------------|
    | IP Condition  | Allows you to set a throttling limit for a specific IP address or a range of IP addresses. |
    | Header Condition | Allows you to set a throttling limit to specific headers and parameters. |
    | Query Param Condition |Allows you to set a throttling limit to specific query parameters. |
    | JWT Claim Condition   | Allows you to set a throttling limit to specific claims.             

    <div class="admonition info">
    <p class="admonition-title">Note</p>
     
     <p><b>Conditional group evaluation</b></p>

    <p>The conditional group execution policy is used only for that condition. For example, if you add an IP condition and set the request count as shown in the above diagram, only 5 requests will be allowed per minute using that IP condition. The default limit will be applied for any request that evaluates to false with that condition (Outside that condition).</p>
    </div>


5.  Enter a condition and value.

    !!! note
        The IP-based advanced throttling expects the client IP in the **X-Forwarded-For** header, in order to detect the IP address and throttle out the request as specified in the IP condition configuration.

6.  Header condition and JWT claim condition values allow regex patterns to be defined.
    You can configure it to make either an exact match or a pattern match for the value using the regex values. For example:
    
    [![Add advanced policy page]({{base_path}}/assets/img/learn/new-header-condition-regex.png)]({{base_path}}/assets/img/learn/new-header-condition-regex.png)

    [![Add advanced policy page]({{base_path}}/assets/img/learn/new-jwt-condition-regex.png)]({{base_path}}/assets/img/learn/anew-jwt-condition-regex.png)

    <div class="admonition info">
    <p class="admonition-title">Note</p>
     
    <p><b>JWT condition</b></p> 

    <b>Claim name </b> : Name of the JWT Claim
    Example: 

    <ul>
        <li> "iss" - The issuer of the JWT</li>
        <li>" <http://wso2.org/claims/apicontext> " - Context of the API </li>
        <li>" <http://wso2.org/claims/version> " - API version </li>
   </ul>
 
    
    <b>Claim value </b> : Value to be checked in the corresponding claim. (allows regex patterns as well)

    <b> Invert condition </b> : Whether to take the throttle decision based on the equality of the values.
    Example: If the claim name is "iss" value is "wso2" and "invert condition" is off - Requests having "wso2" as "iss" claim will be throttled.
    If the claim name is "iss" value is "wso2" and "invert condition" is on - Requests not having "wso2" as "iss" claim will be throttled.
    </div>

7.  Once done, click **Add**.

    [![Add advanced policy page]({{base_path}}/assets/img/learn/add-condition-group.png)]({{base_path}}/assets/img/learn/add-condition-group.png)

You have added a new advanced throttling policy. You can now apply it to an API or a resource.

<div class="admonition info">
    <p class="admonition-title">Note</p>
     
<p><b> Adding multiple conditional groups</b></p> 

<p> You can configure multiple conditional groups when defining a tier for advanced throttling policies. For example, it is possible to apply both an IP based throttling and a query param condition in a single advanced policy. </p>
</div>

## Adding a new application-level throttling tier

Application-level throttling policies are applicable per access token generated for an application.

1.  Sign in to the Admin Portal using the URL https://localhost:9443/admin and your admin credentials (admin/admin by default).
2.  Click **Application Policies** under the **Rate Limiting Policies** section to see the set of existing throttling tiers.
3.  To add a new tier, click **Add Policy**.

    [![Add application policy page]({{base_path}}/assets/img/learn/new-application-policy.png)]({{base_path}}/assets/img/learn/new-application-policy.png)

4.  Fill in the required details and click **Save**.

    [![Add application policy page]({{base_path}}/assets/img/learn/save-new-application-policy.png)]({{base_path}}/assets/img/learn/save-new-application-policy.png)

You have added a new application-level throttling policy.

## Adding a new subscription-level throttling tier

1.  Sign in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials.
2.  Click **Subscription Policies** under the **Rate Limiting Policies** section. The existing set of throttling tiers are displayed.
3.  To add a new tier, click **Add Policy**.

    [![Add subscription policy page]({{base_path}}/assets/img/learn/add-subscription-policy.png)]({{base_path}}/assets/img/learn/add-subscription-policy.png)

    <div class="admonition info">
    <p class="admonition-title">Note</p>
    <p><b> Unauthenticated tier</b></p>
     <p>
    When you are adding a new Subscription level throttling tier, you will see the existing list of subscription tiers in the **Subscription Tier List**. In this list, you will find a tier named **Unauthenticated**, which has a request quota of 500. This is the subscription tier, which is automatically applied when the authentication type of your resources is **'None'.** That is when you can invoke APIs without tokens. And this tier is not visible in the throttling tier list of the application. </p>
    </div>    
4.  Fill in the details required by this form and click **Save** once you are done.

     [![Add subscription policy page]({{base_path}}/assets/img/learn/save-new-subscription-policy.png)]({{base_path}}/assets/img/learn/save-new-subscription-policy.png)

     Given below are the descriptions of the fields you find in the form:

     | Field  | Description     |                                                                           
     |--------|-----------------|
     | Request Count/Request Bandwidth | The maximum number of requests/maximum bandwidth allowed to the API within the time period given in the next field.|
     | Unit Time                       | Time within which the number of requests given in the previous field is allowed to the API. This can be defined in minutes, hours, days, weeks, months or years.                   |
     | Burst Control (Rate Limiting)   | You can define the request count/bandwidth per unit time on an addition layer by using rate limiting. This is usually a smaller number of requests/bandwidth for a shorter time span than what is enforced in the above fields. For instance, if there's a subscription level policy enforced over a long period, you may not want users to consume the entire quota within a short time span. Enforcing a rate limit protects the backend from sudden request bursts and controls the usage at a subscription and API level. |
     | Stop On Quota Reach             | This indicates the action to be taken when a user goes beyond the allocated quota. If the check box is selected, the user's requests are dropped and an error response (HTTP Status code 429) is given. If the check box is cleared, the requests are allowed to pass through.             |
     | Billing Plan                    | This field only makes sense if you have API Monetization enabled. The available **billing plans** are **Free, Commercial, and Freemium**. An API is tagged/labelled as Free, Paid, or Freemium depending on its subscription tiers(e.g., Unlimited, Gold, etc.), which are the tiers selected when creating an API. |
     | Custom Attributes               | You can choose to display additional information about tiers using custom attributes during custom implementations. The main objective of these fields are to provide more information regarding the tier to Application Developers at the time of API subscription. An example usage of custom attributes is API Monetization. See [Enabling Monetization of APIs-]({{base_path}}/learn/api-monetization/monetizing-an-api/) for more information on practical usage of custom attributes in the subscription tier.      |
     | Permissions                     | You can allow or deny permission for specific roles. Once permission is denied to a role, the new subscription tier that you add here will not be available to that role in the Developer Portal.          |
    
    <div class="admonition info">
    <p class="admonition-title">Note</p>
    <p><b> Billing plan</b></p>
    
     **Free** - If all subscription tiers are defined as Free, the API uses the **Free billing plan** and the API is labeled as Free in the Developer Portal.              **Paid** - If all subscription tiers are defined as Paid, the API uses the **Commercial billing plan** and the API is labeled as Paid in the Developer Portal.       
     **Freemium** - If the API has a combination of Free and Paid subscription tiers, the API uses the **Freemium billing plan** and the API is labeled as Freemium in the Developer Portal.                                                                                                                                                    <p>                                                            
      This labeling happens on the Developer Portal only if monetization has been enabled. For information on how to enable monetization and how to tag subscription tiers, see [Configuring API Monetization Category Labels]({{base_path}}/learn/api-monetization/configuring-api-monetization-category-labels/).   </p>                                                                                     
    </div>                                                                           
    You have now successfully added a new subscription-level throttling policy.
    
