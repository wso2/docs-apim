# Developing Integration Solutions

The contents on this page will walk you through the topics related to developing integration solutions using WSO2 Micro 
Integrator.

## Development workflow

Integration developers will follow the workflow illustrated by the following diagram.

![developer workflow](../assets/img/development_workflow.png)

<table>
	<tr>
		<td><b>Step 1: Set up the workspace</b></td>
		<td>
			To start developing integration solutions, you need to first set up your workspace.</br>
			<a href="../../develop/installing-WSO2-Integration-Studio">Install WSO2 Integration Studio</a>, which you will use to develop, build, and test your integration artifacts.
		</td>
	</tr>
	<tr>
		<td id='develop_artifacts'><b>Step 2: Develop the artifacts</b></td>
		<td>
			Before you start developing your artifacts, design the synapse configurations that suite your requirement. Use the following resources:
			<ul>
				<li>
					See the <a href="../../use-cases/learn-overview">Use cases</a> documentation,                 which contains:
					 <ul>
					    <li>
						    <b>Tutorials</b> that will walk you through the process of developing the most                             common integration use cases. 
				        </li>
				        <li>
						<b>Examples</b> providing a quick demo that will help you understand the                                synapse configurations for implementing specific functions.
				        </li>
				     </ul>
				</li>
				<li>
				    See the documentation on <a href="../../references/best-Practices">developing 
				    common integration patterns</a> to get an understanding on the best practices that should be 
				    followed while developing integration solutions for the Micro Integrator.
				</li>
				<li>
					See the <a href="../../develop/WSO2-Integration-Studio">WSO2 Integration Studio documentation</a> for in-depth information on the development tool.
				</li>
				<li>
				    See the documentation on <a href="../../develop/creating-unit-test-suite">creating unit tests</a> for the integration solution you developed.
				</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td><b>Step 3: Build and Run the integration</b></td>
		<td>
			Once you have developed your integration solution,
			<ol>
				<li>
					<a href="../../develop/packaging-artifacts">Package the integration artifacts</a>
				</li>
				<li>
					<a href="../../develop/deploy-artifacts">Build and run</a> the integration artifacts in the Micro Integrator that is embedded in WSO2 Integration Studio.
				</li>
			</ol>
		</td>
	</tr>
	<tr>
		<td><b>Step 4: Iterate and improve</b></td>
		<td>
			You can easily test your integration flow either in a container environment, or a VM.
			<ul>
				<li>
					Use the <a href="../../develop/creating-unit-test-suite/#run-unit-test-suites">Integration Test Suite</a> in WSO2 
					Integration Studio to run unit testing on your integration artifacts.
				</li>
				<li>
					To test the integration flow in <b>Docker</b>, <a href="../../develop/create-docker-project">create a Docker project</a> and push it to your Docker environment.
				</li>
				<li>
					To test the integration flow in <b>Kubernetes</b>, <a href="../../develop/create-kubernetes-project">create a Kubernetes project</a> and push it to your Kubernetes environment.
				</li>
				<li>
					To test the integration flow as a <b>VM deployment</b>, you can instantly <a href="../../develop/deploy-artifacts">build and run</a> the integration artifacts in the Micro Integrator that is embedded in WSO2 Integration Studio.
				</li>
			</ul>
			As you build and run the integration flow, you may identify errors that need to be fixed, and changes that need to be done to the synapse artifacts.
			<ol>
				<li>
					<a href="../../develop/debugging-mediation">Debug the mediation flow</a> to find potential errors.
				</li>
				<li>
					Redeploy the integration artifacts after applying changes.</br></br>
					<b>Note</b>: If you are testing on a VM, the artifacts will be instantly deployed when you <a href="../../develop/deploy-artifacts">Redeploy the synapse artifacts</a>. If you are testing on containers, you need to rebuild the <a href="../../develop/create-docker-project">Docker images</a> or <a href="../../develop/create-kubernetes-project">Kubernetes artifacts</a>.
				</li>
			</ol>
		</td>
	</tr>
	<tr>
		<td><b>Step 5: Deploy in production</b></td>
		<td>
			It is recommended to use a <b>CICD pipeline</b> to deploy your tested integration solutions in the production environment.</br></br>
			WSO2 Integration Studio handles the <b>continous integration</b> of your solutions by generating the 
			artifacts that need to be pushed to a remote artifact repository for the continous deployment process: 
			<ul>
				<li>
					If you have a <b>Kubernetes deployment</b>, see the instructions on how to use the <a href="../../setup/deployment/k8s-pipeline/overview">EI Kubernetes CICD pipeline</a>.
				</li>
			</ul>
		</td>
	</tr>
</table>

## Related topics

<table>
	<tr>
		<td>
			Develop your <b><a href="../../develop/integration-development-kickstart">first integration solution</a></b>.</br></br>
			You can try the development workflow end-to-end by running a simple use case.
		</td>
		<td>
			<b><a href="../../develop/WSO2-Integration-Studio">Using WSO2 Integration Studio</a></b></br></br>
			Get familiar with the developer tool for creating your integration solutions.
		</td>
	</tr>
</table>
