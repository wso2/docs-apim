# Modifying Pipeline Configurations

## Modifying values.yaml file to change configuration

The pipeline configurations can be changed by the modification of the
configurations in
the [values.yaml](https://github.com/wso2/kubernetes-pipeline/blob/master/kubernetes-pipeline/values.yaml) file
corresponding to the pipeline. The [sample
modifications](https://github.com/wso2/kubernetes-pipeline/tree/master/kubernetes-pipeline/samples)
for each product provide a good indication as to how these
configurations could be modified upon deployment. Once a configuration
change has been made, run the helm upgrade command to apply the changes.

``` bash
helm upgrade <RELEASE_NAME> wso2/kubernetes-pipeline --version 1.0.0 -f values.yaml
```
>

**<RELEASE\_NAME\>** should be replaced with the release name provided
when the pipeline is installed initially.

Configuration changes occur that will affect the Jenkins
deployment, some of which include:

  * Changes to the private Docker repository

  * Changes to the artifact source repository

  * Changes to the chart source repository

In these cases, the **Jenkins pod is restarted for these
configurations to be reflected**.

Following are some advanced configurations that could be done to
customize and secure the pipeline tools.

## Change Domain

To customize the domain name, override the host values as shown in the
example below.

``` yml
jenkins:
   ingress:
     host: jenkins.example.com

spinnaker:
   ingress:
     host: spinnaker.example.com

   ingressGate:
     host: gate.spinnaker.example.com

kibana:
   ingress:
     hosts:
     - kibana.example.com

prometheus-operator:
   grafana:
     ingress:
       hosts:
       - grafana.example.com
```

  **`example.com`** refers to the domain name


### Using Ingress with Secure Sockets Layer(SSL) / Transport Layer Security (TLS)

The WSO2 Kubernetes Pipeline resource uses the NGINX Ingress Controller
maintained by Kubernetes. Therefore, it is possible to use SSL/TLS
security layers by adding a certificate to be used with the ingress
controller.

This could be done using the following methods

  - Default SSL certificate
  - Add individual certificates

### Default SSL certificate

Refer to [NGINX Ingress Controller user
guide](https://kubernetes.github.io/ingress-nginx/user-guide/tls/#default-ssl-certificate)
on how to configure a default SSL certificate.

### Add individual certificates

To add individual certificates to each ingress endpoint,

1.  Create Kubernetes secret objects for each endpoint containing the
    certificate and the private key.  Refer [NGINX Ingress Controller user
    guide](https://kubernetes.github.io/ingress-nginx/user-guide/tls/#tls-secrets).

2.  Add the following content to your values.yaml with the secret and
    hostname.
    
    ``` yml
    jenkins:
      ingress:
        host: jenkins.example.com
        tls:
          - secretName: my-tls-cert
            hosts:
              - example.com
    
    spinnaker:
      ingress:
        host: spinnaker.example.com
        tls:
          - secretName: -tls
            hosts:
              - example.com
      ingressGate:
        host: gate.spinnaker.example.com
        tls:
         - secretName: -tls
           hosts:
             - example.com
    
    kibana:
      ingress:
        hosts:
          - kibana.example.com
        tls:
          - hosts:
              - example.com
            secretName: my-tls-cert
    
    prometheus-operator:
      grafana:
        ingress:
          hosts:
          - grafana.example.com
          tls:
            - hosts:
                - example.com
              secretName: my-tls-cert
    ```

    
    Replace **`example.com`**, **`my-tls-cert`** with your domain name
    and secret name respectively.


### Access private GitHub repositories

The use of private repositories are recommended when using WSO2
Kubernetes Pipeline. While it is possible to use the basic credentials
to authorize the pipeline to use these private repositories, we
recommend the use of Github personal access tokens since it provides
more control over the level of access.

1.  Create a personal access token as mentioned
    [here](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line).

2.  Add the username and personal access token to the values.yaml as
    shown below.
    
    ``` yml
    github:
      username: <GITHUB_USERNAME>
      password: <PERSONAL_ACCESS_TOKEN>
    ```


### Change credentials for Jenkins administrator

Jenkins starts as an administrative user by default. The password for
this account could be changed by overriding the relevant values in the
values.yaml

``` yml
jenkins:
  username: <JENKINS_USERNAME>
  password: <JENKINS_PASSWORD>
```


In addition to this, we need to configure Spinnaker to authenticate with
Jenkins since it would be used to run tests.

This could be done by overriding the additional scripts section to
change the default credentials indicated by `JENKINS_USERNAME` and
`JENKINS_PASSWORD`


``` yml
spinnaker:
  halyard:
    additionalScripts:
      create: true
      data:
        enable_ci.sh: |-
          echo "Configuring jenkins master"
          USERNAME="<JENKINS_USERNAME>"
          PASSWORD="<JENKINS_PASSWORD>"
          $HAL_COMMAND config ci jenkins enable
          echo $PASSWORD | $HAL_COMMAND config ci jenkins master edit master --address http://jenkins-service.{{ .Release.Namespace }}.svc.cluster.local:8080 --username $USERNAME --password || echo $PASSWORD | $HAL_COMMAND config ci jenkins master add master --address http://jenkins-service.{{ .Release.Namespace }}.svc.cluster.local:8080 --username $USERNAME --password
          $HAL_COMMAND config features edit --pipeline-templates true
```
### Enable remote Synapse Test Server
Run Unit Test Suites using a remote unit testing server.

1. Deploy Micro Integrator helm chart in synapse unit testing server mode with the following command
``` bash
helm install --name synapse-test  wso2/micro-integrator --version 1.2.0-3 --namespace <NAMESPACE> --set wso2.deployment.wso2microIntegrator.synapseTest.enabled=true
```
2. Obtain the Kubernetes service name(SVC_NAME) for the Helm release **synapse-test** 
``` bash
kubectl get svc -n <NAMESPACE> -l app=synapse-test
```

3. Construct the FQDN for the Kubernetes service as below
``` bash
<SVC_NAME>.<NAMESPACE>.svc.cluster.local
```
4. Enable remote synapse testing for the Pipeline 
``` yaml
applications:
- name: wso2mi
email: <EMAIL>
testScript:
    path: tests
    command: test.sh
chart:
    customChart: false
    name: micro-integrator
    version: 1.2.0-3
    repo: 'https://github.com/wso2-incubator/cicd-sample-chart-mi'
images:
    - organization: *reg_username
    repository: wso2mi
    deployment: wso2microIntegrator
    wso2microIntegrator:
        baseImage: 'wso2/wso2mi:1.2.0'
        gitRepository: 'https://github.com/wso2-incubator/cicd-sample-docker-mi'
    remoteSynapseTestServer:
        enabled: true
        hostname: <SVC_NAME>.<NAMESPACE>.svc.cluster.local
        port: 9008
```
