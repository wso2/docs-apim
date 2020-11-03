# Using POST with No Body
Typically, POST is used to send a message that has data enclosed as a payload inside an HTML body. However, you can also use POST without a payload. WSO2 Micro Integrator considers such messages as normal messages and forwards them to the endpoint without any additional configurations.

In this example, a REST client communicates with a REST service using the Micro Integrator. Apache Tcpmon is used solely for monitoring the communication between the Micro Integrator and the back-end service and has no impact on the messages passed between the Micro Integrator and back-end service.

## Synapse configuration 

Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml      
<api xmlns="http://ws.apache.org/ns/synapse" name="HealthcareService" context="/healthcare">
  <resource methods="POST" url-mapping="/appointment/reserve">
     <inSequence>
        <property name="REST_URL_POSTFIX" scope="axis2" action="remove"/>
        <send>
            <endpoint>
                <address uri="http://localhost:8292/grandoaks/categories/surgery/reserve"/>
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

3. Start tcpmon and configure it to listen to port 8292 of your local machine. It is also important to set the target host name and port as required. In this case, the target port needs to be set to 9090 (i.e. the port where the back-end service is running). We will now test the connection by sending a POST message that includes a payload inside an HTML body.

Invoke the REST API:

1.  Create the `request.json` file with the following details:
        
    ```json
    {
        "patient": {
        "name": "John Doe",
        "dob": "1940-03-19",
        "ssn": "234-23-525",
        "address": "California",
        "phone": "8770586755",
        "email": "johndoe@gmail.com"
        },
        "doctor": "thomas collins",
        "hospital": "grand oak community hospital",
        "appointment_date": "2025-04-02"
    }
    ```

2.  Open a terminal and issue the following command: 
    
    ```bash
    curl -v -H "Content-Type: application/json" -d @request.json http://localhost:8290/healthcare/appointment/reserve -X POST
    ```

    You will receive the following response:

    ```json
    {
       "appointmentNumber": 1,
       "doctor": {
          "name": "thomas collins",
          "hospital": "grand oak community hospital",
          "category": "surgery",
          "availability": "9.00 a.m - 11.00 a.m",
          "fee": 7000
       },
       "patient": {
          "name": "John Doe",
          "dob": "1940-03-19",
          "ssn": "234-23-525",
          "address": "California",
          "phone": "8770586755",
          "email": "johndoe@gmail.com"
       },
       "fee": 7000,
       "confirmed": false,
       "appointmentDate": "2025-04-02"
    }
    ```

3.  Now, send the same POST message but without the enclosed data as follows: 

    ```bash
    curl -v -H "Content-Type: application/json" -d '' http://localhost:8290/healthcare/appointment/reserve -X POST
    ```

    !!! Note
        You would need to configure the backend service to handle such requests, if not the Micro Integrator will throw exceptions.

The tcpmon output shows the same REST request that was sent by the client. This shows that the Micro Integrator handled the POST message regardless of whether it included a payload.