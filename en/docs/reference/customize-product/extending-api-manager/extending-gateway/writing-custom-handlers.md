# Writing Custom Handlers

This section introduces handlers and using an example, explains how to write a custom handler:

## Introducing Handlers

When an API is created, a file with its synapse configuration is added to the API Gateway. You can find it in the 
`<APIM_HOME>/repository/deployment/server/synapse-configs/default/api` folder. It has a set of handlers, each of which 
is executed on the APIs in the same order they appear in the configuration. You find the default handlers in any API's 
Synapse definition as shown below.

``` xml
<handlers>
    <handler class="org.wso2.carbon.apimgt.gateway.handlers.security.CORSRequestHandler">
        <property name="apiImplementationType" value="ENDPOINT"/>
    </handler>
    <handler class="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler"/>
    <handler class="org.wso2.carbon.apimgt.gateway.handlers.throttling.APIThrottleHandler">
        <property name="id" value="A"/>
        <property name="policyKeyResource" value="gov:/apimgt/applicationdata/res-tiers.xml"/>
        <property name="policyKey" value="gov:/apimgt/applicationdata/tiers.xml"/>
        <property name="policyKeyApplication" value="gov:/apimgt/applicationdata/app-tiers.xml"/>
    </handler>
    <handler class="org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageHandler"/>
    <handler class="org.wso2.carbon.apimgt.usage.publisher.APIMgtGoogleAnalyticsTrackingHandler">
        <property name="configKey" value="gov:/apimgt/statistics/ga-config.xml"/>
    </handler>
    <handler class="org.wso2.carbon.apimgt.gateway.handlers.ext.APIManagerExtensionHandler"/>
</handlers>
```

