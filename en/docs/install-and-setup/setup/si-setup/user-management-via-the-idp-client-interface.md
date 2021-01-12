# User Management via the IdP Client Interface

In WSO2 Streaming Integrator, user management is carried out through the
Identity Provider Client (IdP Client) interface that can be switched as
required for the user scenario. Furthermore, a custom IdP Client can be
written to encompass the required user store connection and
authentication.

IdP clients can be switched by specifying te required IdP client in the
`auth.configs:` section in the
`<SI_HOME>/conf/server/deployment.yaml` file.

``` java
    auth.configs:
      # Type of the IdP Client used for the user authentication
      type: local
```

The active IdP client is `local` by default.

Following are the IdP Clients available for WS)2 Streaming Integrator:

- [Local IdP Client](#UserManagementviatheIdPClientInterface-LocalIdPClient)

- [External IdP Client](#UserManagementviatheIdPClientInterface-ExternalIdPClient)

## Local IdP Client

The local IdP Client interacts with the file-based user store that is
defined in the `<SI_HOME>/conf/server/deployment.yaml` file under the `auth.configs` namespace as follows:

``` text
    auth.configs:  
      type: 'local'
      userManager:
        adminRole: admin
        userStore:
          users:
           - 
             user:
               username: admin
               password: YWRtaW4=
               roles: 1
          roles:
           -     
             role:
               id: 1
               displayName: admin
```

The above user and role is added by default.

### Parameters

The parameters used in the above configurations are as follows:

!!! note

If new users/roles are added and the above default user and role are
also needed, the following parameters must be added to the user store
along with the added user/role.


<table style="width:100%;">
<colgroup>
<col style="width: 24%" />
<col style="width: 11%" />
<col style="width: 63%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Default Value</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>              userManager &gt; adminRole             </code></p></td>
<td><p><code>              admin             </code></p></td>
<td><p>The name of the role that has administration privileges.</p></td>
</tr>
<tr class="even">
<td><p><code>              userManager &gt; userStore &gt;             </code></p>
<p><code>              users &gt; user &gt; username             </code></p></td>
<td><p><code>              admin             </code></p></td>
<td><p>The username of the user.</p></td>
</tr>
<tr class="odd">
<td><p><code>              userManager &gt; userStore &gt;             </code></p>
<p><code>              users &gt; user &gt; password             </code></p></td>
<td><p><code>              YWRtaW4=             </code></p></td>
<td><p>The Base64(UTF-8) encrypted password of the user.</p></td>
</tr>
<tr class="even">
<td><p><code>              userManager &gt; userStore &gt;             </code></p>
<p><code>              users &gt; user &gt; roles             </code></p></td>
<td><p><code>              1             </code></p></td>
<td><p>A comma separated list of the IDs of the roles assigned to the user.</p></td>
</tr>
<tr class="odd">
<td><p><code>              userManager &gt; userStore &gt;             </code></p>
<p><code>              roles &gt; role &gt; id             </code></p></td>
<td><p>1</p></td>
<td><p>The unique ID for the role.</p></td>
</tr>
<tr class="even">
<td><p>userManager &gt; userStore &gt;</p>
<p>roles &gt; role &gt; admin</p></td>
<td><p>admin</p></td>
<td><p>The name of the role.</p></td>
</tr>
</tbody>
</table>

  

Furthermore, Local IdP Client functionality can be controlled via the
properties defined in the
`         <SP_HOME>/conf/<PROFILE>/deployment.yam        ` l file under
the `         auth.configs        ` namespace as shown below.

``` java
    auth.configs:
      type: local
      properties:
        sessionTimeout: 3600
        refreshSessionTimeout: 86400     
```

The following are the properties that can be configured for the local
IdP provider:

<table>
<thead>
<tr class="header">
<th>Property</th>
<th>Default Value</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>             properties &gt; sessiontimeout            </code></td>
<td><code>             3600            </code></td>
<td><div class="content-wrapper">
<p>The number of seconds for which the session is valid once the user logs in.</p>
!!! info
<p>The value specified here needs to be greater than 60 seconds because the system checks the user credentials and keeps extending the session every minute until the session timeout is reached.</p>

</div></td>
</tr>
<tr class="even">
<td><pre><code>properties &gt; refreshSessionTimeout</code></pre></td>
<td><code>             86400            </code></td>
<td>The number of seconds for which the refresh token used to extend the session is valid.</td>
</tr>
</tbody>
</table>

  

The complete default configuration of the `         local        ` IdP
Client is as follows:

``` java
    auth.configs:  
      type: 'local'
      properties:
        sessionTimeout: 3600
        refreshSessionTimeout: 86400
      userManager:
        adminRole: admin
        userStore:
          users:
           - 
             user:
               username: admin
               password: YWRtaW4=
               roles: 1
          roles:
           -     
             role:
               id: 1
               displayName: admin
```

  

## External IdP Client

External IdP Client authenticates users by interacting with an external
identity provider via OAuth2 and SCIM2 protocols. The user store is
maintained by the external identity provider. WSO2 SP authenticates by
requesting an access token from the identity provider using the password
grant type.

!!! note

The identity provider with which WSO2 SP interacts with to authenticate
users must be started before the SP server.


The auth manager must be configured under the
`         auth.configs        ` namespace as shown below:

``` java
    auth.configs:
      type: external
      authManager:
        adminRole: admin
```

The parameters used in the above configurations areas follows:

| Parameter                                            | Default Value                      | Description                                              |
|------------------------------------------------------|------------------------------------|----------------------------------------------------------|
| `              userManager > adminRole             ` | `              admin             ` | The name of the role that has administration privilages. |

  

Furthermore, external IdP client functionality can be controlled via the
properties defined in the
`         <SP_HOME>/conf/<PROFILE>/deployment.yaml        ` file under
the `         auth.configs        ` namespace as shown below.

``` java
    auth.configs: 
     type: external
     properties:
      kmDcrUrl: https://localhost:9443/identity/connect/register
      kmTokenUrl: https://localhost:9443/oauth2
      kmUsername: admin
      kmPassword: admin
      idpBaseUrl: https://localhost:9443/scim2
      idpUsername: admin
      idpPassword: admin
      portalAppContext: portal
      statusDashboardAppContext: monitoring
      businessRulesAppContext : business-rules
      databaseName: WSO2_OAUTH_APP_DB
      cacheTimeout: 900
      baseUrl: https://localhost:9643
      grantType: password
      
```

The following are the properties that can be configured for the external
IdP provider:

<table>
<thead>
<tr class="header">
<th><div>
Property
</div></th>
<th><div>
Default Value
</div></th>
<th><div>
Description
</div></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>kmDcrUrl</td>
<td><pre><code>https://localhost:9443/identity/connect/register</code></pre></td>
<td>The Dynamic Client Registration (DCR) endpoint of the key manager in the IdP.</td>
</tr>
<tr class="even">
<td><code>             dcrAppOwner            </code></td>
<td><code>             kmUsername            </code></td>
<td><br />
</td>
</tr>
<tr class="odd">
<td><code>             kmTokenUrl            </code></td>
<td><p><code>                             https://localhost:9443/oauth2                           </code></p></td>
<td>The token endpoint of the key manager in the IdP.</td>
</tr>
<tr class="even">
<td><p><code>              kmUsername             </code></p></td>
<td><code>             admin            </code></td>
<td>The username for the key manager in the IdP.</td>
</tr>
<tr class="odd">
<td><p><code>              kmPassword             </code></p></td>
<td><code>             admin            </code></td>
<td>The password for the key manager in the IdP.</td>
</tr>
<tr class="even">
<td><p><code>              idpBaseUrl             </code></p></td>
<td><p><code>                             https://localhost:9443/scim2                           </code></p></td>
<td>The SCIM2 endpoint of the IdP.</td>
</tr>
<tr class="odd">
<td><p><code>              idpUsername             </code></p></td>
<td><code>             admin            </code></td>
<td>The username for the IdP.</td>
</tr>
<tr class="even">
<td><p><code>              idpPassword             </code></p></td>
<td><code>             admin            </code></td>
<td>The password for the IdP.</td>
</tr>
<tr class="odd">
<td><p><code>              portalAppContext             </code></p></td>
<td><code>             portal            </code></td>
<td>The application context of the Dashboard Portal application in WSO2 SP.</td>
</tr>
<tr class="even">
<td><code>             statusDashboardAppContext            </code></td>
<td><code>             monitoring            </code></td>
<td>The application context of the Status Dashboard application in WSO2 SP.</td>
</tr>
<tr class="odd">
<td><p><code>              businessRulesAppContext             </code></p></td>
<td><code>             business-rules            </code></td>
<td>The application context of the Business Rules application in WSO2 SP.</td>
</tr>
<tr class="even">
<td><code>             databaseName            </code></td>
<td><p><code>              WSO2_OAUTH_APP_DB             </code></p></td>
<td>The name of the wso2.datasource used to store the OAuth application credentials</td>
</tr>
<tr class="odd">
<td><code>             cacheTimeout            </code></td>
<td><code>             900            </code></td>
<td>The cache timeout for the validity period of the token in seconds.</td>
</tr>
<tr class="even">
<td><p><code>              baseUrl             </code></p></td>
<td><p><code>                             https://localhost:9643                           </code></p></td>
<td><p>The base URL to which the token should be redirected after the code returned</p>
<p>from the <strong>Authorization Code</strong> grant type is used to get the token.</p></td>
</tr>
<tr class="odd">
<td><p><code>              grantType             </code></p></td>
<td><code>             password            </code></td>
<td>The grant type used in the OAuth application token request.</td>
</tr>
<tr class="even">
<td><p><code>              spClientId/ portalClientId/             </code></p>
<p><code>              statusDashboardClientId/ businessRulesClientId             </code></p></td>
<td>N/A</td>
<td><p>The client ID of the OAuth App. If no value is specified for this property, the DCR is called to register the application and persist the client ID in the data store.</p></td>
</tr>
<tr class="odd">
<td><p><code>              spClientId/ portalClientId/             </code></p>
<p><code>              statusDashboardClientId/ businessRulesClientId             </code></p></td>
<td>N/A</td>
<td><p>The client secret of the OAuth application. If no value is specified for this property, the DCR is called to register the application and persist the client secret in the data store.</p>
<p><br />
</p></td>
</tr>
</tbody>
</table>

  

### Writing custom IdP Client

When writing a custom IdP client, the following two interfaces must be
implemented:

-   [IdPClientFactory](https://github.com/wso2/carbon-analytics-common/blob/master/components/authentication/org.wso2.carbon.analytics.idp.client/src/main/java/org/wso2/carbon/analytics/idp/client/core/spi/IdPClientFactory.java)
    : This is a factory OSGi service that initialtes the custom IdP
    client using the properties from
    `          IdPClientConfiguration.         `
-   [IdPClient](https://github.com/wso2/carbon-analytics-common/blob/master/components/authentication/org.wso2.carbon.analytics.idp.client/src/main/java/org/wso2/carbon/analytics/idp/client/core/api/IdPClient.java)
    :  An interface with functions to provide user authentication and
    retrieval by the other services.

  
