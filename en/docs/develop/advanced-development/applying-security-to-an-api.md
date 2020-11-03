# Applying Security to an API

## Using a Basic Auth handler
A Basic Authentication handler is enabled in the Micro Integrator by defualt. See the example on [securing an API with basic auth](../../../use-cases/examples/rest_api_examples/securing-rest-apis).

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

## Using Kerberos to secure the REST API

### Prerequisites

**Before you begin**, be sure to [configure a user store](../../../setup/user_stores/setting_up_a_userstores) for the Micro Integrator and add the required users and roles.

### Setting up the Kerberos server

First, you need to set up the Kerberos server and create the credentials for the Micro Integrator (which holds the REST API). For example, let's set up
Active Directory as the kerberos server (KDC):

1.  [Download Apache Directory Studio](https://directory.apache.org/studio/users-guide/apache_directory_studio/download_install.html) and install the product.

2.  In Active Directory(AD), create a new user as shown below.

    <table style="width:100%;">
    <tr>
      <th>Parameter</th>
      <th>Description</th>
    </tr>
    <tbody>
    <tr class="odd">
    <td>Username</td>
    <td>esbservice</td>
    </tr>
    </tbody>
    </table>

3.  Be sure to select **Password does not expire**, and deselect **User must change password** .
4.  Open a terminal and execute the following command to set the Service Principal Name (spn) for the ESB server:

    ```bash
    setspn -s HTTP/myserver esbservice
    ```

    You will now have the following:

    <table>
    <tr>
      <th>Property</th>
      <th>Description</th>
    </tr>
    <tbody>
    <tr class="odd">
    <td>Username</td>
    <td>esbservice</td>
    </tr>
    <tr class="even">
    <td>Service Principal Name</td>
    <td>HTTP/myserver</td>
    </tr>
    </tbody>
    </table>

5.  Open a terminal and execute the command shown below to g enerate the keytab file for the above service. The keytab file contains the password for the service.
6.  Download the `WSO2-REST-KerberosAuth-Handler-1.0.0-SNAPSHOT.jar` file from [here](../../../assets/attach/security/WSO2-REST-KerberosAuth-Handler-1.0.0-SNAPSHOT.jar) and copy it to the `MI_HOME/lib` directory.

### Creating the REST API

Create the following REST API and add the Kerberos handler to secure it with Kerberos authentication. Be sure to replace the handler configurations as described below.
    
```xml
<api xmlns="http://ws.apache.org/ns/synapse"
        name="HealthCheckAPI"
        context="/HealthCheck">
        <resource methods="GET" url-mapping="/status" faultSequence="fault">
            <inSequence>
                <payloadFactory media-type="json">
                    <format>{"Status":"OK"}</format>
                    <args/>
                </payloadFactory>
                <log>
                <property name="JSON-Payload" expression="json-eval($.)"/>
                </log>
                <property name="NO_ENTITY_BODY" scope="axis2" action="remove"/>
                <property name="messageType" value="application/json" scope="axis2" type="STRING"/>
                <respond/>
            </inSequence>
        </resource>
        <handlers>
            <handler class="org.wso2.rest.handler.KerberosAuthHandler">
                <property name="keyTabFilePath" value="<PATH_TO_KEYTAB_FILE>"/>
            </handler>
        </handlers>
</api>
```

Kerberos handler parameters:
    
<table>
        <colgroup>
        <col style="width: 11%" />
        <col style="width: 88%" />
        </colgroup>
        <thead>
        <tr class="header">
        <th>Property</th>
        <th>Description</th>
        </tr>
        </thead>
        <tbody>
        <tr class="odd">
        <td>keyTabFilePath</td>
        <td>The file path to the KeyTab file that was generated for the ESB server. Note that this file contains the password corresponding to the server principal name.</td>
        </tr>
        <tr class="even">
        <td>serverPrincipal</td>
        <td>This is the server principal name (spn) that was generated for the ESB server.</td>
        </tr>
        </tbody>
</table>
    
You have now configured a REST API which is secured with the Kerberos authentication.  

## Using an OAuth base security token
    
You can generate an OAuth base security token using WSO2 Identity Server, and then use that token when invoking your API to connect to a REST endpoint. This approach involves the following tasks:
    
1.  Create a custom handler that will validate the token.
2.  Create an API that points to the REST endpoint and includes the custom handler.
3.  Create an OAuth application in Identity Server and get the access token.
4.  Invoke the API with the access token

### Prerequisites

**Before you begin**, be sure to [configure a user store](../../../setup/user_stores/setting_up_a_userstore) for the Micro Integrator and add the required users and roles.
    
### Creating the custom handler
    
The custom handler must extend AbstractHandler and implement ManagedLifecycle as shown in the following example. You can download the Maven project for this example:https://github.com/wso2-docs/ESB/tree/master/ESB-Artifacts/OAuthHandler_Sample
    
```java
package org.wso2.handler;
import org.apache.axis2.AxisFault;
import org.apache.axis2.client.Options;
import org.apache.axis2.client.ServiceClient;
import org.apache.axis2.context.ConfigurationContext;
import org.apache.axis2.context.ConfigurationContextFactory;
import org.apache.axis2.transport.http.HTTPConstants;
import org.apache.axis2.transport.http.HttpTransportProperties;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpHeaders;
import org.apache.synapse.core.axis2.Axis2MessageContext;
import org.wso2.carbon.identity.oauth2.stub.OAuth2TokenValidationServiceStub;
import org.wso2.carbon.identity.oauth2.stub.dto.OAuth2TokenValidationRequestDTO;
import org.apache.synapse.ManagedLifecycle;
import org.apache.synapse.MessageContext;
import org.apache.synapse.core.SynapseEnvironment;
import org.apache.synapse.rest.AbstractHandler;
import org.wso2.carbon.identity.oauth2.stub.dto.OAuth2TokenValidationRequestDTO_OAuth2AccessToken;

import java.util.Map;

public class SimpleOauthHandler extends AbstractHandler implements ManagedLifecycle {

    private static final String CONSUMER_KEY_HEADER = "Bearer";
    private static final String OAUTH_HEADER_SPLITTER = ",";
    private static final String CONSUMER_KEY_SEGMENT_DELIMITER = " ";
    private static final String OAUTH_TOKEN_VALIDATOR_SERVICE = "oauth2TokenValidationService";
    private static final String IDP_LOGIN_USERNAME = "identityServerUserName";
    private static final String IDP_LOGIN_PASSWORD = "identityServerPw";
    private ConfigurationContext configContext;
    private static final Log log = LogFactory.getLog(SimpleOauthHandler.class);

    @Override
    public boolean handleRequest(MessageContext msgCtx) {
        if (this.getConfigContext() == null) {
            log.error("Configuration Context is null");
            return false;
        }
        try{
            //Read parameters from axis2.xml
            String identityServerUrl =
                    msgCtx.getConfiguration().getAxisConfiguration().getParameter(
                            OAUTH_TOKEN_VALIDATOR_SERVICE).getValue().toString();
            String username =
                    msgCtx.getConfiguration().getAxisConfiguration().getParameter(
                            IDP_LOGIN_USERNAME).getValue().toString();
            String password =
                    msgCtx.getConfiguration().getAxisConfiguration().getParameter(
                            IDP_LOGIN_PASSWORD).getValue().toString();
            OAuth2TokenValidationServiceStub stub =
                    new OAuth2TokenValidationServiceStub(this.getConfigContext(), identityServerUrl);
            ServiceClient client = stub._getServiceClient();
            Options options = client.getOptions();
            HttpTransportProperties.Authenticator authenticator = new HttpTransportProperties.Authenticator();
            authenticator.setUsername(username);
            authenticator.setPassword(password);
            authenticator.setPreemptiveAuthentication(true);
            options.setProperty(HTTPConstants.AUTHENTICATE, authenticator);
            client.setOptions(options);
            OAuth2TokenValidationRequestDTO dto = this.createOAuthValidatorDTO(msgCtx);
            return stub.validate(dto).getValid();
        }catch(Exception e){
            log.error("Error occurred while processing the message", e);
            return false;
        }
    }
    private OAuth2TokenValidationRequestDTO createOAuthValidatorDTO(MessageContext msgCtx) {
        OAuth2TokenValidationRequestDTO dto = new OAuth2TokenValidationRequestDTO();
        Map headers = (Map) ((Axis2MessageContext) msgCtx).getAxis2MessageContext().
                getProperty(org.apache.axis2.context.MessageContext.TRANSPORT_HEADERS);
        String apiKey = null;
        if (headers != null) {
            apiKey = extractCustomerKeyFromAuthHeader(headers);
        }
        OAuth2TokenValidationRequestDTO_OAuth2AccessToken token =
                new OAuth2TokenValidationRequestDTO_OAuth2AccessToken();
        token.setTokenType("bearer");
        token.setIdentifier(apiKey);
        dto.setAccessToken(token);
        return dto;
    }
    private String extractCustomerKeyFromAuthHeader(Map headersMap) {
        //From 1.0.7 version of this component onwards remove the OAuth authorization header from
        // the message is configurable. So we dont need to remove headers at this point.
        String authHeader = (String) headersMap.get(HttpHeaders.AUTHORIZATION);
        if (authHeader == null) {
            return null;
        }
        if (authHeader.startsWith("OAuth ") || authHeader.startsWith("oauth ")) {
            authHeader = authHeader.substring(authHeader.indexOf("o"));
        }
        String[] headers = authHeader.split(OAUTH_HEADER_SPLITTER);
        if (headers != null) {
            for (String header : headers) {
                String[] elements = header.split(CONSUMER_KEY_SEGMENT_DELIMITER);
                if (elements != null && elements.length > 1) {
                    boolean isConsumerKeyHeaderAvailable = false;
                    for (String element : elements) {
                        if (!"".equals(element.trim())) {
                            if (CONSUMER_KEY_HEADER.equals(element.trim())) {
                                isConsumerKeyHeaderAvailable = true;
                            } else if (isConsumerKeyHeaderAvailable) {
                                return removeLeadingAndTrailing(element.trim());
                            }
                        }
                    }
                }
            }
        }
        return null;
    }
    private String removeLeadingAndTrailing(String base) {
        String result = base;
        if (base.startsWith("\"") || base.endsWith("\"")) {
            result = base.replace("\"", "");
        }
        return result.trim();
    }
    @Override
    public boolean handleResponse(MessageContext messageContext) {
        return true;
    }
    @Override
    public void init(SynapseEnvironment synapseEnvironment) {
        try {
            this.configContext =
                    ConfigurationContextFactory.createConfigurationContextFromFileSystem(null, null);
        } catch (AxisFault axisFault) {
            log.error("Error occurred while initializing Configuration Context", axisFault);
        }
    }
    @Override
    public void destroy() {
        this.configContext = null;
    }
    private ConfigurationContext getConfigContext() {
        return configContext;
    }
}
```

Copy the custom `handler.jar` to the `MI_HOME/lib` directory.
    
### Creating the REST API
    
You will now create an API named TestGoogle that connects to the following endpoint: https://www.google.lk/search?q=wso2

1.  See the example REST API configuration given below:
    
    ```xml
    <api xmlns="http://ws.apache.org/ns/synapse"
         name="TestGoogle"
         context="/search">
       <resource methods="GET">
          <inSequence>
             <log level="full">
               <property name="STATUS" value="***** REQUEST HITS IN SEQUENCE *****"/>
             </log>
             <send>
                <endpoint>
                   <http method="get" uri-template="https://www.google.lk/search?q=wso2"/>
                </endpoint>
             </send>
          </inSequence>
       </resource>
       <handlers>
           <handler class="org.wso2.handler.SimpleOauthHandler"/>
       </handlers>
    </api>
    ```        
    Notice that the `           <handlers>          ` tag contains the reference to the custom handler class.
        
2.  Open `MI_HOME/conf/deployment.toml` and add the following parameters:
        
    ```
    [[transport.parameters]]
    name = "oauth2TokenValidationService"
    value = "https://localhost:9444/services/OAuth2TokenValidationService"
  
    [[transport.parameters]]
    name = "identityServerUserName"
    value = "admin"
  
    [[transport.parameters]]
    name = "identityServerPw"
    value = "admin"
    ```
3.  Restart the Micro Integrator.
        
### Getting the OAuth token
        
You will now use Identity Server to create an OAuth application and generate the security token.
        
1.  Start WSO2 Identity Server and log into the management console.
2.  On the **Main** tab, click **Add** under **Service Providers** , and then [add a service provider](https://docs.wso2.com/display/IS570/Adding+and+Configuring+a+Service+Provider)
3.  Note the access token URL and embed it in a cURL request to get the token. For example, use the following command and replace the values with the actual values: 

    ```
    curl -v -k -X POST --user : -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -d 'grant\_type=password&username=admin&password=admin' https://localhost:9444/oauth2/token
    ```
        
Identity Server returns the access token, which you can now use when invoking the API. For example: `curl -v -X GET -H "Authorization: Bearer ca1799fc84986bd87c120ba499838a7" http://localhost:8290/search`

## Using a policy file to authenticate with a secured back-end service
You can connect a REST client to a secured back-end service (such as a SOAP service) through an API that reads from a policy file.

### Prerequisites

**Before you begin**, be sure to [configure a user store](../../../setup/user_stores/setting_up_a_userstore) for the Micro Integrator and add the required users and roles.

### Creating the REST API
        
First, you configure the Micro Integrator to expose the API to the REST client.
    
```xml
  <api xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteAPI" context="/stockquote">
      <resource methods="GET" uri-template="/view/{symbol}">e
         <inSequence trace="enable">
            <header name="Action" value="urn:getQuote"/>
            <payloadFactory>
               <format>
                  <m0:getQuote xmlns:m0="http://services.samples">
                     <m0:request>
                        <m0:symbol>$1</m0:symbol>
                     </m0:request>
                  </m0:getQuote>
               </format>
               <args>
                  <arg expression="get-property('uri.var.symbol')"/>
               </args>
            </payloadFactory>
            <send>
               <endpoint name="rest">
                  <address uri="http://localhost:9000/services/SecureStockQuoteService"
                           format="soap11">
                     <enableAddressing/>
                     <enableSec policy="sec_policy"/>
                  </address>
               </endpoint>
            </send>
            </inSequence>
         <outSequence trace="enable">
            <header xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"
                    name="wsse:Security"
                    action="remove"/>
            <send/>
         </outSequence>
      </resource>
      <resource methods="POST">
         <inSequence>
            <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2"/>
            <property name="OUT_ONLY" value="true"/>
            <send>
               <endpoint>
                  <address uri="http://localhost:9000/services/SimpleStockQuoteService"
                           format="soap11"/>
               </endpoint>
            </send>
         </inSequence>
      </resource>
   </api>
```
 
The policy file stores the security parameters that are going to authenticated by the back-end service. You specify the policy file with the localEntry property, which in this example we've named sec_policy:
    
```xml
<localEntry xmlns="http://ws.apache.org/ns/synapse" key="sec_policy" src="file:repository/samples/resources/policy/policy_3.xml"/> 
```
    
You use then reference the policy file by its localEntry name when enabling the security policy for the end point:
    
```xml
<address uri="http://localhost:9000/services/SecureStockQuoteService"
    format="soap11">
    <enableAddressing/>
    <enableSec policy="sec_policy"/>
</address>
```
    
In the outSequence property, the security header must be removed before sending the response back to the REST client.
    
```xml
<outSequence trace="enable">
<header xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" name="wsse:Security" action="remove"/>
```

<!--    
To test this API configuration, you must run the SecureStockQuoteService, which is bundled in the samples folder, as the back-end server. This sample uses Apache Rampart as the back-end security implementation. Therefore, you need to download and install the unlimited strength policy files for your JDK before using Apache Rampart.

### Testing the API

To download and install the unlimited strength policy files:
    
1.  Go to <http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html>, and download the unlimited strength JCE policy files for your JDK version.
2.  Uncompress and extract the downloaded ZIP file. This creates a directory named JCE that contains the `local_policy.jar` and `US_export_policy.jar` files.
3.  In your Java installation directory, go to the `jre/lib/security` directory, make a copy of the existing `local_policy.jar` and `US_export_policy.jar` files, and then replace the original policy files with the policy files you extracted in the previous step.
    
Now that you have set up the API and the secured back-end SOAP service, you are ready to test this configuration with the following curl command.
    
```bash
curl -v http://127.0.0.1:8280/stockquote/view/IBM
```
    
Observe that the REST client is getting the correct response (the `wsse:Security` header is removed from the decrypted message) while going through the secured back-end service and the API implemented in the Micro Integrator. You can use a TCP monitoring tool such as [tcpmon](https://code.google.com/p/tcpmon/downloads/list) to monitor the message sent from the the Micro Integrator and the response message received by the Micro Integrator. For a tutorial on using tcpmon, see http://technonstop.com/tcpmon-tutorial.
-->
  
## Transforming Basic Auth to WS-Security
    
REST clients typically use Basic Auth over HTTP to authenticate the user name and password, but if the back-end service uses WS-Security, you can configure the API to transform the authentication from Basic Auth to WS-Security.

### Prerequisites

**Before you begin**, be sure to [configure a user store](../../../setup/user_stores/setting_up_a_userstore) for the Micro Integrator and add the required users and roles.

### Creating the REST API
To achieve this transformation, you configure the Micro Integrator to expose the API to the REST client as shown in the previous example, but you add the HTTPS protocol and Basic Auth handler to the configuration as shown below:
    
```xml
  <localEntry xmlns="http://ws.apache.org/ns/synapse" key="sec_policy"
src="file:repository/samples/resources/policy/policy_3.xml"/>
```

```xml
  <api xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteAPI" context="/stockquote">
    <resource methods="GET" uri-template="/view/{symbol}" protocol="https" >
     ...
    </resource>
    <handlers>
      <handler class="org.wso2.rest.BasicAuthHandler"/>
    </handlers>
  </api>
```

### Testing the API
This configuration allows two-fold security: the client authenticates with the API using Basic Auth over HTTPS, and then the API sends the request to the back-end service using the security policy. You can test this configuration using the following command:
    
```bash
 curl -v -k -H "Authorization: Basic YWRtaW46YWRtaW4=" https://localhost:8253/stockquote/view/IBM  
```