# Adding a Class Mediator

`Class Mediator` is one specific example of a mediation extension. When creating a class mediator, we are allowed to write a Java class that extends the `org.apache.synapse.mediators.AbstractMediator` class.

This class implements the mediate() function which accesses the message context and provides the facility to customize the mediation flow of the API. Through that, we can read properties of the message context into variables and perform operations.

```java
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
    private String variable1 = xxx; 

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

Then we can export this class as a jar file and add as a library to `<API-M_HOME>/repository/components/lib` directory.

By referring this class with the fully qualified class name in a class mediator in the API as below, we can execute it in the insequence or outsequence of the API globally or per API as described above.


```xml
<class name="samples.mediators.SimpleClassMediator">                
    <property name="propertyName" value="propertyValue"/>
    ....
</class>
```

If any properties are specified in the java class of the class mediator, the corresponding setter methods are invoked once in the class during initialization.

!!! note
    You can use the Class mediator for user-specific, custom developments only when there is no built-in mediator that already provides the required functionality because maintaining custom classes incurs a high overhead. Therefore, avoid using them unless the scenario is frequently re-used and very user-specific.

!!! warning
    Your class mediator might not be picked up and updated if you use an existing package when creating it.