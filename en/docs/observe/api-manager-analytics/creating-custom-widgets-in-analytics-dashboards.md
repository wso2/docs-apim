#Creating Custom Widgets

In addition to already available widgets in the analytics dashboards, you can implement your own custom widget and use them across the dashboards.

A widget in the Analytics dashboard is a ReactJS component that can be used to visualize information. A widget can have any static or interactive visualizations such as charts, tables, filters with drill-down and inter widget communication capabilities.

In order to identify a particular ReactJS component  as a widget by the dashboard, it needs to register itself as a widget in the portal.

WSO2 API-M Analytics has a widget generator tool to automatically generate the widget skeleton based on the user preferences that are provided via the command-line tool.

Follow the instructions below to create a custom widget:

Let’s assume the following.

- You need to create a custom widget named `APIMApiTraffic`.
- The widget is a subscriber widget.
- The widget uses `SiddhiDataProvider` to retrieve the data. 

## Step 1 - Create a custom widget

Follow the instructions below to create a custom widget named `APIMApiTraffic` that can retrieve the published data:

1. Navigate to the `<API-M_ANALYTICS_HOME>/wso2/tools/generator-widget` directory and issue the following command to initialize the widget generator.

    ```
    npm run init    
    ```
   Hereafter, the above directory will be referred to as `<TOOL_HOME>`.
   
2. Open a new terminal in `<TOOL_HOME>` directory and issue the following command to generate the widget template.

    ```
    npm run createwidget--widgettype:subscriber--dataprovider:SiddhiDataProvider    
    ```
     You will be asked to provide the widget name and the  widget heading.
   
3. Enter the widget name as `APIMApiTraffic` and widget heading as `Total Traffic`.

     Based on the user preferences, the widget skeleton will be created inside the `<TOOL_HOME>/widgetTemplates` directory, and the relevant dependencies will be installed in the `<TOOL_HOME>/widgetTemplates/APIMApiTraffic` directory, which will be hereafter referred to as `<WIDGET_ROOT>`.

     The following file structure will be created inside the `<WIDGET_ROOT>` directory.
     
     ```
     APIMApiTraffic
     ├── src
     │   ├── resources
     │   │     └──widgetConf.json
     │   └── APIMApiTrafficWidget.jsx  
     ├── package.json
     └── webpack.config.js
     ```

    <html>
    <details class="info">
    <summary>Click here for descriptions of the files in the Widget directory</summary>
    <p>The following section describes the files that are available in the `<WIDGET_ROOT>` directory.

    <ol>
    <li><b>Package.json</b></br>
    Package.json file holds metadata relevant to the widget. This file is used to give information to npm that allows it to identify the widget as well as handle the dependencies.
    
    <table>
    <thead>
    <tr class="header">
    <th>**Dependency**</th>
    <th>**Version**</th>
    <th>**Description**</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td width="30%"><code>@wso2-dashboards/widget</code></td>
    <td width="10%">
    <code>
    ^1.4.0
    </code>
    </td>
    <td>
    WSO2 Dashboard Component
    </td>
    </tr>
    
    <tr class="even">
    <td width="30%"><code>@material-ui/core</code></td>
    <td width="10%">
    <code>
    ^3.9.0
    </code>
    </td>
    <td>
    To use react components from material-ui library
    </td>
    </tr>
    
    <tr class="odd">
    <td width="30%"><code>@material-ui/icons</code></td>
    <td width="10%">
    <code>
    ^3.0.2
    </code>
    </td>
    <td>
    To use icons from material-ui library
    </td>
    </tr>
    
    <tr class="odd">
    <td width="30%"><code>React</code></td>
    <td width="10%">
    <code>
    ^16.7.0
    </code>
    </td>
    <td>
    Functionality necessary to define React components
    </td>
    </tr>
    
    <tr class="odd">
    <td width="30%"><code>react-dom</code></td>
    <td width="10%">
    <code>
    ^16.7.0
    </code>
    </td>
    <td>
    Serves as the entry point to the DOM and server renderers for React
    </td>
    </tr>
    
    <tr class="odd">
    <td width="30%"><code>react-custom-scrollbars</code></td>
    <td width="10%">
    <code>
    ^4.2.1
    </code>
    </td>
    <td>
    To wrap the content with the custom scroll component
    </td>
    </tr>
    
    <tr class="odd">
    <td width="30%"><code>rimraf</code></td>
    <td width="10%">
    <code>
    ^2.6.3
    </code>
    </td>
    <td>
    Provides the Unix command <code>rm -rf</code>
    </td>
    </tr>
    
    <tr class="odd">
    <td width="30%"><code>victory</code></td>
    <td width="10%">
    <code>
    ^31.0.2
    </code>
    </td>
    <td>
    Components for modular charting and data visualization
    </td>
    </tr>
    
    </tbody>
    </table>
    </li>
    <li>
    <b>widgetConf.json</b></br>
    This contains the meta information of the widget such as widget ID, widget name and configurations. Following are the main configurations included in the  `widgetConf.json` file.

    <ul><li>
    <code>pubsub</code> - To declare  whether the widget is a publisher or subscriber in the publisher-subscriber concept.
            
    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>The analytics dashboard allows inter-widget communication via publisher/subscriber model. In the publisher/subscriber approach the publisher or the sender sends messages without specifically targeting a subscriber or a receiver. The receiver individually declares the interest in one or more messages published by a particular publisher or set of publishers.</p>
    </div>

    </li>
    <li>
    <code>providerConfig</code> - To declare the data source and the queries from which the data is fetched. You have the ability to write many queries here and select the specific query in runtime,  and also you can use query templates in the default query and assemble it in  runtime.
    </li>
    <li>
    <code>options</code> - Used to integrate the header removing facility to widgets.
    </li></ul>
    </li>
    <li>
    <b>Webpack.config.js</b></br>
    `Webpack.config.js` is basically used to configure the entry point and the output result directory of the widget. By default, it will assume that the entry point of your widget is `src/index` and will output the result in `dist/main.js` minified and optimized for production.</br>
    Furthermore, below properties are included in the `Webpack.config.js` file</br>
    <ul><li>   **context** : The Base directory to resolve entry points and loaders.</li>
    <li>   **entry**   : Application execution starting point.</li>
    <li>   **output**  : options related to how webpack emits results.</li>
    <li>   **module**  : configuration regarding modules.</li>
    <li>   **plugins** : Used to customize the webpack build process in a variety of ways.</li></ul>
    </li>
    </ul>
    </p>

    </details>
    </html>

