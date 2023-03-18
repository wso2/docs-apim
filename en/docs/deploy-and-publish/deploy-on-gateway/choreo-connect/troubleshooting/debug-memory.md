# Debugging Memory Issues

As with any software product, there can be instances where WSO2 Choreo Connect cluster fails due to a memory resource exhaustion. The heap dumps will always point you towards the cause of the memory leak. Therefore, it is important to be able to retrieve heap dumps from an environment at the point when an error occurs. This will avoid the necessity of reproducing the exact issue again (particularly in the case of production issues). A resource exhaustion can happen for two reasons:

- Due to a bug in the system.
- An actual limitation of resources based on low configuration values.

Following sections will guide you on how to take heap dumps from each component of WSO2 Choreo Connect.

## Taking a heap dump of Adapter

The Adapter is implemented in Go lang and, therefore, it exposes standard `pprof` ([GO pprof pkg](https://pkg.go.dev/net/http/pprof)) based Go profiling endpoints in `localhost`.
Follow the steps below to take a heap dump of the Adapter.

1. Log into the Adapter container's shell or in Kubernetes, port-forward the port `6060` from Adapter to localhost. This step is required because Adapter's `pprof` endpoints are only exposed via localhost for safety.

    ```bash tab="Docker Compose"
    docker-compose exec adapter sh
    ```

    ```bash tab="Kubernetes"
    kubectl port-forward choreo-connect-adapter 6060:6060
    ```

1. Use the following command to get the heap dump into the 'heap.out' file.

    ```bash
    wget http://localhost:6060/debug/pprof/heap -O heap.out
    ```

1. View the memory dump in the browser by running the following command.

    ```bash
    go tool pprof -http=127.0.0.1:8000 heap.out
    ```

## Taking a heap dump of Enforcer

Enforcer is implemented in Java and it is configured with required parameters to dump the heap information when out of memory errors happen. The dump can be collected from `/home/wso2/logs/heap-dump.hprof`

## Taking a heap dump of Router

The Router uses the Envoy Proxy as the core component that does the traffic routing. The default Router that is used in your production environment does not support heap profiling and we have built a separate Router Docker image that enables heap profiling. Follow the steps below to take a heap profile of the Router.

### Prerequisites

1.  Install [pprof](https://github.com/google/pprof#readme) and [Graphviz](http://www.graphviz.org/) in your local machine. **pprof** is used to analyze the heap profile and **Graphviz** enables to analyze them with graphs.

2.  Build ***Router Debug Image***, if you are taking heap profile **on top of an updated Router image**.

    !!! note
        For the **GA version** of the Router Docker image, you can use `wso2am/choreo-connect-router:{{choreo_connect.version}}-debug-{{choreo_connect.envoy_version}}` as the **Router Debug Image**.

    1.  Create a Dockerfile as follows. Here we create a custom Docker image by replacing the envoy binary in default Docker image with heap profile enabled envoy binary.

        <!-- Following docker image "wso2am/choreo-connect-router" contains envoy version in its tag, it should be updated per router envoy version update -->

        ```Dockerfile tab="Format"
        FROM <ROUTER_DOCKER_IMAGE_WITH_WSO2_UPDATES>
        COPY --from=wso2am/choreo-connect-router:{{choreo_connect.version}}-debug-{{choreo_connect.envoy_version}} /usr/local/bin/envoy /usr/local/bin/envoy
        ```

        ```Dockerfile tab="Sample Dockerfile"
        FROM wso2/choreo-connect-router:{{choreo_connect.version}}.1 # for update level 1
        COPY --from=wso2am/choreo-connect-router:{{choreo_connect.version}}-debug-{{choreo_connect.envoy_version}} /usr/local/bin/envoy /usr/local/bin/envoy
        ```

    2. Build a Docker image and push it to a Docker registry that your Kubernetes cluster can pull it.

        ```bash tab="Format"
        docker build -t <DOCKER_REGISTRY>/<DEBUG_IMAGE_NAME>:<TAG> .
        ```

        ```bash tab="Sample"
        docker build -t sample.com/choreo-connect-router:{{choreo_connect.version}}.1-debug .
        ```

### Steps

1.  Change the Router Docker image with the built ***Router Debug Image*** and mount a directory to `/var/log/envoy` to collect head profile data.

    ```text tab="Docker Compose"
    Create directory named "profile-data".
    
    mkdir profile-data
    chmod 777 profile-data
    
    Update 'docker-compose.yaml' file as follows and start docker-compose setup.

    router:
      image: <DOCKER_REGISTRY>/<DEBUG_IMAGE_NAME>:<TAG> # change image name
      volumes:
        - ./profile-data:/var/log/envoy # append this volume
    ```

    ```text tab="K8s YAML"
    Update 'choreo-connect/choreo-connect-deployment.yaml' file as follows and apply it to the K8s cluster.

    spec:
      containers:
        - name: choreo-connect-router
          image: <DOCKER_REGISTRY>/<DEBUG_IMAGE_NAME>:<TAG>
          volumeMounts:
            - mountPath: /var/log/envoy
              name: router-heap-profile-data
      volumes:
        - name: router-heap-profile-data
          emptyDir: {}


    ```

    ```bash tab="K8s Helm"
    helm upgrade --install <RELEASE_NAME> wso2/choreo-connect --version {{choreo_connect.helm_chart.version}} --namespace <NAMESPACE> \
        --set wso2.deployment.gatewayRuntime.router.debug.heapProfile.mountEmptyDir=true \
        --set wso2.deployment.gatewayRuntime.router.dockerRegistry=<DOCKER_REGISTRY> \
        --set wso2.deployment.gatewayRuntime.router.imageName=<DEBUG_IMAGE_NAME> \
        --set wso2.deployment.gatewayRuntime.router.imageTag=<TAG>
    ```

2.  Expose the admin portal port (port 9000) to your local machine.

    ```text tab="Docker Compose"
    Already done in the default Docker Compose setup.
    ```

    ```bash tab="Kubernetes (for both YAML and Helm)"
    kubectl port-forward -n <NAMESPACE> svc/<K8S_ROUTER_SERVICE_NAME> 9000:9000
    ```
    
3.  Start/Deploy Choreo Connect.

4.  Start heap profiling. Execute the following command.
    ```bash
    curl -X POST -s "http://localhost:9000/heapprofiler?enable=y"
    ```

5.  End heap profiling. Execute the following command.
    ```bash
    curl -X POST -s "http://localhost:9000/heapprofiler?enable=n"
    ```

6.  Execute following commands to copy profile data and envoy binary to the directory `./profile-data` in you local machine.

    ```bash tab="Docker Compose"
    mkdir profile-data/lib
    docker compose cp router:/usr/local/bin/envoy profile-data/lib/envoy
    ```

    ```bash tab="Kubernetes (for both YAML and Helm)"
    export POD_NAME=<K8S_CHOREO_CONNECT_GATEWAY_RUNTIME_POD_NAME>
    export NAMESPACE=<NAMESPACE>

    kubectl cp -n $NAMESPACE $POD_NAME:/var/log/envoy profile-data -c choreo-connect-router
    kubectl cp -n $NAMESPACE $POD_NAME:/usr/local/bin/envoy profile-data/lib/envoy -c choreo-connect-router
    ```

7.  Analyze the heap profile in the browser by running the following command.
    ```bash
    pprof -http=localhost:8000 profile-data/lib/envoy profile-data/envoy.prof.*
    ```
