# Exposing an CSV Datasource

This example demonstrates how CSV data can be exposed as a data service.

## Prerequisites

!!! Info
    Note that you can only read data from CSV files. The Micro Integrator does not support inserting, updating, or modifying data in a CSV file.

[Download](https://github.com/wso2-docs/WSO2_EI/blob/master/data-service-resources/Products.csv) the `Products.csv` file.

This file contains data about products (cars/motorcycles) that are
manufactured in an automobile company. The data table has the following
columns: `ID` , `Name` ,
`Classification` , and `Price`.

## Synapse configuration
Given below is the data service configuration you need to build. See the instructions on how to [build and run](#build-and-run) this example.

**Be sure** to update the CSV datasource path.

```xml
<data name="CSV" transports="http https local">
   <config enableOData="false" id="CSV">
      <property name="csv_datasource">/path/to/csv/Products.csv</property>
      <property name="csv_columnseperator">,</property>
      <property name="csv_startingrow">2</property>
      <property name="csv_hasheader">true</property>
      <property name="csv_headerrow">1</property>
   </config>
   <query id="Q1" useConfig="CSV">
      <result element="Products" rowName="Product">
         <element column="ID" name="ID" xsdType="string"/>
         <element column="Classification" name="Classification" xsdType="string"/>
         <element column="Price" name="Price" xsdType="string"/>
         <element column="Name" name="Name" xsdType="string"/>
      </result>
   </query>
   <operation name="GetProductsOp">
      <call-query href="Q1"/>
   </operation>
   <resource method="GET" path="Products">
      <call-query href="Q1"/>
   </resource>
</data>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create a Data Service project]({{base_path}}/integrate/develop/create-data-services-configs).
4. [Create the data service]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services) with the configurations given above.
   **Be sure** to update the CSV datasource path.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator. 

You can send an HTTP GET request to invoke the data service using cURL
as shown below.

```bash
curl -X GET http://localhost:8290/services/CSV.HTTPEndpoint/Products
```

This will return the response in XML.

Example:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Products xmlns="http://ws.wso2.org/dataservice">
   <Product>
      <ID>S10_1678</ID>
      <Category>Motorcycles</Category>
      <Price>1000</Price>
      <Name>1969 Harley Davidson
 Ultimate Chopper</Name>
   </Product>
   <Product>
      <ID>S10_1949</ID>
      <Category>Classic Cars</Category>
      <Price>600</Price>
      <Name>1952 Alpine Renault 1300</Name>
   </Product>
   <Product>
      <ID>S10_2016</ID>
      <Category>Motorcycles</Category>
      <Price>456</Price>
      <Name>1996 Moto Guzzi 1100i</Name>
   </Product>
   <Product>
      <ID>S10_4698</ID>
      <Category>Motorcycles</Category>
      <Price>345</Price>
      <Name>2003 Harley-Davidson Eagle Drag Bike</Name>
   </Product>
   <Product>
      <ID>S10_4757</ID>
      <Category>Classic Cars</Category>
      <Price>230</Price>
      <Name>1972 Alfa Romeo GTA</Name>
   </Product>
   <Product>
      <ID>S10_4962</ID>
      <Category>Classic Cars</Category>
      <Price>890</Price>
      <Name>1962 LanciaA Delta 16V</Name>
   </Product>
   <Product>
      <ID>S12_1099</ID>
      <Category>Classic Cars</Category>
      <Price>560</Price>
      <Name>1968 Ford Mustang</Name>
   </Product>
   <Product>
      <ID>S12_1108</ID>
      <Category>Classic Cars</Category>
      <Price>900</Price>
      <Name>2001 Ferrari Enzo</Name>
   </Product>
</Products>
```