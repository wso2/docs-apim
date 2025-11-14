# Configure WSO2 IS 7.x as a Key Manager

WSO2 API Manager supports multiple Key Managers. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager, and it has the inbuilt capability of configuring **WSO2 Identity Server 7.x** (WSO2 IS 7.x) as a Key Manager.

!!! info
    This document provides instructions on configuring **WSO2 Identity Server 7.x** as a Key Manager. If you are using an older version of WSO2 Identity Server, see [Configure WSO2 IS as a Key Manager]({{base_path}}/administer/key-managers/configure-wso2is-connector).

!!! Note
    **Role Based Authorization** based on the [WSO2 Identity Server 7 Role Based Authorization model](https://is.docs.wso2.com/en/7.0.0/guides/authorization/api-authorization/api-authorization/) is supported from WSO2 Identity Server 7.0.0.65 update level onwards.

## Limitations of using WSO2 IS 7.x as a Key Manager

Data models of WSO2 API Manager 4.4.0 and WSO2 Identity Server 7.x are different. Therefore, when using WSO2 API Manager 4.4.0 with WSO2 Identity Server 7.x as the key manager,

- **Tenancy** is **not** supported.
- WSO2 IS 7.x **cannot** be set up as a [**Resident Key Manager**]({{base_path}}/install-and-setup/setup/distributed-deployment/configuring-wso2-identity-server-as-a-key-manager). It can only be set up as a [**Third-party Key Manager**]({{base_path}}/install-and-setup/setup/distributed-deployment/configure-a-third-party-key-manager).


Follow the steps given below to configure WSO2 IS 7.x as a Key Manager component.

## Step 1 - Configure WSO2 IS 7.x

1. Download and install [WSO2 Identity Server 7.x](https://wso2.com/identity-server/).
     
      If you downloaded the archive, extract it.
     `<IS7_HOME>` refers to the root folder of the extracted WSO2 IS 7.x.
   
      <div class="admonition tip">
      <p class="admonition-title">Tip</p>
      <p>Refer to the <a href="https://wso2.com/products/carbon/release-matrix/">Release Matrix</a> for compatible product versions.</p>
      </div>

2. Add following configurations in the `<IS7_HOME>/repository/conf/deployment.toml` file.

    ```toml
    [oauth]
    authorize_all_scopes = true

    [[resource.access_control]]
    context="(.*)/scim2/Me"
    secure=true
    http_method="GET"
    cross_tenant=true
    permissions=[]
    scopes=[]

    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1
    [event_listener.properties]
    notification_endpoint = "https://<APIM_HOST>:<APIM_PORT>/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "WSO2-IS"
    
    ```

    !!! Note
        **Before you begin:**

        You need to import the public certificate of the WSO2 Identity Server 7.x to the truststore of the WSO2 API Manager, and vice-versa. For information on importing the certificates, see the [Importing certificates to the truststore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore) guide.

3. Download [notification.event.handlers-2.0.5.jar](https://maven.wso2.org/nexus/content/repositories/releases/org/wso2/km/ext/wso2is/wso2is.notification.event.handlers/2.0.5/wso2is.notification.event.handlers-2.0.5.jar) and add it to `<IS_HOME>/repository/components/dropins`

4. Start WSO2 Identity Server 7.x with a port offset.
   portOffset is required only if you are running both API-M and IS 7.x in the same JVM.

      `sh wso2server.sh -DportOffset=1`

## Step 2 - Configure WSO2 API Manager

!!! Note
    Configuration values given in this section are based on the assumption that, WSO2 IS 7.x runs on the same JVM as WSO2 APIM, with a port offset of 1 (i.e: `localhost:9444`).

1. Start WSO2 API Manager.

      `<APIM_HOME>` refers to the root folder of the extracted WSO2 APIM.

2. Sign in to the Admin Portal. 
 
      `https://<hostname>:9443/admin`

      `https://localhost:9443/admin`

3. Click **Key Managers**.

4. Click **Add Key Manager** to add the configuration related to a new Key Manager.

5. Enter a **Name** and **Display Name**, and select **WSO2 Identity Server 7** as the **Key Manager Type**.

6. Under the **Key Manager Endpoints** section, provide the following values:

    !!! Note
        You can use `https://localhost:9444/oauth2/token/.well-known/openid-configuration` as the **Well-known URL**, and click on **Import** to populate most of the fields mentioned below, **Grant types**, and the **Certificates** section.

        !!! warning "Important"
            When importing configurations using the well-known URL, manually set the value of <strong>UserInfo Endpoint</strong> to <code>https://localhost:9444/scim2/Me</code>. The auto-import populates this field with <code>https://localhost:9444/oauth2/userInfo</code>.

    | Configuration                 | Value                                                                                                                                                                                                                                               |
    |-------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | Issuer                        | `https://localhost:9444/oauth2/token`                                                                                                                                                                                                               |
    | Client Registration Endpoint  | `https://localhost:9444/api/identity/oauth2/dcr/v1.1/register`                                                                                                                                                                                      |
    | Introspection Endpoint        | `https://localhost:9444/oauth2/introspect`                                                                                                                                                                                                          |
    | Token Endpoint                | `https://localhost:9444/oauth2/token`                                                                                                                                                                                                               |
    | Display Token Endpoint        | `https://localhost:9444/oauth2/token`                                                                                                                                                                                                               |
    | Revoke Endpoint               | `https://localhost:9444/oauth2/revoke`                                                                                                                                                                                                              |
    | Display Revoke Endpoint       | `https://localhost:9444/oauth2/revoke`                                                                                                                                                                                                              |
    | UserInfo Endpoint             | <ul><li>`https://localhost:9444/scim2/Me` or <li>`https://localhost:9444/keymanager-operations/user-info` (supported only from WSO2 API Manager 4.4.0.53 update level onwards). </ul> See [UserInfo Endpoint](#userinfo-endpoint) for more details. |
    | Authorize Endpoint            | `https://localhost:9444/oauth2/authorize`                                                                                                                                                                                                           |
    | Scope Management Endpoint     | `https://localhost:9444/api/identity/oauth2/v1.0/scopes`                                                                                                                                                                                            |

7. Under **Grant types**, provide all the following: `password`, `client_credentials`, `refresh_token`, `urn:ietf:params:oauth:grant-type:saml2-bearer`, `iwa:ntlm`, `urn:ietf:params:oauth:grant-type:device_code`, `authorization_code`, `urn:ietf:params:oauth:grant-type:jwt-bearer`, `urn:ietf:params:oauth:grant-type:token-exchange`.
8. Under **Certificates** section, select **JWKS**. Enter `https://localhost:9444/oauth2/jwks` as the **URL**. 
9. Under **Connector Configurations**, provide the following values:

    | Configuration                                           | Value                                                               |
    |---------------------------------------------------------|---------------------------------------------------------------------|
    | Username                                                | `admin`                                                             |
    | Password                                                | `admin`                                                             |
    | WSO2 Identity Server 7 API Resource Management Endpoint | `https://localhost:9444/api/server/v1/api-resources`                |
    | WSO2 Identity Server 7 Roles Endpoint                   | `https://localhost:9444/scim2/v2/Roles`                             |
    | Create roles in WSO2 Identity Server 7                  | Enable this if you need to create roles in WSO2 Identity Server 7.  |

!!! Note
    **Create roles in WSO2 Identity Server 7** option is supported only from WSO2 API Manager 4.4.0.5 update level onwards.

## Role Creation in WSO2 Identity Server 7.x

!!! Note
    Enabling role creation according to this convention is supported from WSO2 API Manager 4.4.0.5 and WSO2 Identity Server 7.0.0.81 update levels onwards.

By default, roles are **not** created in WSO2 Identity Server 7.x, and it is assumed that the roles will be manually created by the user in WSO2 Identity Server 7.x. 

You can enable role creation in WSO2 Identity Server 7.x by enabling the **Create roles in WSO2 Identity Server 7** option in the **Connector Configurations** section. 

The following property should be enabled in WSO2 Identity Server 7.x, to be able to create `system_primary_<roleName>` roles.

```toml
[role_mgt]
allow_system_prefix_for_role = true
```

When enabled, the following naming conventions are followed when creating/accessing roles in WSO2 IS 7.x, corresponding to the types of WSO2 APIM roles.

    | Type of role in WSO2 API Manager             | Naming convention in WSO2 IS 7.x                           |
    |----------------------------------------------|------------------------------------------------------------|
    | _PRIMARY_ roles (eg: `manager`)              | `system_primary_<roleName>` (eg: `system_primary_manager`) |
    | _Internal_ roles (eg: `Internal/publisher`)  | `<roleName>` (eg: `publisher`)                             |

    !!! Note
        **_Application_ roles** are not used.

## UserInfo Endpoint

The **UserInfo Endpoint** allows clients to verify the identity of the end-user based on the authentication performed by an authorization server, as well as to obtain basic profile information about the end-user. One of the following can be used as the **UserInfo Endpoint**:

!!! Note
    Using `https://localhost:9444/keymanager-operations/user-info` is supported from WSO2 API Manager 4.4.0.53 update level onwards.

- `https://localhost:9444/scim2/Me`
- `https://localhost:9444/keymanager-operations/user-info` - This should be used if WSO2 Identity Server 7.x is using a federated login for applications that are created by the WSO2 IS 7.x Key Manager, and the users are not stored in WSO2 IS 7.x. In order to use this, download the [`keymanager-operations.war`]({{base_path}}/assets/attachments/administer/wso2-is7-km/keymanager-operations.war) and place it in the `<IS7_HOME>/repository/deployment/server/webapps/` directory.