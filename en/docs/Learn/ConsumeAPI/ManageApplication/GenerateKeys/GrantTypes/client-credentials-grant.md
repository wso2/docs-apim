# Client Credentials Grant

Client credentials can be used when the authorization scope is limited to the protected resources belonging to the client. Client credentials are used as an authorization grant when the client requests access to protected resources based on an authorization previously arranged with the authorization server. The client application requests an access token from the authorization server, authenticating the request with its client key and client secret. If the client is successfully authenticated, an access token is returned.

Please refer to the [WSO2 IS documentation](https://docs.wso2.com/display/IS540/Client+Credentials+Grant) for a detailed explanation on this grant type  with the use of a sequence diagram.

### Invoking the Token API to generate the tokens

1.  Get a valid consumer key and consumer secret pair. Initially, you generate these keys through the API Store by clicking **Generate Keys** on the **Production Keys** tab of the application.
2.  Combine the consumer key and consumer secret keys in the format `consumer-key:consumer-secret` and encode the combined string using base64 ( [http://base64encode.org](http://base64encode.org/) ).
3.  Use the following sample cuRL command to obtain the access token.

    -   [**Format**](#format)
    -   [**Example**](#example)
    -   [**Response**](#response)

    ``` java
        curl -k -d "grant_type=client_credentials" -H "Authorization: Basic <Base64-encoded-client_key:client_secret>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:<https-port>/token -v
    ```

    ``` java
            curl -k -d "grant_type=client_credentials" -H "Authorization: Basic cEJ6dUlaaEdwaGZRbWRjVVgwbG5lRmlpdXh3YTo0U0pnV19qTU56aGpIU284OGJuZVhtTnFNMjRh" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token -v
    ```

    ``` java
            > POST /token HTTP/1.1
            > Host: localhost:8243
            > User-Agent: curl/7.54.0
            > Accept: */*
            > Authorization: Basic cEJ6dUlaaEdwaGZRbWRjVVgwbG5lRmlpdXh3YTo0U0pnV19qTU56aGpIU284OGJuZVhtTnFNMjRh
            > Content-Type: application/x-www-form-urlencoded
            > Content-Length: 29
            < HTTP/1.1 200 OK
            < X-Frame-Options: DENY
            < Cache-Control: no-store
            < X-Content-Type-Options: nosniff
            < Pragma: no-cache
            < X-XSS-Protection: 1; mode=block
            < Content-Type: application/json
            < Date: Thu, 18 Jan 2018 12:54:32 GMT
            < Transfer-Encoding: chunked
            {"access_token":"4c27f899-6f9c-3217-b974-3ceb5a409ac3","scope":"am_application_scope default","token_type":"Bearer","expires_in":723}
    ```

        !!! info
    The following command can be used to obtain the access token by specifying the scope.

    ``` java
        curl -k -d "grant_type=client_credentials&scope=test" -H "Authorization: Basic <ConsumerKey:ConsumerSecret>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
    ```


!!! tip
**Tip** : We use the Client Credentials grant type to regenerate access tokens for an application through the API Store. Therefore, you should enable this grant type to the application. To do that, go to the API Store, click the application name from under the **APPLICATIONS** menu, click the **Production Keys** tab, and select the **Client Credentials** check box under **Grant Types** .
![](/assets/attachments/103335291/103335292.png)
!!! info
Setting a custom validity time for access tokens

You can set a validity period for access tokens through a cURL command. Pass the validity\_period parameter as shown in the example below.

``` java
    curl -X POST -k -H "Authorization: Basic <Base64(clientId:clientSecret)>" -d "grant_type=client_credentials&validity_period=<custom_validity_time_in_seconds>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token -v
```

!!! note
Note that for users to be counted in the [Registered Users for Application statistics](https://docs.wso2.com/display/AM260/Viewing+API+Statistics#ViewingAPIStatistics-topUsers) which takes the number of users shared each of the Application, they should have to generate access tokens using [Password Grant](_Password_Grant_) type.


