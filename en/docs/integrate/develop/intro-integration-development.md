# Developing Integration Solutions

The contents on this page will walk you through the topics related to developing integration solutions using WSO2 Integration Studio.

## WSO2 Integration Studio

WSO2 Integration Studio is the comprehensive developer tool, which you will use to <b>develop</b>, <b>build</b>, and <b>test</b> your integration solutions before the solutions are pushed to your production environments. See the topics given below for details.

<table>
	<tr>
		<td>
			<a href="{{base_path}}/integrate/develop/wso2-integration-studio">Quick Tour of WSO2 Integration Studio</a>
		</td>
		<td>
			Get introduced to the main functions of WSO2 Integration Studio.
		</td>
	</tr>
	<tr>
		<td>
			<a href="{{base_path}}/integrate/develop/installing-wso2-integration-studio">Installing WSO2 Integration Studio</a>
		</td>
		<td>
			Find the instructions on how to download and install the tool on your operating system.
		</td>
	</tr>
	<tr>
		<td>
			<a href="{{base_path}}/integrate/develop/troubleshooting-wso2-integration-studio">Troubleshooting WSO2 Integration Studio</a>
		</td>
		<td>
			Find details on how to troubleshoot errors you might encounter as you use WSO2 Integration Studio.
		</td>
	</tr>
</table>

## Development workflow

Integration developers will follow the workflow illustrated by the following diagram.

![developer workflow]({{base_path}}/assets/img/integrate/development_workflow.png)

### Set up the workspace

To start developing integration solutions, you need to first <a href="{{base_path}}/integrate/develop/installing-wso2-integration-studio">install and set up WSO2 Integration Studio</a>.

### Develop

-	Create projects and modules

	<table>
		<tr>
			<td>
				<a href="{{base_path}}/integrate/develop/create-integration-project/#integration-project">Create an Integration project</a>
			</td>
			<td>
				An integration project is a maven multi module project that will include all the modules (sub projects) of your integration solution.
			</td>
		</tr>
		<tr>
			<td>
				<a href="{{base_path}}/integrate/develop/create-integration-project/#sub-projects">Add sub projects to Integration project</a>
			</td>
			<td>
				Once you have created an integration project, you can add new sub projects if required.
			</td>
		</tr>
		<tr>
			<td>
				<a href="{{base_path}}/integrate/develop/create-integration-project/#moving-sub-projects-to-mmm-project">Move sub projects to Integration project</a>
			</td>
			<td>
				You can move sub projects to the required integration project from any location in the workspace.
			</td>
		</tr>
	</table>

-	Create artifacts

	<table>
		<tr>
			<td>
				<b>Message Entry Points</b>
				<ul>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-an-api/">REST API</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service/">Proxy Service</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint/">Inbound Endpoint</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-scheduled-task/">Scheduled Task</a>
					</li>
				</ul>
			</td>
			<td>
				<b>Message Processing Units</b>
				<ul>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store/">Message Store</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-a-message-processor/">Message Processor</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-endpoints/">Endpoint</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-endpoint-templates/">Endpoint Template</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-sequence-templates/">Sequence Template</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences/">Reusable Sequences</a>
					</li>
				</ul>
			</td>
			<td>
				<b>Registry Resources</b>
				<ul>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources/">Registry Resource</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/registry/creating-local-registry-entries/">Local Entry</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/creating-smooks-artifacts/">Smooks</a>
					</li>
				</ul>
			</td>
		<tr>
			<td>
				<b>Data Services Resources</b>
				<ul>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services/">Data Service</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/data-services/creating-datasources/">Datasource</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/data-services/creating-input-validators/">Input Validator</a>
					</li>
				</ul>
			</td>
			<td>
				<b>Custom Artifacts</b>
				<ul>
					<li>
						<a href="{{base_path}}/integrate/develop/customizations/creating-custom-mediators/">Custom Mediator</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/customizations/creating-custom-Inbound-endpoint/">Custom Inbound Enpoint</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/customizations/creating-new-connector/">Custom Connector</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/customizations/creating-custom-task-scheduling/">Custom Scheduled Task</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/customizations/creating-synapse-handlers/">Synapse Handler</a>
					</li>
				</ul>
			</td>
			<td>
				<b>Other</b>
				<ul>
					<li>
						<a href="{{base_path}}/integrate/develop/exporting-artifacts/">Export Artifacts</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/importing-artifacts/">Import Artifacts</a>
					</li>
				</ul>
			</td>
		</tr>
	</table>

-	Secure the artifacts

	<table>
		<tr>
			<td>
				<b>Encrypting Sensitive Data</b>
				<ul>
					<li>
						<a href="../../setup/security/encrypting_plain_text/">Encrpting Secrets</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/using_docker_secrets/">Docker Secrets</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/using_k8s_secrets/">Kubernetes Secrets</a>
					</li>
					<li>
						<a href="../../setup/security/single_key_encryption/">Symmetric Encryption</a>
					</li>
				</ul>
			</td>
			<td>
				<b>Securing APIs and Services</b>
				<ul>
					<li>
						<a href="{{base_path}}/integrate/develop/advanced-development/applying-security-to-an-api/">Securing REST APIs</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/advanced-development/applying-security-to-a-proxy-service/">Securing Proxy Services</a>
					</li>
					<li>
						<a href="{{base_path}}/integrate/develop/creating-artifacts/data-services/securing-data-services/">Securing Data Services</a>
					</li>
				</ul>
			</td>
		</tr>
	</table>

