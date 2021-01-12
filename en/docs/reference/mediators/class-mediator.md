# Class Mediator

The **Class Mediator** creates an instance of a custom-specified class
and sets it as a mediator. The class must implement the
`         org.apache.synapse.api.Mediator        ` interface. If any
properties are specified, the corresponding setter methods are invoked
once on the class during initialization.

The Class mediator is a custom Java class, which you need to maintain by
yourself. Therefore, it is recommended to use the Class mediator only
for not frequently re-used custom developments and very user-specific
scenarios, for which, there is no built-in mediator that already
provides the required functionality.

Your class mediator might not be picked up and updated if you use an existing package when creating. For best results, use [WSO2 Integration Studio]({{base_path}}/develop/WSO2-Integration-Studio) for debugging Class mediators.

## Syntax

``` java
<class name="class-name">
   <property name="string" (value="literal" | expression="[XPath|json-eval(JSON Path)]")/>*
</class>
```

## Configuration

**Class Name**: The name of the class. To load a class, enter the qualified name of the relevant class in this parameter and click **Load Class**.

## Example

In this configuration, the Micro Integrator sends the requested message to the endpoint specified via the [Send mediator]({{base_path}}/reference/mediators/send-Mediator). This endpoint is the Axis2server running on port 9000. The response message is passed through a Class mediator before it is sent back to the client. Two parameters named `         variable1        ` and `         variable2        ` are passed to the instance mediator implementation class ( `SimpleClassMediator`).

!!! Info
    If you want, you can pass the same variables as a value or an expression:

    -   Example for passing the variable as a value: `          <property name="variable1" value="10"/>         `

    -   Example for passing the variable as an expression: `          <property name="variable2" expression="get-property('variable1')"/>         `  
        For more information on using the get property method, see the [Property Mediator]({{base_path}}/reference/mediators/property-Mediator).

!!! Warning
        Using the class variables with expressions will lead to the values evaluated being mixed up when there are concurrent requests and will lead to erroneous behaviors. 

``` java
<sequence xmlns="http://ws.apache.org/ns/synapse" name="errorHandler">
    <makefault>
        <code value="tns:Receiver" xmlns:tns="http://www.w3.org/2003/05/soap-envelope"/>
        <reason value="Mediation failed."/>
    </makefault>
    <send/>
</sequence>

<proxy name="SimpleProxy" transports="http https" startonload="true" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
    <target>
         <inSequence>
                <send>
                    <endpoint name="stockquote">
                        <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                    </endpoint>
                </send>
            </inSequence>
            <outSequence>
                <class name="samples.mediators.SimpleClassMediator">
                    <property name="variable1" value="10"/>
                    <property name="variable2" value="5"/>
                </class>
                <send/>
            </outSequence>
            <faultSequence>
                 <sequence key="errorHandler"/>
            </faultSequence>
    </target>
</proxy>
```

See the following sample Class Mediator and note the `         SynapseMessageContext        ` and the full Synapse API in there.

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

        private static final Log log = LogFactory.getLog(SimpleClassMediator.class);

        private String variable1="10";

        private String variable2="10";

        private int variable3=0;

        public SimpleClassMediator(){}

        public boolean mediate(MessageContext mc) {
            // Do somthing useful..
            // Note the access to the Synapse Message context
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

        public void setVariable2(String newValue){
            variable2=newValue;
        }

        public String getVariable2(){
            return variable2;
        }
    }
```

<!--
#### Samples

For more examples, see:

-   [Sample 380: Writing your own Custom Mediation in
    Java](https://docs.wso2.com/display/EI650/Sample+380%3A+Writing+your+own+Custom+Mediation+in+Java)
-   [Sample 381: Class Mediator to CBR Binary
    Messages](https://docs.wso2.com/display/EI650/Sample+381%3A+Class+Mediator+to+CBR+Binary+Messages)
-->
