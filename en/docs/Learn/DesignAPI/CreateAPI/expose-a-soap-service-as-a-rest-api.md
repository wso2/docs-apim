# Expose a SOAP service as a REST API

WSO2 API Manager supports the management of both REST and SOAP APIs.

In this tutorial, we create and publish an **API with a SOAP endpoint** and then invoke it using the integrated API Console.

!!! note
See the following topics for a description of the concepts that you need to know when invoking an API:

-   [Applications](_Key_Concepts_)
-   [Throttling](_Key_Concepts_)
-   [Access tokens](_Key_Concepts_)


Let's get started.

1.  Log in to the API Publisher and click **ADD NEW API** .
2.  Select the option to design an API with an existing SOAP endpoint, select **Pass Through** , give the endpoint URL and click **Start Creating** .

        !!! info
    This example uses the WSDL `http://ws.cdyne.com/phoneverify/phoneverify.asmx?wsdl` from CDYNE as the endpoint here, but you can use any SOAP backend of your choice.


    ![]({{base_path}}/assets/attachments/103328785/103328772.png)

3.  The **Design** tab of the API opens. Give the information in the table below and click **Next: Implement &gt;** to proceed to the implementation phase.

    | Field   | Sample value |
    |---------|--------------|
    | Name    | SoapTest     |
    | Context | /soaptest    |
    | Version | 1.0          |

    ![]({{base_path}}/assets/attachments/103328785/103328771.png)

4.  Click the **Managed API** option.
5.  Select **HTTP/SOAP Endpoint** , provide the production endpoint (in this example, `http://ws.cdyne.com/phoneverify/phoneverify.asmx` ), and click **Manage** .
    ![]({{base_path}}/assets/attachments/103328785/103328770.png)
6.  In the **Manage** tab, select the **Gold** tier, scroll down and click **Save & Publish** .

        !!! note
    If you wish to add scopes to the resources that were created, click **Add Scopes** and specify the scopes you want to add. If you specify a scope, you need to use the same scope when generating access tokens for the subscribed application and when invoking the API. For more information on working with the scopes, see [OAuthscopes](_Key_Concepts_) .

    ![]({{base_path}}/assets/attachments/103328785/103328769.png)


    ![]({{base_path}}/assets/attachments/103328785/103328768.png)

        !!! note
    Note that when creating this API, the default option, **Apply per Resource** , was selected under **Advanced Throttling Policies** . For more information on setting advanced throttling policies, see [Enforce Throttling and Resource Access Policies](_Enforce_Throttling_and_Resource_Access_Policies_) .


    You have now published the SOAP API to the API Store. Let's subscribe to it.

7.  When prompted, choose to open the newly published API in the API Store.
8.  The SoapTest API opens. Select an application (e.g., DefaultApplication), the **Gold tier** and subscribe to the API.
    ![]({{base_path}}/assets/attachments/103328785/103328767.png)

9.  Click the **View Subscriptions** button when prompted. The **Subscriptions** tab opens.
10. Click the **Production Keys** tab and click **Generate Keys** to create an application access token. If you have already generated keys before, click **Regenerate** . By default, access tokens expire an hour after creation, unless you change the expiration time.
    ![]({{base_path}}/assets/attachments/103328785/103328766.png)
    Let's invoke the API.
11. On the **APIs** menu, select the API and click the **API Console** tab.
    ![]({{base_path}}/assets/attachments/103328785/103328765.png)
12. Expand the POST method and click **Try it out** . Enter the following, and click **Execute** to invoke the API.

    |              |                                                                                                                                 |
    |--------------|---------------------------------------------------------------------------------------------------------------------------------|
    | SOAP Request | ``` java                                                                                                                        
          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:quer="http://ws.cdyne.com/PhoneVerify/query">  
             <soapenv:Header/>                                                                                                             
             <soapenv:Body>                                                                                                                
                <quer:CheckPhoneNumber>                                                                                                    
                   <!--Optional:-->                                                                                                        
                   <quer:PhoneNumber>18006785432</quer:PhoneNumber>                                                                        
                   <!--Optional:-->                                                                                                        
                   <quer:LicenseKey>0</quer:LicenseKey>                                                                                    
                </quer:CheckPhoneNumber>                                                                                                   
             </soapenv:Body>                                                                                                               
          </soapenv:Envelope>                                                                                                              
      ```|
    | SOAP Action  | http://ws.cdyne.com/PhoneVerify/query/CheckPhoneNumber                                                                          |

    ![]({{base_path}}/assets/attachments/103328785/103328764.png)

13. Note the API response that appears on the console.

![]({{base_path}}/assets/attachments/103328785/103328763.png)

In this tutorial, you created an API with a SOAP backend and invoked it using the integrated Swagger API Console.

!!! note
You can also invoke this API using a third-party tool such as SOAP UI. For more information on how to invoke an API using a SOAP client, see [Invoke an API using a SOAP Client](_Invoke_an_API_using_a_SOAP_Client_) .


