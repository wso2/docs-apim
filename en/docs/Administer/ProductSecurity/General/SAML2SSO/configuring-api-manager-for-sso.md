# Configuring API Manager for SSO

You can configure the API Manager for SAML SSO by following the instructions below.

-   [Step 1 - Configure the Carbon Console for SSO](#ConfiguringAPIManagerforSSO-Step1-ConfiguretheCarbonConsoleforSSO)
-   [Step 2 - Configure Publisher/Store for SSO](#ConfiguringAPIManagerforSSO-Step2-ConfigurePublisher/StoreforSSO)
-   [Step 3 - Configure the API Store for SSO in passive mode](#ConfiguringAPIManagerforSSO-Step3-ConfiguretheAPIStoreforSSOinpassivemode)
-   [Step 4 - Configure an Identity Provider](#ConfiguringAPIManagerforSSO-Step4-ConfigureanIdentityProvider)

### Step 1 - Configure the Carbon Console for SSO

!!! info
This step is done in order to have SSO between the API Manager's and Identitiy Server's management consoles.


Open the `         <API-M_HOME>/repository/conf/security/authenticators.xml        ` file and give the configurations as shown below.

-   Set `          disabled         ` attributes in the `          <Authenticator>         ` element to `          false         ` .
-   `           ServiceProviderID          ` : The issuer name of the service provider.

-   `           IdentityProviderSSOServiceURL          ` : The URL of the IDP. In this example, it is the URL of the Identity Server.

        !!! info
    A **Service Provider (SP)** is an entity that provides web services. A service provider relies on a trusted Identity Provider (IdP) for authentication and authorization. In this case, the Identity Server acts as the IdP and does the task of authenticating and authorizing the user of the service provider.

    For instructions on how you can configure WSO2 API Manager with IdPs, see [Step 4](#ConfiguringAPIManagerforSSO-Step4-ConfigureanIdentityProvider) .


``` java
    <Authenticator name="SAML2SSOAuthenticator" disabled="false">
            <Priority>10</Priority>
            <Config>
                <Parameter name="LoginPage">/carbon/admin/login.jsp</Parameter>
                <Parameter name="ServiceProviderID">carbonserver</Parameter>
                <Parameter name="IdentityProviderSSOServiceURL">https://localhost:9444/samlsso</Parameter>
                <Parameter name="NameIDPolicyFormat">urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</Parameter>
            </Config>
```

Make sure the `         <priority>        ` element of the `         SAML2SSOAuthenticator        ` is less than that of the `         BasicAuthenticator        ` handler. For more information see the [FAQ](https://docs.wso2.com/display/AM260/FAQ#FAQ-priority) .

!!! info
NameIDPolicyFormat

Service provider and Identity Provider usually communicate with each other about a subject. That subject should be identified through NAME-ID. It should be in some format so that it is easy for the other party to identify it based on the format. The possible values for the `         NameIDPolicyFormat        ` are as follows:

-   `          urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified [default]         `
-   `          urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress         `
-   `          urn:oasis:names:tc:SAML:2.0:nameid-format:persistent         `
-   `          urn:oasis:names:tc:SAML:2.0:nameid-format:transient         `

In this scenario use `         urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified,        ` which is the default `         NameIDPolicyFormat        ` . However, the value of the `         NameIDPolicyFormat        ` is totally based on the entities that you wish to implement. For more information on NameIdentifiers, refer to [section 8.3 in SAML Core](http://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf) .

!!! info
If there are many WSO2 products in your environment, you can configure SSO for the management consoles to gain one-time access to all of the consoles without repeated authentication. You can do this by changing the `         SAML2SSOAuthenticator        ` configuration in the `         <PRODUCT_HOME>/repository/conf/security/authenticators.xml        ` file as shown above.


### Step 2 - Configure Publisher/Store for SSO

To configure SSO for the API Publisher, open the `         <API-M_HOME>/repository/deployment/server/jaggeryapps/publisher/site/conf/site.json        ` file and give the configurations as shown below.

!!! note
Note that following parameters should be matched with the Service Provider configurations of Identity Server that you are configuring.


``` java
    ssoConfiguration" : {
            "enabled" : "true",
            "issuer" : "API_PUBLISHER",
            "identityProviderURL" : "https://localhost:9444/samlsso",
            "keyStorePassword" : "",
            "identityAlias" : "wso2carbon",
            "verifyAssertionValidityPeriod":"true",
            "timestampSkewInSeconds":"300",
            "audienceRestrictionsEnabled":"true",
            "responseSigningEnabled":"true",
            "assertionSigningEnabled":"true",
            "keyStoreName" :"",
            "signRequests" : "true",
            "assertionEncryptionEnabled" : "false",
            "idpInit" : "false",
            "idpInitSSOURL" : "https://localhost:9444/samlsso?spEntityID=API_PUBLISHER",
    }
```

| Parameter           | Description                                                                                                                                                                                                                                                                                                                                                                      |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| enabled             | Set this value to **true** to enable SSO in the application.                                                                                                                                                                                                                                                                                                                     |
| issuer              | `             API_PUBLISHER            ` . This value can change depending on the **Issuer** value defined in WSO2 IS SSO configuration above.                                                                                                                                                                                                                                   |
| identityProviderURL | **** <https://localhost:9444/samlsso> . Change the IP and port accordingly. This is the redirecting SSO URL in your running WSO2 IS server instance.                                                                                                                                                                                                                             |
| keyStoreName        | The keystore of the running IDP. As you use a remote instance of WSO2 IS here, you can import the public certificate of the IS keystore to the APIM and then point to the APIM keystore. The default keystore of the APIM is `             <API-M_HOME>/repository/resources/security/wso2carbon.jks            ` . ****Be sure to give the full path of the keystore here** .** |
| keyStorePassword    | Password for the above keystore. The default keyStorePassword is `             wso2carbon            ` .                                                                                                                                                                                                                                                                         |
| identityAlias       | wso2carbon                                                                                                                                                                                                                                                                                                                                                                       |

!!! note
By default, in the ssoConfiguration in site.json described above signRequests parameter decide whether to sign the AuthRequest or not. We have enabled it by setting the value **true** in default configuration so that, all the AuthRequests passing will be signed.


The `         identityAlias        ` parameter is set to `         wso2carbon        ` in the above example. You can configure an external server by [importing the certificate](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores#CreatingNewKeystores-Step3:Importingcertificatestothetruststore) of the IdP to APIM, and changing the `         identityAlias        ` parameter value according to the certificate. To configure an IDP initiated SSO, you have to include the following additional parameters in the `         ssoConfiguration        ` section.

``` java
    ...
        "idpInit" : "true",
        "idpInitSSOURL" : "https://localhost:9444/samlsso?spEntityID=API_PUBLISHER",
        "externalLogoutPage" : "https://localhost:9444/samlsso?slo=true"
    ...
```

To configure SSO for the API Store, open the `         <API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/site.json        ` file and change the `         ssoConfiguration        ` section similarly. This allows users to gain access to the Store applications directly, if they are authenticated against the Publisher.

!!! tip
`                   idpInitSSOURL                 ` consists of `         <SAML2.IdPURL>        ` and `         <SAML2.SPEntityId>        ` .

| Properties                                                                                                                                  | Description                                                        |
|---------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| `             SAML2.IdPURL=                                          https://localhost:9443/samlsso                                       ` | The URL of the SAML 2.0 Identity Provider                          |
| `             SAML2.SPEntityId=API_PUBLISHER            `                                                                                   | A unique identifier for this SAML 2.0 Service Provider application |

The `         SAML2.SPEntityId        ` should be the value of issuer you specify under `         ssoConfiguration        ` in the `         <API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/site.json        ` , which uniquely identifies your SAML identity provider. Therefore, it differes between the Store and Publisher according to the issuer that you configure.


### Step 3 - Configure the API Store for SSO in passive mode

If the passive mode is disabled and Single Sign-On (SSO) is enabled, it redirects the user to the SSO login page. Therefore, as the WSO2 API Store allows anonymous access, passive mode is enabled by default, so that irrespective of whether SSO is enabled or not it directs the user to the API Store URL, and enables the SSO work flow only when the **Sign In** button is clicked.

To disable the passive mode, set the property named `         passive        ` to false in the `         <API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/site.json        ` file.

``` java
    "ssoConfiguration" : {
            ...
            "passive" : "false",
            ...
        },
```

!!! note
By enabling passive mode in SSO Configuration, WSO2 API Manager enables **Passive Authentication** on Single Sign On.

!!! info
From the two fundamental authetication models which are active and passive, **active authentication** is based on WS-Trust protocol on which a relying party is resposible of issuing the security token associated with the user credentials. But in **passive authentication** which is based on SAML 2.0 and WS-Federation protocols, the relying party does not control the login logic and relies on the IdP to issue the credentials.


### Step 4 - Configure an Identity Provider

-   [**Configuring WSO2 IS**](#4837221e10ef46ecaec67d4931bc6d18)
-   [**Configuring an external IdP**](#c3ee61ec2a8642bc99ba3c5de4908e99)

You can configure WSO2 Identity Server as the IdP. For instructions on how to configure, see [Configuring Identity Server as IdP for SSO](_Configuring_Identity_Server_as_IDP_for_SSO_) .

You can also opt to configure an external identity provider. For instructions on how to configure, see [Configuring External IdP through Identity Server for SSO](_Configuring_External_IDP_through_Identity_Server_for_SSO_) .
