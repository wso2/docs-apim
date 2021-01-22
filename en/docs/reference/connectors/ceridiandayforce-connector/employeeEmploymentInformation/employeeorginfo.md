# Working with Employee Org Info

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve organizational information of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Org Info](#retrieving-employee-org-info)| Retrieve the organizational hierarchy attached to an employee. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Org Info
We can use GET Employee Org Info operation with required parameters to search and find the organizational info of a required employees.

**GET Employee Org Info**
```xml
<ceridiandayforce.getEmployeeOrgInfo>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
</ceridiandayforce.getEmployeeOrgInfo>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "Address": {
                    "Address1": "11920 Amberpark Drive",
                    "City": "Alpharetta",
                    "PostalCode": "30009",
                    "Country": {
                        "XRefCode": "USA"
                    },
                    "State": {
                        "XRefCode": "GA"
                    }
                },
                "ChildSortOrder": 159,
                "IsPhysicalLocation": false,
                "IsPrimary": true,
                "ParentSortOrder": 1,
                "OrgLevel": {
                    "XRefCode": "Corp",
                    "ShortName": "Corporate",
                    "LongName": "Corporate Level"
                },
                "XRefCode": "Corporate",
                "ShortName": "prd-500b-2018--01-29",
                "LongName": "XYZ Co..PRDemoGold - Jan  29th 2018 -53hf23\r12-22- update UK payrol/ppaca/onboad date\r12-18- Ran update payroll BSI script\rUpdate PPACA calanders"
            }
        },
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "ChildSortOrder": 159,
                "IsPhysicalLocation": false,
                "IsPrimary": true,
                "ParentSortOrder": 146,
                "OrgLevel": {
                    "XRefCode": "Region",
                    "ShortName": "Region",
                    "LongName": "Region Level"
                },
                "XRefCode": "RefCode_33",
                "ShortName": "Manufacturing Co. USA",
                "LongName": "Manufacturing Co. USA"
            }
        },
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "ChildSortOrder": 159,
                "IsPhysicalLocation": false,
                "IsPrimary": true,
                "ParentSortOrder": 147,
                "OrgLevel": {
                    "XRefCode": "District",
                    "ShortName": "District",
                    "LongName": "District"
                },
                "XRefCode": "RefCode_34",
                "ShortName": "District 01",
                "LongName": "District 01"
            }
        },
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "Address": {
                    "Address1": "20 Wilkinson Avenue",
                    "City": "Jersey City",
                    "PostalCode": "07305",
                    "Country": {
                        "XRefCode": "USA"
                    },
                    "State": {
                        "XRefCode": "NJ"
                    }
                },
                "ChildSortOrder": 159,
                "IsPhysicalLocation": true,
                "IsPrimary": true,
                "LedgerCode": "500",
                "ParentSortOrder": 148,
                "OrgLevel": {
                    "XRefCode": "Site",
                    "ShortName": "Site",
                    "LongName": "Site"
                },
                "XRefCode": "Plant1",
                "ShortName": "Plant 1",
                "LongName": "Plant 1"
            }
        },
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "ChildSortOrder": 159,
                "IsPhysicalLocation": false,
                "IsPrimary": true,
                "LedgerCode": "500",
                "ParentSortOrder": 159,
                "OrgLevel": {
                    "XRefCode": "OnSiteDepartment",
                    "ShortName": "Department",
                    "LongName": "Department"
                },
                "XRefCode": "500Packaging",
                "ShortName": "Plant 1 - Packaging",
                "LongName": "Plant 1 - Packaging"
            },
            "Department": {
                "XRefCode": "11",
                "ShortName": "Packaging",
                "LongName": "Packaging"
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Org-Unit-Info/GET-Employee-Org-Info.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Org-Unit-Info/GET-Employee-Org-Info.aspx)

### Sample configuration

Following example illustrates how to connect to Dayforce with the init operation and query operation.

1.Create a sample proxy as below :
```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="query"
       startOnLoad="true"
       statistics="disable"
       trace="disable"
       transports="http,https">
   <target>
      <inSequence>
         <log level="full" separator=","/>
         <property expression="json-eval($.username)" name="username"/>
         <property expression="json-eval($.password)" name="password"/>
         <property expression="json-eval($.clientNamespace)" name="clientNamespace"/>
         <property expression="json-eval($.apiVersion)" name="apiVersion"/>
         <property expression="json-eval($.xRefCode)" name="xRefCode"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getEmployeeOrgInfo>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
         </ceridiandayforce.getEmployeeOrgInfo>
         <send/>
      </inSequence>
   </target>
   <description/>
</proxy>
                                
```

2.Create a json file named query.json and copy the configurations given below to it:

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199"
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200 with the following response body 

```json
{
    "Data": [
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "Address": {
                    "Address1": "11920 Amberpark Drive",
                    "City": "Alpharetta",
                    "PostalCode": "30009",
                    "Country": {
                        "XRefCode": "USA"
                    },
                    "State": {
                        "XRefCode": "GA"
                    }
                },
                "ChildSortOrder": 159,
                "IsPhysicalLocation": false,
                "IsPrimary": true,
                "ParentSortOrder": 1,
                "OrgLevel": {
                    "XRefCode": "Corp",
                    "ShortName": "Corporate",
                    "LongName": "Corporate Level"
                },
                "XRefCode": "Corporate",
                "ShortName": "prd-500b-2018--01-29",
                "LongName": "XYZ Co..PRDemoGold - Jan  29th 2018 -53hf23\r12-22- update UK payrol/ppaca/onboad date\r12-18- Ran update payroll BSI script\rUpdate PPACA calanders"
            }
        },
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "ChildSortOrder": 159,
                "IsPhysicalLocation": false,
                "IsPrimary": true,
                "ParentSortOrder": 146,
                "OrgLevel": {
                    "XRefCode": "Region",
                    "ShortName": "Region",
                    "LongName": "Region Level"
                },
                "XRefCode": "RefCode_33",
                "ShortName": "Manufacturing Co. USA",
                "LongName": "Manufacturing Co. USA"
            }
        },
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "ChildSortOrder": 159,
                "IsPhysicalLocation": false,
                "IsPrimary": true,
                "ParentSortOrder": 147,
                "OrgLevel": {
                    "XRefCode": "District",
                    "ShortName": "District",
                    "LongName": "District"
                },
                "XRefCode": "RefCode_34",
                "ShortName": "District 01",
                "LongName": "District 01"
            }
        },
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "Address": {
                    "Address1": "20 Wilkinson Avenue",
                    "City": "Jersey City",
                    "PostalCode": "07305",
                    "Country": {
                        "XRefCode": "USA"
                    },
                    "State": {
                        "XRefCode": "NJ"
                    }
                },
                "ChildSortOrder": 159,
                "IsPhysicalLocation": true,
                "IsPrimary": true,
                "LedgerCode": "500",
                "ParentSortOrder": 148,
                "OrgLevel": {
                    "XRefCode": "Site",
                    "ShortName": "Site",
                    "LongName": "Site"
                },
                "XRefCode": "Plant1",
                "ShortName": "Plant 1",
                "LongName": "Plant 1"
            }
        },
        {
            "OrgUnitDetail": {
                "EffectiveStart": "2000-01-01T00:00:00",
                "ChildSortOrder": 159,
                "IsPhysicalLocation": false,
                "IsPrimary": true,
                "LedgerCode": "500",
                "ParentSortOrder": 159,
                "OrgLevel": {
                    "XRefCode": "OnSiteDepartment",
                    "ShortName": "Department",
                    "LongName": "Department"
                },
                "XRefCode": "500Packaging",
                "ShortName": "Plant 1 - Packaging",
                "LongName": "Plant 1 - Packaging"
            },
            "Department": {
                "XRefCode": "11",
                "ShortName": "Packaging",
                "LongName": "Packaging"
            }
        }
    ]
}
```
