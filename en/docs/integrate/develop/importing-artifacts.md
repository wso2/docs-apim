# Importing Artifacts

Follow the instructions given below to import an integration artifact into WSO2 Integration Studio.

1.  [Create an ESB project]({{base_path}}/integrate/develop/create-integration-project).
2.	Right-click the ESB project, click **New**, and select the type of artifact you want to import. For example, let's import a REST API artifact.

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/new-artifact.png">

3.  Select the **Import Artifact** option and click **Next**.

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/select-import-artifact-option.png" width="500">

4.  Browse for the configuration file of your artifact, specify the location to save the artifact.

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/select-artifact-file.png" width="500">

5.  Click **Finish**. 

The artifacts are created in the `src/main/synapse-config/<artifact_type>` folder under the ESB project you specified. 

