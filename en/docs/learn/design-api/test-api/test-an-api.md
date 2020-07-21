# Test APIs through the publisher test console

**Testing APIs** is trying out the APIs at the publisher itself and make sure whether the functionalities and behaviours are  met before publishing to the gateway for accessibility of the subscribers.

Only the API developers (creator, publisher) are allowed to test the APIs through the test console. The developers can do the basic functional tests such as the mediation policies, make sure whether the request goes as expected to the back-end
and the proper responses are received, request/response schema validation and check whether the API resources are defined as expected.

The **Test Console** menu/option in the Publisher portal's API details page can be used to test the API at the design phase. Once the developer initiates the test by clicking on the initialize test button, the API is transformed to the prototype(testing)
state and the swagger console is populated with a test-key(token) which prevents the unauthorized users accessing the particular API.

If the API is in the created lifecycle state, the developer can initialize the test.

!!! Note
    We don't allow testing for the APIs that are in publish state.Hence API developer/publisher has to demote the API to prototype/created
    state.
    ![]({{base_path}}/assets/img/learn/publisher-testconsole-publishstate.png)

Let's see how to use the Publisher test Console to test an API.

The examples here use the `PizzaShack` REST API, which was created in [Create a REST API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) .

1.  Sign in to the API Publisher `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher` ). Upon signing in, the list of APIs in the API Publisher is listed. Please refer [create an API guide](/learn/design-api/create-api/create-a-rest-api/) to create a new API.

     The list of APIs in the API Publisher appears. If there are no APIs created, [create an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) before starting.

2.  Click on an API that is in the **CREATED** state.

     <img src="{{base_path}}/assets/img/learn/select-created-api.png" alt="Select API" title="Select API" width="35%" />

3.  Click **Test Console**.

     ![]({{base_path}}/assets/img/learn/publisher-testconsole-createdstate.png)

4.  Click on  the **Initiate Test**  button. This will open the swagger UI(API Console) to test the PizzaShack API before publish to the subscribers.

      ![]({{base_path}}/assets/img/learn/publisher-testconsole-swaggerconsole.png)

5.  Expand the POST  method and click Try it out. It will generated the **test-key** to invoke the API. Then click on execute as follows.

    ![]({{base_path}}/assets/img/learn/publisher-testconsole-testkey.png)

    !!! tip
            **test-key token**

            If API developer initiate a test, the swagger console will be automatically populated with the generated **test-key**. If you try the test api call through the terminal or command line, make sure you copy the generated test-key.


You have now successfully test an API using the publisher test Console and publish the API to the gateway.








