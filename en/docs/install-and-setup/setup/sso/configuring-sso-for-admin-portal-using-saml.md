# Configuring SSO for Admin Portal using SAML

This document explains how to connect WSO2 Identity Server as a third party Identity provier to WSO2 API-Manager using SAML 2.0. Using this feature, you can configure SSO with SAML 2.0 for Admin Portal.

## Pre-requisites

-   Download the API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).

-   Download the Identity Server distirbution from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Info
        To use WSO2 IS as the Key Manager, download the **WSO2 Identity Server 5.10.0 as a Key Manager** pack, with pre-packaged Key Manager features as follows:

        1. Access the [previous WSO2 API Manager related releases](https://wso2.com/api-management/previous-releases/).
        2. Select version 3.1.0.
        3. Click on the Identity Server as a Key Manager download option.

## Configure the userstore

1. Configure the user store(s) (if you have not done so already).

    Follow the instructions in [Configuring User Stores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/introduction-to-userstores/).

    In this document, we will use JDBC userstore (MySQL) and share it between Identity Server and API Manager.

    1.  Create a MySQL database (e.g., user_db) and run the <API-M_HOME>/dbscripts/mysql.sql script on it to create the required tables. 

    2.  Change the userstore type as **database_unique_id** in Identiy Server by adding the following configuration in deployment.toml file resides in `<IS-Home>/repository/conf` directoy.

        ``` toml
        [user_store]
        type = "database_unique_id"
        ```

    3.  Configure the primary userstore by adding the following configuration in deployment.toml.

        ``` toml
        [database.user]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/user_db"
        username = "${username}"
        password = "${password}"
        ```

    4.  Share the userstore with API Manager by adding the same configuration (given in step-c) in deployment.toml file resides in `<APIM-Home>/repository/conf` directory.

    5.  Copy the JDBC driver JAR file into the <PRODUCT_HOME>/repository/components/lib directory of both servers.

    6.  Start the servers using the following commands:

        ``` tab="On Windows"
        wso2server.bat --run
        ```

        ``` tab="On Linux/Mac OS"
        sh wso2server.sh
        ```

## Configure the Identity Server

### Configure the Service Provider

1.  Login to the Management Console of IS server by browsing the following URL:  

    ```
    https://{is-ip}:9444/carbon
    ```

2.  Navigate to the **Service Providers** section under Main → Identity and create new Service Provider.

3.  Edit the created Service Provider:

    1.  Expand the **Inbound Authentication Configuration** secition and configure **SAML2 Web SSO Configuration** by providing the following information:

        <table>
        <tbody>
            <tr>
                <td>Issuer</td>
                <td>Specify the Issuer</td>
            </tr>
            <tr>
                <td>Assertion Consumer URLs</td>
                <td>`https://{apim-ip}:9443/admin/jagg/jaggery_acs.jag`</td>
            </tr>
            <tr>
                <td>Response Signing Algorithm</td>
                <td>`http://www.w3.org/2001/04/xmldsig-more#rsa-sha256`</td>
            </tr>
            <tr>
                <td>Enable Response Signing</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Enable Signature Validation in Authentication Requests and Logout Requests</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Enable Single Logout</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Enable Attribute Profile</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Include Attributes in the Response Always</td>
                <td>true</td>
            </tr>
        </tbody>
        </table>

        Following image shows the sample values for SAML2 Web SSO Configuration:

        [![saml-configuration-in-service-provider]({{base_path}}/assets/img/setup-and-install/saml-configuration-in-service-provider.png)]({{base_path}}/assets/img/setup-and-install/saml-configuration-in-service-provider.png)

        !!! Info "In Mutl-tenanted environments"
            Carry out the instruction given below for all the tenants to be able to login to the Admin portal in a multi-tenanted environment.

            1.  Click the **SaaS Application** option that appears after registering the service provider.

            [![saas-configuration-in-service-provider]({{base_path}}/assets/img/setup-and-install/saas.png)]({{base_path}}/assets/img/setup-and-install/saas.png)            

            If you do not select the **SaaS Application** option, only users in the current tenant domain will be allowed to login to the portal. You will need to register separate service providers for portals from each tenant.

    2.  Register the Service Provider.

    ??? Info "Enable a tenant-specific SSO for the Publisher and Developer Portal"

        To enable a tenant-specific SSO with IS 5.10.0, enable the **Use tenant domain in local subject identifier** option under the **Local & Outbound Authentication Configuration** section.

        [![enable-tenant-domain-in-local-sub-identifier]({{base_path}}/assets/img/setup-and-install/enable-tenant-domain-in-local-sub-identifier.png)]({{base_path}}/assets/img/setup-and-install/enable-tenant-domain-in-local-sub-identifier.png)

4.  Upload the public certificate of the API Manager by selecting **Select SP Certificate Type**.

    [![upload-certificate-in-SP-for-saml2-sso.png]({{base_path}}/assets/img/setup-and-install/upload-certificate-in-SP-for-saml2-sso.png)]({{base_path}}/assets/img/setup-and-install/upload-certificate-in-SP-for-saml2-sso.png)

## Configure the API Manager

### Configure the Admin Portal as SAML 2.0 SSO Service Provider

- Open the site.json resides in `<API-M_Home>/repository/deployment/server/jaggeryapps/admin/site/conf` directory and modify the following configurations found under **ssoConfiguration**.

    <table>
        <tbody>
            <tr>
                <td>enabled</td>
                <td>Set this value to true to enable SSO for Admin app</td>
            </tr>
            <tr>
                <td>issuer</td>
                <td>Specify the issuer value.It depends on the Issuer value defined in Service Provider created in Identity Server</td>
            </tr>
            <tr>
                <td>identityProviderURL</td>
                <td>`https://{is-ip}:9444/samlsso`</td>
            </tr>
            <tr>
                <td>keyStoreName</td>
                <td>The keystore of the running IDP. As you use a remote instance of WSO2 IS here, you can import the public certificate of the IS keystore to the APIM and then point to the APIM keystore</td>
            </tr>
            <tr>
                <td>keyStorePassword</td>
                <td>Password for the above keystore</td>
            </tr>
            <tr>
                <td>identityAlias</td>
                <td>alias given to the Identity Server's certificate. Default alias is `wso2carbon`</td>
            </tr>
        </tbody>
    </table>

    !!! Info 
        To configure an IDP initiated SSO, you have to include the following additional parameters in the ssoConfiguration section.
        <table>
        <tbody>
            <tr>
                <td>idpInit</td>
                <td>true</td>
            </tr>
            <tr>
                <td>idpInitSSOURL</td>
                <td>https://{is-ip}:9444/samlsso?spEntityID=${service-provider-name}</td>
            </tr>
            <tr>
                <td>externalLogoutPage</td>
                <td>`https://{is-ip}:9444/samlsso?slo=true`</td>
            </tr>
        </tbody>
        </table>

    Sample configuration is given below:

    ``` json
    "ssoConfiguration": {
        "enabled": "true",
        "issuer": "apim",
        "identityProviderURL": "https://localhost:9444/samlsso",
        "keyStorePassword": "xxxxxxxx",
        "identityAlias": "wso2carbon",
        "keyStoreName": "wso2carbon.jks",
        "verifyAssertionValidityPeriod": "true",
        "audienceRestrictionsEnabled": "true",
        "responseSigningEnabled": "true",
        "assertionSigningEnabled": "true",
        "assertionEncryptionEnabled": "false",
        "signRequests" : "true",
        "idpInit" : "false",
        "idpInitSSOURL" : "https://localhost:9444/samlsso?spEntityID=apim",
        "externalLogoutPage" : "https://localhost:9444/samlsso?slo=true",
        "loginUserNameAttribute" : ""
    } 
    ```

!!! Attention
    Even with SSO enabled, if the user doesn't have sufficient privileges to access Admin portal, s/he will not be authorized to access them.

!!! Info
        To learn more about Single Sign-On with WSO2 Identity Server, see [SAML 2.0 Web SSO](https://is.docs.wso2.com/en/5.10.0/learn/saml-2.0-web-sso/) in the WSO2 Identity Server documentation.
