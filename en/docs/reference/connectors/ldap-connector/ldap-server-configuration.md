# LDAP Connector Reference

To use the LDAP connector, add the `<ldap.init>` element in your configuration before carrying out any other LDAP operations. 

??? note "ldap.init"
    The ldap.init operation initializes the connector to interact with an LDAP.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>providerUrl</td>
            <td>The URL of the LDAP server.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>securityPrincipal</td>
            <td>The Distinguished Name (DN) of the admin of the LDAP Server.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>securityCredentials</td>
            <td>The password of the LDAP admin.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>secureConnection</td>
            <td>The boolean value for the secure connection.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>disableSSLCertificateChecking</td>
            <td>The boolean value to check whether the certificate is enabled or not.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    ```xml
    <ldap.init>
        <providerUrl>{$ctx:providerUrl}</providerUrl>
        <securityPrincipal>{$ctx:securityPrincipal}</securityPrincipal>
        <securityCredentials>{$ctx:securityCredentials}</securityCredentials>
        <secureConnection>{$ctx:secureConnection}</secureConnection>
        <disableSSLCertificateChecking>{$ctx:disableSSLCertificateChecking}</disableSSLCertificateChecking>
    </ldap.init>
    ```


You can follow the steps below to import your LDAP certificate into wso2ei client’s keystore as follows:

