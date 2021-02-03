# Applying Security to an API

## Using a Basic Auth handler
A Basic Authentication handler is enabled in the Micro Integrator by default. See the example on [securing an API with basic auth]({{base_path}}/integrate/examples/rest_api_examples/securing-rest-apis).

## Using a custom basic auth handler

If required, you can implement a custom basic auth handler (instead of the default handler explained above). The following example of a primitive security handler serves as a template that can be used to write your own security handler to secure an API.

### Prerequisites

**Before you begin**, be sure to [configure a user store](../../../setup/user_stores/setting_up_a_userstore) for the Micro Integrator and add the required users and roles.

### Creating the custom handler

The custom Basic Auth handler in this sample simply verifies whether the request uses username: admin and password: admin. Following is the code for this handler:

```java
package org.wso2.rest;
import org.apache.commons.codec.binary.Base64;
import org.apache.synapse.MessageContext;
import org.apache.synapse.core.axis2.Axis2MessageContext;
import org.apache.synapse.core.axis2.Axis2Sender;
import org.apache.synapse.rest.Handler;
 
import java.util.Map;
 
public class BasicAuthHandler implements Handler {
    public void addProperty(String s, Object o) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public Map getProperties() {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public boolean handleRequest(MessageContext messageContext) {

        org.apache.axis2.context.MessageContext axis2MessageContext
                = ((Axis2MessageContext) messageContext).getAxis2MessageContext();
        Object headers = axis2MessageContext.getProperty(
                org.apache.axis2.context.MessageContext.TRANSPORT_HEADERS);

        if (headers != null && headers instanceof Map) {
            Map headersMap = (Map) headers;
            if (headersMap.get("Authorization") == null) {
                headersMap.clear();
                axis2MessageContext.setProperty("HTTP_SC", "401");
                headersMap.put("WWW-Authenticate", "Basic realm=\"WSO2 ESB\"");
                axis2MessageContext.setProperty("NO_ENTITY_BODY", new Boolean("true"));
                messageContext.setProperty("RESPONSE", "true");
                messageContext.setTo(null);
                Axis2Sender.sendBack(messageContext);
                return false;

            } else {
                String authHeader = (String) headersMap.get("Authorization");
                if (processSecurity(credentials)) {
                    return true;
                } else {
                    headersMap.clear();
                    axis2MessageContext.setProperty("HTTP_SC", "403");
                    axis2MessageContext.setProperty("NO_ENTITY_BODY", new Boolean("true"));
                    messageContext.setProperty("RESPONSE", "true");
                    messageContext.setTo(null);
                    Axis2Sender.sendBack(messageContext);
                    return false;
                }
            }
        }
        return false;
    }
 
    public boolean handleResponse(MessageContext messageContext) {
        return true;
    }

    public boolean processSecurity(String credentials) {
        String decodedCredentials = new String(new Base64().decode(credentials.getBytes()));
        String usernName = decodedCredentials.split(":")[0];
        String password = decodedCredentials.split(":")[1];
        if ("admin".equals(username) && "admin".equals(password)) {
            return true;
        } else {
            return false;
        }
    }
}
```

You can build the project (mvn clean install) for this handler by accessing its source from here: https://github.com/wso2/product-esb/tree/v5.0.0/modules/samples/integration-scenarios/starbucks_sample/BasicAuth-handler

!!! Note
    When building the sample using the source ensure you update `pom.xml` with the online repository. To do this, add the following section before `<dependencies>` tag in `pom.xml` :

    ```xml
    <repositories>
        <repository>
           <id>wso2-nexus</id>
           <name>WSO2 internal Repository</name>
           <url>http://maven.wso2.org/nexus/content/groups/wso2-public/</url>
           <releases>
              <enabled>true</enabled>
              <updatePolicy>daily</updatePolicy>
              <checksumPolicy>ignore</checksumPolicy>
           </releases>
         </repository>
         <repository>
           <id>wso2-maven2-repository</id>
           <name>WSO2 Maven2 Repository</name>
           <url>http://dist.wso2.org/maven2</url>
           <snapshots>
             <enabled>false</enabled>
           </snapshots>
           <releases>
             <enabled>true</enabled>
             <updatePolicy>never</updatePolicy>
             <checksumPolicy>fail</checksumPolicy>
           </releases>
        </repository>
    </repositories>
    ```

Alternatively, you can download the JAR file from the following location, copy it to the `MI_HOME/lib` directory,
and restart the Micro Integrator: https://github.com/wso2/product-esb/blob/v5.0.0/modules/samples/integration-scenarios/starbucks_sample/bin/WSO2-REST-BasicAuth-Handler-1.0-SNAPSHOT.jar

### Creating the REST API

Add the handler to the REST API:

```xml
<api xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteAPI" context="/stockquote">
       <resource methods="GET" uri-template="/view/{symbol}">
          <inSequence>
             <payloadFactory media-type="xml">
                <format>
                   <m0:getQuote xmlns:m0="http://services.samples">
                      <m0:request>
                         <m0:symbol>$1</m0:symbol>
                      </m0:request>
                   </m0:getQuote>
                </format>
                <args>
                   <arg evaluator="xml" expression="get-property('uri.var.symbol')"/>
                </args>
             </payloadFactory>
             <header name="Action" scope="default" value="urn:getQuote"/>
             <send>
                <endpoint>
                   <address uri="http://localhost:9000/services/SimpleStockQuoteService" format="soap11"/>
                </endpoint>
             </send>
          </inSequence>
          <outSequence>
             <send/>
          </outSequence>
          <faultSequence/>
       </resource>
       <handlers>
         <handler class="org.wso2.rest.BasicAuthHandler"/>
        </handlers>
</api>                                    
```

You can now send a request to the secured API.
