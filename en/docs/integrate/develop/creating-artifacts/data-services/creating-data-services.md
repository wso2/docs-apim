# Creating a Data Service

Follow the instructions given below to create a new data service artifact.

!!!	Tip	
	You can also use a sample template to create your data service.

	1.	Open the **Getting Started** view of WSO2 Integration Studio (**Menu -> Help -> Getting Started**). 
	2.	In the Getting Started view, go to the **Data Service** tab and select the **REST Data Service** example.

## Instructions

### Create the data service artifact

Follow the steps given below to create the data service file:

1.  Right-click the **Data Service Config** module in the project
    explorer and go to **New -> Data Service**. 

    <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/new-data-service.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/new-data-service.png" width="700"></a>

2.	In the **New Data Service** wizard that opens, select **Create New
    Data Service** and click **Next**.

    <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/119130577/119130578.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/119130577/119130578.png" width="500"></a>

3.  Enter a name for the data service and click **Finish**.

A data service file (DBS file) will now be created in your data service
project as show below.

![]({{base_path}}/assets/img/integrate/tutorials/data_services/data-service-project-structure.png)

### Adding a datasource

You can configure the datasource connection details using this section.

1.	Click **Data Sources** to expand the section.

	![]({{base_path}}/assets/img/integrate/tutorials/data_services/add-datasource-1.png)

2.	Click **Add New** to open the **Create Datasource** page.

	![]({{base_path}}/assets/img/integrate/tutorials/data_services/add-datasource-2.png)

3.	Enter the datasource connection details.
4.	Click **Test Connection** to expand the section.

    ![]({{base_path}}/assets/img/integrate/tutorials/data_services/test_connection.png)

5.  Click the **Test Connection** button to verify the connectivity between the MySQL datasource and the data service.

6.  Save the data service.

### Creating a query

You can configure the main query details using this section.

1.  Click **Queries** to expand the section. 

    <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/query_expanded.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/query_expanded.png" width="70%"></a>

2.  Click **Add New** to open the **Add Query** page.

    <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/add_query.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/add_query.png" width="70%"></a>

3.  Enter the following query details.
	
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
				Query ID
			</td>
			<td>
				Give a unique name to Identify the Query.
			</td>
		</tr>
		<tr>
			<td>
				Datasource
			</td>
			<td>
			   All the datasources created for this data service are listed. Select the required datasource from the list.
			</td>
		</tr>
		<tr>
			<td>
				SQL Query
			</td>
			<td>
				You can enter the SQL query in this text box.
			</td>
		</tr>
	</table>

#### Input mapping

You can configure input parameters for the query using this section.

1.  Click **Input Mappings** to expand the section. 

    <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/input_mapping_expanded.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/input_mapping_expanded.png" width="70%"></a>

2.	There are two  ways to create the mapping:
	
	-	You can click **Generate** to automatically generate the input mappings from the SQL query.
	-	If you want to add a new input mapping:

		1.	Click **Add New** to open the **Add Input Mapping** page.

			<a href="{{base_path}}/assets/img/integrate/tutorials/data_services/add_input_mappings.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/add_input_mappings.png" width="500"></a>

		2.	Enter the following input mapping details:

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
						Mapping Name
					</td>
					<td>
						Give a name for the mapping.
					</td>
				</tr>
				<tr>
					<td>
						Parameter Type
					</td>
					<td>
						The parameter type.
					</td>
				</tr>
				<tr>
					<td>
						SQL Type
					</td>
					<td>
						The SQL type.
					</td>
				</tr>
			</table>

		3.	Save the input mapping. 

Shown below is an example query with input mapping:
                        
<a href="{{base_path}}/assets/img/integrate/tutorials/data_services/input_mappings.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/input_mappings.png" width="70%"></a>

#### Result (Output Mappings) 

You can configure output result parameters for the query using this section.

1.  Click **Result (Output Mappings)** to expand the section.
    
    <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/out_mapping_expanded.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/out_mapping_expanded.png"></a>
    
2.  Enter the following details:

    <table>
        <tr>
            <th>Property</th>
            <th>Description</th>
        </tr>
    <tr class="odd">
    <td>Grouped by Element</td>
    <td>Employees</td>
    </tr>
    </table>

3.	There are two ways to create the output mapping:

	-	You can click **Generate** to automatically generate the output mappings from the SQL query.
	-	Alternatively, you can manually add the mappings:

		1. Click **Add New** to open the **Add Output Mapping** page.

			<a href="{{base_path}}/assets/img/integrate/tutorials/data_services/add_output_mappings.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/add_output_mappings.png" width="50%"></a>

		2. Enter the following output element details.

		    <table>
		    <tr>
		            <th>Property</th>
		            <th>Description</th>
		        </tr>
		    <tbody>
		    <tr class="odd">
		    <td>Datasource Type</td>
		    <td>column</td>
		    </tr>
		    <tr class="even">
		    <td>Output Field Name</td>
		    <td>EmployeeNumber</td>
		    </tr>
		    <tr class="odd">
		    <td>Datasource Column Name</td>
		    <td>EmployeeNumber</td>
		    </tr>
		    <tr class="even">
		    <td>Schema Type</td>
		    <td>String</td>
		    </tr>
		    </tbody>
		    </table>   

		3.  Save the element.
		4.  Follow the same steps to create the remaining output elements.

