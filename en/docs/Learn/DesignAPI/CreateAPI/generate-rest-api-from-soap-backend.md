# Generate REST API from SOAP Backend

This feature allows users to expose their legacy SOAP backends as REST APIs through WSO2 API Manager. 
WSO2 API Manager supports WSDL 1.1 based SOAP backends.

Follow the instructions below to generate REST APIs in WSO2 API Manager for an existing SOAP backend.

   <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <ul>Before you begin... </ul>
      <ul>Make sure that you have a valid WSDL URL from the SOAP backend. It should belong to the WSDL 1.1 version.</ul>
      </div>
    </html>

1.  Sign in to the API Publisher and click **CREATE API**
   <html>
     <img src="../../../../assets/img/Learn/create-soap-API.jpg" height="400" width="450">
     </html>
 
    <html><div class="admonition info">
      <p class="admonition-title">Info</p>
      <ul>There are two options to create APIs for SOAP backend
      <li>**Pass Through** – Create a pass through proxy for SOAP requests coming to the API Gateway</li>
      <li>**Generate REST APIs** – This option is used to generate REST API definitions from the given WSDL URL</li>
      </ul>
      </div>
    </html>

2. Select **Generate REST APIs** and provide the WSDL URL for the SOAP backend. After, click **NEXT** button to proceed to the next phase.

      ![](../../../assets/img/Learn/create-soap-api-as-a-generated-api.jpg)

3.  Provide the information in the table below and click **CREATE** button.

    | Field   | Sample value       |
    |---------|--------------------|
    | Name    | PhoneVerification  |
    | Context | /phoneverify       |
    | Version | 1.0                |
    | Endpoint| http://ws.cdyne.com/phoneverify/phoneverify.asmx|
    | Business Plans| Unlimited|

    ![](../../../assets/img/Learn/create-soap-api-form.jpg)

4.  Navigate to the **API Definition** tab and click on **Edit** to modify the open API Definition of the API.
    ![]({{base_path}}/assets/attachments/103328795/103328787.png)
    
5.  Click **Apply Changes** to save your API.
    ![]({{base_path}}/assets/attachments/103328795/103328788.png)
6.  The generated API definitions are added to the API as shown below.
    ![]({{base_path}}/assets/attachments/103328795/103328791.png)

        !!! note
    The definition properties are mapped with a Swagger vendor-specific field `x-xpath` , which is used to map the SOAP binding operation parameters with the REST parameters. If a parameter does not have this field it is not mapped with a backend operation. To ensure the mapping functions smoothly, do not make any changes to the properties.


7.  Go to the **Implement** tab and view the **SOAP Mapping** section. Click on a resource to view the In and Out sequences of the API.
    ![]({{base_path}}/assets/attachments/103328795/103328790.png)
8.  The following sample shows the generated API In-sequence for a GET method with query parameters.

    ``` java
        GET https://<host_name>:8243/weather/1.0.0/weather?CityName=xxxxx&CountryName=xxxxx
    ```

    ``` java
            <property name="HTTP_METHOD" value="POST" scope="axis2" type="STRING"/>
                     <header name="SOAPAction"
                             scope="transport"
                             value="http://www.webserviceX.NET/GetWeather"
                             description="SOAPAction"/>
                     <property name="REST_URL_POSTFIX" scope="axis2" action="remove"/>
                     <property name="req.var.CityName" expression="$url:CityName"/>
                     <property name="req.var.CountryName" expression="$url:CountryName"/>
                     <payloadFactory media-type="xml" description="transform">
                        <format>
                           <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                                             xmlns:web="http://www.webserviceX.NET">
                              <soapenv:Header/>
                              <soapenv:Body>
                                 <web:GetWeather>
                                    <web:CityName>$1</web:CityName>
                                    <web:CountryName>$2</web:CountryName>
                                 </web:GetWeather>
                              </soapenv:Body>
                           </soapenv:Envelope>
                        </format>
                        <args>
                           <arg evaluator="xml" expression="get-property('req.var.CityName')"/>
                           <arg evaluator="xml" expression="get-property('req.var.CountryName')"/>
                        </args>
                     </payloadFactory>
                     <property name="messageType"
                               value="application/soap+xml"
                               scope="axis2"
                               type="STRING"
                               description="messageProperty"/>
    ```

    The incoming JSON message parameters are stored using properties. The SOAP payload needed for the backend is generated using a payload factory mediator.

9.  Enter the SOAP endpoint URL. The endpoint type should be the **HTTP/SOAP Endpoint** as shown below.
    ![]({{base_path}}/assets/attachments/103328795/103328789.png)
10. Go to the **Manage** tab and the relevant configuration. Click **Publish** to publish the API to the API Store. For instructions, see [Create and Publish an API](https://docs.wso2.com/display/AM2xx/Create+and+Publish+an+API) .
11. Navigate to the API Store and [invoke the AP](https://docs.wso2.com/display/AM2xx/Quick+Start+Guide#QuickStartGuide-InvokingtheAPI) I.

