# Mapping the Parameters of your Backend URLs with the API Publisher URLs

This tutorial explains how to map your backend URLs to the pattern that you want in the API Publisher.   

!!! note

    -  The URL pattern of the APIs in the Publisher is `http://<gateway-hostname>:<gateway-port>/<context>/<version>/<API resource>` .
    -  You can define variables as part of the URI template of your API's resources. For example, in the URI template `/business/{id}/details/` , `id` is a variable.

Let's do the following API resource to backend mapping in this tutorial as an example.

```
<gateway-url>/business/{id}/details  --->  <backend-url>/api/business/{id}/info
```

1.  Log in to the API Publisher, **Create** a new API with the following information.

    | Field         |               |   Sample value                           |
    |---------------|---------------|------------------------------------------|
    | Name          |               |   TestAPI                                |
    | Context       |               |   /test                                  |
    | Version       |               |   1.0.0                                  |
    | Endpoint      |               |   https://httpbin.org/anything           |

    !!! info
        
        - [httpbin.org](https://httpbin.org) is a simple HTTP Request & Response Service.
        - [httpbin.org/anything](https://httpbin.org/anything) returns the request back.
        - We use [httpbin.org/anything](https://httpbin.org/anything) as the backend endpoint to inspect the requests we make.

2. Go to **Resources** tab under the API Configurations and add a resource with the following parameters.

    | Field         |   Value                                                  |
    |---------------|----------------------------------------------------------|
    | HTTP Verb     |   `/business/{id}/details`                      |
    | URL pattern   |   GET                                                    |

3. Delete the auto generated wildcard `/*` resources. Otherwise all the requests will go to them.

4. Then **Save and deploy**. Final API will look as follows.

    [![]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api.png)

4.  Copy the the following to a text editor and save the file in XML format.  
    (e.g., `TestSequence.xml` ).

    ``` java
        <property name="NEW_URL" value="/business/id/info" />
        <rewrite inProperty="NEW_URL" outProperty="NEW_URL">
            <rewriterule>
                <action type="replace" regex="id" xpath="get-property('uri.var.id')" fragment="path" />
            </rewriterule>
        </rewrite>
        <property name="REST_URL_POSTFIX" expression="get-property('NEW_URL')" scope="axis2" />
    ```
    
    !!! info
        
        - This sequence does the required mapping at synapse runtime.
        - The sequence is self explanetory and you can customize it for your own requirements.

5.  Go to **Policies** tab and create a custom policy with any name using the above sequence. ( We use **Custom Policy** as the name here )

6.  Add the **Custom Policy** to the **Request Flow** of **/business/{id}/details** resource. Then **Save and deploy**.

    Now parameter mapping should work as intended and let's test this out.
 
9.  Click the **Try Out** tab of and try **/business/{id}/details**.

    [![]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api-try-out.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/test-api-try-out.png)

In this tutorial, you mapped the URL pattern of the APIs in the Publisher with the endpoint URL pattern of a sample backend.
