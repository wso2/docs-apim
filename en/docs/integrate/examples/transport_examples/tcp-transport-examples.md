# Using the TCP Transport

**Sending multiple messages via the same TCP channel**

Generally, you can send only one message via one generic TCP channel. Nevertheless, the Micro Integrator also supports sending multiple messages via the same TCP channel by splitting them in different ways.  Hence, the TCP transport needs to determine the end of the message that is mediated through the Micro Integrator to split it by a character, a sequence of characters, message length, or special characters in hex form. The client can select which input type to use to send the request to the TCP proxy out of the available options (i.e., binary and String). Splitting the message by a single character is the most efficient method.

You can split the following sample request input message in different ways as explained below.

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body/></soapenv:Envelope>"
```
## Prerequisites

[Enable the TCP transport](../../../../setup/transport_configurations/configuring-transports/#configuring-the-tcp-transport). 

## Example 1: Splitting by a character

### Synapse configurations

The following proxy service splits the message by a character. It receives a message with an empty body, which it will forward to the HTTP endpoint after enriching the body with the symbolic value "`IBM`".

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="TCPProxy" 
              transports="tcp" 
              startOnLoad="true" 
              trace="disable"> 
          <description/> 
          <target> 
             <inSequence> 
                <property name="symbol" value="IBM" scope="default" type="STRING"/> 
                <enrich> 
                   <source type="inline" clone="true"> 
                      <m:getQuote xmlns:m="http://services.samples"> 
                         <m:request> 
                            <m:symbol>?</m:symbol> 
                         </m:request> 
                      </m:getQuote> 
                   </source> 
                   <target type="body"/> 
                </enrich> 
                <enrich> 
                   <source type="property" clone="true" property="symbol"/> 
                   <target xmlns:m="http://services.samples" xpath="//m:getQuote/m:request/m:symbol"/> 
                </enrich> 
                <log level="full" separator=","/> 
                <header name="Action" value="urn:getQuote" />
                <send> 
                   <endpoint> 
                      <address uri="http://localhost:9000/services/SimpleStockQuoteService" format="soap11"/> 
                   </endpoint> 
                </send> 
             </inSequence> 
             <outSequence> 
                <log level="full"/> 
                <send/> 
             </outSequence> 
          </target> 
          <parameter name="transport.tcp.responseClient">true</parameter> 
          <parameter name="transport.tcp.recordDelimiter">|</parameter> 
          <parameter name="transport.tcp.inputType">string</parameter> 
          <parameter name="transport.tcp.port">6060</parameter> 
          <parameter name="transport.tcp.recordDelimiterType">character</parameter> 
          <parameter name="transport.tcp.contentType">text/xml</parameter> 
</proxy>
```
### Build and Run (Example 1)

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3.  Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the back-end service.

* Download the [back-end service](
https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip)
* Extract the downloaded zip file.
* Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
* Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

Send the following message via TCP to the TCP listener port.
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body/></soapenv:Envelope>|<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body/></soapenv:Envelope>
```
In linux, we can save the request in a <strong>request.xml</strong> file and use netcat to send the TCP request. 
```
netcat localhost 6060 < request.xml
```
It can be observed that two messages are sent to the backend.

## Example 2: Splitting by a special character

### Synapse configuration

The sample proxy below splits the input message by appending a special character to the end of the message.

```xml 
<proxy xmlns="http://ws.apache.org/ns/synapse" name="TCPProxy" 
          transports="tcp" 
          startOnLoad="true" 
          trace="disable"> 
      <description/> 
      <target> 
         <inSequence> 
            <property name="symbol" value="IBM" scope="default" type="STRING"/> 
            <enrich> 
               <source type="inline" clone="true"> 
                  <m:getQuote xmlns:m="http://services.samples"> 
                     <m:request> 
                        <m:symbol>?</m:symbol> 
                     </m:request> 
                  </m:getQuote> 
               </source> 
               <target type="body"/> 
            </enrich> 
            <enrich> 
               <source type="property" clone="true" property="symbol"/> 
               <target xmlns:m="http://services.samples" xpath="//m:getQuote/m:request/m:symbol"/> 
            </enrich> 
            <log level="full" separator=","/> 
            <header name="Action" value="urn:getQuote" />
            <send> 
               <endpoint> 
                  <address uri="http://localhost:9000/services/SimpleStockQuoteService" format="soap11"/> 
               </endpoint> 
            </send> 
         </inSequence> 
         <outSequence> 
            <log level="full"/> 
            <send/> 
         </outSequence> 
      </target> 
  <parameter name="transport.tcp.recordDelimiter">0x03</parameter> 
  <parameter name="transport.tcp.responseClient">true</parameter> 
  <parameter name="transport.tcp.inputType">binary</parameter> 
  <parameter name="transport.tcp.port">6060</parameter> 
  <parameter name="transport.tcp.recordDelimiterType">byte</parameter> 
  <parameter name="transport.tcp.contentType">text/xml</parameter> 
