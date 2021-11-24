# Debugging Memory Issues

As with any software product, there can be instances where WSO2 Choreo Connect cluster fails due to a memory resource exhaustion. The heap dumps will always point you towards the cause of the memory leak. Therefore, it is important to be able to retrieve heap dumps from an environment at the point when an error occurs. This will avoid the necessity of reproducing the exact issue again (particularly in the case of production issues). A resource exhaustion can happen for two reasons:

- Due to a bug in the system.
- An actual limitation of resources based on low configuration values.

Following sections will guide you on how to take heap dumps from each component of WSO2 Choreo Connect.

## Taking a heap dump of Adapter

The Adapter is implemented in Go lang and, therefore, it exposes standard `pprof` ([GO pprof pkg](https://pkg.go.dev/net/http/pprof)) based Go profiling endpoints in `localhost`.
Follow the steps below to take a heap dump of the Adapter.

1. Log into the Adapter container's shell or in kubernetes, port-forward the port `6060` from Adapter to localhost. This step is required because Adapter's `pprof` endpoints are only exposed via localhost for safety.

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
