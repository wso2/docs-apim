# Test a REST API

**Testing APIs** is trying out the APIs at the publisher itself and make sure whether the functionalities and behaviours are met.

API Publisher  has an integrated API Console, which allows you to visualize the API contract and interact with API's resources.

Let's see how to use the Publisher test Console to test an API.

The examples here use the `PizzaShack` REST API, which was created in [Create a REST API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) .

1.  Sign in to the API Publisher `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher` ). Upon signing in, the list of APIs in the API Publisher is listed. Please refer [create an API guide](/learn/design-api/create-api/create-a-rest-api/) to create a new API.

     If there are no APIs created, [create an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) before starting.


2.  Click **Try out** on the left navigation menu.

     ![]({{base_path}}/assets/img/learn/publisher-testconsole-leftpane.png)

3.  You can generate the internal key by clicking on the button to invoke the pizzashack API.

      ![]({{base_path}}/assets/img/learn/publisher-testconsole-generateKey.png)

      !!! Note   
      If you want to authenticate the API call in custom way, you can generate token and please enter it in the internal key text field.

4.  Expand the POST  method and click Try it out. Click Execute.

    ![]({{base_path}}/assets/img/learn/publisher-testconsole-testkey.png)
