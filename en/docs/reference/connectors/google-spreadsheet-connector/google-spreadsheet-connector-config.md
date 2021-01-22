# Google Spreadsheet Connector Reference

The following operations allow you to work with the Google Spreadsheet Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the Google Spreadsheet connector, add the <googlespreadsheet.init> element in your proxy configuration before use any other Google Spreadsheet operations. The <googlespreadsheet.init> element is used to authenticate the user using OAuth2 authentication and allows the user to access the Google account which contains the spreadsheets. For more information on authorizing requests in Google Spreadsheets, see [https://developers.google.com/sheets/api/guides/authorizing](https://developers.google.com/sheets/api/guides/authorizing).

> **Note**: When trying it out the first time, you need to use valid accessToken to use the connector operations. If the provided accessToken has expired then the token refreshing flow will be handled inside the connector. See the [documetation to set up Google Spreadsheets and get credentials such as clientId, clientSecret, accessToken, and refreshToken]({{base_path}}/reference/connectors/google-spreadsheet-connector/get-credentials-for-google-spreadsheet/).

??? note "googlespreadsheet.init"
    The googlespreadsheet.init operation initializes the connector to interact with Google Spreadsheet.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accessToken</td>
            <td>Access token which is obtained through the OAuth2 playground.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>The application URL of Google Sheet version v4. </td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>clientId</td>
            <td>Value of your client id, which can be obtained via Google developer console.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>clientSecret</td>
            <td>Value of your client secret, which can be obtained via Google developer console.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>refreshToken</td>
            <td>Refresh token which is obtained through the OAuth2 playground. It is used to refresh the accesstoken.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.init>
        <accessToken>{$ctx:accessToken}</accessToken>
        <clientId>{$ctx:clientId}</clientId>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <refreshToken>{$ctx:refreshToken}</refreshToken>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
    </googlespreadsheet.init>
    ```

    To get the OAuth access token directly call the init method (this method call getAccessTokenFromRefreshToken method itself) or add  <googlespreadsheet.getAccessTokenFromRefreshToken> element before <googlespreadsheet.init> element in your configuration.

    **Sample for getAccessTokenFromRefreshToken**

    ```xml
    <googlespreadsheet.getAccessTokenFromRefreshToken>
        <clientId>{$ctx:clientId}</clientId>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <refreshToken>{$ctx:refreshToken}</refreshToken>
    </googlespreadsheet.getAccessTokenFromRefreshToken>
    ```

---

### Spreadsheet operation

??? note "googlespreadsheet.createSpreadsheet"
    This createSpreadsheet operation allows you to create a new spreadsheet by specifying the spreadsheet id, sheet properties, and add named ranges.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>properties</td>
            <td>Properties of the spreadsheet.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>sheets</td>
            <td>List of sheets and their properties that you want to add into the spreadsheet. You can add multiple sheets.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>namedRanges</td>
            <td>Create names that refer to a single cell or a group of cells on the sheet. Following sample request will create name range with the name "Name" for  the range A1:A6.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response. For the following request only the "spreadsheetId" will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.createSpreadsheet>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <properties>{$ctx:properties}</properties>
        <sheets>{$ctx:sheets}</sheets>
        <namedRanges>{$ctx:namedRanges}</namedRanges>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.createSpreadsheet>
    ```

    **Sample request**

    The sample request given below calls the createSpreadsheet operation. With the following request we can specify spreadsheet details such as spreadsheet name ("Company"), sheet details such as sheet name ("Employees") as an array. So the spreadsheet will be created inside Google Sheets with the name "Company" and the sheet will be created with the name "Employees". Here we specify the "fields" property to get a partial response. As per the following request, only the "spreadsheetId" will be included in the response.

    ```json
    {
        "clientId":"xxxxxxxxxxxxxxxxxxxxxxxn6f2m.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "properties":{
            "title": "Company"
        },
        "sheets":[
            {
            "properties":
                {
                    "title": "Employees"
                }
            }
        ],
        "fields": "spreadsheetId"
    }
    ```

    **Sample response**

    ```json
    {
        "spreadsheetId": "1bWbo72MAhKgeNDCPcE4Wj3uGgN7K9lW1ckDScZV8b30"
    }
    ```

---

### Sheet operations

??? note "googlespreadsheet.addSheetBatchRequest"
    The addSheetBatchRequest operation allows you to add new sheets to an existing spreadsheet. You can specify the sheet properties for the new sheet. An error is thrown if you provide a title that is used for an existing sheet. For more information, see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#AddSheetRequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is an update to apply to a spreadsheet. To add multiple sheets within the spread sheet, need to repeat "addSheetBatchRequest" property within the requests attribute as below.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response. For the following request only the "spreadsheetId" will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.addSheetBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.addSheetBatchRequest>
    ```

    **Sample request**

    The sample request given below calls the addSheetBatchRequest operation. The request specifies the multiple sheet properties, such as the sheet name ("Expenses1", "Expenses2"), sheet type ("GRID"), and the dimension ((50,10), (70,10)) of the sheet as an array. The fields property is specified to get a partial response. The spreadsheetId and replies values will be included in the response. replies contain properties such as sheet name, type, row, column count, and sheetId.

    ```json
    {
        "clientId":"617729022812-xxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "1oGxpE3C_2elS4kcCZaB3JqVMiXCYLamC1CXZOgBzy9A",
        "requests": [
        {
            "addSheet": {
                "properties": {
                    "title": "Expenses1",
                    "sheetType": "GRID",
                    "gridProperties": {
                        "rowCount": 50,
                        "columnCount": 10
                    }
                }
            }
        },
        {
            "addSheet": {
                "properties": {
                    "title": "Expenses2",
                    "sheetType": "GRID",
                    "gridProperties": {
                        "rowCount": 70,
                        "columnCount": 10
                    }
                }
            }
        }
        ],
        "fields": "spreadsheetId,replies"
    }
    ```
    **Sample response**

    ```json
    {
        "spreadsheetId": "1oGxpE3C_2elS4kcCZaB3JqVMiXCYLamC1CXZOgBzy9A",
        "replies": [
            {
                "addSheet": {
                    "properties": {
                        "sheetId": 372552230,
                        "title": "Expenses1",
                        "index": 1,
                        "sheetType": "GRID",
                        "gridProperties": {
                            "rowCount": 50,
                            "columnCount": 10
                        }
                    }
                }
            },
            {
                "addSheet": {
                    "properties": {
                        "sheetId": 568417391,
                        "title": "Expenses2",
                        "index": 2,
                        "sheetType": "GRID",
                        "gridProperties": {
                            "rowCount": 70,
                            "columnCount": 10
                        }
                    }
                }
            }
        ]
    }
    ```

??? note "googlespreadsheet.deleteSheetBatchRequest"
    The deleteSheetBatchRequest operation allows you to remove sheets from a given spreadsheet using "sheetId". You can get the "sheetId" using the getSheetMetaData operation. For more information, see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#deletesheetrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is an update to apply to a spreadsheet. To add multiple sheets within the spread sheet, need to repeat "addSheetBatchRequest" property within the requests attribute as below.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response. For the following request only the "spreadsheetId" will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.deleteSheetBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.deleteSheetBatchRequest>
    ```

    **Sample request**

    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmxxxxxxxxxxxxxxxxxxxxxKMEIFGCD9EBdrXFGA",
        "requests": [
        {
            "deleteSheet":
            {
                "sheetId": 813171540
            }
        }
        ],
        "fields": "spreadsheetId"
    }
    ```
    **Sample response**

    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.getSheetMetaData"
    The getSheetMetaData operation allows you to provides the sheet metadata within a given spreadsheet. This method can be used to acquire sheet properties and other metadata. If you only want to read the sheet properties, set the includeGridData query parameter to false to prevent the inclusion of the spreadsheet cell data. The Spreadsheet response contains an array of Sheet objects. The sheet titles and size information specifically can be found under the SheetProperties element of these objects. For more information, see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/get).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>includeGridData</td>
            <td>True if grid data should be returned. This parameter is ignored if a field mask was set in the request.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>ranges</td>
            <td>The ranges to retrieve from the spreadsheet.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.getSheetMetaData>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <includeGridData>{$ctx:includeGridData}</includeGridData>
        <ranges>{$ctx:ranges}</ranges>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.getSheetMetaData>
    ```

    **Sample request**

    ```json
    {
    	"clientId":"617729022812-xxxxxxxxxxxx.apps.googleusercontent.com",
    	"clientSecret":"xxxxxxxxxx",
    	"refreshToken":"1/xxxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
    	"accessToken":"ya29.xxxxxxxxxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
    	"apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
    	"spreadsheetId": "1oGxpE3C_2elS4kcCZaB3JqVMiXCYLamC1CXZOgBzy9A",
    	"includeGridData":"false",
    	"ranges": "Employees!A1:B2"
    }
    ```
    **Sample response**

    ```json
    {
        "spreadsheetId": "1oGxpE3C_2elS4kcCZaB3JqVMiXCYLamC1CXZOgBzy9A",
        "properties": {
            "title": "Company",
            "locale": "en_US",
            "autoRecalc": "ON_CHANGE",
            "timeZone": "Etc/GMT",
            "defaultFormat": {
                "backgroundColor": {
                    "red": 1,
                    "green": 1,
                    "blue": 1
                },
                "padding": {
                    "top": 2,
                    "right": 3,
                    "bottom": 2,
                    "left": 3
                },
                "verticalAlignment": "BOTTOM",
                "wrapStrategy": "OVERFLOW_CELL",
                "textFormat": {
                    "foregroundColor": {},
                    "fontFamily": "arial,sans,sans-serif",
                    "fontSize": 10,
                    "bold": false,
                    "italic": false,
                    "strikethrough": false,
                    "underline": false
                }
            }
        },
        "sheets": [
            {
                "properties": {
                    "sheetId": 789,
                    "title": "Employees",
                    "index": 0,
                    "sheetType": "GRID",
                    "gridProperties": {
                        "rowCount": 1000,
                        "columnCount": 26
                    }
                }
            }
        ],
        "spreadsheetUrl": "https://docs.google.com/spreadsheets/d/1oGxpE3C_2elS4kcCZaB3JqVMiXCYLamC1CXZOgBzy9A/edit"
    }
    ```
    
