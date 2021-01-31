# Axis2 Properties

!!! Info
	The following are Axis2 properties that can be used with the [Property mediator]({{base_path}}/reference/mediators/property-Mediator) and the [Property Group mediator]({{base_path}}/reference/mediators/property-Group-Mediator).

Axis2 properties allow you to configure the web services engine in WSO2 Micro Integrator, such as specifying how to cache JMS objects, setting the minimum and maximum threads for consuming messages, and forcing outgoing HTTP/S messages to use HTTP 1.0. You can access some of these properties by using the [Property mediator]({{base_path}}/reference/mediators/property-Mediator) with the scope set to `axis2` or `axis2-client` as shown below.

## CacheLevel

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>CacheLevel</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td>none, connection, session, consumer, producer, auto</td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>This property determines which JMS objects should be cached. JMS objects are cached so that they can be reused in the subsequent invocations. Each caching level can be described as follows:</p>
<p><code>              none             </code> : No JMS object will be cached.<br />
<code>              connection             </code> <code>              :             </code> JMS connection objects will be cached.<br />
<code>              session             </code> : JMS connection and session objects will be cached.<br />
<code>              consumer             </code> : JMS connection, session and consumer objects will be cached.<br />
<code>              producer             </code> : JMS connection, session and producer objects will be cached.</p>
<code>             auto            </code> : An appropriate caching level will be used depending on the transaction strategy.</td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;parameter</span><span class="ot"> name=</span><span class="st">&quot;transport.jms.CacheLevel&quot;</span><span class="kw">&gt;</span>consumer<span class="kw">&lt;/parameter&gt;</span></span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## ConcurrentConsumers

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>ConcurrentConsumers</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td>integer
<p><br />
</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>The minimum number of threads for message consuming. The value specified for this property is the initial number of threads started. As the number of messages to be consumed increases, number of threads are also increased to match the load until the total number of threads equals the value specified for the <code>              transport.jms.MaxConcurrentConsumers             </code> property.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;parameter</span><span class="ot"> name=</span><span class="st">&quot;transport.jms.ConcurrentConsumers&quot;</span><span class="er">locked=&quot;false&quot;</span><span class="kw">&gt;</span>50<span class="kw">&lt;/parameter&gt;</span></span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## HTTP_ETAG

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td>Name</td>
<td>HTTP_ETAG</td>
</tr>
<tr class="even">
<td>Possible Values</td>
<td>true/false</td>
</tr>
<tr class="odd">
<td>Scope</td>
<td>axis2</td>
</tr>
<tr class="even">
<td>Description</td>
<td><div class="content-wrapper">
<p>This property determines whether the HTTP Etag should be enabled for the request or not.</p>
<b>Note</b>:
<p><a href="https://en.wikipedia.org/wiki/HTTP_ETag">HTTP Etag</a> is a mechanism provided by HTTP for Web cache validation.</p>
</div></td>
</tr>
<tr class="odd">
<td>Example</td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;property</span><span class="ot"> name=</span><span class="st">&quot;HTTP_ETAG&quot;</span><span class="ot"> scope=</span><span class="st">&quot;axis2&quot;</span><span class="ot"> type=</span><span class="st">&quot;BOOLEAN&quot;</span><span class="ot"> value=</span><span class="st">&quot;true&quot;</span><span class="kw">/&gt;</span></span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## JMS_COORELATION_ID

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>JMS_COORELATION_ID</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>String</p></td>
</tr>
<tr class="odd">
<td><p><strong>Scope</strong></p></td>
<td><p>axis2</p></td>
</tr>
<tr class="even">
<td><p><strong>Description</strong></p></td>
<td><p>The JMS coorelation ID is used to match responses with specific requests. This property can be used to set the JMS coorrelation ID as a dynamic or a hard coded value in a request. As a result, responses with the matching JMS correlation IDs will be matched with the request.</p></td>
</tr>
<tr class="odd">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;property</span><span class="ot"> name=</span><span class="st">&quot;JMS_COORELATION_ID&quot;</span><span class="ot"> action=</span><span class="st">&quot;set&quot;</span><span class="ot"> scope=</span><span class="st">&quot;axis2&quot;</span><span class="ot"> expression=</span><span class="st">&quot;$header/wsa:MessageID&quot;</span><span class="ot"> xmlns:sam=</span><span class="st">&quot;http://sample.esb.org/&gt;</span></span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## MaxConcurrentConsumers

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>MaxConcurrentConsumers</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td>integer
<p><br />
</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>The maximum number of threads that can be added for message consuming. See <a href="{{base_path}}/reference/mediators/property-reference/axis2-properties/#concurrentconsumers">ConcurrentConsumers</a> .</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;parameter</span><span class="ot"> name=</span><span class="st">&quot;transport.jms.MaxConcurrentConsumers&quot;</span><span class="er">locked=&quot;false&quot;</span><span class="kw">&gt;</span>50<span class="kw">&lt;/parameter&gt;</span></span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## MercurySequenceKey

