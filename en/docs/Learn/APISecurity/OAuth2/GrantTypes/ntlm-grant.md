# dup\_NTLM Grant

**NTLM** is the successor of the authentication protocol in Microsoft LAN Manager (LANMAN), an older Microsoft product, and attempts to provide backwards compatibility with LANMAN. You can obtain an access token to your API in an API Manager instance running on **Windows** by providing a valid NTLM token as an authorization grant. The steps are given below:

#### Invoking the Token API to generate tokens

1.  Get a valid consumer key and consumer secret pair. Initially, you generate these keys through the API Store by clicking the **Generate Keys** button on the **Production Keys** tab of the application.
2.  Combine the consumer key and consumer secret keys in the format consumer-key:consumer-secret and encode the combined string using base64 ( <http://base64encode.org> ).
    In order to generate an access token with NTLM, you must have an NTLM token.

3.  Generate an NTLM token by running the sample provided in the `            <APIM_HOME>/samples/NTLMGrantClient           ` directory. See the **`             Readme.txt            `** in the same folder for instructions.

4.  Invoke the token API in the following manner to get an access token.
    The value of the **`             windows_token            `** in the following command is the NTLM token that you generated in the previous step.

    ``` java
        curl -k -d "grant_type=iwa:ntlm&windows_token=<give the NTLM token you got in step 3>" -H 
        "Authorization: Basic <give the string you got in step2>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
    ```

        !!! note
    Note that for users to be counted in the [Registered Users for Application statistics](https://docs.wso2.com/display/AM260/Viewing+API+Statistics#ViewingAPIStatistics-topUsers) which takes the number of users shared each of the Application, they should have to generate access tokens using [Password Grant](https://docs.wso2.com/display/AM210/Password+Grant) type.



