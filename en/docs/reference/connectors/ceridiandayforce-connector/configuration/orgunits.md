# Working with Org Units

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update organization units

| Operation | Description |
| ------------- |-------------|
|[GET Org Units](#retrieving-org-units)| Retrieve a list of Org Unit XRefCodes.  An XRefcode can then be used to retrieve details of an Org Unit with GET Org Unit Details. |
|[POST Org Units](#creating-org-units)| Create a new Org Unit with a unique XRefCode.  It includes creating its relationship to an existing Parent Org Unit and Legal Entity that are specified in OrgUnitParents and OrgUnitLegalEntities, respectively. |
|[PATCH Org Units](#updating-org-units)| Update an existing Org Unit using its XRefCode, which should be specified in the request URL. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Org Units
We can use GET Org Units operation with required parameters to retrieve a list of org units

**GET Org Units**
```xml
<ceridiandayforce.getOrgUnits/>
```

**Properties**

There are no properties.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "XRefCode": "Corporate"
        },
        {
            "XRefCode": "RetailCoUSA"
        },
        {
            "XRefCode": "RefCode_1"
        },
        {
            "XRefCode": "RefCode_2"
        },
        {
            "XRefCode": "Store118"
        },
        {
            "XRefCode": "RefCode_3"
        },
        {
            "XRefCode": "RefCode_4"
        },
        {
            "XRefCode": "RefCode_5"
        },
        {
            "XRefCode": "RefCode_6"
        },
        {
            "XRefCode": "RefCode_7"
        },
        {
            "XRefCode": "RefCode_8"
        },
        {
            "XRefCode": "Store113"
        },
        {
            "XRefCode": "RefCode_9"
        },
        {
            "XRefCode": "RefCode_10"
        },
        {
            "XRefCode": "RefCode_11"
        },
        {
            "XRefCode": "RefCode_12"
        },
        {
            "XRefCode": "RefCode_13"
        },
        {
            "XRefCode": "RefCode_14"
        },
        {
            "XRefCode": "Store110"
        },
        {
            "XRefCode": "4"
        },
        {
            "XRefCode": "1"
        },
        {
            "XRefCode": "7"
        },
        {
            "XRefCode": "2"
        },
        {
            "XRefCode": "3"
        },
        {
            "XRefCode": "5"
        },
        {
            "XRefCode": "6"
        },
        {
            "XRefCode": "Store105"
        },
        {
            "XRefCode": "RefCode_15"
        },
        {
            "XRefCode": "RefCode_16"
        },
        {
            "XRefCode": "RefCode_17"
        },
        {
            "XRefCode": "RefCode_18"
        },
        {
            "XRefCode": "RefCode_19"
        },
        {
            "XRefCode": "RefCode_20"
        },
        {
            "XRefCode": "Store120"
        },
        {
            "XRefCode": "Store 120 - Accessories"
        },
        {
            "XRefCode": "Store 120 - Mens"
        },
        {
            "XRefCode": "Store 120 - Footwear"
        },
        {
            "XRefCode": "Store 120 - Womens"
        },
        {
            "XRefCode": "Store 120 - Management"
        },
        {
            "XRefCode": "Store 120 - Receiving"
        },
        {
            "XRefCode": "Store125"
        },
        {
            "XRefCode": "RefCode_21"
        },
        {
            "XRefCode": "RefCode_22"
        },
        {
            "XRefCode": "RefCode_23"
        },
        {
            "XRefCode": "RefCode_24"
        },
        {
            "XRefCode": "RefCode_25"
        },
        {
            "XRefCode": "RefCode_26"
        },
        {
            "XRefCode": "Store999"
        },
        {
            "XRefCode": "RefCode_27"
        },
        {
            "XRefCode": "RefCode_28"
        },
        {
            "XRefCode": "RefCode_29"
        },
        {
            "XRefCode": "RefCode_30"
        },
        {
            "XRefCode": "RefCode_31"
        },
        {
            "XRefCode": "RefCode_32"
        },
        {
            "XRefCode": "RefCode_33"
        },
        {
            "XRefCode": "RefCode_34"
        },
        {
            "XRefCode": "Plant1"
        },
        {
            "XRefCode": "500Assembly 1"
        },
        {
            "XRefCode": "500Assembly 2"
        },
        {
            "XRefCode": "500Maintenance"
        },
        {
            "XRefCode": "500Management"
        },
        {
            "XRefCode": "500Operations"
        },
        {
            "XRefCode": "500Packaging"
        },
        {
            "XRefCode": "RefCode_35"
        },
        {
            "XRefCode": "Bank 1"
        },
        {
            "XRefCode": "Bank 1Admin"
        },
        {
            "XRefCode": "Bank 1Commercial Lines"
        },
        {
            "XRefCode": "Bank 1Customer Service"
        },
        {
            "XRefCode": "Bank 1Employee Benefits"
        },
        {
            "XRefCode": "Bank 1Personal Lines"
        },
        {
            "XRefCode": "RefCode_36"
        },
        {
            "XRefCode": "Sunny"
        },
        {
            "XRefCode": "SunnyAdmin"
        },
        {
            "XRefCode": "SunnyCommunity Care"
        },
        {
            "XRefCode": "SunnyHousekeeping"
        },
        {
            "XRefCode": "SunnyNursing"
        },
        {
            "XRefCode": "SunnyPP&E"
        },
        {
            "XRefCode": "SunnyReception"
        },
        {
            "XRefCode": "Store122"
        },
        {
            "XRefCode": "RefCode_37"
        },
        {
            "XRefCode": "Store155"
        },
        {
            "XRefCode": "RefCode_38"
        },
        {
            "XRefCode": "RefCode_39"
        },
        {
            "XRefCode": "Hotel 1"
        },
        {
            "XRefCode": "Hotel 1Concierge"
        },
        {
            "XRefCode": "Hotel 1Food & Beverage"
        },
        {
            "XRefCode": "Hotel 1Front Desk"
        },
        {
            "XRefCode": "Hotel 1Housekeeping"
        },
        {
            "XRefCode": "Hotel 1Management"
        },
        {
            "XRefCode": "Hotel 1Operations"
        },
        {
            "XRefCode": "Hotel 1PP&E"
        },
        {
            "XRefCode": "RefCode_40"
        },
        {
            "XRefCode": "Site1CAN"
        },
        {
            "XRefCode": "Site1CAN8"
        },
        {
            "XRefCode": "Site1CAN10"
        },
        {
            "XRefCode": "Site1CAN5"
        },
        {
            "XRefCode": "Site1CAN11"
        },
        {
            "XRefCode": "Plant 3"
        },
        {
            "XRefCode": "Plant 38"
        },
        {
            "XRefCode": "Plant 39"
        },
        {
            "XRefCode": "Plant 310"
        },
        {
            "XRefCode": "Plant 35"
        },
        {
            "XRefCode": "Plant 311"
        },
        {
            "XRefCode": "Plant 36"
        },
        {
            "XRefCode": "Plant4"
        },
        {
            "XRefCode": "Plant48"
        },
        {
            "XRefCode": "Plant49"
        },
        {
            "XRefCode": "Plant410"
        },
        {
            "XRefCode": "Plant45"
        },
        {
            "XRefCode": "Plant411"
        },
        {
            "XRefCode": "Plant46"
        },
        {
            "XRefCode": "RefCode_41"
        },
        {
            "XRefCode": "RefCode_42"
        },
        {
            "XRefCode": "Store320"
        },
        {
            "XRefCode": "Store 32014"
        },
        {
            "XRefCode": "Store 32025"
        },
        {
            "XRefCode": "Store 32026"
        },
        {
            "XRefCode": "Store 32027"
        },
        {
            "XRefCode": "Store 32028"
        },
        {
            "XRefCode": "Store 320 Mgmt"
        },
        {
            "XRefCode": "RefCode_43"
        },
        {
            "XRefCode": "Minneapolis"
        },
        {
            "XRefCode": "RefCode_44"
        },
        {
            "XRefCode": "RefCode_45"
        },
        {
            "XRefCode": "RefCode_46"
        },
        {
            "XRefCode": "Store 1001"
        },
        {
            "XRefCode": "Store 100122"
        },
        {
            "XRefCode": "RefCode_47"
        },
        {
            "XRefCode": "RefCode_48"
        },
        {
            "XRefCode": "Cloverleaf"
        },
        {
            "XRefCode": "Cloverleaf12"
        },
        {
            "XRefCode": "Cloverleaf33"
        },
        {
            "XRefCode": "Cloverleaf19"
        },
        {
            "XRefCode": "Cloverleaf30"
        },
        {
            "XRefCode": "Cloverleaf32"
        },
        {
            "XRefCode": "Cloverleaf31"
        },
        {
            "XRefCode": "Cranberry"
        },
        {
            "XRefCode": "Cranberry12"
        },
        {
            "XRefCode": "Cranberry33"
        },
        {
            "XRefCode": "Cranberry19"
        },
        {
            "XRefCode": "Cranberry30"
        },
        {
            "XRefCode": "Cranberry32"
        },
        {
            "XRefCode": "Cranberry31"
        },
        {
            "XRefCode": "Store2001"
        },
        {
            "XRefCode": "Store200122"
        },
        {
            "XRefCode": "RefCode_49"
        },
        {
            "XRefCode": "RefCode_50"
        },
        {
            "XRefCode": "RefCode_51"
        },
        {
            "XRefCode": "Plant 601"
        },
        {
            "XRefCode": "Plant 6018"
        },
        {
            "XRefCode": "Plant 6019"
        },
        {
            "XRefCode": "Plant 60110"
        },
        {
            "XRefCode": "Plant 6015"
        },
        {
            "XRefCode": "Plant 60111"
        },
        {
            "XRefCode": "Plant 6016"
        },
        {
            "XRefCode": "Plant 501"
        },
        {
            "XRefCode": "Plant 5018"
        },
        {
            "XRefCode": "Plant 50110"
        },
        {
            "XRefCode": "Plant 5015"
        },
        {
            "XRefCode": "Plant 50111"
        },
        {
            "XRefCode": "Head Office"
        },
        {
            "XRefCode": "HeadOfficeHR"
        },
        {
            "XRefCode": "HeadOfficeFinance"
        },
        {
            "XRefCode": "HeadOfficeMarketing"
        },
        {
            "XRefCode": "HeadOfficeSeniorLeadership"
        },
        {
            "XRefCode": "HeadOfficeSeniorOperations"
        },
        {
            "XRefCode": "RefCode_52"
        },
        {
            "XRefCode": "RefCode_53"
        },
        {
            "XRefCode": "Store 200"
        },
        {
            "XRefCode": "200Accessories"
        },
        {
            "XRefCode": "200Footwear"
        },
        {
            "XRefCode": "200Management"
        },
        {
            "XRefCode": "200Mens"
        },
        {
            "XRefCode": "200Receiving"
        },
        {
            "XRefCode": "200Womens"
        },
        {
            "XRefCode": "Financial Co. Canada"
        },
        {
            "XRefCode": "Central Bank"
        },
        {
            "XRefCode": "Central Bank Admin"
        },
        {
            "XRefCode": "Central Bank Customer Service"
        },
        {
            "XRefCode": "Central Bank IT"
        },
        {
            "XRefCode": "Eastern Bank"
        },
        {
            "XRefCode": "Eastern Bank Admin"
        },
        {
            "XRefCode": "Eastern Bank Customer Service"
        },
        {
            "XRefCode": "Eastern Bank IT"
        },
        {
            "XRefCode": "Western Bank"
        },
        {
            "XRefCode": "Western Bank Admin"
        },
        {
            "XRefCode": "Western Bank Customer Service"
        },
        {
            "XRefCode": "Western Bank IT"
        },
        {
            "XRefCode": "Clinic"
        },
        {
            "XRefCode": "ClinicMedical"
        },
        {
            "XRefCode": "Project"
        },
        {
            "XRefCode": "ITProjects"
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Configuration/Organization-Data/Org-Units/GET-Org-Units.aspx](https://developers.dayforce.com/Build/API-Explorer/Configuration/Organization-Data/Org-Units/GET-Org-Units.aspx)

#### Creating Org Units
We can use POST Org Units operation with required parameters to create a new org unit

**GET Org Units**
```xml
<ceridiandayforce.postOrgUnits>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postOrgUnits>
```

**Properties**

* isValidateOnly (Mandatory): When a TRUE value is used in this parameter, POST and PATCH operations validate the request without applying updates to the database.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "isValidateOnly": "true",
  "fieldAndValue": 
  {
	    "OrgLevel": {
	        "XRefCode": "Site"
	    },
	    "PhysicalLocation": 1,
	    "OrgUnitParents": {
	        "Items": [
	            {
	                "ParentOrgUnit": {
	                    "XRefCode": "Corporate"
	                },
	                "EffectiveStart": "2019-06-26T00:00:00-04:00"
	            }
	        ]
	    },
	    "XRefCode": "ShopDDN",
	    "ShortName": "ShopDDN"
	}
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Configuration/Organization-Data/Org-Units/POST-Org-Units.aspx](https://developers.dayforce.com/Build/API-Explorer/Configuration/Organization-Data/Org-Units/POST-Org-Units.aspx)

#### Updating Org Units
We can use PATCH Org Units operation with required parameters to update an existing org unit

**PATCH Org Units**
```xml
<ceridiandayforce.getEmployeeAddresses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.getEmployeeAddresses>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the org unit. The value provided must be the exact match for an org unit; otherwise, a bad request (400) error will be returned.
* isValidateOnly (Mandatory): When a TRUE value is used in this parameter, POST and PATCH operations validate the request without applying updates to the database.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "Store320",
  "isValidateOnly": "true",
  "fieldAndValue": 
	{
	    "XRefCode": "Store320",
	    "ShortName": "Store 320",
	    "LongName": "Store 320"
	}
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Configuration/Organization-Data/Org-Units/PATCH-Org-Unit.aspx](https://developers.dayforce.com/Build/API-Explorer/Configuration/Organization-Data/Org-Units/PATCH-Org-Unit.aspx)

### Sample configuration

Following example illustrates how to connect to Dayforce with the init operation and query operation.

1.Create a sample proxy as below :
```xml

```

2.Create a json file named query.json and copy the configurations given below to it:

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "isValidateOnly": "true",
  "fieldAndValue": 
  {
	    "OrgLevel": {
	        "XRefCode": "Site"
	    },
	    "PhysicalLocation": 1,
	    "OrgUnitParents": {
	        "Items": [
	            {
	                "ParentOrgUnit": {
	                    "XRefCode": "Corporate"
	                },
	                "EffectiveStart": "2019-06-26T00:00:00-04:00"
	            }
	        ]
	    },
	    "XRefCode": "ShopDDN",
	    "ShortName": "ShopDDN"
	}
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200
