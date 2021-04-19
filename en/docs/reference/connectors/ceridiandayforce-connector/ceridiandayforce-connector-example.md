# Ceridian Dayforce Connector Example 

The Ceridian Dayforce connector allows you to  access the REST API of Ceridian Dayforce HCM. Dayforce is a 
comprehensive human capital management system that covers the entire employee lifecycle including HR, payroll, 
benefits, talent management, workforce management, and services. The entire system resides on cloud that takes the 
burden of managing and replicating data on-premise.

## What you'll build

This example depicts how to use Dayforce connector to:

1. Send GET request to retrieve address of employees from the sample environment defaults
2. Send a POST request to create contacts of an employee. (Note that the POST and PATCH requests will not update the 
sample environment database as it is shared among all developers. However, we will get a response with HTTP code 200)

Both of the two operations are exposed via an API. The API with the context `/dayforceconnector` has three resources  

* `/getEmployeeAddress` - Once invoked, it will retrieve the address information of a specified employee
* `/postEmployeeContact`  - This will create the contact information of an employee when invoked. The relevant 
parameters must be passed in the body as we will see below.

## Setting up the environment 

Please follow the steps mentioned at [Setting up Ceridian Dayforce Environment]({{base_path}}/reference/connectors/ceridiandayforce-connector/ceridiandayforce-connector-config/) document in order to create a Ceridian Dayforce developer account and obtain credentials you need to access the 
Dayforce sample APIs. Keep them saved to be used in the next steps.  

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and import Dayforce connector into it.

{!reference/connectors/importing-connector-to-integration-studio.md!} 

1. Right click on the created ESB Solution Project and select, -> **New** -> **Rest API** to create the REST API.
   <img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" 
   title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

2. Specify the API name as `DayforceConnectorTestAPI` and API context as `/dayforceconnector`. You can go to the 
source view of the XML configuration file of the API and copy the following configuration.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<api context="/dayforceconnector" name="DayforceConnectorTestAPI" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="POST" uri-template="/getEmployeeAddress">
        <inSequence>
            <log level="full" separator=","/>
            <property expression="json-eval($.username)" name="username" scope="default" type="STRING"/>
            <property expression="json-eval($.password)" name="password" scope="default" type="STRING"/>
            <property expression="json-eval($.clientNamespace)" name="clientNamespace" scope="default" type="STRING"/>
            <property expression="json-eval($.apiVersion)" name="apiVersion" scope="default" type="STRING"/>
            <property expression="json-eval($.contextDateRangeFrom)" name="contextDateRangeFrom" scope="default" type="STRING"/>
            <property expression="json-eval($.contextDateRangeTo)" name="contextDateRangeTo" scope="default" type="STRING"/>
            <property expression="json-eval($.xRefCode)" name="xRefCode" scope="default" type="STRING"/>
            <ceridiandayforce.init>
                <username>{$ctx:username}</username>
                <password>{$ctx:password}</password>
                <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
                <apiVersion>{$ctx:apiVersion}</apiVersion>
            </ceridiandayforce.init>
            <ceridiandayforce.getEmployeeAddresses>
                <xRefCode>{$ctx:xRefCode}</xRefCode>
                <contextDate>{$ctx:contextDate}</contextDate>
                <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
                <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
            </ceridiandayforce.getEmployeeAddresses>
            <send/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
    <resource methods="POST" uri-template="/postEmployeeContact">
        <inSequence>
         <log level="full" separator=","/>
         <property expression="json-eval($.username)" name="username"/>
         <property expression="json-eval($.password)" name="password"/>
         <property expression="json-eval($.clientNamespace)" name="clientNamespace"/>
         <property expression="json-eval($.apiVersion)" name="apiVersion"/>
         <property expression="json-eval($.isValidateOnly)" name="isValidateOnly"/>
         <property expression="json-eval($.fieldAndValue)" name="fieldAndValue"/>
         <property expression="json-eval($.xRefCode)" name="xRefCode"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.postEmployeeContacts>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
            <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
         </ceridiandayforce.postEmployeeContacts>
         <send/>
      </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