Let's see what each handler does:

 - **CORSRequestHandler:** Sets the CORS headers to the request and executes the CORS sequence mediation logic. This 
 handler is thereby responsible for returning the CORS headers from the gateway or routing the requests to the backend 
 and letting the backend send the CORS headers.
 - **APIAuthenticationHandler:** Validates the OAuth2 bearer token used to invoke the API. It also determines whether 
 the token is of type `Production` or `Sandbox` and sets `MessageContext` variables as appropriate.
 - **APIThrottleHandler:** Throttles requests based on the throttling policy specified by the `policyKey` property. 
 Throttling is applied both at the application level as well as subscription level.
 - **APIMgtUsageHandler:** Publishes events to WSO2 Stream Processor (WSO2 SP) for collection and analysis of statistics. 
 This handler only comes to effect if API usage tracking is enabled . 
 See the [Overview of API Analytics](../../../analytics/overview-of-api-analytics) 
 section for more information.
 - **APIMgtGoogleAnalyticsTrackingHandler:** Publishes events to Google Analytics. This handler only comes into effect 
 if Google analytics tracking is enabled. See Integrating with Google Analytics for more information.
 - **APIManagerExtensionHandler** : Triggers extension sequences. By default, the extension handler is listed at last 
 in the handler chain, and therefore is executed last. You cannot change the order in which the handlers are executed, 
 except the extension handler. To configure the API Gateway to execute extension handler first, log in to management console
 (<https://localhost:9443/carbon>) and in the main tab, expand the resources section and browse for 
 `_system/config/apimgt/applicationdata/tenant-conf.json`. Edit the field `ExtensionHandlerPosition` and provide 
 the value `top` . This is useful when you want to execute your own extensions before our default handlers in 
 situations like doing additional security checks such as signature verification on access tokens before executing the 
 default security handler.
    See [Adding Mediation Extensions](../../../extensions/adding-mediation-extensions).

### Using APILogMessageHandler

Message logging is handled by `APIManagerExtensionHandler.` `APILogMessageHandler` is a sample handler that comes with 
WSO2 API Manager that can be used for logging.

<div class="admonition info">
    <p class="admonition-title">Info</p>
    <p><b>Why are logs removed from <code>APIManagerExtensionHandler</code>?</b></p>
    <p>
        The primary purpose of <code>ExtensionHandler</code> is handling extensions to mediation and not for 
        logging messages. When the logs are also included in <code>ExtensionHandler</code> , there's a limitation to 
        improve the <code>ExtensionHandler</code> for developing features because it breaks the logs.
    </p>
    <p>
        For example, When the <code>ExtensionHandler</code> moves to the top of the handlers set, most of the logs print 
        null values since the handler runs before the <code>APIAuthenticationHandler</code>. Therefore, the logs are 
        removed from the extension handler and <code>APILogMessageHandler</code> introduced as a sample.
    </p>
</div>

<div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>
        To achieve logging requirements, this handler is not the only approach and with custom sequences also it is 
        possible to log messages using the Log Mediator.
    </p>
</div>

In order to enable logging by invoking `APILogMessageHandler` , follow the steps below.

**To enable Message Logging per API :**

1.  Open the synapse configuration of the API located in `<APIM_HOME>/repository/deployment/server/synapse-configs/default/api` 
directory and add below handler before `</Handlers>` .

    ``` java
    <handler class="org.wso2.carbon.apimgt.gateway.handlers.logging.APILogMessageHandler"/> 
    ```

2.  Copy the following code into the `<APIM_HOME>/repository/conf/log4j2.properties` file to enable printing DEBUG logs.

    ``` java
    logger.log-msg-handler.name = org.wso2.carbon.apimgt.gateway.handlers.logging.APILogMessageHandler
    logger.log-msg-handler.name = DEBUG
    ```
    Append the `log-msg-handler` logger name to `loggers` configuration which is a comma separated list of all active loggers. Sample configuration can be seen below.

    ```
    loggers = log-msg-handler, trace-messages, org-apache-coyote,com-hazelcast
    ```

    !!! note
        The logger name `log-msg-handler` can be replaced by any logger-name.

**To enable Message Logging into APIS created from publisher automatically :**

1.  Open the `<APIM_HOME>/repository/resources/api_templates/velocity_template.xml` file and copy the following handler 
before `</Handlers>`.

    ``` java
    <handler class="org.wso2.carbon.apimgt.gateway.handlers.logging.APILogMessageHandler"/> 
    ```

2.  Restart API Manager.

!!! note
    To perform analytics with the logs, see 
    [Analyzing the Log Overview](../../../analytics/analyzing-the-log-overview) .


## Writing a custom handler

!!! note
    The outcome of using a Class Mediator vs. a Synapse Handler are very similar. However, when using a custom handler 
    you need to maintain a customized velocity template file that needs to be manually merged when you upgrade your 
    product to a newer version. Therefore, it is recommended to use custom Handlers when you wish to specify the exact 
    order of execution of JARs as this can not be done with 
    [Mediators](../../../extensions/adding-mediation-extensions) .


Custom Handler is a way of extending API Manager which the product offer to change the API flow through the API Gateway. 
What is happening in custom handler can be decided by the code you are writing to extend the product. It can be adding 
extra security, logging database invocation or something else. This custom handler must extend the 
`org.apache.synapse.rest.AbstractHandler` class and implement `handleRequest()` and `handleResponse()` methods.

Let's see how you can write a custom handler and apply it to the API Manager. In this example, we extend the 
authentication handler. Make sure your custom handler name is not the same as the name of an existing handler.

WSO2 API Manager provides the OAuth2 bearer token as its default authentication mechanism. A sample implementation 
is <a href="{{base_path}}/assets/attachments/learn/APIAuthenticationHandler.java" download>here</a>. Similarly, you can extend the API Manager to 
support any custom authentication mechanism by writing your own authentication handler class.

Given below is an example implementation. Please find the complete project archive 
[org.wso2.carbon.test.authenticator.zip](https://docs.wso2.com/download/attachments/57743326/org.wso2.carbon.test.authenticator.zip?version=1&modificationDate=1516171792000&api=v2) . 
You can download, unzip and build the project using maven and Java 7 or 8.

``` java
package org.wso2.carbon.test;
import org.apache.synapse.MessageContext;
import org.apache.synapse.core.axis2.Axis2MessageContext;
import org.apache.synapse.rest.AbstractHandler;

import java.util.Map;

public class CustomAPIAuthenticationHandler extends AbstractHandler {

    public boolean handleRequest(MessageContext messageContext) {
        try {
            if (authenticate(messageContext)) {
                return true;
            }
        } catch (APISecurityException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean handleResponse(MessageContext messageContext) {
        return true;  
    }

    public boolean authenticate(MessageContext synCtx) throws APISecurityException {
        Map headers = getTransportHeaders(synCtx);
        String authHeader = getAuthorizationHeader(headers);
        if (authHeader.startsWith("userName")) {
            return true;
        }
        return false;
    }

    private String getAuthorizationHeader(Map headers) {
        return (String) headers.get("Authorization");
    }

    private Map getTransportHeaders(MessageContext messageContext) {
        return (Map) ((Axis2MessageContext) messageContext).getAxis2MessageContext().
        getProperty(org.apache.axis2.context.MessageContext.TRANSPORT_HEADERS);
    }
}
```
Make sure to update the pom file for the above project you created(or downloaded) with below dependency.

```
  <dependencies>
        <dependency>
            <groupId>org.apache.synapse</groupId>
            <artifactId>synapse-core</artifactId>
            <version>2.1.7-wso2v183</version>
        </dependency>
        <dependency>
            <groupId>org.apache.synapse</groupId>
            <artifactId>synapse-commons</artifactId>
            <version>2.1.7-wso2v183</version>
        </dependency>
        <dependency>
            <groupId>org.wso2.carbon.apimgt</groupId>
            <artifactId>org.wso2.carbon.apimgt.gateway</artifactId>
            <version>6.7.206</version>
        </dependency>
    </dependencies>
```
## Engaging the custom handler

1.  Build the custom authenticaor code created/downloaded previously, and copy the resulting jar to 
`<APIM_HOME>/repository/components/lib` directory.

    !!! note
        If the jar you created is non-OSGI, you should place the jar in the  `<APIM_HOME>/repository/components/lib` directory. <br>
        If the jar you created is OSGI, then you should place the jar in the `<APIM_HOME>/repository/components/dropins` driectory.

2.  Engage the custom handler using the API template as explained below:
    You can engage a custom handler to all APIs at once or only to selected APIs. To engage a custom handler to APIs, 
    you need to add the custom handler with its logic in the `<APIM_HOME>/repository/resources/api_templates/velocity_template.xml` 
    file.

    <div class="admonition note">
        <p class="admonition-title">Note</p>
        <p>
            A quicker way to engage the handler for the **purpose of trying it out** is to add the handler to the relevant API artifact file resides in `<APIM_HOME>/repository/deployment/server/synapse-configs/default/api` directory using the following segment.
        </p>
        <p>
            ```
            <handler class="org.wso2.carbon.apimgt.custom.authentication.handler.CustomAPIAuthenticationHandler" />

            ```
        </p>
        <p>
            However, it is not recommended to update the API source code via the source view UI or file system when engaging a 
            custom handler to selected APIs, because the customizations get overridden by the publisher updates.
        </p>
    </div>

    For example, the following code segment adds the custom authentication handler that you wrote earlier to the 
    `velocity_template.xml` file while making sure that it skips the default `APIAuthenticationHandler` implementation:

    ``` java
    <handlers xmlns="http://ws.apache.org/ns/synapse">
    <handler class="org.wso2.carbon.apimgt.custom.authentication.handler.CustomAPIAuthenticationHandler" />
        #foreach($handler in $handlers)
            #if(!($handler.className == "org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler"))
                <handler xmlns="http://ws.apache.org/ns/synapse" class="$handler.className">
                    #if($handler.hasProperties())
                        #set ($map = $handler.getProperties() )
                        #foreach($property in $map.entrySet())
                            <property name="$!property.key" value="$!property.value"/>
                        #end
                    #end
                </handler>
            #end
        #end
    </handlers>
    ```

    You can select to which API(s) you need to engage the handler. Given below is an example of adding only the 
    `CustomAPIAuthenticationHandler` to the sample PizzaShackAPI.

    ``` xml
    <handlers xmlns="http://ws.apache.org/ns/synapse">
        #if($apiName == 'admin--PizzaShackAPI')
            <handler class="org.wso2.carbon.sample.auth.CustomAPIAuthenticationHandler"/>
        #end
        #foreach($handler in $handlers)
            #if($apiName != 'admin--PizzaShackAPI' || !($handler.className == "org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler"))
                <handler xmlns="http://ws.apache.org/ns/synapse" class="$handler.className">
                    #if($handler.hasProperties())
                        #set ($map = $handler.getProperties() )
                        #foreach($property in $map.entrySet())
                            <property name="$!property.key" value="$!property.value"/>
                        #end
                    #end
                </handler>
            #end
        #end
    </handlers>
    ```

3.  Restart the API Manager server.


