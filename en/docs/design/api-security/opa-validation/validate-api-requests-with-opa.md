# Validate API Request with Open Policy Agent (OPA)

The [Open Policy Agent (OPA)](https://openpolicyagent.org/) is an open source, general-purpose policy engine that unifies policy enforcement. 
In WSO2 API manager, you can offload some responsibility of making the decision to authorize or not when a consumer invokes APIs based on policies attached to APIs.

WSO2 API Manager uses OPA’s policy evaluation REST API interface to communicate with OPA. Following diagram describes the request/response of OPA validation.

<a href="{{base_path}}/assets/img/design/security/opa/opa-policy-arachitecture.png">
    <img src="{{base_path}}/assets/img/design/security/opa/opa-policy-arachitecture.png" alt="OPA request flow" width="60%"/>
</a>                                                                                                                           |

## Attaching an OPA Policy to an API Resource

By attaching an OPA policy to the API Resource you can enforce OPA validation to that API resource with providing the following values in the policy.

| Name              | Description                                             | Sample                          |
|-------------------|---------------------------------------------------------|---------------------------------|
| Server URL        | URL of the OPA Server                                   | `http://localhost:8181/v1/data` |
| Policy            | Name of the policy                                      | `abc-policy`                    |
| Rule              | Name of the rule                                        | `xyz-rule`                      |
| Access Token      | **Optional** access token for OPA server authentication | `my-secret-token`               |

<!-- // TODO: (renuka) link configuring OPA from APIM (still not in 410-alpha) when APIM docs available -->

## Defining Policies in the OPA Server

You can define your own policy enforcement logic in OPA by using the values provided by the Choreo Connect Enforcer. The following is a sample policy definition in **Rego** to check the header value. `x-abcd` should be `ABCD` when HTTP method is `PUT`, otherwise HTTP method can be `POST`.

```rego tab='Sample'
package abc.authz

default allow = false
allow {
    input.method == "PUT"
    input.transportHeaders.x-abcd == "ABCD"
}
allow {
    input.method == "POST"
}
```

### Request Payload to the OPA server

By default Choreo Connect uses the class **OPADefaultRequestGenerator** to generate the request payload to the OPA server. You can configure your policies in OPA server based on the following request format.

!!! Info
    You can have your own **Request Generator Implementation**, you can do so by implementing the interface **OPARequestGenerator**. [Custom OPA Policy with Custom Request Generator](#custom-opa-policy-with-custom-request-generator) in this document describes it in more details.

<!-- TODO: link java src for interface and default class. -->

```json tab='Format'
{
    "input": {
        "path": "<full_path>",
        "vhost": "<VIRTUAL_HOST>",
        "apiName": "<API_name>",
        "apiVersion": "<API_version>",
        "httpVersion": "<HTTP_version>",
        "transportHeaders": {"<HeaderKey>":"<HeaderValue>"},
        "method": "<HTTP_method>",
        "authenticationContext": {
            "tokenType": "<one of [API Key|JWT|Internal Key]>",
            "keyType": "one of [PRODUCTION|SANDBOX]",
            "token": "<raw_auth_token>"
        },
        "requestOrigin": "<client_IP>",
        "pathTemplate": "<resource_template_in_OAS_definition",
        "prodClusterName": "<production_endpoint_cluster_name>",
        "sandClusterName": "<sandbox_endpoint_cluster_name>",
        "orgId": "<organization_ID>"
    }
}
```

```json tab='Sample'
{
    "input": {
        "path": "/t/foo.com/v2/1.0.5/foo?hello=world",
        "vhost": "localhost",
        "apiName": "SwaggerPetstore",
        "apiVersion": "1.0.5",
        "httpVersion": "HTTP/1.1",
        "transportHeaders": {
            "authorization": "Bearer eyJ0eXAiOiJKV1QiLC...",
            "x-request-id": "bc1fd847-0a33-45ab-9911-fcdd3f2f77ec",
            "content-length": "17",
            ":method": "POST",
            "x-forwarded-proto": "https",
            ":scheme": "https",
            "foo": "bar",
            ":path": "/t/foo.com/v2/1.0.5/foo?hello=world",
            "content-type": "application/x-www-form-urlencoded",
            ":authority": "localhost:9095",
            "user-agent": "curl/7.77.0",
            "accept": "application/json"
        },
        "method": "POST",
        "authenticationContext": {
            "tokenType": "JWT",
            "keyType": "PRODUCTION",
            "token": "eyJ0eXAiOiJKV1QiLC..."
        },
        "requestOrigin": "172.19.0.1",
        "pathTemplate": "/foo",
        "prodClusterName": "carbon.super_clusterProd_localhost_SwaggerPetstore1.0.5",
        "orgId": "carbon.super"
    }
}
```

### Response Payload from the OPA server

Similar to the request generation Choreo Connect uses the **OPADefaultRequestGenerator**  class to validate the response from OPA. When using the default implementation, you have to write your OPA policies using the following response format.

!!! note
    If required, you can have your own **Response Valiation Implementation** by implementing the interface **OPARequestGenerator**. For more information, see [Custom OPA Policy with Custom Request Generator](#custom-opa-policy-with-custom-request-generator).

```json tab='Format'
{
    "result": <BOOLEAN_POLICY_RESULT>
}
```

```json tab='Sample'
{
    "result": true
}
```

## Custom OPA Policy with Custom Request Generator

1.  Create a Java project with `org.wso2.choreo.connect.enforcer.commons` dependency.
    -   For Apache Maven, use the following.
        ```xml
        <dependency>
            <groupId>org.wso2.choreo.connect</groupId>
            <artifactId>org.wso2.choreo.connect.enforcer.commons</artifactId>
            <version>1.1.0</version>
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

3.  Since we use Java SPI (Service Provider Interface), we need to provide the provider configuration file `META-INF/services/org.wso2.choreo.connect.enforcer.commons.opa.OPARequestGenerator`. If you are using Apache Maven, create the file inside the `<PROJECT>/src/main/resources` directory. The content of the file needs to be the qualified class name of the filter implementation. For example:
    ```text
    org.example.tests.CustomOPARequestGenerator
    ```

4.  Build the project and create the JAR file. For Apache Maven, use the following command.
    ```bash
    mvn clean install
    ```

5.  Mount the JAR file containing the Custom OPA Request Generator to the `/home/wso2/lib/dropins` folder. 

    If you are using the docker-compose file within the distribution, then add the JAR file to `docker-compose/resources/enforcer/dropins` directory.

<!-- TODO: (renuka) should add how to add custom policy after APIM publisher UI supports adding Choreo Connect policies -->