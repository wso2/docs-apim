# Monitoring Logs

Logging is one of the most important aspects of a production-grade
server. A properly configured logging system is vital for identifying
errors, security threats, and usage patterns.

By default, the Micro Integrator is configured to generate the basic log files that are required for monitoring the server. These log files are stored in the `<MI_HOME>/repository/logs` directory by default. 

## Before you begin

The following topics explain how you can use the default logs that are configured in the Micro Integrator. If you have additional logs configured,
you will be able to access those logs as well.

See [Configuring Logs]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties) for details on how logs are configured in the Micro Integator.

## Download Log Files

You can easily download them from the [Micro Integrator Dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard). 

!!! Info
    Alternatively, you can open the the log file from the `<MI_HOME>/repository/logs` directory.

1.  Sign in to the dashboard. 
2.  Click <b>Log Files</b> as shown below to view the complete list.

    <img alt="download log files" src="{{base_path}}/assets/img/integrate/monitoring-dashboard/log-files-dashboard.png" width="700">

3.  User the <b>Search</b> option to find a specific log file.
4.  Click the log file to download.

The default log files available on the dashboard are explained below.

## Monitoring Carbon logs

The Carbon log file (`wso2carbon.log`) covers all the management features of a product. These logs are printed to the console as defined in the log4j2 configurations.

Shown below is a sample log that is printed when you start the Micro Integrator with some integration artifacts deployed.

```bash
TID: [2020-09-24 23:00:04,634]  INFO {org.wso2.config.mapper.ConfigParser} - Initializing configurations with deployment configurations {org.wso2.config.mapper.ConfigParser}
[2020-09-24 23:00:09,292]  INFO {org.ops4j.pax.logging.spi.support.EventAdminConfigurationNotifier} - Logging configuration changed. (Event Admin service unavailable - no notification sent).
[2020-09-24 23:00:12,071]  INFO {org.apache.synapse.rest.API} - {api:HelloWorld} Initializing API: HelloWorld
[2020-09-24 23:00:12,075]  INFO {org.apache.synapse.deployers.APIDeployer} - API named 'HelloWorld' has been deployed from file : /Applications/IntegrationStudio.app/Contents/Eclipse/runtime/microesb/tmp/carbonapps/-1234/1600968612042TestCompositeApplication_1.0.0.car/HelloWorld_1.0.0/HelloWorld-1.0.0.xml
[2020-09-24 23:00:12,076]  INFO {org.wso2.micro.integrator.initializer.deployment.application.deployer.CappDeployer} - Successfully Deployed Carbon Application : helloworldCompositeExporter_1.0.0{super-tenant}
[2020-09-24 23:00:12,110]  INFO {org.apache.synapse.transport.passthru.core.PassThroughListeningIOReactorManager} - Pass-through HTTP Listener started on 0.0.0.0:8290
[2020-09-24 23:00:12,113]  INFO {org.apache.synapse.transport.passthru.core.PassThroughListeningIOReactorManager} - Pass-through HTTPS Listener started on 0.0.0.0:8253
[2020-09-24 23:00:12,114]  INFO {org.wso2.micro.integrator.initializer.StartupFinalizer} - WSO2 Micro Integrator started in 7.49 seconds
[2020-09-24 23:00:12,229]  INFO {org.apache.synapse.transport.passthru.core.PassThroughListeningIOReactorManager} - Pass-through EI_INTERNAL_HTTP_INBOUND_ENDPOINT Listener started on 0.0.0.0:9201
[2020-09-24 23:00:12,240]  INFO {org.apache.synapse.transport.passthru.core.PassThroughListeningIOReactorManager} - Pass-through EI_INTERNAL_HTTPS_INBOUND_ENDPOINT Listener started on 0.0.0.0:9164
[2020-09-24 23:00:14,616]  INFO {org.wso2.micro.integrator.management.apis.security.handler.AuthenticationHandlerAdapter} - User admin logged in successfully
```

## Monitoring API Logs

The API log file covers the logs related to APIs deployed in the Micro Integrator. By default, all APIs in the server will print logs to this common log file (`wso2-mi-api.log`). Shown below are some sample logs printed when the Healthcare API and the UserInfoRESTAPI is being used.

If you have [individual log files]({{base_path}}/integrate/develop/enabling-logs-for-api/) configured for APIs, you can download the log file that is specific to the API.