??? note "googlespreadsheet.updateSheetPropertiesBatchRequest"
    The updateSheetPropertiesBatchRequest operation allows you to update all sheet properties. This method allows you to update the size, title, and other sheet properties, see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#UpdateSheetPropertiesRequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td> It contains data that is a kind of update to apply to a spreadsheet. To Update multiple sheets properties within the spread sheet, need to repeat `updateSheetProperties` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response. This is define outside the requests body.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.updateSheetPropertiesBatchRequest>
          <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
          <requests>{$ctx:requests}</requests>
          <fields>{$ctx:fields}</fields>
    </googlespreadsheet.updateSheetPropertiesBatchRequest>
    ```

    **Sample request**

    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "1oGxpE3C_2elS4kcCZaB3JqVMiXCYLamC1CXZOgBzy9A",
        "requests": [
          {
           "updateSheetProperties": {
            "properties": {
             "sheetId": 789,
             "gridProperties": {
              "columnCount": 25,
              "rowCount": 10
             },
             "title": "Sheet1"
            },
            "fields": "title,gridProperties(rowCount,columnCount)"
           }
          }
         ],
         "fields": "spreadsheetId"
    }
    ```
    **Sample response**

    ```json
    {
        "spreadsheetId": "1oGxpE3C_2elS4kcCZaB3JqVMiXCYLamC1CXZOgBzy9A"
    }
    ```
    
