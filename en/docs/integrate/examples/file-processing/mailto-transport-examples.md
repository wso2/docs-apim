# MailTo Transport Examples

## Globally setting the email sender

When the [MailTo transport sender is enabled]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport) for the Micro Integrator, you can configure your mediation sequences to send emails. In this example, the email sender credentials are set globally in the `deployment.toml` file (stored in the `MI_HOME/conf` directory). You need to specify a valid email address prefixed with the transport sender name (which is specified in the deployment.toml file) in your mediation flow. For example, if the transport sender is 'mailto', the endpoint URL in the synapse configuration should be as follows: `mailto:targetemail@mail.com`

### Synapse configuration

Following are the integration artifacts (proxy service) that we can used to implement this scenario.

```xml
<proxy name="EmailSender" startOnLoad="true" transports="https http" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <inSequence>
            <log/>
            <send>
                <endpoint>
                    <address uri="mailto:targetemail@mail.com"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </target>
</proxy>
```

!!! Note
    - Incoming payload will be sent as mail body.

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio). The path to this folder is referred to as `MI_TOOLING_HOME` throughout this tutorial.
2. Open the `deployment.toml` file from the `MI_TOOLING_HOME/Contents/Eclipse/runtime/microesb/conf` directory, and [enable the MailTo transport sender]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport).
4. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator. 

Invoke the proxy service by sending a request. For example use SOAP UI. Check the inbox of your email account, which is configured as the target endpoint. You will receive an email from the email sender that is configured globally in the deployment.toml file.

## Dynamically setting the email sender

In this example, let's set the email sender details by adding **Property** mediators to the mediation sequence. If these details are not provided in the proxy service, the system uses the [email sender configurations](#globally-setting-the-email-sender) in the deployment.toml file explained above.

### Synapse configuration

Following are the integration artifacts (proxy service) that we can used to implement this scenario.

Enter a valid email address prefixed with the transport sender name (specified in the `deployment.toml` file). For example, if the transport sender is 'mailto', the endpoint URL should be as follows: `mailto:targetemail@mail.com`.

!!! Note
    -   You need to update the property values with actual values of the mail sender account.
    -   In some email service providers, the value for the 'mail.smtp.user' property is the same as the email address of the account.

!!! Tip
    For testing purposes, be sure to enable access from less secure apps to your email account. See the documentation from your email service provider for instructions.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy name="EmailSender" startOnLoad="true" transports="https http" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <inSequence>
            <log/>
            <property name="From" scope="transport" type="STRING" value="frommail@mail.com"/>
            <property name="mail.smtp.user" scope="transport" type="STRING" value="userID"/>
            <property name="mail.smtp.password" scope="transport" type="STRING" value="xxxxxx"/>
            <send>
                <endpoint>
                    <address uri="mailto:targetemail@mail.com"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </target>
</proxy>
```
### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio). The path to this folder is referred to as `MI_TOOLING_HOME` throughout this tutorial.
2. Open the `deployment.toml` file from the `MI_TOOLING_HOME/Contents/Eclipse/runtime/microesb/conf` directory, and [enable the MailTo transport sender]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport).
4. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator. 

Invoke the proxy service by sending a request. Check your inbox. You will receive an email from the email sender that you configured for the proxy service.

## Receiving emails

When the [MailTo transport listener is enabled]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport) for the Micro Integrator, you can configure your mediation sequences to send emails.

In this example, let's configure your mediation sequence to receive emails and then process the email contents. The MailTo transport receiver should be configured at service level and each service configuration should explicitly state the mail transport receiver configuration. This is required to enable different services to receive mails over different mail accounts and configurations.

!!! Info
    You need to provide correct parameters for a valid mail account at the service level.

### Synapse configuration

In this sample, we used the `transport.mail.ContentType` property to make sure that the transport parses the request message as POX. If you remove this property, you may still be able to send requests using a standard mail client. Instead of writing the XML in the body of the message, you add it as an attachment. In that case, you should use XML as a suffix for the attachment and format the request as a SOAP 1.1 message. Indeed, for a file with suffix XML, the mail client will most likely use text/XML as the content type, exactly as required for SOAP 1.1. Sending a POX message using this approach will be a lot trickier because most standard mail clients do not allow the user to explicitly set the content type.

```xml
<proxy name="StockQuoteProxy" transports="mailto">
    <parameter name="transport.mail.Address">synapse.demo.1@gmail.com</parameter>
    <parameter name="transport.mail.Protocol">pop3</parameter>
    <parameter name="transport.PollInterval">5</parameter>
    <parameter name="mail.pop3.host">pop.gmail.com</parameter>
    <parameter name="mail.pop3.port">995</parameter>
    <parameter name="mail.pop3.user">synapse.demo.1</parameter>
    <parameter name="mail.pop3.password">mailpassword1</parameter>
    <parameter name="mail.pop3.socketFactory.class">javax.net.ssl.SSLSocketFactory</parameter>
    <parameter name="mail.pop3.socketFactory.fallback">false</parameter>
    <parameter name="mail.pop3.socketFactory.port">995</parameter>
    <parameter name="transport.mail.ContentType">application/xml</parameter>
    <target>
        <inSequence>
            <property name="senderAddress" expression="get-property('transport', 'From')"/>
            <log level="full">
                <property name="Sender Address" expression="get-property('senderAddress')"/>
            </log>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <property name="Subject" value="Custom Subject for Response" scope="transport"/>
            <header name="To" expression="fn:concat('mailto:', get-property('senderAddress'))"/>
            <log level="full">
                <property name="message" value="Response message"/>
                <property name="Sender Address" expression="get-property('senderAddress')"/>
            </log>
            <send/>
        </outSequence>
    </target>
    <publishWSDL key="conf:custom/sample_proxy_1.wsdl"/>
</proxy>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio). The path to this folder is referred to as `MI_TOOLING_HOME` throughout this tutorial.
2. Open the `deployment.toml` file from the `MI_TOOLING_HOME/Contents/Eclipse/runtime/microesb/conf` directory, and [enable the MailTo transport sender]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport).
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. Add [sample_proxy_1.wsdl](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-protocol-switching/sample_proxy_1.wsdl) as a [registry resource]({{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources). Change the registry path of the proxy accordingly. 
5. Set up the back-end service.
   - Download the [back-end service](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip)
   
   - Extract the downloaded zip file.
   - Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
   - Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```
      
6. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator. 

Send a plain/text e-mail (Make sure you switch to **Plain text** **mode** when you are composing the email) with the following body and any custom Subject from your mail account to the mail address `synapse.demo.1@gmail.com`. 

```xml 
<m0:getQuote xmlns:m0="http://services.samples">
    <m0:request>
        <m0:symbol>IBM</m0:symbol>
    </m0:request>
</m0:getQuote>
```

After a few seconds (for example 30 seconds), you should receive a POX response in your e-mail account with the stock quote reply.
