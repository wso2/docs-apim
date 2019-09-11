# admin\_VFS Transport

**VFS (Virtual File System) transport** implementation is a module which belongs to the Apache Synapse project. The following classes implement the listener and sender APIs.

-`org.apache.synapse.transport.vfs.VFSTransportListener`
-`org.apache.synapse.transport.vfs.VFSTransportSender`

The necessary classes can be found in the `synapse-vfs-transport.jar` file. Unlike the transports described previously, VFS transport does not have any global parameters to be configured. Rather, it has a set of service level parameters that needs to be specified for each service. VFS transport implementation is mainly used and mostly effective in the WSO2 ESB.

Carbon VFS transport supports the **FTPS protocol** . Configuration is identical to other protocols with the only difference being the URL prefixes.

The VFS transport implementation is based on Apache Commons VFS implementation. Therefore `commons-vfs.jar` file should be included in the Carbon classpath to enable the VFS transport.

Since VFS transport deals with file operations, there are instances that these can fail due to unavailability of some resource. In such an instance, the VFS transport is equipped with the following fault-handling mechanism.

When a failure occurs in a file object, it will be marked as a failed record and will be moved to a location (configured by the user) where error file objects are kept. The failed record will be maintained inside a text file (file name is configurable) and the location of that file will be provided by the user. When the next polling iteration is going on, it will check the file against the failed record and if the file is a failed record, it will skip processing and schedule a move task to move that file (the retry duration of the file move task can be configured). It's handled this way because it is a random failure in the move operation.

### VFS service level parameters

