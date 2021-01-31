# Using Failover Endpoints
## Example 1: Failover with one address endpoint

When message failure is not tolerable even though there is only one
service endpoint, then failovers are possible with a single endpoint as
shown in the below configuration.

### Synapse configuration

Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run-example-1) this example.

```xml
<api xmlns="http://ws.apache.org/ns/synapse" name="TestAPI" context="/test">
   <resource methods="GET">
      <inSequence>
         <call>
            <endpoint name="SampleFailover">
                <failover>
                    <endpoint name="Sample_First" statistics="enable" >
                        <address uri="http://localhost:123/myendpoint" statistics="enable" trace="disable">
                            <timeout>
                                <duration>60000</duration>
                            </timeout>
            
                            <markForSuspension>
                                <errorCodes>101504, 101505, 101500</errorCodes>
                                <retriesBeforeSuspension>3</retriesBeforeSuspension>
                                <retryDelay>10</retryDelay>
                            </markForSuspension>
            
                            <suspendOnFailure>
                                <initialDuration>1000</initialDuration>
                                <progressionFactor>2</progressionFactor>
                                <maximumDuration>64000</maximumDuration>
                            </suspendOnFailure>
            
                        </address>
                    </endpoint>
                </failover>
            </endpoint>
         </call>
        <respond/>
      </inSequence>
   </resource>
</api>
```

In the above example, the `         Sample_First        ` endpoint is
marked as `         Timeout        ` if a connection times out, closes,
or sends IO errors after retrying for `         60000        `
miliseconds.

When one of the errors of the specified codes occur (i.e.,
`         101504, 101505        ` and `         101500)        ` , the
failover will retry using the first non-suspended endpoint. In this
case, it is the same endpoint ( `         Sample_First        ` ). It
will retry until the retry count (i.e. 3 in the above example) becomes 0
with a delay as specified by the `         <retryDelay>        `
property (i.e., `         10        ` miliseconds in the above example).

For all the other errors, it will be marked as
`         Suspended        ` . For more information about these states
and properties, see [Endpoint Error Handling]({{base_path}}/integrate/examples/endpoint_examples/endpoint_error_handling).

!!! Info
    The retry count is per endpoint, not per message. The retry happens in parallel. Since messages come to this endpoint via many threads, the same message may not be retried three times. Another message may fail and can reduce the retry count.

    In this configuration, we assume that these errors are rare and if they happen once in a while, it is okay to retry again. If they happen frequently and continuously, it means that it requires immediate attention to get it back to normal state.

### Build and run (example 1)

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the REST API]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Send the following request to invoke the API:

```bash
curl -v -X GET "http://localhost:8290/test"
```

The following logs are printed if the endpoint is unreachable:

```xml
[2019-10-29 12:10:52,557]  WARN {API_LOGGER.TestAPI} - ERROR_CODE : 101503 ERROR_MESSAGE : Error connecting to the back end
[2019-10-29 12:10:52,558]  WARN {org.apache.synapse.endpoints.EndpointContext} - Endpoint : Sample_First with address http://localhost/myendpoint will be marked SUSPENDED as it failed
```

## Example 2: Failover with multiple address endpoints

When a message reaches a failover endpoint with multiple address
endpoints, it will go through its list of endpoints to pick the first
one in `         Active        ` or `         Timeout        ` state
(not in the `         Suspended        ` state). Then, it will send the
message using that particular endpoint.

If a failure occurs with the first endpoint within the failover group
and if this error does not put the first endpoint into
`         Suspended        ` state, the retry will happen using the same
endpoint.

However, if the first endpoint is suspended or if an error occurs while
sending the message with the first endpoint, the failover endpoint will
go through the endpoint list again from the beginning and will try to
send the requests using the next endpoint, which is in the
`         Active        ` or `         Timeout        ` state.
Neverthless, when the first endpoint becomes ready to send again, it
will try again on the first endpoint, even though the second endpoint is
still active. For more information about these states and properties,
see [Endpoint Error Handling]({{base_path}}/integrate/examples/endpoint_examples/endpoint_error_handling).

