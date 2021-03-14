# OAuth Mediator

The **OAuth Mediator** supports 2 forms of OAuth. It bypasses the RESTful requests and authenticates users against WSO2 Identity Server.

When a client tries to invoke a RESTful service, it may be required to verify the credentials of the client. This can be achieved by registering an OAuth application in the WSO2 Identity Server. When the client sends a REST call with the Authorization header to the Micro Integrator, the OAuth mediator validates it with the Identity server and proceeds.

See [2-legged OAuth for Securing a RESTful Service](https://docs.wso2.com/display/IS570/2-legged+OAuth+for+Securing+a+RESTful+Service) for detailed instructions to carry out this process.

!!! Info
	If you are using OAuth 1 a, you will get the `org.apache.synapse.SynapseException: Unable to find SCOPE value in Synapse Message Context` error when the `         SCOPE        ` property is not set in the synapse message context. To avoid this error, add a property with the name `scope` and a value in the synapse message context as shown in the [Example](#example) section.

## Syntax

``` java
<oauthService remoteServiceUrl="" username="" password=""/>
```

## Configuration

The parameters available to configure the OAuth mediator are as follows.

| Parameter Name   | Description                                                    |
|------------------|----------------------------------------------------------------|
| **OAuth Server** | The server URL of the WSO2 Identity Server.                    |
| **Username**     | The user name to be used to log into the WSO2 Identity Server. |
| **Password**     | The password used to log into the WSO2 Identity Server.        |
  
## Example

In the following OAuth mediator configuration accesses a remote service
via the `         https://localhost:9443/service        ` URL. The user
accessing this service is authenticated via the OAuth application
registered in the WSO2 Identity Server and accessed via the
`         http://ws.apache.org/ns/synapse        ` URL. The username
used to log into the WSO2 Identity Server is `         foo        ` and
the password is `         bar        ` . Both the user name and the
password should be registered in the Identity Server. The [Property mediator]({{base_path}}/reference/mediators/property-mediator) adds a property named
`         scope        ` to the synapse message context. The value of
this property will be used by the OAuth mediator to send the OAuth
request.

!!! Info
	The following example is applicable for OAuth 2.0 as well.

``` xml
<property name="scope" scope="default" type="STRING" value="123"/>
<oauthService xmlns="http://ws.apache.org/ns/synapse" remoteServiceUrl="https://localhost:9443/services" username="foo" password="bar" />
```
