# Development of Developer Optimized APIs Sample

This sample scenario elaborates as to how you can use WSO2 API Manager to develop developer optimized APIs.

### Use case

-   Business APIs can be accessed by different parties via different devices. Therefore, providing an optimized and personalized experience for these different user stories is key to the success of digital transformation.

-   The same API can be accessed by different clients (e.g., mobile devices, PC, TV, etc.).

-   The API developer should be able to optimize API output by identifying the client.

-   Optimization can be a composition of the multiple backends or stripdown.

-   APIs are prioritized based on the client.

### Business Story

![](https://lh3.googleusercontent.com/sfvuk6rF0aXhNaVGawSUVyW6_GFus-H2uwueJMwHWeE2gKW9QUMU0p627M2TDED2KH8h174A-e6ZXhc8HNqYBEymnW99A9Rdeoq52LYioY1Zcu6C7eKLuKkR8OfnVU2b04H9ZcZ3AABVVimiow)

ABC Bank is providing financial facilities such as loans, fixed deposits, etc. Therefore, they have to provide the loan and fixed deposit rates. The bank also has an online facility for clients to log in and check their account information and perform transactions. In addition, ABC bank is also looking at developing a mobile banking solution.

### Implementing the scenario

The bank needs APIs in order to achieve the above mentioned sample business story.

1.  Expose the exchange rates.

2.  Provide the clients with their respective account information.

3.  Grant access to the online banking solution as well as the mobile banking solution.

In the future, ABC bank will need more and more functionality exposed through APIs. However, as for now, let’s consider only the above mentioned three APIs, and consider how we could achieve this using WSO2 API Manager.

The following sections explain how we can implement the latter mentioned use cases using WSO2 API Manager.

### Business APIs accessed by different parties via different devices

WSO2 API Manager provides an SDK feature that generates SDKs for a variety of programming languages. This particular feature will address the first part of the sample scenario, which is the requirement for the business APIs to be accessed by different parties via different devices, where different SDKs can address the needs of the different types of consumers involved.

![](https://lh3.googleusercontent.com/8oHiX6n-3JUVLVfGMuRe0A0LIaSvyzBoyoanKYkRD1tqvuY0PPw71bYJhhiqi9KVfH-79x4Rh56BoyZw_cDebrfcXdhOT9_oONzLtybaFBWST3bkFICh_uChJosVVV7F1HBwrkvFyJH74SIaZg)

The API consumers can create different clients using a preferred programming language. For an example, let’s consider two parties that need an application that consumes the APIs using Python and Java. They can develop two applications using the SDK’s for Python and Java separately. The SDK, which is automatically generated through WSO2 API Manager, will handle the API invocation logic; while, the application developer only needs to focus on the business logic of the client and call the method with the respective parameters in the SDK.

### Same API accessed by different clients

In WSO2 API Manager, clients can create separate applications for the same API and in turn use these different applications to access the API. In this example, different users can get the interest rates for bank loans and fixed deposits by subscribing to the applications, which provide the relevant APIs, that the bank has exposed to the public.

Furthermore, the client may be accessing this information via WSO2 API Manager using a mobile device. Therefore, in order to cater to the latter mentioned requirement ABC bank can develop the client application using the Android SDK, and similarly in order to create a client application using Java, they can use the Java SDK by calling the respective SDK methods.

![](https://lh4.googleusercontent.com/vg1W-nIII1cMKvfzT7Yiy_xphKI2cgq4KCmCKecFSAr4UQ3KmyldyitsgKaN5500q9vu2K2nAWC4VpeimibHAe9rYfzR7n9hDSUckhtJNVKMXPBzdi-JrOsTxcnSir4Gnky9T9XBogpYomMHwQ)

### API developer optimizing the API output by identifying the client

API developers can use the headers sent by the client to detect the type of the client (e.g., if the client is a mobile device or not). For example, consider a client who is accessing ABC bank's API’s and performing online account balance checking. In the latter mentioned scenario, if the API developer needs to allow mobile device clients to only access a selected set of data of their account details, and expose all the data to desktop application clients, this can be achieved when using WSO2 API Manager by having a custom sequence in the API definition. For more information on adding custom sequences, see [Adding Mediation Extensions]({{base_path}}/learn/api-gateway/message-mediation/adding-a-class-mediator).

**Example**

If the API developer needs to restrict sending the address element of the bank account details to the mobile device clients.

``` java
<xml>
    <name>Chris Smith</name>
    <address>No 4, Street One, San Francisco.</address>
    <mobile>0718123456</mobile>
</xml>
```

The API developer can add the following custom sequences to the API definition to achieve the latter mentioned scenario.

**In-sequence**

In the following custom IN-sequence, it reads the User-Agent header and stores it in a custom property in WSO2 API Manager.

``` java
<sequence xmlns="http://ws.apache.org/ns/synapse" name="custom-in">
    <description> Description</description>
    <property name="ClientAccessDevice" expression="$trp:User-Agent" />
</sequence>
```

**Out-sequence**

In the following custom OUT-sequence, a filter is introduced to read the latter mentioned custom property and send the custom payload to the backend as follows:

``` java
<sequence xmlns="http://ws.apache.org/ns/synapse" name="custom-out">
    <description>Custom out sequence to remove Address element</description>
    <filter source="get-property('ClientAccessDevice')" regex="iphone">
        <then>
        <log level="custom">
            <property name="ClientAccessDevice" value="then" />
        </log>
        <script language="js">
            var payload = mc.getPayloadXML();
            delete payload.address;
            mc.setPayloadXML(payload);
        </script>
        </then>
        <else>
        </else>
    </filter>
    <property name="Client user device" expression="$trp:User-Agent" />
</sequence>
```

Test the above APIs using the following cURL command.

#### Mobile Device Client

- **cURL**

``` java
    curl -X GET --header 'User-Agent: iphone' 'Accept: application/json' --header 'Authorization: Bearer <key>' 'https://10.100.5.168:8243/information/1.0.0/getCustomerInfo'
```

- **Output**

Output for the mobile devices is as follows

``` java
<xml>
    <name>Chris Smith</name>
    <mobile>0718123456</mobile>
</xml>
```

#### Desktop Device Client

- **cURL**

``` java
curl -X GET --header 'User-Agent: chrome 'Accept: application/json' --header 'Authorization: Bearer <key>' 'https://10.100.5.168:8243/information/1.0.0/getCustomerInfo'
```

- **Output**

Output for the desktop devices is as follows:

``` java
<xml>
    <name>Chris Smith</name>
    <address>No 4, Street One, San Francisco.</address>
    <mobile>0718123456</mobile>
</xml>
```

### Optimization can be a composition of multiple backends or stripdown

This is currently identified as a gap in the WSO2 API manager 2.2.0 implementation and a new feature addressing this via API composition is being developed in WSO2 Carbon 5.0 based release of the WSO2 API Manager.

### Client based prioritization of the APIs

This is currently identified as a gap in the WSO2 API Manager 2.2.0 implementation, and will be addressed in the new features that will be delivered in the WSO2 Carbon 5.0 based release of the WSO2 API Manager.
