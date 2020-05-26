# Securing OAuth Token with HMAC Validation

Implementing security measures in order to prevent the possible attacks is a need in using enterprise software. Keyed-Hash Message Authentication Code (HMAC) validation is such measure which involved a cryptographic hash function and used to verify both the data integrity and authentication of a Message as with any Message Authentication code. In this tutorial you will use the HMAC to validate the OAuth tokens created in WSO2 API Manager and and WSO2 Identity Server.

-   [Preventing miss-use of OAuth Tokens](#SecuringOAuthTokenwithHMACValidation-Preventingmiss-useofOAuthTokens)
-   [WSO2 IS Extension - OAuth Token Generator Extension](#SecuringOAuthTokenwithHMACValidation-WSO2ISExtension-OAuthTokenGeneratorExtension)
-   [WSO2 API Manager extension - HMAC and timestamp verification handler](#SecuringOAuthTokenwithHMACValidation-WSO2APIManagerextension-HMACandtimestampverificationhandler)

#### Preventing miss-use of OAuth Tokens

In API Manager, the main use case of HMAC is preventing miss-use of expired OAuth tokens or randomly generated OAuth tokens. Stolen or randomly generated tokens can be used to employ DOS/DDOS attacks effectively.

If an attacker uses random tokens to send API requests, API Manager will try to verify the token and it will hit through the critical path of verification. This is a costly transaction and it can cause high latencies and instability in API Manager clusters. Implementation of this particular solution is done using extensions developed for standard extension points of WSO2 API Manager and WSO2 Identity Server.

![]({{base_path}}/assets/attachments/103334788/103334789.png)
#### **WSO2 IS Extension - OAuth Token Generator Extension**

Add the following configuration to the `<APIM_HOME>/repository/conf/deployment.toml` in order to enable Keyed-Hash Message Authentication Code (HMAC) validation via the HMAC OAuth handler.


```
[oauth.extensions]
token_generator="com.sample.lahiru.wso2.hmac.oauth"
```

!!! info
    More information on developing OAuth token generator extensions can be found [here](https://is.docs.wso2.com/en/5.10.0/learn/extension-points-for-oauth/#oauth-token-generator) . Code for this particular solution can be found in [oauth-hmac-extension](https://github.com/lahirus/oauth-hmac-extension/blob/master/src/main/java/com/sample/lahiru/wso2/hmac/oauth/OAuthHMACTokenIssuer.java) GitHub repository .


This extension is responsible for enhancing the OAuth token with HMAC(Hash-based Message Authentication Code), so that above mentioned attacks will be less effective. Following two parts will be added to the token in addition to the default token created in WSO2 IS.

-   HMAC

-   Expiry timestamp

The format of the access token will be as follows thereafter. The token has 3 parts, delimited by “.”.

Part I — original access token issued from WSO2 Identity Server

Part II — Hex value for token expiry time

Part III — HMAC calculation of (‘Part I’ + ‘.’ + ‘Part II’)

**Access token format :&lt;Part I&gt;.&lt;Part II&gt;.&lt;Part III&gt;**

Example : ba13cf7473cfbde970ae6e8b60973f64.0000015fc1ebabde.67830f2f2886256eb80faa9dab85c3d2c9be7db1

#### WSO2 API Manager extension -  HMAC and timestamp verification handler

You can engage this handler by adding following entry before **\#foreach($handler in $handlers)** line of **velocity\_template.xml** file located in &lt;AM\_HOME&gt;/repository/resources/api\_templates/ directory.

``` java
    <handler class=“com.sample.lahiru.wso2.hmac.handler.HMACTokenValidatorHandler”/>
```

!!! info
Refer [Writing Custom Handlers](https://docs.wso2.com/display/AM210/Writing+Custom+Handlers) for understanding how to develop and engage WSO2 API handler extensions. Find the code for APIM handler in GitHub in [oauth-hmac-extension](https://github.com/lahirus/oauth-hmac-extension/blob/master/src/main/java/com/sample/lahiru/wso2/hmac/handler/HMACTokenValidatorHandler.java) .


This custom handler verifies the HMAC of the token before it tries to authenticate using default authentication handler, which will be an expensive operation usually. It will also make sure the token is not expired. These verification will avoid any API calls to WSO2 API Manager, in case of the token is expired or HMAC is invalid.

HMAC validation handler calculates the HMAC using Part I and Part II(See Access token format), extracted from the token and validates by comparing that value with HMAC value included in the token(Part III).


