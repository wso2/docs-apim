# Blacklisting and Whitelisting Requests

This section guides you through the following areas:

-   [IP Whitelisting](#ip-whitelisting)
    -   [Creating the Advanced Throttling policy](#creating-the-advanced-throttling-policy)
    -   [Engage the policy with an API](#engage-the-policy-with-an-api)
-   [Blacklisting requests](#blacklisting-requests)
    -   [Blacklisting PhoneVerification API](#blacklisting-phoneverification-api)
-   [Custom throttling](#custom-throttling)

### IP Whitelisting

IP whitelisting is a way of configuring a filter to extract a particular set of known IP addresses to grant access to API requests which are received from those IPs only. This can be achieved by creating and Advanced Throttling policy and attaching it to the required API.

##### Creating the Advanced Throttling policy

1.  Login to the admin portal of WSO2 API Manager (https://&lt;ip\_address&gt;:9443/admin).
2.  Open **Throttling Policies** tab and navigate to **Advanced Throttling.**
3.  Click ADD NEW POLICY to add a new Throttling tier.

    ![](../../assets/img/learn/ip-whitelisting-add-policy.png)

4.  Fill the details as below and click **Add Conditional Group** .

    ![](../../assets/img/learn/ip-whitelisting-add-conditional-group.png)

5.  Open the Conditional Group added and fill the details.

    | Property            | Value                                                                                                          |
    |---------------------|----------------------------------------------------------------------------------------------------------------|
    | IP Condition Policy | Checked                                                                                                        |
    | IP Condition Type   | Specific IP                                                                                                    |
    | IP Address          | <IP_Address_to_be_whitelisted> E.g. 193.100.3.106                                                              |
    | Invert Condition    | Checked (If Invert Condition check then condition only apply to the IPs which not mention in IP Address above) |
    | Request Count       | 0                                                                                                              |

    Following is an example configuration.

    ![](../../assets/img/learn/whitelist-specific-ip.png)
      
     <div class="admonition info">
    <p class="admonition-title">Note</p>  
    <p>In above configuration we are whitelisting a Specific IP.
    You can whitelist a range of IP as well by selecting **IP Range** for the IP Condition Type in the Conditional Group and specifying the range as follows.</p>
    </div>

    ![](../../assets/img/learn/ip-range-whitelisting.png)

6.  Click **Save** .
       
    You have now successfully created the policy. Now we should engage this policy to an API.

##### Engage the policy with an API

1.  Login to API Publisher https://:9443/publisher.
2.  Selct the API and go to the <b>Resources</b> menu.
3.  Enable **API level** under **Operational Configuration** and select the newly created Throttling policy.
    ![](../../assets/img/learn/apply-whitelist-to-api.png)
    
4.  Save and Publish the API.
    Now the API will be accessible only by the IP specified in the throttling policy.

    <div class="admonition info">
    <p class="admonition-title">Note</p>
    <p>
  The policy will be re-enforced for every unit time. Each time the policy is enforced a minimum of 1 request will be allowed to pass before blocking the requests. Having a smaller unit time will increase the frequency of requests passing through. Hence, having an larger unit time is suitable to minimize the number of requests passing through.
    </p>
   </div>

### Blacklisting requests

By blacklisting requests, you can protect servers from common attacks and abuse by users. For example, if a malicious user misuses the system, all requests received from that particular user can be completely blocked. Tenant administrative users can block requests based on the following parameters:

-   Block calls to specific APIs
-   Block all calls from a given application
-   Block requests coming from a specific IP address
-   Block a specific user from accessing APIs

To blacklist a request,

1.  Log in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials.
2.  Click **Black List** under the **Throttle Policies** section and click **Add Item** .

    ![](../../assets/img/learn/add-blacklist-policy.png)

Select the item to black list, enter a value and click **Blacklist** .

![](../../assets/img/learn/select-blacklist-condition.png)

<div class="admonition info">
    <p class="admonition-title">Note</p>
<p>You can temporary on/off the blacklisting condition by enabling/disabling the <b>Condition status</b> that is auto enabled when a blacklisting condition is created. </p>
</div>

![](../../assets/img/learn/blacklist-condition-status.png)

##### Blacklisting PhoneVerification API

As described above you can blacklist requests for APIs, by Applications, to IP Addresses and for Users. Let's see how we can blacklist the requests for an API.

1.  Log in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials.
2.  Click **Black List** under the **Throttle Policies** section and click **Add Item** .
3.  Select **API Context** and provide the Context of PhoneVerification API with version as the **Value.**

    ![](../../assets/img/learn/select-context-blacklist.png)

4.  Click **Blacklist.**
5.  Now login to API Developer Portal using the URL `https://localhost:9443/devportal` and invoke the API.
    You will see the following response.

    ![](../../assets/img/learn/blacklisted-api.png)