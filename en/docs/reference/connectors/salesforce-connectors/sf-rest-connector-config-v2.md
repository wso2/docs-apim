# Salesforce REST Connector Reference

The following operations allow you to work with the Salesforce REST Connector v2.x that provides seamless integration with the [Salesforce REST API v59.0](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_rest.htm). Click on an operation name to see the parameter details and samples on how to use it.

---

## Salesforce REST Connector Connection Configuration

Salesforce REST API uses the OAuth protocol to allow application users to securely access data without having to reveal
their user credentials. For more information on how authentication is done in Salesforce, see
[Understanding Authentication](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_authentication.htm).
You can provide only access token and use it until it expires. After expiry, you will be responsible for getting a new
access token and using it. Alternatively, you have the option of providing refresh token, client secret, and client ID
which will be used to get access token initially and after every expiry by the connector itself. You will not be
required to handle access token expiry in this case.

There also an option to use basic authentication with username and password.

??? note "Connection configuration"
    In the 'Properties' section of each operation, users can configure connection-related information. Once the configuration is created, it can be reused in other operations.
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>apiVersion</td>
    <td>The version of the Salesforce API.</td>
    <td>Yes</td>
    <td>v59.0</td>
    </tr>
    <tr>
    <td>accessToken</td>
    <td>The access token to authenticate your API calls.</td>
    <td>No</td>
    <td>XXXXXXXXXXXX (Replace with your access token)</td>
    </tr>
    <tr>
    <td>apiUrl</td>
    <td>The instance URL for your organization.</td>
    <td>Yes</td>
    <td>https://ap2.salesforce.com</td>
    </tr>
    <tr>
    <td>hostName</td>
    <td>SalesforceOAuth endpoint when issuing authentication requests in your application.</td>
    <td>Yes</td>
    <td>https://login.salesforce.com</td>
    </tr>
    <tr>
    <td>refreshToken</td>
    <td>The refresh token that you received to refresh the API access token.</td>
    <td>No</td>
    <td>XXXXXXXXXXXX (Replace with your refresh token)</td>
    </tr>
    <tr>
    <td>tokenEndpointHostname</td>
    <td>The endpoint of the refresh token that you invoke to refresh the API access token. </td>
    <td>No</td>
    <td>XXXXXXXXXXXX (Replace this with your refresh token endpoint)</td>
    </tr>
    <tr>
    <td>clientId</td>
    <td>The consumer key of the connected application that you created.</td>
    <td>No</td>
    <td>XXXXXXXXXXXX (Replace with your client ID)</td>
    </tr>
    <tr>
    <td>clientSecret</td>
    <td>The consumer secret of the connected application that you created.</td>
    <td>No</td>
    <td>XXXXXXXXXXXX (Replace with your client secret)</td>
    </tr>
    <tr>
    <td>blocking</td>
    <td>Indicates whether the connector needs to perform blocking invocations to Salesforce.</td>
    <td>Yes</td>
    <td>false</td>
    </tr>
    </table>
    
    **Sample configuration**
    
    ```xml
    <salesforcerest.init>
        <accessToken>{$ctx:accessToken}</accessToken>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <hostName>{$ctx:hostName}</hostName>
        <apiVersion>{$ctx:apiVersion}</apiVersion>
        <blocking>{$ctx:blocking}</blocking>
    </salesforcerest.init>
    ```
    
    **Sample request**
    
    ```json
    {
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "blocking" : "false"
    }
    ```
    
    Or if you want the connector to handle token expiry
    
    **Sample configuration**
    
    ```xml
    <salesforcerest.init>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <hostName>{$ctx:hostName}</hostName>
        <apiVersion>{$ctx:apiVersion}</apiVersion>
        <refreshToken>{$ctx:refreshToken}</refreshToken>
        <clientId>{$ctx:clientId}</clientId>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <blocking>{$ctx:blocking}</blocking>
    </salesforcerest.init>
    ```
    
    **Sample request**
    
    ```json
    {
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "refreshToken":"XXXXXXXXXXXX (Replace with your refresh token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "clientId": "XXXXXXXXXXXX (Replace with your client ID)",
        "clientSecret": "XXXXXXXXXXXX (Replace with your client secret)",
        "blocking" : "false"
    }
    ```


??? note "Connection Configuration Parameters for username/password flow"
    The connection configuration parameters that are required to interact with the Salesforce REST API using a username/password flow. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_username_password_oauth_flow.htm) for more information.
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>apiVersion</td>
    <td>The version of the Salesforce API.</td>
    <td>Yes</td>
    <td>v59.0</td>
    </tr>
    <tr>
    <td>apiUrl</td>
    <td>The instance URL for your organization.</td>
    <td>Yes</td>
    <td>https://ap2.salesforce.com</td>
    </tr>
    <tr>
    <td>hostName</td>
    <td>SalesforceOAuth endpoint when issuing authentication requests in your application.</td>
    <td>Yes</td>
    <td>https://login.salesforce.com</td>
    </tr>
    <tr>
    <td>clientId</td>
    <td>The consumer key of the connected application that you created.</td>
    <td>Yes</td>
    <td>XXXXXXXXXXXX (Replace with your client ID)</td>
    </tr>
    <tr>
    <td>clientSecret</td>
    <td>The consumer secret of the connected application that you created.</td>
    <td>Yes</td>
    <td>XXXXXXXXXXXX (Replace with your client secret)</td>
    </tr>
    <tr>
    <td>username</td>
    <td>The username for Salesforce.</td>
    <td>Yes</td>
    <td>youruser@gmail.com</td>
    </tr>
    <tr>
    <td>password</td>
    <td>The password for Salesforce (need to append the password with security key).</td>
    <td>Yes</td>
    <td>xxxxxxxxxxxxxxxxxxxxxx</td>
    </tr>
    <tr>
    <td>blocking</td>
    <td>Indicates whether the connector needs to perform blocking invocations to Salesforce.</td>
    <td>Yes</td>
    <td>false</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.init>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <clientId>{$ctx:clientId}</clientId>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <hostName>{$ctx:hostName}</hostName>
        <apiVersion>{$ctx:apiVersion}</apiVersion>
        <username>{$ctx:username}</username>
        <password>{$ctx:password}</password>
        <blocking>{$ctx:blocking}</blocking>
    </salesforcerest.init>
    ```

    **Sample request**
    
    ```json
    {
        "clientId": "xxxxxxxxxxxxxxxxxxxxxxxx",
        "clientSecret": "xxxxxxxxxxxxxxxxxxxxxxxx",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "username": "youruser@gmail.com",
        "password": "xxxxxxxxxxxxxxxxxxxxxx",
        "apiUrl":"https://(your_instance).salesforce.com",
        "blocking" : "false"
    }
    ```
---

### AppMenu

??? note "listAppMenuTypes"
    To retrieve a list of App Menu types in the Salesforce app dropdown menu, use salesforcerest.listAppMenuTypes and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_appmenu_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/appMenu/`
    
    **Sample configuration**

    ```xml
    <salesforcerest.listAppMenuTypes/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "blocking" : "false"
    }
    ```

    **Sample response**

    ```json
    {
        "AppSwitcher": "/services/data/v59.0/appMenu/AppSwitcher",
        "Salesforce1": "/services/data/v59.0/appMenu/Salesforce1",
        "NetworkTabs": "/services/data/v59.0/appMenu/NetworkTabs"
    }
    ```

??? note "listAppMenuItems"
    To retrieve a list of items in either the Salesforce app drop-down menu or the Salesforce1 navigation menu, use salesforcerest.listAppMenuItems and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_appmenu_items_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/appMenu/AppSwitcher/`

    **Sample configuration**

    ```xml
    <salesforcerest.listAppMenuItems/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "blocking" : "false"
    }
    ```

    **Sample response**

    ```json
    {
        "appMenuItems": [
            {
                "colors": null,
                "content": null,
                "icons": null,
                "label": "Sales",
                "name": "02u5j000004hYzj",
                "type": "Tabset",
                "url": "/home/home.jsp?tsid=02u5j000004hYzj"
            },
            {
                "colors": null,
                "content": null,
                "icons": null,
                "label": "Service",
                "name": "02u5j000004hYzz",
                "type": "Tabset",
                "url": "/home/home.jsp?tsid=02u5j000004hYzz"
            },
            .
            .
        ]
    }
    ```

??? note "returnHeadersForAppMenuItems"
    To retrieve only the headers that are returned by the listAppMenuItems operation, use salesforcerest.returnHeadersForAppMenuItems and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_appmenu_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/appMenu/AppSwitcher/`

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForAppMenuItems/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "blocking" : "false"
    }
    ```

??? note "listAppMenuMobileItems"
    To retrieve a list of the App Menu items in the Salesforce mobile app for Android and iOS and the mobile web navigation menu., 
    use salesforcerest.listAppMenuMobileItems and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_appmenu_items_mobile_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/appMenu/Salesforce1/`

    **Sample configuration**

    ```xml
    <salesforcerest.listAppMenuMobileItems/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "blocking" : "false"
    }
    ```

    **Sample response**

    ```json
    {
        "appMenuItems": [
            {
                "colors": [
                    {
                        "color": "1B96FF",
                        "context": "primary",
                        "theme": "theme4"
                    }
                ],
                "content": null,
                "icons": [
                    {   
                        .
                        .
                ],
                "label": "Chatter",
                "name": "F",
                "type": "Standard.Feed",
                "url": "/feed"
            },
            .
            .
        ]
    }
    ```

??? note "returnHeadersForAppMenuMobileItems"
    To retrieve only the headers that are returned by the listAppMenuMobileItems operation, use salesforcerest.returnHeadersForAppMenuMobileItems and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_appmenu_mobile_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/appMenu/Salesforce1/`
    
    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForAppMenuMobileItems/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "blocking" : "false"
    }
    ```

??? note "tabs"
    To retrieve a list of all tabs, use salesforcerest.tabs. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_tabs_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/tabs/`

    **Sample configuration**

    ```xml
    <salesforcerest.tabs/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample response**

    ```json
    {"output":"[{\"colors\":[{\"color\":\"4dca76\",\"context\":\"primary\",\"theme\":\"theme4\"},{\"color\":\"319431\",\"context\":\"primary\",\"theme\":\"theme3\"}],\"custom\":true,\"iconUrl\":\"https://sampletest-dev-ed.my.salesforce.com/img/icon/form32.png\",..}
    ```

??? note "returnHeadersForTabs"
    To retrieve only the headers that are returned by the tabs operation, use salesforcerest.returnHeadersForTabs. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_tabs_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/tabs/`

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForTabs/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

??? note "themes"
    To retrieve a list of icons and colors used by themes in the Salesforce application, use salesforcerest.themes. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_themes.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/theme`

    **Sample configuration**

    ```xml
    <salesforcerest.themes/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample response**

    ```json
    {
        "themeItems":[
            {
                "name":"Account",
                "icons":[
                    {
                    "width":32,
                    "theme":"theme3",
                    "contentType":"image/png",
                    "url":"https://kesavan-dev-ed.my.salesforce.com/img/icon/accounts32.png",
                    "height":32
                    }
                ]
            }
        ]
    }
    ```
---

### Approvals

??? note "listApprovals"
    To retrieve the list of approvals in Salesforce, use salesforcerest.listApprovals. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_approvals_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/process/approvals/`

    **Sample configuration**

    ```xml
    <salesforcerest.listApprovals/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample response**

    ```json
    {
        "approvals" : {
            "Account" : [ {
            "description" : null,
            "id" : "04aD00000008Py9",
            "name" : "Account Approval Process",
            "object" : "Account",
            "sortOrder" : 1
            } ]
        }
    }
    ```

??? note "returnHeadersForApprovals"
    To return only the headers that are returned by the listApprovals operation, use salesforcerest.returnHeadersForApprovals. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_approvals_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/process/approvals/`

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForApprovals/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

??? note "submitApproveOrRejectApprovals"
    To submit a particular record if that entity supports an approval process and one has already been defined,
    use salesforcerest.submitApproveOrRejectApprovals. Records can be approved and rejected if the current user is an assigned approver.
    See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_approvals_post.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/process/approvals/`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to submit, approve, or reject the approvals.</td>
    <td>Yes</td>
    <td><pre>{
        "requests" : [{
        "actionType": "Submit",
        "contextId": "001D000000I8mIm",
        "nextApproverIds": ["005D00000015rY9"],
        "comments":"this is a test",
        "contextActorId": "005D00000015rZy",
        "processDefinitionNameOrId" : "PTO_Request_Process",
        "skipEntryCriteria": "true"}]
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.submitApproveOrRejectApprovals>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.submitApproveOrRejectApprovals>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the submitApproveOrRejectApprovals operation to submit a record or a collection of records for approval.

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue":{
            "requests" : [{
            "actionType": "Submit",
            "contextId": "001D000000I8mIm",
            "nextApproverIds": ["005D00000015rY9"],
            "comments":"this is a test",
            "contextActorId": "005D00000015rZy",
            "processDefinitionNameOrId" : "PTO_Request_Process",
            "skipEntryCriteria": "true"}]
        }
    }
    ```

    **Sample response**

    Given below is a sample response for the above request.

    ```json
    [ { 
        "actorIds" : [ "005D00000015rY9IAI" ],
        "entityId" : "001D000000I8mImIAJ",
        "errors" : null,
        "instanceId" : "04gD0000000Cvm5IAC",
        "instanceStatus" : "Pending",
        "newWorkitemIds" : [ "04iD0000000Cw6SIAS" ],
        "success" : true 
    } ]
    ```
---

### Composite

??? note "listCompositeResources"
    To retrieve a list of URIs for composite resources, use salesforcerest.listCompositeResources. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_composite_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/composite`

    **Sample configuration**

    ```xml
    <salesforcerest.listCompositeResources/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0"
    }
    ```

    **Sample response**

    ```json
    {
        "tree": "/services/data/v54.0/composite/tree",
        "batch": "/services/data/v54.0/composite/batch",
        "sobjects": "/services/data/v54.0/composite/sobjects",
        "graph": "/services/data/v54.0/composite/graph"
    }
    ```

??? note "sendMultipleRequestsUsingComposite"
    To execute a series of REST API requests in a single call, use salesforcerest.sendMultipleRequestsUsingComposite. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_composite_post.htm) for more information.

    Equivalent to Salesforce REST API `POST /services/data/vXX.X/composite`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to send multiple requests using composite.</td>
    <td>Yes</td>
    <td><pre>{
        "allOrNone" : true,
        "collateSubrequests": true,
        "compositeRequest" : [{
            Composite Subrequest
            },{
            Composite Subrequest
            },{
            Composite Subrequest
        }]
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sendMultipleRequestsUsingComposite>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.sendMultipleRequestsUsingComposite>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": {
            "allOrNone" : true,
            "collateSubrequests": true,
            "compositeRequest" : [{
                Composite Subrequest
                },{
                Composite Subrequest
                },{
                Composite Subrequest
            }]
        }
    }
    ```

    **Sample response**

    ```json
    {
        "compositeResponse" : [{
            Composite Subrequest Result      
            },{
            Composite Subrequest Result      
            },{
            Composite Subrequest Result      
        }]
    }
    ```

??? note "compositeBatch"
    To execute up to 25 subrequests in a single request, use salesforcerest.compositeBatch. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_batch.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/composite/batch`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to submit bacth requests.</td>
    <td>Yes</td>
    <td><pre>{
        "batchRequests" : [
            {
            "method" : "PATCH",
            "url" : "v59.0/sobjects/account/001D000000K0fXOIAZ",
            "richInput" : {"Name" : "NewName"}
            },{
            "method" : "GET",
            "url" : "v59.0/sobjects/account/001D000000K0fXOIAZ?fields=Name,BillingPostalCode"
        }]
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.compositeBatch>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.compositeBatch>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": {
            "batchRequests" : [
                {
                "method" : "PATCH",
                "url" : "v59.0/sobjects/account/001D000000K0fXOIAZ",
                "richInput" : {"Name" : "NewName"}
                },{
                "method" : "GET",
                "url" : "v59.0/sobjects/account/001D000000K0fXOIAZ?fields=Name,BillingPostalCode"
                }
            ]
        }
    }
    ```

    **Sample response**

    ```json
    {
        "hasErrors" : false,
        "results" : [{
            "statusCode" : 204,
            "result" : null
            },{
            "statusCode" : 200,
            "result": {
                "attributes" : {
                    "type" : "Account",
                    "url" : "/services/data/v59.0/sobjects/Account/001D000000K0fXOIAZ"
                },
                "Name" : "NewName",
                "BillingPostalCode" : "94105",
                "Id" : "001D000000K0fXOIAZ"
            }
        }]
    }
    ```

??? note "compositeGraph"
    To submit composite graph operations, use salesforcerest.compositeGraph. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_graph.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/composite/graph`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to submit composite graph operations.</td>
    <td>Yes</td>
    <td><pre>{
        "graphId" : "graphId",
        "compositeRequest" : [
            compositeSubrequest,
            compositeSubrequest,
            ...
        ]
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.compositeGraph>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.compositeGraph>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": {
            "graphId" : "graphId",
            "compositeRequest" : [
                compositeSubrequest,
                compositeSubrequest,
                ...
            ]
        }
    }
    ```

    **Sample response**

    ```json
    {
        "graphs" : [
            {
                "graphId" : "graphId",
                "graphResponse" : {
                    "compositeResponse" : [
                        compositeSubrequestResult,
                        compositeSubrequestResult,
                        compositeSubrequestResult,
                        ...
                    ]
                },
                "isSuccessful" : flag
            },
            ...
        ]
    }
    ```
---

### Consent

