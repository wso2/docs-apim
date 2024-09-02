# Configure WSO2 IS 7.x as a Key Manager

WSO2 API Manager supports multiple Key Managers. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager, and it has the inbuilt capability of configuring **WSO2 Identity Server 7.x** (WSO2 IS 7.x) as a Key Manager.

!!! info
    This document provides instructions on configuring **WSO2 Identity Server 7.x** as a Key Manager. If you are using an older version of WSO2 Identity Server, see [Configure WSO2 IS as a Key Manager]({{base_path}}/administer/key-managers/configure-wso2is-connector).

!!! Note
    **Role Based Authorization** based on the [WSO2 Identity Server 7 Role Based Authorization model](https://is.docs.wso2.com/en/7.0.0/guides/authorization/api-authorization/api-authorization/) is supported from following U2 update levels onwards:

    - WSO2 API Manager 4.3.0.23.

    - WSO2 Identity Server 7.0.0.65.

## Limitations of using WSO2 IS 7.x as a Key Manager

Data models of WSO2 API Manager 4.3.0 and WSO2 Identity Server 7.x are different. Therefore, when using WSO2 API Manager 4.3.0 with WSO2 Identity Server 7.x as the key manager,

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
    ```

    !!! Note
        **Before you begin:**

        You need to import the public certificate of the WSO2 Identity Server 7.x to the truststore of the WSO2 API Manager, and vice-versa. For information on importing the certificates, see the [Importing certificates to the truststore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore) guide.

3. Start WSO2 Identity Server 7.x with a port offset.
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

    | Configuration | Value |
    | --- | --- |
    | Issuer | `https://localhost:9444/oauth2/token` |
    | Client Registration Endpoint | `https://localhost:9444/api/identity/oauth2/dcr/v1.1/register` |
    | Introspection Endpoint | `https://localhost:9444/oauth2/introspect` |
    | Token Endpoint | `https://localhost:9444/oauth2/token` |
    | Display Token Endpoint | `https://localhost:9444/oauth2/token` |
    | Revoke Endpoint | `https://localhost:9444/oauth2/revoke` |
    | Display Revoke Endpoint | `https://localhost:9444/oauth2/revoke` |
    | UserInfo Endpoint | `https://localhost:9444/scim2/Me` |
    | Authorize Endpoint | `https://localhost:9444/scim2/Me` |
    | Scope Management Endpoint | `https://localhost:9444/api/identity/oauth2/v1.0/scopes` |

7. Under **Grant types**, provide all the following: `password`, `client_credentials`, `refresh_token`, `urn:ietf:params:oauth:grant-type:saml2-bearer`, `iwa:ntlm`, `urn:ietf:params:oauth:grant-type:device_code`, `authorization_code`, `urn:ietf:params:oauth:grant-type:jwt-bearer`, `urn:ietf:params:oauth:grant-type:token-exchange`.
8. Under **Certificates** section, select **JWKS**. Enter `https://localhost:9444/oauth2/jwks` as the **URL**. 
9. Under **Connector Configurations**, provide the following values:

    !!! Note
        The **WSO2 Identity Server 7 API Resource Management Endpoint** and **WSO2 Identity Server 7 Roles Endpoint** configurations that are used for Role Based Authorization with WSO2 Identity Server 7.x, are only available after WSO2 APIM 4.3.0 U2 update level 23.

    | Configuration                                           | Value                                                |
    |---------------------------------------------------------|------------------------------------------------------|
    | Username                                                | `admin`                                              |
    | Password                                                | `admin`                                              |
    | WSO2 Identity Server 7 API Resource Management Endpoint | `https://localhost:9444/api/server/v1/api-resources` |
    | WSO2 Identity Server 7 Roles Endpoint                   | `https://localhost:9444/scim2/v2/Roles`              |

