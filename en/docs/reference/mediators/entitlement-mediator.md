# Entitlement Mediator

The **Entitlement Mediator** intercepts requests and evaluates the actions performed by a user against an [eXtensible Access Control Markup Language (XACML)](http://en.wikipedia.org/wiki/XACML) policy. This supports XACML 2.0 and 3.0. WSO2 Identity Server can be used as the XACML Policy Decision Point (PDP) where the policy is set, and the Micro Integrator serves as the XACML Policy Enforcement Point (PEP) where the policy is enforced.

## Syntax

``` java
<entitlementService remoteServiceUrl="" remoteServiceUserName="" remoteServicePassword="" callbackClass="org.wso2.carbon.identity.entitlement.mediator.callback.[UTEntitlementCallbackHandler|X509EntitlementCallbackHandler|SAMLEntitlementCallbackHandler|KerberosEntitlementCallbackHandler]" 
client="soap|basicAuth|thrift|wsXacml">
   <onReject/>
   <onAccept/>
   <advice/>
   <obligations/>
</entitlementService>
```

## Configurations

When you add the Entitlement mediator to a sequence, the Entitlement mediator node appears as follows with four sub elements. These sub elements are used to define a mediation sequence to be applied based on the entitlement result.

The following are descriptions for the four sub elements of the Entitlement mediator.

| Parameter Name  | Description                                                                                                               |
|-----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **OnAccept**    | The sequence to execute when the result returned by the Entitlement mediator is `             Permit            ` . For example, you can configure the sequence to direct the request to the back end server as requested.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **OnReject**    | The sequence to execute when the result returned by the Entitlement mediator is `             Deny            ` , `             Not Applicable            ` or `             Indeterminate            ` . For example, you can configure the sequence to respond to the client with the message `             Unauthorized Request.            `                                                                                                                                                                                                                                                                                                                                 |
| **Obligations** | The sequence to execute when the XACML response contains an obligation statement. When this response is received, the Entitlement mediator clones the current message context, creates a new message context, adds the obligation statement to the SOAP body and then executes the sequence. Since the **Obligations** sequence is executed synchronously, the Entitlement mediator waits for a response. If the sequence returns a `             true            ` value, the sequence defined for the **OnAccept** sub element is applied. If the sequence returns a `             false            ` value, the sequence defined for the **OnReject** sub element is applied. |
| **Advice**      | The sequence to execute when the XACML response contains an advice statement. When this response is received, the Entitlement mediator clones the current message context, creates a new message context, adds the advice statement to the SOAP body and then executes the sequence. Since the **Advice** sequence is executed asynchronously, the Entitlement mediator does not wait for a response.           |                                                                                                                                                                                                      The parameters available for configuring the Entitlement mediator are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Entitlement Server</strong></td>
<td>Server URL of the WSO2 Identity Server that acts as the PDP (e.g., https://localhost:9443/services ).</td>
</tr>
<tr class="even">
<td><strong>User Name</strong></td>
<td>This user should have permissions to log in and manage configurations in the WSO2 Identity Server.</td>
</tr>
<tr class="odd">
<td><strong>Password</strong></td>
<td>The password of the username entered in the <strong>User Name</strong> parameter.</td>
</tr>
<tr class="even">
<td><strong>Entitlement Callback Handler</strong></td>
<td><div class="content-wrapper">
<p>The handler that should be used to get the subject (user name) for the XACML request.</p>
<p>You need to secure the proxy service, which uses the Entitlement mediator using one of the following methods and select the <strong>Entitlement Callback Handler</strong> based on the method you used.</p>
<ul>
<li><strong>UT</strong> : This class looks for the subject name in the Axis2 message context under the username property. This is useful when the UsernameToken security is enabled for a proxy service, because when the user is authenticated for such a proxy service, the username would be set in the Axis2 message context. As a result, the Entitlement mediator would automatically get the subject value for the XACML request from there. This is the default callback class.</li>
<li><strong>X509</strong>: Specify this class if the proxy is secured with X509 certificates.</li>
<li><strong>SAML</strong>: Specify this class if the proxy is secured with WS-Trust.</li>
<li><p><strong>Kerberos</strong>: Specify this class if the proxy is secured with Kerberos.</p></li>
<li><p><strong>Custom</strong>: This allows you to specify a custom entitlement callback handler class.</p></li>
</ul>
<p>You can also set properties that control how the subject is retrieved; see <a href="#advanced-callback-properties">Advanced Callback Properties</a> .</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Entitlement Service Client</strong></td>
<td><div class="content-wrapper">
<p>The method of communication to use between the PEP and the PDP. For SOAP, choose whether to use Basic Authentication (available with WSO2 Identify Server 4.0.0 and later) OR the AuthenticationAdmin service, which authenticates with the Entitlement service in Identity Server 3.2.3 and earlier. Thrift uses its own authentication service over TCP. WS-XACML uses Basic Authentication.</p>
<p>The XAMCL standard refrains from specifying which method should be used to communicate from the PEP to the PDP, and many vendors have implemented a proprietary approach. There is a standard called “Web Services Profile of XACML (WS-XACML) Version 1.0″, but it has not been widely adopted because of its bias toward SOAP and the performance implications from XML signatures. However, the benefit of adopting a standard is the elimination of vendor locking, because it will allow your current PEP to work even if you move to a PDP from another vendor (as long as the new PDP also supports this standard). Otherwise you may need to modify your existing PEP to adopt to the new PDP. WSO2 Identity Server has its proprietary SOAP API, Thrift API, and basic support for WS-XACML.</p>
</div></td>
</tr>
<tr class="even">
<td><strong>Thrift Host</strong></td>
<td>The host used to establish a Thrift connection with the Entitlement service when the Entitlement Service Client is set to Thrift.</td>
</tr>
<tr class="odd">
<td><strong>Thrift Port</strong></td>
<td>The port used to establish a Thrift connection with the Entitlement service when the Entitlement Service Client is set to Thrift. The default port is 10500.</td>
</tr>
</tbody>
</table>

You will now define the sequences you want to run for the entitlement results.

1.  If you want to specify an existing sequence for a result, click **Referring Sequence** for that result and select the sequence from the registry.
2.  If you want to define the sequence in the tree, leave **In-Lined Sequence** selected.
3.  Click **Update**.
4.  In the tree, click the first result node for which you want to define the sequence, and then add the appropriate mediators to create the sequence. Repeat for each result node.

### Advanced Callback Properties

The abstract EntitlementCallbackHandler class supports the following properties for getting the XACML subject (user name), specifying the action, and setting the service name. The various implementations of this class (UTEntitlementCallbackHandler, X509EntitlementCallbackHandler, etc.) can use some or all of these properties. You implement these properties by adding [Property mediators]({{base_path}}/reference/mediators/property-Mediator) before the Entitlement mediator in the sequence.

The default UTEntitlementCallbackHandler looks for a property called
`         username        ` in the Axis2 message context, which it uses
as the XACML request `         subject-id        ` value. Likewise, the
other handlers look at various properties for values for the attributes
and construct the XACML request. The following attribute IDs are used by
the default handlers.

-   `                     urn:oasis:names:tc:xacml:1.0:subject:subject-id                   `
    of category
    `                     urn:oasis:names:tc:xacml:1.0:subject-category:access-subject                   `
-   `                     urn:oasis:names:tc:xacml:1.0:action:action-id                   `
    of category
    `                     urn:oasis:names:tc:xacml:3.0:attribute-category:action                   `
-   `                     urn:oasis:names:tc:xacml:1.0:resource:resource-id                   `
    of category
    `                     urn:oasis:names:tc:xacml:3.0:attribute-category:resource                   `
-   `          IssuerDN         ` of category
    `                     urn:oasis:names:tc:xacml:3.0:attribute-category:environment                   `
    (used only by X509 handler)
-   `          SignatureAlgorithm         ` of category
    `                     urn:oasis:names:tc:xacml:3.0:attribute-category:environment                   `
    (used only by X509 handler)

!!! Info
    In most scenarios, you do not need to configure any of these properties.


| Property name                 | Acceptable values | Scope | Description                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|-------------------------------|-------------------|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| xacml\_subject\_identifier    | string            | axis2 | By default, the Entitlement mediator expects to find the XACML subject (user name) in a property called `              username             ` in the message's Axis2 context. If your authentication mechanism specifies the user name by adding a property of a different name, create a property called `              xacml_subject_identifier             ` and set it to the name of the property in the message context that contains the subject. |
| xacml\_action                 | string            | axis2 | If you are using REST and want to specify a different HTTP verb to use with the service, specify it with the xacml\_action property and specify the xacml\_use\_rest property to true.                                                                                                                                                                                                                                                                   |
| xacml\_use\_rest              | true/false        | axis2 | If you are using REST, and you want to override the HTTP verb to send with the request, you can set this property to true to set to true.                                                                                                                                                                                                                                                                                                                |
| xacml\_resource\_prefix       | string            | axis2 | If you want to change the service name, use this property to specify the new service name or the text you want to prepend to the service name.                                                                                                                                                                                                                                                                                                           |
| xacml\_resource\_prefix\_only | true/false        | axis2 | If set to true, the xacml\_resource\_prefix value is used as the whole service name. If set to false (default), the xacml\_resource\_prefix is prepended to the service name.                                                                                                                                                                                                                                                                            |

## Example

In the following example, the WSO2 Identity Server (with log in URL `https://localhost:9443/services`) is see to authenticate the user invoking the secured backend service.

If the authorization test performed on a request sent to this URL fails, the [Fault mediator]({{base_path}}/reference/mediators/fault-Mediator) converts the request into a fault
message giving `         Unauthorized        ` as the reason for the request to be rejected and `         XACML Authorization Failed        ` as the detail. Then the [Respond mediator]({{base_path}}/reference/mediators/respond-Mediator) sends the converted message back to the client.

If the user is successfully authenticated, the request is sent using the [Send Mediator]({{base_path}}/reference/mediators/send-Mediator) to the endpoint with the
`http://localhost:8281/services/echo"/` URL.

```
<entitlementService remoteServiceUrl="https://localhost:9443/services"
                             remoteServiceUserName="admin"
                             remoteServicePassword=
"enc:kuv2MubUUveMyv6GeHrXr9il59ajJIqUI4eoYHcgGKf/BBFOWn96NTjJQI+wYbWjKW6r79S7L7ZzgYeWx7DlGbff5X3pBN2Gh9yV0BHP1E93QtFqR7uTWi141Tr7V7ZwScwNqJbiNoV+vyLbsqKJE7T3nP8Ih9Y6omygbcLcHzg="
                             callbackClass="org.wso2.carbon.identity.entitlement.mediator.callback.UTEntitlementCallbackHandler"
                             client="basicAuth">
   <onReject>
      <makefault version="soap12">
         <code xmlns:soap12Env="http://www.w3.org/2003/05/soap-envelope"
                        value="soap12Env:Receiver"/>
         <reason value="UNAUTHORIZED"/>
         <node/>
         <role/>
         <detail>XACML Authorization Failed</detail>
      </makefault>
      <respond/>
   </onReject>
   <onAccept>
      <send>
         <endpoint>
            <address uri="http://localhost:8281/services/echo"/>
         </endpoint>
      </send>
   </onAccept>
   <obligations/>
   <advice/>
</entitlementService>
```