??? note "consentDetailsOnSingleAction"
    To retrieve consent details based on a single action, like email or track, across specific consent management objects when the records have a lookup relationship, use salesforcerest.consentDetailsOnSingleAction. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_consent_action.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/consent/action/{action}?ids={listOfIds}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>action</td>
    <td>The proposed action. Ex: email, fax, geotrack, mail, phone, portability, process, profile, shouldforget, social, solicit, storepiielsewhere, track, web</td>
    <td>Yes</td>
    <td>email</td>
    </tr>
    <tr>
    <td>listOfIds</td>
    <td>Comma-separated list of IDs. The ID can be the record ID or the email address listed on the record.</td>
    <td>Yes</td>
    <td>j0t5t5b2@tkbxp5ia.com,4quxlswo@23wj7pwh.com</td>
    </tr>
    <tr>
    <td>aggregatedConsent</td>
    <td>Whether to enable or disable aggregated consent. true or false.</td>
    <td>No</td>
    <td>true</td>
    </tr>
    <tr>
    <td>datetime</td>
    <td>The timestamp for which consent is determined.</td>
    <td>No</td>
    <td>2018-12-12T00:00:00Z</td>
    </tr>
    <tr>
    <td>policy</td>
    <td>The policy.</td>
    <td>No</td>
    <td>requireExplicitConsent</td>
    </tr>
    <tr>
    <td>purpose</td>
    <td>The reason for contacting a customer.</td>
    <td>No</td>
    <td>billing</td>
    </tr>
    <tr>
    <td>verbose</td>
    <td>Whether to allow verbose non-verbose responses. true or false</td>
    <td>No</td>
    <td>true</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.consentDetailsOnSingleAction>
        <action>{$ctx:action}</action>
        <listOfIds>{$ctx:listOfIds}</listOfIds>
        <aggregatedConsent>{$ctx:aggregatedConsent}</aggregatedConsent> <!-- optional -->
        <datetime>{$ctx:datetime}</datetime> <!-- optional -->
        <policy>{$ctx:policy}</policy> <!-- optional -->
        <purpose>{$ctx:purpose}</purpose> <!-- optional -->
        <verbose>{$ctx:verbose}</verbose> <!-- optional -->
    </salesforcerest.consentDetailsOnSingleAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "action":"email",
        "listOfIds": "j0t5t5b2@tkbxp5ia.com,4quxlswo@23wj7pwh.com",
        "datetime": "2018-12-12T00:00:00Z"
    }
    ```

    **Sample Response**

    ```json
    {
        "j0t5t5b2@tkbxp5ia.com" : {
            "result" : "Success",
            "proceed" : {
            "email" : "true"
            "emailResult" : "Success"
            },
            "explanation" : [ {
            "objectConsulted" : "ContactTypePointConsent",
            "status" : "opt_in",
            "purpose" : "billing",
            "recordId" : "003xx000004TxyY",
            "value" : "true"
            },{
            "objectConsulted" : "Contact",
            "field" : "HasOptedOutOfTracking",
            "recordId" : "1",
            "value" : "true"
            }]
        },
        "4quxlswo@23wj7pwh.com" : {
            "result" : "Success",
            "proceed" : {
            "email" : "false"
            "emailResult" : "Success"
            },
            "explanation" : [ {
            "objectConsulted" : "Contact",
            "field" : "HasOptedOutOfEmail",
            "recordId" : "00Qxx00000skwO",
            "value" : "true"
            }  ]
        }   
    }
    ```

??? note "consentDetailsOnMultipleAction"
    To retrieve consent details based on multiple actions, like email and track, across specific consent management objects when the records have a lookup relationship, use salesforcerest.consentDetailsOnMultipleAction. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_multiaction_consent.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/consent/multiaction?actions={listOfActions}&ids={listOfIds}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>listOfActions</td>
    <td>Comma-separated list of proposed actions. Ex: email, fax, geotrack, mail, phone, portability, process, profile, shouldforget, social, solicit, storepiielsewhere, track, web</td>
    <td>Yes</td>
    <td>email,track,fax</td>
    </tr>
    <tr>
    <td>listOfIds</td>
    <td>Comma-separated list of IDs. The ID can be the record ID or the email address listed on the record.</td>
    <td>Yes</td>
    <td>j0t5t5b2@tkbxp5ia.com,4quxlswo@23wj7pwh.com</td>
    </tr>
    <tr>
    <td>aggregatedConsent</td>
    <td>Whether to enable or disable aggregated consent. true or false.</td>
    <td>No</td>
    <td>true</td>
    </tr>
    <tr>
    <td>datetime</td>
    <td>The timestamp for which consent is determined.</td>
    <td>No</td>
    <td>2018-12-12T00:00:00Z</td>
    </tr>
    <tr>
    <td>policy</td>
    <td>The policy.</td>
    <td>No</td>
    <td>requireExplicitConsent</td>
    </tr>
    <tr>
    <td>purpose</td>
    <td>The reason for contacting a customer.</td>
    <td>No</td>
    <td>billing</td>
    </tr>
    <tr>
    <td>verbose</td>
    <td>Whether to allow verbose non-verbose responses. true or false</td>
    <td>No</td>
    <td>true</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.consentDetailsOnMultipleAction>
        <listOfActions>{$ctx:listOfActions}</listOfActions>
        <listOfIds>{$ctx:listOfIds}</listOfIds>
        <aggregatedConsent>{$ctx:aggregatedConsent}</aggregatedConsent> <!-- optional -->
        <datetime>{$ctx:datetime}</datetime> <!-- optional -->
        <policy>{$ctx:policy}</policy> <!-- optional -->
        <purpose>{$ctx:purpose}</purpose> <!-- optional -->
        <verbose>{$ctx:verbose}</verbose> <!-- optional -->
    </salesforcerest.consentDetailsOnMultipleAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "action":"track,geotrack,email",
        "listOfIds": "j0t5t5b2@tkbxp5ia.com,4quxlswo@23wj7pwh.com",
        "datetime": "2018-12-12T00:00:00Z",
        "verbose": "true",
        "purpose": "billing"
    }
    ```

    **Sample Response**

    ```json
    {
        "j0t5t5b2@tkbxp5ia.com" : {
            "result" : "Success",
            "proceed" : {
            "email" : "false"
            "emailResult" : "Success"
            "track" : "false"
            "trackResult" : "Success"
            "solicit" : "false"
            "solicitResult" : "Success"
            },
            "explanation" : [ {
            "objectConsulted" : "ContactTypePointConsent",
            "status" : "opt_in",
            "purpose" : "billing",
            "recordId" : "003xx000004TxyY",
            "value" : "true"
            },{
            "objectConsulted" : "Individual",
            "field" : "HasOptedOutOfTracking",
            "recordId" : "0PKx000006JkyZ",
            "value" : "true"
            }]
        },
        "4quxlswo@23wj7pwh.com" : {
            "result" : "Success",
            "proceed" : {
            "email" : "false"
            "emailResult" : "Success"
            "track" : "false"
            "trackResult" : "Success"
            "solicit" : "true"
            "solicitResult" : "Success"
            },
            "explanation" : [ {
            "objectConsulted" : "Contact",
            "field" : "HasOptedOutOfEmail",
            "recordId" : "00Qxx00000skwO",
            "value" : "true"
            },{
            "objectConsulted" : "Individual",
            "field" : "HasOptedOutOfSolicit",
            "recordId" : "0PKx000003JcpK",
            "value" : "false"
            }]
        }
    }
    ```

---

### Embedded Service

??? note "embeddedServiceConfig"
    To retrieve the values for your Embedded Service deployment configuration, including the branding colors, font, and site URL, use salesforcerest.embeddedServiceConfig. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_embeddedserviceconfigdescribe_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/support/embeddedservice/configuration/{embeddedServiceConfigDeveloperName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>embeddedServiceConfigDeveloperName</td>
    <td>The name of the embedded service config developer.</td>
    <td>Yes</td>
    <td>TestOne</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.embeddedServiceConfig>
        <embeddedServiceConfigDeveloperName>{$ctx:embeddedServiceConfigDeveloperName}</embeddedServiceConfigDeveloperName>
    </salesforcerest.embeddedServiceConfig>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "embeddedServiceConfigDeveloperName":"TestOne"
    }
    ```

    **Sample Response**

    ```json
    {
        "embeddedServiceConfig" : {
            "areGuestUsersAllowed" : false,
            "authMethod" : "CustomLogin",
            "embeddedServiceBranding" : {
            "contrastInvertedColor" : "#ffffff",
            "contrastPrimaryColor" : "#333333",
            "font" : "Salesforce Sans",
            "height" : 498,
            "navBarColor" : "#222222",
            "primaryColor" : "#222222",
            "secondaryColor" : "#005290",
            "width" : 320
            },
            "embeddedServiceLiveAgent" : {
            ...
        }
    }
    ```

??? note "returnHeadersForEmbeddedServiceConfig"
    To retrieve only the headers that are returned by the embeddedServiceConfig operation, use salesforcerest.returnHeadersForEmbeddedServiceConfig. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_embeddedserviceconfigdescribe_head.htm) for more information.

    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/support/embeddedservice/configuration/{embeddedServiceConfigDeveloperName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>embeddedServiceConfigDeveloperName</td>
    <td>The name of the embedded service config developer.</td>
    <td>Yes</td>
    <td>TestOne</td>
    </tr>
    </table>
    
    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForEmbeddedServiceConfig>
        <embeddedServiceConfigDeveloperName>{$ctx:embeddedServiceConfigDeveloperName}</embeddedServiceConfigDeveloperName>
    </salesforcerest.returnHeadersForEmbeddedServiceConfig>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "embeddedServiceConfigDeveloperName":"TestOne"
    }
    ```
    
---

### Event Monitoring

??? note "describeEventMonitoring"
    To retrieve the description of the event monitoring log, use salesforcerest.describeEventMonitoring. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_event_log_file_describe.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/EventLogFile/describe`

    **Sample configuration**

    ```xml
    <salesforcerest.describeEventMonitoring/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample response**

    ```json
    { 
            "actionOverrides" : [ ],
            "activateable" : false,
            "childRelationships" : [ ],
            "compactLayoutable" : false,
            "createable" : false,
            "custom" : false,
            "customSetting" : false,
            "deletable" : false,
            "deprecatedAndHidden" : false,
            "feedEnabled" : false,
            "fields" : [ {
            "autoNumber" : false,
            "byteLength" : 18,
            "calculated" : false,
            "calculatedFormula" : null,
            "cascadeDelete" : false,
            "caseSensitive" : false,
            "controllerName" : null,
            "createable" : false,
            ...
        }
    ```

??? note "queryEventMonitoringData"
    To retrieve the field values from a record, use salesforcerest.queryEventMonitoringData and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_event_log_file_query.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/query?q={queryStringForEventMonitoringData}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>queryStringForEventMonitoringData</td>
    <td>The query string to use to get the field values from the log.</td>
    <td>Yes</td>
    <td>SELECT+Id+,+EventType+,+LogFile+,+LogDate+,+LogFileLength+FROM+EventLogFile+WHERE+LogDate+>+Yesterday+AND+EventType+=+'API'
    </td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.queryEventMonitoringData>
        <queryStringForEventMonitoringData>{$ctx:queryStringForEventMonitoringData}</queryStringForEventMonitoringData>
    </salesforcerest.queryEventMonitoringData>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v34.0",
        "queryStringForEventMonitoringData": "SELECT+Id+,+EventType+,+LogFile+,+LogDate+,+LogFileLength+FROM+EventLogFile+WHERE+LogDate+>+Yesterday+AND+EventType+=+'API'",
    }
    ```

    **Sample response**

    ```json
    {
        "totalSize" : 4,
        "done" : true,
        "records" : [ {
            "attributes" : {
            "type" : "EventLogFile",
            "url" : "/services/data/v59.0/sobjects/EventLogFile/0ATD000000001bROAQ"     }
            "Id" : "0ATD000000001bROAQ",
            "EventType" : "API",
            "LogFile" : "/services/data/v59.0/sobjects/EventLogFile/0ATD000000001bROAQ/LogFile",
            "LogDate" : "2014-03-14T00:00:00.000+0000",
            "LogFileLength" : 2692.0
            }, 
            .
        ]
    }
    ```

??? note "getEventMonitoringContentFromRecord"
    To retrieve event monitoring content in binary format, use salesforcerest.getEventMonitoringContentFromRecord. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_event_log_file_blob.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/EventLogFile/{eventLogFileId}/LogFilee`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>eventLogFileId</td>
    <td>The ID of the event log file.</td>
    <td>Yes</td>
    <td>0ATD000000000pyOAA
    </td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getEventMonitoringContentFromRecord>
        <eventLogFileId>{$ctx:eventLogFileId}</eventLogFileId>
    </salesforcerest.getEventMonitoringContentFromRecord>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "eventLogFileId": "0ATD000000000pyOAA"
    }
    ```

    **Sample response**

    Event monitoring content is returned in binary form. Note that the response content type won’t be JSON or XML because the returned data is binary.

    ```
    HTTP/1.1 200 OK
    Date: Tue, 06 Aug 2013 16:46:10 GMT
    Sforce-Limit-Info: api-usage=135/5000
    Content-Type: application/octetstream
    Transfer-Encoding: chunked
    "EVENT_TYPE", "ORGANIZATION_ID", "TIMESTAMP","USER_ID", "CLIENT_IP",
    "URI", "REFERRER_URI", "RUN_TIME"
    "URI", "00DD0000000K5xD", "20130728185606.020", "005D0000001REDy",
    "10.0.62.141", "/secur/contentDoor", "https-//login-salesforce-com/",
    "11"
    "URI", "00DD0000000K5xD", "20130728185556.930", "005D0000001REI0",
    "10.0.62.141", "/secur/logout.jsp", "https-//MyDomainName-my-salesforce-com/00O/o",
    "54"
    "URI", "00DD0000000K5xD", "20130728185536.725", "005D0000001REI0",
    "10.0.62.141", "/00OD0000001ckx3",
    "https-//MyDomainName-my-salesforce-com/00OD0000001ckx3", "93"
    ```

---

### Invocable Actions

??? note "getListOfAction"
    To retrieve the list of general action types for the current organization, use salesforcerest.getListOfAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_actions_invocable.htm?search_text=action) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/actions`

    **Sample configuration**

    ```xml
    <salesforcerest.getListOfAction/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample response**

    ```json
    {
        "standard":"/services/data/v59.0/actions/standard",
        "custom":"/services/data/v59.0/actions/custom"
    }
    ```

??? note "returnHTTPHeadersForListOfAction"
    To retrieve only the headers that are returned by the getListOfAction operation, use salesforcerest.returnHTTPHeadersForListOfAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_actions_invocable_head.htm) for more information.

    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/actions`

    **Sample configuration**

    ```xml
    <salesforcerest.returnHTTPHeadersForListOfAction/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

??? note "getSpecificListOfAction"
    To retrieve an attribute of a single action, use salesforcerest.getSpecificListOfAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_actions_invocable_custom_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/actions/{actionType}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>actionType</td>
    <td>The type of the invocable action. Valid values: custom, standard.</td>
    <td>Yes</td>
    <td>standard</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getSpecificListOfAction>
        <actionType>{$ctx:actionType}</actionType>
    </salesforcerest.getSpecificListOfAction>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "actionType": "custom",
    }
    ```

    **Sample response**

    ```json
    {
        "quickAction" : "/services/data/v59.0/actions/custom/quickAction",
       "apex" : "/services/data/v59.0/actions/custom/apex",
       "emailAlert" : "/services/data/v59.0/actions/custom/emailAlert",
       "flow" : "/services/data/v59.0/actions/custom/flow",
       "sendNotification" : "/services/data/v59.0/actions/custom/sendNotification"
    }
    ```

??? note "returnHTTPHeadersForSpecificListOfAction"
    To retrieve only the headers that are returned by the getSpecificListOfAction operation, use salesforcerest.returnHTTPHeadersForSpecificListOfAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_actions_invocable_custom_head.htm) for more information.

    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/actions/{actionType}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>actionType</td>
    <td>The type of the invocable action. Valid values: custom, standard.</td>
    <td>Yes</td>
    <td>standard</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHTTPHeadersForSpecificListOfAction>
        <actionType>{$ctx:actionType}</actionType>
    </salesforcerest.returnHTTPHeadersForSpecificListOfAction>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "actionType": "standard",
    }
    ```

??? note "getAttributeOfSpecificAction"
    To retrieve an attribute of a single action, use salesforcerest.getAttributeOfSpecificAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_actions_invocable_standard.htm) for more information.
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>actionType</td>
    <td>The type of the invocable action.</td>
    <td>Yes</td>
    <td>standard</td>
    </tr>
    <tr>
    <td>attribute</td>
    <td>The attribute whose details you want to retrieve.</td>
    <td>Yes</td>
    <td>emailSimple</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getAttributeOfSpecificAction>
        <actionType>{$ctx:actionType}</actionType>
        <attribute>{$ctx:attribute}</attribute>
    </salesforcerest.getAttributeOfSpecificAction>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "actionType": "standard",
        "attribute": "emailSimple",
    }
    ```

    **Sample response**

    ```json
    {
        "actions":[
        {
            "name":"chatterPost",
            "label":"Post to Chatter",
            "type":"CHATTERPOST"
        },
        {
            "name":"emailSimple",
            "label":"Send Email",
            "type":"EMAILSIMPLE"
        }
        ...
        ]
    }
    ```
---

### Knowledge Support

??? note "listKnowledgeRESTApis"
    To retrieve knowledge support REST APIs that allow both authorized and guest users to retrieve the user’s visible data categories and their associated articles, use salesforcerest.listKnowledgeRESTApis. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_knowledge_support.htm) for more information.
    
    Equivalent to REST API `GET /services/data/vXX.X/support`

    **Sample configuration**

    ```xml
    <salesforcerest.listKnowledgeRESTApis/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0"
    }
    ```

    **Sample Response**

    ```json
    {
        "dataCategoryGroups" : "/services/data/vXX.X/support/dataCategoryGroups",
        "knowledgeArticles" : "/services/data/vXX.X/support/knowledgeArticles"
        :
    }
    ```

??? note "listDataCategoryGroups"
    To retrieve data category groups that are visible to the current user, use salesforcerest.listDataCategoryGroups. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_knowledge_support_dcgroups.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/support/dataCategoryGroups?sObjectName={sObjectName}&topCategoriesOnly={topCategoriesOnly}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of sObject. Support 'KnowledgeArticleVersion' only.</td>
    <td>Yes</td>
    <td>KnowledgeArticleVersion</td>
    </tr>
    <tr>
    <td>topCategoriesOnly</td>
    <td>A boolean value where the true returns only the top level categories and false returns the entire tree. Defaults to true.</td>
    <td>No</td>
    <td>true</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.listDataCategoryGroups>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <topCategoriesOnly>{$ctx:topCategoriesOnly}</topCategoriesOnly> <!-- optional -->
    </salesforcerest.listDataCategoryGroups>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "KnowledgeArticleVersion",
        "topCategoriesOnly": "true"
    }
    ```

    **Sample Response**

    ```json
    {
        "categoryGroups" : [ {
            "label" : "Doc",
            "name" : "Doc",
            "objectUsage" : "KnowledgeArticleVersion",
            "topCategories" : [ {
            "childCategories" : null,
            "label" : "All",
            "name" : "All",
            "url" : "/services/data/v59.0/support/dataCategoryGroups/Doc/dataCategories/All?sObjectName=KnowledgeArticleVersion"
            } ]
        }, {
            "label" : "Manual",
            "name" : "Manual",
            "objectUsage" : "KnowledgeArticleVersion",
            "topCategories" : [ {
            "childCategories" : null,
            "label" : "All",
            "name" : "All",
            "url" : "/services/data/v59.0/support/dataCategoryGroups/Manual/dataCategories/All?sObjectName=KnowledgeArticleVersion"
            } ]
        } ]
    }
    ```

??? note "getDataCategoryDetails"
    To retrieve data category details and the child categories by a given category, use salesforcerest.getDataCategoryDetails. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_knowledge_support_dcdetail.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/support/dataCategoryGroups/{group}/dataCategories/{category}?sObjectName={sObjectName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>group</td>
    <td>The data category group.</td>
    <td>Yes</td>
    <td>Doc</td>
    </tr>
    <tr>
    <td>category</td>
    <td>The data category.</td>
    <td>Yes</td>
    <td>All</td>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of sObject. Support 'KnowledgeArticleVersion' only.</td>
    <td>Yes</td>
    <td>KnowledgeArticleVersion</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getDataCategoryDetails>
        <group>{$ctx:group}</group>
        <category>{$ctx:category}</category>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.getDataCategoryDetails>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "KnowledgeArticleVersion",
        "group": "Doc",
        "category": "All"
    }
    ```

    **Sample Response**

    ```json
    {
        "childCategories" : [ {
            "childCategories" : null,
            "label" : "Help",
            "name" : "Help",
            "url" : "/services/data/v59.0/support/dataCategoryGroups/Doc/dataCategories/Help?sObjectName=KnowledgeArticleVersion"
        }, {
            "childCategories" : null,
            "label" : "QA",
            "name" : "QA",
            "url" : "/services/data/v59.0/support/dataCategoryGroups/Doc/dataCategories/QA?sObjectName=KnowledgeArticleVersion"
        } ],
        "label" : "All",
        "name" : "All",
        "url" : "/services/data/v59.0/support/dataCategoryGroups/Doc/dataCategories/All?sObjectName=KnowledgeArticleVersion"
    }
    ```

