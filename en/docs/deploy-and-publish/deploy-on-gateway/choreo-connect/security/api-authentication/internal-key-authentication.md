# Internal Key Authentication

This authentication is used to testing APIs that are created in the Publisher to make sure that the APIs meet the required functionalities and behaviour.

### Step 1 - Deploy a created API to Choreo Connect via APIM
Follow the documentation [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-api-to-choreo-connect/#via-api-manager),

### Step 2 - Generate Internal Key from APIM Publisher
Follow the steps 1 - 4 in [here]({{base_path}}/design/create-api/test-a-rest-api/)

### Step 3 - Invoke the API using the Internal Key
Use the cURL command below to invoke the API via the gateway.

``` bash tab="Format"
curl -k -X GET "<API_URL>" -H  "accept: application/json" -H  "Internal-Key: <Internal-Key>"
```

``` bash tab="Example"
curl -k -X GET "https://localhost:9095/pizzashack/1.0.0/menu" -H  "accept: application/json" -H  "Internal-Key: eyJraWQiOiJnYXRld2F5X2NlcnRpZmljYXRlX2FsaWFzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJpc3MiOiJodHRwczpcL1wvYXBpbTo5NDQzXC9vYXV0aDJcL3Rva2VuIiwia2V5dHlwZSI6IlBST0RVQ1RJT04iLCJzdWJzY3JpYmVkQVBJcyI6W3sic3Vic2NyaWJlclRlbmFudERvbWFpbiI6bnVsbCwibmFtZSI6IlBpenphU2hhY2tBUEkiLCJjb250ZXh0IjoiXC9waXp6YXNoYWNrXC8xLjAuMCIsInB1Ymxpc2hlciI6ImFkbWluIiwidmVyc2lvbiI6IjEuMC4wIiwic3Vic2NyaXB0aW9uVGllciI6bnVsbH1dLCJleHAiOjE2MTgwMDkyMDcsInRva2VuX3R5cGUiOiJJbnRlcm5hbEtleSIsImlhdCI6MTYxNzk0OTIwNywianRpIjoiNDZmMDJjNTgtM2Y0My00YTVhLWEyMjYtMGNhNzM5NmM0NjRjIn0.J-AtbYeVyrFCSXD99DXtND7GsRv1ghuzWJ1XYa3ZA4QRmdJYqCUEo3G2Xy1x5shopp9GZHi6G6wmpiYf-n4rNMNNrCt8O8ogp8EzjWb3cLrbyRDCMYQocEBeefDDB6_62PUHBMQNNXdxbOe38KfY0J_kH_IIGYGqKQEqHUCn8B84dX8ec-HefjqzL9NXti4VIx1_Donhpwtk3J5ERyJdvFRfsXfQFZZVxUZao0em4jJ9sOcbMNQA0FpRzCgx5TMZ6RNC5TBAi_QqO1SysD7jShJ5rw0Eqztn4y3_zr_aE1P3H7xAzl3niWUyzXOZWnuJQPn2C_hBDHKQ--FtViuyrg"
```

!!! Important
    If the APIM publisher uses certificate with different alias name, add the alias name for certificateAlias Configuration in below configuration define at config.toml.

    ```
    [[security.enforcer.tokenService]]
    name="APIM Publisher"
    issuer = "https://localhost:9443/publisher"
    certificateAlias = ""
    certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"
    ```
