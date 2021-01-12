# Changing the Host Name and Context Path of Web UI Applications

When you start any web application of the WSO2 Streaming Integrator (i.e., [Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview), the [Template Editor]({{base_path}}/use-cases/streaming-tutorials/creating-business-rules-templates/#creating-a-business-rules-template), [Business Rules]({{base_path}}/use-cases/streaming-tutorials/creating-business-rules-templates), or Policies) the URL to access its user interface is displayed in the start up logs as follows.

```text
INFO {org.wso2.carbon.siddhi.editor.core.internal.StartupComponent} - Editor Started on : http://<IP_ADDRESS>:<PORT>/<WEB_UI_APPLICATION_NAME>
```
e.g., The URL to access the Streaming Integrator Tooling is logged as follows:

```text
INFO {org.wso2.carbon.siddhi.editor.core.internal.StartupComponent} - Editor Started on : http://<IP_ADDRESS>:9390/editor
```

You can change this URL to display a host name instead of the IP address. You can also change it to display a different name for the web UI application (in the given example, a name different to `editor`). To do the required configurations to make this change, see the topics below.

## Changing the IP address to a host name
 
To change the IP address displayed in the URL to a host name:

1. Open the `<SI_TOOLING_HOME>/CONF/server/deployment.yaml` file.

2. In the `wso2.transport.http:` → `listenerConfigurations:` section, change the value for the `host parameter` to the required hostname (e.g., to `streaming-integrator`) as shown below.

    !!! info
        Note that in this example, you are specifying a host name for the `http` URLs. If the web UI application you are accessing has an `https` URL, you need to make this change for the listener configuration with the `https` scheme.

    ```yaml
         wso2.transport.http:
           transportProperties:
         
           listenerConfigurations:
             -
               id: "default"
               host: "streaming-integrator"
               port: 9387
    ```
   
Once you change the host to `streaming-integrator` as shown in the above example, the `http` URLs to access the Streaming Integrator Tooling and the Template Editor display `streaming-integrator` as the host name.

e.g., the URL to access the Streaming Integrator Tooling is displayed as follows:

```text
    INFO {org.wso2.carbon.siddhi.editor.core.internal.StartupComponent} - Editor Started on : http://streaming-integrator:9390/editor
```

## Changing the web UI application name

To change the name of the web UI application that appears in its URL, add a section as follows in the `<SI_TOOLING_HOME>/CONF/server/deployment.yaml` file.

```yaml
wso2.carbon-ui-server:
apps:
 # configurations for the Editor app "editor": 
    contextPath: "/tooling"
```
Here, the context path for the editor webUI application (i.e., the Streaming Integrator Studio) is specified as `tooling`. Therefore, when you start the Streaming Integrator Tooling server, the URL  for the Streaming Integrator Tooling appears as follows.

```text
INFO {org.wso2.carbon.siddhi.editor.core.internal.StartupComponent} - Editor Started on : http://<IP_ADDRESS>:9390/tooling
```