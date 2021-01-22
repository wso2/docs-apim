# Sequences and Endpoints as Local Registry Entries
This sample demonstrates how sequences and endpoints can be fetched from a local registry.

## Synapse configurations

Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='Proxy Service'
<proxy name="MainProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <inSequence>
            <property name="direction" scope="default" type="STRING" value="incoming"/>
            <sequence key="stockquote"/>
        </inSequence>
        <outSequence>
            <send/>
        </outSequence>
        <faultSequence/>
    </target>
</proxy>
```

```xml tab='Sequence'
<sequence name="stockquote" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
    <!-- log the message using the custom log level. illustrates custom properties for log -->
    <log level="custom">
        <property name="Text" value="Sending quote request"/>
        <property expression="get-property('direction')" name="direction"/>
    </log>
    <!-- send message to real endpoint referenced by key "simple" endpoint definition -->
    <send>
        <endpoint key="simple"/>
    </send>
</sequence>
```

```xml tab='Endpoint'
<endpoint name="simple" xmlns="http://ws.apache.org/ns/synapse">
    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
</endpoint>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create sequence `stockquote` and endpoint `simple` as [local entries]({{base_path}}/integrate/develop/creating-artifacts/registry/creating-local-registry-entries) with the configurations given above.
4. Also, create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) `MainProxy` with the configuration given above.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the back-end service:

1. Download the [back-end service](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip).
2. Extract the downloaded zip file.
3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

Send a message to invoke the service and analyze the mediation log on the Micro Integrator's start-up console.

You will see that the sequence and the endpoint are fetched from the local entry and that the property named `direction` (which was set by the proxy service) is logged by the sequence.

`INFO {org.apache.synapse.mediators.builtin.LogMediator} - Text = Sending quote request, direction = incoming`
