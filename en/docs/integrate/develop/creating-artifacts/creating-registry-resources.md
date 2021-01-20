# Creating a Registry Resource

Initially, your Registry resources project will contain only a `pom` file. You can create any number of registry resources inside that project.

## Step 1: Creating the resource artifact

Right-click on the `Registry Resource project` and click **New** -> **Registry Resource**.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/select-resource.png" width="500">

This will open the **New Registry Resource** window.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-1-1.png" width="500">

Select one of the following options and click **Next**.

- [From existing template](#from-existing-template)
- [Import from file system](#import-from-file-system)
- [Import Registry dump file from file system](#import-registry-dump-file-from-file-system)
- [Check-out from Registry](#check-out-from-registry)

### From existing template

Use the **From existing template** option if you want to generate a registry resource from a template.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-1-1.png" width="500">

Click **Next** and specify values for the following parameters:

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-2.png" width="500">

Enter a unique name for the resource and select a resource template for the **Template** field. In this example, a **WSDL File** template is used.

### Import from file system

Use the **Import from file system** option to import a file or a folder
containing registry resources.

!!! Tip
    This helps you import a resource and collection from the same registry instance or a different registry instance that you have added. Similarly, you can export a resource or collection to the same registry instance or a different registry instance.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-1-2.png" width="500">

Click **Next** and specify values for the following parameters:

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-3.png" width="500">

<table>
  <tr>
    <th>Browse file/Browse folder</th>
    <td>Browse to find the relevant file or folder.</td>
  </tr>
  <tr>
    <th>Copy content only</th>
    <td>If you selected <b>Browse Folder</b>, the <b>Copy content only</b> check box will be enabled. Select the check box if you want to copy only the content of the folder (and not the folder itself) to the save location.</td>
  </tr>
</table>

### Import Registry dump file from file system

Use this option to browse for a registry dump file, which you can use to
sync a registry.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-1-3.png" width="500">

Click **Next** and then click **Browse** to find the relevant file.  

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-4.png" width="500">

### Check-out from registry

Use this option to check out files from the registry.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-1-4.png" width="500">

Click **Next** and specify the artifact name and the registry path from which you want to check out the files.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-5.png" width="500">  

## Step 2: Saving the resource artifact

Specify the location to save the registry resource and click **Finish**.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_resource/new-resource-wizard-save.png" width="500">  

<table>
  <tr>
    <th>Registry path to deploy</th>
    <td>Specify where the registry resource should be saved to at the time of deployment.</td>
  </tr>
  <tr>
    <th>Save Resource in</th>
    <td>Select an existing <a href="{{base_path}}/integrate/develop/create-integration-project/#registry-resource-project">registry resource project</a> to save the resource. Alternatively, you can create a new registry resource project.</td>
  </tr>
</table>

## Editing a Registry Resource

You may need to change the details you entered for a registry resource, for example, the registry path. You can edit such information using the **Registry Resource Editor**. To open this editor, right-click the [Registry Resource project]({{base_path}}/integrate/develop/create-integration-project/#registry-resource-project) and click **Registry Resource Editor**.

This editor lists all the registry resources that you have defined in that project and it will list the **Registry Path to Deploy** information per resource.
