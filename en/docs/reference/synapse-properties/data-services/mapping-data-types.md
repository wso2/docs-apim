# SQL/Data Types

This section describes the data types that are used when defining [Input and Output Mappings]({{base_path}}/reference/synapse-properties/data-services/query-parameters) in a data service:

## Array data type

Array parameter type enables data services to dynamically provide a set
of values without knowing the size of the data set beforehand.
Generally, multiple data types are used for building queries for more
complex inputs. Array data type is available as a parameter type when
creating input mapping queries that are defined while creating a data
service.  

Let's see how array types are handled internally in the SOAP
message-level. When the parameters are serialized (in scalar types),
there is only one element per parameter in the SOAP message. In arrays,
the element representing the parameter is repeated. For example, refer
to the sample SOAP message below, which contains the array type
`employeeNumbers`.

```xml
...
<s:Body>
   <p:setSalaryForEmployees xmlns:p="http://ws.wso2.org/dataservice/samples/rdbms_sample">
      <salary xmlns="http://ws.wso2.org/dataservice/samples/rdbms_sample">15000</salary>
      <employeeNumbers xmlns="http://ws.wso2.org/dataservice/samples/rdbms_sample">1002</employeeNumbers>
      <employeeNumbers xmlns="http://ws.wso2.org/dataservice/samples/rdbms_sample">2014</employeeNumbers>
      <employeeNumbers xmlns="http://ws.wso2.org/dataservice/samples/rdbms_sample">4411</employeeNumbers>
   </p:setSalaryForEmployees>
</s:Body>
</s:Envelope>
```

Array types are properly mentioned in the WSDL generation. As a result,
it is suitably presented in a service that is code generated.

!!! Note
	Note that the ARRAY parameter type cannot be used with the `QUERY_STRING` data type.

## Binary data type

When using data services, you might come across the need to transfer binary
data from/to the server. This is handled using Base64 encoding. When
sending, binary data must be encoded in Base64 format. Similarly, when
receiving, the receiving character data must be Base64-decoded in order
to retrieve the original binary data.

Binary data type is available as an **SQL Type** when creating input
mappings for your queries.

When defining the result of a data service, in order to declare that a
binary value is expected, add a suitable entry in Output Mappings. The
**Schema Type** of the Output Mapping should be selected as "
[xs:base64Binary](http://xsbase64Binary) ."

When using code-generated clients, the encoding/decoding of Base64 data
need not be explicitly done by the user since the existence of binary
data is mentioned in the WSDL. For example, in Axis2 code-generated
stubs, the binary types are handled using the "DataHandler" class.

## User-defined data types

Apart from the standard data types (such as Varchar, Integer, etc.) it is also possible to query custom objects, which are usually called 'User Defined Types' (UDT). Users can query UDTs
with ordinary SQL queries as well as OUT parameters of stored procedures.

#### Query UDTs with ordinary SQL queries 

In this option, you are only required to define an output mapping
corresponding to the UDT that is to be queried. An important point is that the
attributes of a UDT is queried depending on the order they are specified
in the UDT. For example, if the UDT carries the structure below, the
attribute index "0" maps to the attribute "Id".  

```bash
"SampleUDT{Id Integer, Name Varchar(100)}"
```

Similarly, the "Name" attribute can be retrieved via the index "1".

#### Query UDTs via OUT parameters of a stored procedure 

It is possible to retrieve the values of UDTs via the OUT parameters
defined in stored procedures. The user should define an input mapping as
an OUT parameter as well as an output mapping in order to actually
retrieve the values of the UDT attributes.   

## TIMESTAMP data type

If you are writing a query for a column in the database that requires a
value in the form of a date and time, the `         TIMESTAMP        `
data type should be used for the mapping in the data service. The format
of the `         TIMESTAMP        ` value should be as follows: '
YYYY-MM-DD **T** hh:mm:ss\[.mmm\]'. Note that ' **T** ' should be
included to indicate the start of the time value in the time stamp.

!!! Note
    The `         TIMESTAMP        ` data type is synonymous to the `         DATETIME        ` data type. Therefore, if you are writing a query for a column of `         DATETIME        ` type , you can use `         TIMESTAMP        ` in your input/output mapping.