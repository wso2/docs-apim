# Observability Deployment Strategy

The following diagram depicts the complete **cloud-native** observability solution for your Micro Integrator deployment, which includes **metrics monitoring**, **log monitoring**, and **message tracing** capabilities.

![Cloud Native Deployment Architecture]({{base_path}}/assets/img/integrate/monitoring-dashboard/cloud-native-deployment-architecture.png)

You can also set up different flavors of this solution depending on your requirement.

The cloud-native solution is more suitable in the following scenarios:

- You are creating a new cloud-native Micro Integrator deployment. 

	!!! Note
		See the instructions on setting up a cloud-native [Micro Integrator deployment on Kubernetes]({{base_path}}/install-and-setup/setup/mi-setup/deployment/kubernetes_deployment_patterns).

- You already have Prometheus, Grafana, and Jaeger as your in-house monitoring and observability tools. This applies to [VM deployments]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei) as well as [Kuberentes deployments]({{base_path}}/install-and-setup/setup/mi-setup/deployment/kubernetes_deployment_patterns).

### Technologies

The cloud-native observability solution is based on proven projects from the **Cloud Native Computing Foundation**, which makes the solution cloud native and not susceptible to changes in future trends. Following are the technologies used in the current solution:

| **Feature**   | **Technology**              |
|---------------|-----------------------------|
| Metrics       | Prometheus                  |
| Visualization | Grafana                     |
| Logging       | Log4j2, Fluent-Bit, and Grafana Loki |
| Tracing       | Jaeger                      |


### Minimum cloud-native observability

The basic deployment offers you metrics capabilities. You can set up the basic deployment with only Prometheus and Grafana to view and explore with the available Prometheus metrics.

![Cloud Native Deployment - Minimum]({{base_path}}/assets/img/integrate/monitoring-dashboard/cloud-native-observability-metrics.png)

### Log processing add on
 
Once you set up the basic deployment, you can integrate log-processing capabilities. To use this, you need to install **Fluent-Bit** as the logging agent and **Grafana Loki** as the log aggregator.

![Cloud Native Deployment with Logs]({{base_path}}/assets/img/integrate/monitoring-dashboard/cloud-native-observability-logs.png)

### Message tracing add on

Once you set up the basic deployment, you can integrate message tracing capabilities. To use this, you need to install **Jaeger**.  

![Cloud Native Deployment with Tracing]({{base_path}}/assets/img/integrate/monitoring-dashboard/cloud-native-observability-tracing.png)



## What's Next?

-	Set up <a href="{{base_path}}/observe/micro-integrator/setting-up-cloud-native-observability-on-a-vm">cloud-native observability on a VM</a>.
-	Set up <a href="{{base_path}}/observe/micro-integrator/setting-up-cloud-native-observability-in-kubernetes/">cloud-native observability on Kubernetes</a>.
