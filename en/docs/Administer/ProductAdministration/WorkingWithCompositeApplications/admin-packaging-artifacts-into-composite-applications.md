# admin\_Packaging Artifacts into Composite Applications

After working on your artifacts using the Tooling environment, you bundle them into Composite Applications (C-Apps) that can later be deployed in the server. The steps below describe how to bundle your artifacts into a C-App. When deploying via the management console, you will need to create a Composite Application Archive (CAR) file. See [Creating a Composite Application Archive (CAR) file](#admin_PackagingArtifactsintoCompositeApplications-CreatingaCompositeApplicationArchive(CAR)file) .

Also, you can package individual artifacts into separate C-Apps as well. See [Packaging individual artifacts into separate Composite Applications](#admin_PackagingArtifactsintoCompositeApplications-PackagingindividualartifactsintoseparateCompositeApplications) .

1.  Open the Tooling interface with all the artifacts/projects that you created. For example, shown below is an ESB mediation sequeance created with ESB artifacts.
    ![](attachments/126562745/126562760.png)2.  Right-click the **Project Explorer** and click **New -&gt; Project** .
    ![](attachments/126562745/126562761.png)3.  From the window that opens, click **Composite Application Project** .
    ![](attachments/126562745/126562751.png)4.  Give a name to the **Composite Application** project and select the projects that you need to group into your C-App from the list of available projects below. For example,
    ![](attachments/126562745/126562764.png)5.  In the **Composite Application Project POM Editor** that opens, under **Dependencies** , note the information for each of the projects you selected earlier. You can also change the project details here.
    ![](attachments/126562745/126562763.png)
#### Creating a Composite Application Archive (CAR) file

To [deploy a C-App via the product's management console](https://docs.wso2.com/display/ADMIN44x/Deploying+Composite+Applications+in+the+Server) , you will need to first create a Composite Application Archive (CAR) file of that C-App.

1.  To create the CAR file, do one of the following:
    -   Right-click the C-App project and select **Export Composite Application Project** from the pop-up menu.

OR

1.  -   Open the `            pom.xml           ` file in the **Composite Application Project POM Editor** and click the button for creating an archive in the upper-right corner.

2.  Give the location of the CAR file and the artifacts you want to include in it.

        !!! tip
    **Tip** : When you create a CAR file with artifacts, ensure that each artifact name is the same as the relevant artifact file name.


You have now exported all your project's artifacts into a single CAR file. Next, [deploy the Composite Application in the server](https://docs.wso2.com/display/ADMIN44x/Deploying+Composite+Applications+in+the+Server) .

!!! note
Note

-   In a CAR file, if a particular artifact name is different from the relevant artifact file name, re-deploying the CAR file fails with an error.
-   If a CAR file has one or more artifacts that have a artifact name different from the relevant artifact file name, removing those artifacts from memory fails when you delete the CAR file.


#### Packaging individual artifacts into separate Composite Applications

You can also create separate deployable artifacts for each individual artifact in your project. For example, suppose you created an Apache Axis2 Service. When you right-click the Axis2 Service Project, there is an option called **Export Project as Deployable Archive** . It creates the relevant deployable archive in a location you specify.

![](images/icons/grey_arrow_down.png){.expand-control-image} Expand to see the archive file types for different app types...

Following are the deployable archives that will be generated for each artifact type.

| **Artifact Type**            | **Archive Type**                          |
|------------------------------|-------------------------------------------|
| Apache Axis2 Artifact        | .aar                                      |
| Endpoint Artifact            | .xml                                      |
| Sequence Artifact            | .xml                                      |
| Proxy Service Artifact       | .xml                                      |
| Local Entry Artifact         | .xml                                      |
| Synapse Configuration        | .xml                                      |
| ESB Mediator                 | .jar                                      |
| Registry Resource            | Registry Resource with necessary metadata |
| Third Party Library Artifact | .jar (OSGI Bundle)                        |

![](attachments/126562745/126562758.png)