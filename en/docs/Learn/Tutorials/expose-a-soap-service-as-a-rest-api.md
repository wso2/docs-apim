# Expose a SOAP service as a REST API

WSO2 API Manager supports the management of an existing SOAP and WSDL based services exposing as REST APIs.
The organizations who have SOAP/ WSDL based services, can easily bridge their existing services to REST without the cost of a major migration. WSO2 API Manager supports two kinds of services as one for performing a  "pass through" of the SOAP message to the backend and other one is generating [a RESTful api from the backend SOAP service](../../../../Learn/DesignAPI/CreateAPI/generate-rest-api-from-soap-backend/).

This tutorial will explain the steps to design, publish and invoke a SOAP service as a RESTful API using **Pass Through**

### Step 1 - Design a SOAP service as a REST API

1.  Sign in to the API Publisher and click **CREATE API**.
      <html>
     <img src="../../../../assets/img/Learn/create-soap-API.jpg" height="400" width="450">
     </html>

2.  Select **Pass Through** option and thereafter, select one of the following options:

     * WSDL URL - If you select this option, you need to provide an endpoint URL.

     * WSDL Archive/File - If you select this option, click Browse and upload either an individual WSDL file or a WSDL archive, which is a WSDL project that has multiple WSDLs.

     <html><div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>When uploading a WSDL archive, all the dependent wsdls/xsds that are referred in the parent WSDL file should reside inside the WSDL archive itself. If not, the validation will fail at the point of API creation.</p>
     </div>
     </html>

     This example uses the WSDL `https://ws.cdyne.com/ip2geo/ip2geo.asmx?wsdl` from CDYNE as the endpoint here, but you can use any SOAP backend of your choice.
       ![](../../../assets/img/Learn/create-soap-api-using-wsdl.jpg)

3.  Click **NEXT** button to proceed to the next phase and Provide the information in the table below and click **CREATE** button.

    | Field   | Sample value       |
    |---------|--------------------|
    | Name    | PhoneVerification  |
    | Context | /phoneverify       |
    | Version | 1.0                |
    | Endpoint| https://ws.cdyne.com/ip2geo/ip2geo.asmx|
    | Business Plans| Unlimited|

    ![](../../../assets/img/Learn/create-form-for-soap-api.jpg)

4.  The created API appears in the publisher as follows.
    ![](../../../assets/img/Learn/created-soap-api.jpg)
  
    <html><div class="admonition note"><p class="admonition-title">Note</p>
            <p>
            If you wish to add scopes to the resources that were created, navigate to ***Resources*** and expand the resources. Thereafter, creating new scopes and specify them under operation scope. If you specify a scope, you need to use the same scope when generating access tokens for the subscribed application to invoke the API. For more information on working with the scopes, see
    [OAuthscopes](../../../../Learn/APISecurity/Authentication/securing-apis-using-oauth2-access-tokens/)
            </p>
        </div></html>   

    ![](../../../assets/img/Learn/add-scope-for-passthrough-soap-api.jpg)
     <html><div class="admonition note">
     <p class="admonition-title">Note</p>
     <p> Note that when creating this API, the default option of **Rate limiting level** , was selected to **API Level**. For more information on setting advanced throttling policies,
     see [Enforce Throttling and Resource Access Policies](../../../../Learn/RateLimiting/setting-throttling-limits/).</p>
     </div>
     </html>
     
5.  Navigate to **Life Cycle** and Click **Publish** button.
      You have now published SOAP API at the Developer portal.


### Step 2 - Invoke a SOAP service as a REST API.

1.  Log in to the developer portal, navigate to **Credentials** tab and subscribe to  the api using (e.g.,DefaultApplication)
      ![](../../../assets/img/Learn/subscribed-to-api.jpg)

2.  Click the **MANAGE APP** button when prompted **View Credentials**.
    ![](../../../assets/img/Learn/view-credentials.jpg)

3.  Click **GENERATED ACCESS TOKEN** and then it propmt popupto create an application access token.
    ![](../../../assets/img/Learn/generate-accesstoken.jpg)


5. Click **GENERATE** button, generated JWT token can be seen at the popup and copy it.
     <html>
     <img src="../../../../assets/img/Learn/generate-accessToken-popup.jpg" height="400" width="580">
     </html>

    Let's invoke the API.

6. Navigate to **TryOut** tab and paste the token at Access token input field.
    ![](../../../assets/img/Learn/soap-tryout.jpg)
    

7. Expand the POST method and click **Try it out** . Enter the following, and click       **Execute** to invoke the API.
      <html>
      <table>
      <tr>
      <td>SOAP Request</td>
       <td>
       <pre>
       <?xml version="1.0" encoding="utf-8"?>
 &lt;soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"&gt;
  &lt;soap:Body&gt;
    &lt;ResolveIP xmlns="http://ws.cdyne.com/"&gt;
      &lt;ipAddress&gt;string&lt;/ipAddress&gt;
      &lt;licenseKey&gt;string&lt;/licenseKey&gt;
    &lt;/ResolveIP&gt;
  &lt;/soap:Body&gt;
&lt;/soap:Envelope&gt;
      </pre>
      </td>
      </tr>
      <tr>
      <td>SOAP Action
      </td>
      <td>
      <pre>
 "http://ws.cdyne.com/ResolveIP"
      </pre>
      </td>
      </tr>
      </table>
      </html>
     [![](../../../assets/img/Learn/soap-request&soap-action.jpg)](../../../assets/img/Learn/soap-request&soap-action.jpg)

8.  Note the API response that appears on the console.
     [![](../../../assets/img/Learn/soap-response.png)](../../../assets/img/Learn/soap-response.png)


    <html><div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>You can also invoke this API using a third-party tool such as SOAP UI. For more information on how to invoke an API using a SOAP client, 
     see [Invoke an API using a SOAP Client](_Invoke_an_API_using_a_SOAP_Client_) .</p>
     </div>
     </html>