??? note "listArticles"
    To retrieve a page of online articles for the given language and category through either search or query, use salesforcerest.listArticles. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_knowledge_support_artlist.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/support/knowledgeArticles` or with optional parameters `GET /services/data/vXX.X/support/knowledgeArticles?queryString={queryString}&channel={channel}&categories={categories}&queryMethod={queryMethod}&sort={sort}&order={order}&pageSize={pageSize}&pageNumber={pageNumber}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>queryString</td>
    <td>The query string to perform an SOSL search.</td>
    <td>No</td>
    <td>FIND {MyProspect OR MyCompany}</td>
    </tr>
    <tr>
    <td>channel</td>
    <td>The name of the embedded service config developer. Valid channel values are App, Pkb, Csp, Prm</td>
    <td>No</td>
    <td>App</td>
    </tr>
    <tr>
    <td>categories</td>
    <td>The data categories in map json format with a limit of three data category conditions. Ex: {"group1":"category1","group2":"category2",...}. Defaults to None.</td>
    <td>No</td>
    <td>{"group1":"category1","group2":"category2"}</td>
    </tr>
    <tr>
    <td>queryMethod</td>
    <td>AT, BELOW, ABOVE, ABOVE_OR_BELOW. Only valid when categories are specified. Defaults to ABOVE_OR_BELOW.</td>
    <td>No</td>
    <td>ABOVE_OR_BELOW</td>
    </tr>
    <tr>
    <td>sort</td>
    <td>A sortable field name LastPublishedDate, CreatedDate, Title, ViewScore. Defaults to LastPublishedDate for query and relevance for search.</td>
    <td>No</td>
    <td>ViewScore</td>
    </tr>
    <tr>
    <td>order</td>
    <td>Either ASC or DESC, defaults to DESC. Valid only when sort is valid.</td>
    <td>No</td>
    <td>ASC</td>
    </tr>
    <tr>
    <td>pageSize</td>
    <td>Defaults to 20. Valid range 1 to 100.</td>
    <td>No</td>
    <td>10</td>
    </tr>
    <tr>
    <td>pageNumber</td>
    <td>The page number. Defaults to 1.</td>
    <td>No</td>
    <td>1</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.listArticles>
        <queryString>{$ctx:queryString}</queryString> <!-- optional -->
        <channel>{$ctx:channel}</channel> <!-- optional -->
        <categories>{$ctx:categories}</categories> <!-- optional -->
        <queryMethod>{$ctx:queryMethod}</queryMethod> <!-- optional -->
        <sort>{$ctx:sort}</sort> <!-- optional -->
        <order>{$ctx:order}</order> <!-- optional -->
        <pageSize>{$ctx:pageSize}</pageSize> <!-- optional -->
        <pageNumber>{$ctx:pageNumber}</pageNumber> <!-- optional -->
    </salesforcerest.listArticles>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sort": "ViewScore",
        "channel": "Pkb",
        "pageSize": 2
    }
    ```

    **Sample Response**

    ```json
    {
        "articles" : [ {
        "articleNumber" : "000001002",
        "categoryGroups" : [ ],
        "downVoteCount" : 0,
        "id" : "kA0xx000000000BCAQ",
        "lastPublishedDate" : "2015-02-25T02:07:18Z",
        "summary" : "With this online Chinese input tool, you can type Chinese characters through your web browser without installing any Chinese input software in your system. The Chinese online input tool uses the popular Pin Yin input method. It is a fast and convenient tool to input Chinese on English OS environments.",
        "title" : "Long text test",
        "upVoteCount" : 0,
        "url" : "/services/data/v59.0/support/knowledgeArticles/kA0xx000000000BCAQ",
        "viewCount" : 4,
        "viewScore" : 100.0
        }, {
        "articleNumber" : "000001004",
        "categoryGroups" : [ ],
        "downVoteCount" : 0,
        "id" : "kA0xx000000000LCAQ",
        "lastPublishedDate" : "2016-06-21T21:11:02Z",
        "summary" : "The number of characters required for complete coverage of all these languages' needs cannot fit in the 256-character code space of 8-bit character encodings, requiring at least a 16-bit fixed width encoding or multi-byte variable-length encodings. \r\n\r\nAlthough CJK encodings have common character sets, the encodings often used to represent them have been developed separately by different East Asian governments and software companies, and are mutually incompatible. Unicode has attempted, with some controversy, to unify the character sets in a process known as Han unification.\r\n\r\nCJK character encodings should consist minimally of Han characters p",
        "title" : "Test Images",
        "upVoteCount" : 0,
        "url" : "/services/data/v59.0/support/knowledgeArticles/kA0xx000000000LCAQ",
        "viewCount" : 0,
        "viewScore" : 0.0
        }],
        "currentPageUrl" : "/services/data/v59.0/support/knowledgeArticles?channel=Pkb&amp;pageSize=3&amp;sort=ViewScore",
        "nextPageUrl" : null,
        "pageNumber" : 1
    }
    ```

??? note "getArticleDetails"
    To retrieve all online article fields, accessible to the user, use salesforcerest.getArticleDetails. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_knowledge_support_artdetails.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/support/knowledgeArticles/{articleId_or_articleUrlName}?channel={channel}&updateViewStat={updateViewStat}&isUrlName={isUrlName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>articleId_or_articleUrlName</td>
    <td>The Id or the URL name of the article.</td>
    <td>Yes</td>
    <td>kA0xx000000000LCAQ</td>
    </tr>
    <tr>
    <td>channel</td>
    <td>The value of the channel. Defaults to user’s context. Valid channel values are App, Pkb, Csp, Prm</td>
    <td>No</td>
    <td>App</td>
    </tr>
    <tr>
    <td>updateViewStat</td>
    <td>A boolean value. If true, API updates the view count in the given channel as well as the total view count. Defaults to true.</td>
    <td>No</td>
    <td>true</td>
    </tr>
    <tr>
    <td>isUrlName</td>
    <td>A boolean value. If true, indicates that the last portion of the endpoint is a URL name instead of an article ID. Defaults to false.</td>
    <td>No</td>
    <td>true</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getArticleDetails>
        <articleId_or_articleUrlName>{$ctx:articleId_or_articleUrlName}</articleId_or_articleUrlName>
        <channel>{$ctx:channel}</channel> <!-- optional -->
        <updateViewStat>{$ctx:updateViewStat}</updateViewStat> <!-- optional -->
        <isUrlName>{$ctx:isUrlName}</isUrlName> <!-- optional -->
    </salesforcerest.getArticleDetails>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "articleId_or_articleUrlName": "kA0xx000000000LCAQ",
        "updateViewStat": "true"
    }
    ```

    **Sample Response**

    ```json
    {
       "allViewCount" : 17,
       "allViewScore" : 100.0,
       "appDownVoteCount" : 0,
       "appUpVoteCount" : 0,
       "appViewCount" : 17,
       "appViewScore" : 100.0,
       "articleNumber" : "000001004",
       "categoryGroups" : [ ],
       "createdBy" : {
       "email" : "user@company.com",
       "firstName" : "Test",
       "id" : "005xx000001SvoMAAS",
       "isActive" : true,
       "lastName" : "User",
       ...
    }
    ```

