# Deploying the API Microgateway in Kubernetes

1.  Start the API Manager and log in to the API Publisher ( `          https://<hostname>:9443/publisher         ` ) using `          admin         ` as the username and password.
2.  Create an API with the following details:

    Field
    Sample value
    Name
    hello\_world - v1
    Context
    `                 /hello/v1                `

    Version
    1.0.0
    Access Control
    All
    Visibility on Store
    Public
    Production URL
    `                                                http://bk.test.com                                             `
    Tier Availability
    Gold, Unlimited


3.  Create a `           deployment.toml          ` file enabling Kubernetes deployment, service and config map resources.

    The config map is used to copy the `           micro-gw.conf          ` file.

    ``` java
        [kubernetes]
          [kubernetes.kubernetesDeployment]
            enable = true
            #name = ''
            #labels = ''
            #replicas = ''
            #enableLiveness = ''
            #initialDelaySeconds = ''
            #periodSeconds = ''
            #livenessPort = ''
            #imagePullPolicy = ''
            #image = ''
            #env = ''
            #buildImage = ''
            #copyFiles = ''
            #dockerHost = ''
            #dockerCertPath = ''
            #push = ''
            #username = ''
            #password = ''
            #baseImage = ''
            #singleYAML = ''
          [kubernetes.kubernetesService]
            enable = true
            #name = ''
            #labels = ''
            serviceType = 'NodePort'
            #port = ''
          [kubernetes.kubernetesConfigMap]
            enable = true
            ballerinaConf = '/home/user/wso2am-micro-gw-toolkit-2.5.0/resources/conf/micro-gw.conf'
            #[[kubernetes.kubernetesConfigMap.configMaps]]
            #    name = ''
            #    mountPath = ''
            #    readOnly = false
            #    data = ['']
    ```

    Let’s create a project called `           k8s_project          ` and provide the `           deployment.toml          ` file as an input.

4.  Navigate to the `           wso2am-micro-gw-toolkit-2.5.0/bin          ` directory and run the following command,

    ``` java
            ./micro-gw setup k8s_project -a hello_world -v v1 --deployment-config deployment.toml
    ```

    This commands creates the following folders under the `           k8s_project          ` folder.

    `           ├── k8s_project          `

    `           │   ├── conf          `

    `           │   │ └── deployment-config.toml          `

    `           │   ├── src          `

    `           │   │ ├── extension_filter.bal          `

    `           │   │ ├── hello_world_v1.bal          `

    `           │   │ ├── listeners.bal          `

    `           │   │ └── policies          `

    `           │   │    ├── application_10PerMin.bal          `

    `           │   │    ├── application_20PerMin.bal          `

    `           │   │    ├── application_50PerMin.bal          `

    `           │   │    ├── subscription_Bronze.bal          `

    `           │   │    ├── subscription_Gold.bal          `

    `           │   │    ├── subscription_Silver.bal          `

    `           │   │    ├── subscription_Unauthenticated.bal          `

    `           │   │    └── throttle_policy_initializer.bal          `

    `           │   ├── target          `

    `           │   └── temp          `

    `           │       └── hashes.json          `

5.  Build the project using the following command,

    ``` java
            ./micro-gw build k8s_project
    ```

    This generates the following Kubernetes resources.

    `           ├── k8s_project          `

    `           │   └── docker          `

    `           │       └── Dockerfile          `

    `           ├── k8s_project_config_map.yaml          `

    `           ├── k8s_project_deployment.yaml          `

    `           └── k8s_project_svc.yaml          `

    The docker image to be deployed in Kubernetes is created in your local registry. You can find the image `           k8s_project:latest          ` when you execute the docker images command.

6.  Deploy the docker image in a Kubernetes environment.


7.  You can also SCP the image to the Kubernetes nodes as follows:
    1.  Save the docker image to a `             tar            ` file. For example,

        ``` java
                docker save k8s_project:latest > image.tar
        ```

    2.  SCP the image to the Kubernetes nodes. For example,

        ``` java
                    scp -i <identity file> image.tar username@K8s_NODE_IP:
        ```

    3.  Load the docker image in the Kubernetes nodes. This needs to be executed in the Kubernetes nodes. For example,

        ``` java
                    docker load < image.tar
        ```

8.  Deploy the API Microgateway in Kubernetes by deploying the Kubernetes resources using the following command,

    ``` java
            kubectl create -f k8s_project/target/kubernetes/
    ```

9.  Access the API in HTTPS using the following details:

        !!! info
    The `           NodePort          ` service type has been used in Kubernetes. For that service type, you can access the API using any of the Kubernetes node IP addresses and node ports.

    `           https://<Any_Kubernetes_Node_IP>:<NodePort>/hello/v1/check          `

    You can use the `           kubectl get services          ` command to list down the services that run on Kubernetes.


    Node port - 32616

    URL - `           https://<Any_Kubernetes_Node_IP>:32616/hello/v1/check          `

    Headers - `           Authorization Bearer <JWT_TOKEN>          `

    Method - `           GET          `

!!! tip
As JWT is a self-contained access token, the Microgateway does not need to connect to the Key Manager. However, if you are using an Oauth2 access token, point the Microgateway to the Key Manager using the Key Manager details in the `         micro-gw.conf        ` configuration file of the Microgateway. If you are running Key Manager in Kubernetes, you can provide the Key Manager `         serverUrl        ` as shown below. The `         serverUrl        ` has to be accessible from the Microgateway pods.

``` java
    [keyManager]
    serverUrl="https://localhost:9443"
    username="admin"
    password="admin"
    tokenContext="oauth2"
    timestampSkew=5000
```


