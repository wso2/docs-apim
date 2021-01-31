# Generic Properties

!!! Info
	The following are generic properties that can be used with the [Property mediator]({{base_path}}/reference/mediators/property-Mediator) and the [Property Group mediator]({{base_path}}/reference/mediators/property-Group-Mediator).

Generic properties allow you to configure messages as they're processed by the Micro Integrator, such as marking a message as out-only (no response message will be expected), adding a custom error message or code to the message, and disabling WS-Addressing headers.

## PRESERVE_WS_ADDRESSING

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>PRESERVE_WS_ADDRESSING</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>none</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>By default, the Micro Integrator adds a new set of WS-Addressing headers to the messages forwarded from the Micro Integrator. If this property is set to " <code>              true             </code> " on a message, the Micro Integrator will forward it without altering its existing WS-Addressing headers.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;PRESERVE_WS_ADDRESSING&quot;</span> value=<span class="st">&quot;true&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## RESPONSE

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>RESPONSE</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>none</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Once this property is set to 'true' on a message, the Micro Integrator will start treating it as a response message. It is generally used to route a request message back to its source as the response.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;RESPONSE&quot;</span> value=<span class="st">&quot;true&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## OUT_ONLY

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>OUT_ONLY</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>none</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Set this property to "true" on a message to indicate that no response message is expected for it once it is forwarded from the Micro Integrator. In other words, the Micro Integrator will do an out-only invocation with such messages. It is very important to set this property on messages that are involved in out-only invocations to prevent the Micro Integrator from registering unnecessary callbacks for response handling and eventually running out of memory.</p></td>
</tr>
<tr class="even">
<td><p><strong>Description for value="true"<br />
</strong></p></td>
<td><div class="content-wrapper">
<p>Set this property to "true" on a message to indicate that no response message is expected for it once it is forwarded from the Micro Integrator. In other words, the Micro Integrator will do an out-only invocation with such messages. It is very important to set this property on messages that are involved in out-only invocations to prevent the Micro Integrator from registering unnecessary callbacks for response handling and eventually running out of memory.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;OUT_ONLY&quot;</span> value=<span class="st">&quot;true&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td><p><strong>Description for value="false"<br />
</strong></p></td>
<td><div class="content-wrapper">
<p>Set this property to "false" to call the endpoint and get a response once it is forwarded from the Micro Integrator.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb2" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb2-1"><a href="#cb2-1"></a>&lt;property name=<span class="st">&quot;OUT_ONLY&quot;</span> value=<span class="st">&quot;false&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## ERROR_CODE

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>ERROR_CODE</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>string</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>none</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Use this property to set a custom error code on a message which can be later processed by a Synapse fault handler. If the Synapse encounters an error during mediation or routing, this property will be automatically populated.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;ERROR_CODE&quot;</span> value=<span class="st">&quot;100100&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## ERROR_MESSAGE

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>ERROR_MESSAGE</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>string</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>none</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Use this property to set a custom error message on a message which can be later processed by a Synapse fault handler. If the Synapse encounters an error during mediation or routing, this property will be automatically populated.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;log level=<span class="st">&quot;custom&quot;</span>&gt;</span>
<span id="cb1-2"><a href="#cb1-2"></a> &lt;property name=<span class="st">&quot;Cause&quot;</span> expression=<span class="st">&quot;get-property(&#39;ERROR_MESSAGE&#39;)&quot;</span>/&gt;</span>
<span id="cb1-3"><a href="#cb1-3"></a>&lt;/log&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## ERROR_DETAIL

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>ERROR_DETAIL</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>string</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>none</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Use this property to set the exception stacktrace in case of an error. If the Micro Integrator encounters an error during mediation or routing, this property will be automatically populated.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;log level=<span class="st">&quot;custom&quot;</span>&gt;</span>
<span id="cb1-2"><a href="#cb1-2"></a> &lt;property name=<span class="st">&quot;Trace&quot;</span> expression=<span class="st">&quot;get-property(&#39;ERROR_DETAIL&#39;)&quot;</span>/&gt;</span>
<span id="cb1-3"><a href="#cb1-3"></a>&lt;/log&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## ERROR_EXCEPTION

| Parameter            |       Description                                                |
|----------------------|------------------------------------------------------------------|
| **Name**             | ERROR_EXCEPTION                                                 |
| **Possible Values**  | java.lang.Exception                                              |
| **Default Behavior** | none                                                             |
| **Scope**            | synapse                                                          |
| **Description**      | Contains the actual exception thrown in case of a runtime error. |

## TRANSPORT_HEADERS

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>TRANSPORT_HEADERS</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>java.util.Map</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>Populated with the transport headers of the incoming request.</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>axis2</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Contains the map of transport headers. Automatically populated. Individual values of this map can be accessed using the property mediator in the transport scope.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;TRANSPORT_HEADERS&quot;</span> action=<span class="st">&quot;remove&quot;</span> scope=<span class="st">&quot;axis2&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## messageType

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>messageType</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>string</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>Content type of incoming request.</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>axis2</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Message formatter is selected based on this property. This property should have the content type, such as text/xml, application/xml, or application/json.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;messageType&quot;</span> value=<span class="st">&quot;text/xml&quot;</span> scope=<span class="st">&quot;axis2&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## ContentType

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>ContentType</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>string</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>Value of the Content-type header of the incoming request.</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>axis2</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>This property will be in effect only if the messageType property is set. If the messageType is set, the value of Content-Type HTTP header of the outgoing request will be chosen based on this property. Note that this property is required to be set only if the message formatter seeks it in the message formatter implementation.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;ContentType&quot;</span> value=<span class="st">&quot;text/xml&quot;</span> scope=<span class="st">&quot;axis2&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## disableAddressingForOutMessages

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>disableAddressingForOutMessages</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>false</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>axis2</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Set this property to "true" if you do not want the Micro Integrator to add WS-Addressing headers to outgoing messages. This property can affect messages sent to backend services as well as the responses routed back to clients.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;disableAddressingForOutMessages&quot;</span> value=<span class="st">&quot;true&quot;</span> scope=<span class="st">&quot;axis2&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## DISABLE_SMOOKS_RESULT_PAYLOAD

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>DISABLE_SMOOKS_RESULT_PAYLOAD</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>false</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>If this property is set to <code>              true             </code> , the result of file content processing carried out by the <a href="{{base_path}}/reference/mediators/smooks-Mediator">Smooks Mediator</a> will not be loaded into the message context. This is useful in situations where you want to avoid large memory growth/out of heap space issue that may occur when large files processed by the Smooks mediator are reprocessed. See <a href="{{base_path}}/concepts/messaging-transports/#virtual-file-system-vfs">VFS Transport</a> for a proxy service configuration where this property is used.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;DISABLE_SMOOKS_RESULT_PAYLOAD&quot;</span>   value=<span class="st">&quot;true&quot;</span> scope=<span class="st">&quot;default&quot;</span>     type=<span class="st">&quot;STRING&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## ClientApiNonBlocking

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>ClientApiNonBlocking</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>true</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>axis2</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>By default, Axis2 spawns a new thread to handle each outgoing message. This property holds the primary thread until a VFS proxy writes to a VFS endpoint. You need to r emove this property from the message to change this behavior when queuing transports like JMS are involved.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;ClientApiNonBlocking&quot;</span> action=<span class="st">&quot;remove&quot;</span> scope=<span class="st">&quot;axis2&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## transportNonBlocking

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>transportNonBlocking</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>true</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>axis2</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>This property works the same way as <code>              ClientApiNonBlocking             </code>. It is recommended to use <code>              ClientApiNonBlocking             </code> for this purpose instead of <code>              transportNonBlocking             </code> since the former uses the latest axis2 translations.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;transportNonBlocking&quot;</span> action=<span class="st">&quot;remove&quot;</span> scope=<span class="st">&quot;axis2&quot;</span> value=<span class="st">&quot;true&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## TRANSPORT_IN_NAME

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>TRANSPORT_IN_NAME</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Mediation logic can read incoming transport name using this property (since WSO2 ESB 4.7.0)</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;log level=<span class="st">&quot;custom&quot;</span>&gt;</span>
<span id="cb1-2"><a href="#cb1-2"></a>    &lt;property name=<span class="st">&quot;INCOMING_TRANSPORT&quot;</span> expression=<span class="st">&quot;get-property(&#39;TRANSPORT_IN_NAME&#39;)&quot;</span>/&gt;</span>
<span id="cb1-3"><a href="#cb1-3"></a>&lt;/log&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## preserveProcessedHeaders

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>preserveProcessedHeaders</p></td>
</tr>
<tr class="even">
<td><p><strong><strong>Possible Values</strong></strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior<br />
</strong></p></td>
<td><p>Preserving SOAP headers</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse(default)</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>By default, Synapse removes the SOAP headers of incoming requests that have been processed. If we set this property to 'true', Synapse preserves the SOAP headers.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;preserveProcessedHeaders&quot;</span> value=<span class="st">&quot;true&quot;</span> scope=<span class="st">&quot;default&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## SERVER_IP

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>SERVER_IP</p></td>
</tr>
<tr class="even">
<td><p><strong><strong>Possible Values</strong></strong></p></td>
<td><p>IP address or hostname of the Micro Integrator host</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior<br />
</strong></p></td>
<td><p>Set automatically by the mediation engine upon startup</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
</tbody>
</table>

## FORCE_ERROR_ON_SOAP_FAULT

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>FORCE_ERROR_ON_SOAP_FAULT</p></td>
</tr>
<tr class="even">
<td><p><strong><strong>Possible Values</strong></strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior<br />
</strong></p></td>
<td><p>true</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse(default)</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>When a SOAP error occurs in a response, the SOAPFault sent from the back end is received by the out sequence as a usual response by default. If this property is set to <code>true</code>, the SOAPFault is redirected to a fault sequence. Note that when this property is <code>true</code> , only properties in the 'operation' scope will be passed to the error handler, and other properties in the axis2 or default scopes will not be passed to the error handler.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;FORCE_ERROR_ON_SOAP_FAULT&quot;</span> value=<span class="st">&quot;true&quot;</span> scope=<span class="st">&quot;default&quot;</span> type=<span class="st">&quot;STRING&quot;</span>&gt;&lt;/property&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

## QUOTE_STRING_IN_PAYLOAD_FACTORY_JSON

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>QUOTE_STRING_IN_PAYLOAD_FACTORY_JSON</p></td>
</tr>
<tr class="even">
<td><p><strong><strong>Possible Values</strong></strong></p></td>
<td><p>"true", "false"</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior<br />
</strong></p></td>
<td><p>none</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>synapse</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><div class="content-wrapper">
<p>When you create a JSON payload using the PayloadFactory mediator, a string value evaluated from an argument is replaced as it is. If you want to force double quotes to be added to a string value evaluated from an argument, set this property to <code>               true              </code> .</p>
<p><b>Note</b></p>
<p>Double quotes are added only if the value evaluated from an argument is string. If the value is a valid JSON number, boolean value or null, double quotes are not added.</p>

</div></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td>
	<div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;QUOTE_STRING_IN_PAYLOAD_FACTORY_JSON&quot;</span> value=<span class="st">&quot;true&quot;</span>/&gt; </span></code></pre>
</div>
</div>
</div>
</div>
</td>
</tr>
</tbody>
</table>

## RabbitMQ Properties

The following generic properties can be used in the [Property mediator]({{base_path}}/reference/mediators/property-Mediator) and the [Property Group mediator]({{base_path}}/reference/mediators/property-Group-Mediator.md) for RabbitMQ use cases.

### SET_ROLLBACK_ONLY

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
			SET_ROLLBACK_ONLY
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
			default
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			When a message is read from a RabbitMQ message queue, it will be sent to a service running in the backend. If a failure occurs, the Micro Integrator will do a <b>basicReject</b> with the <b>requeue</b> flag set to 'false'. In that case, the user must <a href="{{base_path}}/integrate/examples/rabbitmq_examples/move-msgs-to-dlq-rabbitmq">configure a Dead Letter Exchange</a> to avoid losing messages. The same concept could be used to <a href="{{base_path}}/integrate/examples/rabbitmq_examples/retry-delay-failed-msgs-rabbitmq">control the number of retries and to delay messages</a>.</br></br>
			Note that you need to set the SET_ROLLBACK_ONLY property in the fault handler (e.g., the fault sequence). 
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
			<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;SET_ROLLBACK_ONLY&quot;</span> value=<span class="st">&quot;true&quot;</span> scope=<span class="st">&quot;default&quot;</span> type=<span class="st">&quot;STRING&quot;</span>&gt;&lt;/property&gt;</span></code></pre></div>
			</div>
			</div>
			</div>
		</td>
	</tr>
</table>

### SET_REQUEUE_ON_ROLLBACK

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
			SET_REQUEUE_ON_ROLLBACK
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
			default
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			If this property is set to true in the fault sequence, when a message is read from a RabbitMQ message queue, the Micro Integrator will do a <b>basicReject</b> with the <b>requeue</b> flag set to 'true'. This allows RabbitMQ to immediately redeliver the rejected messages to the consumer.</br></br>
			Note that you need to set the SET_REQUEUE_ON_ROLLBACK property in the fault handler (e.g., the fault sequence). 
		</td>
	</tr>
	<tr>
		<td>
			Example
		</td>
		<td><div class="content-wrapper">
			<div class="code panel pdl" style="border-width: 1px;">
			<div class="codeContent panelContent pdl">
			<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;property name=<span class="st">&quot;SET_REQUEUE_ON_ROLLBACK&quot;</span> value=<span class="st">&quot;true&quot;</span> scope=<span class="st">&quot;default&quot;</span> type=<span class="st">&quot;STRING&quot;</span>&gt;&lt;/property&gt;</span></code></pre></div>
			</div>
			</div>
			</div>
		</td>
	</tr>
</table>
