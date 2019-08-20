# Adding Mediation Extensions

!!! note
This tutorial uses the [WSO2 API Manager Tooling Plug-in](https://docs.wso2.com/display/AM260/Installing+the+API+Manager+Tooling+Plug-In) .


The API Gateway has a default mediation flow, which you can extend by adding custom mediation sequences. In API Manager t here are 3 [default sequences](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-Sequences) engaged as `         in        ` , `         out        ` and `         fault        ` . You create a custom mediation sequence either manually or using a tool such as the [WSO2 API Manager Tooling Plug-in](https://docs.wso2.com/display/AM260/Installing+the+API+Manager+Tooling+Plug-In) , and then engage it per API or globally to all APIs of a specific tenant. With custom mediation sequences you can modify the default mediation flow for different usabilities according to your requirement. Log the mediation flow, execute operations on Message context properties, to customize, format the requests and responses are some of them.

-   [Default mediation flow](#AddingMediationExtensions-Defaultmediationflow)
-   [Creating per-API extensions](#AddingMediationExtensions-Creatingper-APIextensions)
-   [Creating global extensions](#AddingMediationExtensions-Creatingglobalextensions)

!!! note
-   The following **mediators are not usable within custom sequences** because they are not supported by the API Gateway.
    -   Call mediator in non-blocking mode
    -   Send mediator
-   When using the Loopback mediator, it is mandatory to set the following property before defining the Loopback mediator in the custom mediator sequence in the following manner.

    ``` java
        <property name="api.ut.backendRequestTime" expression="get-property('SYSTEM_TIME')"/>
    ```


### Default mediation flow

You cannot dynamically construct the back-end endpoint of an API using the address endpoints in the WSO2 API Manager. To achieve the requirement of a dynamic endpoint, you can use the default endpoint instead. The default endpoint sends the message to the address specified in the **To** header. The **To** header can be constructed dynamically. For example,

``` xml
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="default-endpoint-seq">
      <property name="service_ep" expression="fn:concat('http://jsonplaceholder.typicode.com/', 'posts/')"/>
      <header name="To" expression="get-property('service_ep')"/>
    </sequence>
```

In this example, you have constructed the `         service_ep        ` property dynamically and assigned the value of this property to the **To** header. The default endpoint sends the message to the address specified in the **To** header, in this case, `         http://jsonplaceholder.typicode.com/posts/        ` . For more details about working with dynamc endpoints, see [Dynamic Endpoints](https://docs.wso2.com/display/AM260/Working+with+Endpoints#WorkingwithEndpoints-dynamicendpoints) .

!!! note
Adding a non-blocking send operation

In this example, the Send mediator in a proxy service using the [VFS transport](https://docs.wso2.com/display/ESB500/VFS+Transport) is transferring a file to a VFS endpoint. VFS is a non-blocking transport by default, which means a new thread is spawned for each outgoing message. The [Property mediator](https://docs.wso2.com/display/ESB500/Property+Mediator) added before the Send mediator removes the [ClientAPINonBlocking](https://docs.wso2.com/display/ESB500/Generic+Properties#GenericProperties-Blocking) property from the message to perform the mediation in a single thread. This is required when the file being transferred is large and you want to avoid out-of-memory failures.

``` xml
    <inSequence>
       <property name="ClientApiNonBlocking"
               value="true"
               scope="axis2"
               action="remove"/>
       <send>
          <endpoint name="FileEpr">
             <address uri="vfs:file:////home/shammi/file-out"/>
          </endpoint>
       </send>
    </inSequence>
```


### Creating per-API extensions

-   [Create and upload using the WSO2 API Manager Tooling Plug-in](#AddingMediationExtensions-CreateanduploadusingtheWSO2APIManagerToolingPlug-in)
-   [Create and upload manually in the API Publisher](#AddingMediationExtensions-CreateanduploadmanuallyintheAPIPublisher)
-   [Editing a mediation policy](#AddingMediationExtensions-Editingamediationpolicy)
-   [Create manually and save in the file system](#AddingMediationExtensions-Createmanuallyandsaveinthefilesystem)

#### Create and upload using the WSO2 API Manager Tooling Plug-in

**The recommended way** to engage a mediation extension sequence per API is to create a custom sequence using the [WSO2 API Manager Tooling Plug-in](https://docs.wso2.com/display/AM260/Installing+the+API+Manager+Tooling+Plug-In) , upload it via its APIM Perspective and then engage it using the API Publisher. The following tutorial demonstrates how to do this: [Change the Default Mediation Flow of API Requests](https://docs.wso2.com/display/AM260/Change+the+Default+Mediation+Flow+of+API+Requests) .

#### Create and upload manually in the API Publisher

You can also create a mediation sequence manually and upload it from the API Publisher itself. For instance, you can copy the above default mediation flow content into an XML file. In the **Implement** tab of the API, select the **Enable Message Mediation** check box and click the **Upload** **In Flow** or **Upload** **Out Flow** field (for the example above, it needs to be uploaded to the `         In        ` flow). Once the file is uploaded, save and publish the API. When you invoke the API, the request is sent to the endpoint referred to in the **To** header.

![](attachments/103334749/103334751.png)
#### **Editing a mediation policy**

If you want to edit an already uploaded mediation policy,

1.  Select the mediation policy from the drop down list.
2.  Click the download icon next to it, as shown below:
    ![](attachments/103334749/103334750.png)3.  Edit the downloaded mediation XML file and re-upload it.

#### Create manually and save in the file system

Alternatively, you can name the mediation XML file in the pattern `         <API_NAME>:v<VERSION>--<DIRECTION>        ` and save it directly in the following location:

-   In the **single-tenant mode** , save the XML file in the `          <APIM_HOME>/repository/deployment/server/synapse-configs/default/sequences         ` directory.
-   In the **multi-tenant mode** , save the XML file in the tenant's synapse sequence folder. For example, if tenant id is 1, then save it in `          <API_Gateway>/repository/tenants/1/synapse-configs/default/sequences         ` folder.

In the naming pattern, the `         <DIRECTION>        ` can be `         In        ` or `         Out        ` . When it is `         In        ` , the extension is triggered on the in-flow (request path) and when it is `         Out        ` , the extension is triggered on the out-flow (response path). To change the default fault sequence, you can either modify the default sequence or write a custom fault sequence and engage it to APIs through the API Publisher.

An example synapse configuration of a per-API extension sequence created for the API `         admin--TwitterSearch        ` version 1.0.0 is given below.

``` xml
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="admin--TwitterSearch:v1.0.0--In">
     <log level="custom">
        <property name="TRACE" value="API Mediation Extension"/>
     </log>
    </sequence>
```

You can copy this content into an XML file (e.g., `         twittersearch_ext.xml        ` ) and save it in the `         <API_Gateway>/repository/deployment/server/synapse-configs/default/sequences        ` directory.

The above sequence prints a log message on the console whenever the `         TwitterSearch        ` API is invoked.

### Creating global extensions

You can also engage mediation extension sequences to all APIs of a specific tenant at once. To do that, simply create the XML with the naming pattern `         WSO2AM--Ext--<DIRECTION>        ` and save it in the `         <APIM_HOME>/repository/deployment/server/synapse-configs/default/sequences        ` directory.

An example synapse configuration of a global extension sequence is given below:

``` xml
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="WSO2AM--Ext--In"> 
        <property name="Authentication" expression="get-property('transport', 'Authentication')"/> 
        <property name="Authorization" expression="get-property('Authentication')" scope="transport" type="STRING"/> 
        <property name="Authentication" scope="transport" action="remove" /> 
    </sequence>
```

This custom sequence assigns the value of your basic authentication to Authorization header.

You can copy this content into an XML file (e.g., `         global_ext.xml        ` ) and save it in the `         <API_Gateway>/repository/deployment/server/synapse-configs/default/sequences        ` directory.

When you invoke your REST API via a REST Client, configure that client to have a custom header (Authentication) for your basic authentication credential and configure the **Authorization** header to contain the bearer token for the API. When you  send the Authentication and Authorization headers, the Gateway drops the Authorization header, converts the Authentication to Authorization headers and sends to the backend.

!!! info
[Class Mediator](https://docs.wso2.com/display/ESB500/Class+Mediator) is one specific example of mediation extension. When creating a class mediator, we are allowed to write a Java class which extends the org.apache.synapse.mediators.AbstractMediator class .

This class implements the mediate() function which access the message context and provide the facility to customize the mediation flow of the API. Through that we can read properties of the message context into variables and perform operations.

``` java
        package samples.mediators; 
     
        import org.apache.synapse.MessageContext;
        import org.apache.synapse.mediators.AbstractMediator;
        import org.apache.axiom.om.OMElement;
        import org.apache.axiom.om.OMAbstractFactory;
        import org.apache.axiom.om.OMFactory;
        import org.apache.axiom.soap.SOAPFactory;
        import org.apache.commons.logging.Log;
        import org.apache.commons.logging.LogFactory;
     
        import javax.xml.namespace.QName;
     
        public class SimpleClassMediator extends AbstractMediator {
        private String variable1 = xxx;       

        private static final Log log = LogFactory.getLog(SimpleClassMediator.class);
        
        public SimpleClassMediator(){}
 
        public boolean mediate(MessageContext mc) {
            // Do somthing useful..
            // Implementation of Reading the propertly values of Message context and modifying request / logging properties
            return true;
        }
 
        public String getType() {
            return null;
        }
 
        public void setTraceState(int traceState) {
            traceState = 0;
        }
 
        public int getTraceState() {
            return 0;
        }


        public void setVariable1(String newValue) {
            variable1=newValue;
        }
 
        public String getVariable1() {
            return variable1;
        }
  
       
    }
```
Then we can export this class as a jar file and add as a library to &lt;API-M\_HOME&gt;/repository/components/lib directory.

By refering this class with the fully qualified class name in a class mediator in the API as below, we can execute it in the insequence or outsequence of the API globally or per API as described above.

``` java
    <class name="samples.mediators.SimpleClassMediator">                
        <property name="propertyName" value="propertyValue"/>
        ....
    </class>
```

If any properties are specified in the java class of the class mediator, the corresponding setter methods are invoked once on the class during initialization.

!!! note
You can use the Class mediator for user-specific, custom developments only when there is no built-in mediator that already provides the required functionality, because maintaining custom classes incurs a high overhead. Therefore, avoid using them unless the scenario is frequently re-used and very user-specific.

!!! warning
Your class mediator might not be picked up and updated, if you use an existing package when creating it.



