# Using the Registry REST API

The registry REST API can be used to perform CRUD operations on registry resources. This is not packed with WSO2 API Manager by default. Follow the steps below to use the registry REST API with WSO2 API Manager.

1.  Download the [registry REST API webapp](attachments/103335316/103335317.war) .
2.  Copy the webapp to `          <API-M_HOME>/repository/deployment/server/webapps         ` .
3.  Invoke the registry REST API. For an example, to get the content of the `           app-tiers.xml          ` file, in the registry path `           _system/governance/apimgt/applicationdata,          ` the following curl command can be used:

    -   [**Format**](#7ae3e0457755455db413bd33375a336c)
    -   [**Sample**](#25175165c2694c0391fde821c15cf487)

    ``` java
        curl -X GET -H "Authorization: Basic <base64_encoded_username:password>=" -H "Content-Type: application/json" -H "Cache-Control: no-cache" "https://<hostname>:<port>/resource/1.0.0/artifact/_system/governance/apimgt/applicationdata/app-tiers.xml" -k
    ```

    ``` java
            curl -X GET -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -H "Cache-Control: no-cache" "https://localhost:9443/resource/1.0.0/artifact/_system/governance/apimgt/applicationdata/app-tiers.xml" -k
    ```

    For a complete reference of the available REST API operations, go to [Resources with REST API](https://docs.wso2.com/display/Governance540/Resources+with+REST+API) .


