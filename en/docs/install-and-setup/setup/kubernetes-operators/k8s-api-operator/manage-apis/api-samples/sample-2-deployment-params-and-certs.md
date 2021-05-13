# Sample 2 - Deployment Params and Certs

Let's deploy a backend using Target Endpoint resource on your Kubernetes environment and apply API management.

## Prerequisites

 -  Install a [Kubernetes](https://kubernetes.io/docs/setup/) cluster and **v1.14+** client. Alternatively,
    you can [run Kubernetes locally via Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).
 -  Install [Docker](https://docs.docker.com/).
 -  Install the [Kubernetes API Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install).
 -  Setup Choreo Connect
    1.  Download the Choreo Connect v0.9.0 from
        [github release page's](https://github.com/wso2/product-microgateway/releases/tag/v0.9.0) assets and extract them
        to a folder of your choice. We will refer to this folder as the `CHOREO-CONNECT_HOME`.
    
    2.  Using the kubectl tool, apply Kubernetes configurations for Choreo Connect.
    
        ```bash
        kubectl apply -f <CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect
        ```

 -  Install API controller
    Download the api controller (apictl) from the 
    [github release page's](https://github.com/wso2/product-apim-tooling/releases/tag/v4.0.0) assets and 
    extract them to a folder of your choice.

    ```bash
    export PATH=$PATH:<CLI_TOOL_EXTRACTED_LOCATION>
    ```

## Step 1: Initialize an API-CTL Project

```sh
apictl init cert-products \
    --oas https://raw.githubusercontent.com/wso2/k8s-api-operator/v2.0.0/scenarios/scenario-2-endpoint-cert-override/swagger.yaml
```

Let's zip the project and create the k8s ConfigMap "cert-products-cm".
```sh
zip -r cert-products.zip cert-products/
kubectl create cm cert-products-cm --from-file cert-products.zip
```

## Step 2: Create ConfigMap for Certs

```sh
openssl req -x509 -newkey rsa:4096 -nodes -days 365 \
    -subj "/O=wso2.com Inc./CN=cert-products" \
    -keyout products-certs.key \
    -out products-certs.crt
```

Create k8s ConfigMap "cert-products-certs".
```sh
kubectl create cm cert-products-certs \
    --from-file products-certs.crt
```

## Step 3: Create Params ConfigMap

Let's generate the deployment directory using apictl.

```sh
apictl k8s gen deployment-dir -s cert-products/
```

!!! note
    you can also use the API-CTL project zip to create deployment-dir.
    ```sh
    apictl k8s gen deployment-dir -s cert-products.zip
    ```

You can see a directory created with the name `DeploymentArtifacts_cert-products`. Edit the
`DeploymentArtifacts_cert-products/params_cm.yaml` file with the following content.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: cert-products-params
data:
  params.yaml: |
    environments:
        - name: production
          configs:
              endpoints:
                  production:
                    url: https://products-certs
                  sandbox:
                    url: https://products-certs
              certs:
                  - hostName: products-certs
                    alias: products-certs
                    path: products-certs.crt
```

Apply the edited ConfigMap to the cluster.
```sh
kubectl apply -f DeploymentArtifacts_cert-products/params_cm.yaml
```

## Step 4: Deploy API

You can see the API custom resource yaml file is generated with the directory previously created.
Apply it to the cluster.

```sh
kubectl apply -f DeploymentArtifacts_cert-products/api_crd.yaml
```
