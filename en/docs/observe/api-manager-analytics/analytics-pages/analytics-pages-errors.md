# Error Page
![error page full]({{base_path}}/assets/img/observe/error/error-page-full.png)

The error page displays analytics stats related to erroneous API calls that happened within the API management deployment. 
Page will include error categorization based on the error type and then further drills down into sub types. 
You can use this page as the starting point for debugging any API errors.
See the topics given below to get details of the available widgets.

## Common Controls
![common controls]({{base_path}}/assets/img/observe/error/common-controls.png)

The Error page offers you the three additional common controls listed below.
### API Selector
Use the **API Selector** to select the APIs for which you want to view analytics. By default, this is set to **All**. You can select one or multiple APIs from this selector and view the aggregated result.

### Category/Status Code Toggle
Use this toggle to switch between the error category view and the status code view. When you use the **Category** mode, the errors are categorized by predefined types. 
If you select the **Status Code** mode, you can observe errors categorized by the client-side status code. The **Category** view is more suitable for business analytics purposes while the **Status Code** mode is more suitable for troubleshooting and finding faulty APIs. 

The other common controls and chart layouts change depending on this toggle. 

### Category Selector
The **Category Selector** is enabled only when you have selected the **Category** toggle explained above. You can use this to select one or all of the error categories listed below.
- Authentication: Any kind of authentication error falls into this category including expired/missing/invalid credentials.
- Target Connectivity: Any kind of API backend errors will fall into this category including connection time-outs/backend error(4xx ,5xx status codes)
- Throttling: Any kind of API back-end error falls into this category including application throttling/subscription throttling.
- Other: All other errors fall into this category including mediation errors/resource not found errors.

### Status Code Selector
**Status Code Slector** is enabled only when you have selected **Status Code** toggle explained above. Using this selector you can select all or any available HTTP status code
category(4xx, 5xx). These status codes represent the response status code of the API Gateway.

## Page Walk Through
Page composition is dynamic based on the Category/Status Code Toggle as explained above. Hence both views will be detailed out below.

### Category Mode
The following topics walk you through the main features available for monitoring errors under **Category** mode.

#### Errors by Category Graph
This graph shows error category distribution over time for the selected time period. You can decide the APIs and categories by the controllers explained above.
When you select multiple APIs, error count will be grouped by the category.

![error category graph]({{base_path}}/assets/img/observe/error/error-category-graph.png)
#### Errors by Category Table   
This table will provide further information about the errors such as application details, reason etc. For some authentication errors application name will not be available.
You can use this table to get mode concrete information about errors of your API management system and then start the problem isolation process.

![error category table]({{base_path}}/assets/img/observe/error/error category table.png)
### Status Code Mode
The following topics walk you through the main features available for monitoring errors under **Status Code** mode.

#### Errors by Status Code Graph
This graph shows error HTTP status code distribution over time for the selected time period. You can decide the APIs and status codes groups by the controllers explained above.
When you select multiple APIs, error count will be grouped by the status code group.

![error by status code]({{base_path}}/assets/img/observe/error/error-by-status-code.png)
#### Proxy Errors Heatmap
Proxy errors heatmap shows the error http response codes sent to the client by API Gateway. Each individual status code will be shown against the selected APIs. 
Cell colour will be determined by the number of errors belonging to each status code. Higher the number cell colour will be red and lower the number cell colour will be white.
Using this chart you can further drill down on error code groups that you identified with the **Errors by Status Code** graph.

![proxy error heatmap]({{base_path}}/assets/img/observe/error/proxy-error-heatmap.png)
#### Target Errors Heatmap
Target errors heatmap shows the error http response codes received by API Gateway from the backend. Each individual status code will be shown against the selected APIs. 
Cell colour will be determined by the number of errors belonging to each status code. Higher the number cell colour will be red and lower the number cell colour will be white.
Using this chart you can further drill down on error code groups that you identified with the **Errors by Status Code** graph.

![target error heatmap]({{base_path}}/assets/img/observe/error/target-error-heatmap.png)
