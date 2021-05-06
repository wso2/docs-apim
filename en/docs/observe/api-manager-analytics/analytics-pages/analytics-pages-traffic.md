# Traffic Page
![traffic page full]({{base_path}}/assets/img/observe/traffic/traffic-page-full.png)

This page displays all traffic related information available in the system such as API Usage, Application Usage
, Resource Usage, etc. You can utilize this page to drill-down more into API and Application usages, traffic patterns
 and mostly used APIs/Applications. Rest of the document will explain each widget in detail.
 
## Common Controls
![common controls]({{base_path}}/assets/img/observe/traffic/common-controls.png)

This page offers two additional common controls for the user. 
### API Selector
API selector allows user to select the APIs that they want to view analytics within this page. By default, this is
 set to **All** option. you can select one or multiple APIs from this selector and aggregated result will be shown
  in the page. Depending on the selection of this drop-down next common control **Application** will be populated.
### Application Selector
Application selector allows users to further narrow down search into application level. If same API is used by
 multiple applications, using this selector you can get the separate traffic per each application or for a set of
  applications. Available options on this drop-down depends on the selection of API selector.
  
## Page Walk Through
### API Usage Overtime
![api usage timeline]({{base_path}}/assets/img/observe/traffic/api-usage-timeline.png)

This timeline shows API hit count for selected set of APIs by above mentioned selectors. If multiple APIs are
 selected then timeline will show each API in a separate line with a legend clearly separating each line.
 
## API Usage by Application
![usage by application]({{base_path}}/assets/img/observe/traffic/usage-by-application.png)

This widget shows an application wise breakdown of the API requests as selected by the common controls. There is a
 pie chart view, and a line chart view which you can switch between using the small icon on the top right hand corner
  of the widget.
  
## API Usage by backend
![usage by backend]({{base_path}}/assets/img/observe/traffic/usage-by-backend.png)

This widget shows API backend wise breakdown of the API requests as selected by the common controls. This is useful
 when multiple APIs are sharing the same backend which has traffic restrictions. Using these stats you can take
  proactive steps to scale your backends beforehand. There is a pie chart view, and a line chart view which you can
   switch between using the small icon on the top right-hand corner of the widget.
## API Resource Usage Summary
![resource usage]({{base_path}}/assets/img/observe/traffic/resource-usage.png)

This table shows resource-level breakdown of API traffic. Each row will represent a resource of API and it will show
 API name, resource path, API method and hit count for that combination. Special point to not is that above mentioned
  two common controls won't be applicable to this table. 