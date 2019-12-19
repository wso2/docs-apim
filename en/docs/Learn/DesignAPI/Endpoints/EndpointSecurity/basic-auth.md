# Secure Endpoint with Basic Auth

When you [create an API]({{base_path}}/Learn/DesignAPI/CreateAPI/create-a-rest-api) using the API Publisher, you can specify the endpoint of the API backend implementation in the **Endpoint** tab as Production and Sandbox endpoints.

1. If this endpoint is secured, there is an option for you to set the Auth type, credentials for the endpoint and endpoint certification under **General Endpoint Configurations.**
![general-endpoint-detail]({{base_path}}/assets/img/Learn/general-endpoint-detail.png)


2. Expand the **General Endpoint Configurations** to select the endpoint security scheme. If you enable **Endpoint Security** , you are prompted to select the authentication type for the endpoint and also to give its credentials.

3. Select the endpoint authentication type according to the authentication scheme that is supported by your endpoint. If your endpoint supports basic authentication, you can select the **Basic Auth** option from the drop-down list and give your credentials.
4. click on **save.**
![endpoint-security-type-basic]({{base_path}}/assets/img/Learn/endpoint-security-type-basic.png)

To give more context on the above scenario, a secured endpoint is where we have access-protected resources. You have to specify the username and the password when a request is sent to a secured endpoint. The endpoint authentication mechanism can either be Basic Authentication or Digest Authentication. They differ on how the credentials are communicated and how access is granted by the backend server.

!!! info
    The Endpoint Auth Type selected should match with the authentication mechanism supported by the secured endpoint.


Basic Authentication is the simplest mechanism used to enforce access controls to web resources. Here, the HTTP user agent provides the username and the password when making a request. The string containing the username and the password separated by a colon is Base64 encoded and sent in the authorization header when calling the backend when authentication is required.

!!! info
    If the user name and password is admin, the following header will be sent to the backend.
    ```
    Authorization: Basic YWRtaW46YWRtaW4=` (where `YWRtaW46YWRtaW4=` is equivalent to Base64Encoded{admin:admin} )
    ``` 
