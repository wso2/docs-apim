# Create and Publish an API from a Swagger Definition

A Swagger definition is a format that describes REST APIs. In this tutorial, you create and publish an API in WSO2 API Manager using a Swagger definition for an existing API.

1.  Sign in to the WSO2 API Publisher.
    `          https://<hostname>:9443/publisher         `
2.  In the **APIS** menu, click **Add New API** .
    ![](attachments/103328690/103328669.png)
3.  Select **I Have an Existing API** . Click **Swagger URL** and give `                     http://petstore.swagger.io/v2/swagger.json                   ` as the URL. Click **Start Creating** .
    ![](attachments/103328690/103328668.png)
4.  Edit the information as given below. **
    **

    | Field   | Sample value |
    |---------|--------------|
    | Name    | Petstore     |
    | Context | /petstore    |
    | Version | 1.0.0        |

    ![](attachments/103328690/103328667.png)

5.  Notice that all the **API resources** are created **** automatically when the Swagger URL is specified.
    ![](attachments/103328690/103328666.png)
6.  Click **Edit Source** to edit the Swagger file and remove security headers. This is required to invoke the API in the Store using the Swagger UI.
    ![](attachments/103328690/103328665.png)
7.  Remove the security tag from the `           /pet          ` POST resource given below. This is required to enable API invocation using the API (store) console.

    **Swagger - Post resource**

    ``` java
        //remove the following code snippet
        security:
                - petstore_auth:
                    - 'write:pets'
                    - 'read:pets'
    ```

8.  Remove the security `           pet/{petId}          ` GET resource given below:

    **Swagger - Get resource**

    ``` java
            //remove the following code snippet
    security:
            - api_key: []
    ```
9.  After removing the security tags, click **Apply Changes** to save the changes.
    ![](attachments/103328690/103328664.png)
    Then, click **Next: Implement.**
10. Click the **Managed API** option. Enter the information shown below and click **Next: Manage** .

    | Field               | Sample value                                          |
    |---------------------|-------------------------------------------------------|
    | Endpoint type       | HTTP/REST endpoint                                    |
    | Production endpoint | http://petstore.swagger.io/v2/                        |
    | Sandbox endpoint    | Providing only the production endpoint is sufficient. |

    ![](attachments/103328690/103328663.png)

11. Select the options described in the table below.

    | Field              | Sample value   | Description                                                                                                                                                                                                           |
    |--------------------|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | Transports         | HTTP and HTTPS | The transport protocol on which the API is exposed.  Both HTTP and HTTPS transports are selected by default. If you want to limit API availability to only one transport (e.g., HTTPS), un-check the other transport. |
    | Subscription Tiers | Gold, Silver   | The API can be available at different levels of service. They allow you to limit the number of successful hits to an API during a given period of time.                                                               |

    ![](attachments/103328690/103328662.png)

12. Click **Save & Publish** . **
    **

Now you have successfully published an API using a Swagger defintion.

Let's invoke the API from the API Store.

### **Invoking the API**

1.  Sign in to the WSO2 API Store.
    `           https://<hostname>:9443/store          `

2.  Select the **PetStore** API to open it.
3.  [Subscribe](_Subscribe_to_an_API_) to the API using the DefaultApplication and the Gold tier.
    ![](attachments/103328690/103328661.png)
4.  Click **View Subscriptions** to view all the APIs to which the Default Application has subscribed.
    ![](attachments/103328690/103328660.png)
5.  Click the **Production Keys** tab and generate a token.
    ![](attachments/103328690/103328659.png)

6.  Navigate to the **API Console** for the PetStore API.
    ![](attachments/103328690/103328658.png)
7.  Expand the `           POST          ` resource, click **Try it out** , and give the following example as the request body. Click **Execute** and view the response.

    -   [**Request Body**](#0a7fc092d2d742abaa5437dc3ed7e679)
    -   [**Response**](#ceccefb57b454ce29370fdfa0890f218)

    ``` java
        {
          "id": 0,
          "category": {
            "id": 0,
            "name": "Dogs"
          },
          "name": "Rover",
          "photoUrls": [
            "string"
          ],
          "tags": [
            {
              "id": 0,
              "name": "lion_shepard"
            }
          ],
          "status": "available"
        }
    ```

    ``` java
            {
              "id": 9123612807670061000,
              "category": {
                "id": 0,
                "name": "Dogs"
              },
              "name": "Rover",
              "photoUrls": [
                "string"
              ],
              "tags": [
                {
                  "id": 0,
                  "name": "lion_shepard"
                }
              ],
              "status": "available"
            }
    ```

    You have successfully invoked the Petstore API.

!!! info
### Related Tutorials

-   [Create and Publish an API](_Create_and_Publish_an_API_)

-   [Create a WebSocket API](_Create_a_WebSocket_API_)

-   [Create a Prototyped API with an Inline Script](_Create_a_Mock_API_with_an_Inline_Script_)


