# Observability Overview

Observability can be viewed as a superset of monitoring where monitoring is enriched with capabilities to perform debugging and profiling through rich context, log analysis, correlation, and tracing. Modern day observability resides on three pillars of **logs**, **metrics**, and **tracing**. Modern businesses require observability systems to self-sufficiently emit their current state(overview), generate alerts for any abnormalities detected to proactively identify failures, and to provide information to find the root causes of a system failure.

WSO2 Enterprise Integrator 7.0.0 and older versions offer an analytics distribution that mainly provides business analytics functionality together with a few observability related features. Clients with comprehensive observability requirements had to rely on external tools/stacks such as ELK, Prometheus, AppDynamics, Jaeger, Zipkin, etc. This resulted in multiple scattered systems to observe the system where debugging and troubleshooting were not  sufficiently stream-lined.

The current observability solution avoids this limitation by utilizing a selected set of external tools together with the older analytic distribution intact. This section explains the features and usage of both solutions. 

The older analytics distribution is referred to as the Classic Observability Deployment, and the newer solution (introduced with WSO2 Enterprise Integrator 7.1.0) is the Cloud Native Observability Deployment.

- **Classic Observability Deployment**

    This solution is more suitable in the following scenarios:
    
    - If you require more business analytics and less operation observability.
    
    - If you want a simpler deployment
    
    - If you already have an observability stack such as ELK

- **Cloud Native Observability Deployment**

    This solution is more suitable in the following scenarios:

    - If you are creating a new cloud native deployment
    
    - If you have Prometheus, Grafana and Jaeger as you in-house monitoring and observability tools.
    



