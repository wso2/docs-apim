# Expose a SOAP service as a REST API

WSO2 API Manager supports the management of an existing SOAP and WSDL based services exposing as REST APIs.
The organizations who have SOAP/ WSDL based services, can easily bridge their existing services to REST without the cost of a major migration. WSO2 API Manager supports two kinds of services as one for performing a  "pass through" of the SOAP message to the backend and other one is generating [a RESTful api from the backend SOAP service]({{base_path}}/design/create-api/generate-rest-api-from-soap-backend/).

This tutorial will explain the steps to design, publish and invoke a SOAP service as a RESTful API using **Pass Through**

### Step 1 - Design a SOAP service as a REST API

1.  Sign in to the API Publisher and click **CREATE API**.
    
    [![Create SOAP API]({{base_path}}/assets/img/learn/create-soap-api.jpg)]({{base_path}}/assets/img/learn/create-soap-api.jpg)

2.  Select **Pass Through** option and thereafter, select one of the following options:

     * WSDL URL - If you select this option, you need to provide an endpoint URL.

     * WSDL Archive/File - If you select this option, click Browse and upload either an individual WSDL file or a WSDL archive, which is a WSDL project that has multiple WSDLs.

     <html><div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>When uploading a WSDL archive, all the dependent wsdls/xsds that are referred in the parent WSDL file should reside inside the WSDL archive itself. If not, the validation will fail at the point of API creation.</p>
     </div>
     </html>

     This example uses the WSDL `http://ws.cdyne.com/phoneverify/phoneverify.asmx?wsdl` from CDYNE as the endpoint here, but you can use any SOAP backend of your choice.
        ![Create SOAP Pass Through API]({{base_path}}/assets/img/learn/generate-rest-api-from-soap-backend.jpg)

3.  Click **NEXT** button to proceed to the next phase and Provide the information in the table below and click **CREATE** button.

    | Field   | Sample value       |
    |---------|--------------------|
    | Name    | PhoneVerification  |
    | Context | /phoneverify       |
    | Version | 1.0                |
    | Endpoint| http://ws.cdyne.com/phoneverify/phoneverify.asmx|

    ![Create SOAP API]({{base_path}}/assets/img/learn/create-soap-api-form.jpg)

4.  The created API appears in the publisher as follows.
    ![SOAP API overview]({{base_path}}/assets/img/learn/created-soap-api.jpg)

5.  API definiton of the Created schema has been displayed at **API Definiton** tab.
     [![SOAP API Definition]({{base_path}}/assets/img/learn/api-definition-of-soap-api-created-by-passthrough-mode.jpg)]({{base_path}}/assets/img/learn/api-definition-of-soap-api-created-by-passthrough-mode.jpg)
  
    <html><div class="admonition note"><p class="admonition-title">Note</p>
    <p>
            If you wish to add scopes to the resources that were created, navigate to ***Resources*** and expand the resources. Thereafter, creating new scopes and specify them under operation scope. If you specify a scope, you need to use the same scope when generating access tokens for the subscribed application to invoke the API. For more information on working with the scopes, see
    [OAuthscopes]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/)
            </p>
        </div></html>   

    ![Add scopes for Pass Through API]({{base_path}}/assets/img/learn/add-scope-for-passthrough-soap-api.jpg)
     <html><div class="admonition note">
     <p class="admonition-title">Note</p>
     <p> Note that when creating this API, the default option of **Rate limiting level** , was selected to **API Level**. For more information on setting advanced throttling policies,
     see [Enforce Throttling and Resource Access Policies]({{base_path}}/design/rate-limiting/setting-throttling-limits/).</p>
     </div>
     </html>
     
5.  Navigate to **Life Cycle** and Click **Publish** button.
      You have now published SOAP API at the Developer portal.


### Step 2 - Invoke a SOAP service as a REST API.

1.  Log in to the developer portal, navigate to **Subscriptions** tab and subscribe to  the api using (e.g.,DefaultApplication)
      ![]({{base_path}}/assets/img/learn/subscribed-to-api.jpg)

2.  Click the **MANAGE APP** button when prompted **View Credentials**.
    ![]({{base_path}}/assets/img/learn/view-credentials.jpg)

3.  Click **GENERATED ACCESS TOKEN** and then it propmt popupto create an application access token.
    ![]({{base_path}}/assets/img/learn/generate-accesstoken.jpg)


5. Click **GENERATE**.

     The generated JSON Web Token (JWT) appears in the popup. Make sure to copy it.
     <html>
     <img src="{{base_path}}/assets/img/learn/generate-access-token-popup.jpg" height="400" width="580">
     </html>

    Let's invoke the API.

6. Navigate to **TryOut** tab and paste the token at Access token input field.
    ![]({{base_path}}/assets/img/learn/soap-tryout.jpg)

7. Expand the POST method and click **Try it out** . Enter the following, and click       **Execute** to invoke the API.
      <html>
      <table>
      <tr>
      <td>SOAP Request</td>
       <td>
       <pre>
            &lt;soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"&gt;
                &lt;soap:Body&gt;
                    &lt;CheckPhoneNumber xmlns="http://ws.cdyne.com/PhoneVerify/query"&gt;
                    &lt;PhoneNumber&gt;18006785432&lt;/PhoneNumber&gt;
                    &lt;LicenseKey&gt;18006785432&lt;/LicenseKey&gt;
                    &lt;/CheckPhoneNumber&gt;
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
      http://ws.cdyne.com/PhoneVerify/query/CheckPhoneNumber
      </pre>
      </td>
      </tr>
      </table>
      </html>

    ![]({{base_path}}/assets/img/learn/soap-response.png)

8.  Note the API response that appears on the console.
    <html><div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>You can also invoke this API using a third-party tool such as SOAP UI. For more information on how to invoke an API using a SOAP client, 
     see [Invoke an API using a SOAP Client]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-a-soap-client/) .</p>
     </div>
     </html>



