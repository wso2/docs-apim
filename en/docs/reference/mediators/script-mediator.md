# Script Mediator

The **Script Mediator** is used to invoke the functions of a variety of scripting languages such as JavaScript, Groovy, or Ruby.

!!! Note
    The Micro Integrator uses Rhino engine to execute JavaScripts. Rhino engine converts the script to a method inside a Java class. Therefore, when processing large JSON data volumes, the code length must be less than 65536 characters, since the Script mediator converts the payload into a Java object. However, you can use the following alternative options to process large JSON data volumes.

    -   Achieve the same functionality via a [Class mediator]({{base_path}}/reference/mediators/class-mediator) .
    -   If the original message consists of repetitive sections, you can use the [Iterate mediator]({{base_path}}/reference/mediators/iterate-mediator.md) to generate a relatively
    small payload using those repetitive sections. This will then allow you to use the Script mediator.
    -   The Script Mediator supports using Nashorn to execute JavaScripts, in addition to its default Rhino engine.

A Script mediator can be created in one of the following methods.

-   With the script program statements stored in a separate file, referenced via the **Local or Remote Registry entry**.
-   With the script program statements embedded inline within the Synapse configuration.

Synapse uses the Apache [Bean Scripting
Framework](http://jakarta.apache.org/bsf/) for scripting language
support. Any script language supported by BSF may be used to implement
the Synapse Mediator. With the Script Mediator, you can invoke a
function in the corresponding script. With these functions, it is
possible to access the Synapse predefined in a script variable named
`         mc        ` . The `         mc        ` variable represents an
implementation of the `         MessageContext        ` , named
`         ScriptMessageContext.java        ` , which contains the
following methods that can be accessed within the script as
`         mc.methodName        ` .

| Return? | Method Name                        | Description                                                                                                                                                    |
|---------|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Yes     | getPayloadXML()                    | This gets an XML representation of SOAP Body payload.                                                                                                          |
| No      | setPayloadXML(payload)             | This sets the SOAP body payload from XML.                                                                                                                      |
| No      | addHeader(mustUnderstand, content) | This adds a new SOAP header to the message.                                                                                                                    |
| Yes     | getEnvelopeXML()                   | This gets the XML representation of the complete SOAP envelope.                                                                                                |
| No      | setTo(reference)                   | This is used to set the value which specifies the receiver of the message.                                                                                     |
| Yes     | setFaultTo(reference)              | This is used to set the value which specifies the receiver of the faults relating to the message.                                                              |
| No      | setFrom(reference)                 | This is used to set the value which specifies the sender of the message.                                                                                       |
| No      | setReplyTo(reference)              | This is used to set the value which specifies the receiver of the replies to the message.                                                                      |
| Yes     | getPayloadJSON()                   | This gets the JSON representation of a SOAP Body payload.                                                                                                      |
| No      | setPayloadJSON( payload )          | This sets the JSON representation of a payload obtained via the `             getPayloadJSON()            ` method and sets it in the current message context. |
| Yes     | getProperty(name)                  | This gets a property from the current message context.                                                                                                         |
| No      | setProperty(key, value)            | This is used to set a property in the current message context. The previously set property values are replaced by this method.                                 |

Implementing a Mediator with a script language has advantages over using
the built-in Synapse Mediator types or implementing a custom Java class
Mediator. The Script Mediators have the flexibility of a class Mediator
with access to the Synapse `         MessageContext        ` and
`         SynapseEnvironment        ` APIs. Also, the ease of use and
dynamic nature of scripting languages allow the rapid development and
prototyping of custom mediators. An additional benefit of some scripting
languages is that they have very simple and elegant XML manipulation
capabilities, which make them very usable in a Synapse mediation
environment. e.g., JavaScript E4X or Ruby REXML.

For both types of script mediator definitions, the
`         MessageContext        ` passed into the script has additional
methods over the standard Synapse `         MessageContext        ` to
enable working with XML natural to the scripting language. Example are
when using JavaScript `         getPayloadXML        ` and
`         setPayloadXML        ` , `         E4X        ` XML objects
and when using Ruby, REXML documents.

!!! Info
    The Script mediator is a [content-aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Prerequisites

-   If you are using **nashornJS** as the JavaScript language, and also if you have JSON operations defined in the Script mediator, you need to have JDK version `8u112` or a later version in your environment.
    If your environment has an older JDK version, the Script mediator (that uses nashornJS and JSON operations) will not function properly because of this [JDK bug](https://bugs.openjdk.java.net/browse/JDK-8157160). That is, you will encounter server exceptions in the Micro Integrator.

-   Listed below are the prerequisites for writing a Script mediator using
JavaScript, Groovy, or Ruby.

    <table>
    <thead>
    <tr class="header">
    <th>Scripting Language</th>
    <th>Prerequisite</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Groovy</td>
    <td>Download the groovy-all <code>-2.4.4.jar</code> file and copy it to the <code>&lt;MI_HOME&gt;/</code> dropins directory. Note that when you define the script, you need to start by importing Groovy.</td>
    </tr>
    <tr class="even">
    <td>Ruby</td>
    <td><p>Install the JRuby engine for mediation. This is available in the WSO2 P2 repository as a feature (<strong>WSO2 Carbon - JRuby Engine for Mediation</strong>).</p>
    <p>Alternatively, you can download and install the JRuby engine manually: Download the <code>              jruby-complete-1.3.0.wso2v1.jar             </code> file from the WSO2 P2 repository and copy it to the <code>                             &lt;MI_HOME&gt;/              </code> dropins directory.</p></td>
    </tr>
    <tr class="odd">
    <td>JavaScript</td>
    <td>The JavaScript/E4X support is enabled by default in the Micro Integrator and ready for use.</td>
    </tr>
    </tbody>
    </table>

## Syntax

Click on the relevant tab to view the syntax for a script mediator using an Inline script, or a script mediator using a script of a registry

- **Using an Inline script**:
  The following syntax applies when you create a Script mediator with the script program statements embedded inline within the Synapse configuration.
  ```
  <script language="js"><![CDATA[...script source code...]]></script>
  ```
- **Using a script of the registry**:
  The following syntax applies when you create a Script mediator with the script program statements stored in a separate file, referenced via the Local or Remote Registry entry.

    !!! Info
        If you are creating the Registry Resource via Tooling, you need not specify the content/media type, because it gets automatically applied when you select the **JavaScript File Template** as shown below.

        ![select the JavaScript File Template]({{base_path}}/assets/img/integrate/mediators/119131139/119131140.png)

        ``` 
        <script key="string" language="js" [function="script-function-name"]>
          <include key="string"/>
        </script>
        ```

## Configuration

- **Inline**: If this script type is selected, the script is specified inline. The parameters available to configure a Script mediator using an inline script are as follows.
    <table>
    <thead>
    <tr class="header">
    <th>Parameter Name</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><strong>Language</strong></td>
    <td><p>The scripting language for the Script mediator. You can select from the following available languages.</p>
    <ul>
    <li>JavaScript - This is represented as <code>                  js                 </code> in the source view.</li>
    <li>Groovy - This is represented as <code>                  groovy                 </code> in the source view.</li>
    <li>Ruby - This is represented as <code>                  rb                 </code> in the source view.</li>
    </ul></td>
    </tr>
    <tr class="even">
    <td><strong>Source</strong></td>
    <td><div class="content-wrapper">
    <p>Enter the source in this parameter.</p>
    <p><strong>Note:</strong> If you are using Groovy as the scripting language, you need to first import Groovy in your script by adding the following:</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeContent panelContent pdl">
    <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">import</span><span class="im"> groovy.json.*;</span></span></code></pre></div>
    </div>
    </div>
    </div></td>
    </tr>
    </tbody>
    </table>

- **Registry**: If this script type is selected, a script which is already saved in the registry will be referred using a key. The parameters available to configure a Script mediator using a script saved in the registry are as follows.
    <table>
      <tr class="header">
         <th>Parameter Name</th>
         <th>Description</th>
      </tr>
      <tr class="odd">
         <td><strong>Language</strong></td>
         <td>
            <div class="content-wrapper">
               <p>The scripting language for the Script mediator. You can select from the following available languages.</p>
               <ul>
                  <li>JavaScript - This is represented as <code>                   js                  </code> in the source view.</li>
                  <li>
                     <p>Groovy - This is represented as <code>                    groovy                   </code> in the source view. <strong>Note:</strong> Be sure that your script starts with the following, which indicates that Groovy is imported:</p>
                     <div class="code panel pdl" style="border-width: 1px;">
                        <div class="codeContent panelContent pdl">
                           <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                              <pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">import</span><span class="im"> groovy.json.*;</span></span></code></pre>
                           </div>
                        </div>
                     </div>
                  </li>
                  <li>Ruby - This is represented as <code>                   rb                  </code> in the source view.</li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td><strong>Function</strong></td>
         <td>The function of the selected script language to be invoked. This is an optional parameter. If no value is specified, a default function named <code>                mediate               </code> will be applied. This function considers the Synapse MessageContext as a single parameter. The function may return a boolean. If it does not, then the value <code>                true               </code> is assumed and the Script mediator returns this value.</td>
      </tr>
      <tr class="odd">
         <td><strong>Key Type</strong></td>
         <td>
            <p>You can select one of the following options.</p>
            <ul>
               <li><strong>Static Key</strong> : If this is selected, an existing key can be selected from the registry for the <strong>Key</strong> parameter.</li>
               <li><strong>Dynamic Key</strong> : If this is selected, the key can be entered dynamically in the <strong>Key</strong> parameter.</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td><strong>Key</strong></td>
         <td>The Registry location of the source. You can click either <strong>Configuration Registry</strong> or the <strong>Governance Registry</strong> to select the source from the resource tree.</td>
      </tr>
      <tr class="odd">
         <td><strong>Include keys</strong></td>
         <td>
            <div class="content-wrapper">
               <p>This parameter allows you to include functions defined in two or more scripts your Script mediator configuration. After pointing to one script in the <strong>Key</strong> parameter, you can click <strong>Add Include</strong> <strong>Key</strong> to add the function in another script.</p>
               <p>When you click <strong>Add Include</strong> <strong>Key</strong> , the following parameters will be displayed. Enter the script to be included in the <strong>Key</strong> parameter by clicking either <strong>Configuration Registry</strong> or the <strong>Governance Registry</strong> <strong></strong> and then selecting the relevant script from the resource tree.</p>
            </div>
         </td>
      </tr>
    </table>

## Examples

### Using an inline script

The following configuration is an example of an inline mediator using `JavaScript/E4X` which returns false if the SOAP message body contains an element named `symbol`, which has a value of `IBM`.

``` java
<script language="js"><![CDATA[mc.getPayloadXML()..symbol != "IBM";]]></script>
```

### Using a script saved in the registry

In the following example, script is loaded from the registry by using the key `repository/conf/sample/resources/script/test.js`.

``` java
<script language="js"
    key="repository/conf/sample/resources/script/test.js"
    function="testFunction"/>
```

`         script language="js"        ` indicates that the function
invoked should be in the JavaScript language. The function named
testFunction which is invoked should be saved as a resource in the **Registry**. The script can be as shown in the example below.

``` java
function testFunction(mc) {
     var symbol = mc.getPayloadXML()..*::Code.toString();
     mc.setPayloadXML(
        <m:getQuote xmlns:m="http://services.samples/xsd">
           <m:request>
              <m:symbol>{symbol}</m:symbol>
           </m:request>
        </m:getQuote>);
}
```

### Adding an Include key

The following configuration has an `         include key        ` .

```
<script language="js" key="stockquoteScript" function="transformRequest">
    <include key="sampleScript"/>
</script>
```

The script is written in JavaScript. The function to be executed is `         transformRequest        ` . This function may be as follows in
a script saved in the **Registry**.

``` js
// stockquoteTransform.js
function transformRequest(mc) {
transformRequestFunction(mc);
}

function transformResponse(mc) {
transformResponseFunction(mc);
}
```

In addition, the function in the script named
`         sampleScript        ` which is included in the mediation
configuration via the `         include key        ` sub element is also
executed in the mediation. Note that in order to do this,
`         sampleScript        ` script should also be saved as a
resource in the Registry . This script can be as follows.

``` js
// sample.js
function transformRequestFunction(mc) {
var symbol = mc.getPayloadXML()..*::Code.toString();
mc.setPayloadXML(
    <m:getquote m="http://services.samples">
        <m:request>
            <m:symbol>{symbol}</m:symbol>
        </m:request>
    </m:getquote>);
}
 
function transformResponse(mc) {
var symbol = mc.getPayloadXML()..*::symbol.toString();
var price = mc.getPayloadXML()..*::last.toString();
mc.setPayloadXML(
    <m:checkpriceresponse m="http://services.samples/xsd">
        <m:code>{symbol}</m:code>
        <m:price>{price}</m:price>
    </m:checkpriceresponse>);
}
```

### Adding a custom SOAP header

You can add custom SOAP headers to a request by using the
`         addHeader(mustUnderstand, content)        ` of the Script
Mediator in a proxy service as shown in the example below.

```
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="CustomSOAPHeaderProxy"
       startOnLoad="true"
       statistics="disable"
       trace="disable"
       transports="http,https">
   <target>
      <inSequence>
         <log level="full">
            <property name="Message" value="IncomingRequest"/>
         </log>
         <script language="js">mc.addHeader(false, &lt;ns:sampleCustomHeader xmlns:ns="gsb:http://wso2.org/sample"&gt;&lt;ns:customInfo&gt;CustomHeader&lt;/ns:customInfo&gt;&lt;/ns:sampleCustomHeader&gt;);</script>
         <log level="full">
            <property name="Message" value="UpdatedMessage"/>
         </log>
         <drop/>
      </inSequence>
   </target>
   <description/>
</proxy>
```

### Example per method

The following table contains examples of how some of the commonly used methods can be included in the script invoked by the following sample Script mediator configuration.

```
<script language="js"
             key="conf:/repository/EI/transform.js"
             function="transform"/>
```

<table>
<thead>
<tr class="header">
<th>Return?</th>
<th>Method Name</th>
<th>Example</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Yes</td>
<td>getPayloadXML()</td>
<td><div class="content-wrapper">
<p>The script invoked can be as follows.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: js; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: js; gutter: false; theme: Confluence"><pre class="sourceCode js"><code class="sourceCode javascript"><span id="cb1-1"><a href="#cb1-1"></a><span class="co">// sample.js02.function transformRequestFunction(mc) {</span></span>
<span id="cb1-2"><a href="#cb1-2"></a><span class="kw">var</span> symbol <span class="op">=</span> <span class="va">mc</span>.<span class="at">getPayloadXML</span>()..<span class="op">*::</span><span class="va">Code</span>.<span class="at">toString</span>()<span class="op">;</span></span>
<span id="cb1-3"><a href="#cb1-3"></a><span class="va">mc</span>.<span class="at">setPayloadXML</span>(</span>
<span id="cb1-4"><a href="#cb1-4"></a>    <span class="op">&lt;</span>m<span class="op">:</span>getquote m<span class="op">=</span><span class="st">&quot;http://services.samples&quot;</span><span class="op">&gt;</span></span>
<span id="cb1-5"><a href="#cb1-5"></a>        <span class="op">&lt;</span>m<span class="op">:</span>request<span class="op">&gt;</span></span>
<span id="cb1-6"><a href="#cb1-6"></a>            <span class="op">&lt;</span>m<span class="op">:</span>symbol<span class="op">&gt;{</span>symbol<span class="op">}</span>&lt;/m<span class="op">:</span>symbol<span class="op">&gt;</span></span>
<span id="cb1-7"><a href="#cb1-7"></a>        &lt;/m<span class="op">:</span>request<span class="op">&gt;</span></span>
<span id="cb1-8"><a href="#cb1-8"></a>    &lt;/m<span class="op">:</span>getquote<span class="op">&gt;</span>)<span class="op">;</span></span>
<span id="cb1-9"><a href="#cb1-9"></a>}</span></code></pre></div>
</div>
</div>
<p><code>               mc.getPayloadXML()              </code> returns the response received in XML form.</p>
</div></td>
</tr>
<tr class="even">
<td>No</td>
<td>setPayloadXML(payload)</td>
<td>See the example above for the <code>             getPayloadXML()            </code> method. <code>             mc.setPayloadXML(            </code> <code>             &lt;m:getquote m="http://services.samples"&gt;             &lt;m:request&gt;             &lt;m:symbol&gt;{symbol}&lt;/m:symbol             &lt;/m:request&gt;             &lt;/m:getquote&gt;            </code> <code>             )            </code> is used in that script to set the XML representation of the SOAP body (obtained using the <code>             getPayloadXML()            </code> method) to the current message context.</td>
</tr>
<tr class="odd">
<td>No</td>
<td>addHeader(mustUnderstand, Object content)</td>
<td><div class="content-wrapper">
<p>The script invoked can be as follows.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb2" data-syntaxhighlighter-params="brush: js; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: js; gutter: false; theme: Confluence"><pre class="sourceCode js"><code class="sourceCode javascript"><span id="cb2-1"><a href="#cb2-1"></a><span class="op">&lt;</span>script language<span class="op">=</span><span class="st">&quot;js&quot;</span><span class="op">&gt;</span> </span>
<span id="cb2-2"><a href="#cb2-2"></a><span class="op">&lt;!</span>[CDATA[</span>
<span id="cb2-3"><a href="#cb2-3"></a><span class="kw">var</span> wsse <span class="op">=</span> <span class="kw">new</span> <span class="at">Namespace</span>(<span class="st">&#39;http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd&#39;</span>)<span class="op">;</span> </span>
<span id="cb2-4"><a href="#cb2-4"></a><span class="kw">var</span> envelope <span class="op">=</span> <span class="va">mc</span>.<span class="at">getEnvelopeXML</span>()<span class="op">;</span> </span>
<span id="cb2-5"><a href="#cb2-5"></a><span class="kw">var</span> username <span class="op">=</span> <span class="va">envelope</span>..<span class="at">wsse</span><span class="op">::</span><span class="va">Username</span>.<span class="at">toString</span>()<span class="op">;</span> </span>
<span id="cb2-6"><a href="#cb2-6"></a><span class="kw">var</span> password <span class="op">=</span> <span class="va">envelope</span>..<span class="at">wsse</span><span class="op">::</span><span class="va">Password</span>.<span class="at">toString</span>()<span class="op">;</span>   </span>
<span id="cb2-7"><a href="#cb2-7"></a><span class="va">mc</span>.<span class="at">addHeader</span>(<span class="kw">false</span><span class="op">,</span> <span class="op">&lt;</span>urn<span class="op">:</span>AuthenticationInfo<span class="op">&gt;&lt;</span>urn<span class="op">:</span>userName<span class="op">&gt;{</span>username<span class="op">}</span>&lt;/urn<span class="op">:</span>userName<span class="op">&gt;&lt;</span>urn<span class="op">:</span>password<span class="op">&gt;{</span>password<span class="op">}</span>&lt;/urn<span class="op">:</span>password<span class="op">&gt;</span>&lt;/urn<span class="op">:</span>AuthenticationInfo<span class="op">&gt;</span>)<span class="op">;</span> </span>
<span id="cb2-8"><a href="#cb2-8"></a>]]<span class="op">&gt;</span></span>
<span id="cb2-9"><a href="#cb2-9"></a>&lt;/script<span class="op">&gt;</span> </span></code></pre></div>
</div>
</div>
<p>The <code>               addHeader              </code> method configured as</p>
<p><code>               mc.addHeader(false, &lt;urn:AuthenticationInfo&gt;&lt;urn:userName&gt;{username}&lt;/urn:userName&gt;&lt;urn:password&gt;{password}&lt;/urn:password&gt;&lt;/urn:AuthenticationInfo&gt;)              </code> in the above script is used to extract user name and password values included in the request and add them to the header structure required for the backend service.</p>
</div></td>
</tr>
<tr class="even">
<td>No</td>
<td>getEnvelopeXML()</td>
<td><div class="content-wrapper">
<p>The script invoked can be as follows.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb3" data-syntaxhighlighter-params="brush: js; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: js; gutter: false; theme: Confluence"><pre class="sourceCode js"><code class="sourceCode javascript"><span id="cb3-1"><a href="#cb3-1"></a><span class="op">&lt;</span>script language<span class="op">=</span><span class="st">&quot;js&quot;</span><span class="op">&gt;</span> </span>
<span id="cb3-2"><a href="#cb3-2"></a><span class="op">&lt;!</span>[CDATA[</span>
<span id="cb3-3"><a href="#cb3-3"></a><span class="kw">var</span> wsse <span class="op">=</span> <span class="kw">new</span> <span class="at">Namespace</span>(<span class="st">&#39;http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd&#39;</span>)<span class="op">;</span> </span>
<span id="cb3-4"><a href="#cb3-4"></a><span class="kw">var</span> envelope <span class="op">=</span> <span class="va">mc</span>.<span class="at">getEnvelopeXML</span>()<span class="op">;</span> </span>
<span id="cb3-5"><a href="#cb3-5"></a><span class="kw">var</span> username <span class="op">=</span> <span class="va">envelope</span>..<span class="at">wsse</span><span class="op">::</span><span class="va">Username</span>.<span class="at">toString</span>()<span class="op">;</span> </span>
<span id="cb3-6"><a href="#cb3-6"></a><span class="kw">var</span> password <span class="op">=</span> <span class="va">envelope</span>..<span class="at">wsse</span><span class="op">::</span><span class="va">Password</span>.<span class="at">toString</span>()<span class="op">;</span>   </span>
<span id="cb3-7"><a href="#cb3-7"></a><span class="va">mc</span>.<span class="at">addHeader</span>(<span class="kw">false</span><span class="op">,</span> <span class="op">&lt;</span>urn<span class="op">:</span>AuthenticationInfo<span class="op">&gt;&lt;</span>urn<span class="op">:</span>userName<span class="op">&gt;{</span>username<span class="op">}</span>&lt;/urn<span class="op">:</span>userName<span class="op">&gt;&lt;</span>urn<span class="op">:</span>password<span class="op">&gt;{</span>password<span class="op">}</span>&lt;/urn<span class="op">:</span>password<span class="op">&gt;</span>&lt;/urn<span class="op">:</span>AuthenticationInfo<span class="op">&gt;</span>)<span class="op">;</span> ]]<span class="op">&gt;</span> &lt;/script<span class="op">&gt;</span> </span></code></pre></div>
</div>
</div>
<pre><code>See more at: http://sajithblogs.blogspot.com/2013/08/wso2-EI-adding-complex-soap-headers-to.html#sthash.jqpiEmf0.dpuf</code></pre>
</div></td>
</tr>
<tr class="odd">
<td>Yes</td>
<td>getPayloadJSON()</td>
<td><div class="content-wrapper">
<p>The script invoked can be as follows.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb5" data-syntaxhighlighter-params="brush: js; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: js; gutter: false; theme: Confluence"><pre class="sourceCode js"><code class="sourceCode javascript"><span id="cb5-1"><a href="#cb5-1"></a><span class="kw">function</span> <span class="at">transform</span>(mc) <span class="op">{</span></span>
<span id="cb5-2"><a href="#cb5-2"></a>    payload <span class="op">=</span> <span class="va">mc</span>.<span class="at">getPayloadJSON</span>()<span class="op">;</span></span>
<span id="cb5-3"><a href="#cb5-3"></a>    results <span class="op">=</span> <span class="va">payload</span>.<span class="at">results</span><span class="op">;</span></span>
<span id="cb5-4"><a href="#cb5-4"></a>    <span class="kw">var</span> response <span class="op">=</span> <span class="kw">new</span> <span class="at">Array</span>()<span class="op">;</span></span>
<span id="cb5-5"><a href="#cb5-5"></a>    <span class="cf">for</span> (i <span class="op">=</span> <span class="dv">0</span><span class="op">;</span> i <span class="op">&lt;</span> <span class="va">results</span>.<span class="at">length</span><span class="op">;</span> <span class="op">++</span>i) <span class="op">{</span></span>
<span id="cb5-6"><a href="#cb5-6"></a>        location_object <span class="op">=</span> results[i]<span class="op">;</span></span>
<span id="cb5-7"><a href="#cb5-7"></a>        l <span class="op">=</span> <span class="kw">new</span> <span class="at">Object</span>()<span class="op">;</span></span>
<span id="cb5-8"><a href="#cb5-8"></a>        <span class="va">l</span>.<span class="at">name</span> <span class="op">=</span> <span class="va">location_object</span>.<span class="at">name</span><span class="op">;</span></span>
<span id="cb5-9"><a href="#cb5-9"></a>        <span class="va">l</span>.<span class="at">tags</span> <span class="op">=</span> <span class="va">location_object</span>.<span class="at">types</span><span class="op">;</span></span>
<span id="cb5-10"><a href="#cb5-10"></a>        <span class="va">l</span>.<span class="at">id</span> <span class="op">=</span> <span class="st">&quot;ID:&quot;</span> <span class="op">+</span> (<span class="va">location_object</span>.<span class="at">id</span>)<span class="op">;</span></span>
<span id="cb5-11"><a href="#cb5-11"></a>        response[i] <span class="op">=</span> l<span class="op">;</span></span>
<span id="cb5-12"><a href="#cb5-12"></a>    <span class="op">}</span></span>
<span id="cb5-13"><a href="#cb5-13"></a>    <span class="va">mc</span>.<span class="at">setPayloadJSON</span>(response)<span class="op">;</span></span>
<span id="cb5-14"><a href="#cb5-14"></a><span class="op">}</span></span></code></pre></div>
</div>
</div>
<p><code>               mc.getPayloadJSON()              </code> returns the JSON payload (received as the response) as a JavaScript object. This object can be manipulated as a normal JavaScript variable within a script as shown in the above JavaScript code. See <a href="{{base_path}}/integrate/examples/json_examples/json-examples/#script-mediator">JSON Support</a> for further information about how this script is used.</p>
<p><br />
</p>
</div></td>
</tr>
<tr class="even">
<td>No</td>
<td>setPayloadJSON(payload)</td>
<td><p>See the example script for the <code>              getPayloadJSON()             </code> method.</p>
<p>The <code>              mc.setPayloadJSON()             </code> method can be used to replace the existing payload with a new payload. In the above script, we build a new array object by using the fields of the incoming JSON payload and set that array object as the new payload. See <a href="{{base_path}}/integrate/examples/json_examples/json-examples/#script-mediator">JSON Support</a> for further information about how this script is used</p></td>
</tr>
<tr class="odd">
<td>Yes</td>
<td>getProperty (name)</td>
<td><div class="content-wrapper">
<p>The script invoked can be as follows.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb6" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb6-1"><a href="#cb6-1"></a>&lt;script language=<span class="st">&quot;js&quot;</span>&gt;</span>
<span id="cb6-2"><a href="#cb6-2"></a>&lt;![CDATA[</span>
<span id="cb6-3"><a href="#cb6-3"></a> var time1 = mc.<span class="fu">getProperty</span>(<span class="st">&quot;TIME_1&quot;</span>);</span>
<span id="cb6-4"><a href="#cb6-4"></a> var time2 = mc.<span class="fu">getProperty</span>(<span class="st">&quot;TIME_2&quot;</span>);</span>
<span id="cb6-5"><a href="#cb6-5"></a> var timeTaken = time2 - time1;</span>
<span id="cb6-6"><a href="#cb6-6"></a> <span class="fu">print</span>(<span class="st">&quot;Time Duration :  &quot;</span> + timeTaken + <span class="st">&quot; ms &quot;</span>);</span>
<span id="cb6-7"><a href="#cb6-7"></a> mc.<span class="fu">setProperty</span>(<span class="st">&quot;RESPONSE_TIME&quot;</span>, timeTaken);</span>
<span id="cb6-8"><a href="#cb6-8"></a>]]&gt;</span>
<span id="cb6-9"><a href="#cb6-9"></a>&lt;/script&gt;</span></code></pre></div>
</div>
</div>
<p>In this example, the <code>               getProperty              </code> method is used to get two time durations. The difference between the two time durations is calculated and the <code>               setProperty              </code> method is used to set this difference in the message context.</p>
</div></td>
</tr>
<tr class="even">
<td>No</td>
<td>setProperty(property)</td>
<td><div class="content-wrapper">
<p>See the example for the <code>               getProperty              </code> method. The <code>               setProperty              </code> method is used to set the response time calculated from the time durations obtained (using the <code>               getProperty              </code> method) in the message context.</p>
!!! note
<p>In the ESB profile due to a Rhino engine upgrade, when strings are concatenated and set as a property in the message context, you need to use the toString() method to convert the result to a string.</p>
<p>In the following example, <strong>var result = "a"</strong> and then <strong>result = result + "b"</strong> . When concatenating these strings, the script invoked needs to be as follows:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb7" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb7-1"><a href="#cb7-1"></a><span class="kw">&lt;script</span><span class="ot"> language=</span><span class="st">&quot;js&quot;</span><span class="kw">&gt;</span></span>
<span id="cb7-2"><a href="#cb7-2"></a><span class="bn">&lt;![CDATA[</span></span>
<span id="cb7-3"><a href="#cb7-3"></a>{var result = &quot;a&quot;;</span>
<span id="cb7-4"><a href="#cb7-4"></a> result = result + &quot;b&quot;;</span>
<span id="cb7-5"><a href="#cb7-5"></a> mc.setProperty(&#39;result_str&#39;, result.toString()); </span>
<span id="cb7-6"><a href="#cb7-6"></a>}<span class="bn">]]&gt;</span></span>
<span id="cb7-7"><a href="#cb7-7"></a><span class="kw">&lt;/script&gt;</span></span></code></pre></div>
</div>
</div>
<p><br />
</p>
</div></td>
</tr>
</tbody>
</table>