??? note "getKnowledgeLanguageSettings"
    To retrieve the existing Knowledge language settings, including the default knowledge language and a list of supported Knowledge language information, use salesforcerest.getKnowledgeLanguageSettings. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_knowledge_retrieve_language.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/knowledgeManagement/settings`

    **Sample configuration**

    ```xml
    <salesforcerest.getKnowledgeLanguageSettings/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0"
    }
    ```

    **Sample Response**

    ```json
    {
        "defaultLanguage" : "en_US",
        "knowledgeEnabled" : true,
        "languages" : [ {
        "active" : true,
        "name" : "en_US"
        }, {
        "active" : true,
        "name" : "it"
        }, {
        "active" : true,
        "name" : "zh_CN"
        }, {
        "active" : true,
        "name" : "fr"
        } ]
    }
    ```
---

### Layouts

??? note "sObjectLayouts"
    To retrieve a list of layouts and descriptions (including for actions) for a specific object, use salesforcerest.sObjectLayouts and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_approvallayouts_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/describe/approvalLayouts/`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts and descriptions you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.sObjectLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
    }
    ```

    **Sample Response**

    ```json
    "layouts":[
        {
         "detailLayoutSections":[
            {
               "heading":"Account Information",
               "columns":2,
               "tabOrder":"TopToBottom",
               "useCollapsibleSection":false,
               "rows":8,
               "useHeading":false,
               "layoutRows":[
                  {
                     "layoutItems":[
                        {
                           "editableForUpdate":false,
                           "editableForNew":false,
                           "layoutComponents":[
                              {
                                 "tabOrder":1,
                                 "details":{
                                    "defaultValue":null,
                                    "precision":0,
                                    "nameField":false,
                                    "type":"reference",
                                    "restrictedDelete":false,
                                    "relationshipName":"Owner",
                                    "calculatedFormula":null,
                                    "controllerName":null,
                                    "namePointing":false,
                                    "defaultValueFormula":null,
                                    "calculated":false,
                                    "writeRequiresMasterRead":false,
                                    "inlineHelpText":null,
                                    "picklistValues":[

                                    ]
                               }
                        }
                    ]
                 }
        .
        }
    ```

??? note "returnHeadersForSObjectLayouts"
    To retrieve only the headers that are returned by the sObjectLayouts operation, use salesforcerest.returnHeadersForSObjectLayouts and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_approvallayouts_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObjectName}/describe/approvalLayouts/`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts and descriptions you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.sObjectLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
    }
    ```


??? note "globalSObjectLayouts"
    To retrieve descriptions of global publisher layouts, use salesforcerest.globalSObjectLayouts. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_layouts_global_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/Global/describe/layouts/`

    **Sample configuration**

    ```xml
    <salesforcerest.globalSObjectLayouts/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample Response**

    ```json
    {
        "layouts":[
        {
            "detailLayoutSections":[

            ],
            "relatedContent":null,
            "editLayoutSections":[

            ],
            "relatedLists":[

            ],
            "buttonLayoutSection":null,
            "id":"00h28000001hExeAAE",
            "offlineLinks":[

            ],
            .
            .
        }
    }
    ```

??? note "returnHeadersForGlobalSObjectLayouts"
    To retrieve only the headers that are returned by the globalSObjectLayouts operation, use salesforcerest.returnHeadersForGlobalSObjectLayouts. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_layouts_global_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/Global/describe/layouts/`

    **Sample configuration**

    ```xml
    <salesforcerest.globalSObjectLayouts/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

??? note "compactLayouts"
    To retrieve a list of compact layouts for multiple objects, use salesforcerest.compactLayouts and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_compact_layouts.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/compactLayouts?q={sObjectNameList}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    </tr>
    <tr>
    <td>sObjectNameList</td>
    <td>A comma-separated list of the objects whose compact layouts you want to retrieve.</td>
    <td>Yes</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.compactLayouts/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectNameList":"Account,User",
    }
    ```

    **Sample Response**

    ```json
    {
        "Account":{
        "name":"SYSTEM",
        "id":null,
        "label":"System Default",
        "actions":[
            {
                "showsStatus":false,
                "custom":false,
                "label":"Call",
                "overridden":false,
                "encoding":null,
                "icons":[
                {
                    "width":0,
                    "theme":"theme4",
                    "contentType":"image/svg+xml",
                    "url":"https://kesavan-dev-ed.my.salesforce.com/img/icon/t4v59/action/call.svg",
                    "height":0
                },
                ],
                "windowPosition":null,
                "colors":[
                {
                    "color":"F2CF5B",
                    "context":"primary",
                    "theme":"theme4"
                }
                ],
        .
        .
        ],
        "objectType":"User"
        }
    }
    ```

??? note "sObjectApprovalLayouts"
    To retrieve a list of approval layouts for a specified object, use salesforcerest.sObjectApprovalLayouts and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_approvallayouts_process_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/describe/approvalLayouts/`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectApprovalLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.sObjectApprovalLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "approvalLayouts" : [ {
        "id" : "04aD00000008Py9IAE",
        "label" : "MyApprovalProcessName",
        "layoutItems" : [...],
        "name" : "MyApprovalProcessName"
        }, {
        "id" : "04aD00000008Q0KIAU",
        "label" : "Process1",
        "layoutItems" : [...],
        "name" : "Process1"
        } ]
    }
    ```

??? note "returnHeadersForSObjectApprovalLayouts"
    To retrieve only the headers that are returned by the sObjectApprovalLayouts operation, use salesforcerest.returnHeadersForSObjectApprovalLayouts and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_approvallayouts_process_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObjectName}/describe/approvalLayouts/`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectApprovalLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.sObjectApprovalLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
    }
    ```

??? note "sObjectCompactLayouts"
    To retrieve a list of compact layouts for a specific object, use salesforcerest.sObjectCompactLayouts and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_compactlayouts_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/describe/compactLayouts/`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectCompactLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.sObjectCompactLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "compactLayouts":[
        {
            "name":"SYSTEM",
            "id":null,
            "label":"System Default",
            "actions":[
                {
                "showsStatus":false,
                "custom":false,
                "label":"Call",
                "overridden":false,
                "encoding":null,
                "icons":[
                    {
                        "width":0,
                        "theme":"theme4",
                        "contentType":"image/svg+xml",
                        "url":"https://kesavan-dev-ed.my.salesforce.com/img/icon/t4v59/action/call.svg",
                        "height":0
                    }
                ],
                "defaultCompactLayoutId":null
        .
        ]
    }
    ```

??? note "returnHeadersForSObjectCompactLayouts"
    To retrieve only the headers that are returned by the sObjectCompactLayouts operation, use salesforcerest.returnHeadersForSObjectCompactLayouts and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_compactlayouts_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObjectName}/describe/compactLayouts/`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectCompactLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.sObjectCompactLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
    }
    ```

??? note "sObjectNamedLayouts"
    To retrieve information about alternative named layouts for a specific object, use salesforcerest.sObjectNamedLayouts and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_named_layouts.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/describe/namedLayouts/{layoutName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>layoutName</td>
    <td>The type of layout.</td>
    <td>Yes</td>
    <td>UserAlt</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectNamedLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <layoutName>{$ctx:layoutName}</layoutName>
    </salesforcerest.sObjectNamedLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "layoutName": "UserAlt",
    }
    ```

    **Sample Response**

    ```json
    {
        "layouts":[
        {
            "detailLayoutSections":[
                {
                "heading":"About",
                "columns":2,
                "tabOrder":"LeftToRight",
                "useCollapsibleSection":false,
                "rows":2,
                "useHeading":false,
                "layoutRows":[
                    {
                        "layoutItems":[
                            {
                            "editableForUpdate":false,
                            "editableForNew":false,
                            "layoutComponents":[
                                {
                                    "components":[
                                        {
                                        "tabOrder":2,
                                        "details":{
                                            "defaultValue":null,
                                            "precision":0,
                                            "nameField":false,
                                            "type":"string",
                                            "restrictedDelete":false,
                                            "relationshipName":null,
                                            "calculatedFormula":null,
                                            "controllerName":null,
                                            "namePointing":false,
                                            "defaultValueFormula":null,
                                            "calculated":false,
                                            "writeRequiresMasterRead":false,
                                            "inlineHelpText":null,
                                            "picklistValues":[

                                            ]
                                        }
                                }     
                            ]
                        }
    .
    }
    ```

??? note "sObjectLayoutsForObjectWithMultipleRecordTypes"
    To retrieve lists of page layouts and their descriptions for objects that have more than one record type defined, use salesforcerest.sObjectLayoutsForObjectWithMultipleRecordTypes and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_layouts_multiple_rts_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/describe/layouts/{recordTypeId}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>recordTypeId</td>
    <td>The id of the record type.</td>
    <td>Yes</td>
    <td>0125c000000oIN9AAM</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectNamedLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <recordTypeId>{$ctx:recordTypeId}</recordTypeId>
    </salesforcerest.sObjectNamedLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "recordTypeId": "0125c000000oIN9AAM",
    }
    ```

    **Sample Response**

    ```json
    {
        "buttonLayoutSection" : {
            "detailButtons" : [ 
                ...
            ]
        },
        "detailLayoutSections" : [
                ...
        ],
        "editLayoutSections" : [  
                ...
        ],
        "feedView" : null,
        "highlightsPanelLayoutSection" : null,
        "id" : "00ho000000CUJWIAA5",
        "multirowEditLayoutSections" : [ ],
        "offlineLinks" : [ ],
        "quickActionList" : {
            "quickActionListItems" : [
                    ...
            ]
        },
        "relatedContent" : null,
        "relatedLists" : [  
                ...
        ],
        "saveOptions" : [ ]
    }
    ```

??? note "returnHeadersForSObjectLayoutsForObjectWithMultipleRecordTypes"
    To retrieve only the headers that are returned by the sObjectLayoutsForObjectWithMultipleRecordTypes operation, use salesforcerest.returnHeadersForSObjectLayoutsForObjectWithMultipleRecordTypes and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_layouts_multiple_rts_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObjectName}/describe/layouts/{recordTypeId}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>recordTypeId</td>
    <td>The id of the record type.</td>
    <td>Yes</td>
    <td>0125c000000oIN9AAM</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectNamedLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <recordTypeId>{$ctx:recordTypeId}</recordTypeId>
    </salesforcerest.sObjectNamedLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "recordTypeId": "0125c000000oIN9AAM",
    }
    ```

??? note "sObjectApprovalLayoutsForSpecifiedApprovalProcess"
    To retrieve an approval layout for a named approval process on a specified object, use salesforcerest.sObjectApprovalLayoutsForSpecifiedApprovalProcess and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_approvallayouts_process_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/describe/approvalLayouts/{approvalProcessName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>approvalProcessName</td>
    <td>The Name of the approval process.</td>
    <td>Yes</td>
    <td>ExampleApprovalProcessName</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectNamedLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <approvalProcessName>{$ctx:approvalProcessName}</approvalProcessName>
    </salesforcerest.sObjectNamedLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "approvalProcessName": "ExampleApprovalProcessName",
    }
    ```

    **Sample Response**

    ```json
    {
        "approvalLayouts" : [ {
            "id" : "04aD00000008Py9IAE",
            "label" : "ExampleApprovalProcessName",
            "layoutItems" : [...],
            "name" : "ExampleApprovalProcessName"
        } ]
    }
    ```

??? note "returnHeadersForSObjectApprovalLayoutsForSpecifiedApprovalProcess"
    To retrieve only the headers that are returned by the sObjectApprovalLayoutsForSpecifiedApprovalProcess operation, use salesforcerest.returnHeadersForSObjectApprovalLayoutsForSpecifiedApprovalProcess and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_approvallayouts_process_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObject}/describe/approvalLayouts/{approvalProcessName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>approvalProcessName</td>
    <td>The Name of the approval process.</td>
    <td>Yes</td>
    <td>ExampleApprovalProcessName</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectNamedLayouts>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <approvalProcessName>{$ctx:approvalProcessName}</approvalProcessName>
    </salesforcerest.sObjectNamedLayouts>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "approvalProcessName": "ExampleApprovalProcessName",
    }
    ```

---

### List Views

??? note "listViews"
    To retrieve a list of list views for the specific sObject, use salesforcerest.listViews and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_listviews.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/listviews`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose list views you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.listViews>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.listViews>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "nextRecordsUrl":null,
        "size":7,
        "listviews":[
        {
            "resultsUrl":"/services/data/v59.0/sobjects/Account/listviews/00B280000032AihEAE/results",
            "soqlCompatible":true,
            "id":"00B280000032AihEAE",
            "label":"New This Week",
            "describeUrl":"/services/data/v59.0/sobjects/Account/listviews/00B280000032AihEAE/describe",
            "developerName":"NewThisWeek",
            "url":"/services/data/v59.0/sobjects/Account/listviews/00B280000032AihEAE"
        },
        .
        .
        ],
        "done":true,
        "sobjectType":"Account"
    }
    ```

??? note "listViewById"
    To retrieve the basic information about one list view for the specific sObject, use salesforcerest.listViewById and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_listview.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/listviews/{listViewID}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose list of list views you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>listViewId</td>
    <td>The ID of the specific list view whose information you want to return. This can be obtained by `listViews` operation</td>
    <td>Yes</td>
    <td>00B28000002yqeVEAQ</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.listViewById>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <listViewID>{$ctx:listViewID}</listViewID>
    </salesforcerest.listViewById>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
        "listViewID":"00B28000002yqeVEAQ",
    }
    ```

    **Sample Response**

    ```json
    {
        "resultsUrl":"/services/data/v59.0/sobjects/Account/listviews/00B280000032AihEAE/results",
        "soqlCompatible":true,
        "id":"00B280000032AihEAE",
        "label":"New This Week",
        "describeUrl":"/services/data/v59.0/sobjects/Account/listviews/00B280000032AihEAE/describe",
        "developerName":"NewThisWeek",
        "url":"/services/data/v59.0/sobjects/Account/listviews/00B280000032AihEAE"
    }
    ```

??? note "recentListViews"
    To retrieve the list of recently used list views for the given sObject type, use salesforcerest.recentListViews and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_recentlistviews.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/listviews/recent`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object whose recently used list views you want to return.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.recentListViews>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.recentListViews>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "nextRecordsUrl":null,
        "size":2,
        "listviews":[
        {
            "resultsUrl":"/services/data/v59.0/sobjects/Account/listviews/00B280000032AihEAE/results",
            "soqlCompatible":true,
            "id":"00B280000032AihEAE",
            "label":"New This Week",
            "describeUrl":"/services/data/v59.0/sobjects/Account/listviews/00B280000032AihEAE/describe",
            "developerName":"NewThisWeek",
            "url":"/services/data/v59.0/sobjects/Account/listviews/00B280000032AihEAE"
        }
        .
        .
        ],
        "done":true,
        "sobjectType":"Account"
    }
    ```

??? note "describeListViewById"
    To retrieve detailed information (ID, columns, and SOQL query) about a specific list view for the given sObject type, use salesforcerest.describeListViewById and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_listviewdescribe.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/listviews/{listViewID}/describe`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object to which the list view applies.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>listViewID</td>
    <td>The ID of the list view.</td>
    <td>Yes</td>
    <td>00B28000002yqeVEAQ (obtained by `listViews` operation)</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.describeListViewById>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <listViewID>{$ctx:listViewID}</listViewID>
    </salesforcerest.describeListViewById>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
        "listViewID":"00B28000002yqeVEAQ",
    }
    ```

    **Sample Response**

    ```json
    {
        "whereCondition":{
        "field":"CreatedDate",
        "values":[
            "THIS_WEEK"
        ],
        "operator":"equals"
        },
        "columns":[
        {
            "fieldNameOrPath":"Name",
            "sortDirection":"ascending",
            "hidden":false,
            "sortIndex":0,
            "ascendingLabel":"Z-A",
            "label":"Account Name",
            "sortable":true,
            "type":"string",
            "descendingLabel":"A-Z",
            "selectListItem":"Name"
        },
        .
        .
        ],
        "query":"SELECT Name, Site, BillingState, Phone, toLabel(Type), Owner.Alias, Id, CreatedDate, LastModifiedDate, SystemModstamp FROM Account WHERE CreatedDate = THIS_WEEK ORDER BY Name ASC NULLS FIRST, Id ASC NULLS FIRST",
        "scope":null,
        "orderBy":[
        {
            "fieldNameOrPath":"Name",
            "sortDirection":"ascending",
            "nullsPosition":"first"
        },
        {
            "fieldNameOrPath":"Id",
            "sortDirection":"ascending",
            "nullsPosition":"first"
        }
        ],
        "id":"00B280000032Aih",
        "sobjectType":"Account"
    }
    ```

??? note "listViewResults"
    To execute the SOQL query for the list view and return the resulting data and presentation information, use salesforcerest.listViewResults and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.198.0.api_rest.meta/api_rest/resources_listviewresults.htm?search_text=list%20view) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/listviews/{listViewID}/results`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object to which the list view applies.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>listViewID</td>
    <td>The ID of the list view (obtained by `listViews` operation).</td>
    <td>Yes</td>
    <td>00B28000002yqeVEAQ</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.listViewResults>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <listViewID>{$ctx:listViewID}</listViewID>
    </salesforcerest.listViewResults>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
        "listViewID":"00B28000002yqeVEAQ",
    }
    ```

    **Sample Response**

    ```json
    {
        "size":0,
        "records":[

        ],
        "columns":[
            {
                "fieldNameOrPath":"Name",
                "sortDirection":"ascending",
                "hidden":false,
                "sortIndex":0,
                "ascendingLabel":"Z-A",
                "label":"Account Name",
                "sortable":true,
                "type":"string",
                "descendingLabel":"A-Z",
                "selectListItem":"Name"
            },
            .
            .
        ],
        "id":"00B280000032Aih",
        "label":"New This Week",
        "developerName":"NewThisWeek",
        "done":true
    }
    ```

### Platform Event

??? note "platformEventSchemaByEventName"
    To retrieve the definition of a platform event for an event name, use salesforcerest.platformEventSchemaByEventName and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_eventschema.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{eventName}/eventSchema`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>eventName</td>
    <td>The name of the event.</td>
    <td>Yes</td>
    <td>Low_Ink__e</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.platformEventSchemaByEventName>
        <eventName>{$ctx:sObjectName}</eventName>
    </salesforcerest.platformEventSchemaByEventName>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "eventName": "Low_Ink__e"
    }
    ```

    **Sample Response**

    ```json
    {
        "name": "Low_Ink__e",
        "namespace": "com.sforce.eventbus",
        "type": "expanded-record",
        "fields": [
            {
            "name": "data",
            "type": {
                "type": "record",
                "name": "Data",
                "namespace": "",
                "fields": [
                {
                    "name": "schema",
                    "type": "string"
                },
                ,...
                ]
            }
            },
            {
            "name": "channel",
            "type": "string"
            }
        ]
    }
    ```

??? note "platformEventSchemaByEventNameAndSpecifiedPayloadFormat"
    To retrieve the definition of a platform event for an event name in specified payload format, use salesforcerest.platformEventSchemaByEventNameAndSpecifiedPayloadFormat and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_eventschema.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{eventName}/eventSchema?payloadFormat={payloadFormat}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>eventName</td>
    <td>The name of the event.</td>
    <td>Yes</td>
    <td>Low_Ink__e</td>
    </tr>
    <tr>
    <td>payloadFormat</td>
    <td>The format of the returned event schema. This parameter can either be EXPANDED or COMPACT.</td>
    <td>Yes</td>
    <td>COMPACT</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.platformEventSchemaByEventNameAndSpecifiedPayloadFormat>
        <eventName>{$ctx:sObjectName}</eventName>
        <payloadFormat>{$ctx:payloadFormat}</payloadFormat>
    </salesforcerest.platformEventSchemaByEventNameAndSpecifiedPayloadFormat>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "eventName": "Low_Ink__e",
        "payloadFormat": "COMPACT"
    }
    ```

    **Sample Response**

    ```json
    {
        "name": "Low_Ink__e",
        "namespace": "com.sforce.eventbus",
        "type": "record",
        "fields": [
            {
            "name": "CreatedDate",
            "type": "long",
            "doc": "CreatedDate:DateTime"
            },
            {
            "name": "CreatedById",
            "type": "string",
            "doc": "CreatedBy:EntityId"
            },
            {
            "name": "Printer_Model__c",
            "type": [
                "null",
                "string"
            ],
            "doc": "Data:Text:00NRM000001krnv",
            "default": null
            },...
        ],
        "uuid": "5E5OtZj5_Gm6Vax9XMXH9A"
    }
    ```

??? note "platformEventSchemaBySchemaId"
    To retrieve the definition of a platform event for a schema ID, use salesforcerest.platformEventSchemaBySchemaId and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_event_eventschema.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/event/eventSchema/{schemaId}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>schemaId</td>
    <td>The Id of the schema.</td>
    <td>Yes</td>
    <td>5E5OtZj5_Gm6Vax9XMXH9A</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.platformEventSchemaBySchemaId>
        <schemaId>{$ctx:schemaId}</schemaId>
    </salesforcerest.platformEventSchemaBySchemaId>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "schemaId": "5E5OtZj5_Gm6Vax9XMXH9A"
    }
    ```

    **Sample Response**

    ```json
    {
        "name": "Low_Ink__e",
        "namespace": "com.sforce.eventbus",
        "type": "expanded-record",
        "fields": [
            {
            "name": "data",
            "type": {
                "type": "record",
                "name": "Data",
                "namespace": "",
                "fields": [
                {
                    "name": "schema",
                    "type": "string"
                },
                ]
            }
            },
            {
            "name": "channel",
            "type": "string"
            }
        ]
    }
    ```

??? note "platformEventSchemaBySchemaIdAndSpecifiedPayloadFormat"
    To retrieve the definition of a platform event for a schema ID in specified payload format, use salesforcerest.platformEventSchemaBySchemaIdAndSpecifiedPayloadFormat and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_event_eventschema.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/event/eventSchema/{schemaId}?payloadFormat={payloadFormat}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>schemaId</td>
    <td>The Id of the schema.</td>
    <td>Yes</td>
    <td>5E5OtZj5_Gm6Vax9XMXH9A</td>
    </tr>
    <tr>
    <td>payloadFormat</td>
    <td>The format of the returned event schema. This parameter can either be EXPANDED or COMPACT.</td>
    <td>Yes</td>
    <td>COMPACT</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.platformEventSchemaBySchemaIdAndSpecifiedPayloadFormat>
        <schemaId>{$ctx:schemaId}</schemaId>
        <payloadFormat>{$ctx:payloadFormat}</payloadFormat>
    </salesforcerest.platformEventSchemaBySchemaIdAndSpecifiedPayloadFormat>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "schemaId": "5E5OtZj5_Gm6Vax9XMXH9A",
        "payloadFormat": "COMPACT"
    }
    ```

    **Sample Response**

    ```json
    {
        "name": "Low_Ink__e",
        "namespace": "com.sforce.eventbus",
        "type": "record",
        "fields": [
            {
            "name": "CreatedDate",
            "type": "long",
            "doc": "CreatedDate:DateTime"
            },
            {
            "name": "CreatedById",
            "type": "string",
            "doc": "CreatedBy:EntityId"
            },...
        ],
        "uuid": "5E5OtZj5_Gm6Vax9XMXH9A"
    }
    ```
---

### Process Rules

??? note "listProcessRules"
    To retrieve the list of process rules in the organization, use salesforcerest.listProcessRules. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_rules_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/process/rules/`

    **Sample configuration**

    ```xml
    <salesforcerest.listProcessRules/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample Response**

    ```json
    {
        "rules":{

        }
    }
    ```

??? note "returnHeadersForProcessRules"
    To retrieve only the headers that are returned by the listProcessRules operation, use salesforcerest.returnHeadersForProcessRules. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_rules_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/process/rules/`

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForProcessRules/>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

??? note "getSpecificProcessRule"
    To retrieve the metadata for a specific sObject process rule, use salesforcerest.getSpecificProcessRule and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_rule_object_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/process/rules/{sObjectName}/{workflowRuleId}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object whose process rule you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>workflowRuleId</td>
    <td>The ID of the process rule. You can get IDs using operation `listProcessRules`.</td>
    <td>Yes</td>
    <td>01QD0000000APli</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getSpecificProcessRule>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <workflowRuleId>{$ctx:workflowRuleId}</workflowRuleId>
    </salesforcerest.getSpecificProcessRule>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
        "workflowRuleId": "01QD0000000APli",
    }
    ```

    **Sample Response**

    ```json
    {
        "actions" : [ {
            "id" : "01VD0000000D2w7",
            "name" : "ApprovalProcessTask",
            "type" : "Task"
            } ],
            "description" : null,
            "id" : "01QD0000000APli",
            "name" : "My Rule",
            "namespacePrefix" : null,
            "object" : "Account"
    }
    ```

??? note "returnHeadersForSpecificProcessRule"
    To retrieve only the headers that are returned by the getSpecificProcessRule operation, use salesforcerest.returnHeadersForSpecificProcessRule and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_rule_object_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/process/rules/{sObjectName}/{workflowRuleId}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object whose process rule you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>workflowRuleId</td>
    <td>The ID of the process rule. You can get IDs using operation `listProcessRules`.</td>
    <td>Yes</td>
    <td>01QD0000000APli</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForSpecificProcessRule>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <workflowRuleId>{$ctx:workflowRuleId}</workflowRuleId>
    </salesforcerest.returnHeadersForSpecificProcessRule>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
        "workflowRuleId": "01QD0000000APli",
    }
    ```

??? note "getSpecificProcessRuleList"
    To retrieve all active workflow rules for an sObject, use salesforcerest.getSpecificProcessRuleList and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_rules_object_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/process/rules/{sObjectName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object whose process rule list you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getSpecificProcessRuleList>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.getSpecificProcessRuleList>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "rules" : {
            "Account" : [ {
            "actions" : [ {
                "id" : "01VD0000000D2w7",
                "name" : "ApprovalProcessTask",
                "type" : "Task"
            } ],
            "description" : null,
            "id" : "01QD0000000APli",
            "name" : "My Rule",
            "namespacePrefix" : null,
            "object" : "Account"
            } ]
        }
    }
    ```

??? note "returnHeadersForSpecificProcessRuleList"
    To retrieve all active workflow rules for an sObject, use salesforcerest.returnHeadersForSpecificProcessRuleList and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_rules_object_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/process/rules/{sObjectName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object whose process rule list you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForSpecificProcessRuleList>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.returnHeadersForSpecificProcessRuleList>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
    }
    ```

??? note "triggerProcessRules"
    To trigger all active workflow rules, use salesforcerest.triggerProcessRules and specify the following properties. All rules associated with the specified ID are evaluated, regardless of the evaluation criteria. All IDs must be for records on the same object. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_process_rules_post.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/process/rules/`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>An array of context IDs.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.triggerProcessRules>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.triggerProcessRules>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": {
                "contextIds" : [
                    "001D000000JRWBd",
                    "001D000000I8mIm",
                    "001D000000I8aaf"
                    ]
            }
    }
    ```

    **Sample Response**

    ```json
    {
        "errors" : null,
        "success" : true
    }
    ```
---

### Product Schedules

??? note "getProductSchedules"
    To retrieve revenue and quantity schedules for opportunity products, use salesforcerest.getProductSchedules and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_opportunitylineitemschedules_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/OpportunityLineItem/{OpportunityLineItemId}/OpportunityLineItemSchedules`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>OpportunityLineItemId</td>
    <td>The Id of the opportunity line item.</td>
    <td>Yes</td>
    <td>00kR0000001WJJAIA4</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getProductSchedules>
        <OpportunityLineItemId>{$ctx:OpportunityLineItemId}</OpportunityLineItemId>
    </salesforcerest.getProductSchedules>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "OpportunityLineItemId":"00kR0000001WJJAIA4"
    }
    ```


??? note "createProductSchedules"
    To establish or reestablish a product schedule with multiple installments for an opportunity product, use salesforcerest.createProductSchedules and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_opportunitylineitemschedules_put.htm) for more information.
    
    Equivalent to Salesforce REST API `PUT /services/data/vXX.X/sobjects/OpportunityLineItem/{OpportunityLineItemId}/OpportunityLineItemSchedules`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>OpportunityLineItemId</td>
    <td>The Id of the opportunity line item.</td>
    <td>Yes</td>
    <td>00kR0000001WJJAIA4</td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to create product schedules.</td>
    <td>Yes</td>
    <td><pre>{
        "type": "Both",
        "quantity": 100,
        "quantityScheduleType": "Repeat",
        "quantityScheduleInstallmentPeriod": "Monthly",
        "quantityScheduleInstallmentsNumber": 12,
        "quantityScheduleStartDate": "2018-09-15",
        "revenue": 100,
        "revenueScheduleType": "Repeat",
        "revenueScheduleInstallmentPeriod": "Monthly",
        "revenueScheduleInstallmentsNumber": 12,
        "revenueScheduleStartDate": "2018-09-15"
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.createProductSchedules>
        <OpportunityLineItemId>{$ctx:OpportunityLineItemId}</OpportunityLineItemId>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.createProductSchedules>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "OpportunityLineItemId":"00kR0000001WJJAIA4",
        "fieldAndValue": {
            "type": "Both",
            "quantity": 100,
            "quantityScheduleType": "Repeat",
            "quantityScheduleInstallmentPeriod": "Monthly",
            "quantityScheduleInstallmentsNumber": 12,
            "quantityScheduleStartDate": "2018-09-15",
            "revenue": 100,
            "revenueScheduleType": "Repeat",
            "revenueScheduleInstallmentPeriod": "Monthly",
            "revenueScheduleInstallmentsNumber": 12,
            "revenueScheduleStartDate": "2018-09-15"
        }
    }
    ```

??? note "deleteProductSchedules"
    To delete all installments in a revenue or quantity schedule for opportunity products, use salesforcerest.deleteProductSchedules and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_opportunitylineitemschedules_delete.htm) for more information.

    Equivalent to Salesforce REST API `DELETE /services/data/vXX.X/sobjects/OpportunityLineItem/{OpportunityLineItemId}/OpportunityLineItemSchedules`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>OpportunityLineItemId</td>
    <td>The Id of the opportunity line item.</td>
    <td>Yes</td>
    <td>00kR0000001WJJAIA4</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.deleteProductSchedules>
        <OpportunityLineItemId>{$ctx:OpportunityLineItemId}</OpportunityLineItemId>
    </salesforcerest.deleteProductSchedules>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "OpportunityLineItemId":"00kR0000001WJJAIA4"
    }
    ```
---

### Queries

??? note "query"
    To retrieve data from an object, use salesforcerest.query and specify the following properties. If you want your results to include deleted records in the Recycle Bin, use salesforcerest.queryAll in place of salesforcerest.query. See the [related API documentation for query](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_query.htm) and [queryAll](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_queryall.htm) for more information.

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value<th>
    </tr>
    <tr>
    <td>queryString</td>
    <td>The SQL query to use to search for records.</td>
    <td>Yes</td>
    <td>select id, name from Account</td>
    </tr>
    </table>

    **Sample configuration**

    query:

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/query?q={queryString}`

    ```xml
    <salesforcerest.query>
        <queryString>{$ctx:queryString}</queryString>
    </salesforcerest.query>
    ```

    queryAll:

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/queryAll?q={queryString}`

    ```xml
    <salesforcerest.queryAll>
        <queryString>{$ctx:queryString}</queryString>
    </salesforcerest.queryAll>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "queryString": "select id, name from Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "done" : false,
        "totalSize" : 2014,
        "nextRecordsUrl" : "/services/data/v20.0/query/01gD0000002HU6KIAW-2000",
        "records" : 
        [ 
            {  
                "attributes" : 
                {    
                    "type" : "Account",    
                    "url" : "/services/data/v20.0/sobjects/Account/001D000000IRFmaIAH"  
                },  
                "Name" : "Test 1"
            }, 
            {  
                "attributes" : 
                {    
                    "type" : "Account",    
                    "url" : "/services/data/v20.0/sobjects/Account/001D000000IomazIAB"  
                },  
                "Name" : "Test 2"
            }, 

            ...

        ]
    }
    ```

??? note "queryMore"
    If the results from the query or queryAll operations are too large, the first batch of results is returned along with an ID that you can use with salesforcerest.queryMore to get additional results. If you want your results to include deleted records in the Recycle Bin, use salesforcerest.queryAllMore in place of salesforcerest.queryMore. See the [related API documentation for queryMore](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_query_more_results.htm) and [queryAllMore](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_queryall_more_results.htm) for more information.
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>nextRecordsUrl</td>
    <td>The query identifier for retrieving additional results.</td>
    <td>Yes</td>
    <td>QWE45HUJ39D9UISD00</td>
    </tr>
    </table>

    **Sample configuration**

    queryMore:

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/query/{nextRecordsUrl}`

    ```xml
    <salesforcerest.queryMore>
        <nextRecordsUrl>{$ctx:nextRecordsUrl}</nextRecordsUrl>
    </salesforcerest.queryMore>
    ```

    queryAllMore:

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/queryAll/{nextRecordsUrl}`

    ```xml
    <salesforcerest.queryAllMore>
        <nextRecordsUrl>{$ctx:nextRecordsUrl}</nextRecordsUrl>
    </salesforcerest.queryAllMore>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "nextRecordsUrl": "QWE45HUJ39D9UISD00",
    }
    ```

    **Sample Response**

    ```json
    {
        "done" : true,
        "totalSize" : 3214,
        "records" : [...]
    }
    ```

??? note "queryPerformanceFeedback"
    To get feedback on how Salesforce will execute your query, use the salesforcerest.queryPerformanceFeedback operation. It uses the Query resource along with the explain parameter to get feedback. Salesforce analyzes each query to find the optimal approach to obtain the query results. Depending on the query and query filters, an index or internal optimization might be used. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_query_performance_feedback.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/query?explain={queryString}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>queryString</td>
    <td>The SQL query to use to get feedback for a query.</td>
    <td>Yes</td>
    <td>select id, name from Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.queryPerformanceFeedback>
        <queryString>{$ctx:queryString}</queryString>
    </salesforcerest.queryPerformanceFeedback>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "queryString": "select id, name from Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "plans":[
        {
            "leadingOperationType":"TableScan",
            "relativeCost":2.8324836601307193,
            "sobjectCardinality":2549,
            "fields":[

            ],
            "cardinality":2549,
            "sobjectType":"Account"
        }
        ]
    }
    ```

??? note "listviewQueryPerformanceFeedback"
    To retrieve query performance feedback on a report or list view, use salesforcerest.listviewQueryPerformanceFeedback and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_query_explain.htm) for more information.
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>listViewID</td>
    <td>The ID of the report or list view to get feedback for a query.</td>
    <td>Yes</td>
    <td>00B28000002yqeVEAQ</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.listviewQueryPerformanceFeedback>
        <listViewID>{$ctx:listViewID}</listViewID>
    </salesforcerest.listviewQueryPerformanceFeedback>
    ```
    
    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "listViewID":"00B28000002yqeVEAQ",
    }
    ```

    **Sample Response**

    ```json
    {
        "plans":[
        {
            "leadingOperationType":"Index",
            "relativeCost":0,
            "sobjectCardinality":2549,
            "fields":[
                "CreatedDate"
            ],
            "cardinality":0,
            "sobjectType":"Account"
        },
        .
        .
        ]
    }
    ```
---

### Quick Actions

??? note "quickActions"
    To retrieve a list of global actions, use salesforcerest.quickActions. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_quickactions_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/quickActions/`

    **Sample configuration**

    ```xml
    <salesforcerest.quickActions/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample Response**

    ```json
    {
        "output":"[
            { 
                \"actorIds\" : [ \"005D00000015rY9IAI\" ],
                \"entityId\" : \"001D000000I8mImIAJ\",
                \"errors\" : null,
                \"instanceId\" : \"04gD0000000Cvm5IAC\",
                \"instanceStatus\" : \"Pending\",
                \"newWorkitemIds\" : [ \"04iD0000000Cw6SIAS\" ],
                \"success\" : true 
            } 
        ]"
    }
    ```

??? note "returnHeadersForQuickAction"
    To retrieve only the headers that are returned by the quickActions operation, use salesforcerest.returnHeadersForQuickAction. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_quickactions_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/quickActions/`

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForQuickAction/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

??? note "sObjectAction"
    To retrieve a list of object-specific actions, use salesforcerest.sObjectAction and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/quickActions/`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve a list of quick actions.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectAction>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.sObjectAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "output":"[
        {\"label\":\"Log a Call\",
        \"name\":\"LogACall\",\"type\":\"LogACall\",
        \"urls\":{\"defaultValues\":\"/services/data/v59.0/quickActions/LogACall/defaultValues\",
        \"quickAction\":\"/services/data/v59.0/quickActions/LogACall\",
        \"describe\":\"/services/data/v59.0/quickActions/LogACall/describe\",
        \"defaultValuesTemplate\":\"/services/data/v59.0/quickActions/LogACall/defaultValues/{ID}\"}},
        .
        .
        ]"
    }
    ```

??? note "returnHeadersForSObjectAction"
    To retrieve only the headers that are returned by the sObjectAction operation, use salesforcerest.returnHeadersForSObjectAction and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_head.htm) for more information.

    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObjectName}/quickActions/`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve a list of quick actions.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForSObjectAction>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.returnHeadersForSObjectAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
    }
    ```

??? note "getSpecificAction"
    To retrieve a specific action, use salesforcerest.getSpecificAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_specific_action_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/quickActions/{actionName}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve the specific quick action.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The name of action to return.</td>
    <td>Yes</td>
    <td>hariprasath__LogACall</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getSpecificAction>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <actionName>{$ctx:actionName}</actionName>
    </salesforcerest.getSpecificAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
        "actionName":"hariprasath__LogACall"
    }
    ```

    **Sample Response**

    ```json
    {
        "iconName":null,
        "targetRecordTypeId":null,
        "targetSobjectType":"Task",
        "canvasApplicationName":null,
        "label":"Log a Call",
        "accessLevelRequired":null,
        "icons":[
            {
                "width":0,
                "theme":"theme4",
                "contentType":"image/svg+xml",
                "url":"https://kesavan-dev-ed.my.salesforce.com/img/icon/t4v59/action/log_a_call.svg",
                "height":0
            },
        .
        . 
        ],
        "targetParentField":null,
        "iconUrl":"https://kesavan-dev-ed.my.salesforce.com/img/icon/log_a_call_32.png",
        "height":null
    }
    ```

??? note "returnHeadersForSpecificQuickAction"
    To retrieve only the headers that are returned by the getSpecificAction operation, use salesforcerest.returnHeadersForSpecificQuickAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_specific_action_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObjectName}/quickActions/{actionName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve the specific quick action.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The name of action to return.</td>
    <td>Yes</td>
    <td>hariprasath__LogACall</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForSpecificQuickAction>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <actionName>{$ctx:actionName}</actionName>
    </salesforcerest.returnHeadersForSpecificQuickAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
        "actionName":"hariprasath__LogACall"
    }
    ```

