# NTLM Mediator

NTLM (Windows NT LAN Manager) is an authentication protocol provided in Windows server. NTLM authentication is based on a challenge response-based protocol and WSO2 API Manager gives support to access NTLM protected services by using the NTLM mediator. You need to configure the NTLM backend and use that credentials to access NTLM protected services by using the WSO2 API Manager. First you need to initialize the NTLM mediator and then you can use call mediator or callout mediator to send requests to the backend service.

!!! Info
    - The NTLM mediator is a [content-unaware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

```xml
<NTLM [username="string"] [password="string"] [host="string"] [domain="string"] [ntlmVersion="string"]>
</NTLM>
```

## Configuration

The parameters available for configuring the NTLM mediator are as follows.

<table>
    <tr>
        <th>Parameter Name</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Domain</td>
        <td>Domain of the NTLM configured host. Set your NTLM configured computer domain name in here.</td>
    </tr>
    <tr>
        <td>Host</td>
        <td>NTLM configured the backend host name.</td>
    </tr>
    <tr>
        <td>ntlmVersion</td>
        <td>NTLM version to connect with. Currently there are two NTLM versions available as v1 and v2.</td>
    </tr>
    <tr>
        <td>Username</td>
        <td>NTLM backend username. This is the username of the NTLM enabled backend Windows server.</td>
    </tr>
    <tr>
        <td>Password</td>
        <td>NTLM backend password. This is the password of the NTLM enabled backend Windows server.</td>
    </tr>
</table>

## Example

An example NTLM mediator config is as follows:

```xml
<NTLM domain="DESKTOP-8J5ADEM" host="localhost" ntlmVersion="v2" username="wso2" password="xxxxxxx"/>
```

For MI versions, make sure to include jcifs dependency as it is not included in the product by default.

Use call or callout mediator with initAxis2ClientOptions option set to "false".

Once you have initialized the NTLM mediator, you can call the NTLM enabled endpoint with a call with blocking mode or with a callout mediator. Check the following two example scenarios:

**Example 1 - With Callout Mediator calling a SOAP endpoint**

```xml
<Sequence>
        <NTLM username="username" password="password" host="localhost" domain="DESKTOP-ABCD" ntlmVersion="v2"/>
        <callout serviceURL="http://localhost/WcfService1/Service1.svc/test" action="http://tempuri.org/IService1/ResponseFromNTLMservice"
 initAxis2ClientOptions="false">
            <source xpath="s11:Body/child::*[fn:position()=1] | s12:Body/child::*[fn:position()=1]"/>
            <target xpath="s11:Body/child::*[fn:position()=1] | s12:Body/child::*[fn:position()=1]"/>
        </callout>
        <property name="NO_ENTITY_BODY" scope="axis2" action="remove"/>
        <respond/>
</Sequence>
```

**Example 2 - With Call Mediator calling a REST endpoint**

```xml
<Sequence>
        <NTLM username="username" password="password" host="localhost" domain="DESKTOP-ABCD" ntlmVersion="v2"/>
        <call blocking="true" initAxis2ClientOptions="false">
          <endpoint>
            <address uri="http://localhost/WcfService/Service.svc/test"/>
          </endpoint>
        </call>
        <log level="full"/>
        <respond/>
</Sequence>
```