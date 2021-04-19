# Creating an Integration Project

An integration project consists of one or several project directories. These directories store the various artifacts that you create for your integration sequence. An integration project can be created as a Maven Multi Module (MMM) project by default. This enables you to add ESB Configs, Composite Exporter, Registry Resources, Connector Exporter, Docker Exporter, and Kubernetes Exporter as sub-modules to the project. 

An integration project is the recommended way of creating an “Integration Solution” as it simplifies the CICD workflow.

## Integration project

To create an integration project:

1. [Download](https://wso2.com/integration/integration-studio/) and [install WSO2 Integration Studio]({{base_path}}/integrate/develop/instaling-wso2-integration-studio).

2. Open WSO2 Integration Studio and click **New Integration Project** in the **Getting Started** view as shown below.
    <img src="{{base_path}}/assets/img/integrate/new-project/new-integration-project.png" title="New Integration Project" width="700" alt="New Integration Project"/>

3. In the **New Integration Project** dialog box that opens, enter a name for your integration project. Select the relevant check boxes if you want to create **Registry Resources**, **Connector Exporter**, **Docker Exporter**, or **Kubernetes Exporter** in addition to the **ESB Configs** and **Composite Exporter**.
    <img src="{{base_path}}/assets/img/integrate/new-project/create-a-project.png" title="Create a New Integration Project" width="700" alt="Create a New Integration Project"/>

## Sub projects

An integration project can consist of multiple sub-projects. So multiple small projects can exist under a single integration project, where each of these can be dependent on each other and can be grouped together. However, it is not necessary that all sub-projects in an integration project be dependent on every other sub-project.

<img src="{{base_path}}/assets/img/integrate/new-project/sub-projects.png" title="Sub Projects" width="250" alt="Sub Project"/>

To add sub-projects to an existing integration project, right-click the integration project and hover over **New** to see the available project creation options.

<img src="{{base_path}}/assets/img/integrate/new-project/new-sub-project.png" title="Add a New Sub Project" width="250" alt="Add a New Sub Project"/>

Once you create the new sub project, you can see this nested under your integration project folder in the project explorer.

The following table lists out the available projects that can be associated with an integration project.

<table>
    <tr>
        <th>Sub project</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>ESB Configs</td>
        <td>This project stores the ESB artifacts that are used when defining a mediation flow. This includes addition of any synapse artifacts to your integration project that enables features of a typical ESB.</br>
        <img src="{{base_path}}/assets/img/integrate/new-project/synapse-engine.png" title="Synapse Engine" width="300" alt="Synapse Engine"/>
        </br>
        The following are the synapse artifacts that can be added to an integration flow.
        </br>
        <ul>
            <li><b>Proxy</b>: This is a virtual service in the Micro Integrator that receives messages and processes them. It then delivers them to an external endpoint, where the actual web service is located.</li>
            <li><b>API</b>: A Rest API is an endpoint that has a URL. This address specifies the context and resources that need to be accessed through an HTTP method or call such as GET, PUT, POST, DELETE. Requests arrive at the input sequence, the Micro Integrator processes the message using mediators and forwards the message to the backend. The output sequence receives the backend’s response, processes it, and forwards the message to the client.</li>
            <li><b>Inbound endpoints</b>: They can be configured dynamically without restarting the server. Messages move from the transport layer to the mediation layer without going through the Axis2 engine.</li>
            <li><b>Sequences</b>: Sequences are used in the proxy service and the REST APIs. Each sequence is a set of mediators where messages are processed.</li>
            <li><b>Mediator</b>: It is the processing unit or action that is performed on a message. For example, when enriching a message, filtering it, sending it to an endpoint, deleting it, etc. Mediators can be customized.</li>
            <li><b>Scheduled Tasks</b>: This is a code that is to be executed at a specific moment. Tasks can also be customized.</li>
            <li><b>Endpoints</b>: They are destinations, for example, external to the Micro Integrator. It may be a service represented by a URL, mailbox, JMS queue, TCP socket. The same endpoint can be used with several transport protocols.</li>
            <li><b>Message Store/Message Processors</b>: This design pattern is used in integration when dealing with messages asynchronously (which is to say, when the client does not wait for the response). The message is stored in the memory or drive; this is done by the Message Store. The message processor extracts a queue, memory or database from it and sends it to an endpoint. By using this pattern, the delivery of a message to the endpoint can be guaranteed, since it is only deleted from the Store when an endpoint receives the message correctly.</li>
        </ul>
        </td>
    </tr>
    <tr>
        <td>Composite Exporter</td>
        <td>This project allows you to package all the artifacts (stored as sub-projects under the same integration project) into one <a href="packaging-artifacts/">composite application (C-APP)</a>. This C-APP can then be deployed in the Micro Integrator server.
        </br>
        <img src="{{base_path}}/assets/img/integrate/new-project/composite-application.png" title="Composite Application" width="250" alt="Composite Application"/>
        </td>
    </tr>
    <tr>
        <td>Registry Resources</td>
        <td>Create this project if you want to create registry resources for your mediation flow. You can later use these registry artifacts when you define your mediation sequences in the ESB config project.
        </br>
        The registry has three components: local, config, and governance. Registry resources and metadata can be added into each component in the registry.
        </br>
        <img src="{{base_path}}/assets/img/integrate/new-project/registry-resource.png" title="Registry Resource" width="300" alt="Registry Resource"/>
        </td>
    </tr>
    <tr>
        <td>Connector Exporter</td>
        <td>Create this project if you wish to use connectors in your mediation sequence (defined in the ESB config project). All connector artifacts need to be stored in a connector exporter module before packaging.
        </br>
        <img src="{{base_path}}/assets/img/integrate/connectors/why-connectors.png" title="Why Connectors" width="400" alt="Why Connectors"/>
        </td>
    </tr>
    <tr>
        <td>Docker Exporter</td>
        <td>Create a Docker Exporter if you want to deploy your integration solutions inside a Docker environment. This project directory allows you to package multiple integration projects into a single Docker image and then build and push to the Docker registries. For more information on Docker-specific project creation information, see <a href="{{base_path}}/integrate/develop/create-docker-project">Create Docker Project</a>.</td>
    </tr>
    <tr>
        <td>Kubernetes Exporter</td>
        <td>A Kubernetes Exporter allows you to deploy your integration solutions in a Kubernetes environment. This module allows you to package multiple integration projects and modules into a single Docker image. Also, a file named integration_cr.yaml is generated, which can be used to carry out Kubernetes deployments based on the <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/kubernetes_deployment/#ei-kubernetes-k8s-operator">k8s-ei-operator</a>. For more information on Kubernetes-specific project creation information, see <a href="develop/create-kubernetes-project">Create Kubernetes Project</a>.</td>
    </tr>
</table>

## Maven Multi Module projects

The Maven Multi Module (MMM) integration project is the parent project in an integration solution and sub-projects can be added under this parent project. By default, an integration project is an MMM project unless you specify otherwise. 

By building the parent MMM project, you can build all the sub-projects in the integration solution simultaneously. This allows you to seamlessly push your integration solutions to a CI/CD pipeline. Therefore, it is recommended as a best practice to create your Config project and other projects inside an MMM integration project.

This allows you to manage multiple projects such as Config projects, Composite Application projects, and Registry Resource projects as a single entity.

Although the recommended approach is to create an integration project, which essentially has all the functionality of an MMM project, you can also create an MMM project separately.

**To create the MMM project**:

1.  Open **WSO2 Integration Studio** and click **New Maven Multi Module Project** in the **Getting Started** view.

2.  In the **Maven Modules Creation Wizard** that opens, enter an artifact ID and other parameters as shown below. The artifact ID will be the name of your MMM project.

    <img src="{{base_path}}/assets/img/integrate/create_project/new_maven_multi_module.png" width="500">

3.  Click **Finish**. The MMM project is created in the project explorer. 

    <img src="{{base_path}}/assets/img/integrate/create_project/proj_explorer_mmm.png" width="300">

Now you can create other projects inside the MMM project. For example, let's create a **Config** project and a **Composite Application** project.

You can create sub-projects under this parent MMM project.

## Moving sub projects to MMM project

You can import existing sub projects (ESB Config project, Registry resource project, Composite project, etc.) into an existing Maven Multi Module Project (Integration Project).

Right-click the project, and click <b>Import to Maven Muti Module</b>.

<img src="{{base_path}}/assets/img/integrate/create_project/import-to-mmm.png" width="400" title="import to maven multi module" alt="import to maven multi module">

## Building selected MMM profiles

When you create an integration project, you have a parent MMM project with child modules (sub projects). The MMM project in WSO2 Integration Studio now includes multiple maven profiles. Therefore, you can build selected profiles instead of building the complete MMM project.

Maven profiles:

<table>
	<tr>
		<th>
			Profile Name
		</th>
		<th>
			Description
		</th>
	</tr>
	<tr>
		<td>
			Solution
		</td>
		<td>
			Builds the integration artifacts stored in the <b>ESB Config</b> sub project.
		</td>
	</tr>
	<tr>
		<td>
			Docker
		</td>
		<td>
			Builds the integration artifacts stored in the <b>ESB Config</b> and <b>Docker</b> sub projects.
		</td>
	</tr>
	<tr>
		<td>
			Kubernetes
		</td>
		<td>
			Builds the integration artifacts stored in the <b>ESB Config</b> and <b>Kubernetes</b> sub projects.
		</td>
	</tr>
</table>

To build a selected Maven profile:

!!! Note
    When you build a <b>Docker</b> or <b>Kubernetes</b> profile using this method, you need to have **Maven 3.5.2** or a later version installed.

1.  Open a terminal and navigate to the MMM project folder.
2.  Execute the following command:

    ```bash
    mvn clean install -P <Profile_name>
    ```

    !!! Tip
        If you don't specify a profile name with the `-P` parameter, the default profile will apply.
