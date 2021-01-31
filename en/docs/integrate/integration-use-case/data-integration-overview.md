# Data Integration

Data integration is an important part of an integration process. For example, consider a typical integration process that is managed using the Micro Integrator: Data stored in various, disparate datasources are required in order to complete the integration use case. 

The data services functionality that is embedded in the Micro Integrator can decouple the data from the datasource layer and exposing them as data services. The main integration flow defined in the Integrator will then have the capability of managing the data through the data service. Once the data service is defined, you can manipulate the data stored in the datasources by invoking the relevant operation defined in the data service. For example, you can perform the basic CRUD operations as well as other advanced operations.

<table>
	<tr>
		<td>
			<b>Tutorials</b></br>
			<ul>
				<li>
					Try the end-to-end use case on <a href="{{base_path}}/tutorials/integration-tutorials/sending-a-simple-message-to-a-datasource">data integration</a>
				</li>
			</ul>
		</td>
		<td>
			<b>Examples</b></br>
			<ul>
				<li>
					<a href="{{base_path}}/integrate/examples/data_integration/rdbms-data-service">Exposing an RDBMS Datasource</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/data_integration/json-with-data-service">Exposing Data in JSON Format</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/data_integration/odata-service">Using and OData Service</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/data_integration/nested-queries-in-data-service">Using Nested Data Queries</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/data_integration/batch-requesting">Batch Requesting</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/data_integration/request-box">Invoking Multiple Operations via Request Box</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/data_integration/distributed-trans-data-service">Using Distributed Transactions in Data Services</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/examples/data_integration/data-input-validator">Validating Data Input</a>
				</li>
			</ul>
		</td>
	</tr>
</table>