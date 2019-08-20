# Edit and Consume APIs using Swagger Tools

WSO2 API Manager has an integrated Swagger Editor, which is part of the Swagger project.

[Swagger](http://swagger.io/) is a 100% open source, standard, language-agnostic specification and a complete framework for describing, producing, consuming, and visualizing RESTful APIs, without the need of a proxy or third-party services. Swagger allows consumers to understand the capabilities of a remote service without accessing its source code, and interact with the service with a minimal amount of implementation logic. Swagger helps describe a service in the same way that interfaces describe lower-level programming code.

The [Swagger Editor](https://github.com/swagger-api/swagger-editor) is a dependency-free collection of HTML, JavaScript, and CSS that dynamically generate documentation from a Swagger-compliant API. Swagger-compliant APIs give you interactive documentation, client SDK generation, and more discoverability. The Swagger Editor has JSON code and its UI facilitates easier code indentation, keyword highlighting and shows syntax errors on the fly. You can add resource parameters, summaries and descriptions to your APIs using the Swagger Editor.

API Manager supports [Open API 3.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md) and [Open API 2.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md) specifications and you can simply create, import, edit and consume the APIs defined in both specifications.

In this tutorial, let's see how you can add interactive documentation to an API by directly editing the Swagger code via the API Publisher UI.

!!! note
This tutorial uses the `         PhoneVerification        ` API created in [Create and Publish an API](_Create_and_Publish_an_API_) .


1.  Sign in to the API Publisher and choose to design a new REST API.
    `           https://<hostname>:9443/publisher          `
    ![](attachments/103328505/103328458.png)

        !!! note
    You can select the OpenAPI specification version when you start creating a new REST API. To see the options, click **Show More Options** . Select the supported API specification from the drop-down list.

    ![](attachments/103328505/103328459.png)


2.  Click **Start Creating** .
3.  In the **Design** tab, give an API name, a context and a version, and click **Edit Source** under the **API Definition** section.
    The Swagger UI opens.
    ![](attachments/103328505/103328460.png)
4.  Add a GET and POST method for the API.

    1.  Under the `             paths            ` object, remove the `             {}            ` and add the following code, as shown in the screenshot below.

                !!! tip
        In the code below, note that you have a resource defined with the URL pattern `             /CheckPhoneNumber            ` under the `             paths            ` object. This is followed by the HTTP methods GET and POST. For each HTTP method, the following parameters are defined.

        -   **responses:** An object to hold responses that can be used across operations. See the Swagger specification for details. **
            **
        -   **x-auth-type** : WSO2-specific object to define the authentication type of the method.
        -   **x-throttling-tier** : WSO2-specific object to define the throttling tier of the method.


        ``` java
                 /CheckPhoneNumber:
                    get:
                      responses:
                        '200':
                          description: ''
                      x-auth-type: Application & Application User
                      x-throttling-tier: Unlimited
                    post:
                      responses:
                        '200':
                          description: ''
                      x-auth-type: Application & Application User
                      x-throttling-tier: Unlimited  
        ```

                !!! info
        Troubleshooting

        If you get an error after adding the API definition in the Swagger UI, first check the indentation of the code that you added, which defines the API, because Swagger throw errors if the indention is not correct.


        ![](attachments/103328505/103328461.png)

    2.  Click **Apply Changes** .
        This adds a resource with two HTTP methods into the API, which is visible in the API Publisher.
        ![](attachments/103328505/103328462.png)

    Let's assume that the backend of this API sends the response in XML format. Let's document this under the GET method in the resource that we just added.

5.  Change the response content type to XML.

    1.  Click **Edit Source** and add the following code under the GET method.

        ``` java
                produces:
                        - text/xml
        ```

        ![](attachments/103328505/103328478.png)

    2.  Click **Apply Changes** .
        The response content type that you updated is visible when you expand the GET method in the API Publisher.

                !!! tip
        You can use this attribute to document the type of the response message that the backend sends. **It does not do any message type conversion** . You can add multiple values as a comma-separated list.
        Example:

        ``` java
                produces:
                 - text/xml, application/json
        ```


        ![](attachments/103328505/103328463.png)

6.  Define parameters that correspond to the GET method.

    1.  Click **Edit Source** and add the following code, which defines two parameters to the method, under the GET method.

        ``` java
                parameters:
                        - name: PhoneNumber
                          in: query
                          required: true
                          type: string
                          description: Give the phone number to be validated
                        - name: LicenseKey
                          in: query
                          required: true
                          type: string
                          description: Give the license key as 0 for testing purpose
        ```

        ![](attachments/103328505/103328476.png)

    2.  Click **Apply Changes** .
        The two parameters with their descriptions that you added are visible when you expand the GET method in API Publisher.
        ![](attachments/103328505/103328464.png)

7.  Add a summary and description for the GET method.

    1.  Click **Edit Source** and add the following code, which defines a summary and description, to the GET method.

        ``` java
                    summary: Check the validity of your phone number
                    description: "Phone Verification validates a telephone number and returns carrier information, location routing etc."
        ```

        ![](attachments/103328505/103328474.png)

    2.  Click **Apply Changes** .
        The summary and description of the GET method that you added is visible when you expand the GET method in the API Publisher.
        ![](attachments/103328505/103328465.png)

8.  Add parameters to the POST method and change the POST method datatype.

    1.  Click **Edit Source** and add the following code under the POST method, which defines two parameters named `             PhoneNumber            ` and `             LicenseKey            ` to pass in the payload. It also changes the datatypes of the parameters to `             application/x-www-form-urlencoded            ` as the backend expects that datatype.

        ``` java
                    consumes:
                            - application/x-www-form-urlencoded
                          parameters:
                            - name: PhoneNumber
                              in: formData
                              required: true
                              type: string
                              description: Give the phone number to be validated
                            - name: LicenseKey
                              in: formData
                              required: true
                              type: string
                              description: Give the license key as 0 for testing purpose
        ```

        ![](attachments/103328505/103328472.png)

    2.  Click **Apply Changes** .
        The two parameters with their descriptions that you added are visible when you expand the POST method in the API Publisher.
        ![](attachments/103328505/103328466.png)

9.  Change the title of the API.

    1.  Click **Edit Source** , and add the following code in the Swagger UI.
        This is the title that is visible to the consumers in the API Store after the API is published.

        ``` java
                    info:
                      title: PhoneVerificationAPI
        ```

        ![](attachments/103328505/103328467.png)
        You can see how this change is reflected in the API Store in step 15.

    2.  Click **Apply Changes** and complete the API creation process.

10. Complete the rest of the API creation process.
    For more information, see step 7 onwards under [Create and Publish an API](Create-and-Publish-an-API_103327814.html#CreateandPublishanAPI-ManageAPI) .

11. Click **Go to APIStore** and the API you just published appears.
12. Click **API Console** .
    Note that the changes that you made earlier now appear in the API Store for consumers.
    ![](attachments/103328505/103328468.png)

In this tutorial, you have seen how the integrated Swagger Editor can be used to design, describe, and document your API, so that the API consumers get a better understanding of the API's functionality.