??? note "googlespreadsheet.copyTo"
    The copyTo operation allows you to copy a single sheet from a spreadsheet to another spreadsheet. Returns the properties of the newly created sheet, see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.sheets/copyTo).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>sheetId</td>
            <td>The ID of the sheet to copy.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>destinationSpreadsheetId</td>
            <td>The ID of the spreadsheet to copy the sheet to.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.copyTo>
         <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
         <sheetId>{$ctx:sheetId}</sheetId>
         <destinationSpreadsheetId>{$ctx:destinationSpreadsheetId}</destinationSpreadsheetId>
         <fields>{$ctx:fields}</fields>
    </googlespreadsheet.copyTo>
    ```

    **Sample request**

    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxx-fCyxRTyf-xxxxxxxxxxx",
        "accessToken":"ya29.xxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "1oGxpE3C_2elS4kcCxxxxxxxxxxxxLamC1CXZOgBzy9A",
        "sheetId":"789",
        "destinationSpreadsheetId":"12KoqoxmykLLYbxxxxxxxxxxxxxxxxxxxxEIFGCD9EBdrXFGA"
    }
    ```
    **Sample response**

    ```json
    {
        "sheetId": 813171540,
        "title": "Copy of Sheet1",
        "index": 1,
        "sheetType": "GRID",
        "gridProperties": {
            "rowCount": 10,
            "columnCount": 25
        }
    }
    ``` 
 
---    
    
### Sheet Data operations
        
??? note "googlespreadsheet.addRowsColumnsData"
    The addRowsColumnsData method allows you to add a new rows or columns of data to a sheet, see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/append).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>range</td>
            <td>The [A1 notation](https://developers.google.com/sheets/api/guides/concepts#a1_notation) of the values to retrieve.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>insertDataOption</td>
            <td>How the input data should be inserted. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/append#insertdataoption).</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>valueInputOption</td>
            <td> How the input data should be interpreted. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/ValueInputOption).</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>majorDimension</td>
            <td>The major dimension that results should use. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values#Dimension).</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response. For the following request only the `updates` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>values</td>
            <td>The data that was to be written. For more detail [click here](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#listvalue).</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.deleteDimensionBatchRequest>
         <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
         <requests>{$ctx:requests}</requests>
         <fields>{$ctx:fields}</fields>
    </googlespreadsheet.deleteDimensionBatchRequest>
    ```

    **Sample request**
    
    The following request appends data in row major fashion. The range is used to search for existing data and find a "table" within that range. Values will be appended to the next row of the table, starting with the first column of the table.
    
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CxxxxxxxxxxxxxxxxxxxxxxxxxxdrXFGA",
        "range":"Sheet1!A1:B2",
        "insertDataOption":"INSERT_ROWS",
        "majorDimension":"ROWS",
        "valueInputOption":"RAW",
        "values":[
              [
                   "20",
                   "21"
               ],
               [
                   "22",
                  "23"
               ]
          ]
    }
    ```
    **Sample response**
        
    The response include the updates details.
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CxxxxxxxxxxxxxxxxxxxxxxxxxxdrXFGA",
        "updates": {
            "spreadsheetId": "12KoqoxmykLLYbtsm6CxxxxxxxxxxxxxxxxxxxxxxxxxxdrXFGA",
            "updatedRange": "Sheet1!A1:B2",
            "updatedRows": 2,
            "updatedColumns": 2,
            "updatedCells": 4
        }
    }
    ```
    
??? note "googlespreadsheet.deleteDimensionBatchRequest"
    The deleteDimensionBatchRequest method allows you to delete rows or columns by specifying the dimension, see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#DeleteDimensionRequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple delete operation within the spreadsheet, need to repeat `deleteDimension` property within the requests property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response. For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.deleteDimensionBatchRequest>
         <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
         <requests>{$ctx:requests}</requests>
         <fields>{$ctx:fields}</fields>
    </googlespreadsheet.deleteDimensionBatchRequest>
    ```

    **Sample request**
    
    The following request deletes the first three rows in the sheet since we specify dimension as ROWS.

    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"ry_AXMsEe5Sn9iVoOY7ATnb8",
        "refreshToken":"1/xxxxxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "requests": [
          {
           "deleteDimension": {
            "range": {
             "sheetId": 121832844,
             "dimension": "ROWS",
             "startIndex": 0,
             "endIndex": 3
            }
           }
          }
         ],
          "fields": "spreadsheetId"
    }
    ```
    **Sample response**

    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ``` 
    
