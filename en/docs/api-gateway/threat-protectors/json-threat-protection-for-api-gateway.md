# JSON Threat Protection for Universal Gateway

The JSON threat protector in WSO2 API Manager validates the request body of the JSON message based on pre-configured to 
thwart payload attacks.

### Detecting vulnerabilities before parsing the message

The json\_validator sequence specifies the properties to be limited in the payload. A sample json\_validator sequence 
is given below.

``` xml
<sequence xmlns="http://ws.apache.org/ns/synapse" name="json_validator">
    <log level="custom">
        <property name="IN_MESSAGE" value="json_validator"/>
    </log>
    <property name="maxPropertyCount"  value = "100"/>
    <property name="maxStringLength"  value = "100"/>
    <property name="maxArrayElementCount"  value = "100"/>
    <property name="maxKeyLength"  value = "100"/>
    <property name="maxJsonDepth"  value = "100"/>
    <property name="RequestMessageBufferSize" value="1024"/>
    <class name="org.wso2.carbon.apimgt.gateway.mediators.JsonSchemaValidator"/>
</sequence>
```

| Property                 | Default Value | Description                            |
|--------------------------|---------------|----------------------------------------|
| maxPropertyCount         | 100           | Maximum number of properties           |
| maxStringLength          | 100           | Maximum length of string               |
| maxArrayElementCount     | 100           | Maximum number of elements in an array |
| maxKeyLength             | 100           | Maximum number length of key           |
| maxJsonDepth             | 100           | Maximum length of JSON                 |

### Editing the sequence through registry artifacts

To edit the existing sequence follow the steps below.

1. Go to **Policies** section in the Publisher Portal.
2. Add a new policy with the name **JSON Validator** and provide an newer version.
3. Upload the Policy File with the required changes.
4. Click **Save** to save the newer version of the policy.
5. Apply the newly created policy to the API as per the below section.

### Applying the JSON validator policy

You can apply the predefined JSON Policy through the UI. Follow the instructions below to apply the json\_validator 
in sequence.

1. Create an API or edit an existing API.
2. Go to **Policies** under the **API Configuration** sub-section from the left hand panel.
3. As required, drag and drop the **JSON Validator** from the Policy List tab into Request Flow.
4. Provide the required parameters for JSON validation.

    <a href="{{base_path}}/assets/img/learn/mediation-json-validator.png"><img src="{{base_path}}/assets/img/learn/mediation-json-validator.png" width="70%" alt="Drag and drop the JSON Validator from the policy list"></a> 
    
4. Scroll down the page and click **Save** to save the changes (click **Save and Deploy** and deploy the API for the changes to take effect in the gateways).

### Testing the JSON threat protector

You can edit the sequence to set the property values according to your requirements. A sample request and response for 
each property value set to 5 is given below.

Note that this exceeds the JSON property count

=== "Request"
    ``` java
    The request message:
    curl -X POST "https://localhost:8243/jsonpolicy/1.0.0/addpayload" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer b227d70b-ca56-3439-8698-ffb90345e1b5" -d "{ \"glossary\": \"value\" \"GlossSee\": \"markup\" }"
    ```

=== "Response"
    ``` xml
    <am:fault xmlns:am="http://wso2.org/apimanager">
        <am:code>400</am:code>
        <am:message>Bad Request</am:message>
        <am:description>Request is failed due to JSON schema validation failure:  Max Key Length Reached</am:description>
    </am:fault>
    ```

!!! warning
    **Performance impact**  
    The JSON schema mediator builds the message at the mediation level. This impacts the performance of 10KB messages 
    for 300 concurrent users by 5.2 times than the normal flow.


