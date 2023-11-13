# Creating Artifacts in Non-Server Mode

The WSO2 Micro Integrator (MI) runtime has introduced a non-server mode, enhancing its adaptability for various execution scenarios. Paired with the latest capabilities of WSO2 Integration Studio, this new mode provides developers with a more efficient way to handle integration tasks, especially in cloud-native environments. This documentation outlines how to utilize the non-server mode in MI using the WSO2 Integration Studio.

## Non-Server Mode in MI Runtime
WSO2 Micro Integrator runtime offers two operational modes:

- Server Mode: A long-running process mode. Historically, this was the primary mode for MI, tailored for service and event-handler component types.
- Non-Server Mode: Introduced to cater to the demands of evolving cloud environments, this mode is geared toward short-lived processes, making it ideal for manual and scheduled task components.

!!! note
    The non-server mode is available starting from WSO2 Micro Integrator runtime version 4.2.0.29.

Historically confined to server mode, MI's exclusive operational mode limited its adaptability, particularly in dynamic cloud environments that demanded short-lived, task-specific executions. The newly introduced non-server mode addresses these constraints by providing a flexible mechanism for streamlined task execution, aligning seamlessly with cloud-native best practices. In this mode, MI executes the specified main sequence from start to finish, allowing for efficient task executions without the need for a persistent server process.

## Prerequisites

Before you try out the steps in this guide, complete the following:

- Update the WSO2 MI runtime to the latest version.
- Have an integration project created with **Create ESB Configs** and **Create Composite Exporter** options enabled.

### Step 1: Designing the main sequence
The main sequence is essential in the non-server mode. It serves as the core of your task's integration logic, dictating its execution path. A well-constructed main sequence ensures a consistent and optimal flow for your tasks in the non-server mode. Follow the steps below to design the main sequence:

- Follow the guide [Creating resusable sequences](https://apim.docs.wso2.com/en/latest/integrate/develop/creating-artifacts/creating-reusable-sequences/) to design the main sequence.

   This sequence, designated as the main sequence, plays a crucial role in guiding the task's operational flow. While WSO2 Integration Studio provides various mediators for assistance, prioritize clarity and efficiency in your logic.

### Step 2: Configuring the main sequence:
Correctly configuring and packaging the main sequence is pivotal for ensuring seamless and error-free operations when deploying to the WSO2 Micro Integrator runtime in non-server mode. Follow the instructions below to configure the main sequence within the WSO2 Integration Studio:

1. Set the created sequence as the main sequence.
   
   1. In the MI runtime, in the left file navigation pane, navigate to the **Composite Exporter** folder.
   2. Right-click and select **Main Sequence**.
   3. In the dialog box that appears, select the sequence you designed.
      
3. Package the artifacts.

   Ensure that the main sequence, along with other related artifacts, are packaged appropriately in the `Composite Application project`.
For a detailed guide on packaging, refer to the [WSO2 documentation on packaging synapse artifacts](https://apim.docs.wso2.com/en/latest/integrate/develop/packaging-artifacts/#packaging-synapse-artifacts).

### Step 3: Committing to GitHub

Save and commit your integration project to the preferred GitHub repository, ensuring the inclusion of all relevant files and configurations in this commit.