??? note "getDescribeSpecificAction"
    To retrieve the description of a specific action, use salesforcerest.getDescribeSpecificAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_detail_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/quickActions/{actionName}/describe/`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve the specific quick action.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The action whose description you want to return.</td>
    <td>Yes</td>
    <td>hariprasath__LogACall</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getDescribeSpecificAction>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <actionName>{$ctx:actionName}</actionName>
    </salesforcerest.getDescribeSpecificAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "actionName":"hariprasath__LogACall"
    }
    ```

    **Sample Response**

    ```json
    {
        "iconName":null,
        "targetRecordTypeId":null,
        "targetSobjectType":"Task",
        "canvasApplicationName":null,
        "label":"Log a Call",
        "accessLevelRequired":null,
        "icons":[
            {
                "width":0,
                "theme":"theme4",
                "contentType":"image/svg+xml",
                "url":"https://kesavan-dev-ed.my.salesforce.com/img/icon/t4v59/action/log_a_call.svg",
                "height":0
            }
        ],
        .
        .
        "targetParentField":null,
        "iconUrl":"https://kesavan-dev-ed.my.salesforce.com/img/icon/log_a_call_32.png",
        "height":null
    }
    ```

??? note "returnHeadersForDescribeSpecificAction"
    To retrieve only the headers that are returned by the getDescribeSpecificAction operation, use salesforcerest.returnHeadersForDescribeSpecificAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_detail_head.htm) for more information.

    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObjectName}/quickActions/{actionName}/describe/`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve the specific quick action.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The action whose description you want to return.</td>
    <td>Yes</td>
    <td>hariprasath__LogACall</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForDescribeSpecificAction>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <actionName>{$ctx:actionName}</actionName>
    </salesforcerest.returnHeadersForDescribeSpecificAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "actionName":"hariprasath__LogACall"
    }
    ```

??? note "getDefaultValueOfAction"
    To return a specific action’s default values, including default field values, use salesforcerest.getDefaultValueOfAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_default_values_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/quickActions/{actionName}/defaultValues/`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve a specific action’s default values.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The specific action.</td>
    <td>Yes</td>
    <td>hariprasath__LogACall</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getDefaultValueOfAction>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <actionName>{$ctx:actionName}</actionName>
    </salesforcerest.getDefaultValueOfAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "actionName":"hariprasath__LogACall",
    }
    ```

    **Sample Response**

    ```json
    {
        "WhoId":null,
        "Description":null,
        "WhatId":null,
        "attributes":{
            "type":"Task"
        },
        "Subject":"Call"
    }
    ```

??? note "returnHeadersForDefaultValueOfAction"
    To return only the headers that are returned by the getDefaultValueOfAction operation, use salesforcerest.returnHeadersForDefaultValueOfAction and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_default_values_head.htm) for more information.

    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObjectName}/quickActions/{actionName}/defaultValues/`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve a specific action’s default values.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The specific action.</td>
    <td>Yes</td>
    <td>hariprasath__LogACall</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForDefaultValueOfAction>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <actionName>{$ctx:actionName}</actionName>
    </salesforcerest.returnHeadersForDefaultValueOfAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "actionName":"hariprasath__LogACall",
    }
    ```

??? note "getDefaultValueOfActionById"
    To return the default values for an action specific to the context_id object, use salesforcerest.getDefaultValueOfActionById and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_default_values_id_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/quickActions/{actionName}/defaultValues/{contextId}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve a specific action’s default values.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>contextId</td>
    <td>The specific context id to retrieve the default values of an action.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The specific action.</td>
    <td>Yes</td>
    <td>hariprasath__LogACall</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getDefaultValueOfActionById>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <actionName>{$ctx:actionName}</actionName>
        <contextId>{$ctx:contextId}</contextId>
    </salesforcerest.getDefaultValueOfActionById>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "actionName":"CreateContact",
        "contextId":"001D000000JRWBd"
    }
    ```

    **Sample Response**

    ```json
    {
        "WhoId":null,
        "Description":null,
        "WhatId":null,
        "attributes":{
            "type":"Task"
        },
        "Subject":"Call"
    }
    ```

??? note "returnHeadersForDefaultValueOfActionById"
    To return only the headers that are returned by the getDefaultValueOfActionById operation, use salesforcerest.returnHeadersForDefaultValueOfActionById and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_default_values_id_head.htm) for more information.

    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{sObjectName}/quickActions/{actionName}/defaultValues/{contextId}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you want to retrieve a specific action’s default values.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>contextId</td>
    <td>The specific context id to retrieve the default values of an action.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The specific action.</td>
    <td>Yes</td>
    <td>hariprasath__LogACall</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForDefaultValueOfActionById>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <actionName>{$ctx:actionName}</actionName>
        <contextId>{$ctx:contextId}</contextId>
    </salesforcerest.returnHeadersForDefaultValueOfActionById>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "actionName":"CreateContact",
        "contextId":"001D000000JRWBd"
    }
    ```
---

??? note "create"
    To create a record, use salesforcerest.create and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_sobject_create.htm) for more information.

    Equivalent to Salesforce REST API `POST /services/data/vXX.X/sobjects/{sObjectName}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will create a record.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to create the record. Include all mandatory fields according to the requirements for the specified sObject.</td>
    <td>Yes</td>
    <td><pre>{
        "name": "wso2",
        "description":"This Account belongs to WSO2"
    }
    </pre></td>
    </tr>
    </table>

    > **Note**: For example, if you are creating a record for the Account sObject, "name" is a mandatory parameter, and you might want to include the optional description, so the fieldAndValue property would look like this:
    > ```json
    > {
    >   "name":"wso2",
    >   "description":"This account belongs to WSO2"
    > }
    > ```

    **Sample configuration**

    ```xml
    <salesforcerest.create>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.create>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",,
        "fieldAndValue": {
            "name": "wso2",
            "description":"This Account belongs to WSO2"
        }
    }
    ```

    **Sample Response**

    ```json
    {
        "success":true,
        "id":"0010K00001uiAn8QAE",
        "errors":[

        ]
    }
    ```

??? note "createMultipleRecords"
    To create multiple records of the same sObject type, use salesforcerest.createMultipleRecords and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_composite_sobject_tree_flat.htm#topic-title) for more information.

    Equivalent to Salesforce REST API `POST /services/data/vXX.X/composite/tree/{sObjectName}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will create multiple records.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property, which specifies each record as an entry within the records array. Include all mandatory fields according to the requirements for the specified sObject.</td>
    <td>Yes</td>
    <td><pre>{
    "records": [
    {
    "attributes": {"type": "Account", "referenceId": "ref1"},
    "name": "wso2",
    "phone": "1111111",
    "website": "www.salesforce1.com"
    },
    {
    "attributes": {"type": "Account", "referenceId": "ref2"},
    "name": "slwso2",
    "phone": "22222222",
    "website": "www.salesforce2.com"
    }]
    }
    </pre></td>
    </tr>
    </table>

    > **Note**: For example, if you are creating a record for the Account sObject, "name" is a mandatory parameter, and you might want to include the optional description, so the fieldAndValue property would look like this:
    > ```json
    > {
    >   "records": [
    >   {
    >        "attributes": {"type": "Account", "referenceId": "ref1"},
    >        "name": "wso2",
    >        "phone": "1111111",
    >        "website": "www.salesforce1.com"
    >    },
    >    {
    >        "attributes": {"type": "Account", "referenceId": "ref2"},
    >        "name": "slwso2",
    >        "phone": "22222222",
    >        "website": "www.salesforce2.com"
    >    }]
    > }
    > ```

    **Sample configuration**

    ```xml
    <salesforcerest.createMultipleRecords>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.createMultipleRecords>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "fieldAndValue": {
        "records": [
            {
            "attributes": {"type": "Account", "referenceId": "ref1"},
            "name": "wso2",
            "phone": "1111111",
            "website": "www.salesforce1.com"
            },
            {
            "attributes": {"type": "Account", "referenceId": "ref2"},
            "name": "slwso2",
            "phone": "22222222",
            "website": "www.salesforce2.com"
            }]
        }
    }
    ```

    **Sample Response**

    ```json
    {
        "hasErrors" : false,
        "results" : [{
        "referenceId" : "ref1",
        "id" : "001D000000K1YFjIAN"
        },{
        "referenceId" : "ref2",
        "id" : "001D000000K1YFkIAN"
        },{
        "referenceId" : "ref3",
        "id" : "001D000000K1YFlIAN"
        },{
        "referenceId" : "ref4",
        "id" : "001D000000K1YFmIAN"     
        }]
    }
    ```

??? note "createNestedRecords"
    To create nested records for a specific sObject, use salesforcerest.createNestedRecords and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_composite_sobject_tree_create.htm) for more information.

    Equivalent to Salesforce REST API `POST /services/data/vXX.X/composite/tree/{sObjectName}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will create nested records.</td>
    <td>Yes</td>
    <td></td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property, which specifies each record as an entry within the records array. Include all mandatory fields according to the requirements for the specified sobject.</td>
    <td>Yes</td>
    <td><pre>{
    "records" :[{
    "attributes" : {"type" : "Account", "referenceId" : "ref1"},
    "name" : "SampleAccount1",
    "phone" : "1234567890",
    "website" : "www.salesforce.com",
    "numberOfEmployees" : "100",
    "type" : "Analyst",
    "industry" : "Banking",
    "Contacts" : {
    "records" : [{
    "attributes" : {"type" : "Contact", "referenceId" : "ref2"},
    "lastname" : "Smith",
    "Title" : "President",
    "email" : "sample@salesforce.com"
    },{
    "attributes" : {"type" : "Account", "referenceId" : "ref3"},
    "lastname" : "Evans",
    "title" : "Vice President",
    "email" : "sample@salesforce.com"
    }]
    }
    },{
    "attributes" : {"type" : "Account", "referenceId" : "ref4"},
    "name" : "SampleAccount2",
    "phone" : "1234567890",
    "website" : "www.salesforce.com",
    "numberOfEmployees" : "52000",
    "type" : "Analyst",
    "industry" : "Banking",
    "childAccounts" : {
    "records" : [{
    "attributes" : {"type" : "Account", "referenceId" : "ref5"},
    "name" : "SampleChildAccount1",
    "phone" : "1234567890",
    "website" : "www.salesforce.com",
    "numberOfEmployees" : "100",
    "type" : "Analyst",
    "industry" : "Banking"
    }]
    },
    "Contacts" : {
    "records" : [{
    "attributes" : {"type" : "Contact", "referenceId" : "ref6"},
    "lastname" : "Jones",
    "title" : "President",
    "email" : "sample@salesforce.com"
    }]
    }
    }]
    }
    </pre></td>
    </tr>
    </table>

    > **Note**: For example, if you are creating records for the Account sObject, "name" is a mandatory parameter, and you might want to include additional optional values for each record, so the fieldAndValue property might look like this:
    > ```json
    > {
    >   "records" :[{
    >   "attributes" : {"type" : "Account", "referenceId" : "ref1"},
    >   "name" : "SampleAccount1",
    >   "phone" : "1234567890",
    >   "website" : "www.salesforce.com",
    >   "numberOfEmployees" : "100",
    >   "type" : "Analyst",
    >   "industry" : "Banking",
    >   "Contacts" : {
    >     "records" : [{
    >       "attributes" : {"type" : "Contact", "referenceId" : "ref2"},
    >       "lastname" : "Smith",
    >       "Title" : "President",
    >       "email" : "sample@salesforce.com"
    >     },{
    >       "attributes" : {"type" : "Contact", "referenceId" : "ref3"},
    >       "lastname" : "Evans",
    >       "title" : "Vice President",
    >       "email" : "sample@salesforce.com"
    >     }]
    >   }
    >   },{
    >   "attributes" : {"type" : "Account", "referenceId" : "ref4"},
    >   "name" : "SampleAccount2",
    >   "phone" : "1234567890",
    >   "website" : "www.salesforce.com",
    >   "numberOfEmployees" : "52000",
    >   "type" : "Analyst",
    >   "industry" : "Banking",
    >   "childAccounts" : {
    >     "records" : [{
    >       "attributes" : {"type" : "Account", "referenceId" : "ref5"},
    >       "name" : "SampleChildAccount1",
    >       "phone" : "1234567890",
    >       "website" : "www.salesforce.com",
    >       "numberOfEmployees" : "100",
    >       "type" : "Analyst",
    >       "industry" : "Banking"
    >     }]
    >   },
    >   "Contacts" : {
    >     "records" : [{
    >       "attributes" : {"type" : "Contact", "referenceId" : "ref6"},
    >       "lastname" : "Jones",
    >       "title" : "President",
    >       "email" : "sample@salesforce.com"
    >     }]
    >   }
    >   }]
    > }
    > ```

    **Sample configuration**

    ```xml
    <salesforcerest.createNestedRecords>
        <sObjectName>{$ctx:sObjectName}</sobject>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.createNestedRecords>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",,
        "fieldAndValue":{
            "records" :[{
                "attributes" : {"type" : "Account", "referenceId" : "ref1"},
                "name" : "SampleAccount1",
                "phone" : "1234567890",
                "website" : "www.salesforce.com",
                "numberOfEmployees" : "100",
                "type" : "Analyst",
                "industry" : "Banking",
                "Contacts" : {
                  "records" : [{
                    "attributes" : {"type" : "Contact", "referenceId" : "ref2"},
                    "lastname" : "Smith",
                    "Title" : "President",
                    "email" : "sample@salesforce.com"
                  },{
                    "attributes" : {"type" : "Account", "referenceId" : "ref3"},
                    "lastname" : "Evans",
                    "title" : "Vice President",
                    "email" : "sample@salesforce.com"
                }]
                }
            },...
            ]
        }
    }
    ```

    **Sample Response**

    ```json
    {
        "hasErrors" : false,
        "results" : [{
        "referenceId" : "ref1",
        "id" : "001D000000K0fXOIAZ"
        },{
        "referenceId" : "ref4",
        "id" : "001D000000K0fXPIAZ"
        },{
        "referenceId" : "ref2",
        "id" : "003D000000QV9n2IAD"
        },{
        "referenceId" : "ref3",
        "id" : "003D000000QV9n3IAD"
        },{
        "referenceId" : "ref5",
        "id" : "001D000000K0fXQIAZ"
        },{
        "referenceId" : "ref6",
        "id" : "003D000000QV9n4IAD"
        }]
    }
    ```

??? note "createUsingExternalId"
    To create a new record based on the field values included in the request body, use salesforcerest.createUsingExternalId and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_upsert_post.htm) for more information.

    Equivalent to Salesforce REST API `POST /services/data/vXX.X/sobjects/{sObjectName}/Id`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will create a record.</td>
    <td>Yes</td>
    <td></td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to create the record. Include all mandatory fields according to the requirements for the specified sObject.</td>
    <td>Yes</td>
    <td><pre>{
        "Name" : "California Wheat Corporation",
        "Type" : "New Customer"
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.createUsingExternalId>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.createUsingExternalId>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "fieldAndValue": {
            "records": {
                "Name" : "California Wheat Corporation",
                "Type" : "New Customer"
            }
        }
    }
    ```

    **Sample Response**

    ```json
    {
        "id" : "001D000000Kv3g5IAB",
        "success" : true,
        "errors" : [ ],
        "created": true
    }
    ```

??? note "createUsingQuickAction"
    To create a record via a quick action, use salesforcerest.createUsingQuickAction and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_quickactions_post.htm) for more information.

    Equivalent to Salesforce REST API `POST /services/data/vXX.X/quickActions/{actionName}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The specific action name to create the record.</td>
    <td>Yes</td>
    <td></td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to create the record using a quick action. Include all mandatory fields according to the requirements for the specified sObject.</td>
    <td>Yes</td>
    <td><pre>{
       "record" : { "LastName" : "Smith" }
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.createUsingQuickAction>
        <actionName>{$ctx:actionName}</actionName>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.createUsingQuickAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "actionName":"CreateContact",
        "fieldAndValue": {
            "record" : { "LastName" : "Smith" }
        }
    }
    ```

