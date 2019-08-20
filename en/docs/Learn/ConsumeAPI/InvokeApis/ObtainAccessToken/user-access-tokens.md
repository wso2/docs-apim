# dup\_User Access Tokens

-   [Generating user access tokens](#dup_UserAccessTokens-Generatinguseraccesstokens)
-   [Renewing user access tokens](#dup_UserAccessTokens-Renewinguseraccesstokens)

### Generating user access tokens

User access tokens are tokens that authenticate the final user of an API, and are valid for all APIs subscribed to a user via a particular application. User access tokens allow you to invoke an API even from a third-party application such as a mobile app. You generate/renew a user access token by calling the Login API through a REST client. For more information, see [Token API](https://docs.wso2.com/display/AM300/Token+API) .

!!! tip
By default, access tokens and consumer secrets are not saved in an encrypted format in the database. An admin can **enable encryption** following the instructions in [Encrypting OAuth Keys](https://docs.wso2.com/display/AM210/Encrypting+OAuth+Keys) .

!!! tip
**Tip** : If you want to maintain authorization headers in messages, which are going out from the API Gateway, an admin can go to the `         <API_Gateway_node>/repository/conf/api-manager.xml        ` file, uncomment the `         <RemoveOAuthHeadersFromOutMessage>        ` element, set its value to `         false        ` , and then restart the server to apply the changes.

|                                                                                                                                                                                       |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `                 <RemoveOAuthHeadersFromOutMessage>                ` `                 false                ` `                 </RemoveOAuthHeadersFromOutMessage>                ` |

!!! note
Note that when a user is deleted, the access token is automatically invalidated.


### Renewing user access tokens

To renew a user token, issue a REST call to the WSO2 Login API through a REST client. For more information, see [Token API](https://docs.wso2.com/display/AM300/Token+API) .{


