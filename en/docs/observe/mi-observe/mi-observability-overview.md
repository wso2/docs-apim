# Micro Integrator Observability Overview

This section explains how to set up the observability solutions and perform management tasks for the Micro Integrator.

### Observability solutions

There are two observability solutions for the Micro Integrator; The cloud-native observability deployment and the classic observability deployment.

<img src="{{base_path}}/assets/img/integrate/observability/observability-mi.png" title="Observability Solution" width="650" alt="Observability Solution"/>

The cloud-native and classic observability solution are suitable for the following combination of operations.

<table>
    <tr>
        <th>Observability solution</th>
        <th>Operations</th>
        <th>Description</th>
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
        <td>The default Kubernetes cloud-native solution comes with metrics enabled. You can also configure logging and tracing in combination with this. This solution is ideal if you want a complete cloud-native solution to observability and you already have Prometheus, Grafana, and Jaeger as your in-house monitoring and observability tools.</td>
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
        <td>The default VM cloud-native solution comes with metrics enabled. You can additionally set up logging or tracing separatly as part of this solution later. This solution is ideal if you want a complete cloud-native solution to observability, but you need to set this up on a VM. Ideally you would already have Prometheus, Grafana, and Jaeger as your in-house monitoring and observability tools.</td>
    </tr>
    <tr>
        <td>Classic deployment</td>
        <td>
            <ul>
                <li>Metrics only</li>
                <li>Tracing only</li>
                <li>Metrics and Tracing</li>
                <li>Logging separately</li>
            </ul>
        </td>
        <td>This solution uses the Analytics profile of WSO2 EI 6.x.x and if can be configured to have metrics and tracing by enabling them once set up. You will have to configure logging separately by setting it up in the Micro Integrator itself. This is useful if you require more business analytics and less operation observability and also if you already have an observability stack such as ELK.. This is a more simpler solution.</td>
    </tr>
</table>

* For instructions to set up the above observability solutions, see [Setting Up the cloud-native observability solutions]({{base_path}}/install-and-setup/setup/mi-setup/observability/setting-up-minimum-basic-observability-deployment) or [Setting up classic observability solution]({{base_path}}/install-and-setup/setup/mi-setup/observability/setting-up-classic-observability-deployment).

* For more information on how to use the cloud-native solution, see [Cloud Native Observability Solution]({{base_path}}/observe/mi-observe/cloud-native-observability-dashboards).

* For more information on how to use the classic observability solution, see [Classic Observability Deployment]({{base_path}}/observe/mi-observe/using-the-analytics-dashboard).

### Understanding observability solutions

Predecessors of the WSO2 Micro Integrator (i.e., WSO2 Enterprise Integrator 7.0.0 and older versions) offer an analytics distribution that mainly provides business analytics functionality together with a few observability related features. Clients with comprehensive observability requirements had to rely on external tools/stacks such as ELK, Prometheus, AppDynamics, Jaeger, Zipkin, etc. This resulted in multiple scattered systems to observe the system where debugging and troubleshooting were not sufficiently stream-lined.

The current observability solution utilizes a selected set of external tools together with the older analytic distribution intact. This section explains the features and usage of both solutions. 

The older analytics distribution is referred to as the Classic Observability Deployment, and the newer solution (introduced with WSO2 Enterprise Integrator 7.1.0) is the Cloud-Native Observability Deployment.

## Management

You can monitor and manage various artifacts that you have deployed. The following are the options that enable you to do this.

- **[Micro Integrator Dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard)**: Allows you to perform administration tasks related to your Micro Integrator deployment
- **[Using the Management API]({{base_path}}/observe/mi-observe/working-with-management-api)**: The CLI for the Micro Integrator of APIM 4.0.0 ([apictl]({{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl)) and the Micro Integrator dashboard communicate with this service to obtain administrative information of the server instance and to perform various administration tasks. If you are not using the dashboard or the CLI, you can directly access the resources of the management API

## Integration with external tools

You can integrate with external tools to do the following:

**Monitoring Metrics**

- [JMX Monitoring]({{base_path}}/observe/mi-observe/jmx_monitoring)
- [SNMP Monitoring]({{base_path}}/observe/mi-observe/snmp_monitoring)

**TCP Message Monitoring**

- [Starting TCPMon]({{base_path}}/observe/mi-observe/tcp/starting_tcp_mon)
- [Message Monitoring with TCPMon]({{base_path}}/observe/mi-observe/tcp/message_monitoring_with_tcpmon)
- [Other Usages of TCPMon]({{base_path}}/observe/mi-observe/tcp/other_usages_of_tcpmon)
