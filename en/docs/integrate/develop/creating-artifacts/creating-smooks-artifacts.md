# Creating a Smooks Configuration

[Smooks](http://www.smooks.org/) is an extensible framework for building applications that process data, such as binding data objects and transforming data. 

## Create the Smooks artifact

To create a Smooks configuration artifact:

1.  First create a registry resource as described in [Creating Registry Resources]({{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources). 
2.  When creating the registry resource, select the **From Existing Template** option and select **Smooks Configuration** as the template. The `smooksconfig.xml` file is created. 
3.  Double-click the smooks configuration in the Project Explorer to open it in the embedded JBoss Smooks editor.  
4.  Click **Input Task**, create the data mapping, and save the configuration file.

## Deploy Smooks libraries

Before you can run the Smooks configuration, you must add libraries from the Smooks framework to your registry resources project.

1.  Right-click the registry resources project in the Project Explorer
    and click **Properties** .
2.  In the list on the left, click **Java Build Path** , and then click
    the **Libraries** tab.  
3.  Click **Add Library** , click **WSO2 Classpath Libraries** , and
    then click **Next** .
4.  In the **WSO2 Classpath Libraries** dialog box, click the **Smooks**
    tab, click **Select All** , and click **Finish** .
5.  In the **Properties** dialog box, click **Apply and Close** .

All the Smooks-related libraries have been added to the project classpath. 

## Run the Smooks configuration

You can now run the Smooks configuration:

1. Right-click the file and choose **Run As -> Smooks Run Configuration**. If your Smooks configuration is correct, the console displays the results according to the input model and output model you specified.
2.  You can now add the Smooks configuration artifact to a proxy service or sequence. To do so, create a [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service). 
3.  Drag and drop a Log mediator and a Smooks mediator to the **InSequence**. 
4.  Double-click the **Smooks** mediator to see the **Property** view. Click the button at the right hand corner of the
**Configuration Key** field.
5.  The **Resource Key Editor** dialog box appears. Specify from where you
should select the resource file.
6.  Select **Workspace** option since we have the created **Smooks
Configuration** in our workspace. 
7.  Browse for the **Smooks Configuration** file that we have created and click **OK**.

Now you have successfully referred to the Smooks configuration within your proxy service.