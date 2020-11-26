
In the following document we will be explaining how to federate the OAuth applications using an external indentity provider.

### Pre-requisites
1. Using the latest API-Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/)
2. Have an external IDP already configured. You can follow our [SSO Documentation]({{base_path}}/install-and-setup/setup/sso/okta-as-an-external-idp-using-oidc) to setup okta as an external IDP

### Configuration

1. Go to ```<APIM_HOME>/repository/conf/identity/service-providers/``` and open ```default.xml```
2.  Comment out or remove the the ```<LocalAuthenticatorConfigs ...``` section and add the following. 
    ```xml
        <FederatedIdentityProviders>
            <IdentityProvider>
                <!-- Name of the external IDP -->
                <IdentityProviderName>okta</IdentityProviderName>
                <IsEnabled>true</IsEnabled>
                <DefaultAuthenticatorConfig>
                    <FederatedAuthenticatorConfig>
                        <Name>OpenIDConnectAuthenticator</Name>
                        <IsEnabled>true</IsEnabled>
                    </FederatedAuthenticatorConfig>
                </DefaultAuthenticatorConfig>
            </IdentityProvider>
        </FederatedIdentityProviders>
    ```   

    !!!note
        You can replace the FederatedAuthenticatorConfig name with your corresponding authenticator type of your IDP

        <table>
            <colgroup>
                <col />
                <col />
                <col />
            </colgroup>
            <tbody>
                <tr>
                    <th colspan="2">Authenticator type</th>
                    <th>Config name</th>
                </tr>
                <tr>
                    <td colspan="2" class="confluenceTd">OpenId Connect</td>
                    <td class="confluenceTd">OpenIDConnectAuthenticator</td>
                </tr>
                <tr>
                    <td colspan="2" class="confluenceTd">SAML</td>
                    <td class="confluenceTd">SAMLSSOAuthenticator</td>
                </tr>
            </tbody>
        </table>         

3. Now for the OAuth applications created using the Developer Portal, the above external IDP will be used to generate the access token.