```bash
[2020-11-10 08:44:15,258]  INFO {API_LOGGER.UserInfoRestAPI} - Initializing API: UserInfoRestAPI
[2020-11-10 08:45:59,419]  INFO {API_LOGGER.UserInfoRestAPI} - MESSAGE = Request received to /users resource.
[2020-11-10 08:50:45,351]  INFO {API_LOGGER.UserInfoRestAPI} - Destroying API: UserInfoRestAPI
[2020-11-10 08:50:45,373]  INFO {API_LOGGER.HealthcareAPI} - Initializing API: HealthcareAPI
[2020-11-10 08:52:35,607]  INFO {API_LOGGER.HealthcareAPI} - Log Property message = "Welcome to HealthcareService"
[2020-11-10 08:57:45,457]  INFO {API_LOGGER.HealthcareAPI} - Destroying API: HealthcareAPI
[2020-11-10 08:57:45,477]  INFO {API_LOGGER.StockQuoteAPI} - Initializing API: StockQuoteAPI
[2020-11-10 08:57:49,400]  INFO {API_LOGGER.StockQuoteAPI} - Destroying API: StockQuoteAPI
```

## Monitoring Service Logs

The service log file covers the logs related to proxy services deployed in the Micro Integrator. By default, all services in the server will print logs to this common log file (`wso2-mi-service.log`). Shown below are some sample logs printed when the Healthcare API and the UserInfoRESTAPI is being used.

If you have [individual log files]({{base_path}}/integrate/develop/enabling-logs-for-services/) configured services, you can download the log file that is specific to the service.

```bash
[2020-10-14 10:16:15,399]  INFO {SERVICE_LOGGER.hl7testproxy} - Building Axis service for Proxy service : hl7testproxy
[2020-10-14 10:16:15,401]  INFO {SERVICE_LOGGER.hl7testproxy} - Adding service hl7testproxy to the Axis2 configuration
[2020-10-14 10:16:15,401]  INFO {SERVICE_LOGGER.hl7testproxy} - Successfully created the Axis2 service for Proxy service : hl7testproxy
[2020-10-14 10:26:16,335]  INFO {SERVICE_LOGGER.hl7testproxy} - Stopped the proxy service : hl7testproxy
[2020-10-14 10:37:21,790]  INFO {SERVICE_LOGGER.HL7Proxy1} - Building Axis service for Proxy service : HL7Proxy1
[2020-10-14 10:37:21,791]  INFO {SERVICE_LOGGER.HL7Proxy1} - Adding service HL7Proxy1 to the Axis2 configuration
[2020-10-14 10:37:21,791]  INFO {SERVICE_LOGGER.HL7Proxy1} - Successfully created the Axis2 service for Proxy service : HL7Proxy1
```

## Monitoring Error Logs

The Error log file (`wso2error.log`) contains the error logs that are generated when the server is running. Note that these logs are also printed to the console of the Micro Integrator.

Shown below is an example server error that is printed in the error log file.

```bash
[2020-10-14 10:26:16,361] ERROR {org.apache.synapse.deployers.ProxyServiceDeployer} - ProxyService named : HL7Proxy already exists
[2020-10-14 10:26:16,363] ERROR {org.apache.synapse.deployers.ProxyServiceDeployer} - ProxyService Deployment from the file : /Applications/IntegrationStudio.app/Contents/Eclipse/runtime/microesb/tmp/carbonapps/-1234/1602651376337TestCompositeApplication_1.0.0.car/HL7Proxy2_1.0.0/HL7Proxy2-1.0.0.xml : Failed. org.apache.synapse.deployers.SynapseArtifactDeploymentException: ProxyService named : HL7Proxy already exists
    at org.apache.synapse.deployers.AbstractSynapseArtifactDeployer.handleSynapseArtifactDeploymentError(AbstractSynapseArtifactDeployer.java:482)
    at org.apache.synapse.deployers.ProxyServiceDeployer.deploySynapseArtifact(ProxyServiceDeployer.java:66)
    at org.apache.synapse.deployers.AbstractSynapseArtifactDeployer.deploy(AbstractSynapseArtifactDeployer.java:204)
    at org.wso2.micro.integrator.initializer.deployment.synapse.deployer.SynapseAppDeployer.deployArtifactType(SynapseAppDeployer.java:1106)
    at org.wso2.micro.integrator.initializer.deployment.synapse.deployer.SynapseAppDeployer.deployArtifacts(SynapseAppDeployer.java:134)
    at org.wso2.micro.integrator.initializer.deployment.application.deployer.CappDeployer.deployCarbonApps(CappDeployer.java:141)
    at org.wso2.micro.integrator.initializer.deployment.application.deployer.CappDeployer.deploy(CappDeployer.java:99)
    at org.apache.axis2.deployment.repository.util.DeploymentFileData.deploy(DeploymentFileData.java:136)
    at org.apache.axis2.deployment.DeploymentEngine.doDeploy(DeploymentEngine.java:807)
    at org.apache.axis2.deployment.repository.util.WSInfoList.update(WSInfoList.java:153)
    at org.apache.axis2.deployment.RepositoryListener.update(RepositoryListener.java:377)
    at org.apache.axis2.deployment.RepositoryListener.checkServices(RepositoryListener.java:254)
    at org.apache.axis2.deployment.RepositoryListener.startListener(RepositoryListener.java:371)
    at org.apache.axis2.deployment.scheduler.SchedulerTask.checkRepository(SchedulerTask.java:59)
    at org.apache.axis2.deployment.scheduler.SchedulerTask.run(SchedulerTask.java:67)
    at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
    at java.util.concurrent.FutureTask.runAndReset(FutureTask.java:308)
    at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$301(ScheduledThreadPoolExecutor.java:180)
    at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:294)
    at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
    at java.lang.Thread.run(Thread.java:748)
```

