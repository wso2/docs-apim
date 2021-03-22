# Managing APIs in Kubernetes

WSO2 API Controller, **apictl** allows you to manage APIs in Kubernetes with the use of WSO2 API operator. This approach uses the kubernetes native way to deploy the APIS into a running microgateway cluster from the command line.

!!! Prerequisites

    - [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

    - [Kubernetes v1.14 or above](https://Kubernetes.io/docs/setup/) <br>

        - Minimum CPU : 2vCPU
        - Minimum Memory : 2GB

!!! info
    **Before you begin** 

    -  First download the microgateway distribution from the [github release page](https://github.com/wso2/product-microgateway/releases/) and extract that to a folder of your choice. Then deploy microgateway in kubernetes cluster. Please refer [Steps for deploying  microgateway in kubernetes]()

    -  Make sure the CTL is downloaded and initialized, if not follow the steps in [Download and Initialize the CTL Tool]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

    -  Ensure that the API Operator is deployed in the kubernetes cluster. Please refer [API Operator documentation](https://github.com/wso2/k8s-api-operator/tree/master) for detailed steps.

## Add an API to Kubernetes cluster

1.  Run the following command to add an API to the Kubernetes cluster using either a swagger file, zip file, or an API project folder. When you add the API to the Kubernetes cluster, the API operator successfully deploys the project zip to the WSO2 microgateway Adapter component.

    -   **Command** 

        ```go
        apictl k8s add api -n <API Name> -f <Location of the swagger file, zip file or API project folder>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--name` or `-n` : Name of the API 
                `--file` or `-f` : Location of the swagger file, zip file or the API project folder 

        !!! example
            ```go
            apictl k8s add api -n PizzaShackAPI -f swagger.yaml
            ```
            ```go
            apictl k8s add api -n PizzaShackAPI -f PizzaShackAPI_1.0.0.zip
            ```
            ```go
            apictl k8s add api -n PizzaShackAPI -f PizzaShackAPI-1.0.0
            ```

    -   **Response**

        ```go
        creating configmap with swagger definition            
        configmap/pizzashackapi-swagger created                                             
        creating API definition                                                  
        api.wso2.com/pizzashackapi created
        ```

## Update an API in Kubernetes cluster

1.  Run the following command to update an API in the Kubernetes cluster using either a swagger file, zip file, or an API project folder. When you update the API in the Kubernetes cluster, the API operator successfully deploys the updated project zip to the WSO2 microgateway Adapter component.

    -   **Command** 

        ```go
        apictl k8s update api -n <API Name> -f <Location of the swagger file, zip file or API project folder>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--name` or `-n` : Name of the API 
                `--file` or `-f` : Location of the swagger file, zip file or the API project folder 

        !!! example
            ```go
            apictl k8s update api -n PizzaShackAPI -f swagger.yaml
            ```
            ```go
            apictl k8s update api -n PizzaShackAPI -f PizzaShackAPI_1.0.0.zip
            ```
            ```go
            apictl k8s update api -n PizzaShackAPI -f PizzaShackAPI-1.0.0
            ```

    -   **Response**

        ```go
        creating configmap with swagger definition
        configmap/pizzashackapi-swagger-1614042541 created
        creating API definition
        api.wso2.com/pizzashackapi configured
        configmap "pizzashackapi-swagger" deleted
        ```

## Delete an API in Kubernetes cluster

1.  Run the following command to delete an API in the Kubernetes cluster.

    -   **Command** 

        ```go
        apictl k8s delete api -n <API Name>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--name` or `-n` : Name of the API 
    
        !!! example
            ```go
            apictl k8s delete api -n PizzaShackAPI
            ```

    -   **Response**

        ```go
        api.wso2.com "pizzashackapi" deleted
        ```

## Generate Deployment Directory for Kubernetes

1.  Run the following command to generate a sample directory with all the contents to use as the deployment directory when performing CI/CD pipeline tasks in Kubernetes.

    -   **Command** 

        ```go
        apictl k8s gen deployment-dir -s <Path of Source directory> -d <Path of Destination directory>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--source` or `-s` : Path of the source directory to be used when generating the directory. Source can be a API project folder or a zipped API project.
            -   Optional :
                `--destination` or `-d` : Path of the destination directory where the directory should be generated.       
    
        !!! example
            ```go
             apictl k8s gen deployment-dir -s PizzaShackAPI-1.0.0
            ```
            ```go
             apictl k8s gen deployment-dir -s PizzaShackAPI-1.0.0 -d Deployment-Directory
            ```

    -   **Response**

        ```go
        The deployment directory for PizzaShackAPI-1.0.0 file is generated at Deployment-Directory
        ```

2.  You can add [kustomization.yaml]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-in-kubernetes/resources/kustomization.yaml), [kustomize-config.yaml]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-in-kubernetes/resources/kustomize-config.yaml) and project zip file.

3.  Run the following command to generate the related config maps.

    -   **Command** 

        ```go
        kubectl kustomize

        ```