Shown below is an example query with output mappings:

![]({{base_path}}/assets/img/integrate/tutorials/data_services/output_mapings.png)

#### Advanced properties 

Click **Advanced Properties** to expand the section and add the required parameter values.

![]({{base_path}}/assets/img/integrate/tutorials/data_services/advances_properties_expanded.png)

The data service should now have the query element added.

### Adding a SOAP operation

Use this section to configure a SOAP operation for invoking the data service.

1.  Click **Operations** to expand the section.

    <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/new-operataion.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/new-operataion.png" width="70%"></a>

2.  Click **Add New** to add a SOAP Operation for your data service.

	<a href="{{base_path}}/assets/img/integrate/tutorials/data_services/add-operation.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/add-operation.png" width="70%"></a>

3.	Enter the following information:

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
				Operation Name
			</td>
			<td>
				Give a name to the SOAP Operation.
			</td>
		</tr>
		<tr>
			<td>
				Query ID
			</td>
			<td>
				Select the Query from the listed queries.
			</td>
		</tr>
		<tr>
			<td>
				Operation Parameters
			</td>
			<td>
				Click <b>Add New</b> to add new parameters to the operation.
			</td>
		</tr>
	</table>

### Adding a Resource

Use this section to configure a REST resource for invoking the data service.

1.  Click **Resources** to expand the section.
	
	<a href="{{base_path}}/assets/img/integrate/tutorials/data_services/resource_expanded.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/resource_expanded.png" width="70%"></a>

2.	Click **Add New** to add a new resource.

	<a href="{{base_path}}/assets/img/integrate/tutorials/data_services/create_resource.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/create_resource.png" width="70%"></a>

3.	Give the following details to create the REST resource. 

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
				Resource Path
			</td>
			<td>
				Give the HTTP REST resource path you need to expose.
			</td>
		</tr>
		<tr>
			<td>
				Query ID
			</td>
			<td>
				Select the Query ID from the drop down list that you need to expose as a REST resource.
			</td>
		</tr>
	</table>

4.	Click **Save** to add the resource to the data service.

The data service should now have the resource added.

### Generate Data Service from a Datasource

Follow the steps given below to automatically create a data service using a given datasource structure. 
When generating a data service, the server takes its table structure according to the structure specified in the 
datasource and automatically creates the SELECT, INSERT, UPDATE, and DELETE operations.

1. 	Create a datasource project and add a datasource in the current workspace. You can 
	refer [Creating a Datasource]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-datasources) for more information.

2.	In the **New Data Service** wizard that opens, select **Generate Data Service from Datasource** and click **Next**.
	  <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/generate_dataservice.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/generate_dataservice.png" width="700"></a>

3. 	From the wizard, select the datasource that you have configured in step 1.
	
    <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/generate_dataservice_select_datasource.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/generate_dataservice_select_datasource.png" width="700"></a>

4. 	Select the driver to connect to the datasource. You need to browse and upload a driver from your file system.

    <a href="{{base_path}}/assets/img/integrate/tutorials/data_services/select_driver_file_system.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/select_driver_file_system.png" width="700"></a>

    Then click **Fetch Table** to list down all avaialble tables in the selected datasource.

5. 	From the list of tables, select the tables and the REST resource methods that you want in the generated data service.

	!!!	Note
		1.	The **POST** REST method is enabled only when the database is not in read-only mode.
		2.	The **PUT** and **DELETE** REST methods are enabled only when a primary key is defined on the table.

	<a href="{{base_path}}/assets/img/integrate/tutorials/data_services/select_tables.png"><img src="{{base_path}}/assets/img/integrate/tutorials/data_services/select_tables.png" width="700"></a>

6. 	You can select a service generation mode from the following two options:

	- Single Service: Creates a single data service for resources of all tables.
	  If this option is selected, you need to provide a name for the Data Service you are creating.

	- Multiple Services: Creates a service per table, which will contain isolated resources for each table.

7. 	Click **Finish** to generate the services and add to the dataservices project.

## Examples

<ul>
	<li>
		<a href="{{base_path}}/integrate/examples/data_integration/rdbms-data-service">Exposing an RDBMS Datasource</a>
	</li>
	<li>
		<a href="{{base_path}}/integrate/examples/data_integration/json-with-data-service">Exposing Data in JSON Format</a>
	</li>
	<li>
		<a href="{{base_path}}/integrate/examples/data_integration/odata-service">Using an OData Service</a>
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

## Tutorials

<li>
	See the tutorial on <a href="{{base_path}}/tutorials/integration-tutorials/sending-a-simple-message-to-a-datasource">data integration</a>
</li>
