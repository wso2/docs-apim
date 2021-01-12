# Data Mapper JSON Schema Specification

The following specification defines the Data Mapper JSON schema of the
ESB profile . It is intended to be the authoritative specification.
Implementations of schemas for the Data Mapper mediator must adhere to
this.

## Schema declaration

A schema is represented in JSON by one of:

-   A JSON string, naming a defined type.
-   A JSON object, of the form:
    `           {"type": "typeName" ...attributes...}          ` , where
    `           typeName          ` is either a primitive or a derived
    type name, as defined below.
-   A JSON array, representing a union of embedded types.

A Data Mapper schema should start with the `          $schema         `
attribute with the Data Mapper schema version. For example:
`          { “$schema”:”                     http://wso2-data-mapper-json-schema/1.0v                    ”}         `

Also, it can contain following optional attributes that will define more
information about the schema.

-   **“id”** : a JSON string declaring a unique identifier for the
    schema.
-   **“title”** : a JSON string defining the root element name.
-   **“description”** : a JSON string providing a detailed description
    about the schema.
-   **“type”** : a JSON string providing the element type.
-   **“namespaces”** : a JSON array of JSON objects defining namespaces
    and prefix values used in the schema as shown in the following
    example.  
      

``` js
{ “$schema” : ”http://wso2-data-mapper-json-schema/1.0v”,
“id”:”http://wso2-data-mapper-json-schema-sample-o1”,
“title”:”RootElement”,
"type":"object",
“description”:”This schema represent any form of object without any restriction” ,
"namespaces":[
{ "prefix":"ns1", "url":"http://ns1.com"},
{"prefix":"ns2", "url":"http://ns2.com"}]
}
```

## Primitive types

Primitive types have no specified attributes. The set of primitive type
names are as follows.

-   **null** : no value
-   **boolean** : a binary value
-   **integer** : integer value
-   **number** : rational numbers
-   **string** : unicode character sequence

Primitive type names are also defined type names. Thus, for example, the
schema "string" is equivalent to:
`          {"type": "string"}         `

## Complex types

The Data Mapper schema supports the following complex types: object and
array.

### Object

Object uses the type name `          “object”         ` , and supports
the following attributes.

-   **“id”** : a JSON string declaring a unique identifier for the
    object (required).
-   **“type”** : a JSON string providing the element type.
-   **“description”** : a JSON string providing documentation to the
    user of this schema.
-   **“properties”** : a JSON object listing fields (required). Each
    field is a JSON object.
-   **“attributes”** : a JSON object listing XML attribute fields. Each
    field is a JSON object.

### Arrays

Arrays use the type name `          "array"         ` , and support a
single attribute out of the following.

-   **“items”** : the schema representing the items of the of the array.
-   **“id”** : a JSON string declaring a unique identifier for the
    object (required).
-   **“attributes”** : a JSON object listing XML attribute fields. Each
    field is a JSON object.
-   **“description”** : a JSON string providing documentation to the
    user of this schema

For example, an array of an object containing a field named
`          firstname         ` is declared as shown below.

``` java
{
"type": "array", 
"items": [
{
            "id":"http://jsonschema.net/employee/0",
            "type":"object",
            "properties":{
“firstname":{
                    "id":"http://jsonschema.net/employee/0/firstname",
                    "type":"string"
                }
}
}]
}
```

## Defining WSO2 schemas to represent an XML payload

There are differences between XML and JSON message specifications.
Therefore, to represent XML message formats in JSON schemas, you need to
introduce a few more configurations as explained below.

### Representing XML attributes and namespaces in WSO2 JSON schemas

For example, you can build a JSON schema, which follows the WSO2
specification using the following XML code as described below.