??? note "googlespreadsheet.getCellData"
    The getCellData method allows you to retrieve any set of cell data from a sheet. It return cell contents not only as input values (as would be entered by a user at a keyboard) but also it grants full access to values, formulas, formatting, hyperlinks, data validation, and other properties.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/get).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>range</td>
            <td>The [A1 notation](https://developers.google.com/sheets/api/guides/concepts#a1_notation) of the values to retrieve.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>dateTimeRenderOption</td>
            <td>How dates, times, and durations should be represented in the output. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/DateTimeRenderOption).</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>majorDimension</td>
            <td>The major dimension that results should use. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values#Dimension).</td>
            <td>Optional.</td>
        </tr>                
        <tr>
            <td>valueRenderOption</td>
            <td> How values should be represented in the output. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/ValueRenderOption).</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response. For the following request only the `values` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.getCellData>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <range>{$ctx:range}</range>
        <dateTimeRenderOption>{$ctx:dateTimeRenderOption}</dateTimeRenderOption>
        <majorDimension>{$ctx:majorDimension}</majorDimension>
        <valueRenderOption>{$ctx:valueRenderOption}</valueRenderOption>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.getCellData>
    ```

    **Sample request**
    
    The following returns the cells data in the range A1:E14 of sheet Sheet1 in row-major order.

    ```json
    {
    	"clientId":"617729022812-xxxxxxx.apps.googleusercontent.com",
    	"clientSecret":"xxxxxxxxxxxxxx",
    	"refreshToken":"1/xxxxxxxxxxxx-x-LpK6fDWF9DgcM",
    	"accessToken":"ya29.xxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
    	"apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
    	"spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
    	"range":"Sheet1!A1:E14",
    	"dateTimeRenderOption":"SERIAL_NUMBER",
    	"majorDimension":"ROWS",
    	"valueRenderOption":"UNFORMATTED_VALUE"
    }
    ```
    **Sample response**
    
    In the response cell values in the rage A1:E14 will be return.

    ```json
    {
        "range": "Sheet1!A1:E14",
        "majorDimension": "ROWS",
        "values": [
            [
                "20",
                "21"
            ],
            [
                "22",
                "23"
            ]
        ]
    }
    ```
                    
??? note "googlespreadsheet.getMultipleCellData"
    The getMultipleCellData method allow you to retrieve any set of cell data from a sheet (including multiple ranges). It return cell contents not only as input values (as would be entered by a user at a keyboard) but also it grants full access to values, formulas, formatting, hyperlinks, data validation, and other properties.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/batchGet).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>ranges</td>
            <td>The [ranges](https://developers.google.com/sheets/api/guides/concepts#a1_notation) of the values to retrieve from the spreadsheet.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>dateTimeRenderOption</td>
            <td>How dates, times, and durations should be represented in the output. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/DateTimeRenderOption).</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>majorDimension</td>
            <td>The major dimension that results should use. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values#Dimension).</td>
            <td>Optional.</td>
        </tr>                
        <tr>
            <td>valueRenderOption</td>
            <td> How values should be represented in the output. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/ValueRenderOption).</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response. For the following request only the `valueRanges` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.getMultipleCellData>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <ranges>{$ctx:ranges}</ranges>
        <dateTimeRenderOption>{$ctx:dateTimeRenderOption}</dateTimeRenderOption>
        <majorDimension>{$ctx:majorDimension}</majorDimension>
        <valueRenderOption>{$ctx:valueRenderOption}</valueRenderOption>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.getMultipleCellData>
    ```

    **Sample request**
    
    This will allow you to get cell data by specifying multiple cell range using ranges parameter. Here we can specify multiple cell ranges as a comma sperated.

    ```json
    {
    	"clientId":"617729022812-xxxxxxxxxxxx.apps.googleusercontent.com",
    	"clientSecret":"xxxxxxxxxxxxxxxxxxxxxx",
    	"refreshToken":"1/xxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
    	"accessToken":"ya29.xxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
    	"apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
    	"spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
    	"ranges":"Sheet1!A1:B2,Sheet1!B1:C2,Sheet1!D4:G5",
    	"dateTimeRenderOption":"SERIAL_NUMBER",
    	"majorDimension":"ROWS",
    	"valueRenderOption":"UNFORMATTED_VALUE"
    }
    ```
    **Sample response**
    
    In the response we will get all cell data that is in the specified cell ranges.

    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "valueRanges": [
            {
                "range": "Sheet1!A1:B2",
                "majorDimension": "ROWS",
                "values": [
                    [
                        "20",
                        "21"
                    ],
                    [
                        "22",
                        "23"
                    ]
                ]
            },
            {
                "range": "Sheet1!B1:C2",
                "majorDimension": "ROWS",
                "values": [
                    [
                        "21",
                        34
                    ],
                    [
                        "23",
                        47
                    ]
                ]
            },
            {
                "range": "Sheet1!D4:G5",
                "majorDimension": "ROWS"
            }
        ]
    }
    ```
          
??? note "googlespreadsheet.editCell"
    The editCell method allow you to edit the content of the cell with new values.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/update).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>data</td>
            <td>The new values to apply to the spreadsheet.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>valueInputOption</td>
            <td>How the input data should be interpreted. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/ValueInputOption).</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.editCell>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <range>{$ctx:range}</range>
        <valueInputOption>{$ctx:valueInputOption}</valueInputOption>
        <fields>{$ctx:fields}</fields>
        <majorDimension>{$ctx:majorDimension}</majorDimension>
        <values>{$ctx:values}</values>
    </googlespreadsheet.editCell>
    ```

    **Sample request**
    
    In the request we can specify which sheet.

    ```json
    {
    	"clientId":"617729022812-xxxxxxxxxxxxxx.apps.googleusercontent.com",
    	"clientSecret":"xxxxxxxxxxxxxxxxxx",
    	"refreshToken":"1/Si2q4aOZsaMlYW7bBIoO-fCyxRTyf-xxxxxxxxxxxxx",
    	"accessToken":"ya29.xxxxxxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
    	"apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
    	"spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
    	"range":"Sheet1!A1:E3",
        "majorDimension":"ROWS",
        "valueInputOption":"RAW",
        "values":[
          [
               "1111",
               "2222"
          ],
          [
               "3333",
               "4444"
          ]
         ]
    }
    ```
    **Sample response**
    
    In the response we will get updated details such as cell dimension, cell count, sheet range.

    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "updatedRange": "Sheet1!A1:B2",
        "updatedRows": 2,
        "updatedColumns": 2,
        "updatedCells": 4
    }
    ```
    
??? note "googlespreadsheet.editMultipleCell"
    The editMultipleCell method allow you to edit the content of multiple cell with new values.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/batchUpdate).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>data</td>
            <td>The new values to apply to the spreadsheet.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>valueInputOption</td>
            <td>How the input data should be interpreted. For more detail [click here](https://developers.google.com/sheets/api/reference/rest/v4/ValueInputOption).</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifying which fields to include in a partial response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.editMultipleCell>
         <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
         <data>{$ctx:data}</data>
         <valueInputOption>{$ctx:valueInputOption}</valueInputOption>
         <fields>{$ctx:fields}</fields>
    </googlespreadsheet.editMultipleCell>
    ```

    **Sample request**
    
    Edit the content of multiple cell ranges with new values. We can specify multiple cell ranges and values as JSON array in data.

    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxxx",
        "refreshToken":"1/Si2q4aOZsaMlYW7bBIoO-xxxxxxxxxxxxx-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "valueInputOption":"RAW",
        "data": [
              {
                "values": [["7","8"],["9","10"]],
                "range": "Sheet1!A6"
           }
        ]
    }
    ```
    **Sample response**
    
    In the response we will get updated cell, range details as as array in responses property.

    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "totalUpdatedRows": 2,
        "totalUpdatedColumns": 2,
        "totalUpdatedCells": 4,
        "totalUpdatedSheets": 1,
        "responses": [
            {
                "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
                "updatedRange": "Sheet1!A6:B7",
                "updatedRows": 2,
                "updatedColumns": 2,
                "updatedCells": 4
            }
        ]
    }
    ```
    
