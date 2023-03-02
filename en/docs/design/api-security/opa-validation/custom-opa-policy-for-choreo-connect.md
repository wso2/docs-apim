
# Custom OPA Policy for Choreo Connect

Following contains the steps that you required to follow to create a custom OPA policy by creating you own Request Policy Generator.

1.  Create a Java project with `org.wso2.choreo.connect.enforcer.commons` dependency.
    -   For Apache Maven, use the following.
        ```xml
        <dependency>
            <groupId>org.wso2.choreo.connect</groupId>
            <artifactId>org.wso2.choreo.connect.enforcer.commons</artifactId>
            <version>{{choreo_connect.version}}</version>
        </dependency>
        ```

2.  Use the following interface to implement the Custom OPA Request Generator.

    ```java tab='Interface'
    package org.wso2.choreo.connect.enforcer.commons.opa;

    import org.wso2.choreo.connect.enforcer.commons.model.RequestContext;

    import java.util.Map;

    /**
    * OPA request generator interface to handle OPA policy validation payload and validation response.
    */
    public interface OPARequestGenerator {

        /**
        * Generate the OPA request payload from the provided request context and the additional Properties Map.
        *
        * @param policyName           Name of the policy validated.
        * @param rule                 Rule of the policy.
        * @param additionalParameters Advanced properties that can be used to construct the opa payload.
        * @param requestContext       Request context details to be validated.
        * @return json payload as a string be sent to the OPA server for validation.
        * @throws OPASecurityException If an authentication failure or system error occurs.
        */
        String generateRequest(String policyName, String rule, Map<String, String> additionalParameters,
                            RequestContext requestContext) throws OPASecurityException;

        /**
        * Validate the OPA response and handle request context based on the response.
        *
        * @param policyName           Name of the policy validated.
        * @param rule                 Rule of the policy.
        * @param opaResponse          OPA response to be validated.
        * @param additionalParameters Advanced properties that can be used to construct the opa payload.
        * @param requestContext       Request context details to be validated.
        * @return <code>true</code> if valid, <code>false</code> otherwise.
        * @throws OPASecurityException If an authentication failure or system error occurs.
        */
        boolean handleResponse(String policyName, String rule, String opaResponse, Map<String, String> additionalParameters,
                            RequestContext requestContext) throws OPASecurityException;
    }
    ```

    Here is the sample filter implementation that only returns request headers to OPA.

    ```java tab='Sample Implementation'
    package org.example.tests;

    import org.json.JSONException;
    import org.json.JSONObject;
    import org.wso2.choreo.connect.enforcer.commons.model.RequestContext;
    import org.wso2.choreo.connect.enforcer.commons.opa.OPARequestGenerator;
    import org.wso2.choreo.connect.enforcer.commons.opa.OPASecurityException;

    public class CustomOPARequestGenerator implements OPARequestGenerator {
        @Override
        String generateRequest(String policyName, String rule, Map<String, String> additionalParameters,
                            RequestContext requestContext) throws OPASecurityException {
            JSONObject requestPayload = new JSONObject();
            JSONObject inputPayload = new JSONObject();
            requestPayload.put("input", inputPayload);

            inputPayload.put("headers", requestContext.getHeaders());
            return requestPayload.toString();
        }

        @Override
        boolean handleResponse(String policyName, String rule, String opaResponse, Map<String, String> additionalParameters,
                            RequestContext requestContext) throws OPASecurityException {
            JSONObject response = new JSONObject(opaResponse);
            try {
                return response.getBoolean("result");
            } catch (JSONException e) {
                throw new OPASecurityException(500, "Internal Server Error",
                        "Error while evaluating remote authorization response", e);
            }
        }
    }
    ```

3.  3.  Provide the OPARequestGenerator provider configuration.
    Choreo Connect uses Java SPI (Service Provider Interface) for loading the request generator implementation. Hence, you need to provide the provider configuration file `META-INF/services/org.wso2.choreo.connect.enforcer.commons.opa.OPARequestGenerator`. 
     
    If you are using Apache Maven, create the file inside the `<PROJECT>/src/main/resources` directory. Add the qualified class name of the OPARequestGenerator implementation as the content of the file. For example:
    
    ```text
    org.example.tests.CustomOPARequestGenerator
    ```

4.  Build the project and create the JAR file. For Apache Maven, use the following command.
    ```bash
    mvn clean install
    ```

5.  Mount the JAR file containing the Custom OPA Request Generator to the `/home/wso2/lib/dropins` folder, which is the extension point of the enforcer.

    If you are using the docker-compose file within the distribution, then add the JAR file to `docker-compose/resources/enforcer/dropins` directory.
