# FHIR Connector Reference

The FHIR Connector allows you to work with resources in [FHIR](http://www.hl7.org/fhir/index.html), which are the modular components of FHIR. The connector uses the [FHIR RESTFul API](http://www.hl7.org/fhir/http.html)  to interact with FHIR.

## Initializing the connector

Before you start performing various operations with the connector, make sure to import the FHIR certificate to your ESB client keystore.

To use the FHIR connector, add the  <fhir.init>  element in your configuration before carrying out any other FHIR operations.

For more information on authentication/security of the FHIR REST API, see http://www.hl7.org/implement/standards/fhir/security.html.

??? note "fhir.init"
    The fhir.init operation initializes the connector to interact with the FHIR REST API.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The service root URL.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.init>
        <base>{$ctx:base}</base>
    <fhir.init>
    ```

---

### Conformance

??? note "getConformance"
    The conformance interaction retrieves the server's conformance statement that defines how it supports resources. The conformance interaction retrieves the server's conformance statement that defines how it supports resources, For that use fhir.getConformance and specify the following properties. For more information, see [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#conformance).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <th>format</th>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>id, content, lastUpdated, profile, query, security, tag, text, filter</td>
            <td>These are the optional parameters and are common search parameters for all resources.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.getConformance>
        <base>{$ctx:base}</base>
        <format>{$ctx:format}</format>
        <id>{$ctx:id}</id>
        <content>{$ctx:content}</content>
        <lastUpdated>{$ctx:lastUpdated}</lastUpdated>
        <profile>{$ctx:profile}</profile>
        <query>{$ctx:query}</query>
        <security>{$ctx:security}</security>
        <tag>{$ctx:tag}</tag>
        <text>{$ctx:text}</text>
        <filter>{$ctx:filter}</filter>
    </fhir.getConformance>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "format": "json",
        "id":"%s(id)",
        "content":"%s(content)",
        "lastUpdated":"%s(lastUpdated)",
        "profile":"%s(profile)",
        "query":"%s(query)",
        "security":"%s(security)",
        "tag":"%s(tag)",
        "text":"%s(text)",
        "filter":"%s(filter)"
    }
    ```

### Resources

??? note "create"
    To creates a new resource in a server-assigned location, use fhir.create and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#create).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.create>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <format>{$ctx:format}</format>
    </fhir.create>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "format": "json"
    }
    ```

??? note "update"
    To create a new current version for an existing resource or create an initial version if no resource already exists for the given id, use fhir.update and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#update).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>idToUpdate</td>
            <td>The element of a particular resource. If no id element is provided, or the value is wrong, the server SHALL respond with a HTTP 400 error code, and SHOULD provide an operation outcome identifying the issue.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.update>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <idToUpdate>{$ctx:idToUpdate}</idToUpdate>
        <format>{$ctx:format}</format>
    </fhir.update>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "idToUpdate":"1032702",
        "format": "json"
    }
    ```

??? note "conditionalUpdate"
    The conditional update interaction allows a client to update an existing resource based on some identification criteria, rather than by logical id, For this use fhir.conditionalUpdate and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#update).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>id, content, lastUpdated, profile, query, security, tag, text, filter</td>
            <td>These are the optional parameters and are common search parameters for all resources.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.conditionalUpdate>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <format>{$ctx:format}</format>
        <id>{$ctx:id}</id>
        <content>{$ctx:content}</content>
        <lastUpdated>{$ctx:lastUpdated}</lastUpdated>
        <profile>{$ctx:profile}</profile>
        <query>{$ctx:query}</query>
        <security>{$ctx:security}</security>
        <tag>{$ctx:tag}</tag>
        <text>{$ctx:text}</text>
        <filter>{$ctx:filter}</filter>
    </fhir.conditionalUpdate>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "format": "json",
        "id":"%s(id)",
        "content":"%s(content)",
        "lastUpdated":"%s(lastUpdated)",
        "profile":"%s(profile)",
        "query":"%s(query)",
        "security":"%s(security)",
        "tag":"%s(tag)",
        "text":"%s(text)",
        "filter":"%s(filter)"
    }
    ```

??? note "delete"
    To removes an existing resource, use fhir.delete and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#delete).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>idToUpdate</td>
            <td>The element of a particular resource. If no id element is provided, or the value is wrong, the server SHALL respond with a HTTP 400 error code, and SHOULD provide an operation outcome identifying the issue.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.delete>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <idToDelete>{$ctx:idToDelete}</idToDelete>
    </fhir.delete>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "idToDelete":"1032782",
        "format": "json"
    }
    ```

