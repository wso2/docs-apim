# LDAP Connector Example

Given below is a sample scenario that demonstrates how to perform CRUD operations on LDAP entries using LDAP Connector.

## What you'll build

This example demonstrates on how to use the LDAP connector to create and read LDAP entries on a student directory. 
    ![image]({{base_path}}/assets/img/integrate/connectors/ldap_connector/ldap_connector_usecase.png)

This will have 2 API resources, `create`, `search`.

todo : add an image

* `/create` : This will create a new LDAP entry in the LDAP server.

* `/search` : This will performs a search for one or more LDAP entities with the specified search keys.

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Before you begin, see [Setting up LDAP]({{base_path}}/reference/connectors/ldap-connector/setting-up-ldap/) if you need to setup an LDAP and try this out. 

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

1. Right click on the created Integration Project and select, **New** -> **Rest API** to create the REST API. 
   
2. Provide the API name as `college_student_api` and the API context as `/student`. You can go to the source view of the 
xml configuration file of the API and copy the following configuration. 
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <api context="/student" name="college_student_api" xmlns="http://ws.apache.org/ns/synapse">
        <resource methods="POST" url-mapping="/create">
            <inSequence>
                <sequence key="init_sequence"/>
                <sequence key="add_student_sequence"/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" url-mapping="/search">
            <inSequence>
                <sequence key="init_sequence"/>
                <sequence key="search_student_sequence"/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
    </api>
    ```
   
3. Right click on the created Integration Project and select, -> **New** -> **Sequence** to create the following 
sequences.

    * init_sequence - `<ldap.init>` element authenticates with the LDAP server in order to gain access to perform various 
    LDAP operations.
        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <sequence name="init_sequence" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
            <property expression="json-eval($.secureConnection)" name="secureConnection" scope="default" type="STRING"/>
            <property expression="json-eval($.disableSSLCertificateChecking)" name="disableSSLCertificateChecking" scope="default" type="STRING"/>
            <property expression="json-eval($.providerUrl)" name="providerUrl" scope="default" type="STRING"/>
            <property expression="json-eval($.securityPrincipal)" name="securityPrincipal" scope="default" type="STRING"/>
            <property expression="json-eval($.securityCredentials)" name="securityCredentials" scope="default" type="STRING"/>
            <ldap.init>
                <providerUrl>{$ctx:providerUrl}</providerUrl>
                <securityPrincipal>{$ctx:securityPrincipal}</securityPrincipal>
                <securityCredentials>{$ctx:securityCredentials}</securityCredentials>
                <secureConnection>{$ctx:secureConnection}</secureConnection>
                <disableSSLCertificateChecking>{$ctx:disableSSLCertificateChecking}</disableSSLCertificateChecking>
            </ldap.init>
        </sequence>
        ```

    * add_student_sequence - `<ldap.addEntry>` element creates a new LDAP entry in the LDAP server
        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <sequence name="add_student_sequence" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
            <property expression="json-eval($.content.objectClass)" name="objectClass" scope="default" type="STRING"/>
            <property expression="json-eval($.content.attributes)" name="attributes" scope="default" type="STRING"/>
            <property expression="json-eval($.content.dn)" name="dn" scope="default" type="STRING"/>
            <ldap.addEntry>
                <objectClass>{$ctx:objectClass}</objectClass>
                <attributes>{$ctx:attributes}</attributes>
                <dn>{$ctx:dn}</dn>
            </ldap.addEntry>
            <respond/>
        </sequence>
        ```
      
    * search_student_sequence - `<ldap.searchEntry>` element search for one or more LDAP entities based on the specified 
    search keys.
        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <sequence name="search_student_sequence" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
            <property expression="json-eval($.content.objectClass)" name="objectClass" scope="default" type="STRING"/>
            <property expression="json-eval($.content.filters)" name="filters" scope="default" type="STRING"/>
            <property expression="json-eval($.content.attributes)" name="attributes" scope="default" type="STRING"/>
            <property expression="json-eval($.content.dn)" name="dn" scope="default" type="STRING"/>
            <ldap.searchEntry>
                <objectClass>{$ctx:objectClass}</objectClass>
                <limit>1000</limit>
                <filters>{$ctx:filters}</filters>
                <dn>{$ctx:dn}</dn>
                <attributes>{$ctx:attributes}</attributes>
            </ldap.searchEntry>
            <respond/>
        </sequence>
        ```

{!reference/connectors/exporting-artifacts.md!}

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/ldap_connector_project.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!reference/connectors/deploy-capp.md!}

## Testing

### Create an entry in ldap server

1. Create a file named student_data.json with following sample payload.
    ```json
        { 
          "providerUrl":"ldap://localhost:10389/",
          "securityPrincipal":"uid=admin,ou=system",
          "securityCredentials":"admin",
          "secureConnection":"false",
          "disableSSLCertificateChecking":"false",
          "content":{ 
             "objectClass":"identityPerson",
             "dn":"uid=triss.merigold,ou=Users,dc=wso2,dc=org",
             "attributes":{ 
                "mail":"triss@wso2.com",
                "userPassword":"geralt&triss",
                "sn":"dim",
                "cn":"dim",
                "manager":"cn=geralt,ou=Groups,dc=example,dc=com"
             }
          }
        }
    ```

2. Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).
    ```
    curl -H "Content-Type: application/json" -X POST --data @student_data.json http://localhost:8290/student/create
    ```

**Expected Response**: 
1. You should get a 'Success' response. 
2. Open Apache Directory Studio and category DIT (Directory Information Tree) shows the hierarchical content of the 
directory. Expand, collapse the tree and you will see the new entries. Select the entry and you will see it's attributes 
and values on Entry Editor.
    ![image]({{base_path}}/assets/img/integrate/connectors/ldap_connector/ldap-connector-directory-studio-view.png)

### Search ldap entries

1. Create a file named search_student.json with following sample payload
    ```json
        {
            "providerUrl": "ldap://localhost:10389/",
            "securityPrincipal": "uid=admin,ou=system",
            "securityCredentials": "admin",
            "secureConnection": "false",
            "disableSSLCertificateChecking": "false",
            "application": "ldap",
            "operation": "searchEntity",
            "content": {
                "objectClass": "identityPerson",
                "filters": {
                    "manager": "cn=geralt,ou=Groups,dc=example,dc=com"
                },
                "dn": "ou=Users,dc=wso2,dc=org",
                "attributes": "mail,uid"
            }
        }
    ```

2. Invoke the API as shown below using the curl command. 
    ```
    curl -H "Content-Type: application/json" -X POST --data @search_student.json http://localhost:8290/student/search
    ```

**Expected Response**: 
You should get all entries that match with the provided filter. A sample response is as follows.
```json
    {
        "result": {
            "entry": [
                {
                    "dn": "uid=triss.merigold,ou=Users,dc=WSO2,dc=ORG",
                    "mail": "triss@wso2.com",
                    "uid": "triss.merigold"
                },
                {
                    "dn": "uid=yennefer.of.vengerberg,ou=Users,dc=WSO2,dc=ORG",
                    "mail": "yenna@wso2.com",
                    "uid": "yennefer.of.vengerberg"
                }
            ]
        }
    }
```
## What's Next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
* To customize this example for your own scenario, see [LDAP Connector Configuration]({{base_path}}/reference/connectors/ldap-connector/ldap-server-configuration/) documentation for all operation details of the connector.
