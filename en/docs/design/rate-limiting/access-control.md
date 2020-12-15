# Access Control for API requests

This section guides you through the following areas:

-   [Allowed IPs](#allowed-ips)
    -   [Creating the Advanced Throttling policy](#creating-the-advanced-rate-limit-policy)
    -   [Engage the policy with an API](#engage-the-policy-with-an-api)
-   [Denying requests](#denying-requests)
    -   [Denying the PhoneVerification API](#denying-phoneverification-api)

### Allowed IPs

When requests to an API are to be permitted from a set of known/trusted IPs only, you can achieve this by configuring a group of Allowed IPs through the Advanced Rate Limiting feature.

##### Creating the Advanced Rate Limit policy

1.  Login to the admin portal of WSO2 API Manager (https://&lt;ip\_address&gt;:9443/admin).
2.  Under the **Rate Limiting Policies** tab and navigate to **Advanced Policies.**
3.  Click Add New Policy to add a new Rate Limit tier.

    ![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/allowed-ip-add-policy.png)

4.  Fill the details as below and click **Add Conditional Group**.

    ![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/allowed-ip-add-conditional-group.png)

5.  Open the Conditional Group added and fill the details.

    | Property            | Value                                                                                                          |
    |---------------------|----------------------------------------------------------------------------------------------------------------|
    | IP Condition Type   | Specific IP                                                                                                    |
    | IP Address          | <IP_Address_to_be_allowed> E.g. 193.100.3.106                                                                  |
    | Invert Condition    | Checked (If the 'Invert Condition' is checked, then the condition applies only to the IPs not mentioned in the 'IP Address'.) |
    | Request Count       | 0                                                                                                              |

    Following is an example configuration.

    ![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/new-allow-specific-ip.png)
    
    ![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/save-allow-specific-ip.png)
      
     <div class="admonition info">
    <p class="admonition-title">Note</p>  
    <p>In the above configuration we are allowing a Specific IP address to access an API.
    You can allow a range of IPs as well by selecting **IP Range** for the IP Condition Type in the Conditional Group and specifying the range as follows.</p>
    </div>

    ![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/new-allowed-ip-range.png)

6.  Click **Save**.
       
    You have now successfully created the policy. Now we should engage this policy to an API.

##### Engage the policy with an API

1.  Login to API Publisher https://:9443/publisher.
2.  Select the API and go to the <b>Resources</b> menu.
3.  Enable **API level** under **Operational Configuration** and select the newly created Throttling policy.
    ![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/apply-allowlist-to-api.png)
    
4.  Save and Publish the API.
    Now the API will be accessible only by the IP specified in the throttling policy.

    <div class="admonition info">
    <p class="admonition-title">Note</p>
    <p>
  The policy will be re-enforced for every unit time. Each time the policy is enforced a minimum of 1 request will be allowed to pass before blocking requests. Having a smaller unit time will increase the frequency of requests passing through. Hence, having an larger unit time is suitable to minimize the number of requests passing through.
    </p>
   </div>

### Denying requests

By denying requests, you can protect servers from common attacks and abuse by users. For example, if a malicious user misuses the system, all requests received from that particular user can be completely blocked. Tenant administrative users can block requests based on the following parameters:

-   Block calls to specific APIs
-   Block all calls from a given application
-   Block requests coming from a specific IP address
-   Block a specific user from accessing APIs

To deny a request,

1.  Log in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials.
2.  Click **Deny Policies** under the **Rate Limiting Policies** section and click **Add Policy**.

    ![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/add-denied-policy.png)

Select the item to deny, enter a value and click **Deny**.

![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/select-denied-condition.png)
<div class="admonition info">
    <p class="admonition-title">Note</p>
<p>You can temporary switch on/off the denied condition by enabling/disabling the <b>Condition status</b> that is auto enabled when a denied condition is created. </p>
</div>

![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/denied-condition-status.png)

##### Denying PhoneVerification API

As described above you can deny requests for APIs, by Applications, to IP Addresses and for Users. Let's see how we can deny requests to an API.

1.  Log in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials.
2.  Click **Deny Policies** under the **Rate Limiting Policies** section and click **Add Policy**.
3.  Select **API Context** and provide the Context of PhoneVerification API with version as the **Value.**

    ![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/select-context-deny.png)

4.  Click **Deny.**
5.  Now login to API Developer Portal using the URL `https://localhost:9443/devportal` and invoke the API.
    You will see the following response.

    ![Advanced Rate Limit policy]({{base_path}}/assets/img/learn/denied-api.png)