??? note "createUsingSpecificSObjectQuickAction"
    To create a record via the specified quick action based on the field values included in the request body, use salesforcerest.createUsingSpecificSObjectQuickAction and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_quickactions_specific_action_post.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/sobjects/{sObjectName}/quickActions/{actionName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will create a record.</td>
    <td>Yes</td>
    <td></td>
    </tr>
    <tr>
    <td>actionName</td>
    <td>The specific action name to create the record.</td>
    <td>Yes</td>
    <td></td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to create the record using a quick action. Include all mandatory fields according to the requirements for the specified sObject.</td>
    <td>Yes</td>
    <td><pre>{
       "contextId" : "001D000000JRSGf",
       "record" : { "LastName" : "Smith" }
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.createUsingSpecificSObjectQuickAction>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <actionName>{$ctx:actionName}</actionName>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.createUsingSpecificSObjectQuickAction>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "actionName":"CreateContact",
        "fieldAndValue": {
            "contextId" : "001D000000JRSGf",
            "record" : { "LastName" : "Smith" }
        }
    }
    ```

??? note "createUsingSObjectCollections"
    To create records using sObject collections, use salesforcerest.createUsingSObjectCollections and specify the following properties. Can add up to 200 records. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_sobjects_collections_create.htm) for more information.

    Equivalent to Salesforce REST API `POST /services/data/vXX.X/composite/sobjects`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to create the record using sObject collections. Include all mandatory fields according to the requirements for the specified sObject.</td>
    <td>Yes</td>
    <td><pre>{
       "allOrNone" : false,
       "records" : [{
          "attributes" : {"type" : "Account"},
          "Name" : "example.com",
          "BillingCity" : "San Francisco"
       }, {
          "attributes" : {"type" : "Contact"},
          "LastName" : "Johnson",
          "FirstName" : "Erica"
       }]
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.createUsingSObjectCollections>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.createUsingSObjectCollections>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "actionName":"CreateContact",
        "fieldAndValue": {
            "allOrNone" : false,
            "records" : [{
                "attributes" : {"type" : "Account"},
                "Name" : "example.com",
                "BillingCity" : "San Francisco"
            }, {
                "attributes" : {"type" : "Contact"},
                "LastName" : "Johnson",
                "FirstName" : "Erica"
            }]
        }
    }
    ```

    **Sample Response**

    ```json
    [
        {
            "id" : "001RM000003oLnnYAE",
            "success" : true,
            "errors" : [ ]
        },
        {
            "id" : "003RM0000068xV6YAI",
            "success" : true,
            "errors" : [ ]
        }
    ]
    ```

??? note "getRecordsUsingRelationships"
    To retrieve a record based on the specified object, record ID, and relationship field, use salesforcerest.getRecordsUsingRelationships and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_relationships_get.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/{id}/{relationshipFieldName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will create a record.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>id</td>
    <td>The identifier of the record.</td>
    <td>Yes</td>
    <td>001R0000005hDFYIA2</td>
    </tr>
    <tr>
    <td>relationshipFieldName</td>
    <td>The name of the field that contains the relationship.</td>
    <td>Yes</td>
    <td>Opportunities</td>
    </tr>
    <tr>
    <td>fields</td>
    <td>A comma-delimited list of fields in the associated relationship record returned in the response body.</td>
    <td>No</td>
    <td>field1,field2</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getRecordsUsingRelationships>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <id>{$ctx:id}</id>
        <relationshipFieldName>{$ctx:relationshipFieldName}</relationshipFieldName>
        <fields>{$ctx:fields}</fields>
    </salesforcerest.getRecordsUsingRelationships>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "id":"001R0000005hDFYIA2",
        "relationshipFieldName":"Opportunities",
        "fields":"field1,field2"
    }
    ```

    **Sample Response**

    ```json
    {
        "attributes" : 
        { 
            "type" : "Distributor__c",
            "url" : "/services/data/v59.0/sobjects/Distributor__c/a03D0000003DUhcIAG"
        },
        "Id" : "a03D0000003DUhcIAG",
        "OwnerId" : "005D0000001KyEIIA0",
        "IsDeleted" : false,
        "Name" : "Distributor1",
        "CreatedDate" : "2011-12-16T17:43:01.000+0000",
        "CreatedById" : "005D0000001KyEIIA0",
        "LastModifiedDate" : "2011-12-16T17:43:01.000+0000",
        "LastModifiedById" : "005D0000001KyEIIA0",
        "SystemModstamp" : "2011-12-16T17:43:01.000+0000",
        "Location__c" : "San Francisco"
    }
    ```

??? note "getRecordsUsingSObjectCollections"
    To retrieve one or more records of the same object type using sObject collections, use salesforcerest.getRecordsUsingSObjectCollections and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_sobjects_collections_retrieve.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/composite/sobjects/{sObjectName}?ids={ids}&fields={fields}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will create a record.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>ids</td>
    <td>A list of one or more IDs of the objects to return. All IDs must belong to the same object type.</td>
    <td>Yes</td>
    <td>001xx000003DGb1AAG,001xx000003DGb0AAG,001xx000003DGb9AAG</td>
    </tr>
    <tr>
    <td>fields</td>
    <td>A list of fields to include in the response. The field names you specify must be valid, and you must have read-level permissions to each field.</td>
    <td>Yes</td>
    <td>id,name</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getRecordsUsingSObjectCollections>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <ids>{$ctx:ids}</ids>
        <fields>{$ctx:fields}</fields>
    </salesforcerest.getRecordsUsingSObjectCollections>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "ids":"001xx000003DGb1AAG,001xx000003DGb0AAG,001xx000003DGb9AAG",
        "fields":"id,name"
    }
    ```

    **Sample Response**

    ```json
    [
        {
            "attributes" : {
                "type" : "Account",
                "url" : "/services/data/v59.0/sobjects/Account/001xx000003DGb1AAG"
            },
            "Id" : "001xx000003DGb1AAG",
            "Name" : "Acme"
        },
        {
            "attributes" : {
                "type" : "Account",
                "url" : "/services/data/v59.0/sobjects/Account/001xx000003DGb0AAG"
            },
            "Id" : "001xx000003DGb0AAG",
            "Name" : "Global Media"
        },
        null
    ]
    ```

??? note "getRecordsWithARequestBodyUsingSObjectCollections"
    To retrieve one or more records of the same object type using sObject collections with a request body, use salesforcerest.getRecordsWithARequestBodyUsingSObjectCollections and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_sobjects_collections_retrieve_post.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/composite/sobjects/{sObjectName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will retrieve the record.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The json format property with the new definition for the record.</td>
    <td>Yes</td>
    <td><pre>{
       "ids" : ["001xx000003DGb1AAG", "001xx000003DGb0AAG", "001xx000003DGb9AAG"],
       "fields" : ["id", "name"]
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getRecordsWithARequestBodyUsingSObjectCollections>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.getRecordsWithARequestBodyUsingSObjectCollections>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "fieldAndValue": {
            "ids" : ["001xx000003DGb1AAG", "001xx000003DGb0AAG", "001xx000003DGb9AAG"],
            "fields" : ["id", "name"]
        },
    }
    ```

    **Sample Response**

    ```json
    [
        {
            "attributes" : {
                "type" : "Account",
                "url" : "/services/data/v59.0/sobjects/Account/001xx000003DGb1AAG"
            },
            "Id" : "001xx000003DGb1AAG",
            "Name" : "Acme"
        },
        {
            "attributes" : {
                "type" : "Account",
                "url" : "/services/data/v59.0/sobjects/Account/001xx000003DGb0AAG"
            },
            "Id" : "001xx000003DGb0AAG",
            "Name" : "Global Media"
        },
        null
    ]
    ```

??? note "getObjectRecordCounts"
    To list information about object record counts in your organization, use salesforcerest.getObjectRecordCounts and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_record_count.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/limits/recordCount?sObjects={sObjects}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjects</td>
    <td>A comma-delimited list of object names. If a listed object is not found in the org, it is ignored and not returned in the response.</td>
    <td>No</td>
    <td>Account,Contact</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getObjectRecordCounts>
        <sObjects>{$ctx:sObjects}</sObjects>
    </salesforcerest.getObjectRecordCounts>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjects":"Account,Contact"
    }
    ```

    **Sample Response**

    ```json
    {
        "sObjects" : [ {
            "count" : 3,
            "name" : "Account"
        }, {
            "count" : 10,
            "name" : "Contact"
        } ]
    }
    ```

??? note "update"
    To update a record, use salesforcerest.update and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_retrieve_patch.htm) for more information.

    Equivalent to Salesforce REST API `PATCH /services/data/vXX.X/sobjects/{sObjectName}/{Id}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will create a record.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>Id</td>
    <td>The ID of the record you are updating.</td>
    <td>Yes</td>
    <td>00128000002OOhD</td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The json format property with the new definition for the record.</td>
    <td>Yes</td>
    <td><pre>{
    "name": "wso2",
    "description":"This Account belongs to WSO2"
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.update>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <Id>{$ctx:Id}</Id>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.update>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "Id":"00128000002OOhD",
        "fieldAndValue": {
            "name": "wso2",
            "description":"This Account belongs to WSO2"
        }
    }
    ```

??? note "updateUsingRelationships"
    To updatea parent record based on the specified object, record ID, and relationship field name, use salesforcerest.updateUsingRelationships and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_relationships_patch.htm) for more information.
    
    Equivalent to Salesforce REST API `PATCH /services/data/vXX.X/sobjects/{sObjectName}/{id}/{relationshipFieldName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The type of object for which you will update the record.</td>
    <td>Yes</td>
    <td>Contact</td>
    </tr>
    <tr>
    <td>id</td>
    <td>The ID of the record you are updating.</td>
    <td>Yes</td>
    <td>003R0000005hDFYIA2</td>
    </tr>
    <tr>
    <td>relationshipFieldName</td>
    <td>The name of the field that contains the relationship.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The json format property with the new definition for the record.</td>
    <td>Yes</td>
    <td><pre>{
        "BillingCity" : "San Francisco"
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.updateUsingRelationships>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <id>{$ctx:Id}</id>
        <relationshipFieldName>{$ctx:relationshipFieldName}</relationshipFieldName>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.updateUsingRelationships>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Contact",
        "id":"003R0000005hDFYIA2",
        "relationshipFieldName": "Account",
        "fieldAndValue": {
            "BillingCity" : "San Francisco"
        }
    }
    ```

??? note "updateRecordsUsingSObjectCollections"
    To updatea records using sObject collections, use salesforcerest.updateRecordsUsingSObjectCollections and specify the following properties. This operation can update up to 200 records. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_sobjects_collections_update.htm) for more information.

    Equivalent to Salesforce REST API `PATCH /services/data/vXX.X/composite/sobjects/`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The json format property with the new definition for the record.</td>
    <td>Yes</td>
    <td><pre>{
       "allOrNone" : false,
       "records" : [{
          "attributes" : {"type" : "Account"},
          "id" : "001xx000003DGb2AAG",
          "NumberOfEmployees" : 27000
       },{
          "attributes" : {"type" : "Contact"},
          "id" : "003xx000004TmiQAAS",
          "Title" : "Lead Engineer"
       }]
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.updateRecordsUsingSObjectCollections>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.updateRecordsUsingSObjectCollections>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": {
            "allOrNone" : false,
            "records" : [{
                "attributes" : {"type" : "Account"},
                "id" : "001xx000003DGb2AAG",
                "NumberOfEmployees" : 27000
            },{
                "attributes" : {"type" : "Contact"},
                "id" : "003xx000004TmiQAAS",
                "Title" : "Lead Engineer"
            }]
        }
    }
    ```
    **Sample Response**

    ```json
    [
        {
            "id" : "001RM000003oCprYAE",
            "success" : true,
            "errors" : [ ]
        },
        {
            "id" : "003RM0000068og4YAA",
            "success" : true,
            "errors" : [ ]
        }
    ]
    ```

??? note "delete"
    To delete a record, use salesforcerest.delete and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_retrieve_delete.htm) for more information.
    
    Equivalent to Salesforce REST API `DELETE /services/data/vXX.X/sobjects/{sObjectName}/{idToDelete}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object type of the record.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>idToDelete</td>
    <td>The ID of the record you are deleting.</td>
    <td>Yes</td>
    <td>00128000002OOhD</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.delete>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <idToDelete>{$ctx:idToDelete}</idToDelete>
    </salesforcerest.delete>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "idToDelete":"00128000002OOhD",
    }
    ```

??? note "deleteUsingExternalId"
    To delete a record based on the value of the specified external ID field, use salesforcerest.deleteUsingExternalId and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_upsert_delete.htm) for more information.
    
    Equivalent to Salesforce REST API `DELETE /services/data/vXX.X/sobjects/{customObject}/{externalIdField}/{externalIdFieldValue}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>customObject</td>
    <td>The type of object for which you will create a record.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>externalIdField</td>
    <td>Specific object field to access the record.</td>
    <td>Yes</td>
    <td>sample__c</td>
    </tr>
    <tr>
    <td>externalIdFieldValue</td>
    <td>The value of the ExternalIdField.</td>
    <td>Yes</td>
    <td>15222</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.deleteUsingExternalId>
        <customObject>{$ctx:customObject}</customObject>
        <externalIdField>{$ctx:externalIdField}</externalIdField>
        <externalIdFieldValue>{$ctx:externalIdFieldValue}</externalIdFieldValue>
    </salesforcerest.deleteUsingExternalId>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "customObject": "Account",
        "externalIdField": "sample__c",
        "externalIdFieldValue": "15222"
    }
    ```

??? note "deleteUsingRelationships"
    To delete a parent record based on the specified object, record ID, and relationship field name, use salesforcerest.deleteUsingRelationships and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_relationships_delete.htm) for more information.
    
    Equivalent to Salesforce REST API `DELETE /services/data/vXX.X/sobjects/{sObjectName}/{id}/{relationshipFieldName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <td>sObjectName</td>
    <td>The type of object for which you will delete the record.</td>
    <td>Yes</td>
    <td>Contact</td>
    </tr>
    <tr>
    <td>id</td>
    <td>The ID of the record you are updating.</td>
    <td>Yes</td>
    <td>003R0000005hDFYIA2</td>
    </tr>
    <tr>
    <td>relationshipFieldName</td>
    <td>The name of the field that contains the relationship.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.deleteUsingRelationships>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <id>{$ctx:id}</id>
        <relationshipFieldName>{$ctx:relationshipFieldName}</relationshipFieldName>
    </salesforcerest.deleteUsingRelationships>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Contact",
        "id": "003R0000005hDFYIA2",
        "relationshipFieldName": "Account"
    }
    ```

??? note "deleteRecordsUsingSObjectCollections"
    To delete records using sObject collections, use salesforcerest.deleteRecordsUsingSObjectCollections and specify the following properties. Can delete up to 200 records. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_sobjects_collections_delete.htm) for more information.
    
    Equivalent to Salesforce REST API `DELETE /services/data/vXX.X/composite/sobjects?ids={ids}&allOrNone={allOrNone}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>ids</td>
    <td>A list of up to 200 IDs of objects to be deleted. The IDs can belong to different object types, including custom objects.</td>
    <td>Yes</td>
    <td>001xx000003DGb2AAG,003xx000004TmiQAAS</td>
    </tr>
    <tr>
    <td>allOrNone</td>
    <td>Indicates whether to roll back the entire request when the deletion of any object fails (true) or to continue with the independent deletion of other objects in the request. The default is false.</td>
    <td>No</td>
    <td>false</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.deleteRecordsUsingSObjectCollections>
        <ids>{$ctx:ids}</ids>
        <allOrNone>{$ctx:allOrNone}</allOrNone>
    </salesforcerest.deleteRecordsUsingSObjectCollections>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "ids": "001xx000003DGb2AAG,003xx000004TmiQAAS",
        "allOrNone": "false"
    }
    ```

    **Sample response**

    ```json
    [
        {
            "id" : "001RM000003oLrHYAU",
            "success" : true,
            "errors" : [ ]
        },
        {
            "id" : "001RM000003oLraYAE",
            "success" : true,
            "errors" : [ ]
        }
    ]

    ```

??? note "recentlyViewedItem"
    To retrieve the recently viewed items, use salesforcerest.recentlyViewedItem and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_recent_items.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/recent/?limit={limit}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>limit</td>
    <td>The maximum number of records to be returned.</td>
    <td>Yes</td>
    <td>2</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.recentlyViewedItem>
        <limit>{$ctx:limit}</limit>
    </salesforcerest.recentlyViewedItem>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "limit":"2",
    }
    ```

    **Sample Response**

    ```json
    { 
        "attributes" : 
        { 
            "type" : "Account", 
            "url" : "/services/data/v59.0/sobjects/Account/a06U000000CelH0IAJ" 
        }, 
        "Id" : "a06U000000CelH0IAJ", 
        "Name" : "Acme" 
    }, 
    { 
        "attributes" : 
        { 
            "type" : "Opportunity", 
            "url" : "/services/data/v59.0/sobjects/Opportunity/a06U000000CelGvIAJ" 
        }, 
        "Id" : "a06U000000CelGvIAJ", 
        "Name" : "Acme - 600 Widgets" 
    }
    ```

??? note "retrieveFieldValues"
    To retrieve specific field values for a specific sObject, use salesforcerest.retrieveFieldValues and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_get_field_values.htm) for more information.
    <table>
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/{rowId}?fields={fields}`
    
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object type whose metadata you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>rowId</td>
    <td>The ID of the record whose values you want to retrieve.</td>
    <td>Yes</td>
    <td>00128000005YjDnAAK</td>
    </tr>
    <tr>
    <td>fields</td>
    <td>A comma-separated list of fields whose values you want to retrieve.</td>
    <td>Yes</td>
    <td>AccountNumber,BillingPostalCode</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.retrieveFieldValues>
        <limit>{$ctx:limit}</limit>
    </salesforcerest.retrieveFieldValues>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
        "rowId":"00128000005YjDnAAK",
        "fields":"AccountNumber,BillingPostalCode",
    }
    ```

    **Sample Response**

    ```json
    {
        "AccountNumber" : "CD656092",
        "BillingPostalCode" : "27215",
    }
    ```

??? note "retrieveFieldValuesFromExternalObject"
    To retrieve specific field values from an External Object, use salesforcerest.retrieveFieldValuesFromExternalObject and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_get_field_values_external_object_hdv.htm) for more information.
    <table>
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{externalObject}/{salesforceId}?fields={externalFields}`
    
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>externalObject</td>
    <td>The External object of the organization.</td>
    <td>Yes</td>
    <td>Customer__x</td>
    </tr>
    <tr>
    <td>salesforceId</td>
    <td>The row Id of the object.</td>
    <td>Yes</td>
    <td>x01D0000000002RIAQ</td>
    </tr>
    <tr>
    <td>externalFields</td>
    <td>The comma separated field values.</td>
    <td>Yes</td>
    <td>Country__c,Country__a</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.retrieveFieldValuesFromExternalObject>
        <externalObject>{$ctx:externalObject}</externalObject>
        <salesforceId>{$ctx:salesforceId}</salesforceId>
        <externalFields>{$ctx:externalFields}</externalFields>
    </salesforcerest.retrieveFieldValuesFromExternalObject>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "externalObject": "Customer__x",
        "salesforceId":"x01D0000000002RIAQ",
        "externalFields":"Country__c,Country__a",
    }
    ```

    **Sample Response**

    ```json
    {
        "attributes" : {
            "type" : "Customer__x",
            "url" : "/services/data/v59.0/sobjects/Customer__x/x01D0000000002RIAQ"
        },
        "Country__c" : "Argentina",
        "Id" : "x01D0000000002RIAQ"
    }
    ```

??? note "retrieveStandardFieldValuesFromExternalObjectWithExternalId"
    To retrieve specific field values from an External Object, use salesforcerest.retrieveStandardFieldValuesFromExternalObjectWithExternalId and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_get_field_values_external_object.htm) for more information.
    <table>
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{externalObject}/{externalId}?fields={externalFields}`
    
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>externalObject</td>
    <td>The External object of the organization.</td>
    <td>Yes</td>
    <td>Customer__x</td>
    </tr>
    <tr>
    <td>externalId</td>
    <td>The row Id of the object.</td>
    <td>Yes</td>
    <td>CACTU</td>
    </tr>
    <tr>
    <td>externalFields</td>
    <td>The comma separated field values.</td>
    <td>Yes</td>
    <td>Country__c,Country__a</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.retrieveStandardFieldValuesFromExternalObjectWithExternalId>
        <externalObject>{$ctx:externalObject}</externalObject>
        <externalId>{$ctx:externalId}</externalId>
        <externalFields>{$ctx:externalFields}</externalFields>
    </salesforcerest.retrieveStandardFieldValuesFromExternalObjectWithExternalId>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "externalObject": "Customer__x",
        "externalId":"CACTU",
        "externalFields":"Country__c,Country__a",
    }
    ```

    **Sample Response**

    ```json
    {
        "attributes" : {
            "type" : "Customer__x",
            "url" : "/services/data/v59.0/sobjects/Customer__x/CACTU"
        },
        "Country__c" : "Argentina",
        "ExternalId" : "CACTU"
    }
    ```

??? note "upsert"
    To create or update (upsert) a record using an external ID, use salesforcerest.upsert and specify the following properties. This method is used to create records or update existing records based on the value of a specified external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_upsert.htm) for more information.
    ```
        * If the specified value does not exist, a new record is created.
        * If a record does exist with that value, the field values specified in the request body are updated.
    ```
    
    Equivalent to Salesforce REST API `PATCH /services/data/vXX.X/sobjects/{sObjectName}/{externalIDField}/{Id}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object type whose value you want to upsert.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>externalIDField</td>
    <td>The external Id Field of the subject.</td>
    <td>Yes</td>
    <td>sample__c</td>
    </tr>
    <tr>
    <td>Id</td>
    <td>The value of the customExtIdField.</td>
    <td>Yes</td>
    <td>15222</td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The json format property/payload used to create the record.</td>
    <td>Yes</td>
    <td>{
    "Name":"john"
    }
    </td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.upsert>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <externalIDField>{$ctx:externalIDField}</externalIDField>
        <Id>{$ctx:Id}</Id>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.upsert>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"00D280000017q6q!AQoAQMMZWoN9MQZcXLW475YYoIdJFUICTjbGh67jEfAeV7Q57Ac2Ov.0ZuM_2Zx6SnrOmwpml8Qf.XclstTQiXtCYSGRBcEv",
        "apiUrl":"https://(your_instance).salesforce.com",
        "clientId": "3MVG9ZL0ppGP5UrBrnsanGUZRgHqc8gTV4t_6tfuef8Zz4LhFPipmlooU6GBszpplbTzVXXWjqkGHubhRip1s",
        "refreshToken": "5Aep861TSESvWeug_ztpnAk6BGQxRdovMLhHso81iyYKO6hTm68KfebpK7UYtEzF0ku8JCz7CNto8b3YMRmZrhy",
        "clientSecret": "9104967092887676680",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",,
        "intervalTime" : "2400000",
        "externalIDField":"sample__c",
        "Id":"15222",
        "fieldAndValue":
        {
            "Name":"john"
        }
    }
    ```

    **Sample Response**

    ```json
    {
        "id" : "00190000001pPvHAAU",
        "errors" : [ ],
        "success" : true
    }
    ```

??? note "upsertRecordsUsingSObjectCollections"
    To either create or update (upsert) up to 200 records based on an external ID field using sObject collections, use salesforcerest.upsertRecordsUsingSObjectCollections and specify the following properties. This method is used to create records or update existing records based on the value of a specified external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_composite_sobjects_collections_upsert.htm) for more information.
    ```
        * If the specified value does not exist, a new record is created.
        * If a record does exist with that value, the field values specified in the request body are updated.
    ```
    
    Equivalent to Salesforce REST API `PATCH /services/data/vXX.X/composite/sobjects/{sObjectName}/{externalIdFieldName}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object type whose value you want to upsert.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>externalIdFieldName</td>
    <td>The name of the external id field.</td>
    <td>Yes</td>
    <td>MyExtId__c</td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The json format property/payload used to create the record.</td>
    <td>Yes</td>
    <td>{
        "allOrNone" : false,
        "records" : [{
            "attributes" : {"type" : "Account"},
            "Name" : "Company One",
            "MyExtId__c" : "AAA"
        }, {
            "attributes" : {"type" : "Account"},
            "Name" : "Company Two",
            "MyExtId__c" : "BBB"
        }]
    }
    </td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.upsertRecordsUsingSObjectCollections>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <externalIdFieldName>{$ctx:externalIdFieldName}</externalIdFieldName>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.upsertRecordsUsingSObjectCollections>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"00D280000017q6q!AQoAQMMZWoN9MQZcXLW475YYoIdJFUICTjbGh67jEfAeV7Q57Ac2Ov.0ZuM_2Zx6SnrOmwpml8Qf.XclstTQiXtCYSGRBcEv",
        "apiUrl":"https://(your_instance).salesforce.com",
        "clientId": "3MVG9ZL0ppGP5UrBrnsanGUZRgHqc8gTV4t_6tfuef8Zz4LhFPipmlooU6GBszpplbTzVXXWjqkGHubhRip1s",
        "refreshToken": "5Aep861TSESvWeug_ztpnAk6BGQxRdovMLhHso81iyYKO6hTm68KfebpK7UYtEzF0ku8JCz7CNto8b3YMRmZrhy",
        "clientSecret": "9104967092887676680",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "externalIdFieldName" : "MyExtId__c",
        "fieldAndValue":
        {
            "allOrNone" : false,
            "records" : [{
                "attributes" : {"type" : "Account"},
                "Name" : "Company One",
                "MyExtId__c" : "AAA"
            }, {
                "attributes" : {"type" : "Account"},
                "Name" : "Company Two",
                "MyExtId__c" : "BBB"
            }]
        }
    }
    ```

    **Sample Response**

    ```json
    [
        {
            "id": "001xx0000004GxDAAU",
            "success": true,
            "errors": [],
            "created": true
        },
        {
            "id": "001xx0000004GxEAAU",
            "success": true,
            "errors": [],
            "created": false
        }
    ]
    ```

