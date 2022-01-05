# Generating Service Catalog Metadata Artifact

Follow the instructions given below to generate Service Catalog metadata artifacts for APIs and Proxy Services in WSO2 Integration Studio older workspaces to expose integration services as Managed APIs.

## Generate Swagger and Metadata files for APIs

1. Right-click the **api** folder under the ESB project and click **Generate API Metadata**.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/generate_metadata/api-metadata.png">

2. This will open a success dialog box once finished.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/generate_metadata/api-success.png">

3. Re-select required API artifacts under the relevant **Composite Exporter** module dependencies section to pack the generated metadata artifacts along with the API artifacts.

    !!! Tip
        By default, the `Publish to Service Catalog` checkbox is enabled. If not, select the checkbox in the wizard so that it will include metadata files of the selected artifacts.

## Generate Metadata files for Proxy Services

1. Right-click the **proxy-service** folder under the ESB project and click **Generate API Metadata**.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/generate_metadata/proxy-metadata.png">

2. This will open a success dialog box once finished.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/generate_metadata/proxy-success.png">

3. Re-select required Proxy Service artifacts under the relevant **Composite Exporter** module dependencies section to pack the generated metadata artifacts along with the Proxy Service artifacts.

    !!! Tip
        By default, the `Publish to Service Catalog` checkbox is enabled. If not, select the checkbox in the wizard so that it will include metadata files of the selected artifacts. 

