# K8s Deployment Sample 3: JMS Sender/Receiver

Let's define a JMS (sender and receiver) scenario using WSO2 Micro Integrator and deploy it on your Kubernetes environment.

## Prerequisites

-   Install and set up [WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
-   Install a [Kubernetes](https://kubernetes.io/docs/setup/) cluster and **v1.11+** client. Alternatively, you can [run Kubernetes locally via Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).
-   Install [Docker](https://docs.docker.com/).
-   Install the [Kubernetes API Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install).

-   Deploy an ActiveMQ pod inside your Kubernetes cluster.

## Step 1 - Create the integration solution

Follow the steps given below.

1.  Open WSO2 Integration Studio.
2.  In the <b>Getting Started</b> view, click <b>New Integration Project</b>

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/getting-started-integration-proj.png">

3.  In the <b>New Integration Project</b> dialog box, give a name for the integration project and select the following check boxes: <b>Create ESB Configs</b>, <b>Create Composite Exporter</b>, and <b>Create Kubernetes Exporter</b>.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/esb-config.png" width="500" alt="Create ESB Config Project">

4.  Click <b>Next</b> and enter the following details for your <b>Kubernetes Exporter</b>.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/integration-proj-k8s.png" width="500" alt="Create Kubernetes Project">

    <table>
            <tr>
                <th>
                    Parameter
                </th>
                <th>
                    Description
                </th>
            </tr>
            <tr>
                <td>
                    Kubernetes Exporter Name
                </td>
                <td>
                   Give a unique name for the project. 
                </td>
            </tr>
            <tr>
                <td>
                    Integration Name
                </td>
                <td>
                    This name will be used to identify the integration solution in the kubernetes custom resource. Let's use <code>jms-example</code> as the integration name for this example.
                </td>
            </tr>
            <tr>
                <td>
                    Number of Replicas
                </td>
                <td>
                    Specify the number of pods that should be created in the kubernetes cluster.
                </td>
            </tr>
            <tr>
                <td>
                    Base Image Repository
                </td>
                <td>
                    Specify the base Micro Integrator Docker image for your solution. For this example, let's use the Micro Integrator docker image from the WSO2 public docker registry: <b>wso2/wso2mi</b>.</br></br>
                    Note that the image value format should be 'docker_user_name/repository_name'.
                </td>
            </tr>
            <tr>
                <td>
                    Base Image Tag
                </td>
                <td>
                    Give a tag name for the base Docker image.
                </td>
            <tr>
                <td>
                    Target Image Repository
                </td>
                <td>
                    The Docker repository to which the Docker image will be pushed: 'docker_user_name/repository_name'.
                </td>
            </tr>
            <tr>
                <td>
                    Target Image Tag
                </td>
                <td>
                    Give a tag name for the Docker image.
                </td>
            </tr>
    </table>
    
3.  Add the following proxy service configuration to your project. This service listens to messages from ActiveMQ and publishes to another queue in ActiveMQ.

    1.  Right-click <b>ESB Config</b> in the project explorer, go to **New -> Proxy Service** and create a custom proxy service named `JmsSenderListener`. 

        <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/custom-proxy-service-jms.png" width="500" alt="Create ESB Config Project">

    2.  You can then use the **Source View** to copy the following configuration.

        !!! Tip
            Be sure to update the **tcp://localhost:61616** URL given below with the actual/connecting URL that will be reachable from the Kubernetes pod.

        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <proxy name="JmsSenderListener" startOnLoad="true" transports="jms" xmlns="http://ws.apache.org/ns/synapse">
            <target>
                <inSequence>
                    <send>
                        <endpoint>
                            <address uri="jms:/secondQueue?transport.jms.ConnectionFactoryJNDIName=QueueConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=failover:(tcp://localhost:61616,tcp://localhost:61617)?randomize=false&amp;transport.jms.DestinationType=queue">
                                <suspendOnFailure>
                                    <initialDuration>-1</initialDuration>
                                    <progressionFactor>-1</progressionFactor>
                                    <maximumDuration>0</maximumDuration>
                                </suspendOnFailure>
                                <markForSuspension>
                                    <retriesBeforeSuspension>0</retriesBeforeSuspension>
                                </markForSuspension>
                            </address>
                        </endpoint>
                    </send>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </target>
            <parameter name="transport.jms.SessionAcknowledgement">AUTO_ACKNOWLEDGE</parameter>
            <parameter name="transport.jms.Destination">$SYSTEM:destination</parameter>
            <parameter name="transport.jms.ConnectionFactoryType">firstQueue</parameter>
            <parameter name="transport.jms.ContentType">$SYSTEM:contenttype</parameter>
            <parameter name="java.naming.provider.url">$SYSTEM:jmsurl</parameter>
            <parameter name="transport.jms.SessionTransacted">false</parameter>
            <parameter name="transport.jms.ConnectionFactoryJNDIName">$SYSTEM:jmsconfac</parameter>
            <parameter name="transport.jms.UserName">$SYSTEM:jmsuname</parameter>
            <parameter name="transport.jms.Password">$SYSTEM:jmspass</parameter>
        </proxy>
        ```
        
4.  Open the **integration_cr.yaml** file inside the Kubernetes exporter and add the environment variables as shown below. These values will be injected to the parameters defined in the proxy service.

    !!! Tip
        Be sure to update the **tcp://localhost:61616** URL in the above configuration with the actual/connecting URL that will be reachable from the Kubernetes pod.

     ```yaml 
     ---
     apiVersion: "wso2.com/v1alpha2"
     kind: "Integration"
     metadata:
       name: "jms"
     spec:
       image: "Docker/image/path/to/the/JMSSenderListner"
       deploySpec:
         minReplicas: 1
       expose:
         passthroPort: 8290
       env:
       - name: "jmsconfac"
         value: "TopicConnectionFactory"
       - name: "jmsuname"
         value: "admin"
       - name: "destination"
         value: "queue"
       - name: "jmsurl"
         value: "tcp://localhost:61616"
       - name: "jmspass"
         value: "admin"
       - name: "contenttype"
         value: "application/xml"
     ```

Finally, the created Maven Multi Module project should look as follows:

<img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/jms_example_project.png" width="400" alt="Hello World Project">

## Step 2 - Update JMS configurations

1.  Uncomment the following two commands in the Dockerfile inside the Kubernetes project.
    ```bash
    COPY Libs/*.jar $WSO2_SERVER_HOME/lib/
    COPY Conf/* $WSO2_SERVER_HOME/conf/
    ```
2.  Download [Apache ActiveMQ](http://activemq.apache.org/).
3.  Copy the following client libraries from the `<ACTIVEMQ_HOME>/lib` directory to the `<MAVEN_MULTI_MODULE>/<KUBERNETES_PROJECT>/Lib` directory.

    **ActiveMQ 5.8.0 and above**
    
    -   activemq-broker-5.8.0.jar
    -   activemq-client-5.8.0.jar
    -   activemq-kahadb-store-5.8.0.jar  
    -   geronimo-jms_1.1_spec-1.1.1.jar
    -   geronimo-j2ee-management_1.1_spec-1.0.1.jar
    -   geronimo-jta_1.0.1B_spec-1.0.1.jar
    -   hawtbuf-1.9.jar
    -   Slf4j-api-1.6.6.jar
    -   activeio-core-3.1.4.jar (available in the <ACTIVEMQ_HOME>/lib/optional directory)  
     
    **Earlier version of ActiveMQ**
    
    -   activemq-core-5.5.1.jar
    -   geronimo-j2ee-management_1.0_spec-1.0.jar    
    -   geronimo-jms_1.1_spec-1.1.1.jar
    
4. Open the `deployment.toml` file in your Kubernetes project and add the following content to enable the JMS sender and listener:

    !!! Tip
        Be sure to update the **tcp://localhost:61616** URL in the above configuration with the actual/connecting URL that will be reachable from the Kubernetes pod.

    ```toml
    [server]
    hostname = "localhost"
    
    [keystore.primary]
    file_name = "wso2carbon.jks"
    password = "wso2carbon"
    alias = "wso2carbon"
    key_password = "wso2carbon"
    
    [truststore]
    file_name = "client-truststore.jks"
    password = "wso2carbon"
    alias = "symmetric.key.value"
    algorithm = "AES"
    
    [[transport.jms.listener]]
    name = "default"
    parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
    parameter.provider_url = "tcp://localhost:61616"
    parameter.connection_factory_name = "QueueConnectionFactory"
    parameter.connection_factory_type = "queue"
    
    [[custom_transport.sender]]
    protocol = "jms"
    class="org.apache.axis2.transport.jms.JMSSender"
    ```  

## Step 3 - Build and Push the Docker image

!!! Note
    Be sure to start your Docker instance before building the image. If Docker is not started, the build process will fail.
    
There are two ways to build a Docker image of the integration solution and push it to your Docker registry:

-   Using <b>Maven</b>:

    !!! Note "Before you begin"
            You need **Maven 3.5.2** or a later version when you build the Docker image manually (without using WSO2 Integration Studio).

    1.  Open a terminal and navigate to the integration project.
    2.  Execute the following command. 

        Be sure to specify the user name and password of the correct Docker registry.

        ```bash
        mvn clean install -Dmaven.test.skip=true -Ddockerfile.username={username} -Ddockerfile.password={password} 
        ```

    This will build the Docker image and then push it to the specified Docker registry.

-   Using <b>WSO2 Integration Studio</b>:
      
    1.  Open the **pom.xml** file in the Kubernetes exporter.    
    2.  Ensure that the composite exporter is selected under **Dependencies** and click <b>Build & Push</b>.

        <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/select-dependency-jms-example.png">

    3.  In the dialog box that opens, enter the credentials of your Docker registry to which the image should be pushed.

        <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/docker-registry-credentials.png" width="500" alt="docker registry credentials">

    4.  Click <b>Push Image</b>.

Run the `docker image ls` command to verify that the Docker image is created.

## Step 4 - Deploy the solution in K8s

!!! Info
    **Before you begin**, the [API Kubernetes Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install) should be installed in your kubernetes environment.

Follow the steps given below:

1.  Open the `integration_cr.yaml` file from the Kubernetes project in WSO2 Integration Studio.
2.  See that the **integration** details of the `jms-example` solution is updated.
3.  Open a terminal, navigate to the location of your `integration_cr.yaml` file, and execute the following command to deploy the integration solution into the Kubernetes cluster:
    ```bash
    kubectl apply -f integration_cr.yaml
    ``` 

When the integration is successfully deployed, it should create the `jms-example` integration, `jms-example-deployment`, `jms-example-service`, and `ei-operator-ingress` as follows:

!!! Tip
    The `ei-operator-ingress` is not created if you have [disabled the ingress controller]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-integrations/integration-deployments/#disable-ingress-controller-creation).

```bash
kubectl get integration

NAME          STATUS    SERVICE-NAME    AGE
jms-example   Running                   2m

kubectl get deployment

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
jms-example-deployment   1/1     1            1           2m

kubectl get services
NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)       AGE
jms-example-service      ClusterIP   10.101.107.154   <none>        8290/TCP      2m
kubernetes               ClusterIP   10.96.0.1        <none>        443/TCP       2d
k8s-api-operator         ClusterIP   10.98.78.238     <none>        443/TCP       1d

kubectl get ingress
NAME                   HOSTS                      ADDRESS     PORTS     AGE
api-operator-ingress   wso2ei.ingress.wso2.com    10.0.2.15   80, 443   2m
```

This will create a new queue called **queue** in ActiveMQ. 

## Step 5 - Test the deployment
     
Send a message to this queue. The proxy service you added in **step 3** above will listen to this message and send that message to a new queue called **secondQueue**.
