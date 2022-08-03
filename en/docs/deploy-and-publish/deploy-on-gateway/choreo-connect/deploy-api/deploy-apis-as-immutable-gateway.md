# Deploy APIs as Immutable Gateway

When deploying APIs as an immutable Gateway, the APIs are deployed during startup. After startup, no APIs can be added using apictl. 
For that, the apictl projects needs to be mounted to the `docker-compose/resources/adapter/artifacts/apis` directory 
(default location) of the adapter. 
At the startup of the adapter, it picks the projects and deploys them. After startup, APIs should be added using apictl.

For deploying APIs as an immutable Gateway using Helm chart, please refer [Deploy APIs as Immutable Gateway in Production Deployment]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/production-deployment-guideline/#deploy-apis-as-immutable-gateway).

## Step 1 - Download apictl and set the path variable 

First download [apictl](https://github.com/wso2/product-apim-tooling/releases) locally and extract it into a folder of your choice. Then, add its location to your PATH variable.

```
export PATH=$PATH:<directory-of-the-apictl-executable>
```

## Step 2 - Create an API Project using apictl

Let's create your first project "petstore" using an OpenAPI definition. The following `apictl init` command will generate a project folder containing all the necessary files.

!!! warning

    If you have used a previous version of apictl before, remember to delete the directories `.wso2apictl` and `.wso2apictl.local` that are located in your home directory. Deleting them will make the newer apictl create them again with content compatible with the current version.

``` bash
apictl init petstore --oas https://petstore.swagger.io/v2/swagger.json
```

!!! note

    Instead of initializing the API project, you can [export the APIs from API Manager]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/migrating-apis-to-different-environments) as well.

## Step 3 - Copy the project to the resources/enforcer/artifacts/apis directory

The created apictl project needs to be copied to `docker-compose/resources/adapter/artifacts/apis` directory. These
apictl projects could be copied either in directory format or in zipped format. 
The apictl project can be the API artifact exported from the API Manager as well. 
The docker-compose file mounts that directory to the `/home/wso2/artifacts/apis`. 
All the apictl projects in the directory will be deployed during the startup. 


## Step 4 - update config.toml

```
[adapter.server]
    enabled = false
```

!!! note

    If this configuration is set to true, the mounted API projects are deployed during startup. However, they will not have
    the immutable nature as the APIs can be added after startup using apictl.

!!! note

    If the control plane is enabled, the mounted API projects are not deployed.    


##  Step 5 - Invoke the API
{! ./includes/obtain-jwt.md !}
{! ./includes/invoke-api-with-jwt.md !}

<!-- brought the following here because the path becomes relative when included in the includes folder -->
Refer to [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt) for more details.
