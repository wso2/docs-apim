# Query Parameters

The query in a data service specifies the type of task that should be
performed on the data in a particular data store. For example, consider
the task of retrieving data from a data store, or posting, updating, and
deleting data. Data consumers send requests to the data service by
invoking the relevant operation (or REST resource) in the data service.
Consequently, the query connected to the operation/resource is executed
to perform the task.

!!! Info
	REST resources and Operations are used depending on whether the particular task should be invoked RESTfully, or by using SOAP. Read more about [REST resources and operations]({{base_path}}/reference/synapse-properties/data-services/elements-of-a-data-service) in data services.

## SQL/Query details

If the data store supports SQL, you need to specify the SQL statement to
execute the required task.

**Example**:

```sql
select EmployeeNumber, FirstName, LastName, Email from Employees where EmployeeNumber=:EmployeeNumber
```

## Input parameters

Input mappings allow you to add parameters to a query so that you can
set the parameter value when executing the query. 

For example, if you are writing an SQL query that requires an input value, you need
to specify the parameters that can be used to provide the input. Consider an SQL 
statement for getting details of an employee from a data store. 
To get the details, it is necessary to provide the identifier of the employee in the
data store. 

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
		<td>Generate Input Mapping</td>
		<td>
			If you have defined an SQL query, you can generate input mappings corresponding to the input fields specified in the query by clicking <strong>Generate Input Mappings</strong>.
		</td>
	</tr>
	<tr>
		<td>Returning Generated Keys</td>
		<td>
			It inserts data to a table that has auto increment key columns. The auto incremented key value of the record is mapped to the result output mappings of the data service. For example, the sample query below is used to insert values to a table by the name of <code>               wes_teams              </code>, which has an auto increment column:</br></br>
			<code>               INSERT INTO wes_teams(TEAM) VALUES(?)              </code></br></br>
			Once the user selects <code>               Return               Generated               Keys              </code>, an auto increment key is added as an output mapping.
		</td>
	</tr>
	<tr>
		<td>Returning Updated Key Count</td>
		<td>
		With the current data services functionality, we don't have a way to indicate that the update operation did not affect any rows. But we can return the updated row count as a response to the client in update/insert queries to indicate how may rows are affected by the query execution.
		</td>
	</tr>
</table>

For each input, you can specify the following parameter values:

<table>
   <thead>
      <tr>
         <th>Parameter</th>
         <th>Description</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>Parameter Type</td>
         <td>
            <div>
               <div>
                  This is the data type of the input mapping, which determines how the input mapping parameter will be given in the target query.
               </div>
               <ul>
                  <li>SCALAR: In the target query, the parameter will be used as one value.</li>
                  <li>ARRAY: In the target query, the parameter will contain one or many values for a mapped parameter.<br /></li>
               </ul>
               <p>Note that ARRAY parameter type cannot be used with the QUERY_STRING data type (SQL type).</p>
               <p>In the context of RDBMS and SQL datasources, an ARRAY parameter mapped to an SQL query will be expanded to multiple comma separated parameters at runtime. For example, this can be used in SQL statement conditions such as SELECT ... WHERE ... IN(?).</p>
            </div>
         </td>
      </tr>
      <tr>
         <td>SQL Type</td>
         <td>The data type of the corresponding SQL parameter can be selected from this menu. Note that the QUERY_STRING data type cannot be used if the <b>parameter type</b> is set to ARRAY. Read more about <a href="{{base_path}}/reference/synapse-properties/data-services/mapping-data-types">data types</a>.</td>
      </tr>
      <tr>
         <td>Default Value</td>
         <td>
            <div>
            <p>Default values help you automatically assign a value to a parameter when a user has not entered a specific parameter value in a request. Therefore, this value gets automatically added to the query if it is ignored by the user.</p>
            <p>You can refer to internal property values using default values. You can use special system variables that are defined as default values. At the moment, it only provides a variable for retrieving the username of the current user authenticated in a secured data service. You can access this variable as follows:<br /></p>
            <ul>
               <li>
                  <code>{USERNAME}</code>: Dynamically replaces the input mapping with the current user's username when a data service request is processed.
               </li>
               <li>
                  <code>{NULL}</code>: Sets the current input mapping value to null. It's the same as providing <code>xsi:nil</code> in the incoming message's input parameter element.
               </li>
               <li>
                  <code>{USER_ROLES}</code>: This value contains the list of user roles that the current calling user has. If the parameter mapped is an ARRAY, it will have the full list of user roles. If it's a SCALAR, it will only contain the first user role of the user.
               </li>
            </ul>
         </td>
      </tr>
      <tr>
         <td>IN/OUT Type</td>
         <td>These are used in stored procedures. IN is the usual parameter we give to provide some value. OUT only returns a value from a stored procedure. INOUT does both.</td>
      </tr>
      <tr>
         <td>Validators</td>
         <td>
         	See <a href="{{base_path}}/reference/synapse-properties/data-services/input-validators">input validators</a>
         </td>
      </tr>
   </tbody>
</table>

## Output parameters

