# Am300XML Threat Protection for API Gateway

The XML threat protector in WSO2 API Manager validates the XML payload vulnerabilities based on the pre-configured limits. It uses following methodologies to thwart the gateway from XML based attacks.

-   [Detecting the malformed, vulnerable XML messages through limitations](#Am300XMLThreatProtectionforAPIGateway-detectvulnerability)

-   [XML schema validation](#Am300XMLThreatProtectionforAPIGateway-XMLSchemaValidation)

#### Detecting the malformed, vulnerable XML messages through limitations

The xml\_validator sequence specifies the properties to be limited in the payload. A sample xml\_validator sequence is given below.

``` java
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="xml_validator">
        <log level="custom">
            <property name="IN_MESSAGE" value="xml_validator"/>
        </log>
        <property name="xmlValidation" value="true"/>
        <property name="dtdEnabled" value="false"/>
        <property name="externalEntitiesEnabled" value="true"/>
        <property name="maxXMLDepth" value="100"/>
        <property name="maxElementCount" value="100"/>
        <property name="maxAttributeCount" value="100"/>
        <property name="maxAttributeLength" value="100"/>
        <property name="entityExpansionLimit" value="100"/>
        <property name="maxChildrenPerElement" value="100"/>
        <property name="entityExpansionLimit" value="100"/>
        <property name="schemaValidation" value="true"/>
        <switch source="get-property('To')">
            <case regex=".*/addResource.*">
                <property name="xsdURL" value="<Insert the XSD URL>"/>
            </case>
            <!--<case regex=".*/update.*">-->
                <!--<property name="xsdURL" value="<insert XSD_URL>"/>-->
            <!--</case>-->
            <!--<case regex=".*/delete.*">-->
                <!--<property name="xsdURL" value="<insert XSD_URL>d"/>-->
            <!--</case>-->
        </switch>
        <property name="RequestMessageBufferSize" value="1024"/>
        <class name="org.wso2.carbon.apimgt.gateway.mediators.XMLSchemaValidator"/>
    </sequence>
```

Users can enable or disable XML payload limits and schema validation. Some examples are shown below.

-   [**Disabling the XML payload validation**](#b95bd611fb2144d0940b193f34addf5b)
-   [**Disabling the XML schema validation**](#70c795c618f04f2cb9983858b263298d)

``` java
    <property name="xmlValidation" value="false"/>
```

``` java
    <property name="schemaValidation" value="false"/>
```

##### XML payload validation properties

-   Disable the DTD payload in the XML properties to avoid attacks

-   You can turn on/off external entities of the payload. An example is given below with the elements of the XML request body, that can be configured .

    <table>
    <thead>
    <tr class="header">
    <th>Property</th>
    <th>Default Value</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><pre><code>dtdEnabled</code></pre></td>
    <td><code>               false              </code></td>
    <td><p>The DTD can be enabled/disabled according to your requirement.</p></td>
    </tr>
    <tr class="even">
    <td><code>               externalEntitiesEnabled              </code></td>
    <td><code>               true              </code></td>
    <td><br />
    </td>
    </tr>
    <tr class="odd">
    <td><pre><code>maxXMLDepth</code></pre></td>
    <td><code>               100              </code></td>
    <td>Maximum depth of the XML request message.</td>
    </tr>
    <tr class="even">
    <td><pre><code>maxElementCount</code></pre></td>
    <td><code>               100              </code></td>
    <td>Maximum number of allowed elements in the XML request message.</td>
    </tr>
    <tr class="odd">
    <td><pre><code>maxAttributeCount</code></pre></td>
    <td><code>               100              </code></td>
    <td>Maximum count of allowed attributes in the XML request message.</td>
    </tr>
    <tr class="even">
    <td><pre><code>maxAttributeLength</code></pre></td>
    <td><code>               100              </code></td>
    <td>Maximum allowed length of each attribute value in characters.</td>
    </tr>
    <tr class="odd">
    <td><pre><code>entityExpansionLimit</code></pre></td>
    <td><code>               100              </code></td>
    <td>Maximum allowed entity expansion limit of the XML request message.</td>
    </tr>
    <tr class="even">
    <td><pre><code>maxChildrenPerElement</code></pre></td>
    <td><code>               100              </code></td>
    <td>Maximum number of child elements allowed in the XML request message.</td>
    </tr>
    </tbody>
    </table>

#### XML schema validation

You can define XML schemas per resource to validate each request. For example, to add an XML schema to the resource /userapi/1.0.0/addResource/value follow the steps below.

1.  Define the resource in the case regex
2.  Define the relevant schema URL and add it as shown below.
3.  You can define the buffer size of the request message depending on your requirement. An example is given below.

Each request is sanitized through the XML threat protector. API developer can modify each properties according to your requirement.

-   [Editing the sequence through registry artifacts](#Am300XMLThreatProtectionforAPIGateway-Editingthesequencethroughregistryartifacts)
-   [Applying the XML validator policy](#Am300XMLThreatProtectionforAPIGateway-ApplyingtheXMLvalidatorpolicy)
-   [Testing the XML threat protector](#Am300XMLThreatProtectionforAPIGateway-TestingtheXMLthreatprotector)
-   [Testing the schema validation](#Am300XMLThreatProtectionforAPIGateway-Testingtheschemavalidation)

### Editing the sequence through registry artifacts

To edit the existing sequence follow the steps below.

1.  Log in to the Management Console.
2.  Navigate to `/_system/governance/apimgt/customsequences/in/xml_validator.xml`
3.  Edit the `xml_validator.xml` file.
4.  Go to the API Publisher and re-publish your API for the changes to take effect.

### Applying the XML validator policy

You can apply the pre-defined XML Policy through the UI. Follow the instructions below to apply the xml\_validator in sequence.

-   Create an API or edit an existing API.

-   Go to **Message Mediation** Policies under the **Implement** tab.

-   Select **Enable Message Mediation** . Select xml\_validator from the drop-down menu for In Flow.
    ![]({{base_path}}/assets/attachments/126559467/126559468.png)
-   Click **Save and Publish** to save the changes.

### Testing the XML threat protector

You can edit the sequence to set the property values according to your requirements. A sample request and response for the value of the properties set to 30 is given below. Note that the .xsd URL for the relevant resource has been hosted.

-   [**Request**](#389c50828aa24292b0657e037c09c635)
-   [**Response**](#159d32ca825c41a480037880ce2e6413)

``` java
    curl -X POST "https://192.168.8.101:8243/xmlPolicy/1.0.0/addResource" -H "accept: application/json" -H "Content-Type: application/xml" -H "Authorization: Bearer 2901c002-f626-372c-9be3-fc54b2c8d65f" -d "<?xml version=\"1.0\"?><inline_model> <Name>string</Name> <Age>string</Age> <Address>string</Address> <phone>string</phone> <home>string</home> <path>string</path> <class>string</class> <team>string</team> <location>string</location> <brand>string</brand> <summary>string</summary> <data>string</data> <Name>string</Name> <Age>string</Age> <Address>string</Address> <phone>string</phone> <home>string</home> <path>string</path> <class>string</class> <team>string</team> <location>string</location> <brand>string</brand> <summary>string</summary> <data>string</data> <Name>string</Name> <Age>string</Age> <Address>string</Address> <phone>string</phone> <home>string</home> <path>string</path> <class>string</class> <team>string</team> <location>string</location> <brand>string</brand> <summary>string</summary> <data>string</data> <Name>string</Name> <Age>string</Age> <Address>string</Address> <phone>string</phone> <home>string</home> <path>string</path> <class>string</class> <team>string</team> <location>string</location> <brand>string</brand> <summary>string</summary> <data>string</data></inline_model>"
```

``` java
    <am:fault xmlns:am="http://wso2.org/apimanager">
      <am:code>400</am:code>
      <am:message>Bad Request</am:message>
      <am:description>XML Validation Failed: due to Maximum Element Count limit (30) Exceeded</am:description>
    </am:fault>
```

### Testing the schema validation

A sample request and response to test the schema validation is given below.

-   [**Request**](#45b87273c80b44ffb18a3f8fe4f5b8f6)
-   [**Response**](#194a5a4652e94e609d80ba175c16b449)
-   [**.xsd URL**](#db80409dd4d941dc972837213bc340e5)

``` java
    curl -X POST "https://192.168.8.101:8243/xmlPolicy/1.0.0/addResource" -H "accept: application/json" -H "Content-Type: application/xml" -H "Authorization: Bearer 2901c002-f626-372c-9be3-fc54b2c8d65f" -d "<?xml version=\"1.0\"?><inline_model> <location>string</location> <brand>string</brand> <summary>string</summary> <data>string</data> <Name>string</Name> <Age>string</Age> <Address>string</Address> <phone>string</phone> <home>string</home> <path>string</path> <class>string</class> <team>string</team> <location>string</location> <brand>string</brand> <summary>string</summary> <data>string</data> <Name>string</Name> <Age>string</Age> <Address>string</Address> <phone>string</phone> <home>string</home> <path>string</path> <class>string</class> <team>string</team> <location>string</location> <brand>string</brand> <summary>string</summary> <data>string</data></inline_model>"
```

``` java
    <am:fault xmlns:am="http://wso2.org/apimanager">
      <am:code>400</am:code>
      <am:message>Bad Request</am:message>
      <am:description>Error occurred while parsing XML payload : org.xml.sax.SAXParseException: cvc-elt.1: Cannot find the declaration of element 'inline_model'.</am:description>
    </am:fault>
```

``` java
    <?xml version="1.0" encoding="UTF-8" ?>
    <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:simpleType name="stringtype">
  <xs:restriction base="xs:string"/>
</xs:simpleType>

<xs:simpleType name="inttype">
  <xs:restriction base="xs:positiveInteger"/>
</xs:simpleType>

<xs:simpleType name="dectype">
  <xs:restriction base="xs:decimal"/>
</xs:simpleType>

<xs:simpleType name="orderidtype">
  <xs:restriction base="xs:string">
    <xs:pattern value="[0-9]{6}"/>
  </xs:restriction>
</xs:simpleType>

<xs:complexType name="shiptotype">
  <xs:sequence>
    <xs:element name="name" type="stringtype"/>
    <xs:element name="address" type="stringtype"/>
    <xs:element name="city" type="stringtype"/>
    <xs:element name="country" type="stringtype"/>
  </xs:sequence>
</xs:complexType>

<xs:complexType name="itemtype">
  <xs:sequence>
    <xs:element name="title" type="stringtype"/>
    <xs:element name="note" type="stringtype" minOccurs="0"/>
    <xs:element name="quantity" type="inttype"/>
    <xs:element name="price" type="dectype"/>
  </xs:sequence>
</xs:complexType>

<xs:complexType name="shipordertype">
  <xs:sequence>
    <xs:element name="orderperson" type="stringtype"/>
    <xs:element name="shipto" type="shiptotype"/>
    <xs:element name="item" maxOccurs="unbounded" type="itemtype"/>
  </xs:sequence>
  <xs:attribute name="orderid" type="orderidtype" use="required"/>
</xs:complexType>

<xs:element name="shiporder" type="shipordertype"/>

</xs:schema>
```
!!! warning
Performance impact

The XML mediator builds the message at the mediator level. This impacts the performance of 10KB messages for 300 concurrent users by 5.6 times than the normal flow. The performance may slow down along with the message size.


