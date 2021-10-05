# Working with Employee Performance Ratings

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update performance rating of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Performance Ratings](#retrieving-employee-performance-ratings)| Retrieve details on employee performance reviews. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Performance Ratings
We can use GET Employee Performance Ratings operation with required parameters to search and find the performance review of required employees.

**GET Employee Performance Ratings**
```xml
<ceridiandayforce.getEmployeePerformanceRatings>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
</ceridiandayforce.getEmployeePerformanceRatings>
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
            "NextReviewDate": "2020-04-01T00:00:00",
            "PerformanceCycle": {
                "ShortName": "Annual cycle"
            },
            "PerformanceRatingScale": {
                "XRefCode": "PERFORMANCERATINGSCALE1TO5",
                "ShortName": "Performance rating scale (Show Rating Name And Value)",
                "LongName": "Rating scale used to evaluate the employee performance on a scale of 1 to 5 (Show Rating Name And Value)"
            },
            "PerformanceRating": {
                "XRefCode": "MEETSEXPECTATIONS",
                "ShortName": "Meets Expectations",
                "LongName": "Performance consistently met expectations in all essential areas of responsibility, at times possibly exceeding expectations, and the quality of work overall was very good."
            },
            "RatingScore": 85.000,
            "ReviewDate": "2019-04-01T00:00:00",
            "Reviewer": {
                "XRefCode": "67206"
            },
            "ReviewPeriodStartDate": "2018-01-01T00:00:00",
            "ReviewPeriodEndDate": "2018-12-31T00:00:00"
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Performance-Ratings/GET-Employee-Performance-Ratings.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Performance-Ratings/GET-Employee-Performance-Ratings.aspx)

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
         <ceridiandayforce.getEmployeePerformanceRatings>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
         </ceridiandayforce.getEmployeePerformanceRatings>
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
            "NextReviewDate": "2020-04-01T00:00:00",
            "PerformanceCycle": {
                "ShortName": "Annual cycle"
            },
            "PerformanceRatingScale": {
                "XRefCode": "PERFORMANCERATINGSCALE1TO5",
                "ShortName": "Performance rating scale (Show Rating Name And Value)",
                "LongName": "Rating scale used to evaluate the employee performance on a scale of 1 to 5 (Show Rating Name And Value)"
            },
            "PerformanceRating": {
                "XRefCode": "MEETSEXPECTATIONS",
                "ShortName": "Meets Expectations",
                "LongName": "Performance consistently met expectations in all essential areas of responsibility, at times possibly exceeding expectations, and the quality of work overall was very good."
            },
            "RatingScore": 85.000,
            "ReviewDate": "2019-04-01T00:00:00",
            "Reviewer": {
                "XRefCode": "67206"
            },
            "ReviewPeriodStartDate": "2018-01-01T00:00:00",
            "ReviewPeriodEndDate": "2018-12-31T00:00:00"
        }
    ]
}
```