??? note "googlespreadsheet.updateCellsBatchRequest"
    The updateCellsBatchRequest method allows you to removes all values from a sheet while leaving any formatting unaltered. Specifying userEnteredValue in fields(within the requests property) without providing a corresponding value is interpreted as an instruction to clear values in the range. This can be used with other fields as well. For example, changing the fields(within the requests property) value to userEnteredFormat and making the request clears the sheet of all formatting, but leaves the cell values untouched..see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#updatecellsrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple updateCells operation within the spread sheet, need to repeat `updateCells` property within the `requests` property.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response. For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.updateCellsBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.updateCellsBatchRequest>
    ```

    **Sample request**
    
    ```json
    {
        "clientId":"617729022812-cxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"ry_AXMsEe5Sn9iVoOY7ATnb8",
        "refreshToken":"1/xxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "requests": [
             {
                 "updateCells": {
                     "start": {
                         "columnIndex": 3,
                         "rowIndex": 2,
                         "sheetId": 121832844
                     },
                     "rows": [
                         {
                             "values": [
                                 {"userEnteredValue": {"numberValue": 444}},
                                 {"userEnteredValue": {"numberValue": 777}}
                             ]
                         }
                     ],
                "fields": "userEnteredValue"
                }
            }
         ],
         "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.appendDimensionBatchRequest"
    The appendDimensionBatchRequest method allows you to appends empty rows and columns to the end of the sheet.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#appenddimensionrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple updateCells operation within the spread sheet, need to repeat `updateCells` property within the `requests` property.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response. For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.appendDimensionBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.appendDimensionBatchRequest>
    ```

    **Sample request**
    
    This sample requst allow you to append diamention in row wise with the length 2.
    
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "requests": [
             {
                 "appendDimension": {
                 "dimension": "ROWS",
                 "sheetId": 121832844,
                 "length": 2
             }
             }
             ],
        "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
     
??? note "googlespreadsheet.updateBordersBatchRequest"
    The updateBordersBatchRequest method allow you to edit cell borders.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#updatebordersrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple updateCells operation within the spread sheet, need to repeat `updateCells` property within the `requests` property.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response. For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.updateBordersBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.updateBordersBatchRequest>
    ```

    **Sample request**
    
    In following request we can specify for which range of the sheet the border need to be updated and the formatting details of the border.
    
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "requests": [
            {
              "updateBorders":
              {
                "range": {
                  "sheetId": 121832844,
                  "startRowIndex": 0,
                  "endRowIndex": 10,
                  "startColumnIndex": 0,
                  "endColumnIndex": 6
                },
                "top": {
                  "style": "DASHED",
                  "width": 1,
                  "color": {"blue": 1}
                },
                "bottom":
                {
                  "style": "DASHED",
                  "width": 1,
                  "color": {"blue": 1}
                },
                "innerHorizontal": {
                  "style": "DASHED",
                  "width": 1,
                  "color": {"blue": 1}
                }
               }
           }
        ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.updateBordersBatchRequest"
    The updateBordersBatchRequest method allow you to edit cell borders.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#updatebordersrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple updateCells operation within the spread sheet, need to repeat `updateCells` property within the `requests` property.</td>
            <td>Optional.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response. For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.updateBordersBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.updateBordersBatchRequest>
    ```

    **Sample request**
    
    In following request we can specify for which range of the sheet the border need to be updated and the formatting details of the border.
    
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "requests": [
            {
              "updateBorders":
              {
                "range": {
                  "sheetId": 121832844,
                  "startRowIndex": 0,
                  "endRowIndex": 10,
                  "startColumnIndex": 0,
                  "endColumnIndex": 6
                },
                "top": {
                  "style": "DASHED",
                  "width": 1,
                  "color": {"blue": 1}
                },
                "bottom":
                {
                  "style": "DASHED",
                  "width": 1,
                  "color": {"blue": 1}
                },
                "innerHorizontal": {
                  "style": "DASHED",
                  "width": 1,
                  "color": {"blue": 1}
                }
               }
           }
        ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.repeatCellsBatchRequest"
    The repeatCellsBatchRequest method allow you to updates all cells in the range to the values in the given Cell object. Only the fields listed in the fields(within the requests property)will be updated. Others are unchanged.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#repeatcellrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple repeatCell operation within the spread sheet, need to repeat `repeatCell` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response. For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.repeatCellsBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.repeatCellsBatchRequest>
    ```

    **Sample request**
    
    Here the formating specified in "cell" object will be repeted for row index from 13 to 15.
    
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "requests": [
        {
          "repeatCell": {
            "range": {
              "sheetId": 121832844,
              "startRowIndex": 13,
              "endRowIndex": 15
            },
            "cell": {
              "userEnteredFormat": {
                "backgroundColor": {
                  "red": 0.0,
                  "green": 0.0,
                  "blue": 0.0
                }
              }
            },
            "fields": "userEnteredFormat(backgroundColor)"
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.mergeCellsBatchRequest"
    The mergeCellsBatchRequest  method allow you to merges all cells in the range.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#mergecellsrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple mergeCells operation within the spread sheet, need to repeat `mergeCells` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.mergeCellsBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.mergeCellsBatchRequest>
    ```

    **Sample request**
        
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "requests": [
        {
          "mergeCells": {
            "range": {
              "sheetId": 121832844,
              "startRowIndex": 0,
              "endRowIndex": 2,
              "startColumnIndex": 0,
              "endColumnIndex": 2
            },
            "mergeType": "MERGE_ALL"
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.setDataValidationBatchRequest"
    The setDataValidationBatchRequest Sets a data validation rule to every cell in the range. To clear validation in a range, call this with no rule specified..see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#setdatavalidationrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td> It contains data that is a kind of update to apply to a spreadsheet. To perform multiple setDataValidation operation within the spread sheet, need to repeat `setDataValidation` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.setDataValidationBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.setDataValidationBatchRequest>
    ```

    **Sample request**
        
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "refreshToken":"1/xx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "requests": [
        {
          "mergeCells": {
            "range": {
              "sheetId": 121832844,
              "startRowIndex": 0,
              "endRowIndex": 2,
              "startColumnIndex": 0,
              "endColumnIndex": 2
            },
            "mergeType": "MERGE_ALL"
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.copyPasteBatchRequest"
    The copyPasteBatchRequest method allows you to copy cell formatting in one range and paste it into another range on the same sheet.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#copypasterequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td> It contains data that is a kind of update to apply to a spreadsheet. To perform multiple copyPaste operation within the spread sheet, need to repeat `copyPaste` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.copyPasteBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.copyPasteBatchRequest>
    ```

    **Sample request**
    
    The following request copies the formatting in range A1:D10 and pastes it to the F1:I10 range on the same sheet. The original values in A1:I10 remain unchanged.
        
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"ry_AXMsEe5Sn9iVoOY7ATnb8",
        "refreshToken":"1/xxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.xxxxxxxxxxx-pOuVvnbnHhkVn5u8t6Qr",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA",
        "requests": [
        {
          "copyPaste": {
            "source": {
              "sheetId": 121832844,
              "startRowIndex": 0,
              "endRowIndex": 10,
              "startColumnIndex": 0,
              "endColumnIndex": 4
            },
            "destination": {
              "sheetId": 121832844,
              "startRowIndex": 0,
              "endRowIndex": 10,
              "startColumnIndex": 5,
              "endColumnIndex": 9
            },
            "pasteType": "PASTE_FORMAT",
            "pasteOrientation": "NORMAL"
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.cutPasteBatchRequest"
    The cutPasteBatchRequest method allows you to cuts the one range and pastes its data, formats, formulas, and merges to the another range on the same sheet.see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#cutpasterequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple cutPaste operation within the spread sheet, need to repeat `cutPaste` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.cutPasteBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.cutPasteBatchRequest>
    ```

    **Sample request**
    
    The following request cuts the range A1:D10 and pastes its data, formats, formulas, and merges to the F1:I10 range on the same sheet. The original source range cell contents are removed.
        
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.Ci-xxxxxxxxxxxxx",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "14PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
        "requests": [
        {
          "cutPaste": {
            "source": {
              "sheetId": 1020069232,
              "startRowIndex": 0,
              "endRowIndex": 10,
              "startColumnIndex": 0,
              "endColumnIndex": 4
            },
            "destination": {
              "sheetId": 401088778,
              "rowIndex": 0,
              "columnIndex": 5
            },
            "pasteType": "PASTE_NORMAL"
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.updateConditionalFormatRuleBatchRequest"
    The updateConditionalFormatRuleBatchRequest method allows you to updates a conditional format rule at the given index, or moves a conditional format rule to another index,see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#updateconditionalformatrulerequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple updateConditionalFormatRule operation within the spread sheet, need to repeat `updateConditionalFormatRule` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.updateConditionalFormatRuleBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.updateConditionalFormatRuleBatchRequest>
    ```

    **Sample request**
    
    The following request replaces the conditional formatting rule at index 0 with a new rule that formats cells containing the exact text specified ("Total Cost") in the A1:D5 range.
        
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.Ci-xxxxxxxxxxxxxxxxxxxxxx-kQ9Wri4bsf4TEulw",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "14PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
        "requests": [
        {
          "updateConditionalFormatRule": {
            "sheetId": 1020069232,
            "index": 0,
            "rule": {
              "ranges": [
                {
                  "sheetId": 1020069232,
                  "startRowIndex": 0,
                  "endRowIndex": 5,
                  "startColumnIndex": 0,
                  "endColumnIndex": 4
                }
              ],
              "booleanRule": {
                "condition": {
                  "type": "TEXT_EQ",
                  "values": [
                    {
                      "userEnteredValue": "Total Cost"
                    }
                  ]
                },
                "format": {
                  "textFormat": {
                    "bold": true
                  }
                }
              }
            }
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.addConditionalFormatRuleBatchRequest"
    The addConditionalFormatRuleBatchRequest method allows you to adds a new conditional format rule at the given index,see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#addconditionalformatrulerequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple addConditionalFormatRule operation within the spread sheet, need to repeat `addConditionalFormatRule` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.addConditionalFormatRuleBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.addConditionalFormatRuleBatchRequest>
    ```

    **Sample request**
    
    The following request establishes new gradient conditional formatting rules for row 10 and 11 of a sheet. The first rule states that cells in that row have their backgrounds colored according to their value. The lowest value in the row will be colored dark red, while the highest value will be colored bright green. The color of other values will be determined by interpolation.
        
    ```json
    {
        "clientId":"617729022812-vjo2edd0i4bcb38ifu4qg17ke5nn6f2m.apps.googleusercontent.com",
        "clientSecret":"ry_AXMsEe5Sn9iVoOY7ATnb8",
        "refreshToken":"1/Si2q4aOZsaMlYW7bBIoO-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.Ci-CA9sR2IXoOaVg9fpRwf8fEhF8lqfOJL1FpRihUlNxEa8kw-kQ9Wri4bsf4TEulw",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "14PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
        "requests": [
        {
          "addConditionalFormatRule": {
            "rule": {
              "ranges": [
                {
                  "sheetId": 1020069232,
                  "startRowIndex": 10,
                  "endRowIndex": 11
                }
              ],
              "gradientRule": {
                "minpoint": {
                  "color": {
                    "green": 0.2,
                    "red": 0.8
                  },
                  "type": "MIN"
                },
                "maxpoint": {
                  "color": {
                    "green": 0.9
                  },
                  "type": "MAX"
                }
              }
            },
            "index": 0
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.deleteConditionalFormatRuleBatchRequest"
    The deleteConditionalFormatRuleBatchRequest method allows you to deletes a conditional format rule at the given index,see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#DeleteConditionalFormatRuleRequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple deleteConditionalFormatRule operation within the spread sheet, need to repeat `deleteConditionalFormatRule` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.deleteConditionalFormatRuleBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.deleteConditionalFormatRuleBatchRequest>
    ```

    **Sample request**
    
    The following request deletes the conditional formatting rule having index 0 in the sheet specified by sheetId.
        
    ```json
    {
        "clientId":"617729022812-vjo2edd0i4bcb38ifu4qg17ke5nn6f2m.apps.googleusercontent.com",
        "clientSecret":"ry_AXMsEe5Sn9iVoOY7ATnb8",
        "refreshToken":"1/Si2q4aOZsaMlYW7bBIoO-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.Ci-CA9sR2IXoOaVg9fpRwf8fEhF8lqfOJL1FpRihUlNxEa8kw-kQ9Wri4bsf4TEulw",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "14PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
        "requests": [
        {
          "deleteConditionalFormatRule": {
            "sheetId": 1020069232,
            "index": 0
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.updateDimensionPropertiesBatchRequest"
    The updateDimensionPropertiesBatchRequest method allows you to updates properties of dimensions within the specified range,see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#updatedimensionpropertiesrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple updateDimensionProperties operation within the spreadsheet, need to repeat `updateDimensionProperties` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.updateDimensionPropertiesBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.updateDimensionPropertiesBatchRequest>
    ```

    **Sample request**
    
    The following request updates the width of column A to 160 pixels.
        
    ```json
    {
        "clientId":"617729022812-vjo2edd0i4bcb38ifu4qg17ke5nn6f2m.apps.googleusercontent.com",
        "clientSecret":"ry_AXMsEe5Sn9iVoOY7ATnb8",
        "refreshToken":"1/Si2q4aOZsaMlYW7bBIoO-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.Ci-CA9sR2IXoOaVg9fpRwf8fEhF8lqfOJL1FpRihUlNxEa8kw-kQ9Wri4bsf4TEulw",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "14PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
        "requests": [
        {
          "updateDimensionProperties": {
            "range": {
              "sheetId": 1020069232,
              "dimension": "COLUMNS",
              "startIndex": 0,
              "endIndex": 1
            },
            "properties": {
              "pixelSize": 160
            },
            "fields": "pixelSize"
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.autoResizeDimensionsBatchRequest"
    The autoResizeDimensionsBatchRequest method allows you to automatically resizes one or more dimensions based on the contents of the cells in that dimension,see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#autoresizedimensionsrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple autoResizeDimensions operation within the spread sheet, need to repeat `autoResizeDimensions` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.autoResizeDimensionsBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.autoResizeDimensionsBatchRequest>
    ```

    **Sample request**
    
    The following request turns on automatic resizing of columns A:C, based on the size of the column content. Automatic resizing of rows is not supported.
        
    ```json
    {
        "clientId":"617729022812-xxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.Ci-xxxxxxxxxxx-kQ9Wri4bsf4TEulw",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "14PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
        "requests": [
        {
          "autoResizeDimensions": {
            "dimensions": {
              "sheetId": 1020069232,
              "dimension": "COLUMNS",
              "startIndex": 0,
              "endIndex": 3
            }
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.insertDimensionBatchRequest"
    The insertDimensionBatchRequest method allows you to inserts rows or columns in a sheet at a particular index.,see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#insertdimensionrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple insertDimension operation within the spread sheet, need to repeat `insertDimension` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.insertDimensionBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.insertDimensionBatchRequest>
    ```

    **Sample request**
    
    The following request inserts two blank columns at column C. The inheritBefore field, if true, tells the API to give the new columns or rows the same properties as the prior row or column; otherwise the new columns or rows acquire the properties of those that follow them. inheritBefore cannot be true if inserting a row at row 1 or a column at column A.
        
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxx",
        "refreshToken":"1/Si2q4aOZsaMlYW7bBIxxxxxxxxxxxxxxoO-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.Ci-xxxxxxxxxxxxxxxxxx-kQ9Wri4bsf4TEulw",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "14PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
        "requests":[
        {
          "insertDimension":
          {
            "range":
            {
              "sheetId": 1020069232,
              "dimension": "COLUMNS",
              "startIndex": 2,
              "endIndex": 4
            },
            "inheritFromBefore": true
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
      
??? note "googlespreadsheet.moveDimensionBatchRequest"
    The moveDimensionBatchRequest method allows you to moves one or more rows or columns,see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#movedimensionrequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td>It contains data that is a kind of update to apply to a spreadsheet. To perform multiple moveDimension operation within the spread sheet, need to repeat `moveDimension` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.insertDimensionBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.insertDimensionBatchRequest>
    ```

    **Sample request**
    
    The following request moves column A to the column D position.
        
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.Ci-xxxxxxxxxxxx-kQ9Wri4bsf4TEulw",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "14PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
        "requests":[
        {
          "moveDimension":
          {
            "source":
            {
              "sheetId": 1020069232,
              "dimension": "COLUMNS",
              "startIndex": 0,
              "endIndex": 1
            },
            "destinationIndex": 3
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```
    
??? note "googlespreadsheet.sortRangeBatchRequest"
    The sortRangeBatchRequest method allows you to sorts data in rows based on a sort order per column,see [the Google Spreadsheet documentation](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#sortrangerequest).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>spreadsheetId</td>
            <td>Unique value of the spreadsheet</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>requests</td>
            <td> It contains data that is a kind of update to apply to a spreadsheet. To perform multiple sortRange operation within the spread sheet, need to repeat `sortRange` property within the `requests` property.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>fields (Outside the requests property)</td>
            <td>Specifying which fields to include in a partial response.For the following request only the `spreadsheetId` will be included in the response.</td>
            <td>Optional.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <googlespreadsheet.sortRangeBatchRequest>
        <spreadsheetId>{$ctx:spreadsheetId}</spreadsheetId>
        <requests>{$ctx:requests}</requests>
        <fields>{$ctx:fields}</fields>
    </googlespreadsheet.sortRangeBatchRequest>
    ```

    **Sample request**
    
    The following request sorts the range A1:F10, first by column B in ascending order, then by column D in descending order, then by column E in descending order.
        
    ```json
    {
        "clientId":"617729022812-xxxxxxxxxxxxxx.apps.googleusercontent.com",
        "clientSecret":"xxxxxxxxxxxx",
        "refreshToken":"1/xxxxxxxxxxxxx-fCyxRTyf-LpK6fDWF9DgcM",
        "accessToken":"ya29.Ci-xxxxxxxxxxx-kQ9Wri4bsf4TEulw",
        "apiUrl":"https://sheets.googleapis.com/v4/spreadsheets",
        "spreadsheetId": "14PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
        "requests": [
        {
          "sortRange": {
            "range": {
              "sheetId": 1020069232,
              "startRowIndex": 0,
              "endRowIndex": 10,
              "startColumnIndex": 0,
              "endColumnIndex": 6
            },
            "sortSpecs": [
              {
                "dimensionIndex": 1,
                "sortOrder": "ASCENDING"
              },
              {
                "dimensionIndex": 3,
                "sortOrder": "DESCENDING"
              },
              {
                "dimensionIndex": 4,
                "sortOrder": "DESCENDING"
              }
            ]
          }
        }
      ],
      "fields": "spreadsheetId"
    }
    ```
    **Sample response**
    
    ```json
    {
        "spreadsheetId": "12KoqoxmykLLYbtsm6CEOggk5bTKMEIFGCD9EBdrXFGA"
    }
    ```