``` xml
<?xml version="1.0" encoding="UTF-8"?>
<ns:employees xmlns:ns="http://wso2.employee.info" xmlns:sn="http://wso2.employee.address">
   <ns:employee>
      <ns:firstname>Mark</ns:firstname>
      <ns:lastname>Taylor</ns:lastname>
      <sn:addresses>
         <sn:address location="home">
            <sn:city postalcode="30000">LA</sn:city>
            <sn:road>baker street</sn:road>
         </sn:address>
         <sn:address location="office">
            <sn:city postalcode="10003">Colombo 03</sn:city>
            <sn:road>duplication road</sn:road>
         </sn:address>
      </sn:addresses>
   </ns:employee>
   <ns:employee>
      <ns:firstname>Mathew</ns:firstname>
      <ns:lastname>Hayden</ns:lastname>
      <sn:addresses>
         <sn:address location="home">
            <sn:city postalcode="60000">Sydney</sn:city>
            <sn:road>101 street</sn:road>
         </sn:address>
         <sn:address location="office">
            <sn:city postalcode="10003">Colombo 03</sn:city>
            <sn:road>duplication road</sn:road>
         </sn:address>
      </sn:addresses>
   </ns:employee>
</ns:employees
```

!!! Info
    WSO2 Data Mapper supports o nly single rooted XML messages. In the above
example, `           employees          ` is the root element of the
payload, and it should be the value of the `           title          `
element.


Also, there are two namespace values used. Those should be listed under
the `           namespaces          ` field with any prefix value.

!!! Info
    Prefix value can be any valid string that contains only \[a-z,A-Z,0-1\]
characters. You need not match them with the prefix values of the
sample.


When you include above information, the schema will be as follows.

!!! Info
    The `           "required"          ` field specifies the fields that
are mandatory to contain in that level of schema.


``` js
 { “$schema” : ”http://wso2-data-mapper-json-schema/1.0v”,
“id”:”http://wso2-data-mapper-json-schema-sample-o1”,
“title”:”employees”,
"type":"object",
“description”:”This schema represent wso2 employee xml message format” ,
 "required":[
    "employees"
   ],
"namespaces":[
{ "prefix":"ns1", "url":"http://wso2.employee.info"},
{"prefix":"ns2", "url":"http://wso2.employee.address"}]
}
```

#### Including the child elements and attribute values

Define child elements under the `           ”properties”          `
field as a JSON object with fields to describe the child element. In the
above employee example, the `           employees          ` element
contains an array of similar employee elements. Hence, this can be
represented as the following schema.

``` js
 { “$schema” : ”http://wso2-data-mapper-json-schema/1.0v”,
“id”:”http://wso2-data-mapper-json-schema-sample-employees”,
“title”:”employees”,
"type":"object",
“description”:”This schema represent wso2 employee xml message format” ,
“properties”: {
    “employee”:{
"id":"http://wso2-data-mapper-json-schema-sample-employees/employee",
                "type":"array",
            “Items”:[ ],
        "required":[ "arrayRequired" ]                  
        }
    },
"required":[
    "employees"
   ],
"namespaces":[
{ "prefix":"ns1", "url":"http://wso2.employee.info"},
{"prefix":"ns2", "url":"http://wso2.employee.address"}]
}
```

Since the `           employee          ` element is an array type
element, it contains a field named `           “items”          ` ,
which defines the element format of the array of employee elements. It
contains three child fields as `           firstname          ` ,
`           lastname          ` , `          ` and
`           address          ` with string, string, and object types
accordingly. Hence, when you include these elements into the schema, it
will look as the following schema.

``` js
 { “$schema” : ”http://wso2-data-mapper-json-schema/1.0v”,
“id”:”http://wso2-data-mapper-json-schema-sample-employees”,
“title”:”employees”,
"type":"object",
“description”:”This schema represent wso2 employee xml message format” ,
“properties”: {
    “employee”:{
"id":"http:/….employees/employee",
                "type":"array",
            “Items”:[{
                        "id":"http://jsonschema.net/employee/0",
                        "type":"object",
                        "properties":{
                                "firstname":{
                                    "id":"http://.../employee/firstname",
                                    "type":"string"
                                    },
                                "lastname":{
                                    "id":"http://.../employee/lastname",
                                    "type":"string"
                                    },
                                "addresses":{
                                    "id":"http://.../employee//addresses",
                                    "type":"object",
                                    "properties":{
                                            "address":{
                                            "id":"http://.../employee/
addresses/address",
                                            "type":"array",
                                            "Items":[ … ]
                                            }
                                    }
                                }
                        },
                        "required":[
                                    "firstname",
                                    "lastname",
                                    "address"
                                ]
                        } ],
             "required":["arrayRequired" ]
        }
    },
   "required":["employees" ],
"namespaces":[
{ "prefix":"ns1", "url":"http://wso2.employee.info"},
{"prefix":"ns2", "url":"http://wso2.employee.address"}]
}
```

