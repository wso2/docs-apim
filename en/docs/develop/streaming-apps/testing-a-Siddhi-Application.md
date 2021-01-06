# Testing Siddhi Applications

The Streaming Integrator allows the following tasks to be carried
out to ensure that the Siddhi applications you create and deploy are
validated before they are run in an actual production environment.

-   Validate Siddhi applications that are written in the Streaming Integrator Tooling.

-   Run Siddhi applications that were written in the Streaming Integrator Tooling.

-   Simulate events to test the Siddhi applications and analyze events
    that are received and sent. This allows you to analyze the status of
    each query within a Siddhi application at different execution
    points.

## Validating a Siddhi application

To validate a Siddhi application, follow the procedure below:

1.  Start and access the Streaming Integrator Tooling. For detailed
    instructions, see [Starting Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview#starting-streaming-integration-studio).

2.  In this example, let's use an existing sample as an example. Click
    on the **ReceiveAndCount** sample to open it.

3.  Sample opens in a new tab. This sample does not have errors, and
    therefore, no errors are displayed in the editor. To create an error
    for demonstration purposes, change the `count()` function in the `query1` query to
    `countNew()` as shown below.

    ```sql
    @info(name='query1') 
    from SweetProductionStream 
    select countNew() as totalCount 
    insert into TotalCountStream;      `
    ```

    Now, the editor indicates that there is a syntax error. If you move
    the cursor over the error icon, it indicates that
    `countNew` is an invalid function name as shown
    below.  
    ![Source View indicates a syntax error]({{base_path}}/assets/img/streaming/testing-siddhi-applications/syntax-error-indicated.png)

## Running a Siddhi application

You can run a Siddhi application to verify whether the logic
you have written is correct. To start a Siddhi application, follow the procedure below:

1.  Start and access the Streaming Integrator Tooling. For detailed
    instructions, see [Starting Stream Integration Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview#starting-streaming-integration-studio).
    
2.  For this example, click the **existing** sample **ReceiveAndCount**. It opens in a new untitled tab.

3.  Save the Siddhi file so that you can run it. To save it, click **File** -> **Save**. Once the file is saved,
    you can see the **Run** -> **Run** menu option enabled as shown
    below.

    ![Run and Debug options enabled]({{base_path}}/assets/img/streaming/testing-siddhi-applications/enable-run-debug.png)

    To start the application, click the **Run** menu option. This logs the following output in the console.

    ![Run log]({{base_path}}/assets/img/streaming/testing-siddhi-applications/run-log.png)

5.  To create an error for demonstration purposes, change the `count()` function in the
    `query1` query to `countNew()`, and save. Then click **Run** -> **Run**. As a result, the
    following output is logged in the console.

    ![Siddhi application in a faulty state]({{base_path}}/assets/img/streaming/testing-siddhi-applications/faulty-siddhi-application-message.png)

<a name="simulate"></a>
## Simulating events

This section demonstrates how to test a Siddhi application via event simulation. Event simulation involves simulating 
predefined event streams. These event stream definitions have stream attributes. You can use event simulator to create 
events by assigning values to the defined stream attributes and send them as events. This is useful for testing Siddhi 
applications in order to evaluate whether they function as expected


Events can be simulated in the following methods:

- [Simulating a single event](#simulating-a-single-event)
- [Simulating multiple events via CSV files](#simulating-multiple-events-via-csv-files)
- [Simulating multiple events via databases](#simulating-multiple-events-via-databases)
- [Generating random events](#generating-random-events)

!!! tip
    Before you simulate events for a Siddhi application, you need to run it. Therefore, before you try this section, see
    [Running a Siddhi application](#running-a-siddhi-application).

### Simulating a single event

This section demonstrates how to simulate a single event to be processed
via the Streaming Integrator.

!!! tip
    Before simulating events, a Siddhi application should be deployed.
    
To simulate a single event, follow the steps given below.

1.  Access the Streaming Integrator Tooling via the `http://localhost:/editor`
    URL. The Streaming Integrator Tooling opens as shown below.
    
    !!! info
        The default URL is`http://localhost:9090/editor`.

    ![Welcome Page]({{base_path}}/assets/img/streaming/creating-siddhi-applications/welcome-page.png)

2.  Click the **Event Simulator** icon in the left pane of the editor to
    open the **Single Simulation** panel.

    ![Event Simulation icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/event-simulation-icon.png)

    It opens the left panel for event simulation as follows.

    ![Event Simulation Panel]({{base_path}}/assets/img/streaming/testing-siddhi-applications/event-simulation-panel.png)

3.  Enter Information in the **Single Simulation** panel as described
     below.

    1.  In the **Siddhi App Name** field, select a currently deployed Siddhi application.

    2.  In the **Stream Name** field, select the event stream for which you want to simulate events. The list displays all the event streams defined in the selected Siddhi application.

    3.  If you want to simulate the event for a specific time different to the current time, enter a valid timestamp in the **Timestamp** field. To select a timestamp, click the time and calendar icon next to the **Timestamp** field.

        ![Time and Calendar icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/time-and-calendar.png) <br/>

        Then select the required date, hour, minute, second and millisecond. Click **Done** to select the time stamp entered. If you want to select the current time, you can click **Now**.

    4.  Enter values for the attributes of the selected stream.

4.  Click **Send** to start sending the event. The simulated event is logged similar to the sample log given below.

    ![Output Log]({{base_path}}/assets/img/streaming/testing-siddhi-applications/output-log.png)


### Simulating multiple events via CSV files
This section explains how to generate multiple events via CSV files to
be analyzed via the Streaming Integrator.

!!! tip
    Before simulating events, a Siddhi application should be deployed.
    
To simulate multiple events from a CSV file, follow the steps given
below.

1. Access the Streaming Integrator Tooling via the `http://localhost:/editor`
   URL. The Streaming Integrator Tooling opens as shown below.
   
    !!! info
        The default URL is`http://localhost:9090/editor`.

    ![Welcome Page]({{base_path}}/assets/img/streaming/creating-siddhi-applications/welcome-page.png)

2.  Click the **Event Simulator** icon in the left pane of the editor.

    ![Event Simulator Icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/event-simulation_Icon.png)

3.  In the event simulation left panel that opens, click on the **Feed Simulation** tab.

    ![Feed Simulation tab]({{base_path}}/assets/img/streaming/testing-siddhi-applications/feed-simulation-tab.png)  
      
4.  To create a new simulation, click **Create** . This opens the
    following panel.

    ![New feed simulatioin]({{base_path}}/assets/img/streaming/testing-siddhi-applications/feed-simulation.png)

5.  Enter values for the displayed fields as follows.

    1.  In the **Simulation Name** field, enter a name for the event simulation.

    2.  In the **Description** field, enter a description for the event simulation.

    3.  If you want to receive events only during a specific time interval, enter that time interval in the **Time Interval** field.

    4.  Click **Advanced Configurations** if you want to enter detailed specifications to filter events from the CSV file. Then enter information as follows.

        1.  If you want to include only events that belong to a specific time interval in the simulation feed, enter the start time and the end time  in the **Starting Event's Timestamp** and **Ending Event's Timestamp** fields respectively. To select a timestamp, click the time and calendar icon next to the field.

            ![Time and calendar icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/time-and-calendar.png)

            Then select the required date, hour, minute, second and millisecond. Click **Done** to select the time stamp entered. If you want to select the current time, you can click **Now**.

        2.  If you want to restrict the event simulation feed to a specific number of events, enter the required number in the **No of Events** field.

    5.  In the **Simulation Source** field, select **CSV File**.

    6.  Click **Add Simulation Source** to open the following section.

        ![Simulation Source]({{base_path}}/assets/img/streaming/testing-siddhi-applications/simulation-source.png)

        In the **Siddhi App Name** field, select the required Siddhi
        application. Then more fields as shown below.

        ![Feed simulation details]({{base_path}}/assets/img/streaming/testing-siddhi-applications/feed-simulation-details.png)

        Enter details as follows:

        1.  In the **Stream Name** field, select the stream for which you want to simulate events. All the streams defined in the Siddhi application you selected are available in the list.

        2.  In the **CSV File** field, select an available CSV file. If no CSV files are currently uploaded, select **Upload File** from the list. This opens the **Upload File** dialog box.

            ![Uploading the CSV file]({{base_path}}/assets/img/streaming/testing-siddhi-applications/upload-csv.png)

            Click **Choose File** and browse for the CSV file you want to upload. Then click **Upload**.

        3.  In the **Delimiter** field, enter the character you want to use in order to separate the attribute values in each row of the CSV file.

        4.  If you want to enter more detailed specifications, click **Advanced Configuration**. Then enter details as follows.

            1.  To use the index value as the event timestamp, select the **Timestamp Index** option. Then enter the relevant index.

            2.  If you want to increase the value of the timestamp for each new event, select the **Increment event time by(ms)** option. Then enter the number of milliseconds by which you want to increase the timestamp of each event.

            3.  If you want the events to arrive in order based on the timestamp, select **Yes** under the **Timestamp Interval** option.

        5.  Click **Save** to save the information relating to the CSV file. The name os the CSV file appears in the **Feed Simulation** tab in the left panel.

6.  To simulate a CSV file that is uploaded and visible in the **Feed Simulation** tab in the left panel, click on the arrow to its right. The simulated events are logged in the output console.

### Simulating multiple events via databases

This section explains how to generate multiple events via databases to be analyzed via the Streaming Integrator.

!!! tip
    Before simulating events via databases:<br/>
    -   A Siddhi application must be created.<br/>
    -   The database from which you want to simulate events must be already configured for the Streaming Integrator.
    
To simulate multiple events from a database, follow the procedure below:

1. Access the Streaming Integrator Tooling via the `http://localhost:/editor` URL. The Streaming Integrator Tooling opens as shown below.
   
    !!! info
        The default URL is`http://localhost:9090/editor`.

    ![Welcome Page]({{base_path}}/assets/img/streaming/creating-siddhi-applications/welcome-page.png)
     
2.  Click the **Event Simulator** icon in the left pane of the editor.

    ![Event Simulator Icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/event-simulation_Icon.png)

3.  Click the **Feed** tab to open the **Feed Simulation** panel.

    ![Feed Simulation tab]({{base_path}}/assets/img/streaming/testing-siddhi-applications/feed-simulation.png)

4.  To create a new simulation, click **Create**. This opens the following panel.

    ![New Simulation]({{base_path}}/assets/img/streaming/testing-siddhi-applications/database-simulation.png)

5.  Enter values for the displayed fields as follows.

    1.  In the **Simulation Name** field, enter a name for the event simulation.

    2.  In the **Description** field, enter a description for the event simulation.

    3.  If you want to simulate events at time intervals of a specific length, enter that length in milliseconds in the **Time Interval(ms)** field.

    4.  If you want to enter more advanced conditions to simulate the events, click **Advanced Configurations**. As a result, the following section is displayed.

        ![Advanced onfigurations]({{base_path}}/assets/img/streaming/testing-siddhi-applications/feed-simulation-database-advanced.png)

        Then enter details as follows:

        1.  If you want to include only events that belong to a specific time interval in the simulation feed, enter the start time and the end time  in the **Starting Event's Timestamp** and **Ending Event's Timestamp** fields respectively. To select a timestamp, click the time and calendar icon next to the field.

            ![Time and Calendar icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/time-and-calendar.png)

            Then select the required date, hour, minute, second and millisecond. Click **Done** to select the time stamp entered. If you want to select the current time, you can click **Now**.

        2.  If you want to restrict the event simulation feed to a specific number of events, enter the required number in the **No of Events** field.

    5.  In the **Simulation Source** field, select **Database**. To connect to a new database, click **Add Simulation Source** to open the following section.

        ![Configuring the database]({{base_path}}/assets/img/streaming/testing-siddhi-applications/configure-database-for-simulation.png)

        Enter information as follows:

        | Field               | Description                                                                                                                                                 |
        |---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | **Siddhi App Name** | Select the Siddhi Application in which the event stream for which you want to simulate events is defined.                                                   |
        | **Stream Name**     | Select the event stream for which you want to simulate events. All the streams defined in the Siddhi Application you selected are available to be selected. |
        | **Data Source**     | The JDBC URL to be used to access the required database.                                                                                                    |
        | **Driver Class**    | The driver class name of the selected database.                                                                                                             |
        | **Username**        | The username that must be used to access the database.                                                                                                      |
        | **Password**        | The password that must be used to access the database.                                                                                                      |

    6.  Once you have entered the above information, click **Connect to Database**. If the datasource is correctly configured, the following is displayed to indicate that Streaming Integrator can successfully connect to the database.

        ![Successfully connected to database]({{base_path}}/assets/img/streaming/testing-siddhi-applications/successfully-connected-message.png)

    7.  To use the index value as the event timestamp, select the **Timestamp Index** option. Then enter the relevant index. If you want the vents in the CSV file to be sorted based on the timestamp, select the **Yes** option under **CSV File is Ordered by Timestamp**.

    8.  To increase the timestamp of the published events, select the **Timestamp Interval** option. Then enter the number of milliseconds by which you want to increase the timestamp of each event.

6.  Click **Save**. This adds the fed simulation you created as an active simulation in the **Feed Simulation** tab of the left panel as shown below.

    ![Feed simulation added]({{base_path}}/assets/img/streaming/testing-siddhi-applications/created-feed-simulation.png)

7.  Click on the play button of this simulation to open the **Start the Siddhi Application** dialog box.

    ![Start the Siddhi Application dialog box]({{base_path}}/assets/img/streaming/testing-siddhi-applications/start-siddhi-application.png)

8.  Click **Start Simulation**. A message appears to inform you that the feed simulation started successfully. Similarly, when the simulation is completed, a message appears to inform you that the event simulation has finished.
 


### Generating random events

This section explains how to generate random data to be analyzed via the Streaming Integrator.

!!! tip
    Before simulating events, a Siddhi application should be deployed.
    
To simulate random events, follow the steps given below:

1. Access the Streaming Integrator Tooling via the `http://localhost:/editor`
   URL. The Streaming Integrator Tooling opens as shown below.
   
    !!! info
        The default URL is`http://localhost:9090/editor`.

    ![Welcome Page]({{base_path}}/assets/img/streaming/creating-siddhi-applications/welcome-page.png)

2.  Click the **Event Simulator** icon in the left pane of the editor.

    ![Event Simulator Icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/event-simulation-icon.png)

3. Click the **Feed** tab to open the **Feed Simulation** panel.

    ![Feed Simulation]({{base_path}}/assets/img/streaming/testing-siddhi-applications/feed-simulation-panel.png)

4.  To create a new simulation, click **Create** . This opens the following panel.

    ![Create feed simulation]({{base_path}}/assets/img/streaming/testing-siddhi-applications/wso2-feed-simulation.png)

5.  Enter values for the displayed fields as follows.

    1.  In the **Simulation Name** field, enter a name for the event simulation.

    2.  In the **Description** field, enter a description for the event simulation.

    3.  If you want to include only events that belong to a specific time interval in the simulation feed, enter the start time and the end time  in the **Starting Event's Timestamp** and **Ending Event's Timestamp** fields respectively. To select a timestamp, click the time and calendar icon next to the field.

        ![Time and Calendar icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/time-and-calendar.png)

        Then select the required date, hour, minute, second and millisecond. Click **Done** to select the time stamp entered. If you want to select the current time, you can click **Now**.

    4.  If you want to restrict the event simulation feed to a specific number of events, enter the required number in the **No of Events** field.

    5.  If you want to receive events only during a specific time interval, enter that time interval in the **Time Interval** field.

    6.  In the **Simulation Source** field, select **Random**.

    7.  If the random simulation source from which you want to simulate events does not already exist in the **Feed Simulation** pane, click **Add New** to open the following section.

        ![Random Simulation Source]({{base_path}}/assets/img/streaming/testing-siddhi-applications/random-simulation-source.png)

    8.  Enter information relating to the random source as follows:

        1.  In the **Siddhi App Name** field, s elect the name of the
            Siddhi App with the event stream for which the events are
            simulated.
        2.  In the **Stream Name** field, select the event stream for
            which you want to simulate events. All the streams defined
            in the Siddhi Application you selected are available to be
            selected.
        3.  In the **Timestamp Interval** field, enter the number of
            milliseconds by which you want to increase the timestamp of
            each event.
        4.  To enter values for the stream attributes, follow
            the instructions below.
            -   To enter a custom value for a stream attribute, select
                **Custom data based** from the list. When you select
                this value, data field in which the required value can
                be entered appears as shown in the example below.  
                ![Custom data based simulation]({{base_path}}/assets/img/streaming/testing-siddhi-applications/custom-data-based.png)

            -   To enter a primitive based value, select **Primitive
                based** from the list. The information to be entered
                varies depending on the data type of the attribute. The
                following table explains the information you need to
                enter when you select **Primitive based** for each data
                type.  

                <table>
                <thead>
                <tr class="header">
                <th>Data Type</th>
                <th>Values to enter</th>
                </tr>
                </thead>
                <tbody>
                <tr class="odd">
                <td><code>                     STRING                    </code></td>
                <td>Specify a length in the <strong>Length</strong> field that appears. This results in a value of the specified length being auto-generated.</td>
                </tr>
                <tr class="even">
                <td><code>                     FLOAT                    </code> or <code>                     DOUBLE                    </code></td>
                <td>The value generated for the attribute is based on the following values specified.
                <ul>
                <li><strong>Min</strong> : The minimum value.</li>
                <li><strong>Max</strong> : The maximum value.</li>
                <li><strong>Precision</strong> : The precise value. The number of decimals included in the auto-generated values are the same as that of the value specified here.</li>
                </ul></td>
                </tr>
                <tr class="odd">
                <td><code>                     INT                    </code> or <code>                     LONG                    </code></td>
                <td>The value generated for the attribute is based on the following values specified.
                <ul>
                <li><strong>Min</strong> : The minimum value.</li>
                <li><strong>Max</strong> : The maximum value.</li>
                </ul></td>
                </tr>
                <tr class="even">
                <td><code>                     BOOL                    </code></td>
                <td>No further information is required because <code>                     true                    </code> and <code>                     false                    </code> values are randomly generated.</td>
                </tr>
                </tbody>
                </table>

            -   To randomly assign values based on a pre-defined set of meaningful values, select **Property based** from the list. When you select this value, a field in which the set of available values are listed appears as shown in the example below.

                ![Property-based simulation]({{base_path}}/assets/img/streaming/testing-siddhi-applications/property-based.png)

            -   To assign a regex value, select **Regex based** from the list.

6.  Click **Save** to save the simulation information. The saved random simulation appears in the **Feed** tab of the left panel.

7.  To simulate events, click the arrow to the right of the saved simulation (shown in the example below).

    ![Simulating random events]({{base_path}}/assets/img/streaming/testing-siddhi-applications/simulate-events.png)

    The simulated events are logged in the CLI as shown in the extract
    below.

    ![Random Events Output Log]({{base_path}}/assets/img/streaming/testing-siddhi-applications/random-events-output-log.png)  