# Adding New Throttling Policies

WSO2 API Manager admins can add new throttling policies and define extra properties to the throttling policies. To get started, click the level of throttling that you want to add a new policy to:

-   [Adding a new advanced throttling policy](#AddingNewThrottlingPolicies-Addinganewadvancedthrottlingpolicy)
-   [Adding a new application-level throttling tier](#AddingNewThrottlingPolicies-Addinganewapplication-levelthrottlingtier)
-   [Adding a new subscription-level throttling tier](#AddingNewThrottlingPolicies-Addinganewsubscription-levelthrottlingtier)

!!! warning
To make changes in the throttling configurations, set the `EnableAdvanceThrottling` parameter in api `-manager.xml` . This parameter is set to `true` by default. If you set it to `false` , you only see the available tiers.
![](attachments/50518321/59575603.png){height="250"}


### Adding a new advanced throttling policy

You can add advanced throttling policies to both APIs and resources.

1.  Sign in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials (admin/admin by default).
2.  Click **Advanced Throttling** under the **Throttle Policies** section to see the set of existing throttling tiers.
3.  To add a new tier, click **Add Tier** .
    ![](attachments/103334984/103334995.png)4.  Fill in the required details and click **Save** .

    ![](attachments/103334984/103334994.png)
    ![](attachments/103334984/103334986.png)
        !!! info
    **Request Count** and **Request Bandwidth** are the two options for default limit. You can use the option according to your requirement. For example, If your using API for File sharing, Data transmission you can use request bandwidth option and limit the data bandwidth for given time unit.


5.  To add throttling limits with different parameters to the conditions below, click **Add Conditional Group** .

        !!! note
    Note that if you want to add a header, query param, or JSON Web Token (JWT) claim condition, you need to set the `<EnableHeaderConditions>` , `<EnableJWTClaimConditions>` or `<EnableQueryParamConditions>` element to `true` (depending on which condition you need) in the `repository/conf/api-manager.xml` file.


    You can add Description about condition group by click **Sample description about condition group** under **Condition Group.**

    ![](attachments/103334984/103334989.png)
    | Condition             | Description                                                                                |
    |-----------------------|--------------------------------------------------------------------------------------------|
    | IP Condition          | Allows you to set a throttling limit for a specific IP address or a range of IP addresses. |
    | Header Condition      | Allows you to set a throttling limit to specific headers and parameters.                   |
    | Query Param Condition | Allows you to set a throttling limit to specific query parameters.                         |
    | JWT Claim Condition   | Allows you to set a throttling limit to specific claims.                                   |

        !!! note
    Conditional group Execution policy used only for that condition. For example, If you add IP condition and set request count as shown in above diagram then only 5 requests allow per 1 minute using that IP condition. Any request comes with false condition(Outside that condition) taken to the default limit.


6.  Turn on the required condition and enter a condition and value.
7.  Header condition and JWT claim condition values allow regex patterns to be defined.
    You can configure it to make either an exact match or a pattern match for the value using the regex values. For example,
    ![](attachments/103334984/103334988.png)
        !!! note
    Claim name : Name of the JWT Claim
    Eg : "iss" - The issuer of the JWT, " <http://wso2.org/claims/apicontext> " - Context of the API, " <http://wso2.org/claims/version> " - API version

    Claim value : Value to be checked in the corresponding claim. (allows regex patterns as well)

    Invert condition : Whether to take the throttle decision based on the equality of the values.
    Eg : If the claim name is "iss" value is "wso2" and "invert condition" is off - Requests having "wso2" as "iss" claim will be throttled.
    If the claim name is "iss" value is "wso2" and "invert condition" is on - Requests not having "wso2" as "iss" claim will be throttled.


8.  Once done, click **Add** .

You have added a new advanced throttling policy. You can now apply it to an API or a resource.

!!! note
You possibly can configure multiple conditional groups when defining a tier for advanced throttling policies. For example, Its possible to apply IP based throttling and query pram condition both in one advanced policy tier.


### Adding a new application-level throttling tier

Application-level throttling policies are applicable per access token generated for an application.

1.  Sign in to the Admin Portal using the URL https://localhost:9443/admin and your admin credentials (admin/admin by default).
2.  Click **Application Tiers** under the **Throttle Policies** section to see the set of existing throttling tiers.
3.  To add a new tier, click **Add New Policy** .
    ![](attachments/103334984/103334993.png)4.  Fill in the required details and click **Save** .
    ![](attachments/103334984/103334992.png)
You have added a new application-level throttling policy.

### Adding a new subscription-level throttling tier

1.  Sign in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials.
2.  Click **Subscription Policies** under the **Throttling Policies** section. The existing set of throttling tiers are displayed.
3.  To add a new tier, click **Add New Policy** .
    ![](attachments/103334984/103334985.png)
        !!! info
    When you are going to add a new Subscription level throttling tier, you can see the existing list of subscription tiers in **Subscription Tier List** . In this list, you will find a tier named **Unauthenticated** which have a request quota of 500. This is a subscription tier which automatically applied when the authentication type of your resources is **'None'.** That is, when you can invoke APIs without tokens. And this tier is not visiblie in the Throttling tier list of the application.


4.  Fill in the details required by this form and click **Save** once you are done.
    ![](attachments/103334984/103334990.png)

    Given below are the descriptions of the fields you find in the form:

    | Field                           | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
    |---------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | Request Count/Request Bandwidth | The maximum number of requests/maximum bandwidth allowed to the API within the time period given in the next field.                                                                                                                                                                                                                                                                                                                                                                                                           |
    | Unit Time                       | Time within which the number of requests given in the previous field is allowed to the API. This can be defined in minutes, hours, days, weeks, months or years.                                                                                                                                                                                                                                                                                                                                                              |
    | Burst Control (Rate Limiting)   | You can define the request count/bandwidth per unit time on an addition layer by using rate limiting. This is usually a smaller number of requests/bandwidth for a shorter time span than what is enforced in the above fields. For instance, if there's a subscription level policy enforced over a long period, you may not want users to consume the entire quota within a short time span. Enforcing a rate limit protects the backend from sudden request bursts and controls the usage at a subscription and API level. |
    | Stop On Quota Reach             | This indicates the action to be taken when a user goes beyond the allocated quota. If the check box is selected, the user's requests are dropped and an error response (HTTP Status code 429) is given. If the check box is cleared, the requests are allowed to pass through.                                                                                                                                                                                                                                                |
    | Billing Plan                    | This field only makes sense if you have API Monetization enabled. The available **billing plans** are **Free, Commercial, and Freemium** . An API is tagged/labelled as Free, Paid, or Freemium depending on its subscription [tiers](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-Throttlingtiers) (e.g., Unlimited, Gold, etc.), which are the tiers selected when creating an API.                                                                                                                         
      -   **Free** - If all subscription tiers are defined as Free, the API uses the **Free billing plan** and the API is labeled as Free in the Store.                                                                                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
      -   **Paid** - If all subscription tiers are defined as Paid, the API uses the **Commercial billing plan** and the API is labeled as Paid in the Store.                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
      -   **Freemium** - If the API has a combination of Free and Paid subscription tiers, the API uses the **Freemium billing plan** and the API is labeled as Freemium in the Store.                                                                                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
      This labeling happens on the API Store only if monetization has been enabled. For information on how to enable monetization and how to tag subscription tiers, see [Configuring API Monetization Category Labels](https://docs.wso2.com/display/AM260/Configuring+API+Monetization+Category+Labels) .                                                                                                                                                                                                                          |
    | Custom Attributes               | You can choose to display addtional information about tiers using custom attributes, during custom implementations. The main objective of these fields are to provide more information regarding the tier to Application Developers at the time of API subscription. An example usage of custom attributes is API Monetization. See [Enabling Monetization of APIs-](https://docs.wso2.com/pages/viewpage.action?pageId=97564601) for more information on practical usage of custom attributes in the subscription tier.      |
    | Permissions                     | You can allow or deny permission for specific roles. Once permission is denied to a role, the new subscription tier that you add here will not be available to that role in the API Store.                                                                                                                                                                                                                                                                                                                                    |

    You have added a new subscription-level throttling policy.


