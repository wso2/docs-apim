# Using Swagger Documents

API documentation is important to guide the users on what they can do using specific APIs. 

When you create a REST API artifact or a RESTful data service from WSO2 Integration Studio, a default Swagger definition is generated. For [REST API]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) artifacts, you can also attach an additional custom Swagger definition for the API.

## Swagger documents of API artifacts

If your REST API is deployed, copy the following URLs (with your API details) to your browser:

!!! Note
    If you have a custom Swagger definition attached to the API, the following URLs will return the custom definition and not the default Swagger definition of the API.


-   To access the `swagger.json` file, use the following URL:

    ```bash
    http://<MI_HOST>:8290/<API_NAME>?swagger.json
    ```

    **Example**: 
    ```bash
    http://localhost:8290/HealthcareAPI?swagger.json
    ```

-   To access the `swagger.yaml` file, use the following URL:

    ```bash
    http://<MI_HOST>:8290/<API_NAME>?swagger.yaml
    ```

    **Example**: 
    ```bash
    http://localhost:8290/HealthcareAPI?swagger.yaml
    ```

!!! Tip
    -   Replace `<MI_HOST>` with `localhost`. If you are using a public IP, the respective IP address or domain needs to be specified. 
    -   Replace `<API_NAME>` with your API's name. The API name is case sensitive.

## Swagger documents of RESTful data services

If your RESTful data service is deployed, copy the following URLs to your browser:

-   To access the `swagger.json` file, use the following URL:

    ```bash
    http://<MI_HOST>:8290/<DATA_SERVICE>?swagger.json
    ```

    **Example**: 
    ```bash
    http://localhost:8290/RDBMSDataService?swagger.json
    ```

-   To access the `swagger.yaml` file, use the following URL:

    ```bash
    http://<MI_HOST>:8290/<DATA_SERVICE>?swagger.yaml
    ```

    **Example**: 
    ```bash
    http://localhost:8290/RDBMSDataService?swagger.yaml
    ```

!!! Tip
    -   Replace `<MI_HOST>` with `localhost`. If you are using a public IP, the respective IP address or domain needs to be specified. 
    -   Replace `<DATA_SERVICE>` with your service name. The service name is case sensitive.