</api>
```

Now we can export the imported connector and the API into a single CAR application. CAR application is the one we are 
going to deploy to server runtime. 

{!reference/connectors/exporting-artifacts.md!}

Now the exported CApp can be deployed in the integration runtime so that we can run it and test.

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/ceridiandayforce-connector-1.0.0.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!reference/connectors/deploy-capp.md!}

## Testing

We can use Curl or Postman to try the API. The testing steps are provided for curl. Steps for Postman should be 
straightforward and can be derived from the curl requests.  

### GET the address information of an employee in Dayforce

* Invoke the API as shown below using the curl command. Curl Application can be downloaded from 
[here] (https://curl.haxx.se/download.html).

```
curl --location --request POST 'http://192.168.8.100:8290/dayforceconnector/getEmployeeAddress' \
--header 'Content-Type: application/json' \
--data '{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr58.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199"
}'
```

**Note**
* You may have to change the 'http://192.168.8.100:8290' part depending on the ip address on which your integration server instance is running.
* You may have to change the 'clientNamespace' in the request body as Dayforce developer instance gets moved around by Ceridian. The address can be obtained ad mentioned in section Setting up the environment 
 
**Expected Response**:

You should receive 200 OK response with the response body as follows,

```json
{
    "Data": [
        {
            "Address1": "4114 Yonge St.",
            "City": "North York",
            "PostalCode": "M2P 2B7",
            "Country": {
                "Name": "Canada",
                "XRefCode": "CAN",
                "ShortName": "Canada",
                "LongName": "Canada"
            },
            "State": {
                "Name": "Ontario",
                "XRefCode": "ON",
                "ShortName": "Ontario",
                "LongName": "Ontario"
            },
            "EffectiveStart": "2017-01-15T00:00:00",
            "ContactInformationType": {
                "ContactInformationTypeGroup": {
                    "XRefCode": "Address",
                    "ShortName": "Address",
                    "LongName": "Address"
                },
                "XRefCode": "PrimaryResidence",
                "ShortName": "Primary Residence",
                "LongName": "Primary Residence"
            },
            "IsPayrollMailing": false
        }
    ]
}
```
    
### POST the contact information of an employee in Dayforce

* Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).

```
curl --location --request POST 'http://192.168.8.100:8290/dayforceconnector/postEmployeeContact' \
--header 'Content-Type: application/json' \
--data '{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr58.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "isValidateOnly": "FALSE",
  "contextDateRangeFrom": "2017-01-01T13:24:56",
  "fieldAndValue": {
      "ContactNumber": "202 265 8987",
      "Country": {
        "Name": "United States of America",
        "XRefCode": "USA",
        "ShortName": "United States of America",
        "LongName": "United States of America"
      },
      "EffectiveStart": "2000-01-01T00:00:00",
      "ContactInformationType": {
        "ContactInformationTypeGroup": {
          "XRefCode": "Phone",
          "ShortName": "Phone",
          "LongName": "Phone"
        },
        "XRefCode": "HomePhone",
        "ShortName": "Home",
        "LongName": "Home"
      },
      "IsForSystemCommunications": false,
      "IsPreferredContactMethod": false,
      "IsUnlistedNumber": false,
      "IsVerified": false,
      "IsRejected": false,
      "ShowRejectedWarning": true,
      "NumberOfVerificationRequests": 0
    }
}'
```

**Expected Response**:
* You should get a 200 OK response. Please bear in mind that this post will not update the database in the sample 
environment. However, if you use this in a test or production environment changes will be made to the database.

In this example Ceridian Dayforce connector is used to perform operations with Dayforce HCM.  Please read the [Ceridian Dayforce connector reference guide]({{base_path}}/reference/connectors/ceridiandayforce-connector/ceridiandayforce-connector-reference/) to learn more about the operations you can perform with the Dayforce connector.
