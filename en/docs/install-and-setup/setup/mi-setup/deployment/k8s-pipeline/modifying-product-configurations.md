# Modifying Product Configurations

## Modify the Product Configurations in efficient manner.

This document assumes that you have completed the instructions in the
following pages.

1.  [Pipeline Quick Start Guide](../pipeline-quick-start-guide/)

2.  [Testing The Pipeline Environment](../testing-the-pipeline-environment/)

3.  [Deploy Your Own Artifact](../deploy-your-own-artifact/)

If the above requirements are satisfied let’s start modifying product
configuration in a step by step manner

Create a fork of the [Sample Chart
Source Repository](https://github.com/wso2-incubator/cicd-sample-chart-mi).
Create a clone of the forked chart source repository as follows.
    
   ``` xml
    $ git clone https://github.com/[git-username]/cicd-sample-chart-mi.git
    
   ```
Replace the `[git-username]` tag with the name of your GitHub username.

2.  Apply overridden configurations as environment variables. 
    
    For example, if you want to change the Hostname to
    `localhost-sample` (in deployment.toml file) in the WSO2 Micro
    Integrator product pack in the Dev environment.
    
    1.  Define an environment variable **HOSTNAME** in
        the **`cicd-sample-chart-mi > micro-integrator/values-dev.yaml`**
        file under `wso2.deployment.wso2microIntegrator.env` as shown
        below  
        
        [ ![Host-Name](../../../assets/img/k8s_pipeline/modify-product/modify-pro1.png)](../../../assets/img/k8s_pipeline/modify-product/modify-pro1.png)
    
    2.  Change the chart data in the
        sample [values](https://raw.githubusercontent.com/wso2/kubernetes-pipeline/master/kubernetes-pipeline/samples/values-mi.yaml) file
        used in the [Pipeline Quick Start
        Guide](../pipeline-quick-start-guide/) to
        use in the custom chart.
        
        ``` xml
        applications:
        - name: wso2mi
          email: <EMAIL>
          testScript:
            path: tests
            command: test.sh
          chart:
            customChart: false
            name: micro-integrator
            version: 1.2.0-1
            repo: 'https://github.com/[git-username]/cicd-sample-chart-mi'
        ```
    
    3.  Upgrade the Helm chart with the command below, providing the
        modified sample values file.
        
        
        ``` xml
        $ helm upgrade <RELEASE_NAME> wso2/kubernetes-pipeline -f values-mi.yaml
        ```
        
        !!! Info
            This may take up to 10 minutes.
        
        
   **<RELEASE\_NAME\>** should be replaced with the release name
        provided when the pipeline is installed initially in the [Pipeline Quick Start
        Guide](../pipeline-quick-start-guide/).
   
   4.  Restart the Jenkins pod by deleting the existing pod. This will
        cause the cluster to spawn a new pod for Jenkins.
        
       ``` xml
        $ POD_NAME=`kubectl get pods --selector=app=jenkins -n <NAMESPACE> -o json -o jsonpath='{ .items[0].metadata.name }'`
        
        $ kubectl delete pod $POD_NAME -n <NAMESPACE>
       ```
        
      Replace **<NAMESPACE\>** with the namespace in your cluster.
    
   5.  Commit and push the changes in your forked chart source
        repository to master branch with the following commands
       
       ``` xml
            $ cd cicd-sample-chart-mi
        
            $ git add .
        
            $ git commit -m "Modify Hostname"
        
            $ git push origin master                  
       ```
        
   6.  Stop the manual judgment in any existing environments and watch
        the deployment of the setup with updated configurations being
        deployed in the Spinnaker dashboard.
        
   [ ![Stop Manual Judgement](../../../assets/img/k8s_pipeline/modify-product/modify-pro2.png)](../../../assets/img/k8s_pipeline/modify-product/modify-pro2.png)
   [ ![Stop Manual Judgement2](../../../assets/img/k8s_pipeline/modify-product/modify-pro3.png)](../../../assets/img/k8s_pipeline/modify-product/modify-pro3.png)
   [ ![Stop Manual Judgement3](../../../assets/img/k8s_pipeline/modify-product/modify-pro4.png)](../../../assets/img/k8s_pipeline/modify-product/modify-pro4.png)
        
3.  Refer to the environment variable **HOSTNAME** in the Docker
    Exporter project under the forked [CICD
    sample](https://github.com/wso2-incubator/cicd-sample-docker-mi) repository.
    
    1.  Update the deployment.toml file in the forked [CICD sample](https://github.com/wso2-incubator/cicd-sample-docker-mi) repository, **`cicd-sample-docker-mi>helloworldDockerExporter/deployment.toml`** to
        use the HOSTNAME environment variable.
   
        ``` xml
        [server]
        hostname = "$env{HOSTNAME}"
        
        [user_store]
        type = "read_only_ldap"
        
        [keystore.tls]
        file_name = "wso2carbon.jks"
        password = "wso2carbon"
        alias = "wso2carbon"
        key_password = "wso2carbon"
        
        [truststore]
        file_name = "client-truststore.jks"
        password = "wso2carbon"
        alias = "symmetric.key.value"
        algorithm = "AES"
        ```

    
   2.  Commit and push the changes into your forked CICD sample
        repository.
    
   3.  Stop the manual judgment in any existing environments and watch
        the deployment of the setup with updated configurations being
        deployed in the Spinnaker
        dashboard.
        
   [ ![Manual Judgment1](../../../assets/img/k8s_pipeline/modify-product/modify-pro5.png)](../../../assets/img/k8s_pipeline/modify-product/modify-pro5.png)
   [ ![Manual Judgment2](../../../assets/img/k8s_pipeline/modify-product/modify-pro6.png)](../../../assets/img/k8s_pipeline/modify-product/modify-pro6.png)
   [ ![Manual Judgment3](../../../assets/img/k8s_pipeline/modify-product/modify-pro7.png)](../../../assets/img/k8s_pipeline/modify-product/modify-pro7.png)