??? note "conditionalDelete"
    The conditional delete interaction allows a client to delete an existing resource based on some selection criteria, rather than by a specific logical id, For this use fhir.conditionalDelete and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#delete).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>id, content, lastUpdated, profile, query, security, tag, text, filter</td>
            <td>These are the optional parameters and are common search parameters for all resources.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.conditionalDelete>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <format>{$ctx:format}</format>
        <id>{$ctx:id}</id>
        <content>{$ctx:content}</content>
        <lastUpdated>{$ctx:lastUpdated}</lastUpdated>
        <profile>{$ctx:profile}</profile>
        <query>{$ctx:query}</query>
        <security>{$ctx:security}</security>
        <tag>{$ctx:tag}</tag>
        <text>{$ctx:text}</text>
        <filter>{$ctx:filter}</filter>
    </fhir.conditionalDelete>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "format": "json",
        "id":"%s(id)",
        "content":"%s(content)",
        "lastUpdated":"%s(lastUpdated)",
        "profile":"%s(profile)",
        "query":"%s(query)",
        "security":"%s(security)",
        "tag":"%s(tag)",
        "text":"%s(text)",
        "filter":"%s(filter)"
    }
    ```

??? note "readResource"
    To accesses the current contents of a resource, use fhir.readResource and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#read).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.readResource>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <format>{$ctx:format}</format>
    </fhir.readResource>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "format": "json"
    }
    ```

??? note "readSpecificResourceById"
    To accesses the current contents of a resource, use fhir.readSpecificResourceById and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#read).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>id</td>
            <td>The possible values for the logical Id.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>summary</td>
            <td>The search parameter _summary can be used when reading a resource. It can have the values true, false, text & data.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.readSpecificResourceById>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <id>{$ctx:id}</id>
        <format>{$ctx:format}</format>
        <summary>{$ctx:summary}</summary> 
    </fhir.readSpecificResourceById>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "id":"1032702",
        "format": "json",
        "summary": "true"
    }
    ```

??? note "vReadResource"
    To preforms a version specific read of the resource, use fhir.vReadResource and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#vread).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>logicalId</td>
            <td>The possible values for the logical Id.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>versionId</td>
            <td>The Version Id ("vid") is an opaque identifier that conforms to the same format requirements as a Logical Id.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.vReadResource>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <logicalId>{$ctx:logicalId}</logicalId>
        <versionId>{$ctx:versionId}</versionId>
        <format>{$ctx:format}</format>
    </fhir.vReadResource>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "logicalId":"1032702",
        "versionId":"107748",
        "format": "json"
    }
    ```

### History

??? note "history"
    To retrieves the history of a particular resource supported by the system , use fhir.history and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#history).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>idForHistory</td>
            <td>The id of the history that needs to be retrieved.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>id, content, lastUpdated, profile, query, security, tag, text, filter</td>
            <td>These are the optional parameters and are common search parameters for all resources.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.history>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <idForHistory>{$ctx:idForHistory}</idForHistory>
        <format>{$ctx:format}</format>
        <id>{$ctx:id}</id>
        <content>{$ctx:content}</content>
        <lastUpdated>{$ctx:lastUpdated}</lastUpdated>
        <profile>{$ctx:profile}</profile>
        <query>{$ctx:query}</query>
        <security>{$ctx:security}</security>
        <tag>{$ctx:tag}</tag>
        <text>{$ctx:text}</text>
        <filter>{$ctx:filter}</filter>
    </fhir.history>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "idForHistory":1032702",
        "format": "json",
        "id":"%s(id)",
        "content":"%s(content)",
        "lastUpdated":"%s(lastUpdated)",
        "profile":"%s(profile)",
        "query":"%s(query)",
        "security":"%s(security)",
        "tag":"%s(tag)",
        "text":"%s(text)",
        "filter":"%s(filter)"
    }
    ```

??? note "historyAll"
    To retrieves the history of all resources supported by the system , use fhir.historyAll and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#history).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>id, content, lastUpdated, profile, query, security, tag, text, filter</td>
            <td>These are the optional parameters and are common search parameters for all resources.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.historyAll>
        <base>{$ctx:base}</base>
        <format>{$ctx:format}</format>
        <id>{$ctx:id}</id>
        <content>{$ctx:content}</content>
        <lastUpdated>{$ctx:lastUpdated}</lastUpdated>
        <profile>{$ctx:profile}</profile>
        <query>{$ctx:query}</query>
        <security>{$ctx:security}</security>
        <tag>{$ctx:tag}</tag>
        <text>{$ctx:text}</text>
        <filter>{$ctx:filter}</filter>
    </fhir.historyAll>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "format": "json",
        "id":"%s(id)",
        "content":"%s(content)",
        "lastUpdated":"%s(lastUpdated)",
        "profile":"%s(profile)",
        "query":"%s(query)",
        "security":"%s(security)",
        "tag":"%s(tag)",
        "text":"%s(text)",
        "filter":"%s(filter)"
    }
    ```

