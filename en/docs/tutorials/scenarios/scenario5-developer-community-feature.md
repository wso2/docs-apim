# Scenario 5 - Getting the Developer Community Involved

This is a tutorial that is part of a series and can be used as a standalone tutorial on how to involve the developer community. For more details on the scenario and general prerequisites, please see [the scenario overview page]({{base_path}}/tutorials/scenarios/scenario-overview).

**_Time to Complete : 4 mins_**

## User Story

Quantis allows random users to access their APIs. Since they have now enabled the Developer Portal for external users to register to their system, they now expect the developer community to interact with them on building their own applications using their services. Quantis wants to provide a place where application developers can communicate with the Quantis API developers with their API related queries. This way application developers and external users can understand more about Quantis APIs and they could have a better developer experience.

WSO2 API Manager Developer Portal provides many features to assist developers to use the APIs published. For example:

- SDK generation for APIs
- Documentation for APIs
- Ratings and Comments
- API console to try out the API

## Step 1: Set up and try out developer community features

This demo setup contains a sample API to demonstrate these features. Log in to the Quantis Developer Portal using Quantis user `sindy@quantis.com` with the password `user123` and check the **QuantisTrainAPI**.

![Community features]({{base_path}}/assets/img/tutorials/scenarios/dev-portal-community.png)

You could generate client side SDKs for different programming languages. You could find more information on this in our [official documentation]({{base_path}}/consume/generating-sdks/write-a-client-application-using-the-sdk/).  We have provided a sample Java program created using the Java SDK downloaded from the **QuantisTrainAPI**.

1. Subscribe to the **QuantisTrainAPI** using an application and generate an access token.
2. Go to the `/resources` location and invoke the API using the `sdk-demo-1.0.0.jar` with the access token

```
java -jar sdk-demo-1.0.0.jar <access_token>

```

![SDK response]({{base_path}}/assets/img/tutorials/scenarios/sdk-response.png)

!!! Info
    **Sdk-demo-1.0.0.jar** is built using the Java SDK downloaded from the Developer Portal. You could check the source code for this program in the `/resources/sdk-demo` location

    When you download the SDK from Developer Portal (e.g., Java SDK), you have the ability to build it and use it as a dependency for your project. In this demo, the Java SDK for **QuantisTrainAPI** (QuantisTrainAPI_1.0.0_java.zip) was used and built using Apache Maven.

    Then you could add the following dependency to your project to import the SDK. 

    ```xml
    <dependency>
      <groupId>org.wso2</groupId>
      <artifactId>org.wso2.client.QuantisTrainAPI</artifactId>
      <version>1.0.0</version>
    </dependency>

    ```
    Sample code on invoking the API using this SDK can be found in `resources/sdk-demo/src/main/java/org/wso2/carbon/apimgt/tutorial/App.java`.

## What's next

Try out the next scenario in the series, [Integrating with Data Sources]({{base_path}}/tutorials/scenarios/scenario6-integrating-with-data-sources).