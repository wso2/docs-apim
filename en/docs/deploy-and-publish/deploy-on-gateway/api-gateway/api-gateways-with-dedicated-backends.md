# API Gateways with Dedicated Backends

We can extend the [multiple gateway environments](../maintaining-separate-production-and-sandbox-gateways) feature by utilizing parameterized endpoint capabilities of WSO2 API Manager to have each gateway point to a different back-end endpoint. API Gateway is the actual runtime of the APIs that are developed and published from the API Publisher. WSO2 API Manager is capable of publishing APIs to different Gateways where API users connect to those API Gateways in order to do the actual API calls through the applications to which they are subscribed.

However, the API Publisher can only provide a single static endpoint for an API in the implementation. Therefore, the API call is directed to a single endpoint in whichever Gateway the API is deployed in, as depicted in the diagram below.

[![Single endpoint]({{base_path}}/assets/img/learn/single-endpoint.png)]({{base_path}}/assets/img/learn/single-endpoint.png)

However, in most situations, you would want to have each Gateway proxying to a dedicated backend API. To provide that capability, WSO2 API Manager provides the ability to specify parameterized endpoint URLs at the time of specifying the API endpoint URL. This URL is resolved at runtime with the details (host and port) specified at the startup of each Gateway. Each gateway then points to a dedicated backend API, as depicted in the digram below.

[![Dedicated endpoint]({{base_path}}/assets/img/learn/dedicated-endpoint.png)]({{base_path}}/assets/img/learn/dedicated-endpoint.png)
### Configuring Parameterized Endpoints

Follow the steps below to configure a parameterized endpoint as the API endpoint.

1.  Start the WSO2 API Manager server that includes the API Publisher component and create an API.
2.  Go to the **Endpoints** tab of the API and replace the host and port of the API endpoint with `{uri.var.host}` and `{uri.var.port} ` respectively, as shown below.

    [![Dedicated backend definition]({{base_path}}/assets/img/learn/dedicated-backend-def.png)]({{base_path}}/assets/img/learn/dedicated-backend-def.png)

3.  Save and [publish](../../design-api/publish-api/publish-an-api) the API.

4.  Navigate to the `<API-M_HOME>/repository/deployment/server/synapse-configs/sequences` directory of each Gateway and create the following sequence.

    ``` java
        <sequence xmlns="http://ws.apache.org/ns/synapse" name="WSO2AM--Ext--In">
                <property name="uri.var.host" expression="get-property('system','host')" />
                <property name="uri.var.port" expression="get-property('system','port')" />
        </sequence>
    ```

    !!! note
        Java system properties are used at the server start-up process of each Gateway to resolve the variables that are defined as properties in this sequence.

    !!! info
        Alternatively, you can resolve this host and port using a class mediator. To do that, follow the steps below as an alternative to step 4.

        1. Create a java class extending the AbstractMediator class of `org.synapse.core` as shown below and create the JAR file out of it.

        ```java
            import org.apache.synapse.MessageContext;
            import org.apache.synapse.mediators.AbstractMediator;
            public class EnvironmentResolver extends AbstractMediator {

                @Override
                public boolean mediate(MessageContext messageContext) {

                    String host = System.getProperty("environment.host");
                    String port = System.getProperty("environment.port");

                    messageContext.setProperty("uri.var.host", host);
                    messageContext.setProperty("uri.var.port", port);

                    return true;
                }

                @Override
                public boolean isContentAware(){
                        return false;
                }
            }
        ```
        2. Add the created JAR file into the `<API-M_HOME>/repository/components/lib` folder of each Gateway. You can download a sample JAR file [here](https://docs.wso2.com/download/attachments/80713829/env-resolver-1.0.0.jar?version=2&modificationDate=1512985782000&api=v2).<br/><br/>
        3. Add the following sequence to the `<API-M_HOME>/repository/deployment/server/synapse-configs/sequences` folder of each Gateway.

        ``` java
            <sequence xmlns="http://ws.apache.org/ns/synapse" name="WSO2AM--Ext--In">
                    <class name="org.wso2.carbon.env.EnvironmentResolver"/>
            </sequence>
        ```

        !!! note
            `org.wso2.carbon.env.EnvironmentResolver` is the fully qualified name of the class that contains the code responsible for converting system variables into properties. It is a special class that needs to be extended from the `org.apache.synapse.mediators.AbstractMediator` class and requires overriding of the `mediate` function.


5.  Execute the following command when starting up each Gateway to set the system variables at the server start up from within the `<API-M_HOME>/bin` directory by replacing the following values.

    | **&lt;ip\_of\_backend\_environment&gt;** | **&lt;port\_of\_backend\_environment&gt;**                       |
    |------------------------------------------|------------------------------------------------------------------|
    | host IP of the Gateway                   | port where the Gateway is running in the dedicated machine or VM |

    ```java
    ./api-manager.sh -Dhost=<ip_of_backend_environment> -Dport=<port_of_backend_environment>
    ```

    !!! note
        If you have used the class mediator to configure API Gateways in step 4, use the command given below instead of the one above.
        ```java
        ./api-manager.sh -Denvironment.host=<ip_of_backend_environment> -Denvironment.port=<port_of_backend_environment>
        ```
    Now the Gateways have started with the dedicated backend host/port combinations.

6.  Invoke the API.

You receive the response from the API, which is sent through the dedicated backend, from the Gateway that this API is published.