|     Parameter       |           Value               |
|---------------------|------------------------------------------------------------------|
| **Name**            | MercurySequenceKey                                               |
| **Possible Values** | integer                                                          |
| **Description**     | Can be an identifier specifying a Mercury internal sequence key. |

## MercuryLastMessage

|     Parameter       |           Value               |
|---------------------|------------------------------------------------------------------------------------|
| **Name**            | MercuryLastMessage                                                                 |
| **Possible Values** | true/false                                                                         |
| **Description**     | When set to "true", it will make this the last message and terminate the sequence. |

## FORCE_HTTP_1.0

|     Parameter       |           Value               |
|---------------------|-------------------------------------------------------------------------------|
| **Name**            | FORCE_HTTP_1.0                                                              |
| **Possible Values** | true/false                                                                    |
| **Scope**           | axis2-client                                                                  |
| **Description**     | Forces outgoing http/s messages to use HTTP 1.0 (instead of the default 1.1). |

## setCharacterEncoding

|     Parameter       |           Value               |
|---------------------|-------------------------------------------------------------------------------|
| **Name**             | setCharacterEncoding                                                                                                                                        |
| **Possible Values**  | false                                                                                                                                                       |
| **Default Behavior** | By default character encoding is enabled in the Micro Integrator.                                                                                                |
| **Scope**            | axis2                                                                                                                                                       |
| **Description**      | This property can be used to remove character encode. Note that if this property is set to 'false', the 'CHARACTER_SET_ENCODING' property cannot be used. |
| **Example**          | `             <property name="             setCharacterEncoding             " value="false" scope="axis2" type="STRING"/>            `                      |

## CHARACTER_SET_ENCODING

|     Parameter       |           Value               |
|---------------------|-------------------------------------------------------------------------------|
| **Name**             | CHARACTER_SET_ENCODING                                                                                                                                                                   |
| **Possible Values**  | Any valid encoding standard (E.g., UTF-8, UTF-16 etc.)                                                                                                                                     |
| **Default Behavior** | N/A                                                                                                                                                                                        |
| **Scope**            | axis2                                                                                                                                                                                      |
| **Description**      | Specifies the encoding type used for the content of the files processed by the transport. Note that this property cannot be used if the 'setCharacterEncoding' property is set to 'false'. |
| **Example**          | `             <property name="CHARACTER_SET_ENCODING" value="UTF-8" scope="axis2" type="STRING"/>            `                                                                             |
## DECODE_MULTIPART_DATA

|     Parameter       |           Value               |
|---------------------|-------------------------------------------------------------------------------|
| **Name**             | DECODE_MULTIPART_DATA                                                                                                                                                                   |
| **Possible Values**  | true/false                                                                                                                                 |
| **Default Behavior** | false                                                                                                                                                                                        |
| **Scope**            | axis2                                                                                                                                                                                      |
| **Description**      | Specifies whether to decode multipart messages when the message is built in a content aware mediation scenario. Otherwise, the outgoing message will be in encoded form |
| **Example**          | `<property name="DECODE_MULTIPART_DATA" value="true" scope="axis2" action="set" type="BOOLEAN"/>`                                                                 |                                                             |

## HL7 Properties

### HL7_GENERATE_ACK

<table>
	<tr>
		<th>
			Parameter
		</th>
		<th>
			Description
		</th>
	</tr>
	<tr>
		<td>
			Name
		</td>
		<td>
			HL7_GENERATE_ACK
		</td>
	</tr>
	<tr>
		<td>
			Possible Values
		</td>
		<td>
			true/false
		</td>
	</tr>
	<tr>
		<td>
			Scope
		</td>
		<td>
			axis2
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			Use this property to disable auto acknowledgement of HL7 messages that are received by the Micro Integrator. By default, auto acknowledgement is enabled in the Micro Integrator. You can disable this by setting this property to 'false'.
		</td>
	</tr>
	<tr>
		<td>
			Example
		</td>
		<td>
			<div class="content-wrapper">
			<div class="code panel pdl" style="border-width: 1px;">
			<div class="codeContent panelContent pdl">
			<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;property</span><span class="ot"> name=</span><span class="st">&quot;HL7_GENERATE_ACK&quot;</span><span class="ot"> <span class="ot"> scope=</span><span class="st">&quot;axis2&quot;</span><span class="ot"> value=</span><span class="st">&quot;true&quot;</span><span class="kw">&lt;/property&gt;</span></span></code></pre></div>
			</div>
			</div>
			</div>
		</td>
	</tr>
</table>

### HL7_RESULT_MODE

