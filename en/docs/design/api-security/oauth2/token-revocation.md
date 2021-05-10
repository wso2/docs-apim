# Token Revocation

## Revoking access tokens

After issuing an access token, a user or an admin can revoke it in case of theft or a security violation. You can do this by calling the Revoke API using a utility like cURL. The Revoke API's endpoint URL is `http://localhost:8280/revoke` .

!!! note
    You can also revoke refresh tokens. For more information, see [Revoking a refresh token]({{base_path}}/design/api-security/oauth2/grant-types/refresh-token-grant/#revoking-a-refresh-token).


The parameters required to invoke the following API are as follows:

-   `token` - The token to be revoked

-   `<base64 encoded (clientId:clientSecret)>` - Use a base64 encoder (e.g., <https://www.base64encode.org/> ) to encode your client ID and client secret using the following format: `<clientId>:<clientSecret>` Thereafter, enter the encoded value for this parameter.

-   `token_type_hint` = This parameter is **optional**. If you do not specify this parameter, then WSO2 Identity Server (WSO2 IS) will search in both key spaces (access and refresh) and if it finds a matching token then it will be revoked. Therefore, if this parameter it not specified the token revokation process takes longer. However, if you specify this parameter then WSO2 IS only searches in the respective token key space, hence the token revokation process is much faster.

    ``` tab="Format"
        curl -k -v -d "token=<ACCESS_TOKEN_TO_BE_REVOKED>" -H "Authorization: Basic <base64 encoded (clientId:clientSecret)>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
        curl -k -v -d "token=<ACCESS_TOKEN_TO_BE_REVOKED>&token_type_hint=<access_token_or_refresh_token>" -H "Authorization: Basic <base64 encoded (clientId:clientSecret)>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
    ```
    
    ``` tab="Examples"
        curl -k -v -d "token=a0d210c7a3de7d548e03f1986e9a5c39" -H "Authorization: Basic OVRRNVJLZWFhVGZGeUpRSkRzam9aZmp4UkhjYTpDZnJ3ZXRual9ZOTdSSzFTZWlWQWx1aXdVVmth" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
        curl -k -v -d "token=1d18ec65-6151-3499-9352-68afe64299c3&token_type_hint=access_token" -H "Authorization: Basic OVRRNVJLZWFhVGZGeUpRSkRzam9aZmp4UkhjYTpDZnJ3ZXRual9ZOTdSSzFTZWlWQWx1aXdVVmth" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
        curl -k -v -d "token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IlpqUm1ZVE13TlRKak9XVTVNbUl6TWpnek5ESTNZMkl5TW1JeVkyRXpNamRoWmpWaU1qYzBaZz09In0.eyJhdWQiOiJodHRwOlwvXC9vcmcud3NvMi5hcGltZ3RcL2dhdGV3YXkiLCJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJhcHBsaWNhdGlvbiI6eyJvd25lciI6ImFkbWluIiwidGllciI6IjEwUGVyTWluIiwibmFtZSI6Imp3dCIsImlkIjo5OCwidXVpZCI6bnVsbH0sInNjb3BlIjoiYW1fYXBwbGljYXRpb25fc2NvcGUgZGVmYXVsdCIsImlzcyI6Imh0dHBzOlwvXC9sb2NhbGhvc3Q6OTQ0M1wvb2F1dGgyXC90b2tlbiIsInRpZXJJbmZvIjp7IlVubGltaXRlZCI6eyJzdG9wT25RdW90YVJlYWNoIjp0cnVlLCJzcGlrZUFycmVzdExpbWl0IjowLCJzcGlrZUFycmVzdFVuaXQiOm51bGx9fSwia2V5dHlwZSI6IlBST0RVQ1RJT04iLCJzdWJzY3JpYmVkQVBJcyI6W3sic3Vic2NyaWJlclRlbmFudERvbWFpbiI6ImNhcmJvbi5zdXBlciIsIm5hbWUiOiJQaXp6YVNoYWNrQVBJIiwiY29udGV4dCI6IlwvcGl6emFzaGFja1wvMS4wLjAiLCJwdWJsaXNoZXIiOiJhZG1pbiIsInZlcnNpb24iOiIxLjAuMCIsInN1YnNjcmlwdGlvblRpZXIiOiJVbmxpbWl0ZWQifV0sImNvbnN1bWVyS2V5IjoiRTI3cDVWT1hVcWk5RW5JU3lwUjhRckFHc2ZBYSIsImV4cCI6MTU3MzExMzIxOCwiaWF0IjoxNTczMTA5NjE4LCJqdGkiOiI2ZTcwZmNkZS0wNGNlLTRlNTgtYTMyYy04ZTlhYWQ5YmYwMDMifQ.VD23nViK6Np1U8SQxulxrEVFZpnPT7dpr3UN0xm--PSLBRXucWgrdse9qig922o9CWGj4lYxdsdHnwzz3Vh-i1-114jGnf_o6K-ITmO2m0SyCOrzo5PWMYbeZpkKM9slWahrGJm18XqGu7aRZiEnN8cLCke-DsnQVJJcCaS_jTniAD_-DCk5VBUTdQP1yiekq-A5QjKp_dKAjMF-8PQPXpMU526fXMMauFTz65EEZ-BpwAvfSBwLnSGI1GQp7xF9VWytCBAWt4ZvK6e7Y6hrwH1p7KT4Nli6PZv6RxbalW0mI9vqknSJRhWtn0GQcw1FSymMi-QOo0M7LgwIp7ypuw" -H "Authorization: Basic OVRRNVJLZWFhVGZGeUpRSkRzam9aZmp4UkhjYTpDZnJ3ZXRual9ZOTdSSzFTZWlWQWx1aXdVVmth" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
    ```
    
    ``` tab="Response"
        You receive an empty response with the HTTP status as 200. The following HTTP headers are returned:
            
            RevokedRefreshToken: 5e87a8235cd4d066e15c4c989f5ecf94
            Cache-Control: no-store
            Access-Control-Allow-Methods: POST
            X-Content-Type-Options: nosniff
            AuthorizedUser: admin@carbon.super
            Pragma: no-cache
            RevokedAccessToken: a0d210c7a3de7d548e03f1986e9a5c39
            X-XSS-Protection: 1; mode=block
            Access-Control-Allow-Headers: authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction,Authorization
            Content-Type: text/html
            Date: Thu, 07 Nov 2019 07:51:46 GMT
            Transfer-Encoding: chunked
    
        Note that if you use an invalid access token, you still receive an empty response with the HTTP status as 200 but only the following HTTP headers are returned:
        
            Cache-Control: no-store
            Access-Control-Allow-Methods: POST
            X-Content-Type-Options: nosniff
            Pragma: no-cache
            X-XSS-Protection: 1; mode=block
            Access-Control-Allow-Headers: authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction,Authorization
            Content-Type: text/html
            Date: Thu, 07 Nov 2019 07:58:11 GMT
            Transfer-Encoding: chunked
        
    ```
    
!!! note
    Revoking access tokens obtained with an Implicit grant
    
    If you obtained an access token with the Implicit grant type, you do not have to provide the client secret to revoke it. The sample cURL command to revoke an access token with Implicit grant is given below.
    
    ``` java
        curl -X POST -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -d "token=<ACCESS_TOKEN_TO_BE_REVOKED>&token_type_hint=access_token&client_id=<CLIENT_ID>" http://localhost:8243/revoke
    ```
    
