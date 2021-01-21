# Transforming Content Types
This section describes how you can transform the content type of a message using an API. In this scenario, the API exposes a REST back-end service that accepts and returns XML and JSON messages for HTTP methods as follows:
    
-  GET - Response is in JSON format.
-  POST - Accepts JSON request and returns response in XML format.
-  DELETE - Empty request body should is required. Returns response in XML format. 
    
## Synapse configuration
    
Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<api xmlns="http://ws.apache.org/ns/synapse" name="HealthcareService" context="/healthcare">
    <resource methods="POST" url-mapping="/appointment/reserve">
        <inSequence>
            <property name="REST_URL_POSTFIX" scope="axis2" action="remove"/>
            <send>
                <endpoint>
                    <address uri="http://localhost:9090/grandoaks/categories/surgery/reserve"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <log level="full"/>
            <property name="messageType" value="application/xml" scope="axis2"/>
            <send/>
        </outSequence>
    </resource>
    <resource methods="GET" uri-template="/appointments/{appointmentNo}">
        <inSequence>
            <send>
                <endpoint>
                    <address uri="http://localhost:9090/healthcare"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <log level="full"/>
            <property name="messageType" value="application/json" scope="axis2"/>
            <send/>
        </outSequence>
    </resource>
    <resource methods="DELETE" uri-template="/appointments/{appointmentNo}">
        <inSequence>
            <send>
                <endpoint>
                    <address uri="http://localhost:9090/healthcare"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <log level="full"/>
            <property name="messageType" value="application/xml" scope="axis2"/>
            <send/>
        </outSequence>
    </resource>
</api>
```
    
## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the rest api]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the back-end service:

1. Download the [Hospital-Service-2.0.0-JDK11.jar](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
2. Open a terminal, navigate to the location of the downloaded service, and run it using the following command:

    ```bash
    java -jar Hospital-Service-2.0.0-JDK11.jar
    ```

Sending an **HTTP POST request**:

1. Create the `request.json` file as follows:
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

2. Following is the cURL command to send an HTTP POST request to the API:

    !!! Tip
        The context of the API is ‘/healthcare’. For every HTTP method, a url-mapping or uri-template is defined, and the URL to call the methods differ with the defined mapping or template.
        
    ```bash
    curl -v -H "Content-Type: application/json" -X POST -d @request.json http://localhost:8290/healthcare/appointment/reserve
    ```

    The response from backend to the Micro Integrator will be:

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

    The Micro Integrator transform the response to XML and send it back to client as:

    ```xml
    <jsonObject>
       <appointmentNumber>1</appointmentNumber>
       <doctor>
          <name>thomas collins</name>
          <hospital>grand oak community hospital</hospital>
          <category>surgery</category>
          <availability>9.00 a.m - 11.00 a.m</availability>
          <fee>7000.0</fee>
       </doctor>
       <patient>
          <name>John Doe</name>
          <dob>1940-03-19</dob>
          <ssn>234-23-525</ssn>
          <address>California</address>
          <phone>8770586755</phone>
          <email>johndoe@gmail.com</email>
       </patient>
       <fee>7000.0</fee>
       <confirmed>false</confirmed>
       <appointmentDate>2025-04-02</appointmentDate>
    </jsonObject>
    ```

Sending an **HTTP GET request**:

1.  Following is the CURL command to send a **GET request** to the API:
    
    ```bash
    curl -v -X GET http://localhost:8290/healthcare/appointments/1
    ```
    
2.  The response for the request will be:
    
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

Sending an **HTTP DELETE request**:

1.  Following is the cURL command for sending an HTTP DELETE request:
  
    ```bash
    curl -v -X DELETE http://localhost:8290/healthcare/appointments/1
    ```
        
    This request will be sent to the back end, and the order with the specified ID will be deleted. The response to the Micro Integrator from backend will be as follows:

    ```json
    {"status":"Appointment is successfully removed"}
    ```

2.  The Micro Integrator transform the response to XML and sends it back to the client as follows:

    ```xml
    <jsonObject><status>Appointment is successfully removed</status></jsonObject>
    ```
