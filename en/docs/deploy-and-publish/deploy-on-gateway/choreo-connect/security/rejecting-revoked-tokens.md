# Rejecting Revoked Tokens

After issuing an access token or an API Key, a user or admin can revoke it due to any reason. This must be done especially if it has been compromised. If a revoked token is used to invoke an API, Choreo Connect will reject the invocation by returning an Unauthenticated Error response.

!!! important
    Revoking the access token can only be done by enabling the Control Plane Event hub. This is when running [Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/). For standalone mode, the only workaround would be to undeploy the API and redeploy with a different name or the version, while keeping the context (basepath) unchanged.

!!! info
    When you revoke an access token using APIM, an event will be sent to Choreo Connect via the Control Plane Event hub and Choreo Connect will reject the token then onwards. You can follow the [Quick Start Guide]({{base_path}}https://apim.docs.wso2.com/en/latest/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/) to have an initial setup of Choreo Connect with Control Plane enabled.

Follow the steps given below to revoke an access token or an API key

- [Revoking an Access Token](#revoking-an-access-token)
- [Revoking an API Key](#revoking-an-api-key)

## Revoking an Access Token

Here are the steps to revoke an Access Token.

1. [Deploy the API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect).

2. Generate an access token from APIM (Follow [Get a Test Key to Invoke an API]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/#get-a-test-key-to-invoke-an-api)).

3. Revoke the access token by calling the following API from control plane.

    ``` tab="Format"
    curl -k -v -d "token=<ACCESS_TOKEN_TO_BE_REVOKED>" -H "Authorization: Basic <base64 encoded (clientId:clientSecret)>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:9443/oauth2/revoke
    ```
    
    ``` tab="Example"
    curl -k -v -d "token=eyJ4NXQiOiJNell4TW1Ga09HWXdNV0kwWldObU5EY3hOR1l3WW1NNFpUQTNNV0kyTkRBelpHUXpOR00wWkdSbE5qSmtPREZrWkRSaU9URmtNV0ZoTXpVMlpHVmxOZyIsImtpZCI6Ik16WXhNbUZrT0dZd01XSTBaV05tTkRjeE5HWXdZbU00WlRBM01XSTJOREF6WkdRek5HTTBaR1JsTmpKa09ERmtaRFJpT1RGa01XRmhNelUyWkdWbE5nX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJ2YWppcmEtZGV2IiwiYXV0IjoiQVBQTElDQVRJT05fVVNFUiIsImF1ZCI6IkhEZVBINFluRHdjOWtsUHRROTY3MnpGVWZYa2EiLCJuYmYiOjE2MTk4NTIyOTYsImF6cCI6IkhEZVBINFluRHdjOWtsUHRROTY3MnpGVWZYa2EiLCJzY29wZSI6InJlYWQ6cGV0cyIsImlzcyI6Imh0dHBzOlwvXC9sb2NhbGhvc3Q6OTQ0M1wvb2F1dGgyXC90b2tlbiIsImV4cCI6MTYxOTg1NTg5NiwiaWF0IjoxNjE5ODUyMjk2LCJqdGkiOiI0ZTMzMGRiZC03NWM2LTRhYjUtYTc0OS1iOTQ5N2FhMzUyMWEifQ.jUzkrljwJu77FRGswRQ1uKBRDsHswwp1oRyjh-ULOf4pZ0faxCTKO2djpBBkxVtgaiv1YKtzhaqRUV_UgCLDAgVO76G-sntSXmN5ATEohwcJfSNRHzOsfiCem-kkgO6P2TE15x7G4hlTfufIiirVlXVjcv-4s3fTVCCd-rsm7JEgb9HM-W2GV6l8-CDJ1cfzEQxSnQ7hgueO9CzhTbSnfRNZrwxZtNxXQC8LZcKfNQAzBbOlScT0qB4iJj_FgOHdIlpLANC-IFeCO6UnChztGRqccyTWUSjNuQBtN3_jCb1MQig3m7b2ZSirDygnZ09oecxxxUC2Sj1mHM5i6LCsEA" -H "Authorization: Basic SERlUEg0WW5Ed2M5a2xQdFE5NjcyekZVZlhrYTplVzU1RFBBRm4zaUZzZjIwM3B4U0dFZ3NHODBh" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:9443/oauth2/revoke
    ```
    
    ``` tab="Response"
        You receive an empty response with the HTTP status as 200. The following HTTP headers are returned:
            
            X-Frame-Options: DENY
            X-Content-Type-Options: nosniff
            X-XSS-Protection: 1; mode=block
            Cache-Control: no-store
            Pragma: no-cache
            RevokedAccessToken: eyJ4NXQiOiJNell4TW1Ga09HWXdNV0kwWldObU5EY3hOR1l3WW1NNFpUQTNNV0kyTkRBelpHUXpOR00wWkdSbE5qSmtPREZrWkRSaU9URmtNV0ZoTXpVMlpHVmxOZyIsImtpZCI6Ik16WXhNbUZrT0dZd01XSTBaV05tTkRjeE5HWXdZbU00WlRBM01XSTJOREF6WkdRek5HTTBaR1JsTmpKa09ERmtaRFJpT1RGa01XRmhNelUyWkdWbE5nX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJ2YWppcmEtZGV2IiwiYXV0IjoiQVBQTElDQVRJT05fVVNFUiIsImF1ZCI6IkhEZVBINFluRHdjOWtsUHRROTY3MnpGVWZYa2EiLCJuYmYiOjE2MTk4NTIyOTYsImF6cCI6IkhEZVBINFluRHdjOWtsUHRROTY3MnpGVWZYa2EiLCJzY29wZSI6InJlYWQ6cGV0cyIsImlzcyI6Imh0dHBzOlwvXC9sb2NhbGhvc3Q6OTQ0M1wvb2F1dGgyXC90b2tlbiIsImV4cCI6MTYxOTg1NTg5NiwiaWF0IjoxNjE5ODUyMjk2LCJqdGkiOiI0ZTMzMGRiZC03NWM2LTRhYjUtYTc0OS1iOTQ5N2FhMzUyMWEifQ.jUzkrljwJu77FRGswRQ1uKBRDsHswwp1oRyjh-ULOf4pZ0faxCTKO2djpBBkxVtgaiv1YKtzhaqRUV_UgCLDAgVO76G-sntSXmN5ATEohwcJfSNRHzOsfiCem-kkgO6P2TE15x7G4hlTfufIiirVlXVjcv-4s3fTVCCd-rsm7JEgb9HM-W2GV6l8-CDJ1cfzEQxSnQ7hgueO9CzhTbSnfRNZrwxZtNxXQC8LZcKfNQAzBbOlScT0qB4iJj_FgOHdIlpLANC-IFeCO6UnChztGRqccyTWUSjNuQBtN3_jCb1MQig3m7b2ZSirDygnZ09oecxxxUC2Sj1mHM5i6LCsEA
            AuthorizedUser: <your-user-name>@carbon.super
            RevokedRefreshToken: 6350cf06-d6b6-3e4a-8833-768150af1b44
            Date: Sat, 01 May 2021 07:20:57 GMT
            Content-Type: text/html
            Content-Length: 0
            Server: WSO2 Carbon Server
    
        Note that if you use an invalid access token, you still receive an empty response with the HTTP status as 200 but only the following HTTP headers are returned:
        
            X-Frame-Options: DENY
            X-Content-Type-Options: nosniff
            X-XSS-Protection: 1; mode=block
            Cache-Control: no-store
            Pragma: no-cache
            Date: Sat, 01 May 2021 07:30:15 GMT
            Content-Type: text/html
            Content-Length: 0
            Server: WSO2 Carbon Server    
    ```

    !!! info
        Once the token is revoked, if you check the logs in `adapter`, you will see the following logs appear, which means the `adapter` has received the token revocation data from the control plane.
        ```
        2021-05-01 07:20:57 INFO [revoked_token_listener.go:39] - [messaging.handleTokenRevocation] [-] Event JWT is received []
        2021-05-01 07:20:57 INFO [server.go:1315] - [xds.UpdateEnforcerRevokedTokens] [-] New Revoked token cache update for the label: commonEnforcerLabel version: 652374093
        ```

4. Verify by invoking the API using revoked access token. See the following example.

    ``` tab="Example"
        curl -X '<your method>' 'https://localhost:9095/<your api context>/<your api version>/<your resource>' -H 'accept: application/json'   -H 'Content-Type: application/json' -H 'Authorization: Bearer eyJ4NXQiOiJNell4TW1Ga09HWXdNV0kwWldObU5EY3hOR1l3WW1NNFpUQTNNV0kyTkRBelpHUXpOR00wWkdSbE5qSmtPREZrWkRSaU9URmtNV0ZoTXpVMlpHVmxOZyIsImtpZCI6Ik16WXhNbUZrT0dZd01XSTBaV05tTkRjeE5HWXdZbU00WlRBM01XSTJOREF6WkdRek5HTTBaR1JsTmpKa09ERmtaRFJpT1RGa01XRmhNelUyWkdWbE5nX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJ2YWppcmEtZGV2IiwiYXV0IjoiQVBQTElDQVRJT05fVVNFUiIsImF1ZCI6IkhEZVBINFluRHdjOWtsUHRROTY3MnpGVWZYa2EiLCJuYmYiOjE2MTk4NTIyOTYsImF6cCI6IkhEZVBINFluRHdjOWtsUHRROTY3MnpGVWZYa2EiLCJzY29wZSI6InJlYWQ6cGV0cyIsImlzcyI6Imh0dHBzOlwvXC9sb2NhbGhvc3Q6OTQ0M1wvb2F1dGgyXC90b2tlbiIsImV4cCI6MTYxOTg1NTg5NiwiaWF0IjoxNjE5ODUyMjk2LCJqdGkiOiI0ZTMzMGRiZC03NWM2LTRhYjUtYTc0OS1iOTQ5N2FhMzUyMWEifQ.jUzkrljwJu77FRGswRQ1uKBRDsHswwp1oRyjh-ULOf4pZ0faxCTKO2djpBBkxVtgaiv1YKtzhaqRUV_UgCLDAgVO76G-sntSXmN5ATEohwcJfSNRHzOsfiCem-kkgO6P2TE15x7G4hlTfufIiirVlXVjcv-4s3fTVCCd-rsm7JEgb9HM-W2GV6l8-CDJ1cfzEQxSnQ7hgueO9CzhTbSnfRNZrwxZtNxXQC8LZcKfNQAzBbOlScT0qB4iJj_FgOHdIlpLANC-IFeCO6UnChztGRqccyTWUSjNuQBtN3_jCb1MQig3m7b2ZSirDygnZ09oecxxxUC2Sj1mHM5i6LCsEA'   -d '<your-content>' -v -k
    ```
    
    ``` tab="Response"
        You will receive following response with the HTTP status as 401. 

        {"error_message":"Invalid Credentials","code":"900901","error_description":"Invalid JWT token. Make sure you have provided the correct security credentials"}
    ```

## Revoking an API Key

Here are the steps to revoke an API Key.

1. [Deploy the API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect).

2. Generate an API Key from API-M by following the steps in [Secure APIs with API Keys]({{base_path}}/design/api-security/api-authentication/secure-apis-using-api-keys).

3. Get an access token to the Control Plane (API-M) by referring to [this section]({{base_path}}/reference/product-apis/devportal-apis/devportal-v3/devportal-v3/#section/Authentication). Remember to include `apim:api_key` as a scope when requesting the access token.

4. Revoke the API Key by calling the following API from the Control Plane.

    ``` tab="Format"
    curl -k -v -H "Authorization: Bearer <access-token-for-API-M-REST-API>" -d '{ "apikey" : "<API-Key-to-revoke>" }' -H "Content-Type: application/json" "https://localhost:9443/api/am/devportal/v3/applications/<application-ID>/api-keys/<key-type>/revoke"
    ```

    ``` tab="Example"
    curl -k -H "Authorization: Bearer e4cb79d6-c22e-386a-a1eb-0494208e9976" -H "Content-Type: application/json" -X POST -d '{ "apikey" : "eyJ4NXQiOiJOMkpqTWpOaU0yRXhZalJrTnpaalptWTFZVEF4Tm1GbE5qZzRPV1UxWVdRMll6YzFObVk1TlE9PSIsImtpZCI6ImdhdGV3YXlfY2VydGlmaWNhdGVfYWxpYXMiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJhcHBsaWNhdGlvbiI6eyJvd25lciI6ImFkbWluIiwidGllclF1b3RhVHlwZSI6bnVsbCwidGllciI6IjEwUGVyTWluIiwibmFtZSI6Im15IiwiaWQiOjIsInV1aWQiOiI5MzkyMTM2OC1lYmRkLTQxYzEtOWI2Ny1lMzhlZmNkZmMzMjAifSwiaXNzIjoiaHR0cHM6XC9cL2FwaW06OTQ0NFwvb2F1dGgyXC90b2tlbiIsInRpZXJJbmZvIjp7IlVubGltaXRlZCI6eyJ0aWVyUXVvdGFUeXBlIjoicmVxdWVzdENvdW50IiwiZ3JhcGhRTE1heENvbXBsZXhpdHkiOjAsImdyYXBoUUxNYXhEZXB0aCI6MCwic3RvcE9uUXVvdGFSZWFjaCI6dHJ1ZSwic3Bpa2VBcnJlc3RMaW1pdCI6MCwic3Bpa2VBcnJlc3RVbml0IjpudWxsfX0sImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOlt7InN1YnNjcmliZXJUZW5hbnREb21haW4iOiJjYXJib24uc3VwZXIiLCJuYW1lIjoicXFxcSIsImNvbnRleHQiOiJcL3FxcVwvMSIsInB1Ymxpc2hlciI6ImFkbWluIiwidmVyc2lvbiI6IjEiLCJzdWJzY3JpcHRpb25UaWVyIjoiVW5saW1pdGVkIn1dLCJ0b2tlbl90eXBlIjoiYXBpS2V5IiwiaWF0IjoxNjUwMzY0MjYyLCJqdGkiOiJlYzYxZDI0Zi04Nzg2LTRlYjktYmZiNy1lN2EyMGQwMjk1ZjYifQ==.M6ZiC1asUawlx73JYU83knl6vm1AG1q95DKnk-mU_59UG1yTRMJDtQn0CpHNDlTb-w9P4JGY8H5Z6l-aLUsmlyDAgIDG58_Q264jYqXleinRlOQyeAkQrPUM4DlVqM9yKOM-xLB8ZrE8feMj6-jHk6boJNtGBV1XUioJ-IQwq2MnBOII3dRbePYA7hNICmlOWaVXDOZitpihTiIl1JUHT7a_nGDiXg3b-MC14PqrdrAnqNWxih_K6oiVrlulsAaVWhRr3dmTQcsA4Eqr2N9FMHDRPeUT8MKlCpy7_SZeWX207LkwdnvWSVrV6dNPJuAWU1g8my_MYQlDDltZqKaisw==" }' "https://localhost:9443/api/am/devportal/v3/applications/93921368-ebdd-41c1-9b67-e38efcdfc320/api-keys/PRODUCTION/revoke"
    ```

    !!! info
        Refer to [Developer Portal - Revoke API Key]({{base_path}}/reference/product-apis/devportal-apis/devportal-v3/devportal-v3/#tag/API-Keys/paths/~1applications~1{applicationId}~1api-keys~1{keyType}~1revoke/post) section for more info.

    The above command will return an empty 200 response.

4.  Invoke the API with the same API key to verify whether the token has been revoked.

!!! tip

    If an API Key is lost or forgotten, as an alternative to revoking, you can either,   

    - block the subscription of the API to the Application or     
    - unsubscribe the API from the Application.