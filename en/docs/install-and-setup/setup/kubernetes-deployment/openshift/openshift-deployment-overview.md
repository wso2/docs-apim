# Deploy WSO2 API Manager on OpenShift

This guide provides comprehensive instructions for deploying WSO2 API Manager on OpenShift Container Platform using Helm charts. OpenShift environments have unique security requirements that differ from standard Kubernetes clusters, requiring specific configuration adjustments for successful deployment.

!!! info "OpenShift-Specific Configuration"
    This guide covers the following OpenShift-specific requirements:
    
    - [Preparing Docker images for OpenShift compatibility](#step-1---preparing-the-docker-images)
    - [Configuring security context settings in `values.yaml`](#step-4---configure-openshift-specific-settings-in-valuesyaml)
    - [Applying proper permissions for container execution](#step-1---preparing-the-docker-images)

For an all-in-one deployment, following this guide is sufficient. If you need a distributed deployment, please refer to the [Deployment Patterns guide](../kubernetes/kubernetes-overview.md) and apply the additional configurations mentioned in this document on top of the provided `default_values.yaml` files.

## Contents

- [WSO2 API Manager: Deployment on OpenShift](#wso2-api-manager-deployment-on-openshift)
  - [Contents](#contents)
  - [Prerequisites](#prerequisites)
  - [Deployment Steps](#deployment-steps)
    - [Step 1 - Preparing the Docker Images](#step-1---preparing-the-docker-images)
    - [Step 2 - Login to the OpenShift Cluster](#step-2---login-to-the-openshift-cluster)
    - [Step 3 - Create Secrets and Clone Helm Charts](#step-3---create-secrets-and-clone-helm-charts)
    - [Step 4 - Configure OpenShift-Specific Settings in values.yaml](#step-4---configure-openshift-specific-settings-in-valuesyaml)
  - [All-in-One Deployment](#all-in-one-deployment)
  - [Distributed Deployment](#distributed-deployment)

## Prerequisites

Before you begin, ensure you have met the following requirements:

!!! info "Prerequisites"
    - [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
    - [Helm](https://helm.sh/docs/intro/install/) (version 3 or newer)
    - [OpenShift CLI (oc)](https://docs.openshift.com/container-platform/latest/cli_reference/openshift_cli/getting-started-cli.html)
    - [Kubernetes client (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
    - Access to an operational OpenShift cluster
    - [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/) (compatible with Git release nginx-0.22.0)
    - Access to a container registry accessible from your OpenShift cluster
    - Database server (MySQL, MSSQL, PostgreSQL, etc.) accessible from the OpenShift cluster

## Deployment Steps

### Step 1 - Preparing the Docker Images

To fully comply with OpenShift’s security model especially its use of arbitrary user IDs, user has to create a custom Docker image tailored for OpenShift environments. Following are the steps required for modifying the image to ensure compatibility, including how to set group ownership to the root group (GID 0), which allows access when OpenShift assigns a random UID at runtime.

The official WSO2 Docker images run as a non-root user with a fixed UID. While that works on standard Kubernetes clusters, OpenShift often injects a random UID and restricts container privileges. To prevent permission issues, update the image to:

1. Allow group write access to required directories
2. Assign root group ownership (GID 0)

Also 

1. Starting from v4.6.0, each component has a separate Docker image (All-in-one, Control-plane, Gateway, Traffic-manager).
2. These Docker images do not contain any database connectors; therefore, we need to build custom Docker images based on each Docker image in order to make the deployment work with a separate DB.
3. Download a connector which is compatible with the DB version and copy the connector while building the image

!!! example "Sample Dockerfile for All-in-One Image"
    ```dockerfile
    FROM wso2/wso2am:4.6.0

    # Change directory permissions for OpenShift compatibility
    USER root
    RUN chgrp -R 0 ${USER_HOME} && chmod -R g=u ${USER_HOME} \
        && chgrp -R 0 ${WSO2_SERVER_HOME} && chmod -R g=u ${WSO2_SERVER_HOME} \
        && chgrp -R 0 ${USER_HOME}/solr && chmod -R g=u ${USER_HOME}/solr
    USER wso2carbon

    # Copy JDBC MySQL driver
    COPY mysql-connector.jar ${WSO2_SERVER_HOME}/repository/components/lib
    ```

!!! info "Note"
    Changing the group is mandatory to allow OpenShift to assign arbitrary UIDs. 
    Ref: [a-guide-to-openshift-and-uids](https://www.redhat.com/en/blog/a-guide-to-openshift-and-uids), [group_ownership_and_file_permission](https://developers.redhat.com/blog/2020/10/26/adapting-docker-and-kubernetes-containers-to-run-on-red-hat-openshift-container-platform#group_ownership_and_file_permission)

After creating your Dockerfile:

1. Build the custom image:
   ```bash
   docker build -t <REGISTRY_URL>/<REPOSITORY>/<IMAGE_NAME>:<TAG> .
   ```

2. Push the image to your registry:
   ```bash
   docker push <REGISTRY_URL>/<REPOSITORY>/<IMAGE_NAME>:<TAG>
   ```

!!! warning "Important"
    Make sure to update the Helm chart configurations to use these modified images when deploying to OpenShift.


### Step 2 - Login to the OpenShift Cluster

First, authenticate to your OpenShift cluster using the OpenShift CLI:

!!! info "Authentication with OpenShift CLI"
    You can authenticate using one of the following methods:
    
    - **Username/Password Authentication**:
      ```bash
      oc login <API_SERVER_URL> -u <USERNAME> -p <PASSWORD>
      ```
      
    - **Token-Based Authentication**:
      ```bash
      oc login <API_SERVER_URL> --token=<TOKEN>
      ```

Once authenticated, verify your connection and check your currently selected project:

```bash
# Verify connection
oc whoami

# Check current project
oc project
```

### Step 3 - Create Secrets and Clone Helm Charts

1. **Create Keystore Secret**:

   Before deploying the Helm chart, create a Kubernetes secret containing the keystores and truststore:

   ```bash
   # Create a secret with default WSO2 keystores and truststores
   kubectl create secret generic apim-keystore-secret \
     --from-file=wso2carbon.jks \
     --from-file=client-truststore.jks
   ```

   !!! tip
       You can find the default keystore and truststore files in the `repository/resources/security/` directory of any WSO2 API-M distribution.

2. **Clone WSO2 Helm Charts Repository**:

   ```bash
   git clone https://github.com/wso2/helm-apim.git
   cd helm-apim
   ```

### Step 4 - Configure OpenShift-Specific Settings in values.yaml

In each `values.yaml` file for your deployment, make the following OpenShift-specific changes:

!!! info "Security Context Configuration"
    The following settings need to be applied to make your deployment compatible with OpenShift's security model:

1. **Update Security Context Settings**:

   | Setting | Description |
   |---------|-------------|
   | `runAsUser: null` | Allows OpenShift to assign arbitrary UIDs |
   | `seLinux.enabled: true/false` | Enables/disables SELinux support |
   | `enableAppArmor: false` | Disables AppArmor profiles |
   | `configMaps.scripts.defaultMode: "0457"` | Sets execute permissions for ConfigMaps |
   | `seccompProfile.type` | Controls which seccomp profile to apply |

   **Example Configuration**:

   ```yaml
   securityContext:
     # -- Set to null to allow OpenShift to assign arbitrary UIDs
     runAsUser: null
     # -- SELinux context configuration
     seLinux:
       enabled: false
       level: ""
     # -- Seccomp profile for the container
     seccompProfile:
       # -- Seccomp profile type (RuntimeDefault, Unconfined or Localhost)
       type: RuntimeDefault
       localhostProfile: ""
   # -- Disable AppArmor for OpenShift compatibility
   enableAppArmor: false
   # -- Set execute permissions for ConfigMaps
   configMaps:
     scripts:
       defaultMode: "0457"
   ```

## All-in-One Deployment

The All-in-One deployment is the simplest pattern to deploy WSO2 API Manager on OpenShift. This section provides detailed instructions for deploying the All-in-One pattern in an OpenShift environment.

### Step 1 - Prepare Configuration Values

1. **Navigate to the All-in-One Helm Chart Directory**:
   ```bash
   cd helm-apim/all-in-one
   ```

2. **Create a Custom Values File**:
   
   Create a file named `openshift-values.yaml` with your OpenShift-specific configurations:

   ```yaml
   # OpenShift-specific settings
   kubernetes:
     securityContext:
       runAsUser: null
       seLinux:
         enabled: false
       seccompProfile:
         type: RuntimeDefault
     enableAppArmor: false
     configMaps:
       scripts:
         defaultMode: "0457"
   
   # Database configuration
   wso2:
     apim:
       configurations:
         databases:
           apim_db:
             url: "jdbc:mysql://<DB_HOST>:3306/apim_db?useSSL=false"
             username: "apimadmin"
             password: "password"
           shared_db:
             url: "jdbc:mysql://<DB_HOST>:3306/shared_db?useSSL=false"
             username: "sharedadmin"
             password: "password"
       
       # Keystore configuration
       configurations:
         security:
           jksSecretName: "apim-keystore-secret"
   
   # Docker image configuration
   wso2:
     deployment:
       image:
         registry: "<YOUR_REGISTRY>"
         repository: "<YOUR_REPOSITORY>"
         tag: "<YOUR_TAG>"
         # If using private registry
         imagePullSecrets:
           enabled: true
           username: "<REGISTRY_USERNAME>"
           password: "<REGISTRY_PASSWORD>"
   ```

!!! warning "Important"
    Replace the placeholders with your actual values:
    - `<DB_HOST>`: Your database host address
    - `<YOUR_REGISTRY>`, `<YOUR_REPOSITORY>`, `<YOUR_TAG>`: Your OpenShift-compatible image details
    - `<REGISTRY_USERNAME>`, `<REGISTRY_PASSWORD>`: Your private registry credentials (if applicable)

### Step 2 - Deploy Using Helm

1. **Create a Namespace**:
   ```bash
   oc create namespace wso2
   ```

2. **Deploy with Helm**:
   ```bash
   helm install apim wso2/wso2am-all-in-one \
     --namespace wso2 \
     --create-namespace \
     --version 4.6.0-1 \
     -f openshift-values.yaml
   ```

   Alternatively, if you want to use the default OpenShift configuration:

   ```bash
   helm install apim wso2/wso2am-all-in-one \
     --namespace wso2 \
     --create-namespace \
     --version 4.6.0-1 \
     --set wso2.subscription.username=<USERNAME> \
     --set wso2.subscription.password=<PASSWORD> \
     -f https://raw.githubusercontent.com/wso2/helm-apim/main/docs/am-pattern-0-all-in-one/default_openshift_values.yaml
   ```

### Step 3 - Verify Deployment

1. **Check Deployment Status**:
   ```bash
   oc get pods -n wso2
   ```

2. **Check Services and Routes**:
   ```bash
   # List services
   oc get svc -n wso2
   
   # List routes
   oc get routes -n wso2
   ```

!!! note "Access and Exposure"
    By default, the deployment will create Kubernetes services but not OpenShift routes. You may need to create routes to expose the API Manager services externally:
    
    ```bash
    oc create route passthrough apim-publisher \
      --service=apim-wso2am-service \
      --port=9443 \
      --hostname=publisher.apim.example.com \
      -n wso2
    ```


## Distributed Deployment

For distributed deployments of WSO2 API Manager on OpenShift, you need to apply the same OpenShift-specific configurations to each component of your chosen pattern:

### Step 1 - Select an Appropriate Pattern

Review the [WSO2 API-M Deployment Patterns](../kubernetes/kubernetes-overview.md) and choose the pattern that suits your requirements:

- [Pattern 1: HA All-in-One Deployment](../kubernetes/am-pattern-1-all-in-one-ha.md)
- [Pattern 2: All-in-One with Gateway](../kubernetes/am-pattern-2-all-in-one-gw.md) 
- [Pattern 3: Control Plane with Traffic Manager and Gateway](../kubernetes/am-pattern-3-acp-tm-gw.md)
- [Pattern 4: Control Plane with Traffic Manager, Gateway and Key Manager](../kubernetes/am-pattern-4-acp-tm-gw-km.md)
- [Pattern 5: API-M Deployment with Simple Scalable Setup](../kubernetes/am-pattern-5-all-in-one-gw-km.md)

### Step 2 - Configure Each Component

For each component in your selected pattern:

!!! info "Component Configuration"
    Each component requires the same OpenShift-specific configurations:

    1. **Custom Docker Images**: Build OpenShift-compatible images for each component
    2. **Security Context**: Apply the same security context settings as described in [Step 4](#step-4---configure-openshift-specific-settings-in-valuesyaml)
    3. **Database Connections**: Configure the database connections for each component
    4. **Service and Route Configuration**: Configure services and routes appropriate for OpenShift

**Example Component Configuration**:

```yaml
# OpenShift security context settings for Control Plane component
kubernetes:
  securityContext:
    runAsUser: null
    seLinux:
      enabled: false
    seccompProfile:
      type: RuntimeDefault
  enableAppArmor: false
  configMaps:
    scripts:
      defaultMode: "0457"
```

### Step 3 - Deploy Components in Order

Deploy components in the correct order, typically:

1. **Control Plane/All-in-One**:
   ```bash
   helm install apim wso2/wso2am-acp \
     --namespace wso2 \
     --create-namespace \
     --version 4.6.0-1 \
     -f control-plane-openshift-values.yaml
   ```

2. **Traffic Manager** (if applicable):
   ```bash
   helm install tm wso2/wso2am-tm \
     --namespace wso2 \
     --create-namespace \
     --version 4.6.0-1 \
     -f tm-openshift-values.yaml
   ```

3. **Key Manager** (if applicable): 
   ```bash
   helm install km wso2/wso2am-km \
     --namespace wso2 \
     --version 4.6.0-1 \
     -f km-openshift-values.yaml
   ```

4. **Gateway**:
   ```bash
   helm install gw wso2/wso2am-universal-gw \
     --namespace wso2 \
     --version 4.6.0-1 \
     -f gw-openshift-values.yaml
   ```

!!! tip "Deployment Best Practices"
    - **Namespace Strategy**: Use separate namespaces for different environments (dev, test, prod)
    - **Resource Management**: Configure appropriate resource limits and requests for your OpenShift cluster
    - **Health Monitoring**: Configure appropriate liveness and readiness probes for each component
    - **Persistence**: Use persistent volumes for any stateful components
    - **Route Configuration**: Set up OpenShift routes with proper TLS termination for external access
    - **Integration**: Configure integration with OpenShift monitoring and logging stacks

## Troubleshooting OpenShift Deployments

When deploying WSO2 API Manager on OpenShift, you might encounter some common issues. Here are solutions to the most frequent problems:

### Permission Denied Errors

**Symptom**: Pods fail to start with permission denied errors in the logs.

**Solution**: This typically happens because OpenShift runs containers with random UIDs. Check that:

1. Your custom Docker images have the proper group permissions:
   ```bash
   # Check container logs
   oc logs <pod-name> -n <namespace>
   ```

2. Verify your security context settings in the values.yaml:
   ```bash
   # Ensure runAsUser is set to null
   oc get deployment <deployment-name> -n <namespace> -o yaml | grep -A 10 securityContext
   ```

### Image Pull Errors

**Symptom**: Pods are stuck in "ImagePullBackOff" or "ErrImagePull" states.

**Solution**:

1. Ensure your image repository is accessible from OpenShift:
   ```bash
   # Check image pull secrets
   oc get secrets -n <namespace>
   ```

2. Verify registry credentials:
   ```bash
   # Create or update image pull secret
   oc create secret docker-registry regcred \
     --docker-server=<your-registry-server> \
     --docker-username=<your-username> \
     --docker-password=<your-password> \
     --docker-email=<your-email> \
     -n <namespace>
   ```

### Volume Mount Issues

**Symptom**: Pods crash with volume-related errors.

**Solution**:

1. Ensure any persistent volume claims are bound:
   ```bash
   oc get pvc -n <namespace>
   ```

2. Check volume permissions:
   ```bash
   # Update deployment to allow writing to volumes
   oc patch deployment <deployment-name> -n <namespace> \
     -p '{"spec":{"template":{"spec":{"securityContext":{"fsGroup":0}}}}}'
   ```

### Network Policy Issues

**Symptom**: Components cannot communicate with each other.

**Solution**: OpenShift uses network policies that might block inter-service communication.

1. Check current network policies:
   ```bash
   oc get netpol -n <namespace>
   ```

2. Create a permissive network policy for API-M components:
   ```bash
   oc apply -f - <<EOF
   apiVersion: networking.k8s.io/v1
   kind: NetworkPolicy
   metadata:
     name: allow-wso2-internal
     namespace: <namespace>
   spec:
     podSelector:
       matchLabels:
         app: wso2am
     ingress:
     - from:
       - podSelector:
           matchLabels:
             app: wso2am
   EOF
   ```