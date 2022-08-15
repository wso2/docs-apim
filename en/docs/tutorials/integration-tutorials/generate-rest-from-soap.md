# Generate a REST API from SOAP Backend

Although REST APIs are what a modern enterprise looks for in their API management solution, they do not need to represent a RESTful backend service or system. You can expose legacy SOAP backends as REST APIs through WSO2 Integration Studio. WSO2 Integration Studio supports WSDL 1.1 based SOAP backends.

!!! note
    Before you begin, make sure that you have a valid WSDL URL from the SOAP backend. It should belong to the WSDL 1.1 version.

Follow the instructions below to generate REST APIs in WSO2 Integration Studio for an existing SOAP backend.

1. [Start WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio/).

2. [Create a new Integration Project]({{base_path}}/integrate/develop/create-integration-project/).

3. Right-click the **Config** project in the project explorer and go to **New** → **REST API**.

4. In the dialog box that opens, select **Generate REST API from WSDL** from the given options for creating the API artifact.

5. Click **Next** to go to the next page and enter the relevant details.



