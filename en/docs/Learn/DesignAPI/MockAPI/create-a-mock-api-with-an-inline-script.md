# Create a Mock API with an Inline Script

In this tutorial, you create a prototyped API with an inline script, deploy it as a prototype, and invoke it using the API Console integrated in the API Store. Typically, you create APIs with inline scripts for testing purposes. An API prototype is created for the purpose of early promotion and testing. You can deploy a new API or a new version of an existing API as a prototype. It gives subscribers an early implementation of the API that they can try out without a subscription or monetization, and provide feedback to improve. After a period of time, publishers can make changes that the users request and publish the API.

1.  Sign in to the API Publisher using `admin` as the username and password.
`https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher` ).
2.  Select the option to design a new REST API and click **Start Creating** .
    ![](/assets/attachments/103328761/103328756.png)
3.  Give the information in the table below. To add resources, click the **Add** button. Since the URL Pattern used here is a variable, it is denoted within curly braces.

    <table>
    <thead>
    <tr class="header">
    <th>Field</th>
    <th><br />
    </th>
    <th>Sample value</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Name</td>
    <td><br />
    </td>
    <td>Location_API</td>
    </tr>
    <tr class="even">
    <td>Context</td>
    <td><br />
    </td>
    <td>/location</td>
    </tr>
    <tr class="odd">
    <td>Version</td>
    <td><br />
    </td>
    <td>1.0.0</td>
    </tr>
    <tr class="even">
    <td>Resources</td>
    <td>URL pattern</td>
    <td>{town}</td>
    </tr>
    <tr class="odd">
    <td><br />
    </td>
    <td>Request types</td>
    <td><p>GET</p></td>
    </tr>
    </tbody>
    </table>

    ![](/assets/attachments/103328761/103328755.png)

4.  After the resource is added, expand its `GET` method and note that a parameter by the name `town` is added under the resource. You use it to pass the payload to the backend. Once done, click **Next: Implement &gt;** .

        !!! tip
    To specify multiple parameters in the API resource, separate the parameters with a forward slash.

    ``` java
        {param1}/{param2}
    ```


    ![](/assets/attachments/103328761/103328754.png)

5.  In the **Prototyped API** section under the **Implement** tab, select the implementation method as **Inline** .
    ![](/assets/attachments/103328761/103328753.png)

        !!! note
    The inline JavaScript engine does not provide support for SOAP APIs. If you opt for the endpoint implementation method instead of inline, you need to provide an endpoint to a prototype API. For example, <http://ws.cdyne.com/phoneverify/phoneverify.asmx>


6.  Expand the `GET` method and give the following as the script. It reads the payload that the user sends with the API request and returns it as a JSON value. The value **mc** is the message context.

    ``` java
        mc.setProperty('CONTENT_TYPE', 'application/json');
        var town = mc.getProperty('uri.var.town');
        mc.setPayloadJSON('{ "Town" : "'+town+'"}');
    ```

    ![](/assets/attachments/103328761/103328752.png)

7.  Click **Deploy as a Prototype** .

8.  When prompted, choose to open the newly published API in the API Store.

        !!! tip
    **Tip** : You can invoke prototyped APIs without signing in to the API Store or subscribing to the API. The purpose of a prototype is advertising and giving an early implementation for users to test.


9.  The Location API opens. Click the **API Console** tab.
    ![](/assets/attachments/103328761/103328750.png)

10. Expand the `GET` method, click **Try it out** . Give any value for the town (e.g. London) and click **Execute** to invoke the API.
    ![](/assets/attachments/103328761/103328749.png)
11. Note the payload you gave as a JSON output in the response.
    ![](/assets/attachments/103328761/103328748.png)

You have created an API with inline script, deployed it as a prototype and invoked it through the integrated API Console.

An API can also be prototyped by moving the API to the prototyped state in the API lifecycle. For more information, see the [Deploy and Test Mock APIs](_Deploy_and_Test_Mock_APIs_) tutorial.

!!! info
### Related Tutorials

-   [Create and Publish an API](_Create_and_Publish_an_API_)

-   [Create a WebSocket API](_Create_a_WebSocket_API_)

-   [Create and Publish an API from a Swagger definition](_Create_and_Publish_an_API_from_a_Swagger_Definition_)


