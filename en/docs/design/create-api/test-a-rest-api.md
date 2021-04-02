# Test a REST API

Testing APIs refers to the process of trying out the APIs in the Publisher itself to make sure that the APIs meet the required functionalities and behaviour.

WSO2 API Manager's Publisher offers an integrated API Console that allows API creators and API publishers to visualize the API contract and interact with API's resources.

Follow the instructions below to use the Publisher test console to test an API:

!!! note
    Create the `PizzaShack` REST API or an API of your choice before following the instructions below. For more information, see [Create a REST API.]({{base_path}}/design/create-api/create-a-rest-api)

1.  {!includes/sign-in-publisher.md!}

     The list of APIs that are available in the Publisher appear.

2. Click on the API that you wish to test.

     Let's use the sample `PizzaShack` REST API.

3.  Click **TryOut**.

     <a href="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-leftpane.png"><img src="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-leftpane.png" width="20%" alt="Try out menu option in the left panel"></a>

4.  Click **GET TEST KEY**.

     This generates the internal key needed to invoke the API.

      <a href="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-generatekey.png"><img src="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-generatekey.png" width="60%" alt="Generate key"></a>

    <html><div class="admonition note">
    <p class="admonition-title">Note</p>
    <ul>If you want to perform the authentication process by using a custom token, please enter it in the **Internal Key** text field.</ul>
    </div>
    </html> 

5.  Expand the **GET**  method, click **Try it out**, and click **Execute**.

     Note the successful response for the API invocation.

    [![Publisher test console]({{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-swaggerui.png)]({{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-swaggerui.png)
