# Endpoint Types

Choreo Connect supports a range of different endpoint types, allowing the it to connect with advanced types of backends.

<table>
<tr>
<th><b>Type</b></th>
<th><b>Description</b></th>
</tr>
<tr>
<td>HTTP/ REST Endpoint</td>
<td>A REST service endpoint based on a URI template. </td>
</tr>
<tr>
<td>WebSocket Endpoint</td>
<td>A HTTP based streaming endpoint implemented based on the WebSocket protocol. Once a connection is established with the endpoint, a channel that enables two way communication is created providing pub sub capabilities. </td>
</tr>
<tr><td>Mock Implementation</td>
<td>The Mock Implementation uses the built-in JavaScript engine of Synapse to mock the responses and can be used per HTTP resource of the API. For more information on the Mock Implementation, see <a href="{{base_path}}/design/prototype-api/create-a-prototype-api/#mock-implementation">Create a Prototype API</a>.</br>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>The <b>Mock Implementation</b> will be only available for APIs that are in the <b>CREATED</b> or <b>PROTOTYPED</b> state.</p>
</div> 
</td>
</tr>
</table>