1. To encrypt the connections, you need to configure a certificate authority (https://www.digitalocean.com/community/tutorials/how-to-encrypt-openldap-connections-using-starttls) 
and use it to sign the keys for the LDAP server.
2. Use the following command to import the certificate into the EI client keystore. 
   ```bash
   keytool -importcert -file <certificate file> -keystore <EI>/repository/resources/security/client-truststore.jks -alias "LDAP"
   ```
3. Restart the server and deploy the LDAP configuration.

**Ensuring secure data**

Secure Vault is supported for encrypting passwords. See, 
[Working with Passwords](https://docs.wso2.com/display/ADMIN44x/Encrypting+Passwords+with+Cipher+Tool) on integrating 
and using Secure Vault.

**Re-using LDAP configurations**

You can save the LDAP configuration as a [local entry]({{base_path}}/integrate/develop/creating-artifacts/registry/creating-local-registry-entries) and then easily reference it with the configKey attribute in your operations. For example, if you saved the above **<ldap.init>** entry as a local entry named MyLDAPConfig, you could reference it from an operation like addEntry as follows:

```xml
<ldap.addEntry configKey="MyLDAPConfig"/>
```

---

### User authentication

??? note "authenticate"
    LDAP authentication is a major requirement in most LDAP based applications. The  authenticate operation simplifies the LDAP authentication mechanism. This operation authenticates the provided Distinguished Name(DN) and password against the LDAP server, and returns either a success or failure response depending on whether the authentication was successful or not.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>dn</td>
            <td>The distinguished name of the user.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>password</td>
            <td>The password of the user.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <ldap.authenticate>
        <dn>{$ctx:dn}</dn>
        <password>{$ctx:password}</password>
    </ldap.authenticate>
    ```
    
    **Sample request**

    ```json
    {
        "providerUrl":"ldap://localhost:10389/",
        "securityPrincipal":"cn=admin,dc=wso2,dc=com",
        "securityCredentials":"comadmin",
        "secureConnection":"false",
        "disableSSLCertificateChecking":"false",
        "application": "ldap",
        "operation":"authenticate",
        "content":{
            "dn":"uid=testDim20,ou=staff,dc=wso2,dc=com",
            "password":"12345"
        }
    }
    ```

    **Authentication success response**

    ```xml
    <Response xmlns="http://localhost/services/ldap">
        <result>
            <message>Success</message>
        </result>
    </Response>
    ```

    **Authentication failure response**

    ```xml
    <Response xmlns="http://localhost/services/ldap">
        <result>
            <message>Fail</message>
        </result>
    </Response>
    ```

    **Error codes**
    
    This section describes the connector error codes and their meanings.

    | Error Code  | Description |
    | ------------- | ------------- |
    | 7000001 | An error occurred while searching a LDAP entry.    |
    | 7000002 | LDAP root user's credentials are invalid.    |
    | 7000003 | An error occurred while adding a new LDAP entry.    |
    | 7000004 | An error occurred while updating an existing LDAP entry.    |
    | 7000005 | An error occurred while deleting a LDAP entry.    |
    | 7000006 | The LDAP entry that is required to perform the operation does not exist.    |

    **Sample error response**

    ```xml
    <Fault xmlns="http://localhost/services/ldap">
        <error>
            <errorCode>700000X</errorCode>
            <errorMessage>Error Message</errorMessage>
        </error>
    </Fault>
    ```

### CRUD operations

??? note "addEntry"
    The addEntry operation creates a new LDAP entry in the LDAP server.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>objectClass</td>
            <td>The object class of the new entry.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>dn</td>
            <td>The distinguished name of the new entry. This should be a unique DN that does not already exist in the LDAP server.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>attributes</td>
            <td>The other attributes of the entry other than the DN. These attributes should be specified as comma separated key-value pairs.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <ldap.addEntry>
        <objectClass>{$ctx:objectClass}</objectClass>
        <dn>{$ctx:dn}</dn>
        <attributes>{$ctx:attributes}</attributes>
    </ldap.addEntry>
    ```
    
    **Sample request**

    ```json
    {
        "providerUrl":"ldap://localhost:10389/",
        "securityPrincipal":"cn=admin,dc=wso2,dc=com",
        "securityCredentials":"comadmin",
        "secureConnection":"false",
        "disableSSLCertificateChecking":"false",
        "application":"ldap",
        "operation":"createEntity",
        "content":{ 
            "objectClass":"inetOrgPerson",
            "dn":"uid=testDim20,ou=staff,dc=wso2,dc=com",
            "attributes":{ 
                "mail":"testDim1s22c@wso2.com",
                "userPassword":"12345",
                "sn":"dim",
                "cn":"dim",
                "manager":"cn=dimuthuu,ou=Groups,dc=example,dc=com"
            }
        }
    }
    ```

??? note "searchEntry"
    The searchEntry operation performs a search for one or more LDAP entities based on the specified search keys.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>objectClass</td>
            <td>The object class of the new entry.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>filters</td>
            <td>The keywords to use in the search. The parameters should be in JSON format as follow:
            "filters":{ "uid":"john", "mail":"testDim2@gmail.com"}
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>dn</td>
            <td>The distinguished name of the entry you need to search.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>attributes</td>
            <td>The attributes of the LDAP entry that should be included in the search result.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>onlyOneReference</td>
            <td>Boolean value whether to guarantee or not only one reference.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>limit</td>
            <td>This allows you to set a limit on the number of search results. If this property is not defined the maximum no of search results will be returned.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <ldap.searchEntry>
        <objectClass>{$ctx:objectClass}</objectClass>
        <dn>{$ctx:dn}</dn>
        <filters>{$ctx:filters}</filters>
        <attributes>{$ctx:attributes}</attributes>
        <onlyOneReference>{$ctx:onlyOneReference}</onlyOneReference>
        <limit>1000</limit>
    </ldap.searchEntry>
    ```
    
    **Sample request**

    ```json
    {
        "providerUrl":"ldap://server.example.com",
        "securityPrincipal":"cn=admin,dc=example,dc=com",
        "securityCredentials":"admin",
        "secureConnection":"false",
        "disableSSLCertificateChecking":"false",
        "application":"ldap",
        "operation":"searchEntity",
        "content":{
            "dn":"ou=sales,dc=example,dc=com",
            "objectClass":"inetOrgPerson",
            "attributes":"mail,uid,givenName,manager,objectGUID",
            "filters":{
                "manager":"cn=sales-group,ou=sales,dc=example,dc=com","uid":"rajjaz"},
            "onlyOneReference":"false"
        }
    }
    ```

??? note "updateEntry"
    The updateEntry operation updates an existing LDAP entry in the LDAP server based on the specified changes.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>mode</td>
            <td>The mode of the update operation. Possible values are as follows:
                <ul>
                    <li>replace : Replaces an existing attribute with the new attribute that is specified.</li>
                    <li>add : Adds a new attributes</li>
                    <li>remove : Removes an existing attribute.</li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>dn</td>
            <td>The distinguished name of the entry.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>attributes</td>
            <td>Attributes of the entry to be updated. The attributes to be updated should be specified as comma separated key-value pairs.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <ldap.searchEntry>
        <objectClass>{$ctx:objectClass}</objectClass>
        <dn>{$ctx:dn}</dn>
        <filters>{$ctx:filters}</filters>
        <attributes>{$ctx:attributes}</attributes>
        <onlyOneReference>{$ctx:onlyOneReference}</onlyOneReference>
        <limit>1000</limit>
    </ldap.searchEntry>
    ```
    
    **Sample request**

    ```json
    {
        "providerUrl":"ldap://server.example.com",
        "securityPrincipal":"cn=admin,dc=example,dc=com",
        "securityCredentials":"admin",
        "secureConnection":"false",
        "disableSSLCertificateChecking":"false",
        "application":"ldap",
        "operation":"searchEntity",
        "content":{
            "dn":"ou=sales,dc=example,dc=com",
            "objectClass":"inetOrgPerson",
            "attributes":"mail,uid,givenName,manager,objectGUID",
            "filters":{
                "manager":"cn=sales-group,ou=sales,dc=example,dc=com","uid":"rajjaz"},
            "onlyOneReference":"false"
        }
    }
    ```

??? note "deleteEntry"
    The deleteEntry operation deletes an existing LDAP entry from the LDAP server.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>dn</td>
            <td>The distinguished name of the entry to be deleted.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <ldap.searchEntry>
        <objectClass>{$ctx:objectClass}</objectClass>
        <dn>{$ctx:dn}</dn>
        <filters>{$ctx:filters}</filters>
        <attributes>{$ctx:attributes}</attributes>
        <onlyOneReference>{$ctx:onlyOneReference}</onlyOneReference>
        <limit>1000</limit>
    </ldap.searchEntry>
    ```
    
    **Sample request**

    ```json
    {
        "providerUrl":"ldap://server.example.com",
        "securityPrincipal":"cn=admin,dc=example,dc=com",
        "securityCredentials":"admin",
        "secureConnection":"false",
        "disableSSLCertificateChecking":"false",
        "application":"ldap",
        "operation":"searchEntity",
        "content":{
            "dn":"ou=sales,dc=example,dc=com",
            "objectClass":"inetOrgPerson",
            "attributes":"mail,uid,givenName,manager,objectGUID",
            "filters":{
                "manager":"cn=sales-group,ou=sales,dc=example,dc=com","uid":"rajjaz"},
            "onlyOneReference":"false"
        }
    }
    ```