# admin\_MailTo Transport

The polling MailTo transport supports sending messages (E-Mail) over SMTP and receiving messages over POP3 or IMAP. This transport implementation is available as a module of the WS-Commons Transports project. The receiver and sender classes that should be included in the Carbon configuration to enable the MailTo transport are `         org.apache.axis2.transport.mail.MailTransportListener        ` and `         org.apache.axis2.transport.mail.MailTransportSender        ` respectively. The JAR consisting of the transport implementation is named `         axis2-transport-mail.jar        ` .

The mail transport receiver should be configured at service level. That is each service configuration should explicitly state the mail transport receiver configuration. This is required to enable different services to receive mails over different mail accounts and configurations. However, transport sender is generally configured globally so that all services can share the same transport sender configuration.

### Service Level Transport Receiver Parameters

The MailTo transport listener implementation can be configured by setting the parameters described in JavaMail API documentation. For IMAP related properties, see [Package Summary - IMAP](https://javamail.java.net/nonav/docs/api/com/sun/mail/imap/package-summary.html) . For POP3 properties, see [Package Summary - POP3](https://javamail.java.net/nonav/docs/api/com/sun/mail/pop3/package-summary.html) . In addition to the parameters described in the JavaMail API documentation, the MailTo transport listener also supports the following transport parameters.

!!! info
Tip

In the following transport parameter tables, the literals displayed in italics under the **Possible Values** column should be considered as fixed literal constant values. Those values can be directly specified in the transport configuration.


<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Required</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>transport.mail.Address</p></td>
<td><p>The mail address from which this service should fetch incoming mails.</p></td>
<td><p>Yes</p></td>
<td><p>A valid e-mail address</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.mail.Folder</p></td>
<td><p>The mail folder in the server from which the listener should fetch incoming mails.</p></td>
<td><p>No</p></td>
<td><p>A valid mail folder name (e.g., inbox)</p></td>
<td><p>inbox folder if that is available or else the root folder</p></td>
</tr>
<tr class="odd">
<td><p>transport.mail.Protocol</p></td>
<td><p>The mail protocol to be used to receive messages.</p></td>
<td><p>No</p></td>
<td><p><em>pop3, imap</em></p></td>
<td><p>imap</p></td>
</tr>
<tr class="even">
<td><p>transport.mail.PreserveHeaders</p></td>
<td><p>A comma separated list of mail header names that this receiver should preserve in all incoming messages.</p></td>
<td><p>No</p></td>
<td><p>A comma separated list</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.mail.RemoveHeaders</p></td>
<td><p>A comma separated list of mail header names that this receiver should remove from incoming messages.</p></td>
<td><p>No</p></td>
<td><p>A comma separated list</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.mail.ActionAfterProcess</p></td>
<td><p>Action to perform on the mails after processing them.</p></td>
<td><p>No</p></td>
<td><p><em>MOVE, DELETE</em></p></td>
<td><p>DELETE</p></td>
</tr>
<tr class="odd">
<td><p>transport.mail.ActionAfterFailure</p></td>
<td><p>Action to perform on the mails after a failure occurs while processing them.</p></td>
<td><p>No</p></td>
<td><p><em>MOVE, DELETE</em></p></td>
<td><p>DELETE</p></td>
</tr>
<tr class="even">
<td><p>transport.mail.MoveAfterProcess</p></td>
<td><p>Folder to move the mails after processing them.</p></td>
<td><p>Required if ActionAfterProcess is MOVE</p></td>
<td><p>A valid mail folder name</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.mail.MoveAfterFailure</p></td>
<td><p>Folder to move the mails after encountering a failure.</p></td>
<td><p>Required if ActionAfterFailure is MOVE</p></td>
<td><p>A valid mail folder name</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.mail.ProcessInParallel</p></td>
<td><p>Whether the receiver should incoming mails in parallel or not (works only if the mail protocol supports that - for example, IMAP).</p></td>
<td><p>No</p></td>
<td><p><em>true, false</em></p></td>
<td><p>false</p></td>
</tr>
<tr class="odd">
<td><p>transport.ConcurrentPollingAllowed</p></td>
<td><p>Whether the receiver should poll for multiple messages concurrently.</p></td>
<td><p>No</p></td>
<td><p><em>true, false</em></p></td>
<td><p>false</p></td>
</tr>
<tr class="even">
<td><p>transport.mail.MaxRetryCount</p></td>
<td><p>Maximum number of retry operations to be performed when fetching incoming mails.</p></td>
<td><p>Yes</p></td>
<td><p>A positive integer</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.mail.ReconnectTimeout</p></td>
<td><p>The reconnect timeout in milliseconds to be used when fetching incoming mails.</p></td>
<td><p>Yes</p></td>
<td><p>A positive integer</p></td>
<td><p></p></td>
</tr>
</tbody>
</table>

### Global Transport Sender Parameters

For a list of parameters supported by the MailTo transport sender, see [Package Summary - SMTP](https://javamail.java.net/nonav/docs/api/com/sun/mail/smtp/package-summary.html) . In addition to the parameters described there, the MailTo transport sender supports the following parameters.

<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Required</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>transport.mail.SMTPBccAddresses</p></td>
<td><p>If one or more e-mail addresses need to be specified as BCC addresses for outgoing mails, this parameter can be used.</p></td>
<td><p>No</p></td>
<td><p>A comma separated list of e-mail addresses</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.mail.Format</p></td>
<td><p>Format of the outgoing mail.</p></td>
<td><p>No</p></td>
<td><p><em>Text</em> , <em>Multipart</em></p></td>
<td><p>Text</p></td>
</tr>
</tbody>
</table>


