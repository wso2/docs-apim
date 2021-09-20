---
title: Micro Integrator Observability Overview - WSO2 API Manager 4.0.0
---

# Micro Integrator Observability Overview

This section explains how to set up the observability solutions and perform management tasks for the Micro Integrator.

### Observability solutions

There are two cloud-native observability solutions for the Micro Integrator; The Kubernetes based deployment and the VM based deployment.

<a href="{{base_path}}/assets/img/integrate/observability/observability-mi.png"><img src="{{base_path}}/assets/img/integrate/observability/observability-mi.png" title="Observability Solution" width="50%" alt="Observability Solution"/></a>

These solutions are suitable for the following combination of operations.

<table>
    <tr>
        <th><b>Observability solution</b></th>
        <th><b>Operations</b></th>
        <th><b>Description</b></th>
    </tr>
    <tr>
        <td>Kubernetes cloud-native solution</td>
        <td>
            <ul>
                <li>Metrics only</li>
                <li>Metrics + Logging</li>
                <li>Metrics + Tracing</li>
                <li>Metrics + Logging + Tracing</li>
            </ul>
        </td>
        <td>The default Kubernetes cloud-native solution comes with metrics enabled. You can also configure logging and tracing in combination with this. This solution is ideal if you want a complete cloud-native solution to observability and you already have Prometheus, Grafana, and Jaeger as your in-house monitoring and observability tools.
        </br>
        For more information, see the <a href="{{base_path}}/observe/micro-integrator/setting-up-cloud-native-observability-in-kubernetes">Getting Started Guide - K8s Deployment</a>.
        </td>
    </tr>
    <tr>
        <td>VM cloud-native deployment</td>
        <td>
            <ul>
                <li>Metrics only</li>
                <li>Logging (add-on)</li>
                <li>Tracing (add-on)</li>
            </ul>
        </td>
        <td>The default VM cloud-native solution comes with metrics enabled. You can additionally set up logging or tracing separately as part of this solution later. This solution is ideal if you want a complete cloud-native solution to observability, but you need to set this up on a VM. Ideally, you would already have Prometheus, Grafana, and Jaeger as your in-house monitoring and observability tools.
        </br>
        For more information, see the <a href="{{base_path}}/observe/micro-integrator/setting-up-cloud-native-observability-on-a-vm">Getting Started Guide - VM Deployment</a>.
        </td>
    </tr>
</table>

### Understanding observability solutions

Predecessors of the WSO2 Micro Integrator (i.e., WSO2 Enterprise Integrator 7.0.0 and older versions) offer an analytics distribution that mainly provides business analytics functionality together with a few observability related features. Clients with comprehensive observability requirements had to rely on external tools/stacks such as ELK, Prometheus, AppDynamics, Jaeger, Zipkin, etc. This resulted in multiple scattered systems to observe the system where debugging and troubleshooting were not sufficiently stream-lined.

The current observability solution utilizes a selected set of external tools together with the older analytic distribution intact. This section explains the features and usage of both solutions.
