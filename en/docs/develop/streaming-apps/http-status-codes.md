## HTTP Status Codes

When REST API requests are sent to carryout various actions, various HTTP status codes will be returned based on the state of the action (success or failure) and the HTTP method (`POST, GET, PUT, DELETE`) executed. The following are the definitions of the various HTTP status codes that are returned.


### HTTP status codes indicating successful delivery

| Code | Code Summary | Description                                                                                                                                                                                                                       |
|------|--------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 200  | Ok           | HTTP request was successful. The output corresponding to the HTTP request will be returned. Generally used as a response to a successful `             GET            ` and `             PUT            ` REST API HTTP methods. |
| 201  | Created      | HTTP request was successfully processed and a new resource was created. Generally used as a response to a successful `             POST            ` REST API HTTP method.                                                        |
| 204  | No content   | HTTP request was successfully processed. No content will be returned. Generally used as a response to a successful `             DELETE            ` REST API HTTP method.                                                        |
| 202  | Accepted     | HTTP request was accepted for processing, but the processing has not been completed. This generally occurs when your successful in trying to undeploy an application.                                                             |

### Error HTTP status codes

| Code | Code Summary          | Description                                                                                                                                                                                                                                 |
|------|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 404  | Not found             | Requested resource not found. Generally used as a response for unsuccessful `             GET            ` and `             PUT            ` REST API HTTP methods.                                                                        |
| 409  | Conflict              | Request could not be processed because of conflict in the request. This generally occurs when you are trying to add a resource that already exists. For example, when trying to add an auto-scaling policy that has an already existing ID. |
| 500  | Internal server error | Server error occurred.                                                                                                                                                                                                                      |