</proxy>
```

### Build and Run (Example 2)

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an ESB Solution project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project).
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-and-run) in your Micro Integrator.

Set up the back-end service.

* Download the [back-end service](
https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip)
* Extract the downloaded zip file.
* Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
* Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

Send the following message via TCP to the TCP listener port.
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body/></soapenv:Envelope>
```
In linux, we can save the request in a <strong>request.xml</strong> file and use netcat to send the TCP request. 
```
netcat localhost 6060 < request.xml
```

## Example 3: Splitting by a character sequence

### Synapse configuration

The sample proxy below splits the input message by a sequence of characters.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="TCPProxy" 
          transports="tcp" 
          startOnLoad="true" 
          trace="disable"> 
      <description/>
<target> 

        <inSequence> 
            <property name="symbol" value="IBM" scope="default" type="STRING"/> 
            <enrich> 
               <source type="inline" clone="true"> 
                  <m:getQuote xmlns:m="http://services.samples"> 
                     <m:request> 
                        <m:symbol>?</m:symbol> 
                     </m:request> 
                  </m:getQuote> 
               </source> 
               <target type="body"/> 
            </enrich> 
            <enrich> 
               <source type="property" clone="true" property="symbol"/> 
               <target xmlns:m="http://services.samples" xpath="//m:getQuote/m:request/m:symbol"/> 
            </enrich> 
            <log level="full" separator=","/> 
            <header name="Action" value="urn:getQuote" />
            <send> 
               <endpoint> 
                  <address uri="http://localhost:9000/services/SimpleStockQuoteService" format="soap11"/> 
               </endpoint> 
            </send> 
         </inSequence> 
         <outSequence> 
            <log level="full"/> 
            <send/> 
         </outSequence> 
      </target>
<parameter name="transport.tcp.responseClient">true</parameter> 
      <parameter name="transport.tcp.recordDelimiter">split</parameter>
      <parameter name="transport.tcp.inputType">string</parameter> 
      <parameter name="transport.tcp.port">6060</parameter> 
      <parameter name="transport.tcp.recordDelimiterType">string</parameter> 
      <parameter name="transport.tcp.contentType">text/xml</parameter> 
 </proxy>
```

### Build and Run (Example 3)

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an ESB Solution project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project).
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-and-run) in your Micro Integrator.

Set up the back-end service.

* Download the [back-end service](
https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip)
* Extract the downloaded zip file.
* Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
* Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

Send the following message via TCP to the TCP listener port.
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body/></soapenv:Envelope>split<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body/></soapenv:Envelope>
```

In linux, we can save the request in a <strong>request.xml</strong> file and use netcat to send the TCP request.

```
netcat localhost 6060 < request.xml
```
It can be observed that two messages are sent to the backend.

## Developing the Java Client for the Transport

The sample Java Client below splits the input message by a special character. Also, you can develop a character delimiter client by changing the below client accordingly.

```java
 import java.io.ByteArrayOutputStream;
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStreamWriter;
 import java.io.PrintWriter;
 import java.net.Socket;
 
 public class TCPClient {
 
     String host = "localhost";
     int port = 6060;
     Socket socket = null;
     int count = 0;
     
     public static void main(String args[]) throws Exception {
         Character aByte = 0x10;
         TCPClient client = new TCPClient();
         String message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                         + "<soapenv:Header/><soapenv:Body/></soapenv:Envelope>" + aByte;
         client.sendToServer(message);
         client.recieveFromServer();
         client.sendToServer(message);
         client.recieveFromServer();
         client.close();
     }
     
     TCPClient() throws Exception {
        socket = new Socket(host, port);
     }
     
     void sendToServer(String msg) throws Exception {
         //create output stream attached to socket
         PrintWriter outToServer = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()));
         //send msg to server
         outToServer.print(msg);
         outToServer.flush();
     }
     
     void recieveFromServer() throws Exception {
         char delimiter = 0x10;
         InputStream inFromServer = socket.getInputStream();
         //read from server
         int next = inFromServer.read();
         ByteArrayOutputStream bos = new ByteArrayOutputStream();
         while (next > -1) {
             if (delimiter != next) {
                bos.write(next);
            }
            next = inFromServer.read();
            if (delimiter == next) {
                System.out.println(new String(bos.toByteArray()));
                count++;
                if (count == 1 || count == 2) {
                    break;
                }
                bos = new ByteArrayOutputStream();
            }
        }   
        if (count == 2) {
            close();
        }
     }
     
     void close() throws IOException {
        socket.close();
     }
 }
```
