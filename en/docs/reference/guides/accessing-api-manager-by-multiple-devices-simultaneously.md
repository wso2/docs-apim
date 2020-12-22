# Accessing API Manager by Multiple Devices Simultaneously

When there are many users who use production deployment setups, accessing API Manager by multiple devices is more important. According to the architecture, if we logged out from one device and revoke the access token, then all the calls made with that token thereafter will get authentication failures. In this case Applications should be smart enough to detect that authentication failure and should request  for a new access token.

!!! note
    This will be a guide for you if you create client applications having API Manager underlying. Note that, you need to use [Password Grant](https://docs.wso2.com/display/AM260/Password+Grant) type in this scenario.


-   [Issue in having multiple access tokens](#AccessingAPIManagerbyMultipleDevicesSimultaneously-Issueinhavingmultipleaccesstokens)
-   [Recommended Solution](#AccessingAPIManagerbyMultipleDevicesSimultaneously-RecommendedSolution)
-   [How this should work](#AccessingAPIManagerbyMultipleDevicesSimultaneously-Howthisshouldwork)

### Issue in having multiple access tokens

Once user log in to the application, the user may need to provide username and password. We can use that information (username and passowrd) and consumer key, consumer secret pair to receive new token once the authentication failure is detected. We should handle this from client application side. If we allowed users to have multiple tokens at the same time, that will cause security related issues and finally users will end up with thousands of tokens that the user cannot even maintain. And also those affects to the usage of metering and statistics.

### Recommended Solution

The recommended solution for this issue is having only one active user token at a given time. We need to make the client application aware about error responses sent from the API Manager Gateway. And use the refresh token Approach. When you request a user token you will get refresh token along with the token response, so that you can use that for refreshing the access token.

### How this should work

Let's assume that same user is logged in to WSO2 API Manager from desktop and tablet. At that time client should provide username and password both when they are login into desktop and tablet apps. Then you can generate token request with the username - password and consumer key - consumer secret pair. So this request will be kept in memory until the user close or logout from application (We do not persist this data to anywhere so that there is no security issue.).

Then, when the user log out from the desktop or the application on the desktop, it decides to refresh the OAuth token first, and the user will be prompted to enter their username and password on the tablet, since the tablet has  revoked or inactivated the OAuth token. But in here, you should not prompt username and password because the client is already provided them and you have the token request in memory. Once we detect authentication failure from the tablet, it will immediately send token generation request and get new token. Hence, the user will not aware about what happen underline.
