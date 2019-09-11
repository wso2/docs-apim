# Deploying API Manager with Kubernetes or OpenShift Resources

!!! warning
This page has been restricted because currently APIM 220 does not have artifacts that support these instructions.


Follow the instructions below to use Kubernetes (K8s) or Openshift resources for container-based deployments of WSO2 API Manager (API-M).

!!! note
In the context of this document, **&lt;`KUBERNETES_HOME>         `** refers to a local copy of the [`wso2/kubernetes-apim         `](https://github.com/wso2/kubernetes-apim/) Git repository that **includes common resources that can be used for Kubernetes and OpenShift.**


1.  Checkout the WSO2 kubernetes-apim repository using `git clone` :

    ``` java
        git clone https://github.com/wso2/kubernetes-apim.git
        git checkout tags/v2.1.0-2
    ```

2.  Log in to the `WSO2 Docker Registry` .
    Enter your WSO2 subscription credentials to log in to the WSO2 Docker Registry.

        !!! note
    You need to either have a subscription for WSO2 API Manager or a free trial subscription to be able to pull the required Docker images from the registry.


    ``` java
        docker login docker.cloud.wso2.com
    ```

3.  Pull required Docker images from the [`WSO2 Docker Registry           `](https://docker.cloud.wso2.com/) using `docker pull` :

    ``` java
            docker pull docker.cloud.wso2.com/wso2am-analytics-kubernetes:2.1.0
            docker pull docker.cloud.wso2.com/wso2am-kubernetes:2.1.0
            docker pull docker.cloud.wso2.com/apim-rdbms-kubernetes:2.1.0
    ```

        !!! tip
    You can also build the Docker images by following the guide in the &lt; `KUBERNETES_HOME>/base/README.md` . In addition, note that the same images can be used for OpenShift.


4.  Copy the Images into Kubernetes/Openshift nodes or to a Registry.
    Copy the required Docker images over to the Kubernetes Nodes.
    For example:

    1.  Use `docker save` to create a TAR file of the required image.

    2.`scp` the TAR file to each node.

    3.  Use `docker load` to load the image from the copied TAR file on the nodes.
        Alternatively, if a private Docker registry is used, transfer the images there.

5.  Deploy Kubernetes/Openshift Resources.

        !!! note
    **Before you begin the deployment** , make sure that you have the following prerequisites.

    -   Set up Network File System (NFS) to deploy any pattern.
        NFS is used as the persistent volume for API Manager servers. As a result, setting up NFS is required to deploy any pattern. Therefore, you need to complete the following:

        1.  Update the NFS server IP in `<KUBERNETES_HOME>/pattern-X/artifacts/volumes/persistent-volumes.yaml             `
        2.  Create the required directories in the NFS server for each pattern as mentioned in the &lt; `KUBERNETES_HOME>/pattern-X/artifacts/volumes/persistent-volumes.yaml             `
            For example, for `pattern-1` , create the directories as `/exports/pattern-1/apim             `

    -   It is recommend to use a MySQL or any database cluster in a production environment.
        Only one MySQL container is used with host path mount in these deployments.


6.  Deploy Kubernetes/Openshift Resources:

        !!! info
    The following instructions have been **tested on OpenShift v3.6.0** and **Kubernetes v1.6.1** and **NFS** is tested in **Kubernetes v1.6.1.**


    -   [Deploy a pattern on Kubernetes](#DeployingAPIManagerwithKubernetesorOpenShiftResources-DeployapatternonKubernetes)
    -   [Deploy a pattern on Openshift](#DeployingAPIManagerwithKubernetesorOpenShiftResources-DeployapatternonOpenshift)

    #### **Deploy a pattern on Kubernetes**

    1.  Create a namespace named `wso2` .

        ``` java
                kubectl create namespace wso2
        ```

    2.  Create a service account named `wso2svcacct` in the `wso2` namespace.

        ``` java
                    kubectl create serviceaccount wso2svcacct -n wso2
        ```

    3.  Deploy any pattern by running the `deploy-kubernetes.sh` script that is inside the pattern folder ( `<KUBERNETES_HOME>/pattern-X/` directory).

        ``` java
                    ./deploy-kubernetes.sh
        ```

    4.  Access the management console using the following command to list ingresses in the deployment.

        ``` java
                    kubectl get ingress
        ```

        Add relevant hosts and IP addresses to the `/etc/hosts` file.
        The following are sample access URLs. However, note that this will varies based on the pattern that you are using.

        -   [https://wso2apim](https://wso2apim/)

        -   [https://wso2apim-analytics](https://wso2apim-analytics/)

        -   [https://wso2apim-gw](https://wso2apim-gw/)

    If required, **undeploy a pattern on Kubernetes**

    You can undeploy any pattern by running `undeploy-kubernetes.sh` script that is inside the pattern folder ( `<KUBERNETES_HOME>/pattern-X/` directory).

    ``` java
            ./undeploy-kubernetes.sh
    ```

    #### **
    Deploy a pattern on Openshift**

    1.  Create a user named `admin` and assign the user to the `cluster-admin` role.
        This user with the `cluster-admin` role is used to deploy the OpenShift artifacts.

        ``` java
                    oc login -u system:admin
                    oc create user admin --full-name=admin
                    oc adm policy add-cluster-role-to-user cluster-admin admin
        ```

    2.  Create a new project named `wso2` .

        ``` java
                    oc new-project wso2 --description="WSO2 API Manager 2.1.0" --display-name="wso2"
        ```

        Create a service account named `wso2svcacct` in the `wso2` project and assign it the `anyuid` security context constraint.

        ``` java
                    oc create serviceaccount wso2svcacct
                    oc adm policy add-scc-to-user anyuid -z wso2svcacct -n wso2
        ```

    3.  Deploy any pattern by running the `deploy-openshift.sh` script inside the pattern folder ( `<KUBERNETES_HOME>/pattern-X/` directory).

        ``` java
                    ./deploy-openshift.sh
        ```

    4.  Access the Management Console using the following command to list the routes in the deployment.

        ``` java
                    oc get routes
        ```

        Add relevant hosts and IP addresses to the `/etc/hosts` file.

        The following are sample access URLs. Note that this varies based on the pattern that you are using.

        -   [https://wso2apim](https://wso2apim/)
        -   [https://wso2apim-analytics](https://wso2apim-analytics/)
        -   <https://wso2apim-gw>

    If required, **undeploy a pattern on OpenShift**

    
    You can undeploy any pattern by running the `undeploy-openshift.sh` script that is inside the pattern folder ( `<KUBERNETES_HOME>/pattern-X/` directory).

    ``` java
            ./undeploy-openshift.sh
    ```

7.  Customize the deployment (If required). **
    **

    Configurations are bound with the `wso2` namespace. Therefore, if you are changing the hostnames or the namespace, do the following:

    1.  Change `wso2.svc` to `<namespace>.svc` in all the configuration files.
    2.  Update the `KUBERNETES_NAMESPACE` parameter with the correct namespace in all the `<API-M_HOME>/repository/conf/axis2/axis2.xml` files.
    3.  Update Docker base images.
        Use a CA signed certificate and update the `client-truststore.jks` and `wso2carbon.jks` files which are in the following location.
        [https://github.com/wso2/kubernetes-apim/tree/2.1.0-nfs/base/apim/files](https://www.google.com/url?q=https%3A%2F%2Fgithub.com%2Fwso2%2Fkubernetes-apim%2Ftree%2F2.1.0-nfs%2Fbase%2Fapim%2Ffiles&sa=D&sntz=1&usg=AFQjCNFpe0GcpxuImsleBgvPAP5tGswp_g) .


