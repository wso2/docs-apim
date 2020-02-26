# Mapping the Parameters of your Backend URLs with the API Publisher URLs

This tutorial explains how to map your backend URLs to the pattern that you want in the API Publisher.   

!!! note

    -  The URL pattern of the APIs in the Publisher is `http://<hostname>:8280/<context>/<version>/<API resource>` .
    -  You can define variables as part of the URI template of your API's resources. For example, in the URI template /business/{businessId}/address/ , `businessId` is a variable.
    -  The variables in the resources are read during mediation runtime using property values with the `uri.var.` prefix. 
    For example, this HTTP endpoint gets the businessId that you specify in the resource `http://localhost:8280/businesses/{uri.var.businessId}/details` .
    -  The URI template of the API's resource is automatically appended to the end of the HTTP endpoint at runtime. You can use the following mediator setting to remove the URL postfix from the backend endpoint:   
    `<property name="REST_URL_POSTFIX" scope="axis2" action="remove"/>` .

We do the following mapping in this tutorial:

[![]({{base_path}}/assets/img/learn/api-gateway/message-mediation/url-mapping.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/url-mapping.png)

!!! info
    **Before you begin...** 
    
    Note that a mock backend implementation is set up in this tutorial for the purpose of demonstrating the API invocation. 
    If you have a local API Manager setup, save [this file]({{base_path}}/assets/attachments/learn/api-gateway/message-mediation/Response_API.xml) in the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/api` folder to set up the mock backend.

1.  Log in to the API Publisher, design a new API with the following information, click **Create**.

    | Field         |               |   Sample value                                                  |
    |---------------|---------------|-----------------------------------------------------------------|
    | Name          |               |   TestAPI                                                       |
    | Context       |               |   /test                                                         |
    | Version       |               |   1.0.0                                                         |
    | Business Plan |               |   Gold                                                          |
    | Endpoint      |               |   http://localhost:8280/businesses/{uri.var.businessId}/details |
    | Resources     |  URL pattern  |   /business/{businessId}/address/                               |
    |               |  Request types|   GET                                                           |    

3.  Go to **Lifecycle** tab and Click `Publish` to publish the API.

    As the API's resource is appended to its endpoint by Synapse at runtime, let's write a custom sequence to remove this appended resource.

4.  Copy the the following to a text editor and save the file in XML format.  
    (e.g., `TestSequence.xml` ).

    !!! example
        ``` java
        <sequence xmlns="http://ws.apache.org/ns/synapse" name="TestSequence">
            <property name="REST_URL_POSTFIX" scope="axis2" action="remove"/>
        </sequence>
        ```

5.  Go to API Publisher, click on the APi to go to the **Runtime Configurations** tab.

6.  Enable the **Message Mediation**  switch and engage the `In` sequence that you created earlier.  

    [![]({{base_path}}/assets/img/learn/api-gateway/message-mediation/upload-test-seq.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/upload-test-seq.png)

    !!! info
        `TestSequence.xml` removes the URL postfix from the backend endpoint, since the URI template of the API's resource is automatically appended to the end of the URL at runtime. Therefore the **request** URL is modified by adding this sequence to the **In Flow**.


7.  Save the API.

8.  Log in to the API Devportal and subscribe to the API and generate an access token to invoke the API.
 
9.  Click the **Try Out** tab of your API and click on **Try it out** on the `/business/{businessId}/address` resource.  

    [![]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api-try-out.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api-try-out.png)

19. Note below the `businessId` is added in the UI as a parameter. Give a `businessId` and click **Execute** to invoke 
the API.  

    [![]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api-tryout-execute.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api-tryout-execute.png)

20. Note the response that you get. According to the mock backend used in this tutorial, you get the response `Received Request`.  

    [![]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api-resource.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api-resource.png)

In this tutorial, you mapped the URL pattern of the APIs in the Publisher with the endpoint URL pattern of a sample backend.
