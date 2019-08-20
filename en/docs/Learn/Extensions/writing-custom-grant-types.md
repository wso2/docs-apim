# Writing Custom Grant Types

OAuth 2.0 authorization servers provide support for four main grant types according to the OAuth 2.0 specification. They also allow you to add custom grant types and extend the existing ones.

See [Writing a Custom OAuth 2.0 Grant Type](https://docs.wso2.com/display/IS560/Writing+a+Custom+OAuth+2.0+Grant+Type) in the WSO2 identity Server documentation to implement custom grant types for the API Manager. Note that API Manager has already customized the Grant Type handlers for `         authorization_code        ` , `         password        ` , `         client_credentials        ` and `         saml2-bearer        ` grant types. If you require any additional functionality for these grant types, its advisable to extend the following grant handler implementations.

| Grant Type                                                               | Existing Handler Class (which can be extended if required)                                              |
|--------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| `             authorization_code            `                            | `             org.wso2.carbon.apimgt.keymgt.handlers.ExtendedAuthorizationCodeGrantHandler            ` |
| `             password            `                                      | `             org.wso2.carbon.apimgt.keymgt.handlers.ExtendedPasswordGrantHandler            `          |
| `             client_credentials            `                            | `             org.wso2.carbon.apimgt.keymgt.handlers.ExtendedClientCredentialsGrantHandler            ` |
| `             urn:ietf:params:oauth:grant-type:saml2-bearer            ` | `             org.wso2.carbon.apimgt.keymgt.handlers.ExtendedSAML2BearerGrantHandler            `       |

!!! tip
**A re you using WSO2 Identity Server as the Key Manager?** If so, be sure to follow the this compatibility matrix.

![](images/icons/grey_arrow_down.png){.expand-control-image} Click here to see the compatibility matrix.

The compatibility matrix with regard to WSO2 API Manager (WSO2 API-M) and WSO2 Identity Server Key Manager ( WSO2 IS-KM ) product distribution is as follows:

![](images/icons/grey_arrow_down.png){.expand-control-image} What is referred to as the prepackaged WSO2 Identity Server as a Key Manager?

!!! info
The **prepackaged WSO2 Identity Server as a Key Manager 5.7.0** comes with the necessary configurations already installed in order to connect WSO2 Identity Server as the Key Manager for WSO2 API Manager, and is therefore different to the default version (vanilla pack) of WSO2 Identity Server 5.7.0. The prepackaged WSO2 Identity Server as a Key Manager 5.7.0 is compatible with WSO2 API Manager 2.6.0 and is supported by [WUM](https://wso2.com/updates) .

<table>
<thead>
<tr class="header">
<th>WSO2 API-M</th>
<th>WSO2 IS-KM</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>API-M 2.6.0 GA</td>
<td><p>GA or WUM update for WSO2 IS-KM-5.7.0</p></td>
<td><br />
</td>
</tr>
<tr class="even">
<td>API-M-2.6.0 WUM update</td>
<td><p>GA or WUM update for WSO2 IS-KM-5.7.0</p></td>
<td><br />
</td>
</tr>
<tr class="odd">
<td>APIM-2.6.0-update-X</td>
<td>-</td>
<td>APIM-2.6.0-update-X (e.g., WSO2 APIM-2.6.0-update-1) releases are <strong>not compatible</strong> with the GA or WUM updates that are available for WSO2 IS-KM.</td>
</tr>
</tbody>
</table>


