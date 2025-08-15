## Create an MCP Server by Proxying an Existing MCP Server

Use this path when you already run a standards-compliant **MCP Server** and want to expose it through **WSO2 API Manager** for governance and developer onboarding. APIM **does not generate tools** here; it **discovers** the upstream server’s tools and **proxies** MCP methods (e.g., `initialize`, `tools/list`, `tools/call`).

In the Publisher Portal, you will:

* Provide basic details (name, context, version) and the **upstream MCP endpoint**.
* Configure upstream and any APIM **policies** (auth, throttling, analytics).
* Publish to make the proxied MCP tools available to consumers via APIM.


1. **Go to the Publisher Portal**
   In the navigation, click **Proxy Existing MCP Server** → **Proxy an Existing MCP Server**.

2. **Provide the definition**

   * Select **MCP Server URL** and enter:
     `https://db720294-98fd-40f4-85a1-cc6a3b65bc9a-prod.e1-us-east-azure.choreoapis.dev/godzilla/mcp-everything-server/v1.0`

3. **Select tools to import**

   * Select the tools to expose through the MCP Server in APIM.
     Click **Next**.

   [![MCP Server Proxy Select Tools]({{base_path}}/assets/img/mcp/create-mcp-server-proxy-tools-selected.png){: style="width:90%"}]({{base_path}}/assets/img/mcp/create-mcp-server-proxy-tools-selected.png)

4. **Enter MCP Server details**
   Fill in the details below and click **Create**.
   !!! note
   The **Endpoint** must be the backend base URL your tools will call at runtime—not the OpenAPI document URL.

   | Field    | Sample value                                                               |
   | -------- | -------------------------------------------------------------------------- |
   | Name     | EverythingMCP                                                                   |
   | Context  | /everything                                                                  |
   | Version  | 1.0.0                                                                      |
   | Endpoint | `https://db720294-98fd-40f4-85a1-cc6a3b65bc9a-prod.e1-us-east-azure.choreoapis.dev/godzilla/mcp-everything-server/v1.0` |

   [![MCP Server Proxy Create]({{base_path}}/assets/img/mcp/create-mcp-server-proxy-create.png){: style="width:90%"}]({{base_path}}/assets/img/mcp/create-mcp-servers-proxy-create.png)


### Next Step → Update and Deploy Your MCP Server

Once the MCP Server is created, you may want to refine tool names and descriptions, test them in the MCP Playground, and deploy them to the desired Gateway.
For a complete walkthrough, see **[Updating Tools and Deploying the MCP Server](./update-and-deploy-mcp-server.md)**.
