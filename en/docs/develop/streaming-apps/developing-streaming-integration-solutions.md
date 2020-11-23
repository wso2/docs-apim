# Developing Streaming Integrator Solutions

This section provides an overview of the development flow in the Streaming Integrator.

Developing a Streaming Integrator solution involves the following four steps.


![Streaming Integrator Development Flow](../../images/developing-si-solutions/si-development-workflow.png)

| **Step**                          | **Description**                                                                                                                   |
|-----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| **Step 1: Installing SI Tooling** |This involves downloading and installing the Streaming Integration Tooling in which Siddhi applications are designed. For more information, see the following topics:<br/> - [Installing the Streaming Integrator in a Virtual Machine](../setup/installing-si-in-vm.md)<br/> - [Installing the Streaming Integrator in Docker](../setup//installing-si-using-docker.md)<br/> - [Installing the Streaming Integrator in Kubernetes](../setup/installing-si-using-kubernetes.md) |
| **Step 2: Creating Siddhi Applications** | Siddhi applications can be designed in the Streaming Integrator Tooling via the source view or the design view. For detailed instructions, see [Creating Siddhi Applications](creating-a-Siddhi-Application.md). |
| **Step 3: Testing Siddhi Applications** | Once a Siddhi application is created, you can test it before using it in a production environmenty by simulating events to it. For more information, see [Testing Siddhi Applications](testing-a-Siddhi-Application.md). |
| **Step 4: Deploying Siddhi Applications** | Once your Siddhi application is created and verified via the testing functionality in the Streaming Integrator Tooling, you can deploy it in the Streaming Integrator server, or deploy it in a Docker/Kubernetes environment. For more information about, see the following topics:<br/> - [Deploying Siddhi Applications](deploying-Streaming-Applications.md)<br/> - [Exporting Siddhi Applications](exporting-Siddhi-Applications.md)|
| **Step 5: Running Siddhi Applications** | This involves running the Siddhi application in the server where you deployed them. To try this out, you can follow the [Streaming Integrator Tutorials](tutorials-overview.md). |