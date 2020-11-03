# Using GET with a Message Body
Typically, a GET request does not contain a body, and the Micro Integrator does not support these types of requests. When it receives a GET request that contains a body, it drops the message body as it sends the message to the endpoint. 

## Synapse configuration

Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<api xmlns="http://ws.apache.org/ns/synapse" name="HealthcareService" context="/healthcare">
  <resource methods="GET POST" url-mapping="/appointment/reserve">
     <inSequence>
        <property name="REST_URL_POSTFIX" scope="axis2" action="remove"/>
        <send>
            <endpoint>
                <address uri="http://localhost:9090/healthcare/surgery"/>
            </endpoint>
        </send>
     </inSequence>
     <outSequence>
        <send/>
     </outSequence>
  </resource>
</api>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio](../../../../develop/installing-WSO2-Integration-Studio).
2. [Create an integration project](../../../../develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the rest api](../../../../develop/creating-artifacts/creating-an-api) with the configurations given above.
4. [Deploy the artifacts](../../../../develop/deploy-artifacts) in your Micro Integrator.

Set up the back-end service:

1. Download the [Hospital-Service-2.0.0-JDK11.jar](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
2. Open a terminal, navigate to the location of the downloaded service, and run it using the following command:

    ```bash
    java -jar Hospital-Service-2.0.0-JDK11.jar
    ```

Send an invalid request to the back end as follows:
    
```bash
curl -v -H "Content-Type: application/json" -d @request.json http://localhost:8290/healthcare/appointment/reserve -X GET
```

The `request.json` file has the following content on the appointment:
    
```json
[ 
   { 
      "name":"thomas collins",
      "hospital":"grand oak community hospital",
      "category":"surgery",
      "availability":"9.00 a.m - 11.00 a.m",
      "fee":7000.0
   },
   { 
      "name":"anne clement",
      "hospital":"clemency medical center",
      "category":"surgery",
      "availability":"8.00 a.m - 10.00 a.m",
      "fee":12000.0
   },
   { 
      "name":"seth mears",
      "hospital":"pine valley community hospital",
      "category":"surgery",
      "availability":"3.00 p.m - 5.00 p.m",
      "fee":8000.0
   }
]
```

The additional parameter `-X` replaces the original POST method with the specified method, which in this case is GET. This will cause the client to send a GET request with a message similar to a POST request. If you view the output in tcpmon, you will see that there is no message body in the request.