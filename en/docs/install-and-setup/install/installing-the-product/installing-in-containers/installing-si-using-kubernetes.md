# Installing Streaming Integrator Using Kubernetes

WSO2 Streaming Integrator can be deployed natively on Kubernetes via the Siddhi Kubernetes Operator.

The Streaming Integrator can be configured in the `<SI-TOOLING_HOME>/wso2/server/resources/decker/export/siddhi-process.yaml` file and passed to the CRD(Custom Resource Definition)for deployment.
Siddhi logic can be directly written in the `<SI-TOOLING_HOME>/wso2/server/resources/decker/export/siddhi-process.yaml` file or passed as `.siddhi` files via config maps.

To install WSO2 Streaming Integrator via Kubernetes, follow the steps below:

!!! tip "Before you begin:"
    Start a Kubernetes cluster. The Kubernetes version must be v1.10.11 or later. To start the cluster, you can use Minikube, GKE(Google Kubernetes Engine) Cluster, Docker for Mac, or any other Kubernetes cluster.<br/><br/>
     **Minikube**<br/><br/>
        You can install Minikube from the [Kubernetes/Minikube](https://github.com/kubernetes/minikube#installation)<br/><br/>
        Siddhi operator automatically creates NGINX ingress. Therefore, for it to work, you can do one of the following: <br/><br/>
        - Enable ingress on Minikube by issuing the following command.<br/><br/>
            `minikube addons enable ingress`<br/><br/>
        - Disable automatic ingress creation by the Siddhi operator. For instructions, see [Siddhi Kubernetes Microservice Documentation - Deploy Siddhi Applications without Ingress creation](https://siddhi.io/en/v5.0/docs/siddhi-as-a-kubernetes-microservice/#deploy-siddhi-apps-without-ingress-creation).<br/><br/>
     **GKE Cluster**<br/><br/>
        To install Siddhi operator, you have to give cluster admin permission to your account. In order to do this, issue the following command. You need to replace `your-address@email.com` with your account email address<br/><br/>
        `kubectl create clusterrolebinding user-cluster-admin-binding --clusterrole=cluster-admin --user=your-address@email.com`<br/><br/>
     **Docker for Mac**<br/><br/>
        Siddhi operator automatically creates NGINX ingress. Therefore, for it to work, you can do one of the following: <br/><br/>
        - Enable NGINX ingress. For instructions, see [NGINX Ingress Controller documentation](https://kubernetes.github.io/ingress-nginx/deploy/#docker-for-mac).<br/><br/>
        - Disable automatic ingress creation by the Siddhi operator. For instructions, see [Siddhi Kubernetes Microservice Documentation - Deploy Siddhi Applications without Ingress creation](https://siddhi.io/en/v5.0/docs/siddhi-as-a-kubernetes-microservice/#deploy-siddhi-apps-without-ingress-creation).<br/><br/>
    You are also required to have admin privileges to install the Siddhi operator.
        

## Install Siddhi Operator for Streaming Integrator

To install the Siddhi Kubernetes operator for WSO2 Streaming Integrator, issue the following commands.

```
kubectl apply -f https://github.com/wso2/streaming-integrator/tree/master/modules/kubenetes/00-prereqs.yaml
kubectl apply -f https://github.com/wso2/streaming-integrator/tree/master/modules/kubenetes/01-siddhi-operator.yaml
```

You can verify the installation by making sure the following deployments are running in your Kubernetes cluster.
```
$ kubectl get deployment

NAME                 DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
streaming-integrator   1         1         1            1           1m
siddhi-parser          1         1         1            1           1m
```

## Deploy Streaming Integrator

The Siddhi application that contains the streaming integration logic can be deployed in Kubernetes via the Siddhi operator.

To understand how this is done, let's create a very simple Siddhi stream processing application that consumes events via HTTP, filters the input events where the value for `deviceType` is `dryer` and the value for `power` is greater than `600`, and then logs the output in the console. This can be created by configuring the `<SI-TOOLING_HOME>/wso2/server/resources/decker/export/siddhi-process.yaml` file as given below.

```yaml
    apiVersion: siddhi.io/v1alpha2
    kind: SiddhiProcess
    metadata: 
      name: streaming-integrator
    spec: 
      apps: 
        - script: |
            @App:name("PowerSurgeDetection")
            @App:description("App consumes events from HTTP as a JSON message of { 'deviceType': 'dryer', 'power': 6000 } format and inserts the events into DevicePowerStream, and alerts the user if the power level is greater than or equal to 600W by printing a message in the log.")
            /*
                Input: deviceType string and powerConsuption int(Watt)
                Output: Alert user from printing a log, if there is a power surge in the dryer. In other words, notify when power is greater than or equal to 600W.
            */
            
            @source(
              type='http',
              receiver.url='${RECEIVER_URL}',
              basic.auth.enabled='false',
              @map(type='json')
            )
            define stream DevicePowerStream(deviceType string, power int);
            @sink(type='log', prefix='LOGGER')  
            define stream PowerSurgeAlertStream(deviceType string, power int); 
            @info(name='surge-detector')  
            from DevicePowerStream[deviceType == 'dryer' and power >= 600] 
            select deviceType, power  
            insert into PowerSurgeAlertStream;
      container: 
        env: 
          - 
            name: RECEIVER_URL
            value: "http://0.0.0.0:8080/checkPower"
          - 
            name: BASIC_AUTH_ENABLED
            value: "false"
```

To change the default configurations in WSO2 Streaming Integrator that are defined in the `<SI-TOOLING_HOME>/conf/server/deployment.yaml` file, you need to add he required configurations with the required over-riding values in the `SiddhiProcess.yaml` file under a section named `runner` as shown in the example below.

```yaml
    apiVersion: siddhi.io/v1alpha2
    kind: SiddhiProcess
    metadata: 
      name: streaming-integrator-app
    spec: 
      apps: 
        - script: |
            @App:name("PowerSurgeDetection")
            @App:description("App consumes events from HTTP as a JSON message of { 'deviceType': 'dryer', 'power': 6000 } format and inserts the events into DevicePowerStream, and alerts the user if the power level is greater than or equal to 600W by printing a message in the log.")
            /*
                Input: deviceType string and powerConsuption int(Watt)
                Output: Alert user from printing a log, if there is a power surge in the dryer. In other words, notify when power is greater than or equal to 600W.
            */
            
            @source(
              type='http',
              receiver.url='${RECEIVER_URL}',
              basic.auth.enabled='false',
              @map(type='json')
            )
            define stream DevicePowerStream(deviceType string, power int);
            @sink(type='log', prefix='LOGGER')  
            define stream PowerSurgeAlertStream(deviceType string, power int); 
            @info(name='surge-detector')  
            from DevicePowerStream[deviceType == 'dryer' and power >= 600] 
            select deviceType, power  
            insert into PowerSurgeAlertStream;
      container: 
        env: 
          - 
            name: RECEIVER_URL
            value: "http://0.0.0.0:8080/checkPower"
          - 
            name: BASIC_AUTH_ENABLED
            value: "false"
            
      runner: |
        auth.configs:
          type: 'local'        # Type of the IdP client used
          userManager:
            adminRole: admin   # Admin role which is granted all permissions
            userStore:         # User store
              users:
              -
                user:
                  username: root
                  password: YWRtaW4=
                  roles: 1
              roles:
              -
                role:
                  id: 1
                  displayName: root
          restAPIAuthConfigs:
            exclude:
              - /simulation/*
              - /stores/* 
```

Here, you have included a configuration for `auth.configs` to over-ride the default values that are applicable to the Streaming Integrator (i.e., vlues configured under `auth.configs` in the `<SI-TOOLING_HOME>/conf/server/deployment.yaml` file.

To apply the configurations in the `siddhi-process.yaml` to your Kubernetes cluster, save the file in a preferred location and then issue the following command.

```
kubectl apply -f <PATH_to_siddhi-process.yaml>
```

### Invoke Siddhi Applications

To invoke Siddhi Applications, follow the steps below:

1. To obtain the external IP of the Ingress load balancer, issue the following command.
    
    `kubectl get ingress`
    
    This generates a response similar to the following:
    
    ```
    NAME      HOSTS     ADDRESS     PORTS     AGE
    siddhi    siddhi    10.0.2.15    80       14d
    ```
     
2. Add the host (i.e., `siddhi`) and the related external IP (i.e., `ADDRESS`) in the `/etc/hosts` file in your machine.

    !!! info
        For Minikube, you have to use Minikube IP as the external IP. Therefore, issue the `minikube ip` command to get the IP of the Minikube cluster.

3. To send events to the `PowerSurgeDetection` deployed in Kubernetes, issue the following CURL command.

    ```
    curl -X POST \
      http://siddhi/streaming-integrator-0/8080/checkPower \
        -H 'Accept: */*' \
        -H 'Content-Type: application/json' \
        -H 'Host: siddhi' \
        -d '{
            "deviceType": "dryer",
            "power": 600
            }'
    ```   
    
4. To monitor the associated logs for the above Siddhi application, list down the available pods by executing the following command.
    
    `kubectl get pods`
    
    The pods are listed as shown in the following sample response.
    
    ```
    NAME                                        READY    STATUS    RESTARTS    AGE
    streaming-integrator-app-0-b4dcf85-npgj7     1/1     Running      0        165m
    streaming-integrator-5f9fcb7679-n4zpj        1/1     Running      0        173m
    ```

5. Issue the following command in order to monitor the logs of the relevant pod. In this example, let's assume that you need to monitor the logs for the `streaming-integrator-app-0-b4dcf85-npgj7` pod.

    `kubectl logs -f streaming-integrator-app-0-b4dcf85-npgj7`

!!! info 
    For more details about the Siddhi Operator, see [Siddhi as a Kubernetes Microservice](https://siddhi.io/en/v5.0/docs/siddhi-as-a-kubernetes-microservice/#!).