Define the XML attributes under the `           “attributes”          `
field similar to the "properties in the element definition. In the above
employees example, address array element and city element contain
attributes, and those can be represented as follows.

``` js
"addresses":{
                 "id":"http://.../addresses",
                 "type":"object",
                 "properties":{
                    "address":{
                            "id":"http://.../addresses/address",
                            "type":"array",
                            "items":[
                                    {
                                    "id":"http://.../addresses/address/element",
                                    "type":"object",
                                    "properties":{
                                                            "city":{
                                                "id":"http://.../addresses/address/element/city",
                                                "type":"string",
                                            "attributes":{
                                                        "postalcode":{
                                                                "id":".../element/city/postalcode",
                                                                "type":"string"
                                                            }
                                                    }
                                                },
                                            "road":{
                                                "id":".../addresses/address/element/road",
                                                "type":"string"
                                                }
                                        }
                                    }],
        “attributes”:{
            "location":{
                                        "id":".../addresses/address/element/location",
                                        "type":"string"
                                        }
            }
                        }
                } 
```

Now, the format of the XML payload is complete. However, you need to
define namespaces. You have defined the namespaces used in the payload
before with prefix values in the root element under the
`          “namespaces”         ` tag. To assign the namespace to each
element, you should only add the prefix before the element name with a
colon as `          “ns1:employees”         `,
`          “ns1:employee”         ` etc.

The complete schema to represent the employee payload is as follows.

``` java
{
  “$schema” : ”http://wso2-data-mapper-json-schema/1.0v”,
  “id”:”http://wso2-data-mapper-json-schema-sample-employees”,
  “title”:”ns2:employees”,
  "type":"object",
  “description”:”This schema represent wso2 employee xml message format” ,
  “properties”: {
    "ns2:employee":{
        "id":"http://.../employee",
        "type":"array",
        "items":[
            {
                "id":"http://.../employee/element",
                "type":"object",
                "properties":{
                        "ns2:firstname":{
                            "id":"http://.../employee/element/firstname",
                            "type":"string"
                            },
                        "ns2:lastname":{
                            "id":"http://.../employee/element/lastname",
                            "type":"string"
                            },
                        "ns1:addresses":{
                            "id":"http://.../employees/employee/element/addresses",
                            "type":"object",
                            "properties":{
                                    "ns1:address":{
                                        "id":"http://.../addresses/address",
                                        "type":"array",
                                        "items":[
                                                {
                                "id":"http://.../addresses/address/0",
                                "type":"object",
                                "properties":{
                                        “ns1:city":{
                                            "id":"http://.../addresses/address/element/city",
                                            "type":"string",
                                            "attributes":{
                                                    "postalcode":{
                                                            "id":"http://.../city/-postalcode",
                                                            "type":"string"
                                                        }
                                                }
                                            },
                                        "ns1:road":{
                                            "id":"http://.../addresses/address/element/road",
                                            "type":"string"
                                            }
                                    }
            “attributes”: {
                "location":{
                                        "id":"http://jsonschema.net/employees/employee/0/addresses/address/0/-location",
                                        "type":"string"
                                            },
}
                                }
                            ]
                            }
                    }
                }
            },
            "required":[
                "firstname",
                "lastname",
                "address"
            ]
            }
        ],
        "required":[
            "arrayRequired"
        ]
    }
   },
   "required":[
    "employees"
   ],
  "namespaces":[{ "prefix":"ns1", "url":"http://wso2.employee.address"},{"prefix":"ns2", "url":"http://wso2.employee.info"}]

}
```