### Synapse configuration

Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run-example-2) this example.

Multiple address endpoints are used in this example.

```xml
<api xmlns="http://ws.apache.org/ns/synapse" name="TestAPI" context="/test">
   <resource methods="GET">
      <inSequence>
         <call>
            <endpoint>
                <failover>
                    <endpoint name="fooEP">
                        <http uri-template="http://localhost:8080/foo">
                            <timeout>
                                <duration>10000</duration>
                                <responseAction>fault</responseAction>
                            </timeout>
                            <suspendOnFailure>
                                <errorCodes>101503,101504,101505,101507</errorCodes>
                                <initialDuration>100</initialDuration>
                                <progressionFactor>1.0</progressionFactor>
                                <maximumDuration>30000</maximumDuration>
                            </suspendOnFailure>
                        </http>
                    </endpoint>
                    <endpoint name="barEP">
                        <http uri-template="http://localhost:8080/bar">
                            <timeout>
                                <duration>10000</duration>
                                <responseAction>fault</responseAction>
                            </timeout>
                            <suspendOnFailure>
                                <errorCodes>101503,101504,101505,101507</errorCodes>
                                <initialDuration>100</initialDuration>
                                <progressionFactor>1.0</progressionFactor>
                                <maximumDuration>30000</maximumDuration>
                            </suspendOnFailure>
                            <retryConfig>
                                <disabledErrorCodes>101507,101503</disabledErrorCodes>
                            </retryConfig>
                        </http>
                    </endpoint>
                </failover>
            </endpoint>
         </call>
        <respond/>
      </inSequence>
   </resource>
</api>

```

!!! Note
    The `<retryConfig>` property configures the last child endpoint to stop retying by ending the loop (i.e. to make the endpoint respond back to the service), after attempting to send requests to all the child endpoints and when all the attempts fail.
    ```xml
    <retryConfig>
            <disabledErrorCodes>101507,101504</disabledErrorCodes>
    </retryConfig>
    ```
    According to this configuration, the following error codes are used for sending the endpoint into `Timeout` state: `101504` and `101507`.

### Build and run (example 2)

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an ESB Solution project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project).
3. [Create the REST API]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-and-run) in your Micro Integrator.

Invoke the sample API by executing the following command:

```bash
curl -v -X GET "http://localhost:8290/test"
```

The following logs are getting printed if the endpoint is unreachable:

```xml
[2019-10-29 13:38:24,354]  WARN {API_LOGGER.TestAPI} - ERROR_CODE : 101503 ERROR_MESSAGE : Error connecting to the back end
[2019-10-29 13:38:24,354]  WARN {org.apache.synapse.endpoints.EndpointContext} - Endpoint : fooEP with address http://localhost:8080/foo will be marked SUSPENDED as it failed
[2019-10-29 13:38:24,354]  WARN {org.apache.synapse.endpoints.EndpointContext} - Suspending endpoint : fooEP with address http://localhost:8080/foo - current suspend duration is : 100ms - Next retry after : Tue Oct 29 13:38:24 IST 2019
[2019-10-29 13:38:24,355]  WARN {org.apache.synapse.endpoints.FailoverEndpoint} - AnonymousEndpoint Detect a Failure in a child endpoint : Endpoint [fooEP]
[2019-10-29 13:38:24,356]  WARN {org.apache.synapse.transport.passthru.ConnectCallback} - Connection refused or failed for : localhost/127.0.0.1:8080
[2019-10-29 13:38:24,357]  WARN {API_LOGGER.TestAPI} - ERROR_CODE : 101503 ERROR_MESSAGE : Error connecting to the back end
[2019-10-29 13:38:24,357]  WARN {org.apache.synapse.endpoints.EndpointContext} - Endpoint : barEP with address http://localhost:8080/bar will be marked SUSPENDED as it failed
[2019-10-29 13:38:24,357]  WARN {org.apache.synapse.endpoints.EndpointContext} - Suspending endpoint : barEP with address http://localhost:8080/bar - current suspend duration is : 100ms - Next retry after : Tue Oct 29 13:38:24 IST 2019
```