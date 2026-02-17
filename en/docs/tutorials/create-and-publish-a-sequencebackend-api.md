# Create and Publish an API with Sequence as a Backend

When using a sequence as a backend, you can execute any mediation logic which acts as a backend to the **REST API**.
WSO2 API Manager has integrated the support for invoking **REST API** with custom mediation logic through WSO2 API Gateway. Follow the steps below to create and publish an API with Sequence as a Backend.

## Step 1 - Create a REST API

1. Sign in to the API Publisher Portal `https://<hostname>:9443/publisher`.

2. Click **CREATE API** and then click **Start From Scrach**.

    [![Create a new REST API]({{base_path}}/assets/img/get_started/design-new-rest-api.png)]({{base_path}}/assets/img/get_started/design-new-rest-api.png)

3. Enter the API details without an endpoint URL and click **Create**.  

    [![Create a test API]({{base_path}}/assets/img/learn/design-new-rest-api-details.png)]({{base_path}}/assets/img/learn/design-new-rest-api-details.png)

## Step 2 - Add Sequence Backend Endpoint

1. Click **Endpoints** to navigate to Endpoints page.

2. Navigate to the **Sequence Backend Endpoint** type and click **ADD**.

    [![Select Sequence Backend endpoint]({{base_path}}/assets/img/learn/endpoint-select-sequence-backend-endpoint.png)]({{base_path}}/assets/img/learn/endpoint-select-sequence-backend-endpoint.png)

    You will be redirected to the sequence backend page.
    [![Select Sequence Backend endpoint page]({{base_path}}/assets/img/learn/endpoint-sequence-backend-page.png)]({{base_path}}/assets/img/learn/endpoint-sequence-backend-page.png)

3. Upload a sequence file to the preferred **Key Type**
    
    To upload, you can hit Add button under the selected key type.
    Sequence Backend endpoint configuration needs to have atleast one sequence for the API (either SANDBOX or PRODUCTION).
        [![Upload Sequence Backend]({{base_path}}/assets/img/learn/upload-sequence-backend-file.png)]({{base_path}}/assets/img/learn/upload-sequence-backend-file.png)

    !!!note
        In both key types, only one sequence is allowed to be added. If a developer wants to replace, then the uploaded one should be deleted from the preferred key type.

4. Click **Save**
    [![Save the Sequence Uploaded]({{base_path}}/assets/img/learn/endpoint-sequence-backend-save.png)]({{base_path}}/assets/img/learn/endpoint-sequence-backend-save.png)

    This lists the uploaded sequences for the preferred key types.
    [![List Sequence Backends Uploaded]({{base_path}}/assets/img/learn/list-sequence-backends-uploaded.png)]({{base_path}}/assets/img/learn/list-sequence-backends-uploaded.png)


4. Download sequence uploaded of the preferred key type. This will download the sequence uploaded by the user.

5. Delete sequence uploaded from the preferred key type
    If there's only one item to be deleted, you will not be permitted to perform the operation as atleast one sequence should be provided under the "Sequence Backend" endpoint type.

6. Click **Save**.

    [![Save the Endpoint Configuration]({{base_path}}/assets/img/learn/endpoint-config-sequence-backend-save.png)]({{base_path}}/assets/img/learn/endpoint-config-sequence-backend-save.png)

    !!!note
         Button will not be enabled if there's no sequence provided under the Sequence Backend endpoint configuration.

!!!note
        Sequence Backend endpoint type only applicable for REST APIs and can be deployed only in Synapse Gateway.