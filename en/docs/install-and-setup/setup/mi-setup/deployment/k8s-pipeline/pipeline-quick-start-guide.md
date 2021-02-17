# Pipeline Quick Start Guide
Setting up a basic pipeline for WSO2 Micro Integrator on Kubernetes is
quick and simple.

Before you begin to develop your pipeline, set up the following
prerequisites in a running Kubernetes cluster.

## Prerequisites

  - Install and set up `Helm` (Supported version 2.14.3)

  - Install `Nginx` Ingress Controller Git
    release [nginx-0.22.0](https://github.com/kubernetes/ingress-nginx/releases/tag/nginx-0.22.0)

## Deploy the CI/CD pipeline

1.  [Download](https://raw.githubusercontent.com/wso2/kubernetes-pipeline/master/kubernetes-pipeline/samples/values-mi.yaml) the
    following `values-mi.yaml` file and replace the placeholders with
    their respective values.
    
      - `<REGISTRY_USERNAME>` - Docker organization name.
    
      - `<REGISTRY_PASSWORD>` - Docker password.
    
      - `<REGISTRY_EMAIL>` - Email address of Docker organization.
    
      - `<EMAIL>` - Email address notifications should be sent to in
        case of failure.
    
      - `<GITHUB_USERNAME>` - GitHub username.
    
      - `<GITHUB_PASSWORD>` - GitHub password.

2.  Add the `WSO2 helm repository`.
    ``` xml
    $ helm repo add wso2 https://helm.wso2.com
    
    $ helm repo update
    ```

3.  Install the pipeline Helm chart by pointing to the
    updated `values-mi.yaml` file.
    
    ``` bash
    $ helm install --name <RELEASE_NAME> wso2/kubernetes-pipeline --version 1.1.0 -f values-mi.yaml --namespace <NAMESPACE>
    ```   
    
    !!! Info
        The installation will take up to 10 minutes.
    
   

4.  Obtain the external IP (\`EXTERNAL-IP\`) of the Ingress resources by
    listing down the Kubernetes Ingresses.
   
    ``` bash
    $ kubectl get ing -n <NAMESPACE>
    ```
    
    | NAME                              | HOSTS                               |       ADDRESS |  PORTS | AGE |
    | --------------------------------  | ------------------------------------|---------------|--------|---- |
    | <RELEASE\_NAME\>-grafana          | grafana.example.com                 |<EXTERNAL\_IP\>|      80|  20m|
    | <RELEASE\_NAME\>-kibana           | kibana.example.com                  |<EXTERNAL\_IP\>|      80|  20m|
    | <RELEASE\_NAME\>-spinnaker-deck   | spinnaker.example.com               |<EXTERNAL\_IP\>| 80, 443|  20m|
    | <RELEASE\_NAME\>-spinnaker-gate   | gate.spinnaker.example.com          |<EXTERNAL\_IP\>| 80, 443|  20m|
    | jenkins-ingress                   | jenkins.example.com                 |<EXTERNAL\_IP\>| 80, 443|  20m|
    

5.  Add the above hosts as an entry in `/etc/hosts` as follows:
    
    `<EXTERNAL_IP>  grafana.example.com kibana.example.com
    spinnaker.example.com jenkins.example.com`

6.  Navigate to the following URLs on any web browser
    
      - Continuous Integration:`https://jenkins.example.com`
    
      - Continuous Delivery: `https://spinnaker.example.com`
    
      - Monitoring: `https://grafana.example.com`
    
      - Logging: `https://kibana.example.com`
