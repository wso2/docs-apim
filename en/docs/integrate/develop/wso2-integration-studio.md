# Quick Tour - WSO2 Integration Studio

WSO2 Integration Studio is your development environment for designing, developing, debugging, and testing integration solutions. As an integration developer, you can execute all the phases of the development lifecycle using this tool. When your integration solutions are production-ready, you can easily push the artifacts to your continuous integration/continuous deployment pipeline.

## Getting Started

When you open WSO2 Integration Studio, you will see the **Getting Started** view in the tool's workbench. 

<img src="{{base_path}}/assets/img/integrate/workbench/getting-started-view.png" width="800">

You can also click the <img src="{{base_path}}/assets/img/integrate/workbench/icon-getting-started-workbench.png" width="20"> icon at the top-right of the workbench to open the **Project Explorer** alongside the **Getting Started** tab as shown below.

<img src="{{base_path}}/assets/img/integrate/workbench/workbench-getting-started.png" width="800">

To get started, you need to first create the required project directories. Alternatively, you can use an integration sample, which will generate the required projects and files for a specific use case.

<table>
	<tr>
		<th>
			Project Directories
		</th>
		<td>
			<p>Use the links on the <b>Getting Started</b> view to create the required projects. These project directories are saved to your workspace and they can later be accessed from the <a href="#project-explorer">Project Explorer</a> view of WSO2 Integration Studio.</p>
			<img src="{{base_path}}/assets/img/integrate/workbench/getting-started-view.png" width="800">
		</td>
	</tr>
	<tr id="templates">
		<th>
			Samples
		</th>
		<td>
			<p>
				The <b>Getting Started</b> view lists a set of sample projects and integration artifacts that represent common integration scenarios. You can use these to explore WSO2 Micro Integrator and to try out common integration use cases. The <a href="#sample-guide">sample guide</a> will provide instructions on how to run the samples.
			</p>
			<img src="{{base_path}}/assets/img/integrate/workbench/getting-started-templates.png" width="800">
		</td>
	</tr>
	<tr id="template-guide">
		<th>
			Sample Guide
		</th>
		<td>
			<p>
				The sample guide is a <b>Help</b> pane, which provides documentation on how to use the <a href="#templates">integration sample scenarios</a>. You can follow the instructions given in the guides to deploy and test each sample scenario.
			</p>
			<img src="{{base_path}}/assets/img/integrate/workbench/workbench-template-guide.png" width="200">
		</td>
	</tr>
</table>

Once you have created the required set of projects and artifacts, you can start working with the project directories and artifact editors shown below.

<img src="{{base_path}}/assets/img/integrate/workbench/workbench-working-project.png" width="800">

## Project Explorer

The project explorer provides a view of all the project directories created for your integration solution. Shown below is the project explorer of a working project.

<img src="{{base_path}}/assets/img/integrate/workbench/workbench-project-explorer.png" width="300">

## Graphical Editor

The graphical editor of WSO2 Integration Studio is a drag-and-drop editor for designing integration workflows. To access the graphical editor, you must first create a REST API, Proxy Service, Inbound Endpoint, or Sequence artifact.

Once you open the graphical editor, the **Palette** to your left lists all the integration artifacts that you can use. You can drag the required artifacts to the canvas on your right and design your integration flow. The parameters for each artifact can be configured using the [Properties](#properties) view.

<img src="{{base_path}}/assets/img/integrate/workbench/graphical-editor.png" width="800">

## Source Editor

When you open any integration artifact from the project explorer, you will have a source editor in addition to the graphical editor. This editor allows you to write or edit your integration solution using the source code (synapse).

<img src="{{base_path}}/assets/img/integrate/workbench/source-editor.png" width="800">

## Swagger Editor

The swagger editor is available when you create a REST API. This is in addition to the graphical editor and the source editor. The swagger editor can be used to write or edit your integration solution using the swagger definition. The Swagger UI allows you to visualize and interact with the REST API.

<img src="{{base_path}}/assets/img/integrate/workbench/swagger-editor.png" width="800">

## Properties

The properties view allows you to configure the properties and parameters that define the integration artifacts in your integration flow. When you double click an artifact in the graphical editor, the **Properties** view for that artifact will open. Alternatively, you can right-click the artifact and click **Show Properties** to open this view.

<img src="{{base_path}}/assets/img/integrate/workbench/workbench-properties.png" width="800">

## Console

The Console view displays a variety of console types depending on the type of development and the current set of user settings. The three consoles that are provided by default with WSO2 Integration Studio are:

-   **Process Console**: Shows standard output, error, and input.
-   **Stacktrace Console**: Well-formatted Java stacktrace with hyperlinks to specific source code locations.
-   **CVS Console**: Displays output from CVS operations.

<img src="{{base_path}}/assets/img/integrate/workbench/workbench-console.png" width="800">

## HTTP Client

An embedded RESTful HTTP client is shipped with WSO2 Integration Studio to support testing. Once you have deployed your integration solutions in the Micro Integrator server, you can invoke the solutions using this client within WSO2 Integration Studio.

<img src="{{base_path}}/assets/img/integrate/workbench/http4e-client-empty.png" width="800">

## Embedded Micro Integrator

WSO2 Integration Studio is shipped with an embedded Micro Integrator server, which allows developers to deploy and run integration artifacts during the development phase. To deploy the artifacts and to run the embedded Micro Intgrator, right-click the composite application project (which includes your artifacts) and click **Export Project Artifacts and Run**.

Find out more about [using the embedded Micro Integrator]({{base_path}}/integrate/develop/using-embedded-micro-integrator)

<img src="{{base_path}}/assets/img/integrate/create_project/testing_export_run.png" width="500">

## Inbuilt Debugging Capabilities

WSO2 Integration Studio is shipped with mediation debugging capabilities, which allows developers to debug an integration project using the tool. The embedded Micro Intgrator server and debugging capabilities enables developers to comprehensively test, debug, and improve integration solutions before the artifacts are released to a production environment.

You need to select your integration project in the project explorer and go to **Run -> Debug** as shown below. Find out more about [mediation debugging]({{base_path}}/integrate/develop/debugging-mediation).

<img src="{{base_path}}/assets/img/integrate/workbench/debugging-capabilities.png" width="500">

## Outline

The Outline view displays an outline of a structured file that is
currently open in the editor area, and lists structural elements. It
enables you to hide certain fields, methods, and types, and also allows
you to sort and filter to find what you want. The contents of the
Outline view are editor specific. For example, in a Java source file,
the structural elements are classes, fields, and methods. The contents
of the toolbar are also editor specific.

<img src="{{base_path}}/assets/img/integrate/workbench/workbench-outline.png">

## What's Next?

-   See [Installing WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio) for installation instructions.
-   See [Working with WSO2 Integration Studio]({{base_path}}/integrate/develop/working-with-wso2-integration-studio) for more information on how to setup and use tooling.
-   See [Troubleshooting WSO2 Integration Studio]({{base_path}}/integrate/develop/troubleshooting-wso2-integration-studio) for information on troubleshooting errors you may run into while using EI Tooling.