!!! tip
In transport parameter tables, literals displayed in italic mode under the "Possible Values" column should be considered as fixed literal constant values. Those values can be directly put in transport configurations.


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
<td><p>transport.vfs.<br />
FileURI</p></td>
<td><p>The file URL from<br />
where the input files<br />
should be fetched.</p></td>
<td><p>Yes</p></td>
<td><p>A valid file URL<br />
of the form file://<br />
file://&lt;path&gt;</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.vfs.<br />
ContentType</p></td>
<td><p>Content type of the files<br />
transferred over the transport.</p></td>
<td><p>Yes</p></td>
<td><p>A valid content<br />
type for the<br />
files (e.g., text/xml)</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.vfs.<br />
FileName<br />
Pattern</p></td>
<td><p>If the VFS listener<br />
should read only a<br />
subset of all the files<br />
available in the<br />
specified file URI<br />
location, this parameter<br />
can be used to select<br />
those files by name<br />
using a regular<br />
expression.</p></td>
<td><p>No</p></td>
<td><p>A regular<br />
expression to<br />
select files by<br />
name<br />
(e.g.,*\.xml)</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.<br />
PollInterval</p></td>
<td><p>The polling interval in<br />
milliseconds for the<br />
transport receiver to<br />
poll the file URI<br />
location.</p></td>
<td><p>No</p></td>
<td><p>A positive integer</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.vfs.<br />
ActionAfter<br />
Process</p></td>
<td><p>Action to perform<br />
over the files after<br />
processed by<br />
the transport.</p></td>
<td><p>No</p></td>
<td><p><em>MOVE,</em><br />
<em>DELETE</em></p></td>
<td><p>DELETE</p></td>
</tr>
<tr class="even">
<td><p>transport.vfs.<br />
ActionAfter<br />
Failure</p></td>
<td><p>Action to perform<br />
over the files after<br />
processed by<br />
the transport.</p></td>
<td><p>No</p></td>
<td><p><em>MOVE,</em><br />
<em>DELETE</em></p></td>
<td><p>DELETE</p></td>
</tr>
<tr class="odd">
<td><p>transport.vfs.<br />
MoveAfter<br />
Process</p></td>
<td><p>The location to<br />
move the files<br />
after processing.</p></td>
<td><p>Required if<br />
ActionAfterProcess<br />
is MOVE</p></td>
<td><p>A valid file URI</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.vfs.<br />
MoveAfter<br />
Failure</p></td>
<td><p>The location to<br />
move the files<br />
after a failure<br />
occurs.</p></td>
<td><p>Required if<br />
ActionAfterFailure<br />
is MOVE</p></td>
<td><p>A valid file URI</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.vfs.<br />
ReplyFileURI</p></td>
<td><p>The location to<br />
which reply files<br />
should be written<br />
by the transport.</p></td>
<td><p>No</p></td>
<td><p>A valid file URI</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.vfs.<br />
ReplyFile<br />
Name</p></td>
<td><p>The name for reply files<br />
written by the transport.</p></td>
<td><p>No</p></td>
<td><p>A valid file<br />
name</p></td>
<td><p>response.xml</p></td>
</tr>
<tr class="odd">
<td><p>transport.vfs.<br />
Move<br />
Timestamp<br />
Format</p></td>
<td><p>The pattern/format<br />
of the  timestamps<br />
added to file names<br />
as prefixes when<br />
moving files (See<br />
the API documentation<br />
of <code>              java.text.             </code><br />
<code>              SimpleDateFormat             </code><br />
for details).</p></td>
<td><p>No</p></td>
<td><p>A valid timestamp<br />
pattern<br />
(e.g., yyyy-MM-<br />
dd'T'HH:mm<br />
:ss.SSSZ)</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.vfs.<br />
Streaming</p></td>
<td><p>If files should be transferred<br />
in streaming mode or not.</p></td>
<td><p>No</p></td>
<td><p>true, false</p></td>
<td><p>false</p></td>
</tr>
<tr class="odd">
<td><p>transport.vfs.<br />
Reconnect<br />
Timeout</p></td>
<td><p>Reconnect timeout<br />
value in seconds<br />
to be used in<br />
case of an error<br />
when transferring<br />
files.</p></td>
<td><p>No</p></td>
<td><p>A positive<br />
integer</p></td>
<td><p>30 sec</p></td>
</tr>
<tr class="even">
<td><p>transport.vfs.<br />
MaxRetry<br />
Count</p></td>
<td><p>Maximum number of<br />
retry attempts to<br />
carry out in case<br />
of errors.</p></td>
<td><p>No</p></td>
<td><p>A positive<br />
integer</p></td>
<td><p>3</p></td>
</tr>
<tr class="odd">
<td><p>transport.vfs.<br />
Append</p></td>
<td><p>When writing the<br />
response to a file,<br />
if the response<br />
should be appended<br />
to the response file<br />
this parameter<br />
should be set to<br />
true.<br />
<br />
By default the<br />
response file will<br />
be completely<br />
overwritten.</p></td>
<td><p>No</p></td>
<td><p><em>true, false</em></p></td>
<td><p>false</p></td>
</tr>
<tr class="even">
<td><p>transport.vfs.<br />
MoveAfter<br />
FailedMove</p></td>
<td><p>New destination<br />
to move the<br />
failed file.</p></td>
<td><p>No</p></td>
<td><p>A valid file URI</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.vfs.<br />
Failed<br />
Records<br />
FileName</p></td>
<td><p>The file name to maintain<br />
the list of failure files.</p></td>
<td><p>No</p></td>
<td><p>A valid file name</p></td>
<td><p>vfs-move-<br />
failed-<br />
records.<br />
properties</p></td>
</tr>
<tr class="even">
<td><p>transport.vfs.<br />
Failed<br />
Records<br />
File<br />
Destination</p></td>
<td><p>The destination of the<br />
failed file.</p></td>
<td><p>No</p></td>
<td><p>A folder URI</p></td>
<td><p>repository<br />
/conf/</p></td>
</tr>
<tr class="odd">
<td><p>transport.vfs.<br />
Move<br />
Failed<br />
Record<br />
Timestamp<br />
Format</p></td>
<td><p>When adding a record<br />
to the failed file,<br />
entries are logged<br />
as:<br />
<code>              file_name             </code><br />
<code>              time_stamp             </code> .<br />
This will configure<br />
the time stamp<br />
format.</p></td>
<td><p>No</p></td>
<td><p>A valid timestamp<br />
pattern (eg: yyyy-<br />
MM-dd'T'HH:mm:<br />
ss.SSSZ)</p></td>
<td><p>dd-MM-<br />
yyyy<br />
HH:mm<br />
:ss</p></td>
</tr>
<tr class="even">
<td><p>transport.vfs.<br />
Failed<br />
Record<br />
Next<br />
Retry<br />
Duration</p></td>
<td><p>The time in milli<br />
second for the<br />
move task to wait<br />
until next retry.</p></td>
<td><p>No</p></td>
<td><p>A positive<br />
integer</p></td>
<td><p>3000 milli<br />
seconds</p></td>
</tr>
</tbody>
</table>

You can find a VFS transport implementation in this tutorial: <http://wso2.org/library/tutorials/2011/01/sftp-file-transer-wso2-esb>
