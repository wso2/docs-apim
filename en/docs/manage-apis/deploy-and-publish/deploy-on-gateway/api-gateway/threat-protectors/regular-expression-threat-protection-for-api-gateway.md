# Regular Expression Threat Protection for Universal Gateway

WSO2 API Manager provides predefined regex patterns to sanitize the request from SQL injection attacks. The attacks 
may depend on the API traffic at runtime. The API developers should identify the common attacks and select the 
appropriate restrictive measures. This feature extracts the data from XML, JSON payloads, Queryparam, URI path, headers 
and validates the content against predefined regular expressions. If any predefined regex keyword is matched with the 
content, the API request is considered as a threat and it is blocked and rejected. This secures the backend resources 
from activities that make the system vulnerable.  You can configure your own restriction patterns to thwart various 
attacks such as the following:

-   JavaScript Injection
-   Server-side Include Injection
-   XPath Injection
-   Java Exception Injection
-   XPath Abbreviated Syntax Injection

### Denying request patterns

We recommend the following patterns for denying requests.

<table>
    <thead>
        <tr class="header">
            <th>Name</th>
            <th>Patterns</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd">
            <td>SQL Injection</td>
            <td>
                <code>.*'.*|.*ALTER.*|.*ALTER TABLE.*|.*ALTER VIEW.*|</code><br />
                <code>.*CREATE DATABASE.*|.*CREATE PROCEDURE.*|.*CREATE SCHEMA.*|</code><br />
                <code>.*create table.*|.*CREATE VIEW.*|.*DELETE.*|.*DROP DATABASE.*|</code><br />
                <code>.*DROP PROCEDURE.*|.*DROP.*|.*SELECT.*</code>
            </td>
        </tr>
        <tr class="even">
            <td>Server-side Include Injection Attack</td>
            <td>
                <code>.*#include.*|.*#exec.*|.*#echo.*|.*#config.*</code>
            </td>
        </tr>
        <tr class="odd">
            <td>Java Exception Injection</td>
            <td>
                <code>.*Exception in thread.*</code>
            </td>
        </tr>
        <tr class="even">
            <td>XPath Injection</td>
            <td>
                <code>.*'.*|(?&lt;![\w\d])or(?![\w\d])|.*1=1.*|.*ALTER.*|.*ALTER TABLE.*|.*ALTER VIEW.*|</code><br />
                <code>.*CREATE DATABASE.*|.*CREATE PROCEDURE.*|.*CREATE SCHEMA.*|</code><br />
                <code>.*create table.*|.*CREATE VIEW.*|.*DELETE.*|.*DROP DATABASE.*|</code><br />
                <code>.*DROP PROCEDURE.*|.*DROP.*|.*SELECT.*</code>
            </td>
        </tr>
        <tr class="odd">
            <td>JavaScript Injection</td>
            <td><p>
                ```
                <\s*script\b[^>]*>[^<]+<\s*/\s*script\s*>
                ```
            </p></td>
        </tr>
        <tr class="even">
            <td>XPath Expanded Syntax Injection</td>
            <td><p><code>/?(ancestor(-or-self)?|descendant(-or-self)?|following(-sibling))</code></p></td>
        </tr>
    </tbody>
</table>

### Editing the sequence through registry artifacts

To edit the existing sequence follow the steps below.

1. Go to **Policies** section in the Publisher Portal.
2. Add a new policy with the name **Regex Policy** and provide an newer version.
3. Upload the Policy File with the required changes.
4. Click **Save** to save the newer version of the policy.
5. Apply the newly created policy to the API as per the below section.

### Applying the Regular Expression Policy

You can apply the predefined Regular Expression Policy through the UI. Follow the instructions below to apply the 
regex\_policy in sequence.

1. Create an API or edit an existing API.
2. Go to **Policies** under the **API Configuration** sub-section from the left hand panel.
3. As required, drag and drop the **Regex Policy** from the Policy List tab into Request Flow.

    <a href="{{base_path}}/assets/img/learn/mediation-regex-policy.png"><img src="{{base_path}}/assets/img/learn/mediation-regex-policy.png" width="70%" alt="Drag and drop the Regex Policy from the policy list"></a> 
    
4. Scroll down the page and click **Save** to save the changes (click **Save and Deploy** and deploy the API for the changes to take effect in the gateways).

Each request is sanitized through the regular expression threat protector. You can add or modify the regex patterns 
according to your requirement.

The regex\_policy sequence is given below.

``` xml
<sequence xmlns="http://ws.apache.org/ns/synapse" name="regex_policy">
    <log level="custom">
        <property name="IN_MESSAGE" value="Regular_expression_policy"/>
    </log>
    <property name="threatType" expression="get-property('threatType')" value="SQL-Injection"/>
    <property name="regex" expression="get-property('regex')" value=".*'.*|.*ALTER.*|.*ALTER TABLE.*|.*ALTER VIEW.*|
        .*CREATE DATABASE.*|.*CREATE PROCEDURE.*|.*CREATE SCHEMA.*|.*create table.*|.*CREATE VIEW.*|.*DELETE.*|.
        *DROP DATABASE.*|.*DROP PROCEDURE.*|.*DROP.*|.*SELECT.*"/>
    <property name="enabledCheckBody" expression="get-property('checkBodyEnable')" value="true"/>
    <property name="enabledCheckHeaders" expression="get-property('enabledCheckHeaders')" value="true"/>
    <property name="enabledCheckPathParams" expression="get-property('enabledCheckPathParams')" value="true"/>
    <class name="org.wso2.carbon.apimgt.gateway.mediators.RegularExpressionProtector"/>
</sequence>
```

!!! note
    If you need to validate only the request headers, you can disable the `enabledCheckBody` and 
    `enabledCheckPathParams` properties by setting the value to `false` .


### Testing the regex threat protector

You can test this feature by sending an SQL injection attack with the XML message body. The sample request and response 
is given below.

=== "Message"
    ``` xml
    <?xml version="1.0" encoding="UTF-8"?>
    <breakfast_menu>
        <food>
            <name>Homestyle Breakfast</name>
            <price>drop table</price>
            <description>
                Two eggs, bacon or sausage, toast, and our ever-popular hash browns
            </description>
            <calories>950</calories>
        </food>
    </breakfast_menu>
    ```

=== "Response"
    ``` xml
    <am:fault xmlns:am="http://wso2.org/apimanager">
        <am:code>400</am:code>
        <am:message>Bad Request</am:message>
        <am:description>SQL-Injection Threat detected in Payload</am:description>
    </am:fault>
    ```

!!! warning
    **Performance impact**  
    The regex mediator builds the entire message and performs string processing to find potentially harmful constructs 
    underneath the message body. This drops the performance of 10KB messages for 300 concurrent users by 3.6 times than 
    the normal flow. The performance decrease may accelerate along with the message size.


