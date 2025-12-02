# Manage Advanced Policies

Advanced rate limiting policies can be applied to both APIs and resources.

## Adding a New Advanced Rate Limiting Policy

1.  Sign in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials (admin/admin by default).
2.  Click **Advanced Throttling** under the **Rate Limiting Policies** section to see the set of existing rate limiting tiers.
3.  To add a new tier, click **Add New Policy**.
    
    [![Add advanced policy page]({{base_path}}/assets/img/learn/add-advanced-throttling-tier.png)]({{base_path}}/assets/img/learn/add-advanced-throttling-tier.png)
    
4.  Fill in the required details and click **Add**.
    
    [![Add advanced policy page]({{base_path}}/assets/img/learn/save-advanced-policy.png)]({{base_path}}/assets/img/learn/save-advanced-policy.png)

    <div class="admonition info">
    <p class="admonition-title">Note</p>
    <p><b>Rate limiting based on request count or bandwidth</b></p>
    <p>
       <b>Request Count</b> and <b>Request Bandwidth</b> are the two options for default limit. You can use the option according to your requirement. Request Count is commonly used as the limiting option for API requests. If you are using APIs for File sharing and Data transmission you can use Request Bandwidth as your default limiting option.
    </p>
    </div>
   
    [![Add advanced policy page]({{base_path}}/assets/img/learn/add-request-bandwith-advanced-policy.png)]({{base_path}}/assets/img/learn/add-request-bandwith-advanced-policy.png)

You have added a new advanced rate limiting policy. You can now apply it to an API or a resource.

## Adding Conditional Groups

You can add rate limiting limits with different parameters to the conditions by adding conditional groups.

5.  To add conditional groups, click **Add Conditional Group**.

     <div class="admonition info">
     <p class="admonition-title">Note</p>

     <p><b>Enabling header, query param or JWT based rate limiting</b></p>
     <p><ul>
     <li>IP based throttling is enabled by default.
     </li>
     <li>
     Note that if you want to add a header, query param, or JSON Web Token (JWT) claim condition, you need to set the `enable_header_based_throttling` , `enable_jwt_claim_based_throttling` or `enable_query_param_based_throttling` element to `true` (depending on which condition you need) under `[apim.throttling]` in the `repository/conf/deployment.toml` file.</li>
      ```toml
      [apim.throttling]
      enable_header_based_throttling = true
      enable_jwt_claim_based_throttling = true
      enable_query_param_based_throttling = true
      ```
     <li>This JWT is the backend JWT and not the one you use to invoke it. In addition, you need to enable the Backend JWT token to get this rate limiting flow to work.
     </li></ul>
     </p>
    </div>

     You can add a description about the condition group by clicking **Description** under **Condition Group**.
    
     [![Add advanced policy page]({{base_path}}/assets/img/learn/new-conditional-groups.png)]({{base_path}}/assets/img/learn/new-conditional-groups.png)

     | Condition    | Description value |
     |---------------|-------------------|
     | IP Condition  | Allows you to set a rate limiting limit for a specific IP address or a range of IP addresses. |
     | Header Condition | Allows you to set a rate limiting limit to specific headers and parameters. |
     | Query Param Condition |Allows you to set a rate limiting limit to specific query parameters. |
     | JWT Claim Condition   | Allows you to set a rate limiting limit to specific claims.             

     <div class="admonition info">
     <p class="admonition-title">Note</p>
     
     <p><b>Conditional group evaluation</b></p>

     <p>The conditional group execution policy is used only for that condition. For example, if you add an IP condition and set the request count as shown in the above diagram, only 5 requests will be allowed per minute using that IP condition. The default limit will be applied for any request that evaluates to false with that condition (Outside that condition).</p>
     </div>

6.  Enter a condition and value.

    !!! note
        The IP-based advanced rate limiting expects the client IP in the **X-Forwarded-For** header, in order to detect the IP address and throttle out the request as specified in the IP condition configuration.

