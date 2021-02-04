# NTLM Grant

**NTLM** is the successor of the authentication protocol in Microsoft LAN Manager (LANMAN), an older Microsoft product, and attempts to provide backwards compatibility with LANMAN. You can obtain an access token to your API in an API Manager instance running on **Windows** by providing a valid NTLM token as an authorization grant. The steps to get access token for NTLM grant, are given below:

#### Invoking the Token API to generate tokens

1.  Get a valid consumer key and consumer secret pair. Initially, you generate these keys through the API Developer Portal by clicking the **Generate Keys** button on the **Production Keys** tab of the application.

2.  Combine the consumer key and consumer secret keys in the format consumer-key:consumer-secret and encode the combined string using [base64 encoder](http://base64encode.org).

    In order to generate an access token with NTLM, you must have an NTLM token.

3.  Generate an NTLM token by running the sample provided in the `<APIM_HOME>/samples/NTLMGrantClientWithHandshake` directory. See the **`Readme.txt`** in the same folder for instructions.

4.  Invoke the token API in the following manner to get an access token.
    The value of the **`windows_token`** in the following command is the NTLM token that you generated in the previous step.

    ``` java
    curl -k -d "grant_type=iwa:ntlm&windows_token=<give the NTLM token you got in step 3>" -H "Authorization: Basic <give the string you got in step2>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
    ```

!!! tip
    If you want to **disable the NTLM grant type** in the APIM instance, add the following entry to the `deployment.toml` file in the `<APIM_HOME>/repository/conf/` folder.

    ``` toml
    [oauth.grant_type.iwa_ntlm]
    enable = false
    ```
