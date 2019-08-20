# Include Additional Headers in the API Console

The Swagger API Console is a JavaScript client that runs in the API Store and makes JavaScript calls from the Store to the API Gateway. You must specify any additional headers that you want to add to the API Console under the CORS ( [Cross Origin Resource Sharing](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) ) configuration.

!!! note
Before you begin...

Open the CORS configuration in the `         <API-M_HOME>/repository/conf/api-manager.xml        ` file, enable CORS if it is not enabled already and specify the additional headers ( `         SOAPAction        ` , in this case) under the `         <Access-Control-Allow-Headers>        ` element:

**CORS configurations in api-manager.xml**

``` xml
     <CORSConfiguration>
        <Enabled>true</Enabled>
        <Access-Control-Allow-Origin>*</Access-Control-Allow-Origin>
        <Access-Control-Allow-Methods>GET,PUT,POST,DELETE,PATCH,OPTIONS</Access-Control-Allow-Methods>
        <Access-Control-Allow-Headers>authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction</Access-Control-Allow-Headers>
    </CORSConfiguration>
```

!!! info
This configuration is only valid for APIs created through the API manager Publisher application. All the other Oauth token related APIs (/authorize, /revoke, /token, /userinfo) are not affected from this. To enable CORS configuration to these APIs as well, see [Enabling CORS for Oauth Token related APIs](#IncludeAdditionalHeadersintheAPIConsole-EnableCORSForOauthTokenApis)


Next, let's see how to add the header as a parameter to the API Console.

1.  Log in to the API Publisher and click the API that you want to invoke (e.g., `          PhoneVerification         ` ).
2.  Click the **Edit** link next to the API's name, navigate down to the **API Definition** section and click on the `           POST          ` method to expand it.
    ![](attachments/103333115/103333116.png)
3.  Update the **Produces** and **Consumes** fields to `           text/xml          ` and create the following header using the **Add Parameter** button.

    <table>
    <thead>
    <tr class="header">
    <th>Parameter name</th>
    <th>Values</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>SOAPAction</td>
    <td>Description: Set to <a href="http://ws.cdyne.com/PhoneVerify/query/CheckPhoneNumber" class="uri">http://ws.cdyne.com/PhoneVerify/query/CheckPhoneNumber</a><br />
    Parameter Type: Header<br />
    Data Type: String<br />
    Required: False</td>
    </tr>
    </tbody>
    </table>

    ![](attachments/103333115/103333117.png)
4.  Once you are done, click **Save** .

5.  Log in to the API Store, subscribe to the API and generate an access token for the application you subscribed with.
    If it's an API that you are already subscribed to, you might have to re-generate the access token from the **Applications** page.
    ![](attachments/103333115/103333118.png)6.  Click on the API again to open it and then click its **API Console** tab.
    ![](attachments/103333115/103333119.png)7.  Expand the POST method and click **Try it out** .

    ![](attachments/103333115/103333120.png)
8.  Fill the parameter values and click **Execute** to invoke the API. For example,

    | Parameter              | Value                                                                                                                                                                              |
    |------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | Body                   | This is the example SOAP request that we copied from the SOAP UI of the [previous tutorial](https://docs.wso2.com/display/AM250/Convert+a+JSON+Message+to+SOAP+and+SOAP+to+JSON) : 
                                                                                                                                                                                          
      ``` java                                                                                                                                                                            
            <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">           
              <soap:Body>                                                                                                                                                                       
                <CheckPhoneNumber xmlns="http://ws.cdyne.com/PhoneVerify/query">                                                                                                                
                  <PhoneNumber>650 745 4499 </PhoneNumber>                                                                                                                                      
                <!-- Optional LicenseKey parameter-->                                                                                                                                           
                  <LicenseKey>0</LicenseKey>                                                                                                                                                    
                </CheckPhoneNumber>                                                                                                                                                             
              </soap:Body>                                                                                                                                                                      
            </soap:Envelope>                                                                                                                                                                    
      ```                                                                                                                                                                                 |
    | Parameter Content Type | text/xml                                                                                                                                                                           |
    | SOAPAction             | <http://ws.cdyne.com/PhoneVerify/query/CheckPhoneNumber>                                                                                                                           |

    ![](attachments/103333115/103333121.png)
9.  A result similar to the following appears on the console.
    ![](attachments/103333115/103333122.png)
You have added SOAP parameters to the API Console and invoked a SOAP service using the API Console.

## Enabling CORS for OAuth Token related APIs

Enabling CORS configuration through `         api-manager.xml        ` is only valid for APIs created through the API manager Publisher application. Hence, enabling CORS for OAuth token related APIs ( **/authorize, /revoke, /token, /userinfo** ) can be carried out as follows.

Based on the API that you need to enable CORS, add the following handler configuration to the relevant API synapse file present in `         <API-M_HOME>/repository/deployment/server/synapse-configs/default/api/        ` folder. It should be added within the `         <handlers>        ` parent element.

``` java
    <handler class="org.wso2.carbon.apimgt.gateway.handlers.security.CORSRequestHandler">
        <property name="apiImplementationType" value="ENDPOINT"/>
    </handler>
```

The following are the mappings of the synapse files corresponding to the OAuth token related APIs.

| Endpoint   | Synapse configuration                         |
|------------|-----------------------------------------------|
| /authorize | `             _AuthorizeAPI_.xml            ` |
| /revoke    | `             _RevokeAPI_.xml            `    |
| /token     | `             _TokenAPI_.xml            `     |
| /userinfo  | `             _UserInfoAPI_.xml            `  |


