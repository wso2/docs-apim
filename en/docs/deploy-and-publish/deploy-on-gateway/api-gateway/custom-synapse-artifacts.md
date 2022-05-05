# Storing Custom Synapse Artifacts

WSO2 API Manager contains two types of artifacts; these are runtime artifacts and design-time artifacts. The API Synapse artifacts that act as the API definitions for the Gateway nodes fall into the runtime artifacts category. Without Synapse artifacts, the API Gateway will not be able to serve the specific API requests during the runtime.

To keep custom runtime artifacts deployed in the file system of the Gateway, add the following configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file of the Gateway nodes.

```toml

[apim.sync_runtime_artifacts.gateway.skip_list]
apis = ["api1.xml","api2.xml"]
endpoints = ["endpoint1.xml"]
sequences = ["post_with_nobody.xml"]
local-entries = ["file.xml"]

```