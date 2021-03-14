# Documentum Connector Example

Documentum Connector can be used to perform operations on OpenText Documentum Enterprise content management system.

## What you'll build

This example explains how to use Documentum Connector to create a folder and retrieve cabinet details from Documentum. The user sends a payload with the repository name, parent folder ID and name of the folder to be created. Then the connector communicates with Documentum to create a folder under the
parent folder in the specified cabinet.

The example consists of an API named as Documentum API with two resources create folder and get cabinets.

**Create Folder**
/createfolder: The user sends the request payload which includes the repository, parent folder ID and folder name. This request is sent to WSO2 EI by invoking the Documentum API. It will create the new folder in Documentum under the parent folder given.

**Get Cabinets**
/getcabinets: The user sends the request payload, containing the repository name to list cabinets present under that in Documentum. This request is sent to WSO2 EI where the Documentum Connector API resides. Once the API is invoked, it returns the list of cabinets.

**Create Document**
/createdocument: The user sends the request payload which includes the folder ID and document name. This request is sent to WSO2 EI where the Documentum Connector API resides. Once the API is invoked, it will create the new Document in Documentun under the given folder ID.

The following diagram shows the overall solution.

<img src="{{base_path}}/assets/img/integrate/connectors/documentum-example.png" title="Documentum connector example" width="400" alt="Documentum connector example"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/), which is the tooling component of WSO2 EI. Once added, the operations of the connector can be dragged onto your canvas and added to your resources.

### Import the connector

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

Now the connector is added to the palette.

### Configure a Proxy Service

1. Right click on the project and go to **New** -> **Proxy Service**.

2. Select **Create A New Proxy Service** from the options that appear and click **Next**.

3. Provide a name for the proxy service and click **Finish**.

4. Add the following configuration to the source view of the project.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <proxy name="documentum_createfolder" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
        <target>
            <inSequence>
                <property expression="json-eval($.repo)" name="repo" scope="default" type="STRING"/>
                <property expression="json-eval($.objectcodeID)" name="objectcode" scope="default" type="STRING"/>
                <property expression="json-eval($.foldername)" name="foldername" scope="default" type="STRING"/>
                <documentum.createfolder>
                    <repo>{$ctx:repo}</repo>
                    <objectcode>{$ctx:objectcode}</objectcode>
                    <foldername>{$ctx:foldername}</foldername>
                </documentum.createfolder>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </target>
    </proxy>
    ```

You can see the newly added connector in the design palette.

<img src="{{base_path}}/assets/img/integrate/connectors/documentum-proxy.png" title="Documentum proxy" width="800" alt="Documentum proxy"/>

### Configure the connection and create folder operation

1. Do the following configurations to initialize the connector.
    <img src="{{base_path}}/assets/img/integrate/connectors/documentum-connection.png" title="Documentum connection" width="800" alt="Documentum connection"/>

2. Do the following configurations to set up the `create folder` operation.
    <img src="{{base_path}}/assets/img/integrate/connectors/documentum-create-folder.png" title="Documentum create folder" width="800" alt="Documentum create folder"/>

Now we can export the imported connector and the API into a single CAR application. CAR application is the one we are going to deploy to server runtime. 

{!reference/connectors/exporting-artifacts.md!}

Now the exported CApp can be deployed in Enterprise Integrator Runtime so that we can run it and test.

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/googlepubsub-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the simulator details and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the Enterprise Integrator Runtime. 

{!reference/connectors/deploy-capp.md!}   

## Testing

**Create folder operation**

1. Open Postman and use a POST operation with the following sample request payload, then click on **Send**.
    ```json
    {
        "repos":"doctest",
        "objectcodeID":"0b0277b68004e7dd",
        "foldername":"demo"
    }
    ```

2. You will see the following sample response payload.

```json
    {
        "name":"folder",
        "type":"dm_folder",
        "definition":"http://183.28.254.179:8078/documentum-rest-web-16.7.0000.0076/repositories/doctest/types/dm_folder",
        "properties": {
            "object_name":"testchildfolder",
            "r_object_type":"dm_folder",
            "title":"",
            "subject":"",
            "authors": null,
            "keywords": null,
            "a_application_type": "",
            "a_status": "",
            "r_creation_date": "2020-07-17T04:30:56.000+00:00",
            "r_modify_date": "2020-07-17T04:30:56.000+00:00",
            "r_modifier": "appowner",
            "r_access_date": null,
            "a_is_hidden": false,
            "i_is_deleted": false,
            "a_retention_date": null,
            "a_archive": false,
            "a_compound_architecture": "",
            "a_link_resolved": false,
            "i_reference_cnt": 1,
            "i_has_folder": true,
            "i_folder_id": [
                "0b0277b68004e7dd"
            ],
            "r_composite_id": null,
            "r_composite_label": null,
            "r_component_label": null,
            "r_order_no": null,
            "r_link_cnt": 0,
            "r_link_high_cnt": 0,
            "r_assembled_from_id": "0000000000000000",
            "r_frzn_assembly_cnt": 0,
            "r_has_frzn_assembly": false,
            "resolution_label": "",
            "r_is_virtual_doc": 0,
            "i_contents_id": "0000000000000000",
            "a_content_type": "",
            "r_page_cnt": 0,
            "r_content_size": 0,
            "a_full_text": true,
            "a_storage_type": "",
            "i_cabinet_id": "0c0277b68002952c",
            "owner_name": "appowner",
            "owner_permit": 7,
            "group_name": "docu",
            "group_permit": 5,
            "world_permit": 4,
            "i_antecedent_id": "0000000000000000",
            "i_chronicle_id": "0b0277b6800584f7",
            "i_latest_flag": true,
            "r_lock_owner": "",
            "r_lock_date": null,
            "r_lock_machine": "",
            "log_entry": "",
            "r_version_label": [
                "1.0",
                "CURRENT"
            ],
            "i_branch_cnt": 0,
            "i_direct_dsc": false,
            "r_immutable_flag": false,
            "r_frozen_flag": false,
            "r_has_events": false,
            "acl_domain": "appowner",
            "acl_name": "dm_450277b680000101",
            "a_special_app": "",
            "i_is_reference": false,
            "r_creator_name": "appowner",
            "r_is_public": true,
            "r_policy_id": "0000000000000000",
            "r_resume_state": 0,
            "r_current_state": 0,
            "r_alias_set_id": "0000000000000000",
            "a_effective_date": null,
            "a_expiration_date": null,
            "a_publish_formats": null,
            "a_effective_label": null,
            "a_effective_flag": null,
            "a_category": "",
            "language_code": "",
            "a_is_template": false,
            "a_controlling_app": "",
            "r_full_content_size": 0.0,
            "a_extended_properties": null,
            "a_is_signed": false,
            "a_last_review_date": null,
            "i_retain_until": null,
            "r_aspect_name": null,
            "i_retainer_id": null,
            "i_partition": 0,
            "i_is_replica": false,
            "i_vstamp": 0,
            "r_folder_path": [
                "/WSO2 Connector/Sample/testchildfolder"
            ],
            "i_ancestor_id": [
                "0b0277b6800584f7",
                "0b0277b68004e7dd",
                "0c0277b68002952c"
            ],
            "r_object_id": "0b0277b6800584f7"
        }
    }
```

## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