Just as Input mapping allows you to add parameters to a query, output
mapping determines how the output of a query should be presented. Use
this section to specify how the result of the query should be presented.
You can choose XML, JSON, or RDF as the format of the result, along with
the parameters that should be used to represent the data.

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
			Output Type
		</td>
		<td>
			The output type determines the format in which the query output will be presented. You can select either XML, RDF, or JSON.
		</td>
	</tr>
	</tr>
	<tr>
		<td>Use Column Numbers</td>
		<td>
		If this option is selected, the mapping will be done by the column number basis instead of the column name.
		</td>
	</tr>
	<tr>
		<td>Escape Non Printable Characters</td>
		<td>Use this option if the data in your database consists of characters that are not serializable to XML. Few examples are " '. When you invoke services that access such data and produce responses, the sever throws errors. This option ensures that non-printable characters will be ignored when producing the responses.</td>
	</tr>
</table>

The following parameters are configurable for XML/RDF output types.

<table style="width:100%;">
<colgroup>
<col style="width: 5%" />
<col style="width: 94%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Generate Output Mapping</td>
<td><div class="content-wrapper">
<p>Note that this option is only available for <code>               SELECT              </code> statements excluding <code>               SELECT *              </code> , and for datasources such as RDBMS.</p>
<p>If you have defined an SQL query, you can generate output mappings corresponding to the fields specified in the query by clicking <strong>Generate Response</strong>. In the example shown below, there is an SQL query that needs to output values for the <code>customernumber</code> and <code>customername</code> fields in the <code>customers</code> table.</p>
<p>
</p>
</div></td>
<tr class="even">
<td>Row Namespace</td>
<td>See <a href="{{base_path}}/reference/synapse-properties/data-services/using-namespaces">Defining Namespaces</a> .</td>
</tr>
</tbody>
</table>

For each output element, you can specify the following parameters:

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
			Mapping Type
		</td>
		<td>
			Select the mapping type.
		</td>
	</tr>
	<tr>
		<td>
			Output Field Name
		</td>
		<td>
			The name for the output field.
		</td>
	</tr>
	<tr>
		<td>
			Datasource Type
		</td>
		<td>
			Select the datasource type.
		</td>
	</tr>
	<tr>
         <td>Parameter Type</td>
         <td>
            <div>
               <div>
                  This is the data type of the output element.
               </div>
               <ul>
                  <li>SCALAR: The parameter will be used as one value.</li>
                  <li>ARRAY: The parameter will contain one or many values for a mapped parameter.<br /></li>
               </ul>
            </div>
         </td>
    </tr>
	<tr>
		<td>
			Export Name
		</td>
		<td>
			Give name for the export. The result element can be declared to be exported with a given name when defining a query in a data service.</br></br>
			The query request export feature must be used in conjunction with request box. It allows individual queries executed in a request to communicate with each other. The concept is 'exporting' a specific result element so that the next calling query will get that result element as a query parameter. Therefore, if you have two queries (namely 'query1' and 'query2') that is executed sequentially in a request box, and if 'query1' has a specific result element and if that element is exported with the name 'foo', then 'query2' also gets a query param named 'foo'. Therefore, when this request box session is executed, the query1's exported value will be passed into query2 as an input parameter. This feature is very useful in situations where the result of an earlier-executed query is required for the execution of a subsequent query (e.g. a newly created primay key).
		</td>
	</tr>
	<tr>
		<td>
			Export Type
		</td>
		<td>
			There are two export types that can be used.
			<ul>
				<li><strong>SCALAR</strong>: The single element value is exported. If there are multiple instances of this value, the last one will be exported.
				</li>
				<li><strong>ARRAY</strong>: An array of values will be exported. Each occurrence of the value is added to an array and exported.
				</li>
			</ul>
		</td>
	</tr>
</table>

## Advanced query parameters

Advanced query properties help define additional features when querying an RDBMS. Query property details are described below.

<table>
<tr class="header">
<th><p>Property Name</p></th>
<th><p>Description</p></th>
</tr>
<tbody>
<tr class="odd">
<td><p>Timeout</p></td>
<td><p>Sets a timeout for the underlying JDBC query.</p></td>
</tr>
<tr class="even">
<td>
	<p>Fetch Direction</p></td>
<td>
	<ul>
		<li>
			<b>Forward</b>: Rows in a result set will be processed in a forward direction; first-to-last.
		</li>
		<li>
			<b>Backward</b>: Rows in a result set will be processed in reverse direction; last-to-first. 
		</li>
	</ul>
</td>
</tr>
<tr class="odd">
<td><p>Fetch Size</p></td>
<td><p>The number of rows that should be fetched from the database when more rows are needed. If the fetch size is zero, the JDBC driver ignores the value and is free to make its own best guess as to what the fetch size should be. Note that the fetch size is set to a lower value in the Micro Integrator by default. However, if you expect a very large number of rows to be fetched, you should increase the fetch size accordingly (e.g. 1000) to improve performance.</p></td>
</tr>
<tr class="even">
<td><p>Max Field Size</p></td>
<td><p>Maximum data size for the field.<br />
Used to reduce the size each field takes in order to eliminate the possibility of hitting a db limit.</p></td>
</tr>
<tr class="odd">
<td><p>Max Rows</p></td>
<td><p>Maximum number of rows to be returned. Zero means all rows.</p></td>
</tr>
<tr class="even">
<td><p>Force Stored Procedure</p></td>
<td><p>Forces the current SQl statement as a stored procedure.</p></td>
</tr>
<tr class="odd">
<td><p>Force JDBC Batch Requests</p></td>
<td><p>Forces to use native JDBC batch request.</p></td>
</tr>
</tbody>
</table>