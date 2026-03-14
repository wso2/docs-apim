# Configure Asgardeo as a Key Manager

WSO2 API Manager supports multiple Key Managers at the same time. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager, and with the use of connectors, it is capable of supporting any authorization server as a Key Manager.  

WSO2 API Manager can connect Asgardeo by WSO2 out-of-the-box using the [WSO2 API-M Asgardeo Connector](https://github.com/wso2-extensions/apim-km-asgardeo).  

Follow the instructions given below to configure Asgardeo as a third-party Key Manager:

## Step 1 - Configure Asgardeo

1. Log into the [Asgardeo Console](https://console.asgardeo.io) and create or select the **organization** you want to use with WSO2 API Manager.

2. Create an OAuth Application that will act as the management client for WSO2 API Manager. 

    1. Navigate to **Applications** → **`+ New Application`**

        ![asgardeo new application]({{base_path}}/assets/img/administer/asgardeo-newapplication.png)

    2. **Create** a **Standard-Based Application** with the following Name and Protocol.

        | Name               | Protocol                   |
        |--------------------|----------------------------|
        | APIM-Management-App | OAuth 2.0 + OpenID Connect |

        ![asgardeo select application]({{base_path}}/assets/img/administer/asgardeo-select-application.png)

        ![asgardeo application details]({{base_path}}/assets/img/administer/asgardeo-application-details.png)

    3. In the page that follows, make note of the **Client ID** and **Client secret** found under **Protocol**.

        ![asgardeo note client id secret]({{base_path}}/assets/img/administer/asgardeo-protocol-id-secret.png) 

3. Authorize the Management OAuth Application to use the required Management APIs.

    1. Navigate to  **API Authorization** → **`+ Authorize API resource`** in the created application.

        ![asgardeo application api authorization]({{base_path}}/assets/img/administer/asgardeo-application-api-authorization.png)

    2. In the popped-up window, select the Management API **`OAuth DCR API`** as the **API Resource**, **`Select All`** for **Authorized Scopes**, and click on **Finish**.  

        ![asgardeo authorize dcr api]({{base_path}}/assets/img/administer/asgardeo-authorize-dcr-api.png)

        !!! note
            If the required API Resource doesn't appear, please allow a few moments for the API Resources list to finish loading. Reload the page if the issue persists.   

        !!! note
            Ensure you have authorized the **Management API** version of the API Resource. It is a common mistake to authorize the **Organization API** version instead.  

    3. Repeat the previous step for the following Management APIs:  
        - **API Resource Management API** 
        - **SCIM2 Roles V1/V2 API**

4. Create an API Resource that serves as a global container for the scopes defined in WSO2 API Manager.
    1. Navigate to **Resources** → **API Resources** → **`+ New API Resource`**

        ![asgardeo new api resource]({{base_path}}/assets/img/administer/asgardeo-new-api-resource.png)

    2. Enter a unique **Identifier** and **Display Name** (Example shown below). Click on **Next**.

        | Identifier                    | Display Name               |
        |-------------------------------|----------------------------|
        | /api/server/v1/scope-resource | APIM_GLOBAL_SCOPES         |

        ![asgardeo create api resource]({{base_path}}/assets/img/administer/asgardeo-create-api-resource.png)
    
    3. On the **Scopes** page that appears next, click **Next**. No scopes need to be added. 

    4. On the **Authorization** page that appears next, click on **Create** ensuring that **Requires authorization** is enabled. 

        ![asgardeo authorize api resource]({{base_path}}/assets/img/administer/asgardeo-authorize-api-resource.png)

## Step 2 - Configure WSO2 API Manager

1. Start **WSO2 API Manager** and log in to the **Admin Portal**.  
    `https://<APIM_HOST>/admin`

2. Add Asgardeo as a Key Manager
    1. Navigate to **Key Managers** → **`Add Key Manager`**.

        ![asgardeo new key manager]({{base_path}}/assets/img/administer/asgardeo-new-key-manager.png)

    2. Under **General Details** and **Key Manager Type**, provide the following:
        - **Name**: A unique name for the Key Manager (e.g., AsgardeoKM)
        - **Display Name**: A user-friendly name (e.g., Asgardeo)
        - **Key Manager Type**: Asgardeo

        ![asgardeo general details]({{base_path}}/assets/img/administer/asgardeo-general-details.png)

    3. Under **Key Manager Endpoints**,
        - Provide the **Well-Known URL**:  
            `https://api.asgardeo.io/t/{ORGANIZATION-NAME}/oauth2/token/.well-known/openid-configuration`
        - Click on the **Import** button to populate the endpoint fields automatically
        - Manually provide **Scope Management Endpoint**: none

        ![asgardeo endpoint details]({{base_path}}/assets/img/administer/asgardeo-endpoint-details.png)

    4. Under **Grant Types**, review the auto-populated list and remove any grant types you do not wish to support.

    5. Under **Certificates**, ensure **JWKS** is selected and `https://api.asgardeo.io/t/{ORGANIZATION-NAME}/oauth2/jwks` has been set as the **URL**

    6. Under **Connector Configurations**, provide the following:

        | Configuration                               | Value                                                                 |
        |---------------------------------------------|-----------------------------------------------------------------------|
        | Organization                                | Your chosen organization name                                         |
        | Client ID                                   | Noted Client ID in Step 1 - 2c                                        |
        | Client Secret                               | Noted Client secret in Step 1 - 2c                                    |
        | Global Scopes API Resource Name             | Display Name of Global Scopes API Resource in Step 1 - 4b             |
        | Asgardeo API Resource Management Endpoint   | `https://api.asgardeo.io/t/{ORGANIZATION-NAME}/api/server/v1/api-resources` |
        | Asgardeo Roles Endpoint                     | `https://api.asgardeo.io/t/{ORGANIZATION-NAME}/scim2/v2/Roles`        |


    7. Click **Add** to save the Key Manager.

## Role Creation in Asgardeo

By default, roles are **not** created in Asgardeo, and it is assumed that the roles will be manually created by the user in Asgardeo. 

You can enable automatic role creation in Asgardeo by enabling the **Create roles in Asgardeo** option in the **Connector Configurations** section. 

When enabled, the following naming conventions are followed when creating/accessing roles in  Asgardeo, corresponding to the types of WSO2 API Manager roles.

| Type of role in WSO2 API Manager             | Naming convention in Asgardeo                              |
|----------------------------------------------|------------------------------------------------------------|
| _PRIMARY_ roles (eg: `manager`)              | `apim_primary_<roleName>` (eg: `apim_primary_manager`) |
| _Internal_ roles (eg: `Internal/publisher`)  | `<roleName>` (eg: `publisher`)                             |

!!! Note
    **_Application_ roles** are not used.
 

## Requesting and Using Scopes with Asgardeo

This section explains how **OAuth scopes** are created, authorized, and finally requested when using **Asgardeo as the Key Manager** in WSO2 API Manager.

The process involves **three roles**:  

- API Publisher (creates scopes)
- Asgardeo Administrator (authorizes scopes)
- Application Developer (requests tokens with scopes)

### Step 1: Create and Assign Scopes in the Publisher Portal
The scopes required in the API must be mirrored in Asgardeo. The following steps must be completed by the **API Publisher**.

1. Log in to the **Publisher Portal**: `https://<APIM_HOST>/publisher`

2. Open the API that requires scope-based access control.

3. Create a new **Scope** (or skip this step and select an existing one)

4. Assign the scope to the required API resource:
    1. Navigate to the **Resources** section of the API
    2. Add the scope to the required resource.
    3. Save the API

Saving the API triggers WSO2 API Manager to propagate the scope to Asgardeo.  

!!! Note
    The **Resources** section of an **API** is equivalent to the **Tools** section of an **MCP Server**. The steps to create and assign scopes to a tool of an MCP Server are similar to the steps mentioned above.

!!! warning
    Ensure that no scope name begins with the word `internal`. For example, `internal_order_management` is not permitted. Asgardeo does not allow user-defined scope names with this prefix.

### Step 2: Authorize Scopes in Asgardeo

Scopes must be explicitly authorized by an Asgardeo Admin for the OAuth application that will request them. The following steps must be completed by an **Asgardeo Administrator**.

1.  Log in to the **[Asgardeo Console](https://console.asgardeo.io)** as an admin.

2.  Navigate to **Applications** and open the OAuth application that will request scopes.

3.  Navigate to the **API Authorization** tab, click on **`+ Add API Resource`** and authorize the **global API resource** named `APIM_GLOBAL_SCOPES`.

4.  Select (allow) the specific scopes that the application should be permitted to request

5.  Save the changes.

Only scopes **explicitly allowed** here can be requested in access token requests.

---

### Step 3: Request Access Tokens with Scopes

Once scopes are authorized, the application developer can request access tokens. These steps can be completed by the **Application Developer**

1. Use the OAuth application credentials to request a token. This can be done the Developer Portal or using a cURL command as shown in the Developer Portal.
2. Include the required scopes in the request. 

If the scope is authorized, Asgardeo issues an access token containing the requested scope