4. Start a node development environment and create a Symlink.
 
     Issue the following commands in the `<WIDGET_ROOT>` directory to start a node development environment and create a symlink from `<WIDGET_ROOT>` directory to `<ANALYTICS_HOME>/wso2/dashboard/deployment/web-ui-apps/analytics-dashboard/extensions/widgets` directory.

    ```
    npm run dev
    ```
    
    !!! note
        Creating a development environment and Symlink, will instantly update the changes to the UI. You do not need to restart the dashboard profile every time to see the changes.
    
5. Start the dashboard profile of the Analytics Server.

    !!! note
        If you have already started the dashboard profile, restart the dashboard profile to render the new widget to the dashboard.
        
6. Sign in to the Dashboard Portal and create a new dashboard.
   
     For instructions on creating a new dashboard, see [Creating New Dashboards](https://docs.wso2.com/display/SP440/Creating+New+Dashboards).
   
7. You can view the newly created `APIMApiTraffic` widget in the widget listing panel of the Dashboard Designer. Drag and drop the `APIMApiTraffic` widget to the dashboard.

    !!! note
        - The `APIMApiTraffic` widget is a subscriber widget and it retrieves published data. 
        - To configure a publisher widget, drag and drop the `DateTimeRangePicker` widget to the same page.
        
8. Click on the configuration icon in the top-left of the `APIMApiTraffic` widget. 

     This will open the “Widget configurations” panel which lists all the publishers in the dashboard.

9. Select the Date time Range.
    
    [![APIMApiTraffic configurations]({{base_path}}/assets/img/learn/apim-apitraffic-configurations.png)]({{base_path}}/assets/img/learn/apim-apitraffic-configurations.png)
    
## Step 2 - Define the database configurations for the widget

Follow the instructions below to define the database configurations for the `APIMApiTraffic` widget so that the traffic data will be retrieved from the database and displayed on the widget.

1.  Navigate to the `<WIDGET_ROOT>/src/resources` directory and replace the following configurations of the `widgetConf.json` file.

    !!! note
        -   Data providers are the sources from which information is fetched to be displayed in widgets, you can use either `SiddhiStoreDataProvider` or `RDBMSDataProvider`. For more information on data providers, see [Working with data providers](https://docs.wso2.com/display/SP440/Working+with+Data+Providers#WorkingwithDataProviders-SiddhiStoreDataProvider).
        -   In order to retrieve data , you must create a Siddhi app and a Siddhi query. For more information, see [Siddhi query guide](https://siddhi.io/en/v5.1/docs/query-guide/).
        -   `publishingInterval` refers to the frequency with which you want the data provider to poll data from the Siddhi store. The time interval is specified in seconds.
        
2.  Navigate to the `<WIDGET_ROOT>` directory and update the content of the `APIMApiTrafficWidget.jsx` file as follows to handle the data received from the query.

    1. Declare a new variable named `usageData` and add it to the state.

        ```
        this.state = {
            usageData: null,
        };
        ```  
    2. Modify the `queryName` parameter of the `assembleQuery` method as `apiUsageQuery`.

        ```
        dataProviderConfigs.configs.config.queryData.queryName = 'apiusagequery';
        ```

    3. Update the `handleQueryResults` method as follows to format the retrieved data.

        ```
        handleQueryResults(message) {
            const { data } = message;
            if (data) {
                const usageData = [];
                data.forEach((dataUnit) => {
                    usageData.push({
                        API: dataUnit[0] + '(' + dataUnit[1] + ')', Traffic: dataUnit[2],
                    });
                });    
                this.setState({ usageData });
            }
        }
        ```

## Step 3 - Create a traffic chart to display data

1.  Navigate to `<WIDGET_ROOT>` directory and create a functional component named `TrafficChart.jsx`. </br>
    
     Now, the directory structure inside the `<WIDGET_ROOT>` directory will be as follows.
    ```
     APIMApiTraffic
     ├── dist
     ├── node_modules
     ├── src
     │   ├── resources
     │   ├── APIMApiTrafficWidget.jsx     
     │   └── TrafficChart.jsx  
     ├── package.json
     └── webpack.config.js
    ```
    
2.  Update the `TrafficChart.jsx` as follows.

    ```
    import React from 'react';
    import PropTypes from 'prop-types';
    import { VictoryBar, VictoryChart, VictoryAxis } from 'victory';
    
    export default function TrafficChart(props) {
        const { data } = props;
        const  styles = {
            victorybar: {
                display: 'flex',
                flexWrap: 'wrap',
                data: { fill: 'rgb(0, 107, 201)', width: 5 },
            },
            victoryaxis: {
                axisLabel: {
                    padding: 30,
                    fill: '#fff',
                    fontsize: '8px',
                },
            },
        };
    
        const chartTheme = {
            axis: {
                style:  {
                    tickLabels: {
                        fill: '#fff',
                        fontSize: '8px',
                        angle: 45,
                    },
                    grid: { stroke: 'none' },
                },
            },
        };
    
        return (
            <VictoryChart
                theme={chartTheme}
                domainPadding={{ '{{' }} x: 30 }}
                maxDomain={{ '{{' }} x: 5 }}
                height={245}
            >
                <VictoryBar
                    barWidth={6}
                    cornerRadius={{ '{{' }} topRight: 5 }}
                    style={styles.victorybar}
                    animate={{ '{{' }}
                        duration: 1000,
                        onLoad: { duration: 500 },
                    }}
                    data={data}
                    x='API'
                    y='Traffic'
                />
                <VictoryAxis
                    label='Api Name'
                    style={styles.victoryaxis}
                />
                <VictoryAxis
                    dependentAxis
                    label='Total Traffic'
                    style={styles.victoryaxis}
                />
            </VictoryChart>
        );
    }
    
    TrafficChart.propTypes = {
        data: PropTypes.instanceOf(Object).isRequired,
        themeName: PropTypes.string.isRequired,
    }; 
    ```

    !!! note
        `Victory JS` is a React JS library for modular charting and data visualization. You can find the required information about Victory JS in the official Victory JS](https://formidable.com/open-source/victory/) documentation. In order to create charts using `Victory JS` you need to install the `Victory JS` as a dependency to the widget. 
        
        Follow the steps mentioned below to install `Victory JS` as a dependency:

        1. Navigate to `<WIDGET_ROOT>` directory  and add `Victory JS` as a dependency to the `package.json` file.   
            ```
            "dependencies": {
                    "victory": "^31.0.2"
            },  
            ```
        2. Issue the following command to install the dependency.
            ```
            npm install
            ```
            
3. Modify the `APIMApiTrafficWidget.jsx` file as shown below to pass the Traffic data to the `TrafficChart.jsx` file.
   
     ```
     import TrafficChart from './TrafficChart';
    
     class APIMApiTrafficWidget extends Widget {
        
        render() {
        
            const { usageData } = this.state;
            
            return (
                <TrafficChart
                    data={usageData}
                />
            );
        }
     }
     ```
 
4. Build the newly created widget.
    
     This will permanently deploy the widget.

    ```
    npm run build
    ```

5. Add the newly created widget to the Analytics Dashboard by selecting it from the widget listings.

6. Refresh the dashboard to view the changes.

     The widget will appear on the dashboard.
