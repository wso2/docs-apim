# Basic Auth

When you create an API using the API Publisher, you can specify the endpoint of the API backend implementation in the **Implement** tab as Production and Sandbox endpoints.

If this endpoint is secured, there is an option for you to set the Auth type and credentials for the endpoint under **Show More Options.**

![](attachments/103334868/103334863.png)

Here you can click the **Show More Options** link to select the endpoint security scheme. If you select **Secured** , you are prompted to select the authentication type for the endpoint and also to give its credentials.

Then select the endpoint authentication type according to the authentication scheme that is supported by your endpoint. If your endpoint supports basic authentication, you can select the **Basic Auth** option from the drop down list and give your credentials.

![](attachments/103334868/103334862.png)

To give more context on the above scenario, a secured endpoint is where we have access-protected resourses. You have to specify the username and the password when a request is sent to a secured endpoint. The endpoint authentication mechanism can either be Basic Authentication or Digest Authentication. They differ on how the credentials are communicated and how access is granted by the backend server.

!!! info
The Endpoint Auth Type selected should match with the authentication mechanism supported by the secured endpoint.


is the simplest mechanism used to enforce access controls to web resources. Here, the HTTP user agent provides the username and the password when making a request. The string containing the username and the password separated by a colon is Base64 encoded and sent in the authorization header when calling the backend when authentication is required.

!!! info
If the user name and password is admin, the following header will be sent to the backend

`         Authorization: Basic YWRtaW46YWRtaW4=        ` (where `         YWRtaW46YWRtaW4=        ` is equivalent to Base64Encoded{admin:admin} )