??? note "getDeleted"
    To retrieve a list of individual records that have been deleted within the given timespan for the specified object,
    use salesforcerest.getDeleted. The date and time should be provided in ISO 8601 format:YYYY-MM-DDThh:mm:ss+hh:mm.
    See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_getdeleted.htm)
    for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/deleted/?start={startTime}&end={endTime}`
    
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
            <th>Sample Value</th>
        </tr>
        <tr>
            <td>sObjectName</td>
            <td>The object where you want to look for deleted records</td>
            <td>Yes</td>
            <td>Account</td>
        </tr>
        <tr>
            <td>startTime</td>
            <td>Starting date/time (Coordinated Universal Time (UTC)—not local—timezone) of the timespan for which to retrieve the data.</td>
            <td>Yes</td>
            <td>2015-10-05T12:30:30+05:30</td>
        </tr>
        <tr>
            <td>endTime</td>
            <td>Ending date/time (Coordinated Universal Time (UTC)—not local—timezone) of the timespan for which to retrieve the data.</td>
            <td>Yes</td>
            <td>2015-10-10T20:30:30+05:30</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getDeleted>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <startTime>{$ctx:startTime}</startTime>
        <endTime>{$ctx:endTime}</endTime>
    </salesforcerest.getDeleted>
    ```

    **Sample request**

    ```json
    {
      "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
      "apiUrl":"https://(your_instance).salesforce.com",
      "hostName": "https://login.salesforce.com",
      "apiVersion": "v59.0",
      "sObjectName":"Account",
      "startTime":"2015-10-05T12:30:30+05:30",
      "endTime":"2015-10-10T20:30:30+05:30"
    }
    ```

    **Sample Response**

    ```json
    {
       "earliestDateAvailable":"2018-09-20T07:52:00.000+0000",
       "deletedRecords":[
    
       ],
       "latestDateCovered":"2018-10-27T15:00:00.000+0000"
    }
    ```

??? note "getUpdated"
    To retrieve a list of individual records that have been updated within the given timespan for the specified object,
    use salesforcerest.getUpdated. The date and time should be provided in ISO 8601 format:YYYY-MM-DDThh:mm:ss+hh:mm.
    See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_getupdated.htm)
    for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/updated?start={startTime}&end={endTime}`
    
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
            <th>Sample Value</th>
        </tr>
        <tr>
            <td>sObjectName</td>
            <td>The object where you want to look for updated records</td>
            <td>Yes</td>
            <td>Account</td>
        </tr>
        <tr>
            <td>startTime</td>
            <td>Starting date/time (Coordinated Universal Time (UTC)—not local—timezone) of the timespan for which to retrieve the data.</td>
            <td>Yes</td>
            <td>2015-10-05T12:30:30+05:30</td>
        </tr>
        <tr>
            <td>endTime</td>
            <td>Ending date/time (Coordinated Universal Time (UTC)—not local—timezone) of the timespan for which to retrieve the data.</td>
            <td>Yes</td>
            <td>2015-10-10T20:30:30+05:30</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getUpdated>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <startTime>{$ctx:startTime}</startTime>
        <endTime>{$ctx:endTime}</endTime>
    </salesforcerest.getUpdated>
    ```

    **Sample request**

    ```json
    {
      "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
      "apiUrl":"https://(your_instance).salesforce.com",
      "hostName": "https://login.salesforce.com",
      "apiVersion": "v59.0",
      "sObjectName":"Account",
      "startTime":"2015-10-05T12:30:30+05:30",
      "endTime":"2015-10-10T20:30:30+05:30"
    }
    ```

    **Sample Response**

    ```json
    {
       "ids":[
    
       ],
       "latestDateCovered":"2018-10-27T15:00:00.000+0000"
    }
    ```
---

### Scheduling

??? note "listSchedulerRESTResourcesAndURIs"
    To retrieve a list of available Salesforce Scheduler REST resources and corresponding URIs, use salesforcerest.listSchedulerRESTResourcesAndURIs and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/requests_ls_scheduling.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/scheduling/`

    **Sample configuration**

    ```xml
    <salesforcerest.listSchedulerRESTResourcesAndURIs/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0"
    }
    ```

    **Sample response**

    ```json
    {
        "getAppointmentCandidates" : "/services/data/v59.0/scheduling/getAppointmentCandidates",
        "getAppointmentSlots" : "/services/data/v59.0/scheduling/getAppointmentSlots"
    }
    ```

??? note "listAppointmentCandidates"
    To retrieve a list of service resources (appointment candidates) based on work type group or work type and service territories, use salesforcerest.listAppointmentCandidates and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/requests_ls_getappointmentcandidates.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/scheduling/getAppointmentCandidates`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to list appointment candidates.</td>
    <td>Yes</td>
    <td><pre>{
      "startTime": "2019-01-23T00:00:00.000Z",
      "endTime": "2019-02-30T00:00:00.000Z",
      "workTypeGroupId": "0VSB0000000KyjBOAS",
      "accountId": "001B000000qAUAWIA4",
      "territoryIds": [
        "0HhB0000000TO9WKAW"
      ],
      "schedulingPolicyId": "0VrB0000000KyjB",
      "engagementChannelTypeIds": [
        "0eFRM00000000Bv2AI"
      ]
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.listAppointmentCandidates>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.listAppointmentCandidates>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": {
            "startTime": "2019-01-23T00:00:00.000Z",
            "endTime": "2019-02-30T00:00:00.000Z",
            "workTypeGroupId": "0VSB0000000KyjBOAS",
            "accountId": "001B000000qAUAWIA4",
            "territoryIds": [
                "0HhB0000000TO9WKAW"
            ],
            "schedulingPolicyId": "0VrB0000000KyjB",
            "engagementChannelTypeIds": [
                "0eFRM00000000Bv2AI"
            ]
        }
    }
    ```

    **Sample response**

    ```json
    {
        "candidates": [
            {
            "endTime": "2019-01-23T19:15:00.000+0000",
            "resources": [
                "0HnB0000000D2DsKAK"
            ],
            "startTime": "2019-01-23T16:15:00.000+0000",
            "territoryId": "0HhB0000000TO9WKAW",
            "engagementChannelTypeIds": [
                "0eFRM00000000Bv2AI"
            ]
            },
            {
            "endTime": "2019-01-23T19:30:00.000+0000",
            "resources": [
                "0HnB0000000D2DsKAK"
            ],
            "startTime": "2019-01-23T16:30:00.000+0000",
            "territoryId": "0HhB0000000TO9WKAW",
            "engagementChannelTypeIds": [
                "0eFRM00000000Bv2AI"
            ]
            }
        ]
    }
    ```

??? note "listAppointmentSlots"
    To retrieve a list of available appointment time slots for a resource based on given work type group or work type and service territories, use salesforcerest.listAppointmentSlots and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/requests_ls_getappointmentslots.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/scheduling/getAppointmentSlots`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to list appointment slots.</td>
    <td>Yes</td>
    <td><pre>{
      "startTime": "2019-01-23T00:00:00.000Z",
      "endTime": "2019-02-30T00:00:00.000Z",
      "workTypeGroupId": "0VSB0000000KyjBOAS",
      "accountId": "001B000000qAUAWIA4",
      "territoryIds": [
        "0HhB0000000TO9WKAW"
      ],
      "schedulingPolicyId": "0VrB0000000KyjB",
      "engagementChannelTypeIds": [
        "0eFRM00000000Bv2AI"
      ]
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.listAppointmentSlots>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.listAppointmentSlots>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": {
            "startTime": "2019-01-23T00:00:00.000Z",
            "endTime": "2019-02-30T00:00:00.000Z",
            "workTypeGroupId": "0VSB0000000KyjBOAS",
            "accountId": "001B000000qAUAWIA4",
            "territoryIds": [
                "0HhB0000000TO9WKAW"
            ],
            "schedulingPolicyId": "0VrB0000000KyjB",
            "engagementChannelTypeIds": [
                "0eFRM00000000Bv2AI"
            ]
        }
    }
    ```

    **Sample response**

    ```json
    {
        "timeSlots": [
            {
            "endTime": "2019-01-21T19:15:00.000+0000",
            "startTime": "2019-01-21T16:15:00.000+0000",
            "territoryId": "0HhB0000000TO9WKAW"
            },
            {
            "endTime": "2019-01-21T19:30:00.000+0000",
            "startTime": "2019-01-21T16:30:00.000+0000",
            "territoryId": "0HhB0000000TO9WKAW"
            },
            {
            "endTime": "2019-01-21T19:45:00.000+0000",
            "startTime": "2019-01-21T16:45:00.000+0000",
            "territoryId": "0HhB0000000TO9WKAW"
            }
        ]
    }
    ```

---

### sObjects

??? note "describeGlobal"
    To retrieve a list of the objects that are available in the system, use salesforcerest.describeGlobal. You can then get metadata for an object or objects as described in the next sections. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_describeGlobal.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/`
    
    **Sample configuration**

    ```xml
    <salesforcerest.describeGlobal/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample Response**

    ```json
    {
        "maxBatchSize":200,
        "sobjects":[
            {
                "updateable":false,
                "activateable":false,
                "deprecatedAndHidden":false,
                "layoutable":false,
                "custom":false,
                "deletable":false,
                "replicateable":false,
                "undeletable":false,
                "label":"Accepted Event Relation",
                "keyPrefix":null,
                "searchable":false,
                "queryable":true,
                "mergeable":false,
                "urls":{
                    "rowTemplate":"/services/data/v59.0/sobjects/AcceptedEventRelation/{ID}",
                    "describe":"/services/data/v59.0/sobjects/AcceptedEventRelation/describe",
                    "sobject":"/services/data/v59.0/sobjects/AcceptedEventRelation"
                },
                "createable":false,
                "feedEnabled":false,
                "retrieveable":true,
                "name":"AcceptedEventRelation",
                "customSetting":false,
                "labelPlural":"Accepted Event Relations",
                "triggerable":false
            },
            .
            .
        ],
        "encoding":"UTF-8"
    }
    ```

??? note "describeSObject"
    To get metadata (such as name, label, and fields, including the field properties) for a specific object type, use salesforcerest.describeSObject and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_describe.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/describe/`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object type whose metadata you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.describeSObject>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.describeSObject>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "updateable":true,
        "activateable":false,
        "childRelationships":[
            {
                "relationshipName":"ChildAccounts",
                "field":"ParentId",
                "deprecatedAndHidden":false,
                "childSObject":"Account",
                "cascadeDelete":false,
                "restrictedDelete":false
            },
            {
                "relationshipName":"AccountCleanInfos",
                "field":"AccountId",
                "deprecatedAndHidden":false,
                "childSObject":"AccountCleanInfo",
                "cascadeDelete":true,
                "restrictedDelete":false
            },
            .
        ]
    }
    ```

??? note "listAvailableApiVersion"
    To retrieve a list of summary information about each REST API version that is currently available, use salesforcerest.listAvailableApiVersion. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_versions.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/`

    **Sample configuration**

    ```xml
    <salesforcerest.listAvailableApiVersion/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample Response**

    ```json
    {
        "output":"[
        {\"label\":\"Winter '11\",\"url\":\"/services/data/v20.0\",\"version\":\"20.0\"},
        .
        .
        ]"
    }
    ```

??? note "listOrganizationLimits"
    To retrieve the limit information for your organization, use salesforcerest.listOrganizationLimits. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_limits.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/limits/`
    
    **Sample configuration**

    ```xml
    <salesforcerest.listOrganizationLimits/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample Response**

    ```json
    {
        "ActiveScratchOrgs": {
            "Max": 3,
            "Remaining": 3
        },
        "AnalyticsExternalDataSizeMB": {
            "Max": 40960,
            "Remaining": 40960
        },
        "ConcurrentAsyncGetReportInstances": {
            "Max": 200,
            "Remaining": 200
        },
            .
            .
    }
    ```

??? note "listResourcesByApiVersion"
    To retrieve the resources that are available in the specified API version, use salesforcerest.listResourcesByApiVersion. You can then get the details of those resources. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_discoveryresource.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/`

    **Sample configuration**

    ```xml
    <salesforcerest.listResourcesByApiVersion/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample Response**

    ```json
    {
        "tooling":"/services/data/v59.0/tooling",
        "folders":"/services/data/v59.0/folders",
        "eclair":"/services/data/v59.0/eclair",
        "prechatForms":"/services/data/v59.0/prechatForms",
        "chatter":"/services/data/v59.0/chatter",
        "tabs":"/services/data/v59.0/tabs",
        "appMenu":"/services/data/v59.0/appMenu",
        "quickActions":"/services/data/v59.0/quickActions",
        "queryAll":"/services/data/v59.0/queryAll",
        "commerce":"/services/data/v59.0/commerce",
        .
    }
    ```

??? note "sObjectBasicInfo"
    To retrieve the individual metadata for the specified object, use salesforcerest.sObjectBasicInfo. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_basic_info_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object type whose metadata you want to retrieve.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectBasicInfo>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.sObjectBasicInfo>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
    }
    ```

    **Sample Response**

    ```json
    {
        "objectDescribe":{
            "updateable":true,
            "activateable":false,
            "deprecatedAndHidden":false,
            "layoutable":true,
            "custom":false,
            "deletable":true,
            "replicateable":true,
            "undeletable":true,
            "label":"Account",
            "keyPrefix":"001",
            "searchable":true,
            "queryable":true,
            "mergeable":true,
            "urls":{
                "compactLayouts":"/services/data/v59.0/sobjects/Account/describe/compactLayouts",
                "rowTemplate":"/services/data/v59.0/sobjects/Account/{ID}"
            },
            "createable":true,
            "feedEnabled":true,
            "retrieveable":true,
            "name":"Account",
            "customSetting":false,
            "labelPlural":"Accounts",
            "triggerable":true
        },
        .
    }
    ```

??? note "sObjectPlatformAction"
    To retrieve the description of the PlatformAction, use salesforcerest.sObjectPlatformAction. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_platformaction.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/PlatformAction`

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectPlatformAction/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample Response**

    ```json
    {
        "objectDescribe":{
        "updateable":false,
        "activateable":false,
        "deprecatedAndHidden":false,
        "layoutable":false,
        "custom":false,
        "deletable":false,
        "replicateable":false,
        "undeletable":false,
        "label":"Platform Action",
        "keyPrefix":"0JV",
        "searchable":false,
        "queryable":true,
        "mergeable":false,
        "urls":{
            "rowTemplate":"/services/data/v59.0/sobjects/PlatformAction/{ID}",
            "describe":"/services/data/v59.0/sobjects/PlatformAction/describe",
            "sobject":"/services/data/v59.0/sobjects/PlatformAction"
        },
        "createable":false,
        "feedEnabled":false,
        "retrieveable":false,
        "name":"PlatformAction",
        "customSetting":false,
        "labelPlural":"Platform Actions",
        "triggerable":false
    },
    "recentItems":[

    ]
    }
    ```

??? note "sObjectRows"
    To retrieve details of a specific record, use salesforcerest.sObjectRows. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_retrieve_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{sObjectName}/{rowId}/`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The object type of the record.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>rowId</td>
    <td>The ID of the record whose details you want to retrieve.</td>
    <td>Yes</td>
    <td>00128000005YjDnAAK</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectRows>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
        <rowId>{$ctx:rowId}</rowId>
    </salesforcerest.sObjectRows>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName":"Account",
        "rowId":"00128000005YjDnAAK",
    }
    ```

    **Sample Response**

    ```json
    {
        "AccountNumber" : "CD656092",
        "BillingPostalCode" : "27215"
    }
    ```

??? note "sObjectRowsByExternalId"
    To retrieve records with a specific external ID, use salesforcerest.sObjectRowsByExternalId. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_upsert_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/{customObject}/{externalIdField}/{externalIdFieldValue}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>customObject</td>
    <td>The type of the custom object.</td>
    <td>Yes</td>
    <td>Merchandise__c</td>
    </tr>
    <tr>
    <td>externalIdField</td>
    <td>Specific object ID to access the record.</td>
    <td>Yes</td>
    <td>MerchandiseExtID__c</td>
    </tr>
    <tr>
    <td>externalIdFieldValue</td>
    <td>The value of the ExternalIdField.</td>
    <td>Yes</td>
    <td>123</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.sObjectRowsByExternalId>
        <customObject>{$ctx:customObject}</customObject>
        <externalIdField>{$ctx:externalIdField}</externalIdField>
        <externalIdFieldValue>{$ctx:externalIdFieldValue}</externalIdFieldValue>
    </salesforcerest.sObjectRowsByExternalId>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "customObject":"Merchandise__c",
        "externalIdField":"MerchandiseExtID__c",
        "externalIdFieldValue": "123"
    }
    ```

    **Sample Response**

    ```json
    { 
        "attributes" : {
            "type" : "Merchandise__c",
            "url" : "/services/data/v59.0/sobjects/Merchandise__c/a00D0000008oWP8IAM"
        },
        "Id" : "a00D0000008oWP8IAM",
        "OwnerId" : "005D0000001KyEIIA0",
        "IsDeleted" : false,
        "Name" : "Example Merchandise",
        "CreatedDate" : "2012-07-12T17:49:01.000+0000",
        "CreatedById" : "005D0000001KyEIIA0",
        "LastModifiedDate" : "2012-07-12T17:49:01.000+0000",
        "LastModifiedById" : "005D0000001KyEIIA0",
        "SystemModstamp" : "2012-07-12T17:49:01.000+0000",
        "Description__c" : "Merch with external ID",
        "Price__c" : 10.0,
        "Total_Inventory__c" : 100.0,
        "Distributor__c" : null,
        "MerchandiseExtID__c" : 123.0
    }
    ```

??? note "returnHeadersOfSObjectRowsByExternalId"
    To retrieve headers that are returned by sending a request to the sObjectRowsByExternalId operation, use salesforcerest.returnHeadersOfSObjectRowsByExternalId. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_upsert_get.htm) for more information.

    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/{customObject}/{externalIdField}/{externalIdFieldValue}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>customObject</td>
    <td>The type of the custom object.</td>
    <td>Yes</td>
    <td>Merchandise__c</td>
    </tr>
    <tr>
    <td>externalIdField</td>
    <td>Specific object ID to access the record.</td>
    <td>Yes</td>
    <td>MerchandiseExtID__c</td>
    </tr>
    <tr>
    <td>externalIdFieldValue</td>
    <td>The value of the ExternalIdField.</td>
    <td>Yes</td>
    <td>123</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersOfSObjectRowsByExternalId>
        <customObject>{$ctx:customObject}</customObject>
        <externalIdField>{$ctx:externalIdField}</externalIdField>
        <externalIdFieldValue>{$ctx:externalIdFieldValue}</externalIdFieldValue>
    </salesforcerest.returnHeadersOfSObjectRowsByExternalId>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "customObject":"Merchandise__c",
        "externalIdField":"MerchandiseExtID__c",
        "externalIdFieldValue": "123"
    }
    ```

??? note "viewRelevantItems"
    To retrieve the current user’s most relevant items that include up to 50 of the most recently viewed or updated records for each object in the user’s global search scope, use salesforcerest.viewRelevantItems. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_relevant_items.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/relevantItems?lastUpdatedId={lastUpdatedId}&sobjects={sobjects}&{nameOfLastUpdatedIdParamPerSObject}.lastUpdatedId={valueOfLastUpdatedIdParamPerSObject}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>lastUpdatedId</td>
    <td>The last updated Id. It compares the entire current list of relevant items to a previous version, if available.</td>
    <td>No</td>
    <td>102959935</td>
    </tr>
    <tr>
    <td>sobjects</td>
    <td>The name for one or more sObjects to scope the results to a particular object or set of objects.</td>
    <td>No</td>
    <td>Account,User</td>
    </tr>
    <tr>
    <td>nameOfLastUpdatedIdParamPerSObject</td>
    <td>The parameter name of the last updated id for a particular object in the format of sobject.lastUpdatedId. Ex: Account.lastUpdatedId.</td>
    <td>No</td>
    <td>Account</td>
    </tr>
    <tr>
    <td>valueOfLastUpdatedIdParamPerSObject</td>
    <td>The value of the last updated id for a particular object parameter.</td>
    <td>No</td>
    <td>102959935</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.viewRelevantItems>
        <lastUpdatedId>{$ctx:lastUpdatedId}</lastUpdatedId>
        <sobjects>{$ctx:sobjects}</sobjects>
        <nameOfLastUpdatedIdParamPerSObject>{$ctx:nameOfLastUpdatedIdParamPerSObject}</nameOfLastUpdatedIdParamPerSObject>
        <valueOfLastUpdatedIdParamPerSObject>{$ctx:valueOfLastUpdatedIdParamPerSObject}</valueOfLastUpdatedIdParamPerSObject>
    </salesforcerest.viewRelevantItems>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sobjects":"Account,User",
        "nameOfLastUpdatedIdParamPerSObject": "Account",
        "valueOfLastUpdatedIdParamPerSObject": "102959935"
    }
    ```
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/relevantItems?sobjects=Account,User&Account.lastUpdatedId=102959935`

    **Sample Response**

    ```json
    [ {
        "apiName" : "Account",
        "key" : "001",
        "label" : "Accounts",
        "lastUpdatedId" : "193640553",
        "recordIds" : [ "001xx000003DWsT" ]
    } ]
    ```
---

### Search

??? note "search"
    To search for records, use salesforcerest.search and specify the search string. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_search.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/search/?q={searchString}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>searchString</td>
    <td>The SQL query to use to search for records.</td>
    <td>Yes</td>
    <td>sample string</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.search>
        <searchString>{$ctx:searchString}</searchString>
    </salesforcerest.search>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "searchString": "FIND {map*} IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead",
    }
    ```

    **Sample Response**

    ```json
    {
        {"output":"[{\"attributes\":{\"type\":\"Account\",\"url\":\"/services/data/v59.0/sobjects/Account/00128000005dMcSAAU\"},\"Id\":\"00128000005dMcSAAU\",\"Name\":\"GenePoint\"}]"}
    }
    ```

