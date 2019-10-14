# Am300JSON Threat Protection for API Gateway

The JSON threat protector in WSO2 API Manager validates the request body of the JSON message based on pre-configured to thwart payload attacks.

-   [Editing the sequence through registry artifacts](#Am300JSONThreatProtectionforAPIGateway-Editingthesequencethroughregistryartifacts)
-   [Applying the JSON validator policy](#Am300JSONThreatProtectionforAPIGateway-ApplyingtheJSONvalidatorpolicy)
-   [Testing the JSON threat protector](#Am300JSONThreatProtectionforAPIGateway-TestingtheJSONthreatprotector)

#### Detecting vulnerabilities before parsing the message

The json\_validator sequence specifies the properties to be limited in the payload. A sample json\_validator sequence is given below.

``` java
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

1.  Log in to the Management Console.
2.  Navigate to `/_system/governance/apimgt/customsequences/in/json_validator.xml          `
3.  Edit the `json_validator.xml` file.
4.  Go to the API Publisher and re-publish your API for the changes to take effect.

### Applying the JSON validator policy

You can apply the pre-defined JSON Policy through the UI. Follow the instructions below to apply the json\_validator in sequence.

-   Create an API or edit an existing API.

-   Go to **Message Mediation** Policies under the **Implement** tab.

-   Select **Enable Message Mediation** . Select json\_validator from the drop-down menu for In Flow.
    ![]({{base_path}}/assets/attachments/126559464/126559465.png)
-   Click **Save and Publish** to save the changes.

### Testing the JSON threat protector

You can edit the sequence to set the property values accoring to your requirements. A sample request and response for each property value set to 5 is given below.

-   [**Request**](#2fabe5e92ef64a3a999bb756d894221e)
-   [**Response**](#6da49ce3d2cf4091a885d78334d2513e)

Note that this exceeds the JSON property count

``` java
    The request message:
    curl -X POST "https://localhost:8243/jsonpolicy/1.0.0/addpayload" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer b227d70b-ca56-3439-8698-ffb90345e1b5" -d "{ \"glossary\": \"value\" \"GlossSee\": \"markup\" }"
```

``` java
    <am:fault xmlns:am="http://wso2.org/apimanager">
      <am:code>400</am:code>
      <am:message>Bad Request</am:message>
      <am:description>Request is failed due to JSON schema validation failure:  Max Key Length Reached</am:description>
    </am:fault>
```

!!! warning
Performance impact

The JSON schema mediator builds the message at the mediation level. This impacts the performance of 10KB messages for 300 concurrent users by 5.2 times than the normal flow.


