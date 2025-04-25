# CSV Module Reference

CSV Module in WSO2 Enterprise Integrator helps working with CSV payloads. This transforms a given payload into another type of payload according to your requirements. You can change the type of the output payload using these transformation configurations as well. You can send the payload to be transformed in multiple ways (e.g., POST request ).

The following transformations can be performed with this module.

!!! Note
    If you use CSV Module 2.x.x you need to add [opencsv-5.10.wso2v1.jar](https://maven.wso2.org/nexus/content/repositories/releases/org/wso2/orbit/com/opencsv/opencsv/5.10.wso2v1/opencsv-5.10.wso2v1.jar) to `<MI-HOME>/lib`.

## CSV to CSV transformation

You can use the CSV to CSV transformation to convert a CSV payload into another CSV payload according to your requirements using the configurations given below.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Header</td>
    <td>headerPresent</td>
    <td>Absent<br>Present</td>
    <td>Specify whether the CSV input has a header row</td>
  </tr>
  <tr>
    <td>Separator</td>
    <td>valueSeparator</td>
    <td>Default : "," (comma)</td>
    <td>Specify the separator to use in the CSV input.<br>To use tab as the separator, use the value tab to this property. To use space, use the value space.</td>
  </tr>
  <tr>
    <td>Skip Headers</td>
    <td>skipHeader</td>
    <td>true, false</td>
    <td>This is available only if the value of the <code>headerPresent</code> property is set to <code>Present</code>. The default value is <code>false</code>.</td>
  </tr>
  <tr>
    <td>Skip Data Rows</td>
    <td>dataRowsToSkip</td>
    <td></td>
    <td>Specify the number of data rows to skip in the CSV. The default is 0.<br>- If headerPresent is Present, then data rows are the rows excluding the first row.<br>- If <code>headerPresent</code> is <code>Absent</code>, then data rows are the rows starting from the first row.<br></td>
  </tr>
  <tr>
    <td>Order by Column</td>
    <td>orderByColumn</td>
    <td></td>
    <td>Order the CSV content by values of the given column. If you want to specify the column by column index, provide the index of the column (Indexes are starting from 1). <br>To specify the column by column name, give the column name within double quotes (e.g., "name"). <br>Specifying the column by column name works only if the value of the <code>headerPresent</code> property is <code>Present</code>.</td>
  </tr>
  <tr>
    <td>Sort Columns</td>
    <td>columnOrdering</td>
    <td>Ascending, Descending</td>
    <td>This option is enabled if the <code>orderByColumn</code> has a value. This determines whether the CSV should be ordered ascendingly or descendingly according to the given column.<br>The default value is <code>Ascending</code>.</td>
  </tr>
  <tr>
    <td>Skip Columns</td>
    <td>columnsToSkip</td>
    <td></td>
    <td>Specify columns to skip from the CSV payload. You can specify the columns as comma-separated values. <br>This property supports more complex queries also, you can find full specifications below in <b>CSV Columns Skipper Query</b>.
  </tr>
  <tr>
    <td>Custom Header</td>
    <td>customHeader</td>
    <td></td>
    <td>Set a custom header to the output CSV payload. If this property not specified, the header for the output CSV is determined as follows,<br>- If the value of the <code>headerPresent</code> is <code>Absent</code> , the output CSV would not have a header.<br>- If the value of the <code>headerPresent</code> is <code>Present</code> and <code>skipHeader</code> is set as <code>true</code>, output CSV would not have a header.<br>- If <code>headerPresent</code> is <code>Present</code> and <code>skipHeader</code> is set as <code>false</code>, output CSV would have the header of the input CSV.<br></td>
  </tr>
  <tr>
    <td>Separator</td>
    <td>customValueSeparator</td>
    <td>Default : "," (comma)</td>
    <td>Values separator to use in the output CSV.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ```
  id,name,email,phone_number  
  1,De witt Hambidge,dwitt0@newsvine.com,true  
  2,Brody Dowthwaite,bdowthwaite1@delicious.com,false  
  3,Catlin Drought,cdrought2@etsy.com,608-510-7991  
  4,Kissiah Douglass,kdouglass3@squarespace.com,true  
  5,Robinette Udey,rudey4@nytimes.com,true  
  ```

A sample synapse configuration for the csvToCsv operation is shown below.

  ```xml
  <CSV.csvToCsv>  
    <headerPresent>Present</headerPresent> 
    <skipHeader>true</skipHeader> 
    <dataRowsToSkip>1</dataRowsToSkip> 
    <orderByColumn>2</orderByColumn> 
    <columnOrdering>Ascending</columnOrdering> 
    <columnsToSkip>"phone_number"</columnsToSkip>	
    <customHeader>index,name,email</customHeader>               
  </CSV.csvToCsv>   
  ```

The following is the sample response, for the request given  above.

  ```
  index,name,email  
  2,Brody Dowthwaite,bdowthwaite1@delicious.com  
  3,Catlin Drought,cdrought2@etsy.com  
  4,Kissiah Douglass,kdouglass3@squarespace.com  
  5,Robinette Udey,rudey4@nytimes.com  
  ```

## CSV to JSON transformation

You can use the CSV to JSON transformation to convert a CSV payload into a JSON payload according to your requirements using the configurations given below.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Header</td>
    <td>headerPresent</td>
    <td>Absent<br>Present</td>
    <td>Specify whether the CSV input has a header row</td>
  </tr>
  <tr>
    <td>Separator</td>
    <td>valueSeparator</td>
    <td>Default : "," (comma)</td>
    <td>Specify the separator to use in the CSV input.<br>To use tab as the separator, use the value tab to this property. To use space, use the value space.</td>
  </tr>
  <tr>
    <td>Skip Headers</td>
    <td>skipHeader</td>
    <td>true, false</td>
    <td>This is available only if the value of the <code>headerPresent</code> property is set to <code>Present</code>. The default value is <code>false</code>.</td>
  </tr>
  <tr>
    <td>Skip Data Rows</td>
    <td>dataRowsToSkip</td>
    <td></td>
    <td>Specify the number of data rows to skip in the CSV. The default is 0.<br>- If headerPresent is Present, then data rows are the rows excluding the first row.<br>- If <code>headerPresent</code> is <code>Absent</code>, then data rows are the rows starting from the first row.<br></td>
  </tr>
  <tr>
    <td>Empty Values</td>
    <td>csvEmptyValues</td>
    <td></td>
    <td>Specify how to treat empty CSV values in the output JSON.</td>
  </tr>
  <tr>
    <td>JSON Keys</td>
    <td>jsonKeys</td>
    <td></td>
    <td>If you need to set custom keys in the JSON output, specify JSON keys in this property. Use a set of comma-separated strings as JSON keys. (eg: name,email). If this property is not specified, JSON keys of the output are determined as follows,<br>-If the value of the headerPresent is Absent , JSON keys would be autogenerated (eg: key-1, key-2).<br>- If the value of the headerPresent is Present, CSV header values would be used as the JSON keys.</td>
  </tr>
  <tr>
    <td>Data Types</td>
    <td>dataTypes</td>
    <td></td>
    <td>This property represents the data types of JSON fields. Supporting data types are, String, Boolean, Integer and Number. <br>The input for this property is a JSON. It is easy to config this with the Integrations Studio Property view . <br>For this property, the property view provides a table with columns, "Column Name Or Index", "Is Column Name" and "Data Type". "Column Name Or Index" column accepts an index or name of a CSV column which you need to change the data type in the output JSON. "Is Column Name" gives you a dropdown with values Yes and No. <br>The Default is Yes. The value Yes means, you have input a column name in the Column Name Or Index column. <br>No means, you have given an index in the Column Name Or Index column. "Data Type" column represents the output data type.</td>
  </tr>
  <tr>
    <td>Root JSON Key</td>
    <td>rootJsonKey</td>
    <td></td>
    <td>If you need to wrap the JSON output inside a wrapper object, specify the key for the wrapper object.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ```
  id,name,email,phone_number  
  1,De witt Hambidge,dwitt0@newsvine.com,true  
  2,Brody Dowthwaite,bdowthwaite1@delicious.com,false  
  3,Catlin Drought,cdrought2@etsy.com,608-510-7991  
  4,Kissiah Douglass,kdouglass3@squarespace.com,true  
  5,Robinette Udey,rudey4@nytimes.com,true 
  ```

A sample synapse configuration for the csvToJson operation is shown below.

  ```xml
  <CSV.csvToJson>
      <headerPresent>Present</headerPresent>
      <skipHeader>true</skipHeader>
      <columnsToSkip>"phone_number"</columnsToSkip>
      <dataRowsToSkip>1</dataRowsToSkip>
      <csvEmptyValues>Null</csvEmptyValues>
      <jsonKeys>index,name,email</jsonKeys>
      <dataTypes>[{"Column Name Or Index":"id","Is Column Name":"Yes","Data Type":"Number"},{"Column Name Or Index":"2","Is Column Name":"No","Data Type":"String"}]</dataTypes>
      <rootJsonKey>results</rootJsonKey>
  </CSV.csvToJson>
  ```

The following is the sample response, for the request given  above.

  ```JSON
  {
      "results": [
          {
              "index": 2.0,
              "name": "Brody Dowthwaite",
              "email": "bdowthwaite1@delicious.com"
          },
          {
              "index": 3.0,
              "name": "Catlin Drought",
              "email": "cdrought2@etsy.com"
          },
          {
              "index": 4.0,
              "name": "Kissiah Douglass",
              "email": "kdouglass3@squarespace.com"
          },
          {
              "index": 5.0,
              "name": "Robinette Udey",
              "email": "rudey4@nytimes.com"
          }
      ]
  }
  ``` 

## CSV to XML transformation

You can use the CSV to XML transformation to convert a CSV payload into a XML payload according to your requirements using the configurations given below.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Header</td>
    <td>headerPresent</td>
    <td>Absent<br>Present</td>
    <td>Specify whether the CSV input has a header row</td>
  </tr>
  <tr>
    <td>Separator</td>
    <td>valueSeparator</td>
    <td>Default : "," (comma)</td>
    <td>Specify the separator to use in the CSV input.<br>To use tab as the separator, use the value tab to this property. To use space, use the value space.</td>
  </tr>
  <tr>
    <td>Skip Headers</td>
    <td>skipHeader</td>
    <td>true, false</td>
    <td>This is available only if the value of the <code>headerPresent</code> property is set to <code>Present</code>. The default value is <code>false</code>.</td>
  </tr>
  <tr>
    <td>Skip Data Rows</td>
    <td>dataRowsToSkip</td>
    <td></td>
    <td>Specify the number of data rows to skip in the CSV. The default is 0.<br>- If headerPresent is Present, then data rows are the rows excluding the first row.<br>- If <code>headerPresent</code> is <code>Absent</code>, then data rows are the rows starting from the first row.<br></td>
  </tr>
  <tr>
    <td>Skip Columns</td>
    <td>columnsToSkip</td>
    <td></td>
    <td>Specify columns to skip from the CSV payload. You can specify the columns as comma-separated values. <br>This property supports more complex queries also, you can find full specifications below in <b>CSV Columns Skipper Query</b>.
  </tr>
  <tr>
    <td><b>Root Element Group</b></td>
    <td></td>
    <td></td>
    <td>You can use the properties under this group to config the root XML element of the output XML payload. You can find the following properties under the root element group.</td>
  </tr>
  <tr>
    <td>Tag</td>
    <td>rootElementTag</td>
    <td></td>
    <td>Name of the XML tag of the root element. The default value is root.</td>
  </tr>
  <tr>
    <td>Namespace</td>
    <td>rootElementNamespace</td>
    <td></td>
    <td>Namespace of the root element.</td>
  </tr>
  <tr>
    <td>Namespace URI</td>
    <td>rootElementNamespaceURI</td>
    <td></td>
    <td>Namespace URI of the root element.</td>
  </tr>
  <tr>
    <td><b>Group Element Group</b></td>
    <td></td>
    <td></td>
    <td>The properties under this group are for configuring the group elements of the output XML payload. You can find the following properties under the group element group.</td>
  </tr>
  <tr>
    <td>Tag</td>
    <td>groupElementName</td>
    <td></td>
    <td>Name of the XML tag of the group element. The default value is group.</td>
  </tr>
  <tr>
    <td>Namespace</td>
    <td>groupElementNamespace</td>
    <td></td>
    <td>Namespace of the group element.</td>
  </tr>
  <tr>
    <td>Namespace URI</td>
    <td>groupElementNamespace</td>
    <td></td>
    <td>Namespace URI of the group element.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ```
  id,name,email,phone_number  
  1,De witt Hambidge,dwitt0@newsvine.com,true  
  2,Brody Dowthwaite,bdowthwaite1@delicious.com,false  
  3,Catlin Drought,cdrought2@etsy.com,608-510-7991  
  4,Kissiah Douglass,kdouglass3@squarespace.com,true  
  5,Robinette Udey,rudey4@nytimes.com,true 
  ```

A sample synapse configuration for the csvToXml operation is shown below.

  ```xml
  <CSV.csvToXml>
      <headerPresent>Present</headerPresent>
      <skipHeader>true</skipHeader>
      <columnsToSkip>"phone_number"</columnsToSkip>
      <tagNames>index,name,email</tagNames>
      <rootElementTag>results</rootElementTag>
      <groupElementTag>result</groupElementTag>
  </CSV.csvToXml>
  ```

The following is the sample response, for the request given above.

  ```xml
  <results>
      <result>
          <index>1</index>
          <name>De witt Hambidge</name>
          <email>dwitt0@newsvine.com</email>
      </result>
      <result>
          <index>2</index>
          <name>Brody Dowthwaite</name>
          <email>bdowthwaite1@delicious.com</email>
      </result>
      <result>
          <index>3</index>
          <name>Catlin Drought</name>
          <email>cdrought2@etsy.com</email>
      </result>
      <result>
          <index>4</index>
          <name>Kissiah Douglass</name>
          <email>kdouglass3@squarespace.com</email>
      </result>
      <result>
          <index>5</index>
          <name>Robinette Udey</name>
          <email>rudey4@nytimes.com</email>
      </result>
  </results>
  ``` 

## JSON to CSV transformation

You can use the JSON to CSV transformation to convert a JSON payload into a CSV payload according to your requirements using the configurations given below.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>CSV Header</td>
    <td>customHeader</td>
    <td></td>
    <td>Set a custom header to the output CSV payload. If this property is not specified, the key values of the input would be used as the output CSV headers.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ``` json
  [
      {
          "id": "1",
          "name": "De witt Hambidge",
          "email": "dwitt0@newsvine.com",
          "phone_number": "true"
      },
      {
          "id": "2",
          "name": "Brody Dowthwaite",
          "email": "bdowthwaite1@delicious.com",
          "phone_number": "false"
      },
      {
          "id": "3",
          "name": "Catlin Drought",
          "email": "cdrought2@etsy.com",
          "phone_number": "608-510-7991"
      },
      {
          "id": "4",
          "name": "Kissiah Douglass",
          "email": "kdouglass3@squarespace.com",
          "phone_number": "true"
      },
      {
          "id": "5",
          "name": "Robinette Udey",
          "email": "rudey4@nytimes.com",
          "phone_number": "true"
      }
  ]
  ```
A sample synapse configuration for the jsonToCsv operation is shown below.

  ``` xml
  <CSV.jsonToCsv>
      <customHeader>index,name,email,number</customHeader>
  </CSV.jsonToCsv>
  ```
The following is the sample response, for the request given above.

  ```
  index,name,email,number
  1,De witt Hambidge,dwitt0@newsvine.com,true
  2,Brody Dowthwaite,bdowthwaite1@delicious.com,false
  3,Catlin Drought,cdrought2@etsy.com,608-510-7991
  4,Kissiah Douglass,kdouglass3@squarespace.com,true
  5,Robinette Udey,rudey4@nytimes.com,true
  ```

## XML to CSV transformation

You can use the XML to CSV transformation to convert a XML payload into a CSV payload according to your requirements using the configurations given below.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>CSV Header</td>
    <td>customHeader</td>
    <td></td>
    <td>Set a custom header to the output CSV payload. If this property is not specified, Key values of the input would be used as the output CSV headers.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ``` xml
  <root>
      <group>
          <id>1</id>
          <name>De witt Hambidge</name>
          <email>dwitt0@newsvine.com</email>
          <phone_number>true</phone_number>
      </group>
      <group>
          <id>2</id>
          <name>Brody Dowthwaite</name>
          <email>bdowthwaite1@delicious.com</email>
          <phone_number>false</phone_number>
      </group>
      <group>
          <id>3</id>
          <name>Catlin Drought</name>
          <email>cdrought2@etsy.com</email>
          <phone_number>608-510-7991</phone_number>
      </group>
      <group>
          <id>4</id>
          <name>Kissiah Douglass</name>
          <email>kdouglass3@squarespace.com</email>
          <phone_number>true</phone_number>
      </group>
      <group>
          <id>5</id>
          <name>Robinette Udey</name>
          <email>rudey4@nytimes.com</email>
          <phone_number>true</phone_number>
      </group>
  </root>
  ```

A sample synapse configuration for the xmlToCsv operation is shown below.

  ``` xml
  <CSV.xmlToCsv>
    <customHeader>index,name,email,number</customHeader>
  </CSV.xmlToCsv>
  ```

The following is the sample response, for the request given above.

  ```
  index,name,email,number
  1,De witt Hambidge,dwitt0@newsvine.com,true
  2,Brody Dowthwaite,bdowthwaite1@delicious.com,false
  3,Catlin Drought,cdrought2@etsy.com,608-510-7991
  4,Kissiah Douglass,kdouglass3@squarespace.com,true
  5,Robinette Udey,rudey4@nytimes.com,true
  ```

## CSV Columns Skipper Query

The `columnsToSkip` (Skip Columns) property in CSV to JSON, CSV to XML, CSV to CSV operations supports a simple query language to configure the skipping columns.

### Queries

#### Single Column

The column selection query can be a single column representing one column in the CSV. You can represent a column with its index or using the header name for that column.

* Column index : Column indexes are starting from 1. You can give a single column index as the column skipper query. E.g., `3`
* Column name: You can specify a column using its name. Note that, this feature work only if the value of the  `headerPresent` property is `Present`. You can give the column name within double quotations in the columns skipper query. (E.g., `"email"`)

#### Multiple Columns
You can select multiple columns by combining them with a comma (,).

  ```
  1,2,3,
  ```

  ```
  "name":"email"
  ```

  ```
  3:"email"
  ```

#### Element Range
You can specify a range of columns in the query. Use colon character (:) to define a range.

  ```
  1:5
  ```

  ```
  "name":"email"
  ```

  ```
  3:"email"
  ```

You can use asterisk symbol to represent the last column in case you don't know the number of columns. For example if you want to skip all the columns from  column `3`, then use the following query,

  ```
  3:*
  ```

#### Group Elements
You can use opening and closing brackets to define a group of elements. A few examples are shown below.

  ```
  (1:5)
  ```

  ```
  (3,4,"name")
  ```

  ```
  2,3,("name":*)
  ```

#### Not Syntax
You can use the exclamation mark (!) to exclude columns from columns skipper. For example, if you want to skip all the columns from 5 to 10 but want to include 7th column, can use the query given below

  ```
  5:10,!7
  ```
The following is an additional example of how you can use this.

  ```
  3:*,!(10:"email")
  ```