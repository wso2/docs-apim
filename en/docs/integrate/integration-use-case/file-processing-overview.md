# File Processing

In many business domains, there are different use cases related to managing files. Also, there are file-based legacy systems that are tightly coupled with other systems. These files contain huge amounts of data, which requires a big effort for manual processing. It is not scalable with an increase in system load. This leads us to the requirement of automating the processing of files. The WSO2 Micro Integrator enables the following file processing capabilities:

- Reading, Writing, and Updating files:

  	Files can be located in the local file system or a remote location which can be accessed over protocols such as FTP, FTPS, SFTP, SMB. Therefore, the system used to process those files should capable of communicating over those protocols.

- Process data

  	The system should capable of extracting relevant information from the file. For example, if required to process XML files, the system should be capable of executing and XPath on the file content and extract relevant information.

- Execute some business logic

  	The system should be capable of performing actions that are required to construct a business use case. It should be capable of taking decisions and sending processed information to other systems over different communication protocols.

<table>
	<tr>
		<td>
			<b>Tutorials</b></br>
			<ul>
				<li>
					Try the end-to-end use case on <a href="{{base_path}}/tutorials/integration-tutorials/file-processing">file processing</a>
				</li>
			</ul>
		</td>
		<td>
			<b>Examples</b>
			<ul>
				<li>
					<a href="{{base_path}}/integrate/examples/file-processing/vfs-transport-examples">VFS Transport
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/file-processing/Accessing_Windows_Share_Using_VFS_Transport">Accessing a Windows Share using VFS</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/file-processing/mailto-transport-examples">Using the MailTo Transport</a>
				</li>
			</ul>
		</td>
	</tr>
</table>