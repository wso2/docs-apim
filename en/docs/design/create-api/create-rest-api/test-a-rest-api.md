# Test a REST API

Testing APIs refers to the process of trying out the APIs in the Publisher itself to make sure that the APIs meet the required functionalities and behaviour.

WSO2 API Manager's Publisher offers an integrated API Console that allows API creators and API publishers to visualize the API contract and interact with API's resources.

Follow the instructions below to use the Publisher test console to test an API:

!!! note
    Create the `PizzaShack` REST API or an API of your choice before following the instructions below. For more information, see [Create a REST API.]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api)

1.  {!includes/sign-in-publisher.md!}

     The list of APIs that are available in the Publisher appear.

2. Click on the API that you wish to test.

     Let's use the sample `PizzaShack` REST API.

3.  Go to **Test** and click **TryOut**.

     <html><div class="admonition note">
     <p class="admonition-title">Note</p>
     <ul> The API can be tested in any lifecycle state, and can be used in any state except for the "retired" state, even in the "block" state you can still try it out, but you will get a 503 (service unavailable) response.</ul></div>
     </html>

     <a href="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-leftpane.png"><img src="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-leftpane.png" width="20%" alt="Try out menu option in the left panel"></a>

4.  You can generate the internal key by clicking on the **Generate Key** button to invoke and test the PizzaShack API.

       <html><div class="admonition note">
          <p class="admonition-title">Note</p>
          <ul>The UI generates an Internal token to authenticate the API call.</ul>
          <ul>If the API Publishers have a token or key then they can paste it in the UI and invoke the API using that key</ul>
          </div>
       </html>
      <a href="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-generatekey.png"><img src="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-generatekey.png" width="80%" alt="Generate key"></a>

5.  Expand the **GET**  method, click **Try it out**, and click **Execute**.

    Note the successful response for the API invocation.

    [![Publisher test console]({{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-swaggerui.png)]({{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-swaggerui.png)
