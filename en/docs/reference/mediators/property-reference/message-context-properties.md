# Synapse Message Context Properties

!!! Info
	The following are message context properties that can be used with the [Property mediator]({{base_path}}/reference/mediators/property-Mediator) and the [Property Group mediator]({{base_path}}/reference/mediators/property-Group-Mediator).

The Synapse message context properties allow you to get information
about the message, such as the date/time it was sent, the message
format, and the message operation. You can use the
`         get-property()        ` function in the [Property mediator]({{base_path}}/references/mediators/property-Mediator) with the scope set to
`         Synapse        ` to retrieve these properties.

## SYSTEM_DATE

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
<tbody>
<tr class="odd">
<td><p><strong>Name</strong></p></td>
<td><p>SYSTEM_DATE</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>-</p></td>
</tr>
<tr class="odd">
<td><p><strong>Default Behavior</strong></p></td>
<td><p>-</p></td>
</tr>
<tr class="even">
<td><p><strong>Scope</strong></p></td>
<td><p>-</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>Returns the current date as a String.</p>
Optionally, a date format as per the standard date format may be supplied by entering the following in the Namespaced Property Editor: <code>                  get-property("SYSTEM_DATE", "yyyy-MM-dd'T'HH:mm:ss.SSSXXX")</code>
</td>
</tr>
</tbody>
</table>

## SYSTEM_TIME

<table>
	<tr>
		<th>Parameter</th>
		<th>Description</th>
	</tr>
	<tr>
		<td><b>Name</b></td>
		<td></td>
	</tr>
	<tr>
		<td><b>Possible Values</b></td>
		<td></td>
	</tr>
	<tr>
		<td><b>Default Behavior</b></td>
		<td></td>
	</tr>
	<tr>
		<td><b>Scope</b></td>
		<td></td>
	</tr>
	<tr>
		<td><b>Description</b></td>
		<td>
			Returns the current time in milliseconds, i.e. the difference, measured in milliseconds, between the current time and midnight, January 1, 1970 UTC.
		</td>
	</tr>
</table>


## To, From, Action, FaultTo, ReplyTo, MessageID

|     Parameter       |           Description              |
|----------------------|------------------------------------------------------|
| **Names**            | To, From, Action, FaultTo, ReplyTo, MessageID        |
| **Possible Values**  | \-                                                   |
| **Default Behavior** | \-                                                   |
| **Scope**            | \-                                                   |
| **Description**      | The message To, Action and WS-Addressing properties. |


## MESSAGE_FORMAT


|     Parameter       |           Description              |
|----------------------|----------------------------------------------------------------------|
| **Names**            | MESSAGE\_FORMAT                                                      |
| **Possible Values**  | \-                                                                   |
| **Default Behavior** | \-                                                                   |
| **Scope**            | \-                                                                   |
| **Description**      | Returns the message format, i.e. returns pox, get, soap11 or soap12. |


## OperationName

|     Parameter       |           Description              |
|----------------------|---------------------------------------------|
| **Names**            | OperationName                               |
| **Possible Values**  | \-                                          |
| **Default Behavior** | \-                                          |
| **Scope**            | \-                                          |
| **Description**      | Returns the operation name for the message. |
