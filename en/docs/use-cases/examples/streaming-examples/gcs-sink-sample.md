# Publishing Events to a GCS Bucket

## Purpose

This example shows how to publish events to a GCS bucket via the siddhi-io-gcs sink extension. The Siddhi application receives events by consuming them from the `http://localhost:8006/inputStream` endpoint. These events are then sent to the `GCS` sink that aggregates and commits the events to a Google Cloud Storage bucket.

!!!info "Before you begin:"
    1. Create an account in [Google Cloud](https://cloud.google.com/).
    2. Download the credential file that is generated through the GCP console and save it in a directory of your choice. For more information, see [Google Cloud Authentication Documentation](https://cloud.google.com/docs/authentication/?hl=en_US&_ga=2.203156947.-316765357.1568779091).
    3. Save the sample Siddhi application in Streaming Integrator Tooling.


## Executing the Sample

To execute the sample, follow the steps below:

1. Enter values for the `credential.path` and the `bucket.name` parameters of the GCS Sink definition in the sample Siddhi application.

    !!!info
        You can either set the `credential.path` parameter in the sink configuration as shown below or can set a system variable with`GOOGLE_APPLICATION_CREDENTIALS` as the name with the path to the credential file.

2. Start the sample by clicking the **Start** button (shown below) or by clicking **Run** => **Run**.

    ![Start button]({{base_path}}/assets/img/streaming/amazon-s3-sink-sample/start.png)

    If the Siddhi application starts successfully, the following message appears in the console.

    `GCSSinkSample.siddhi - Started Successfully!`

## Testing the Sample

To test the sample Siddhi application, open a terminal and issue the following curl command

`curl -H "Content-Type: application/json" -d '{"event":{"key":"testFile","payload":"message", "test":"wjson"}}' http://localhost:8006/inputStream`

???info "Click here to view the sample Siddhi application."

    ```sql
    @App:name("GCSSinkSample")
    @App:description("Publish Events to a GCS bucket using a http-source")


    @Source(type = 'http',
            receiver.url='http://localhost:8006/inputStream', @map(type='json'))
    define stream inputStream(key string, payload string, suffix string);

    @sink(type='google-cloud-storage', credential.path='<credential.path>', bucket.name='<bucket.name>',
          object.name='test-object-{{suffix}}',
        @map(type='text'))
    define stream outputStream(key string, payload string, suffix string);

    from inputStream
    select *
    insert into outputStream;
    ```