7.  Header condition and JWT claim condition values allow regex patterns to be defined.
    You can configure it to make either an exact match or a pattern match for the value using the regex values. For example:
    
    [![Add advanced policy page]({{base_path}}/assets/img/learn/new-header-condition-regex.png){:style="width:45%"}]({{base_path}}/assets/img/learn/new-header-condition-regex.png)

    [![Add advanced policy page]({{base_path}}/assets/img/learn/new-jwt-condition-regex.png){:style="width:45%"}]({{base_path}}/assets/img/learn/anew-jwt-condition-regex.png)

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

    !!! note
        This JWT claim is the backend JWT and not the one you use to invoke it. Also, you need to enable the Backend JWT token to get this rate limiting flow to work.

8.  Once done, click **Add**.

    [![Add advanced policy page]({{base_path}}/assets/img/learn/add-condition-group.png)]({{base_path}}/assets/img/learn/add-condition-group.png)

<div class="admonition info">
    <p class="admonition-title">Note</p>
     
<p><b> Adding multiple conditional groups</b></p> 

<p> You can configure multiple conditional groups when defining a tier for advanced rate limiting policies. For example, it is possible to apply both an IP based rate limiting and a query parameter condition in a single advanced policy. </p>
</div>


## Allowed IPs

When requests to an API should be permitted from only a set of known/trusted IPs, you can achieve this by configuring a group of Allowed IPs through the Advanced Rate Limiting feature.

### Creating the Advanced Rate Limit Policy for Allowed IPs

1.  Login to the Admin Portal of WSO2 API Manager (https://&lt;ip\_address&gt;:9443/admin).
2.  Under the **Rate Limiting Policies** tab, navigate to **Advanced Policies.**
3.  Click **Add New Policy** to add a new Rate Limit tier.

    [![Allowed IP add policy]({{base_path}}/assets/img/learn/add-advanced-throttling-tier.png)]({{base_path}}/assets/img/learn/add-advanced-throttling-tier.png)

4.  Fill the details and click **Add Conditional Group**.

    [![Allowed IP add conditional group]({{base_path}}/assets/img/learn/allowed-ip-add-conditional-group.png)]({{base_path}}/assets/img/learn/allowed-ip-add-conditional-group.png)

5.  Open the Conditional Group added and fill the details.

    | Property            | Value                                                                                                          |
    |---------------------|----------------------------------------------------------------------------------------------------------------|
    | IP Condition Type   | Specific IP                                                                                                    |
    | IP Address          | <IP_Address_to_be_allowed> E.g. 193.100.3.106                                                                  |
    | Invert Condition    | Checked (If the 'Invert Condition' is checked, then the condition applies only to the IPs not mentioned in the 'IP Address'.) |
    | Request Count       | 0                                                                                                              |

    Following is an example configuration.

    [![New allow specific IP]({{base_path}}/assets/img/learn/new-allow-specific-ip.png)]({{base_path}}/assets/img/learn/new-allow-specific-ip.png)
    
    [![Save allow specific IP]({{base_path}}/assets/img/learn/save-allow-specific-ip.png)]({{base_path}}/assets/img/learn/save-allow-specific-ip.png)
      
     <div class="admonition info">
    <p class="admonition-title">Note</p>  
    <p>In the above configuration we are allowing a Specific IP address to access an API.
    You can allow a range of IPs as well by selecting **IP Range** for the IP Condition Type in the Conditional Group and specifying the range as follows.</p>
    </div>

    [![New allowed IP range]({{base_path}}/assets/img/learn/new-allowed-ip-range.png)]({{base_path}}/assets/img/learn/new-allowed-ip-range.png)

6.  Click **Save**.
       
You have now successfully created the policy.

<div class="admonition info">
    <p class="admonition-title">Note</p>
    <p>
  The policy will be re-enforced for every unit time. Each time the policy is enforced a minimum of 1 request will be allowed to pass before blocking requests. Having a smaller unit time will increase the frequency of requests passing through. Hence, having a larger unit time is suitable to minimize the number of requests passing through.
    </p>
   </div>
