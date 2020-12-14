# Processing Geo Data

## Purpose:
This application demonstrates how to retrieve the longitude and latitude based on location details provided.

!!!info "Before you begin:"
    Save the sample Siddhi application in Streaming Integrator Tooling.

## Executing the Sample

To execute the sample open the saved Siddhi application in Streaming Integrator Tooling, and start it by clicking the **Start** button (shown below) or by clicking **Run** => **Run**.

![Start button]({{base_path}}/assets/img/streaming/amazon-s3-sink-sample/start.png)

If the Siddhi application starts successfully, the following message appears in the console.

`execution-geo-sample.siddhi - Started Successfully!`

## Testing the Sample

To test the sample Siddhi application, simulate single events for it via the Streaming Integrator Tooling as follows:

1. To open the Event Simulator, click the **Event Simulator** icon.

    ![Event Simulator Icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/event-simulation-icon.png)

    This opens the event simulation panel.

2. To simulate events for the `geocodeStream` stream of the `execution-geo-sample`  Siddhi application, enter information in the **Single Simulation** tab of the event simulation panel as follows.

    ![Select Siddhi Application and Stream]({{base_path}}/assets/img/streaming/execution-geo-sample/siddhi-app-and-stream.png)

    | **Field**                   | **Value**                              |
    |-----------------------------|----------------------------------------|
    | **Siddhi App Name**         | `execution-geo-sample`                 |
    | **StreamName**              | `geocodeStream`                        |

    As a result, attributes specific to the `geocodeStream` are displayed as marked in the above image.

3. Enter attribute values as follows.

    ![Attribute Values]({{base_path}}/assets/img/streaming/execution-geo-sample/attribute-values.png).

    | **Attribute**         | **Value**                     |
    |-----------------------|-------------------------------|
    | **location**          | `5 Avenue Anatole France`     |
    | **level**             | `75007 Paris`                 |
    | **time**              | `France`                      |

4. Click **Start and Send**.


## Viewing the Results

The prediction for the location you provided via the event you simulated is displayed as follows in the Streaming Integrator Tooling console.

`INFO {io.siddhi.core.query.processor.stream.LogStreamProcessor} - sentimentExtensionSample: Event :, StreamEvent{ timestamp=1513623526790, beforeWindowData=null, onAfterWindowData=null, outputData=[48.8583698, 2.2944833, Tour Eiffel, 5 Avenue Anatole France, 75007 Paris, France], type=CURRENT, next=null}`

???info "Click here to view the sample Siddhi application."

    ```sql
    @App:name("execution-geo-sample")
    @App:description('Use geo data related functionality to retrieve the longitude and latitude for the provided location details.')

    -- Please refer to https://docs.wso2.com/display/SP400/Quick+Start+Guide on getting started with streaming-integrator-tooling.

    define stream geocodeStream (location string, level string, time string);

    @sink(type='log')
    define stream dataOut(latitude double, longitude double, formattedAddress string);

    @info(name = 'query')
    from geocodeStream#geo:geocode(location)
    select latitude, longitude, formattedAddress
    insert into dataOut;
    ```