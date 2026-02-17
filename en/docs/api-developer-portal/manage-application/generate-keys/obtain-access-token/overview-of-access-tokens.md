# Overview of Access Tokens

When an Application Developer registers an Application on the Developer Portal, the Application is given a consumer-key and a consumer-secret, which represents the credentials of the Application that is being registered. The consumer-key becomes the unique identifier of the Application, similar to a user's username, and is used to authenticate users. When an Access Token is issued for the Application, it is issued against the latter mentioned consumer-key.

API consumers generate access tokens and pass them in the incoming API requests. The API key (i.e., the generated access token) is a simple string that you need to pass as an HTTP header. For example, `"Authorization: Bearer NtBQkXoKElu0H1a1fQ0DWfo6IX4a."` This works equally well for SOAP and REST calls.

Authorizing requests, which come to published APIs, using access tokens helps you **prevent certain types of denial-of-service (DoS) attacks**. If the token that is passed with a request is invalid, WSO2 API Manager (WSO2 API-M) discards that request in the first stage of processing it.

WSO2 API Manager provides two types of access tokens for authentication:

-   **Application Access Tokens** : Tokens to identify and authenticate an entire application. An application is a logical collection of many APIs. Using a single application access token, you can invoke all of these APIs.
-   **User Access Tokens** : Tokens to identify the final user of an application. For example, the final user of a mobile application deployed on different devices.

!!! note
        In WSO2 API-M the access token must be unique for the following combinations - `CONSUMER_KEY, AUTHZ_USER, USER_TYPE, TOKEN_STATE, TOKEN_STATE_ID` and `TOKEN_SCOPE`. The latter mentioned constraint is defined in the `IDN_OAUTH2_ACCESS_TOKEN` table. Therefore, it is not possible to have more than one Access Token for any of the above combinations.