<table>
	<tr>
		<th>
			Parameter
		</th>
		<th>
			Description
		</th>
	</tr>
	<tr>
		<td>
			Name
		</td>
		<td>
			HL7_RESULT_MODE
		</td>
	</tr>
	<tr>
		<td>
			Possible Values
		</td>
		<td>
			<code>ACK</code> or <code>NACK</code>
		</td>
	</tr>
	<tr>
		<td>
			Scope
		</td>
		<td>
			axis2
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			Use this property to specify whether an ACK or NACK should be returned to the messaging client as an acknowledgement. If you select a NACK response, you have the option to specify a custom NACK message that should be sent to the client along with the NACK.
		</td>
	</tr>
	<tr>
		<td>
			Example
		</td>
		<td>
			<div class="content-wrapper">
			<div class="code panel pdl" style="border-width: 1px;">
			<div class="codeContent panelContent pdl">
			<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;property</span><span class="ot"> name=</span><span class="st">&quot;HL7_RESULT_MODE&quot;</span><span class="ot"> <span class="ot"> scope=</span><span class="st">&quot;axis2&quot;</span><span class="ot"> value=</span><span class="st">&quot;ACK|NACK&quot;</span><span class="kw">&lt;/property&gt;</span></span></code></pre></div>
			</div>
			</div>
			</div>
		</td>
	</tr>
</table>

### HL7_NACK_MESSAGE

<table>
	<tr>
		<th>
			Parameter
		</th>
		<th>
			Description
		</th>
	</tr>
	<tr>
		<td>
			Name
		</td>
		<td>
			HL7_NACK_MESSAGE
		</td>
	</tr>
	<tr>
		<td>
			Possible Values
		</td>
		<td>
			User defined string value.
		</td>
	</tr>
	<tr>
		<td>
			Scope
		</td>
		<td>
			axis2
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			Use this property to set a custom NACK message that should be sent to the HL7 client as an acknowledgement. This property can be used only if the HL7 result mode is set to <code>NACK</code>.
		</td>
	</tr>
	<tr>
		<td>
			Example
		</td>
		<td>
			<div class="content-wrapper">
			<div class="code panel pdl" style="border-width: 1px;">
			<div class="codeContent panelContent pdl">
			<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;property</span><span class="ot"> name=</span><span class="st">&quot;HL7_NACK_MESSAGE&quot;</span><span class="ot"> <span class="ot"> scope=</span><span class="st">&quot;axis2&quot;</span><span class="ot"> value=</span><span class="st">&quot;error message&quot;</span><span class="kw">&lt;/property&gt;</span></span></code></pre></div>
			</div>
			</div>
			</div>
		</td>
	</tr>
</table>

### HL7_APPLICATION_ACK

<table>
	<tr>
		<th>
			Parameter
		</th>
		<th>
			Description
		</th>
	</tr>
	<tr>
		<td>
			Name
		</td>
		<td>
			HL7_APPLICATION_ACK
		</td>
	</tr>
	<tr>
		<td>
			Possible Values
		</td>
		<td>
			true/false
		</td>
	</tr>
	<tr>
		<td>
			Scope
		</td>
		<td>
			axis2
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			Use this property to specify whether the Micro Integrator should wait for the backend to process the message before sending an acknowledgement (ACK or NACK message) back to the messaging client.
		</td>
	</tr>
	<tr>
		<td>
			Example
		</td>
		<td>
			<div class="content-wrapper">
			<div class="code panel pdl" style="border-width: 1px;">
			<div class="codeContent panelContent pdl">
			<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;property</span><span class="ot"> name=</span><span class="st">&quot;HL7_APPLICATION_ACK&quot;</span><span class="ot"> <span class="ot"> scope=</span><span class="st">&quot;axis2&quot;</span><span class="ot"> value=</span><span class="st">&quot;true|false&quot;</span><span class="kw">&lt;/property&gt;</span></span></code></pre></div>
			</div>
			</div>
			</div>
		</td>
	</tr>
</table>

### HL7_RAW_MESSAGE

<table>
	<tr>
		<th>
			Parameter
		</th>
		<th>
			Description
		</th>
	</tr>
	<tr>
		<td>
			Name
		</td>
		<td>
			HL7_RAW_MESSAGE
		</td>
	</tr>
	<tr>
		<td>
			Possible Values
		</td>
		<td>
			$axis2:HL7_RAW_MESSAGE
		</td>
	</tr>
	<tr>
		<td>
			Scope
		</td>
		<td>
			axis2
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			Use this property to retrieve the original raw EDI format HL7 message in an InSequence.
		</td>
	</tr>
	<tr>
		<td>
			Example
		</td>
		<td>
			<div class="content-wrapper">
			<div class="code panel pdl" style="border-width: 1px;">
			<div class="codeContent panelContent pdl">
			<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">&lt;property</span><span class="ot"> name=</span><span class="st">&quot;HL7_RAW_MESSAGE&quot;</span><span class="ot"> <span class="ot"> scope=</span><span class="st">&quot;axis2&quot;</span><span class="ot"> value=</span><span class="st">&quot;$axis2:HL7_RAW_MESSAGE&quot;</span><span class="kw">&lt;/property&gt;</span></span></code></pre></div>
			</div>
			</div>
			</div>
		</td>
	</tr>
</table>
