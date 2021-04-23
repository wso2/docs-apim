# Scenario 1 - Create REST API from an OpenAPI Definition

## User Story

**Coltrain is one of the railway companies that is partnered up with GOGO Train to provide better service to their customers. Coltrain already has some internally managed APIs deployed in-house and these are managed by their internal development team. One of the APIs is train schedule retrieval API which is intended for the public community to get the Coltrain schedules. Currently, this API is exposed for the public and Coltrain development team faces challenges in maintaining and handling high load for the API . By exposing this API through WSO2 API Manager, Coltrain expects to get the full benefits of an API Management solution such as API lifecycle management, security, throttling, etc. and decouple the maintenance overhead from the internal teams.**

**_Time to Complete : 10 mins_**

WSO2 API manager provides capability to import OAS definitions and create the API using that. 
    ![Import OAS definition to API-M]({{base_path}}/assets/img/tutorials/scenarios/oas-def-import.png)
    
Let's first test the backend. You could do following curl command and you will get a response with schedule items.

```
curl "http://localhost:8082/train-operations/v1/schedules"

```
You will get the following response

```
[{"entryId":"1","startTime":"14:50","endTime":"19:59","from":"London","to":"Glasgow","trainType":"Standard"},{"entryId":"2","startTime":"14:30","endTime":"19:20","from":"London","to":"Edinburgh","trainType":"1st class"},{"entryId":"3","startTime":"11:10","endTime":"12:59","from":"London","to":"Cardiff","trainType":"Standard"},{"entryId":"4","startTime":"08:30","endTime":"10:50","from":"London","to":"Manchester","trainType":"1st class"}]

```

Backend is working fine. Let’s expose this API through WSO2 API Manager. 

1. Log in to https://localhost:9443/publisher/apis using Coltrain publisher user. Use user as _apiprovider@coltrain.com_ and password as _user123_
2. Select **Import Open API** option under **REST API** section
   
    ![Create API]({{base_path}}/assets/img/tutorials/scenarios/create-api-oas-def.png)


3. Select **OpenAPI File/Archive** radio button and import the **coltrain-public-openapi.yaml** definition from _resources_ location.

    ![Import Definition]({{base_path}}/assets/img/tutorials/scenarios/import-oas-def.png)

4. Add the context (say /coltrain) and create the API. Keep the endpoint as it is. You could click the tick in front of the endpoint to check the backend url status.

    ![Create API]({{base_path}}/assets/img/tutorials/scenarios/create-coltrain-public-api.png)

   
Since this API is intended to be accessed by public users, Coltrain api providers want to remove any authentication for this resource. This way anyone can access the service without any credentials. For that,  

1. Go to **Develop → API Configuration → Resources** tab
2. Expand a resource
3. Under the **Operation Governance** section, turn off the radio button for **Security**

    ![Change security]({{base_path}}/assets/img/tutorials/scenarios/resource-security.png)

4. Save the API.

Before Publishing the API, Coltrain developers want to test this API. For that WSO2 API Manager provides a Test console to test the API while it is in the development stage.

Before starting to test the API, you need to deploy the API in the gateway. For that, go to **Deploy → Deployment** section and select **Deploy** . This will deploy the API in the gateway but this won’t be visible to the outside world.

![Deploy API]({{base_path}}/assets/img/tutorials/scenarios/deploy-coltrain-public.png)

Now we are ready to test the API. For that, go to the **Test → Try Out** . This provides an API console in the Publisher ui to test the API.

![Try out]({{base_path}}/assets/img/tutorials/scenarios/tryout.png)

Expand the _/schedules_ resource and invoke the API. You won’t need to click **Generate Key** since we have removed the security for this resource. You will have to generate one if you want to test the _/schedules/{id}_ resource.

![Try out result]({{base_path}}/assets/img/tutorials/scenarios/tryout-result.png)

Now testing is done from the publisher end. The API needs to be published in-order to access it from the Developer portal. For that,

1. Go to **Portal Configurations → Subscriptions** and select one from **Business Plans**. You could select “Unlimited” and save.
2. Go to **Lifecycle** section and select **Publish**.

Now the API is published. To view this API go to https://localhost:9443/devportal/ Dev portal and select **Coltrain** tenant domain. This will redirect you to the Coltrain developer portal.

Select the **ColTrainScheduleCommunityAPI** and select the **Try-Out** button from the left menu. This will open up an in-built API console for this API. You could now try out the API by clicking the resources. 

![Developer Portal Tryout]({{base_path}}/assets/img/tutorials/scenarios/coltrain-public-dev.png)