### Build and run

1.	<a href="{{base_path}}/integrate/develop/packaging-artifacts">Package</a>

	The artifacts and modules should be packaged in a <b>Composite Exporter</b> before it can be deployed in any environment.

2.	<a href="{{base_path}}/integrate/develop/deploy-artifacts">Deploy</a>

	You can easily deploy and try out the packaged integration artifacts on your preferred environment:

	<table>
		<tr>
			<td>
				<ul>
					<li>
						Deploy on the <a href="{{base_path}}/integrate/develop/using-embedded-micro-integrator">Embedded Micro Integrator</a>
					</li>
					<li>
						Deploy on a <a href="{{base_path}}/integrate/develop/using-remote-micro-integrator">Remote Micro Integrator</a>
					</li>
					<li>
						Deploy on <a href="{{base_path}}/integrate/develop/create-docker-project">Docker</a>
					</li>
					<li>
						Deploy on <a href="{{base_path}}/integrate/develop/create-kubernetes-project">Kubernetes</a>
					</li>
				</ul>
			</td>
		</tr>
	</table>

3.	<a href="{{base_path}}/integrate/develop/creating-unit-test-suite/#run-unit-test-suites">Unit Tests</a>

	Use the <b>integration test suite</b> of WSO2 Integration Studio to run unit tests on the developed integration solution.

### Iterate and improve

As you build and run the integration flow, you may identify errors that need to be fixed, and changes that need to be done to the synapse artifacts.

<table>
	<tr>
		<td>
			Debug Mediations
		</td>
		<td>
			Use the <a href="{{base_path}}/integrate/develop/debugging-mediation">Mediation Debug</a> function in WSO2 Integration Studio to debug errors while you develop the integration solutions.
		</td>
	</tr>
	<tr>
		<td>
			Using Logs
		</td>
		<td>
			You can enable and analyze the following logs to debug various errors:
			<ul>
				<li>
					<a href="{{base_path}}/integrate/develop/using-wire-logs">Wire Logs</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/develop/enabling-logs-for-services">Proxy Service Access Logs</a>
				</li>
				<li>
					<a href="{{base_path}}/integrate/develop/enabling-logs-for-api">REST API Access Logs</a>
				</li>
			</ul>
		</td>
	</tr>
</table>

You must redeploy the integration artifacts after applying changes.

-	If you are testing on a VM, the artifacts will be instantly deployed when you <a href="{{base_path}}/integrate/develop/deploy-artifacts">redeploy the synapse artifacts</a>.
-	If you are testing on containers, you need to rebuild the <a href="{{base_path}}/integrate/develop/create-docker-project">Docker images</a> or <a href="{{base_path}}/integrate/develop/create-kubernetes-project">Kubernetes artifacts</a>.

### Push to production

It is recommended to use a <b>CICD pipeline</b> to deploy your tested integration solutions in the production environment.

<table>
	<tr>
		<td>
			<b>On-Premise Environment</b>
		</td>
		<td>
			You can easily push your integration solutions to a CICD pipeline because the developer tool (WSO2 Integration Studio) consists of Maven support. See the details on <a href="{{base_path}}/integrate/develop/create-integration-project">Integration Project</a>.
		</td>
	</tr>
	<tr>
		<td>
			<b>Kubernetes Environment</b>
		</td>
		<td>
			If you have a <b>Kubernetes deployment</b>, see the instructions on how to use the <a href="../../setup/deployment/k8s-pipeline/overview">EI Kubernetes CICD pipeline</a>.
		</td>
	</tr>
</table>

## Related topics

<table>
	<tr>
		<td>
			<b><a href="{{base_path}}/integrate/develop/integration-development-kickstart">Develop your first integration</a></b>
		</td>
		<td>
			Try the development workflow end-to-end by running a simple use case.
		</td>
	</tr>
	<tr>
		<td>
			<b><a href="{{base_path}}/integrate/learn-overview">Integration Use Cases</a></b>
		</td>
		<td>
			Read about the integration use cases supported by the Micro Integrator of EI 7.1.0.
		</td>
	</tr>
	<tr>
		<td>
			<b><a href="{{base_path}}/integrate/learn-overview/#tutorials">Tutorials</a></b>
		</td>
		<td>
			Develop and try out each integration use case end-to-end.
		</td>
	</tr>
	<tr>
		<td>
			<b><a href="{{base_path}}/integrate/learn-overview/#examples">Examples</a></b>
		</td>
		<td>
			Try out specific integration scenarios by running the samples.
		</td>
	</tr>
</table>
