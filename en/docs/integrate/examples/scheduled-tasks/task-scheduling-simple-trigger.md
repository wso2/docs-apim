# Task Scheduling using a Simple Trigger
This example demonstrates the concept of tasks and how a simple trigger works. Here the `MessageInjector` class is used, which injects a specified message to the Micro Integrator environment. You can write your own task class implementing the `org.apache.synapse.startup.Task` interface and implement the `execute` method to run the task.

If the task should send the message directly to the endpoint through the main sequence, the endpoint address should be specified. For example, if the address of the endpoint is `http://localhost:9000/services/SimpleStockQuoteService`, the Synapse configuration of the scheduled task will be as shown below.

## Synapse configurations

Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='Scheduled Task'
<?xml version="1.0" encoding="UTF-8"?>
<task class="org.apache.synapse.startup.tasks.MessageInjector" group="synapse.simple.quartz" name="CheckPrice" xmlns="http://ws.apache.org/ns/synapse">
    <trigger interval="5"/>
    <property name="soapAction" value="urn:getQuote" xmlns:task="http://www.wso2.org/products/wso2commons/tasks"/>
    <property name="to" value="http://localhost:9000/services/SimpleStockQuoteService" xmlns:task="http://www.wso2.org/products/wso2commons/tasks"/>
    <property name="format" value="soap11" xmlns:task="http://www.wso2.org/products/wso2commons/tasks"/>
    <property name="message" xmlns:task="http://www.wso2.org/products/wso2commons/tasks">
        <m0:getQuote xmlns:m0="http://services.samples">
            <m0:request>
                <m0:symbol>IBM</m0:symbol>
            </m0:request>
        </m0:getQuote>
    </property>
</task>
```

```xml tab='Main Sequence'
<?xml version="1.0" encoding="UTF-8"?>
<sequence name="main" xmlns="http://ws.apache.org/ns/synapse">
    <in>
            <send/>
        </in>
        <out>
            <log level="custom">
                <property name="First_Value" expression="//ns:getQuoteResponse/ax21:open/child::text()"
                          xmlns:ax21="http://services.samples/xsd" xmlns:ns="http://services.samples"/>
                <property name="For_the_organization" expression="//ns:getQuoteResponse/ax21:name/child::text()"
                          xmlns:ax21="http://services.samples/xsd" xmlns:ns="http://services.samples"/>
                <property name="Last_Value" expression="//ns:getQuoteResponse/ax21:last/child::text()"
                          xmlns:ax21="http://services.samples/xsd" xmlns:ns="http://services.samples"/>
            </log>
            <drop/>
        </out>
</sequence>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [main sequence]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) and a [scheduled task]({{base_path}}/integrate/develop/creating-artifacts/creating-scheduled-task) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

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

When the Micro Integrator is invoked, you will see that the back-end service generates a quote every 5 seconds and that the Micro Integrator receives the stock quote response.
