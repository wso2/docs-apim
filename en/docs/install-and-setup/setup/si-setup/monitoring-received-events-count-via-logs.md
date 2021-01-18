# Monitoring the Received Events Count via Logs

You can monitor the total number of events received by the WSO2 Streaming Integrator via its sources per given time interval. This is done by configuring WSO2 Streaming Integrator to log the received event count for a specified time interval. The purpose of this log is to estimate the events received by the server during the time it is active. The event counter is reset each time the Streaming Integrator server is restarted.

To configure WSO2 Streaming Integrator to log the total received events count, follow the steps below:

1. Open the `<SI_HOME>/conf/server/deployment.yaml` file.

2. Add a parameter named `enableLoggingEventCount` and set it to `true` as shown below:

    `enableLoggingEventCount: true`
    
    !!! info
        This is set to `false` by default.
        
3. Add another parameter named `loggingDuration` and give the time interval (in minutes) for which you want the total received event count to be logged. e.g., If you want the total received event count to be logged every minute, you can set the parameter as follows:

    `loggingDuration: 1`
    
    If you do not specify the logging duration, the received event count is logged every one minute by default.
    
4. Save the change. The configuration is as follows:

    ```
     enableLoggingEventCount: true
     loggingDuration: 1
    ```
   
5. Restart WSO2 Streaming Integrator for the change to be effective.

    The total received event count is logged as shown in the example below:
    
    ```text
    [2020-06-10 16:11:21,875]  INFO {io.siddhi.core.util.statistics.RecievedEventCounter} - Event received for Stream SweetProductionStream in siddhi App ReceiveHTTPinXMLFormatWithCustomMapping for last 1 minute(s): 60 .Total Events: 3636.
    ```
