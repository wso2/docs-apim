# Google Spreadsheet Connector Example

The Google Sheets API lets users to read and modify any aspect of a spreadsheet. The WSO2 Google Spreadsheet Connector allows you to access the Google Spreadsheet [API Version v4](https://developers.google.com/sheets/api/guides/concepts) through WSO2 EI. It allows users to read/write any aspect of the spreadsheet via the spreadsheets collection. It has the ability to do spreadsheet operations and spreadsheet data operations. 

## What you'll build

This example explains how to use Google Spreadsheet Connector to create a Google spreadsheet, write data to it, and read it. Further, it explains how the data in the spreadsheet can be edited. 

It will have three HTTP API resources, which are `insert`, `read` and `edit`. 

* `/insert `: The user sends the request payload, which includes the name of the spreadsheet, the sheet names, and what data should be inserted to which sheet and which range of cells.  This request is sent to WSO2 EI by invoking the Spreadsheet API. It creates a spreadsheet with specified data in the specified cell range. 

    <img src="{{base_path}}/assets/img/integrate/connectors/sheet-insert.png" title="Calling insert operation" width="800" alt="Calling insert operation"/> 

* `/read `: The user sends the request payload, which includes the spreadsheet Id that should be obtained from calling the `insert` API resource, and the range of the cell range to be read. 

    <img src="{{base_path}}/assets/img/integrate/connectors/sheet-read.png" title="Calling read operation" width="800" alt="Calling read operation"/>

* `/edit `: The user sends the request payload, which includes the spreadsheet Id that should be obtained from calling the `insert` API resource, and the data to be edited that includes values and the range. 

    <img src="{{base_path}}/assets/img/integrate/connectors/sheet-edit.png" title="Calling edit operation" width="800" alt="Calling edit operation"/>


If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

## Creating the Integration Logic

1. Follow these steps to [Configure Google Sheets API]({{base_path}}/reference/connectors/google-spreadsheet-connector/get-credentials-for-google-spreadsheet/) and obtain the Client Id, Client Secret, Access Token, and Refresh Token.  

2. Right click on the created Integration Project and select, -> **New** -> **Rest API** to create the REST API. 
    <img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

3. Provide the API name as `SpreadsheetAPI` and the API context as `/insert`.

4. First we will create the `/insert` resource. Right click on the API Resource and go to **Properties** view. We use a URL template called `/insert` as we have two API resources inside single API. The method will be `Post`. 
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.png" title="Adding the API resource." width="800" alt="Adding the API resource."/>

5. In this operation we are going to receive input from the user, which are `properties`, `sheets`, `range` and `values`. 
    - properties - It can provide the spreadsheet properties such as title of the spreadsheet. 
    - sheets - It can provide set of sheets to be created.
    - range - It provides the sheet name and the range that data need to be inserted. 
    - values - Data to be inserted.

6. The above four parameters are saved to a property group. Drag and drop the Property Group mediator onto the canvas in the design view and do as shown below. For further reference, you can read about the [Property Group mediator]({{base_path}}/reference/mediators/property-group-mediator). You can add set of properties as below. 

    <img src="{{base_path}}/assets/img/integrate/connectors/sheetcon1.png" title="Adding a property into a property group" width="800" alt="Adding a property"/>

7. Once all the properties are added to the Property Group Mediator, it looks as below. 

    <img src="{{base_path}}/assets/img/integrate/connectors/sheetcon2.png" title="Property Group Mediator" width="800" alt="Property Group Mediator"/>

8. The `createSpreadsheet` operation is going to be added as a separate sequence. Right click on the created Integration Project and select, -> **New** -> **Sequence** to create the `createSpreadsheet` sequence.

9. Drag and drop the **init** operation in the Googlespreadsheet Connector as below. Fill the following values that you obtained in the step 1. 
    - accessToken
    - apiUrl: https://sheets.googleapis.com/v4/spreadsheets
    - clientId
    - clientSecret
    - refreshToken

    <img src="{{base_path}}/assets/img/integrate/connectors/sheetcon3.png" title="init operation" width="800" alt="init operation"/>

10. Drag and drop **createSpreadsheet** operation to the Canvas next. Parameter values are defined in step 6 and 7 in the property group. 

    <img src="{{base_path}}/assets/img/integrate/connectors/sheetcon4.png" title="Parameters" width="800" alt="Parameters"/>

11. The complete XML configuration for the `createSpreadsheet.xml` looks as below. 
```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <sequence name="createSpreadsheet" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
        <googlespreadsheet.init>
            <accessToken></accessToken>
            <apiUrl>https://sheets.googleapis.com/v4/spreadsheets</apiUrl>
            <clientId></clientId>
            <clientSecret></clientSecret>
            <refreshToken></refreshToken>
        </googlespreadsheet.init>
        <googlespreadsheet.createSpreadsheet>
            <properties>{$ctx:properties}</properties>
            <sheets>{$ctx:sheets}</sheets>
        </googlespreadsheet.createSpreadsheet>
    </sequence>
```

12. Next we need to create the `addData.xml` sequence as above. As explained in step 8, create a sequence by right clicking the Integration Project that has already been created. 

13. Below is the complete XML configuration for `addData.xml` file. 
```xml

    <?xml version="1.0" encoding="UTF-8"?>
    <sequence name="addData" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
        <property expression="json-eval($.spreadsheetId)" name="spreadsheetId" scope="default" type="STRING"/>
        <googlespreadsheet.init>
            <accessToken></accessToken>
            <apiUrl>https://sheets.googleapis.com/v4/spreadsheets</apiUrl>
            <clientId></clientId>
            <clientSecret></clientSecret>
            <refreshToken></refreshToken>
        </googlespreadsheet.init>
        <googlespreadsheet.addRowsColumnsData>
            <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
            <range>{$ctx:range}</range>
            <insertDataOption>INSERT_ROWS</insertDataOption>
            <valueInputOption>RAW</valueInputOption>
            <majorDimension>ROWS</majorDimension>
            <values>{$ctx:values}</values>
        </googlespreadsheet.addRowsColumnsData>
    </sequence>

```

14. Now go back to `SpreadsheeetAPI.xml` file, and from **Defined Sequences** drag and drop **createSpreadsheet** sequence, **addData** sequence and finally the Respond Mediator to the canvas. Now we are done with creating the first API resource, and it is displayed as shown below. 

    <img src="{{base_path}}/assets/img/integrate/connectors/sheetcon5.png" title="insert operation xml config" width="800" alt="insert operation xml config"/>

15. Create the next API resource, which is `/read`. From this, we are going to read the specified spreadsheet data. Use the URL template as `/read`. The method will be POST. 

    <img src="{{base_path}}/assets/img/integrate/connectors/apiresource.png" title="Adding an API resource" width="800" alt="Adding an API resource"/>

16. Let's create `readData.xml` sequence. The complete XML configuration looks as below. 
```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <sequence name="readData" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
        <property expression="json-eval($.spreadsheetId)" name="spreadsheetId" scope="default" type="STRING"/>
        <property expression="json-eval($.range)" name="range" scope="default" type="STRING"/>
        <googlespreadsheet.init>
            <accessToken></accessToken>
            <apiUrl>https://sheets.googleapis.com/v4/spreadsheets</apiUrl>
            <clientId></clientId>
            <clientSecret></clientSecret>
            <refreshToken></refreshToken>
        </googlespreadsheet.init>
        <googlespreadsheet.getCellData>
            <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
            <range>{$ctx:range}</range>
            <dateTimeRenderOption>SERIAL_NUMBER</dateTimeRenderOption>
            <majorDimension>ROWS</majorDimension>
            <valueRenderOption>UNFORMATTED_VALUE</valueRenderOption>
        </googlespreadsheet.getCellData>
    </sequence>
```

19. In this operation, the user sends the spreadsheetId and range as the request payload. They will be written to properties as we did in step 10.  

20. Go back to SpreadsheetAPI. Drag and drop `readData` sequence from the **Defined Sequences** to the canvas followed by a Respond mediator. 
    <img src="{{base_path}}/assets/img/integrate/connectors/sheetcon6.png" title="Adding the read resource" width="800" alt="Adding read resource"/>

21. Next go to SpreadsheetAPI. To create the next API resource, drag and drop another API resource to the design view. Use the URL template as `/edit`. The method will be POST. 

22. Create the sequence  `editSpeadsheet.xml` which looks as below.
```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <sequence name="editSpreadsheet" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
      <property expression="json-eval($.spreadsheetId)" name="spreadsheetId" scope="default" type="STRING"/>
      <property expression="json-eval($.data)" name="data" scope="default" type="STRING"/>
      <googlespreadsheet.init>
          <accessToken></accessToken>
          <apiUrl>https://sheets.googleapis.com/v4/spreadsheets</apiUrl>
          <clientId></clientId>
          <clientSecret></clientSecret>
          <refreshToken></refreshToken>
      </googlespreadsheet.init>
      <googlespreadsheet.editMultipleCell>
          <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
          <valueInputOption>RAW</valueInputOption>
          <data>{$ctx:data}</data>
      </googlespreadsheet.editMultipleCell>
  </sequence>

```
23. Go back to SpreadsheetAPI. Drag and drop `editSpeadsheet` sequence from the **Defined Sequences** to the canvas followed by a Respond mediator. 
    <img src="{{base_path}}/assets/img/integrate/connectors/sheetcon7.png" title="Adding the edit resource" width="800" alt="Adding edit resource"/>

24. Below is the complete XML configuration of the SpreadsheetAPI. 
```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <api context="/spreadsheet" name="SpreadsheetAPI" xmlns="http://ws.apache.org/ns/synapse">
        <resource methods="POST" uri-template="/insert">
            <inSequence>
                <propertyGroup description="It contains the set of properties related to spreadsheet creation and addData operations. ">
                    <property expression="json-eval($.properties)" name="properties" scope="default" type="STRING"/>
                    <property expression="json-eval($.sheets)" name="sheets" scope="default" type="STRING"/>
                    <property expression="json-eval($.range)" name="range" scope="default" type="STRING"/>
                    <property expression="json-eval($.values)" name="values" scope="default" type="STRING"/>
                </propertyGroup>
                <sequence description="This sequence will create a spreadsheet and outputs the spreadsheet url. " key="createSpreadsheet"/>
                <sequence description="This sequence will insert the data to the created spreadsheet. " key="addData"/>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" uri-template="/read">
            <inSequence>
                <sequence description="This sequence will read data of the spreadsheet. " key="readData"/>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" uri-template="/edit">
            <inSequence>
                <sequence key="editSpreadsheet"/>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
    </api>

```

{!reference/connectors/exporting-artifacts.md!}


## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/google-spreadsheet-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the value of the access token and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the Enterprise Integrator Runtime. 

{!reference/connectors/deploy-capp.md!}

## Testing

### Spreadsheet insert Operation

Invoke the SpreadsheetAPI with the following URL. An application such as [Postman](https://www.postman.com/) can be used to invoke the API. 

```
  Resource method: POST
  URL: http://localhost:8290/spreadsheet/insert
```

  ```
    {
      "properties":{
          "title": "Company"
        },
      "sheets":[
          {
            "properties":
            {
              "title": "Employees"
            }
          },
          {
            "properties":
            {
              "title": "Hector"
            }
          }
        ], 
        "range":"Employees!A1:C3",
        "values":[
            [
                "First Name",
                "Last Name",
                "Gender"
            ],
            [
                "John",
                "Doe",
                "Male"
            ],
            [
              "Leon",
                "Wins",
                "Female"
              ]
        ]
    }
    
  ```
**Expected Response**: 
You should get a success response as below, and the spreadsheet should be created in the given ID in the response with data inserted.  

```
  {
    "spreadsheetId": "1ddnO00fcjuLvEMCUORVjYQ4C0VLeAPNGmcvSvELHbPU",
    "updates": {
      "spreadsheetId": "1ddnO00fcjuLvEMCUORVjYQ4C0VLeAPNGmcvSvELHbPU",
      "updatedRange": "Employees!A1:C3",
      "updatedRows": 3,
      "updatedColumns": 3,
      "updatedCells": 9
    }
  }
```

### Spreadsheet Read Operation

Invoke the SpreadsheetAPI with the following URL. An application such as [Postman](https://www.postman.com/) can be used to invoke the API. Obtain the Spreadsheet ID from step 1. 
```
  Resource method: POST
  URL: http://localhost:8290/spreadsheet/read
```

  ```
    {
      "spreadsheetId":"1Ht0FWeKtKqBb1pEEzLcRMM8s5mktJdhivX3iaFXo-qQ",
      "range":"Employees!A1:C3"
    }
  ```

**Expected Response**: 
You should get the following response returned. 
```
  {
    "range": "Employees!A1:C3",
    "majorDimension": "ROWS",
    "values": [
      [
        "First Name",
        "Last Name",
        "Gender"
      ],
      [
        "John",
        "Doe",
        "Male"
      ],
      [
        "Leon",
        "Wins",
        "Female"
      ]
    ]
  }

```

### Spreadsheet Edit Operation

1. Invoke the SpreadsheetAPI with the following URL. Application such as [Postman](https://www.postman.com/) can be used to invoke the API. Obtain the Spreadsheet ID from the step 1. 
```
  Resource method: POST
  URL: http://localhost:8290/spreadsheet/edit
```

  ```
    {
      "spreadsheetId":"1Ht0FWeKtKqBb1pEEzLcRMM8s5mktJdhivX3iaFXo-qQ",
      "data": [
          {
            "values": [["Isuru","Uyanage","Female"],["Supun","Silva","Male"]],
            "range": "Employees!A6"
      }
      ]
    }
  ```

**Expected Response**: 
You should get the following response returned. 

```
  {
    "spreadsheetId": "1Ht0FWeKtKqBb1pEEzLcRMM8s5mktJdhivX3iaFXo-qQ",
    "totalUpdatedRows": 2,
    "totalUpdatedColumns": 3,
    "totalUpdatedCells": 6,
    "totalUpdatedSheets": 1,
    "responses": [
      {
        "spreadsheetId": "1Ht0FWeKtKqBb1pEEzLcRMM8s5mktJdhivX3iaFXo-qQ",
        "updatedRange": "Employees!A6:C7",
        "updatedRows": 2,
        "updatedColumns": 3,
        "updatedCells": 6
      }
    ]
  }
```
The spreadsheet should be edited within the above specified cell range. 

## What's Next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
* To customize this example for your own scenario, see [Google Spreadsheet Connector Configuration]({{base_path}}/reference/connectors/google-spreadsheet-connector/google-spreadsheet-connector-config/) documentation for all operation details of the connector.
