# Secure Endpoint with Digest Auth

A secured endpoint is where we have access-protected resources. You have to specify the username and the password when a request is sent to a secured endpoint.  The endpoint authentication mechanism can either be Basic Authentication or Digest Authentication. They differ on how the credentials are communicated and how access is granted by the backend server. 

Digest Authentication applies a hash function to the username and the password before sending them over the network. It is a process of applying MD5 cryptographic hashing with the usage of nonce values to prevent replay attacks. It is a simple challenge-response authentication mechanism that may be used by a server to challenge a client request and by a client to provide authentication information for the secured endpoint.

!!! info
    The following is the sample format of the header that will be sent to the backend when Digest Auth is specified as the endpoint authentication type. The attributes added to the authorization header depends on the challenge header sent from the backend server.
    
    ``` java
    Authorization: Digest username="Admin", realm="admin@wso2.com", nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093", uri="/dir/index.html", qop=auth, nc=00000001, cnonce="0a4f113b", response="6629fae49393a05397450978507c4ef1", opaque="5ccc069c403ebaf9f0171e9517f40e41"
    ```

Digest Authentication is safer than Basic Authentication, which uses unencrypted base64 encoding instead of a hashing mechanism.

When you [create an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api) using the API Publisher, you can specify the endpoint of the API backend implementation via the **Endpoint** page as Production and Sandbox endpoints.

Follow the instructions below to use Digest Auth as the endpoint authentication type when using a secured endpoint:

1. Click **Endpoint** in the API Publisher.

2. Click **General Endpoint Configurations** to select the endpoint security scheme. 

     ![general-endpoint-detail]({{base_path}}/assets/img/learn/general-endpoint-detail.png)

3. Select **Digest Auth** as the endpoint authentication type and enter your credentials.
     
     ![enpoint-security-type-digest]({{base_path}}/assets/img/learn/enpoint-security-type-digest.png)

    !!! info

         The selected Endpoint Auth Type should match with the authentication mechanism supported by the secured endpoint.

4. Click **SAVE.**
