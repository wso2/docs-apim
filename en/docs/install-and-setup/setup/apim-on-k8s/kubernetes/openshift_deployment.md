# Deploying API-M in Openshift
## Overview

This guide provides step-by-step instructions for deploying WSO2 API Manager (API-M) on an OpenShift cluster using Helm charts. It covers OpenShift-specific configuration requirements, including:

- [Preparing the Docker images](#preparing-the-docker-images)
- [Configuring the security context in `values.yaml`](#change-openshift-specific-settings-in-valuesyaml)

For an all-in-one deployment, following this guide is sufficient. If you need a distributed deployment, refer to the [Deployment Patterns guide](README.md) and apply the additional configurations mentioned here on top of the provided `default_values.yaml` files.

## Prerequisites:

- Install Git, Helm, Openshift Client(OC) and Kubernetes client in order to run the steps provided in the following quick start guide.
- An already setup Openshift cluster.
- Install NGINX Ingress Controller. Please note that Helm resources for WSO2 product deployment patterns are compatible with NGINX Ingress Controller Git release nginx-0.22.0.

## General Steps

Required Dockerfiles can be found in the [docker-apim](https://github.com/wso2/docker-apim) repo and follow the given steps below for preparing the necessary images.

#### Preparing the Docker Images

To fully comply with OpenShift’s security model especially its use of arbitrary user IDs, user has to create a custom Docker image tailored for OpenShift environments. Following are the steps required for modifying the image to ensure compatibility, including how to set group ownership to the root group (GID 0), which allows access when OpenShift assigns a random UID at runtime.

The official WSO2 Docker images run as a non-root user with a fixed UID. While that works on standard Kubernetes clusters, OpenShift often injects a random UID and restricts container privileges. To prevent permission issues, update the image to:

1. Allow group write access to required directories
2. Assign root group ownership (GID 0)

Also 

1. Starting from v4.5.0, each component has a separate Docker image (All-in-one, Control-plane, Gateway, Traffic-manager).
2. These Docker images do not contain any database connectors; therefore, we need to build custom Docker images based on each Docker image in order to make the deployment work with a seperate DB.
3. Download a connector which is compatible with the DB version and copy the connector while building the image

Ex: Following is a sample modified dockerfile created using the existing ```ubuntu/apim``` as the base image. 
```Dockerfile
FROM wso2/wso2am:4.5.0

ARG USER=wso2carbon
ARG USER_ID=10001
ARG USER_HOME=/home/${USER}
ARG WSO2_SERVER_NAME=wso2am
ARG WSO2_SERVER_VERSION=4.5.0
ARG WSO2_SERVER_REPOSITORY=product-apim
ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}

# Change direcrtory permissions
USER root
RUN chgrp -R 0 ${USER_HOME} && chmod -R g=u ${USER_HOME} \
    && chgrp -R 0 ${WSO2_SERVER_HOME} && chmod -R g=u ${WSO2_SERVER_HOME} \
    && chgrp -R 0 ${USER_HOME}/solr && chmod -R g=u ${USER_HOME}/solr
USER wso2carbon
# Copy JDBC MySQL driver
COPY mysql-connector.jar ${WSO2_SERVER_HOME}/repository/components/lib

```
After making the changes, build and push the image to the to the registry and make sure to change the helm charts so that it will use these modified images when deploying.


#### Login to the Openshift Cluster

```bash
oc login <API server URL> -u <user> -p <password>
```

#### Create Secret
1. Before deploying the Helm chart, we need to create a Kubernetes secret containing the keystores and truststore.
2. You can find the default keystore and truststore in the following location within any of the APIM packs: `repository/resources/security/`
```bash
kubectl create secret generic jks-secret --from-file=wso2carbon.jks --from-file=client-truststore.jks
```

#### Clone helm-apim
```bash
git clone https://github.com/wso2/helm-apim.git
```

#### Change Openshift Specific settings in values.yaml

In each corresponding values.yaml file, the following changes need to be made in order to make them compatible with the openshift environment. 

> 1. runAsUser: For allowing the assignment of arbitrary UIDs, you can set runAsUser as follows kubernetes.securityContext.runAsUser=null
> 2. seLinux Support: If you need SELinux support, you can enable it by setting kubernetes.securityContext.seLinux.enabled=true
> 3. AppArmor Support: If you need AppArmor disabled, you can do so by setting kubernetes.enableAppArmor=false
> 4. ConfigMap Access: If your runtime user doesn't have execute access to ConfigMaps, you can fix it by setting kubernetes.configMaps.scripts.defaultMode=0457
> 5. Seccomp: If you need to change which seccomp (secure computing mode) profile to apply, you can do it using
kubernetes.securityContext.seccompProfile.type

Ex: 

```yaml
  securityContext:
    # -- User ID of the container
    runAsUser: null
    # -- SELinux context for the container
    seLinux:
      enabled: false
      level: ""
    # -- Seccomp profile for the container
    seccompProfile:
      # -- Seccomp profile type(RuntimeDefault, Unconfined or Localhost)
      type: RuntimeDefault
      localhostProfile: ""
  # -- Enable AppArmor profiles for the deployment
  enableAppArmor: false
  # -- Set UNIX permissions over the executable scripts
  configMaps:
    scripts:
      defaultMode: "0457"
```

---

## APIM ALL-IN-ONE Deployment

- Navigate to the all-in-one deployment `(helm-apim/all-in-one)` and inside the ```default_values.yaml```
  - Change the DB related info(Type,URL, Credentials, etc.) and the container image related info(repositoy, digest, etc.) if needed in the values.yaml

  - Change the `wso2.apim.configurations.security.jksSecretName` to the secret name created earlier.

- Apply the helm chart using
 ```helm install <deoplyment-name> . -f default_values.yaml```

[Add the helm install command which sets the values within the command itself.]


## Distributed Setup

Helm charts for distributed setup can be found inside the  ```apim-helm/distributed``` folder. In each chart, change the DB related info(Type,URL, Credentials, etc.) and the container image related info(repositoy, digest, etc.) if needed in the values.yaml. Please refer deployment patterns section to find the suitable deployment pattern and follow the deployment guide to do the neccessary changes to the values.yaml.