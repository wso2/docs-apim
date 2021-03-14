# Using the HTTP REST Client

WSO2 Micro Integrator contains an embedded HTTP REST client, which allows you to conveniently invoke your integration solutions after they are deployed in a server.

When you open WSO2 Integration Studio, click the <img src="{{base_path}}/assets/img/integrate/testing-integrations/project-view-icon.png" width="20"> icon on the upper-right of the window. The **HTTP REST Client** tab is listed in the lower pane as shown below. 

<img src="{{base_path}}/assets/img/integrate/testing-integrations/open-http4e-client-empty.png" width="800">

If you don't see this <b>HTTP Client</b> tab, go to <b>Window -> Show View - Other</b> and select <b>HTTP Client</b> to enable the tab.

<img src="{{base_path}}/assets/img/integrate/testing-integrations/show-http4e-client-empty.png" width="500">

To send a request from this client:

1.  Enter the request information in the relevant fields:

    <table>
        <tr>
            <th>
                Request Info
            </th>
            <th>
                Description
            </th>
        </tr>
        <tr>
            <td>
                Method
            </td>
            <td>
               Select the required HTTP method from the list:</br></br> 
               <b>Get</b>, <b>Post</b>, <b>Delete</b>, <b>Put</b>, <b>Head</b>, <b>Options</b>, or <b>Trace</b>.
            </td>
        </tr>
        <tr>
            <td>
                URL
            </td>
            <td>
                Specity the URL of the HTTP request.
            </td>
        </tr>
        <tr>
            <td>
                Headers
            </td>
            <td>
                Specify the HTTP headers for the request.
            </td>
        </tr>
        <tr>
            <td>
                Params
            </td>
            <td>
               Specify the parameters that should be passed in the HTTP request. 
            </td>
        </tr>
        <tr>
            <td>
                Body
            </td>
            <td>
                Specify the message payload that should be sent with the HTTP request.
            </td>
        </tr>
     </table>

2.  Click the <b>Send</b> icon (<img src="{{base_path}}/assets/img/integrate/tutorials/common/play-head-icon.png" width="20">) to send the request.

The response will be printed in the **HTTP Response** section of the client.
