
# Custom OPA Policy for Regular gateway

The instructions below contain the steps that you require to follow to create a custom OPA policy by creating your own Request Policy Generator.

1. Create a Java project with following dependencies.
    -   For Apache Maven, use the following.
        ```xml
        <dependencies>
            <dependency>
                <groupId>org.apache.synapse</groupId>
                <artifactId>synapse-extensions</artifactId>
                <version>2.1.7-wso2v270</version>
            </dependency>
            <dependency>
                <groupId>org.apache.synapse</groupId>
                <artifactId>synapse-core</artifactId>
                <version>2.1.7-wso2v270</version>
            </dependency>
            <dependency>
                <groupId>org.apache.axis2</groupId>
                <artifactId>axis2-kernel</artifactId>
                <version>1.6.1-wso2v76</version>
            </dependency>
        </dependencies>
        ```

   1. Use the following interface to implement the Custom OPA Request Generator.

       ```java tab='Interface'
       package org.apache.synapse.mediators.opa;

       import org.apache.synapse.MessageContext;
       import java.util.Map;

       /**
       * OPA request generator interface to handle OPA policy validation payload and validation response
       */
       public interface OPARequestGenerator {

        /**
          * Generate the OPA request payload from the provided message context and the additional Properties Map
          *
          * @param policyName           Name of the policy validated
          * @param rule                 The rule of the policy
          * @param additionalParameters Additional parameters that can be used to construct the opa payload
          * @param messageContext       The message to be validated with OPA server
          * @return json input as a string and this will be sent to the OPA server for validation
          * @throws OPASecurityException If an authentication failure or some other error occurs
       */
            String generateRequest(String policyName, String rule, Map<String, String> additionalParameters,
            MessageContext messageContext) throws OPASecurityException;

        /**
          * Handle the OPA response based on the implementation
          *
          * @param policyName           Name of the policy validated
          * @param rule                 The rule of the policy
          * @param opaResponse          The message to be authenticated
          * @param additionalParameters Additional parameters that can be used to handle the the opa response
          * @param messageContext       The message to be authenticated
          * @return true if the authentication is successful
          * @throws OPASecurityException If an authentication failure or some other error occurs
       */
            boolean handleResponse(String policyName, String rule, String opaResponse, Map<String, String> additionalParameters,
            MessageContext messageContext) throws OPASecurityException;

       }
       ```

       Here is the sample implementation that only returns request headers to OPA.

       ```java tab='Sample Implementation'
       package org.example.tests;

       import org.apache.synapse.MessageContext;
       import org.apache.synapse.core.axis2.Axis2MessageContext;
       import org.apache.synapse.mediators.opa.OPAConstants;
       import org.apache.synapse.mediators.opa.OPARequestGenerator;
       import org.apache.synapse.mediators.opa.OPASecurityException;
       import org.json.JSONException;
       import org.json.JSONObject;
    
       import java.util.Map;
       import java.util.TreeMap;
    
       public class CustomOPARequestGenerator implements OPARequestGenerator {
    
           @Override
           public String generateRequest(String policyName, String rule, Map<String, String> additionalParameters,
                                         MessageContext messageContext) throws OPASecurityException {
    
               org.apache.axis2.context.MessageContext axis2MessageContext = ((Axis2MessageContext) messageContext)
                       .getAxis2MessageContext();
               TreeMap<String, String> transportHeadersMap = (TreeMap<String, String>) axis2MessageContext
                       .getProperty(org.apache.axis2.context.MessageContext.TRANSPORT_HEADERS);
    
               JSONObject inputObject = new JSONObject();
               JSONObject opaPayload = new JSONObject();
               opaPayload.put(OPAConstants.REQUEST_TRANSPORT_HEADERS_KEY, new JSONObject(transportHeadersMap));
               inputObject.put(OPAConstants.INPUT_KEY, opaPayload);
               return inputObject.toString();
           }
    
           @Override
           public boolean handleResponse(String policyName, String rule, String opaResponse,
                                         Map<String, String> additionalParameters,
                                         MessageContext messageContext) throws OPASecurityException {
    
               JSONObject response = new JSONObject(opaResponse);
               try {
                   return response.getBoolean("result");
               } catch (JSONException e) {
                   throw new OPASecurityException(OPASecurityException.INTERNAL_ERROR,
                           OPASecurityException.INTERNAL_ERROR_MESSAGE, e);
               }
           }
       }
       ```

2. Build the project and create the JAR file. For Apache Maven, use the following command.
    ```bash
    mvn clean install
    ```

3. Add the JAR file containing the Custom OPA Request Generator to the `<APIM_HOME>/repository/components/libs` folder.
4. Create a new policy from the policies window with the following policy definition. Make sure that you define the policy attributes `serverUrl`, `policy` and `rule` from the create new policy form. 

    ```xml
    <opa>
        <serverUrl>{% raw %}{{serverUrl}}{% endraw %}</serverUrl>
        <policy>{% raw %}{{policy}}{% endraw %}</policy>
        <rule>{% raw %}{{rule}}{% endraw %}</rule>
        <requestGenerator>org.example.tests.CustomOPARequestGenerator</requestGenerator>
    </opa>
    ```