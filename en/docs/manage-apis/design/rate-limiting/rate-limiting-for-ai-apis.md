# Rate Limiting for AI APIs

## Overview

AI APIs in the WSO2 API Manager use the token based rate limiting policies in subscriptions by way of business plans. These policies allow for granular control of how AI APIs are used by applications.

AI API subscription policies can be created and customized based on the following quotas:

- **Request Count** - This quota limits the total number of requests an application can make. Once the specified request count limit is reached, further requests from that application will be throttled, preventing access to the AI API until the quota is reset.

- **Total Token Count** - The total token count refers to the aggregate number of tokens consumed by an application across all its interactions with an AI API. Once the total token count exceeds the limit, the application will be throttled.

- **Prompt Token Count** - This quota limits the number of tokens used specifically for AI prompt processing. Once the prompt token count limit is exceeded, the application will be throttled, ensuring that excessive prompts do not overuse the AI API resources.

- **Completion Token Count** - Completion tokens refer to the tokens generated as a response from the AI API. A limit can be set for the completion token count, and when the limit is reached, the API Gateway will throttle further completions for the application.


## Adding a New AI API Subscription Throttling Policy

1.  Sign in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials.
2.  Click **Subscription Policies** under the **Rate Limiting Policies** section. The existing set of rate limiting tiers are displayed.
3.  To add a new tier, click **Add AI Policy**.

    [![Add subscription policy page]({{base_path}}/assets/img/design/rate-limiting/add-ai-subscription-policy.png)]({{base_path}}/assets/img/design/rate-limiting/add-ai-subscription-policy.png)

4.  Fill in the details required by this form and click **Save** once you are done.

     [![Add subscription policy page]({{base_path}}/assets/img/design/rate-limiting/save-new-ai-subscription-policy.png)]({{base_path}}/assets/img/design/rate-limiting/save-new-ai-subscription-policy.png)


     Given below are the descriptions of the fields you find in the form:

     | Field  | Description     |                                                                           
     |--------|-----------------|
     | Request Count | The maximum number of requests allowed to the AI API within the time period given in unit time field.|
     | Total/Prompt/Completion Token Count | The maximum number of tokens (total/prompt/completion) allowed to the AI API within the time period given in unit time field.|
     | Unit Time                       | Time within which the number of requests given in the previous field is allowed to the API. This can be defined in minutes, hours.                   |
     | Stop On Quota Reach             | This indicates the action to be taken when a user goes beyond the allocated quota. If the check box is selected, the user's requests are dropped and an error response (HTTP Status code 429) is given. If the check box is cleared, the requests are allowed to pass through.             |
     | Billing Plan                    | This field only makes sense if you have API Monetization enabled. The available **billing plans** are **Free and Commercial**. An API is tagged/labelled as Free or Paid depending on its subscription tiers(e.g., Unlimited, Gold, etc.), which are the tiers selected when creating an API. |
     | Custom Attributes               | You can choose to display additional information about tiers using custom attributes during custom implementations. The main objective of these fields are to provide more information regarding the tier to Application Developers at the time of API subscription. An example usage of custom attributes is API Monetization. See [Enabling Monetization of APIs-]({{base_path}}/manage-apis/design/api-monetization/monetizing-an-api/) for more information on practical usage of custom attributes in the subscription tier.      |
     | Permissions                     | You can allow or deny permission for specific roles. Once permission is denied to a role, the new subscription tier that you add here will not be available to that role in the Developer Portal.   


## Business Plans

The API Creators need to select a minimum of one business plan when creating an AI API through the API-M publisher portal. These business plans can be either a default business plan or a custom business plan created through the API-M admin portal. The business plans are used to enforce rate limiting by allowing you to limit the number of events via the AI API during a given period of time.


[![AI API Business Plans]({{base_path}}/assets/img/design/rate-limiting/ai-api-business-plans.png)]({{base_path}}/assets/img/design/rate-limiting/ai-api-business-plans.png)



