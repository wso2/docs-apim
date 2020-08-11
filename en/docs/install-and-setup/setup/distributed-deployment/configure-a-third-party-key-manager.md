# Configure a Third Party Key Manager

The **Key Manager** handles all clients, security, and access token-related operations. In a typical API Manager production deployment, different components talk to the Key Manager component for achieving different tasks. The API Gateway connects with the Key Manager to check the validity of OAuth tokens, subscriptions, and API invocations. When a subscriber generates an access token to the application using the Developer Portal, the Developer Portal makes a call to the Key Manager to create an OAuth App and obtains an access token. 
At server startup gateway fetches all the subscription validation meta information such as apis, api policies, url templates, applications, application keys, application policies, subscriptions, subscription policies from the database and persist in memory.
Hence, to validate a token, the API Gateway uses in-memory data store and validates the token details. For more information, see [Key Manager]({{base_path}}/getting-started/overview/#key-manager).

The Key Manager decouples the OAuth client and access token management from the rest of its operations so that you can plug in a third-party OAuth provider for managing OAuth clients and access tokens. When working with an external Key Manager, it requires to configure the Authorization server cofigurations in admin portal by adding a new key manager.

- [Integration with a third party OAuth Authorization Server](/administer/key-managers/overview/)