# Advanced Configurations

This section explains how to configure scope to role mappings for API Manager REST APIs.

##Changing Default Roles

Certain resources of the REST API are protected using OAuth 2.0 scopes. Each tenant has a `tenant-conf.json` configuration file with a section for RESTAPIScopes that contains a mapping between all the scopes that are available with API Manager REST APIs, and a set of roles. 

When a user requires access to a resource protected by an OAuth 2.0 scope, an access token associated with that particular scope needs to be provided as the Bearer token in the Authroization header. In order to retrieve the token, the user has to invoke the Token API and request for that scope. For more information, see the Authorization section in REST API documents. When issuing such an access token, the Token API validates the eligibility of the user for that particular scope using the RESTAPIScopes configuration. An access token with the particular scope is issued for the user only if that user has been assigned one or more of the roles specified in the RESTAPIScopes configuration for that scope.

You can modify the default roles defined in RESTAPIScopes configuration according to your requirements via the Admin Portal UI. For more information, refer [Managing Permissions]({{base_path}}/administer/managing-users-and-roles/managing-permissions/#adding-role-based-permissions). 

!!! note
    Restart the server for the RESTAPIScopes configuration changes to take effect.
