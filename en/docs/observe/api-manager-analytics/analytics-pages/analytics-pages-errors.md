# Error Page

The error page shows information related to erroneous API calls that are received by your API management deployment. The errors are categorization based on the error type. You can further drill down using the error subtypes. Use this page as the starting point for debugging any API errors. 

![error page full]({{base_path}}/assets/img/observe/error/error-page-full.png)

See the topics given below to get details of the available widgets.

## Common Controls

The Error page offers you the three additional common controls listed below.

![common controls]({{base_path}}/assets/img/observe/error/common-controls.png)

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
The **Status Code** selector is enabled only when you have selected the **Status Code** toggle explained above. You can use this to select all or any available HTTP status code category (4xx, 5xx, etc.). These status codes represent the response status of the API Gateway.

## Page Walk Through
The content you see on this page depends on the Category/Status Code Toggle as explained above. See the details given below.

### Category Mode
The following topics walk you through the main features available for monitoring errors under **Category** mode.

#### Errors by Category Graph
This graph shows the error category distribution over time for the selected period. Use the controllers (explained above) to select the APIs to which this content applies.
When you select multiple APIs, the error count is grouped by the category.

![error category graph]({{base_path}}/assets/img/observe/error/error-category-graph.png)
#### Errors by Category Table   
This table provides further information about the errors such as application details and the error reason. For some authentication errors, the application name is not available.
You can use this table to get more concrete information about the errors of your API management system and then start the problem isolation process.

![error category table]({{base_path}}/assets/img/observe/error/error category table.png)
### Status Code Mode
The following topics walk you through the main features available for monitoring errors under **Status Code** mode.

#### Errors by Status Code Graph
This graph shows the distribution of HTTP status codes (of the errors) over time for the selected period. Use the controllers (explained above) to select the APIs and status code groups to which this content applies.
When you select multiple APIs, the error count is grouped by the status code group.

![error by status code]({{base_path}}/assets/img/observe/error/error-by-status-code.png)
#### Proxy Errors Heatmap
Proxy errors heatmap shows the HTTP response codes of errors that are sent to the client by the API Gateway. Each status code is shown against the selected APIs.
The cell color is determined by the number of errors belonging to each status code. The cell color is red for higher numbers and white for lower numbers.
Using this chart you can further drill down on error code groups that you identified with the **Errors by Status Code** graph.

![proxy error heatmap]({{base_path}}/assets/img/observe/error/proxy-error-heatmap.png)
#### Target Errors Heatmap
Target errors heatmap shows the error http response codes received by API Gateway from the backend. Each individual status code will be shown against the selected APIs. 
Cell colour will be determined by the number of errors belonging to each status code. Higher the number cell colour will be red and lower the number cell colour will be white.
Using this chart you can further drill down on error code groups that you identified with the **Errors by Status Code** graph.

![target error heatmap]({{base_path}}/assets/img/observe/error/target-error-heatmap.png)
