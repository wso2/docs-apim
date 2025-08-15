# Subscribe to a MCP Server

You have to **subscribe** to a published MCP Server before using its tools in your applications. The subscription process fulfills the authentication process and provides you with access tokens that you can use to invoke a MCP Server's tools. 

The examples here use the `Petstore` MCP Server, which is created and published to the Developer Portal in WSO2 API Manager.

## Subscribe to an existing application

If you already have an existing application, follow the instructions below to subscribe to the MCP Server using that application.

1.  Sign in to the Developer Portal (`https://<hostname>:<port>/devportal`) and click on the MCP Server (e.g., `Petstore`) to go to the MCP Server overview.

     [![MCP Server overview]({{base_path}}/assets/img/mcp/mcp-server-overview.png)]({{base_path}}/assets/img/mcp/mcp-server-overview.png)
        
2.  Click **SUBSCRIBE TO AN APPLICATION**.

     <a href="{{base_path}}/assets/img/learn/from-existing-app.png" ><img src="{{base_path}}/assets/img/learn/from-existing-app.png" alt="Subscribe to new app" title="Subscribe to new app" /></a>
    
3.  Select the application, the throttling policy, and click **Subscribe**.

     [![Subscribe to new application]({{base_path}}/assets/img/learn/subscribe-to-app.png)]({{base_path}}/assets/img/learn/subscribe-to-app.png)
    
     You can see the subscriptions list in the **Subscriptions** section.
     
     [![Subscribe to new app]({{base_path}}/assets/img/learn/subscription-list.png)]({{base_path}}/assets/img/learn/subscription-list.png)


If you do not have an existing application, you can create one and then subscribe to the MCP Server. For detailed steps, refer to [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/), as the process is similar.
