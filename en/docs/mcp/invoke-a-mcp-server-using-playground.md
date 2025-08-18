# Test a MCP Server Using the MCP Playground

WSO2 API Manager has an Integrated MCP Playground, which allows you to visualize the MCP Server schema and interact with MCP Server's tools.

Follow the instructions below to use the MCP Playground to test a MCP Server:

!!! prerequisite
    - You need to have an application subscribed to the MCP Server. For more information, see [Subscribe to a MCP Server]({{base_path}}/mcp/subscribe-to-a-mcp-server/).
    - Obtain an access token for the application. You can use the token endpoint to get a JWT token. For more information, see [Generate an Access Token]({{base_path}}/consume/invoke-apis/invoke-api-using-tools/invoke-an-api-using-the-integrated-api-console/#step-3-get-an-access-token).

The examples here use the `Petstore` MCP Server, which was created in [Create a MCP Server from an OpenAPI definition]({{base_path}}/mcp/create-from-openapi/).

1. Sign in to the WSO2 Developer Portal (`https://<hostname>:9443/devportal`).

2. Click **MCP Servers**, and click on the MCP Server that you need to invoke.

3. Click **Try Out** in MCP Server Overview tab and go to **Test** → **MCP Playground**

    [![MCP Playground Menu]({{base_path}}/assets/img/mcp/mcp-playground-menu.png)]({{base_path}}/assets/img/mcp/mcp-playground-menu.png)

    The MCP Playground UI to test the Petstore MCP Server appears.

4. Enter the copied access token in the **Token** field or click `Configuration` button on the MCP Playground and if a test key is not populated, click on **GET TEST KEY**.

    [![MCP PLayground Configuration Button]({{base_path}}/assets/img/mcp/mcp-playground-config-btn.png)]({{base_path}}/assets/img/mcp/mcp-playground-config-btn.png)
    
    [![Get Test Key for MCP Playground]({{base_path}}/assets/img/mcp/mcp-playground-get-test-key.png)]({{base_path}}/assets/img/mcp/mcp-playground-get-test-key.png)

5. Click on **Connect** to connect with your deployed MCP Server.

    [![Connect to MCP Server in Playground]({{base_path}}/assets/img/mcp/mcp-playground-connect.png)]({{base_path}}/assets/img/mcp/mcp-playground-connect.png)

    Once connected, you will see the available tools for the MCP Server. You can select and call individual tools by providing the parameters if necessary.

6. Expand a method and enter the values to test. Click on the execute button to invoke the tool.

    [![Execute tool in MCP Playground]({{base_path}}/assets/img/mcp/mcp-playground-devportal.png)]({{base_path}}/assets/img/mcp/mcp-playground-devportal.png)

Note the successful response for the tool invocation.

You have now successfully invoked a MCP Server tool using the MCP Playground.
