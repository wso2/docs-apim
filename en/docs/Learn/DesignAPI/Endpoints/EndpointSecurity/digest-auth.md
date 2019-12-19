# Secure Endpoint with Digest Auth

When you [create an API]({{base_path}}/Learn/DesignAPI/CreateAPI/create-a-rest-api) using the API Publisher, you can specify the endpoint of the API backend implementation in the **Endpoint** tab as Production and Sandbox endpoints.

1. If this endpoint is secured, there is an option for you to set the Auth type, credentials for the endpoint and endpoint certification under **General Endpoint Configurations.**
![general-endpoint-detail]({{base_path}}/assets/img/Learn/general-endpoint-detail.png)

2. Click **General Endpoint Configurations** to select the endpoint security scheme. If you enable **Endpoint Security** , you are prompted to select the authentication type for the endpoint and also to give its credentials.

3. Select the endpoint authentication type according to the authentication scheme that is supported by your endpoint. If your endpoint supports Digest authentication, you can select the **Digest Auth** option from the drop down list and give your credentials.
4. click on **save.**

![enpoint-security-type-digest]({{base_path}}/assets/img/Learn/enpoint-security-type-digest.png)

To give more context on the above scenario, a secured endpoint is where we have access-protected resources. You have to specify the username and the password when a request is sent to a secured endpoint. The endpoint authentication mechanism can either be Basic Authentication or Digest Authentication. They differ on how the credentials are communicated and how access is granted by the backend server.

!!! info
    The selected Endpoint Auth Type should match with the authentication mechanism supported by the secured endpoint.


Digest Authentication applies a hash function to the username and the password before sending them over the network. It is a process of applying MD5 cryptographic hashing with the usage of nonce values to prevent replay attacks. It is a simple challenge-response authentication mechanism that may be used by a server to challenge a client request and by a client to provide authentication information for the secured endpoint.

This approach is safer than Basic Authentication, which uses unencrypted base64 encoding instead of a hashing mechanism.

!!! info
    The following is the sample format of the header that will be sent to the backend when Digest Auth is specified as the endpoint auth type. The attributes added to the authorization header depends on the challenge header sent from the backend server.
    ``` java
    Authorization: Digest username="Admin", realm="admin@wso2.com", nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093", uri="/dir/index.html", qop=auth, nc=00000001, cnonce="0a4f113b", response="6629fae49393a05397450978507c4ef1", opaque="5ccc069c403ebaf9f0171e9517f40e41"
    ```