??? note "historyType"
    To retrieves the history of all resources of a given type supported by the system , use fhir.historyType and specify the following properties. For more information, see related [FHIR API documentation](http://www.hl7.org/implement/standards/fhir/http.html#history).
    <table>
        <tr>
            <th>Parameter Name</td>
            <th>Description</td>
            <th>Required</td>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>id, content, lastUpdated, profile, query, security, tag, text, filter</td>
            <td>These are the optional parameters and are common search parameters for all resources.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.historyType>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <format>{$ctx:format}</format>
        <id>{$ctx:id}</id>
        <content>{$ctx:content}</content>
        <lastUpdated>{$ctx:lastUpdated}</lastUpdated>
        <profile>{$ctx:profile}</profile>
        <query>{$ctx:query}</query>
        <security>{$ctx:security}</security>
        <tag>{$ctx:tag}</tag>
        <text>{$ctx:text}</text>
        <filter>{$ctx:filter}</filter>
    </fhir.historyType>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type":"Patient"
        "format": "json",
        "id":"%s(id)",
        "content":"%s(content)",
        "lastUpdated":"%s(lastUpdated)",
        "profile":"%s(profile)",
        "query":"%s(query)",
        "security":"%s(security)",
        "tag":"%s(tag)",
        "text":"%s(text)",
        "filter":"%s(filter)"
    }
    ```

### Search

??? note "search"
    To search from a particular resource supported by the system , use fhir.search and specify the following properties. For more information, see related [FHIR API documentation on search operation](http://www.hl7.org/implement/standards/fhir/http.html#search) and [filter operation](http://www.hl7.org/implement/standards/fhir/search.html#filter).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>id, content, lastUpdated, profile, query, security, tag, text, filter</td>
            <td>These are the optional parameters and are common search parameters for all resources.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.search>
        <base>{$ctx:base}</base>
        <type>{$ctx:type}</type>
        <format>{$ctx:format}</format>
        <id>{$ctx:id}</id>
        <content>{$ctx:content}</content>
        <lastUpdated>{$ctx:lastUpdated}</lastUpdated>
        <profile>{$ctx:profile}</profile>
        <query>{$ctx:query}</query>
        <security>{$ctx:security}</security>
        <tag>{$ctx:tag}</tag>
        <text>{$ctx:text}</text>
        <filter>{$ctx:filter}</filter>
    </fhir.search>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "format": "json",
        "id":"%s(id)",
        "content":"%s(content)",
        "lastUpdated":"%s(lastUpdated)",
        "profile":"%s(profile)",
        "query":"%s(query)",
        "security":"%s(security)",
        "tag":"%s(tag)",
        "text":"%s(text)",
        "filter":"%s(filter)"
    }
    ```

??? note "searchPost"
    To search from a particular resource supported by the system , use fhir.searchPost and specify the following properties. For more information, see related [FHIR API documentation on the search operation](http://www.hl7.org/implement/standards/fhir/http.html#search).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>base</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#root">service root URL</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The name of a resource type (e.g., "Patient").</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="http://www.hl7.org/implement/standards/fhir/http.html#mime-type">Mime Type</a>.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>id, content, lastUpdated, profile, query, security, tag, text, filter</td>
            <td>These are the optional parameters and are common search parameters for all resources.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <fhir.historyAll>
        <base>{$ctx:base}</base>
        <format>{$ctx:format}</format>
        <id>{$ctx:id}</id>
        <content>{$ctx:content}</content>
        <lastUpdated>{$ctx:lastUpdated}</lastUpdated>
        <profile>{$ctx:profile}</profile>
        <query>{$ctx:query}</query>
        <security>{$ctx:security}</security>
        <tag>{$ctx:tag}</tag>
        <text>{$ctx:text}</text>
        <filter>{$ctx:filter}</filter>
    </fhir.historyAll>
    ```

    **Sample request**

    ```json
    {
        "base": "https://open-api.fhir.me",
        "type": "Patient",
        "format": "json",
        "id":"%s(id)",
        "content":"%s(content)",
        "lastUpdated":"%s(lastUpdated)",
        "profile":"%s(profile)",
        "query":"%s(query)",
        "security":"%s(security)",
        "tag":"%s(tag)",
        "text":"%s(text)",
        "filter":"%s(filter)"
    }
    ```