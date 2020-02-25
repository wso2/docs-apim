# Configuration Catalog
This document describes all the configuration parameters that are used in WSO2 API Manager in a all-in-one deployment. 

## Instructions for use

> Select the configuration sections, parameters, and values that are required for your use and add them to the deployment.toml file. See the example .toml file given below.

```toml
# This is an example .toml file.

[server]
pattern="value"                         
enable_port_forward=true

[key_mgr_node]
endpoints="value"

[gateway]
gateway_environments=["dev","test"]

[[database]]
pool_options.maxActiv=5

```