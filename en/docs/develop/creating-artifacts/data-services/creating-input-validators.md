# Creating a custom validator

An **input validator** allows a data service to validate the input
parameters in a request and stop the execution of the request if the
input doesn’t meet the required criteria. In addition to the default
validators provided, you can create your own custom validators by
creating a Java class that implements the
`         org.wso2.carbon.dataservices.core.validation.Validator        `
interface. You can [create a new custom validator](#creating-a-new-custom-validator)
or [import an existing validator project](#importing-a-validator-project).

## Creating a new custom validator

Follow these steps to create a new custom validator. Alternatively, you
can [import an existing validator project](#importing-a-validator-project).

1.  Go to **File-> New -> Other -> Data Services Validator Project**
    to open the **New Data Services Validated Artifact Creation Wizard**
    .
2.  Select **Create New Data Services Validator Project** and click
    **Next** .
3.  Type a unique name for the project and specify the package and class
    name for this validator.
4.  Optionally, specify the location and working set for this project.
5.  A Maven POM file will be generated automatically for this project.
    If you want to customize the Maven options (such as including parent
    POM information in the file from another project in this workspace),
    click **Next** and specify the options.
6.  Click **Finish** . The project is created, and the new validator
    class is open in the editor where you can add your validation logic.

## Importing a validator project

Follow these steps to import an existing custom validator project.
Alternatively, you can [create a new custom validator](#creating-a-new-custom-validator).

1.  Go to **File-> New -> Other -> Data Services Validator Project**
    to open the **New Data Services Validated Artifact Creation Wizard**
    .
2.  Select **Import Project From Workspace** and click **Next** .
3.  Select the existing validator project, and optionally specify the
    location and working sets for the new project.
4.  A Maven POM file will be generated automatically for this project.
    If you want to customize the Maven options (such as including parent
    POM information in the file from another project in this workspace),
    click **Next** and specify the options.
5.  Click **Finish** . The project is imported, and the validator class
    is open in the editor, where you can modify the validation logic as
    needed.