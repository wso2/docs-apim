# Setting up an LDAP Server

WSO2 Identity Server offers an embedded LDAP as a primary user store. Download Identity Server from [here](https://wso2.com/identity-and-access-management/) and start the server. See [Quick Start Guide](https://is.docs.wso2.com/en/5.10.0/get-started/quick-start-guide/) for more information.

### Apache Directory Studio

1. Download Apache Directory Studio from [here](http://directory.apache.org/studio/) and open.
2. Right click on the LDAP Servers tab found on the bottom left corner and click **New Connection**.<br>
    <img src="{{base_path}}/assets/img/integrate/connectors/ldap_connector/ds_create_new_connection.png" title="LDAP new connection" width="400" alt="LDAP new connection"/>
3. Configure network parameters as follows and click next.<br>
    <img src="{{base_path}}/assets/img/integrate/connectors/ldap_connector/creating_a_new_connection.png" title="LDAP new connection" width="600" alt="LDAP new connection"/>
4. Provide authentication parameters as follows and click finish.
    * Bind DN or user parameter - **uid=admin,ou=system**
    * Bind password - **admin**
5. Right click on newly created connection and select **Open Connection**.<br>
    <img src="{{base_path}}/assets/img/integrate/connectors/ldap_connector/open_connection.png" title="LDAP new connection" width="400" alt="LDAP new connection"/>