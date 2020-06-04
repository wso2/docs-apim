# Using the Registry REST API

 You can use the registry REST API to perform CRUD operations on registry resources. This is not packed with WSO2 API Manager by default. Follow the instructions below to use the registry REST API with WSO2 API Manager.

1.  Download the [registry REST API webapp]({{base_path}}/assets/attachments/resource.war).
2.  Copy the webapp to the `<API-M_HOME>/repository/deployment/server/webapps` directory.
3.  Invoke the registry REST API. 

     For an example, you can use the following cURL command to get the content of the `app-tiers.xml` file, in the following registry path `_system/governance/apimgt/applicationdata`
    
    ``` java tab="Format"
    curl -X GET -H "Authorization: Basic <base64_encoded_username:password>=" -H "Content-Type: application/json" -H "Cache-Control: no-cache" "https://<hostname>:<port>/resource/1.0.0/artifact/_system/governance/apimgt/applicationdata/app-tiers.xml" -k
    ```

    ``` java tab="Sample"
    curl -X GET -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -H "Cache-Control: no-cache" "https://localhost:9443/resource/1.0.0/artifact/_system/governance/apimgt/applicationdata/app-tiers.xml" -k
    ```

    For a complete reference of the available REST API operations, go to [Resources with REST API](https://docs.wso2.com/display/Governance540/Resources+with+REST+API).