## Monitoring Audit Logs

Audit logs are used for tracking the sequence of actions that affect a particular task carried out on the server.

## Monitoring Service/Event Tracing Logs 

These are logs that are enabled in the Micro Integrator for tracing services and events using a separate log file (`wso2carbon-trace-messages.log`).

## Monitoring HTTP Access Logs

HTTP access logs (requests and responses) help you monitor information such as the clients that access the product, how many hits are received, what the errors are, etc. This information is useful for troubleshooting errors.

In the Micro Integrator, access logs are generated for the PassThrough transport. The PassThrough transport works on 8290/8253 ports and is used for API/Service invocations. By default, all access logs from the PassThrough transport are written to a common access log file - `http_access_.log`.

!!! Note
    See [Configuring Access Logs]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties/#configuring-http-access-logs) for instructions on configuring access logs.

```xml
[10/Nov/2020:08:52:35.604 +0530] "GET /healthcare/querydoctor/surgery HTTP/1.1" - - "-" "curl/7.64.1"
[10/Nov/2020:08:52:35.610 +0530] "GET /healthcare/surgery HTTP/1.1" - - "-" "Synapse-PT-HttpComponents-NIO"
[10/Nov/2020:08:52:35.610 +0530] "- - " 200 - "-" "-"
[10/Nov/2020:08:52:35.604 +0530] "- - " 200 - "-" "-"
```

## Monitoring Patch Logs 

The Patch log file contain details related to patches applied to the product. Patch logs cannot be customized.

```bash
[2020-09-24 23:00:05,319]  FINE {org.wso2.micro.integrator.server.util.PatchUtils processPatches} - Checking for patch changes ...  
[2020-09-24 23:00:05,322]  FINE {org.wso2.micro.integrator.server.util.PatchUtils processPatches} - No new patch or service pack detected, server will start without applying patches   
[2020-09-24 23:00:05,323]  FINE {org.wso2.micro.integrator.server.util.PatchUtils checkMD5Checksum} - Patch verification started  
[2020-09-24 23:00:05,323]  FINE {org.wso2.micro.integrator.server.util.PatchUtils checkMD5Checksum} - Patch verification successfully completed  
[2020-10-14 10:16:07,812]  FINE {org.wso2.micro.integrator.server.util.PatchUtils processPatches} - Checking for patch changes ...  
[2020-10-14 10:16:07,815]  FINE {org.wso2.micro.integrator.server.util.PatchUtils processPatches} - No new patch or service pack detected, server will start 
```

## Monitoring Correlation Logs

Correlation logs are used for monitoring the round trip of a message that is sent to the Micro Integrator.

See [Monitoring Message Round Trip]({{base_path}}/observe/mi-observe/logs/monitoring-correlation-logs) for details.

## Monitoring Console Logs

When you run the Micro Integrator, the console will print logs from the [Carbon log file](#monitoring-carbon-logs) as well as the [Error log file](#monitoring-error-logs).

If you have enabled <b>wire logs</b>, these will also be printed on the console. See the instructions on how to [enable and use Wire Logs]({{base_path}}/integrate/develop/using-wire-logs/).