??? note "searchScopeAndOrder"
    To retrieve the search scope and order for the currently logged-in user, use salesforcerest.searchScopeAndOrder. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_search_scope_order.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/search/scopeOrder`

    **Sample configuration**

    ```xml
    <salesforcerest.searchScopeAndOrder/>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
    }
    ```

    **Sample Response**

    ```json
    {
        "output":"[]"
    }
    ```

??? note "searchResultLayout"
    To retrieve the search result layouts for one or more sObjects, use salesforcerest.searchResultLayout and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_search_layouts.htm#topic-title) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/search/layout/?q={sObjectNameList}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>sObjectNameList</td>
    <td>A comma-delimited list of the objects whose search result layouts you want to retrieve.</td>
    <td>Yes</td>
    <td>Account,User</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.searchResultLayout>
        <sObjectNameList>{$ctx:sObjectNameList}</sObjectNameList>
    </salesforcerest.searchResultLayout>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectNameList": "Account,User",
    }
    ```

    **Sample Response**

    ```json
    {
        "output":"[{\"errorMsg\":null,\"label\":\"Search Results\",\"limitRows\":25,\"objectType\":\"Account\",\"searchColumns\":[{\"field\":\"Account.Name\",\"format\":null,\"label\":\"Account Name\",\"name\":\"Name\"},{\"field\":\"Account.Site\",\"format\":null,\"label\":\"Account Site\",\"name\":\"Site\"},.]"
    }
    ```

??? note "searchSuggestedRecords"
    To return a list of suggested records whose names match the user’s search string, use salesforcerest.searchSuggestedRecords and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.198.0.api_rest.meta/api_rest/resources_search_suggest_records.htm?search_text=search%20Suggested%20records) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/search/?q={searchString}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>stringForSearch</td>
    <td>The object type that the search is scoped to.</td>
    <td>Yes</td>
    <td>hari</td>
    </tr>
    <tr>
    <td>sObjectName</td>
    <td>The SOQL query to execute the search.</td>
    <td>Yes</td>
    <td>Account</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.searchSuggestedRecords>
        <stringForSearch>{$ctx:stringForSearch}</stringForSearch>
        <sObjectName>{$ctx:sObjectName}</sObjectName>
    </salesforcerest.searchSuggestedRecords>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "sObjectName": "Account",
        "stringForSearch": "hari",
    }
    ```

    **Sample Response**

    ```json
    {
        {"autoSuggestResults":[],"hasMoreResults":false}
    }
    ```
---

### Survey

??? note "addOrChangeTranslationOfSurveyField"
    To add or change the translated value of the survey field if a survey field can be translated or is already translated into a particular language, use salesforcerest.addOrChangeTranslationOfSurveyField and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/request_survey_translate_add_change.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/localizedvalue/record/{developerName}/{language}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>developerName</td>
    <td>The developer name of the flow field.</td>
    <td>Yes</td>
    <td>Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel</td>
    </tr>
    <tr>
    <td>language</td>
    <td>The translated language of the flow field.</td>
    <td>Yes</td>
    <td>zh_CN</td>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to add or change the translation of survey field.</td>
    <td>Yes</td>
    <td><pre>{
        "value": "China"
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.addOrChangeTranslationOfSurveyField>
        <developerName>{$ctx:developerName}</developerName>
        <language>{$ctx:language}</language>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.addOrChangeTranslationOfSurveyField>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "zh_CN",
        "fieldAndValue": {
            "value": "China"
        }
    }
    ```

    **Sample response**

    ```json
    {
        "createdBy": "005xxx",
        "createdDate": "2018-09-14T00:10:30Z",
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "zh_CN",
        "value": "中國",
        "isOutOfDate": true
    }
    ```

??? note "addOrUpdateTranslatedValueOfMultipleSurveyFieldsInOneOrMoreLanguages"
    If one or more survey fields can be translated or are already translated, to add or update the translated values of the survey fields in the languages into which survey fields can be translated, use salesforcerest.addOrUpdateTranslatedValueOfMultipleSurveyFieldsInOneOrMoreLanguages and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/request_survey_translate_add_change_multiple.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/localizedvalue/records/upsert`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to add or update the translated value of multiple survey fields in one or more languages.</td>
    <td>Yes</td>
    <td><pre>[
      {
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "en_US",
        "value": "China"
      },
      {
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "zh_CN",
        "value": "中國"
      }
    ]
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.addOrUpdateTranslatedValueOfMultipleSurveyFieldsInOneOrMoreLanguages>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.addOrUpdateTranslatedValueOfMultipleSurveyFieldsInOneOrMoreLanguages>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": [
            {
                "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
                "language": "en_US",
                "value": "China"
            },
            {
                "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
                "language": "zh_CN",
                "value": "中國"
            }
        ]
    }
    ```

    **Sample response**

    ```json
        {   
            "output":
                "[
                    {
                        \"createdBy\": \"005xxx\",
                        \"createdDate\": \"2018-09-14T00:10:30Z\",
                        \"developerName\": \"Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel\",
                        \"language\": \"en_US\",
                        \"value\": \"China\",
                        \"isOutOfDate\": false
                    },
                    ...
                ]"
        }
    ```

??? note "getTranslatedValueOfSurveyField"
    To retrieve the translated value of the survey field after a survey field is translated into a particular language, use salesforcerest.getTranslatedValueOfSurveyField and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/request_survey_translate_view.htm) for more information.
    
    Equivalent to Salesforce REST API `GET /services/data/vXX.X/localizedvalue/record/{developerName}/{language}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>developerName</td>
    <td>The developer name of the flow field.</td>
    <td>Yes</td>
    <td>Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel</td>
    </tr>
    <tr>
    <td>language</td>
    <td>Language of the translated field. Possible values are da, nl_NL, fi, fr, de.</td>
    <td>Yes</td>
    <td>zh_CN</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getTranslatedValueOfSurveyField>
        <developerName>{$ctx:developerName}</developerName>
        <language>{$ctx:language}</language>
    </salesforcerest.getTranslatedValueOfSurveyField>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "zh_CN"
    }
    ```

    **Sample response**

    ```json
    {
        "createdBy": "005xxx",
        "createdDate": "2018-09-14T00:10:30Z",
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "zh_CN",
        "value": "中國",
        "isOutOfDate": true
    }
    ```

??? note "getTranslatedValuesOfMultipleSurveyFieldsInOneOrMoreLanguages"
    To retrieve the translated values of multiple survey fields in the translated languages after survey fields are translated into one or more languages, use salesforcerest.getTranslatedValuesOfMultipleSurveyFieldsInOneOrMoreLanguages and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/request_survey_translate_view_multiple.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/localizedvalue/records/get`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to get the translated value of multiple survey fields in one or more languages.</td>
    <td>Yes</td>
    <td><pre>[
      {
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "en_US"
      },
      {
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "zh_CN"
      }
    ]
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getTranslatedValuesOfMultipleSurveyFieldsInOneOrMoreLanguages>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.getTranslatedValuesOfMultipleSurveyFieldsInOneOrMoreLanguages>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": [
            {
                "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
                "language": "en_US"
            },
            {
                "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
                "language": "zh_CN"
            }
        ]
    }
    ```

    **Sample response**

    ```json
        {   
            "output":
                "[
                    {
                        \"createdBy\": \"005xxx\",
                        \"createdDate\": \"2018-09-14T00:10:30Z\",
                        \"developerName\": \"Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel\",
                        \"language\": \"en_US\",
                        \"value\": \"China\",
                        \"isOutOfDate\": false
                    },
                    ...
                ]"
        }
    ```

??? note "deleteTheTranslatedValueOfSurveyField"
    To delete the translated value of the survey field after a survey field is translated into a particular language, use salesforcerest.deleteTheTranslatedValueOfSurveyField and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/request_survey_translate_delete.htm) for more information.
    
    Equivalent to Salesforce REST API `DELETE /services/data/vXX.X/localizedvalue/record/{developerName}/{language}`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>developerName</td>
    <td>The developer name of the flow field.</td>
    <td>Yes</td>
    <td>Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel</td>
    </tr>
    <tr>
    <td>language</td>
    <td>Language of the translated field. Possible values are da, nl_NL, fi, fr, de.</td>
    <td>Yes</td>
    <td>zh_CN</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.deleteTheTranslatedValueOfSurveyField>
        <developerName>{$ctx:developerName}</developerName>
        <language>{$ctx:language}</language>
    </salesforcerest.deleteTheTranslatedValueOfSurveyField>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "zh_CN"
    }
    ```


??? note "deleteTranslatedValueOfMultipleSurveyFieldsInOneOrMoreLanguages"
    To delete the translated values of multiple survey fields after survey fields are translated into one or more languages, use salesforcerest.deleteTranslatedValueOfMultipleSurveyFieldsInOneOrMoreLanguages and specify the following properties. This resource does not require the use of an external ID field. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/request_survey_translate_delete_multiple.htm) for more information.
    
    Equivalent to Salesforce REST API `POST /services/data/vXX.X/localizedvalue/records/delete`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to get the translated value of multiple survey fields in one or more languages.</td>
    <td>Yes</td>
    <td><pre>[
      {
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "en_US"
      },
      {
        "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
        "language": "zh_CN"
      }
    ]
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.deleteTranslatedValueOfMultipleSurveyFieldsInOneOrMoreLanguages>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.deleteTranslatedValueOfMultipleSurveyFieldsInOneOrMoreLanguages>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "fieldAndValue": [
            {
                "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
                "language": "en_US"
            },
            {
                "developerName": "Flow.Flow.MyFlow.1.Choice.Choice_1_Master.InputLabel",
                "language": "zh_CN"
            }
        ]
    }
    ```

---

### Users

??? note "getUserInformation"
    To retrieve information about a specific user, use salesforcerest.getUserInformation and specify the following property.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/User/{userId}`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>userId</td>
    <td>The ID of the user whose information you want to retrieve.</td>
    <td>Yes</td>
    <td>00528000000yl7j</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getUserInformation>
        <userId>{$ctx:userId}</userId>
    </salesforcerest.getUserInformation>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "userId": "00528000000yl7j",
    }
    ```

    **Sample Response**

    ```json
    {
        "ProfileId":"00e28000000xIEQAA2",
        "LastModifiedDate":"2016-11-29T05:40:45.000+0000",
        "Address":{
            "country":"LK",
            "city":null,
            "street":null,
            "latitude":null,
            "postalCode":null,
            "geocodeAccuracy":null,
            "state":null,
            "longitude":null
        },
        "LanguageLocaleKey":"en_US",
        "EmailPreferencesAutoBccStayInTouch":false
        .
        .
    }
    ```

??? note "getUserPasswordExpirationStatus"
    To retrieve information about a specific user, use salesforcerest.getUserPasswordExpirationStatus and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_user_password_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/User/{userId}/password`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>userId</td>
    <td>The ID of the user whose information you want to retrieve.</td>
    <td>Yes</td>
    <td>00528000000yl7j</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getUserPasswordExpirationStatus>
        <userId>{$ctx:userId}</userId>
    </salesforcerest.getUserPasswordExpirationStatus>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "userId": "00528000000yl7j",
    }
    ```

    **Sample Response**

    ```json
    {
        "isExpired" : false
    }
    ```

    Example error response if session has insufficient privileges

    ```json
    {
        "message" : "You do not have permission to view this record.",
        "errorCode" : "INSUFFICIENT_ACCESS"
    }
    ```

??? note "setPassword"
    To set new password for Salesforce account for a specific User, use salesforcerest.setPassword and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_user_password_post.htm) for more information.

    Equivalent to Salesforce REST API `POST /services/data/vXX.X/sobjects/User/{userId}/password`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>userId</td>
    <td>The ID of the user whose information you want to retrieve.</td>
    <td>Yes</td>
    <td>00528000000yl7j</td>
    </tr>
    </tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to submit, approve, or reject the approvals.</td>
    <td>Yes</td>
    <td><pre>{
        "NewPassword" : "myNewPassword1234"
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.setPassword>
        <userId>{$ctx:userId}</userId>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.setPassword>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "userId": "00528000000yl7j",
        "fieldAndValue": {
            "NewPassword" : "myNewPassword1234"
        }
    }
    ```

    **Sample Response**

    No response body on successful password change, HTTP status code 204 returned.

    Example error response if new password does not meet organization password requirements

    ```json
    {
        "message" : "Your password must have a mix of letters and numbers.",
        "errorCode" : "INVALID_NEW_PASSWORD"
    }   
    ```

??? note "resetPassword"
    To reset the password of a specific user, use salesforcerest.resetPassword and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_user_password_delete.htm) for more information.

    Equivalent to Salesforce REST API `DELETE /services/data/vXX.X/sobjects/User/{userId}/password`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>userId</td>
    <td>The ID of the user whose information you want to retrieve.</td>
    <td>Yes</td>
    <td>00528000000yl7j</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getUserInformation>
        <userId>{$ctx:userId}</userId>
    </salesforcerest.getUserInformation>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "userId": "00528000000yl7j",
    }
    ```

    **Sample Response**

    ```json
    {
       "NewPassword" : "myNewPassword1234"
    }
    ```

??? note "returnHeadersForUserPassword"
    To retrieve only the headers that are returned by sending a GET request to the sObject User Password resource, use salesforcerest.returnHeadersForUserPassword and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_user_password_head.htm) for more information.

    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/User/{userId}/password`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>userId</td>
    <td>The ID of the user whose information you want to retrieve.</td>
    <td>Yes</td>
    <td>00528000000yl7j</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForUserPassword>
        <userId>{$ctx:userId}</userId>
    </salesforcerest.returnHeadersForUserPassword>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "userId": "00528000000yl7j",
    }
    ```


??? note "getSelfServiceUserPasswordExpirationStatus"
    To retrieve a self-service user’s password expiration status based on the specified user ID, use salesforcerest.getSelfServiceUserPasswordExpirationStatus and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_self_service_user_password_get.htm) for more information.

    Equivalent to Salesforce REST API `GET /services/data/vXX.X/sobjects/SelfServiceUser/{selfServiceUserId}/password`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>selfServiceUserId</td>
    <td>The Id of the self-service user.</td>
    <td>Yes</td>
    <td>00528000000yl7j</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getSelfServiceUserPasswordExpirationStatus>
        <selfServiceUserId>{$ctx:selfServiceUserId}</selfServiceUserId>
    </salesforcerest.getSelfServiceUserPasswordExpirationStatus>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "selfServiceUserId": "00528000000yl7j",
    }
    ```

    **Sample Response**

    ```json
    {
        "isExpired" : false
    }
    ```

    Example error response if session has insufficient privileges

    ```json
    {
        "message" : "You do not have permission to view this record.",
        "errorCode" : "INSUFFICIENT_ACCESS"
    }
    ```

??? note "setSelfServiceUserPassword"
    To set a self-service user’s password based on the specified user ID, use salesforcerest.setSelfServiceUserPassword and specify the following property. The password provided in the request body replaces the user’s existing password. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_self_service_user_password_post.htm) for more information.

    Equivalent to Salesforce REST API `POST /services/data/vXX.X/sobjects/SelfServiceUser/{selfServiceUserId}/password`

    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>selfServiceUserId</td>
    <td>The ID of the self service user whose password needs to be set.</td>
    <td>Yes</td>
    <td>00528000000yl7j</td>
    </tr>
    </tr>
    <td>fieldAndValue</td>
    <td>The .json format property used to submit, approve, or reject the approvals.</td>
    <td>Yes</td>
    <td><pre>{
        "NewPassword" : "myNewPassword1234"
    }
    </pre></td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.setSelfServiceUserPassword>
        <selfServiceUserId>{$ctx:selfServiceUserId}</selfServiceUserId>
        <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    </salesforcerest.setSelfServiceUserPassword>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "selfServiceUserId": "00528000000yl7j",
        "fieldAndValue": {
            "NewPassword" : "myNewPassword1234"
        }
    }
    ```

    **Sample Response**

    No response body on successful password change, HTTP status code 204 returned.

    Example error response if new password does not meet organization password requirements

    ```json
    {
        "message" : "Your password must have a mix of letters and numbers.",
        "errorCode" : "INVALID_NEW_PASSWORD"
    }   
    ```

??? note "resetSelfServiceUserPassword"
    To reset password for Salesforce account for a specific self-service, use salesforcerest.resetSelfServiceUserPassword and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_self_service_user_password_delete.htm) for more information.
    
    Equivalent to Salesforce REST API `DELETE /services/data/vXX.X/sobjects/SelfServiceUser/{selfServiceUserId}/password`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>selfServiceUserId</td>
    <td>The ID of the self service user whose password needs to be reset.</td>
    <td>Yes</td>
    <td>00528000000yl7j</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.resetSelfServiceUserPassword>
        <selfServiceUserId>{$ctx:selfServiceUserId}</selfServiceUserId>
    </salesforcerest.resetSelfServiceUserPassword>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "selfServiceUserId": "00528000000yl7j",
    }
    ```

    **Sample Response**

    ```json
    {
       "NewPassword" : "myNewPassword1234"
    }
    ```

??? note "returnHeadersForSelfServiceUserPassword"
    To retrieve only the headers that are returned by sending a GET request to the sObject Self-Service User Password resource, use salesforcerest.returnHeadersForSelfServiceUserPassword"
    and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_sobject_self_service_user_password_head.htm) for more information.
    
    Equivalent to Salesforce REST API `HEAD /services/data/vXX.X/sobjects/SelfServiceUser/{selfServiceUserId}/password`
    
    <table>
    <tr>
    <th>Parameter Name</th>
    <th>Description</th>
    <th>Required</th>
    <th>Sample Value</th>
    </tr>
    <tr>
    <td>selfServiceUserId</td>
    <td>The Id of the self-service user.</td>
    <td>Yes</td>
    <td>00528000000yl7j</td>
    </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.returnHeadersForSelfServiceUserPassword>
        <selfServiceUserId>{$ctx:selfServiceUserId}</selfServiceUserId>
    </salesforcerest.returnHeadersForSelfServiceUserPassword>
    ```

    **Sample request**

    ```json
    {
        "accessToken":"XXXXXXXXXXXX (Replace with your access token)",
        "apiUrl":"https://(your_instance).salesforce.com",
        "hostName": "https://login.salesforce.com",
        "apiVersion": "v59.0",
        "selfServiceUserId": "00528000000yl7j",
    }
    ```

---

### Reports

??? note "getReport"
    To retrieve information about a report, use salesforcerest.getReport and specify the following property. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_analytics.meta/api_analytics/sforce_analytics_rest_api_getreportrundata.htm) for more information.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
            <th>Sample Value</th>
        </tr>
        <tr>
            <td>reportId</td>
            <td>The ID of the report that you want to retrieve.</td>
            <td>Yes</td>
            <td>00O8d000004MWaGEAW</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcerest.getReport>
        <reportId>{$ctx:reportId}</reportId>
    </salesforcerest.getReport>
    ```

    **Sample request**

    ```json
    {
        "reportId": "00O8d000004MWaGEAW",
    }
    ```

    **Sample Response**

    ```json
    {
    "attributes": {
        "describeUrl": "/services/data/v55.0/analytics/reports/00O8d000004MWaGEAW/describe",
        "instancesUrl": "/services/data/v55.0/analytics/reports/00O8d000004MWaGEAW/instances",
        "reportId": "00O8d000004MWaGEAW",
        "reportName": "SampleReport",
        "type": "Report"
    },
    "allData": true,
    "factMap": {
        "T!T": {
            "aggregates": [
                {
                    "label": "13",
                    "value": 13
                }
            ],
            "rows": [
                {
                    "dataCells": [
                        {
                            "label": "Customer - Direct",
                            "recordId": "0018d00000FgQblAAF",
                            "value": "Customer - Direct"
                        },
                        {
                            "label": "Warm",
                            "recordId": "0018d00000FgQblAAF",
                            "value": "Warm"
                        },
                        {
                            "label": "-",
                            "recordId": "0018d00000FgQblAAF",
                            "value": null
                        },
                        {
                            "label": "16/08/2022",
                            "value": "2022-08-15"
                        },
                        .
                        .
                        .
                    ]
                }
            ]
            }
        }
    }
    ```
