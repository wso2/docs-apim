# Rejecting Revoked Tokens

After issuing an access token, a user or admin can revoke it due to any reason, such as security violation. If a revoked token is used to invoke an API, Choreo Connect will reject the invocation by returning an Unauthenticated response.

!!! note
    Revoking the access token can only be done by enabling the Control Plane Event hub. So you need to follow [this]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-api-to-choreo-connect/#via-api-manager) as initial setup to enable Control Plane.

!!! info
    When you revoke an access token using APIM, the same information will be collected by Choreo Connect via the Control Plane Event hub and the Choreo Connect will reject the same token.


### Revoking an Access Token

Here are the steps to revoking an Access Token.

!!! info 
    Before you begin, make sure you have enabled the Control Plane with Choreo Connect

1. [Deploy the API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-api-to-choreo-connect/#via-api-manager).

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
        2021-05-01 07:20:57 INFO [revoked_token_listener.go:36] - [messaging.handleTokenRevocation] [-] RevokedToken: 4e330dbd-75c6-4ab5-a749-b9497aa3521a, Token Type: JWT
        2021-05-01 07:20:57 INFO [server.go:827] - [xds.UpdateEnforcerRevokedTokens] [-] New Revoked token cache update for the label: commonEnforcerLabel version: 652374093
        ```

4. If you need to verify, you can try invoking the API using revoked access token. See the following example.

    ``` tab="Example"
        curl -X '<your method>' 'https://localhost:9095/<your api context>/<your api version>/<your resource>' -H 'accept: application/json'   -H 'Content-Type: application/json' -H 'Authorization: Bearer eyJ4NXQiOiJNell4TW1Ga09HWXdNV0kwWldObU5EY3hOR1l3WW1NNFpUQTNNV0kyTkRBelpHUXpOR00wWkdSbE5qSmtPREZrWkRSaU9URmtNV0ZoTXpVMlpHVmxOZyIsImtpZCI6Ik16WXhNbUZrT0dZd01XSTBaV05tTkRjeE5HWXdZbU00WlRBM01XSTJOREF6WkdRek5HTTBaR1JsTmpKa09ERmtaRFJpT1RGa01XRmhNelUyWkdWbE5nX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJ2YWppcmEtZGV2IiwiYXV0IjoiQVBQTElDQVRJT05fVVNFUiIsImF1ZCI6IkhEZVBINFluRHdjOWtsUHRROTY3MnpGVWZYa2EiLCJuYmYiOjE2MTk4NTIyOTYsImF6cCI6IkhEZVBINFluRHdjOWtsUHRROTY3MnpGVWZYa2EiLCJzY29wZSI6InJlYWQ6cGV0cyIsImlzcyI6Imh0dHBzOlwvXC9sb2NhbGhvc3Q6OTQ0M1wvb2F1dGgyXC90b2tlbiIsImV4cCI6MTYxOTg1NTg5NiwiaWF0IjoxNjE5ODUyMjk2LCJqdGkiOiI0ZTMzMGRiZC03NWM2LTRhYjUtYTc0OS1iOTQ5N2FhMzUyMWEifQ.jUzkrljwJu77FRGswRQ1uKBRDsHswwp1oRyjh-ULOf4pZ0faxCTKO2djpBBkxVtgaiv1YKtzhaqRUV_UgCLDAgVO76G-sntSXmN5ATEohwcJfSNRHzOsfiCem-kkgO6P2TE15x7G4hlTfufIiirVlXVjcv-4s3fTVCCd-rsm7JEgb9HM-W2GV6l8-CDJ1cfzEQxSnQ7hgueO9CzhTbSnfRNZrwxZtNxXQC8LZcKfNQAzBbOlScT0qB4iJj_FgOHdIlpLANC-IFeCO6UnChztGRqccyTWUSjNuQBtN3_jCb1MQig3m7b2ZSirDygnZ09oecxxxUC2Sj1mHM5i6LCsEA'   -d '<your-content>' -v -k
    ```
    
    ``` tab="Response"
        You will receive following response with the HTTP status as 401. 

        {"error_message":"Invalid Credentials","code":"900901","error_description":"Invalid JWT token. Make sure you have provided the correct security credentials"}
    ```
