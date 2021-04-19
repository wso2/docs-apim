# Streaming Integrator Tooling Overview

The Streaming Integrator Tooling is a developer tool that is shipped with the Streaming Integrator to develop Siddhi applications. It provides four interfaces to develop Siddhi applications.

-   **Source View** : This allows you to write Siddhi applications
    in the Siddhi Query Language. This supports auto-completion and
    tracking syntax errors.

-   **Design View** :This interface visualizes the event flow of a
    Siddhi application, and allows you to compose the applications by
    dragging and dropping Siddhi components to a graph.
    
-   **Wizard View**: This is a wizard with a page for each component of a Siddhi application that displays the relevant configuration parameters as fields. This wizard can be directly accessed from the [Welcome Page](#welcome-page). Only ETL (Extract, Transform, Load) applications can be created/viewed in this interface. For a Siddhi application to be considered an ETL application, it must include all of the following components:<br/><br/> - A source configuration<br/><br/> - A sink configuration (the sink type can be any of the [supported sink types](https://siddhi.io/en/v5.1/docs/query-guide/#sink) other than `log`)<br/><br/> - A Siddhi query that performs a transformation. <br/><br/> For more information, see [Creating an ETL Application via SI Tooling tutorial]({{base_path}}/use-cases/streaming-tutorials/creating-etl-application-via-tooling).

-   **Async API View**: This interface allows you to generate an asynchronous API definition from a Siddhi application that includes a source/sink of the `websocket-server`, `webhooks` or `sse` type. Once an API definition is generated, you can also edit it in this interface. It displays the API definition in code format in the left panel, and as a form in the right panel. For more information about accessing this view and creating/editing an asynchronous API definition in this view, see [Generating and Viewing Asynchronous API Definitions]({{base_path}}/develop/streaming-apps/working-with-the-async-api-view)

Once a Siddhi application is created, you can simulate events via the
Streaming Integrator Tooling to test whether it works as expected.

## Starting Streaming Integrator Tooling

To start and access the Streaming Integrator Tooling, follow the steps below:

1.  Start the Streaming Integrator Tooling by issuing one of the following
    commands from the `<SI_HOME>/bin` directory.

    -   For Windows: `tooling.bat`
    -   For Linux: `./tooling.sh`

2.  Access the Streaming Integrator Tooling via the `http://localhost:/editor`
    URL. The Streaming Integrator Tooling opens as shown below.

    !!! info
        The default URL is `http://localhost:9390/editor`. If required, you can change the host name (i.e., `localhost`) or the web UI application name (i.e., `editor`). For instructions, see [Changing the Host Name and Context Path of SI Tooling]({{base_path}}/setup/change-hostname-and-context-path).
    

## Welcome Page

![Streaming Integrator Tooling Welcome Page]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/streaming-integrator-tooling-welcome-page.png)

The **Welcome to the Streaming Integrator Tooling Tour Guide** is open by
default. You can take a tour by following the instructions on the dialog
box, or close it and proceed to explore the Streaming Integrator Tooling on
your own. You can also access this dialog box by clicking **Tools** ->
**Tour Guide** . Once you close the dialog box, you can try the
following:

-   **New**
    Click this to open a new untitled Siddhi file.

-   **Open**
    Click this to open a Siddhi file that is already saved in the `workspace` directory of the Streaming Integrator 
    Tooling. If the file is already opened in a new tab, clicking **Open** does not open it again. The default path to 
    the `workspace` directory is `<SI_Home>/wso2/server/deployment`.
    
-   **New ETL Flow**
    Click this to open a wizard with which you can create a Siddhi application with ETL functionality by entering values for the required parameters instead of constructing Siddhi queries by writing code or via a graphical interface. To understand how this is done, follow the [Creating an ETL Application via SI Tooling tutorial]({{base_path}}/use-cases/streaming-tutorials/creating-etl-application-via-tooling).

-   **Try out samples**  
    The pre-created samples provided out of the box are listed in this
    section. When you click on a sample, it opens in a new tab without a
    title.

-   **More Samples**  
    Click this to view the complete list of samples in the samples
    directory. This allows you to access samples other than the ones that
    are displayed by default is the **Try out samples** section. When
    you click on a sample, it opens in a new tab without a title.

-   **Quick links**  
    This section provides links to more resources.

## Menu items

This section explains the options that are available in the **File** ,
**Edit** and **Run** menus.

#### File menu Items

The **File** menu includes the following options.

![File menu]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/file-menu.png)

-   **New**  
    Click this to open a new untitled Siddhi file. For more information, see the [Creating an ETL Application via SI Tooling tutorial]({{base_path}}/use-cases/streaming-tutorials/creating-etl-application-via-tooling).
    
-   **New ETL Flow**
    Click this to create a new ETL application via the ETL wizard. For instructions, 
    
-   **Open File** 
    Click this to open a Siddhi file that is already saved in the `workspace` directory of the Streaming Integrator 
    Tooling. If the file is already opened in a new tab, clicking **Open** does not open it again. The default path to 
    the `workspace` directory is `<SI_Home>/wso2/server/deployment`.         ` .  
      
    When a Siddhi file is opened, its source view is displayed by default.  
    ![The source view of a Siddhi application]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/siddhi-app-source-view.png)  
    To view a design view where the elements of the Siddhi application are graphically represented, click 
    **Design View**. As a result, a graphical view of the Siddhi application is displayed as shown in the following 
    example.  
    ![The design view of Siddhi application]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/siddhi-app-design-view.png)
     
-   **Import Sample**  
    Click this to import a sample from the samples diretory to a new tab. The sample opens in an untitled Siddhi file.
     Once you save it, it can be accessed from the `workspace` directory.  
     
-   **Save**  
    Click this to save an edited or new file to the `workspace` directory.  
    
-   **Save As**  
    Click this if you want to save an existing saved file with a different name. If you click this for an untitled 
    Siddhi file, the normal save operation is executed (i.e., same operation carried out when you click **Save** ). 
     
-   **Import File**  
    Click this to open a file from a system location. This file is opened in a new tab in the saved state with the same
     file name with which it is imported. 
     
-   **Export File** 
    Click this to export a saved file to a system location. This is only applicable to Siddhi application tabs that are
     in a saved state.

-   **Close File**
    Click this to close a currently active Siddhi application that is already open in a tab.  
    
-   **Close All Files** 
    Click this to close all the Siddhi files that are currently open. 
    
-   **Delete File**  
    Click this to delete the currently active Siddhi file from the `workspace` directory. Only Siddhi files that are
    already saved can be deleted.
    
-   **Settings**  
    Click this to change the theme and the font size used in the Streaming Integrator Tooling. The default theme is **Twilight** .

#### Edit menu Items

The **Edit** menu includes the following options.

![Edit menu]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/editor-menu.png)

-   **Undo**  
    Click this to undo the last edit made to the Siddhi application that
    you are currently editing. Only unsaved edits can be undone.
    
-   **Redo**  
    Click this to redo the edit that was last undone in the Siddhi
    application that you are currently editing. The redo operation can
    be carried out only if you have not saved the Siddhi application
    after you undid the change.
    
-   **Find** 
    Click this to search for a specific string in the currently
    active Siddhi application tab.
      
-   **Find and Replace**  
    Click this to search for a specific string in the currently
    active Siddhi application tab, and replace it with another string.
    
-   **Reformat Code**  
    Click this to reformat the Siddhi queries in the Siddhi
    application that you are currently creating/editing in the [source view](#StreamProcessorStudioOverview-SourceView).

    !!! info
        This menu option is only visible when you are working in the [source view](#StreamProcessorStudioOverview-SourceView).
    
-   **Auto-Align** <br/>
    Click this to horizontally align all the Siddhi components in a
    Siddhi application that you are creating/editing in the [design view](#StreamProcessorStudioOverview-DesignView).

    !!! info
        This menu option is only visible when you are working in the [design view](#StreamProcessorStudioOverview-DesignView).

#### Run menu Items

The **Run** menu includes the following options.

![Run menu]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/run-menu-option.png)


-   **Run**  
    Click this to start the Siddhi application in the Run mode. Only
    saved Siddhi applications can be run.

    !!! info
        This menu option is enabled only when a Siddhi application is being created/edited in the [source view](#StreamProcessorStudioOverview-SourceView).
    

-   **Stop**  
    Click this to stop a Siddhi application that is already running.

  

#### Tools menu items

The **Tools** menu provides access to the following tools that are shipped with the Streaming Integrator Tooling.

![Tools menu]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/tools-menu.png)

- **File Explorer** 

    The file explorer. This is also avaible in the [Side Panel](#StreamProcessorStudioOverview-SidePanel).
    
- **Extension Installer**

    This opens the **Extension Installer** dialog box (shown below) where you can search for the required extension and install/uninstall it by clicking **Install** or **Uninstall** as appropriate. Once you install/uninstall an extension, you need to restart the Streaming Integrator Tooling. For detailed instructions, see [Installing Siddhi Extensions]({{base_path}}/develop/streaming-apps/installing-siddhi-extensions).

     ![Extension Installer]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/extension-installer.png)   
    
- **Event Simulator**  

    Simulation can be carried out in two ways:

    -   Single Simulation
    -   Feed Simulation

    For detailed information about event simulation, see [Simulating Events](_Simulating_Events_).  
    The event simulator can also be accessed from the [Side Panel](#StreamProcessorStudioOverview-SidePanel).
    
- **Error Store Explorer**

    This opens the Error Store Explorer in which you can view, correct and replay the streaming events with errors that are stored in the error store.
    
    In order to use it, first you need to connect it to the SI server by clicking **Connect to Server** and then entering the server configurations in the dialog box that appears.
    
    ![Connect to Server]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/connect-error-store-explorer.png)
     
    Once the Error Store Explorer is connected to an SI server, you can get an overview of events with errors as shown in the example below.
    
    ![Error Store Explorer]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/view-basic-error-info.png)
    
    Here, you can do the following:
    
    - **Fetch Errors**: At a given time, the Error Store Explorer displays the number of events with errors from the time it was last fetched/refreshed. To get the latest errors, select the required Siddhi application in the **Siddhi app** field and click **Fetch**.
    
    - **View details**: To view details of a specific error, click **Detailed Info** for the relevant event. Then the details of the error are displayed in the **Error Entry** dialog box as shown in the example below.
           ![Error Entry]({{base_path}}/assets/img/streaming/handling-requests-with-errors/error-entry.png)
           
    - **Replay events**: This can be done in one of the following three methods:
    
        - To replay all the events for the selected Siddhi application without making any changes, click **Replay All**.
        
        - To replay a single event without making any changes, click **Replay** for the specific event.
        
        - To make any changes to the event before replaying, click **Detailed Info** for the relevant event and open the **Error Entry** dialog box. Then make the required changes to the event (which is displayed in an editable field) and click **Replay**.
        
            !!!info
                Note that only mapping errors can be corrected before replaying.
        
            ![Correct and Replay Event]({{base_path}}/assets/img/streaming/handling-requests/correct-and-replay-event.png)
            
    - **Discard events**: To discard all the erroneous events for the selected Siddhi application, click **Discard All**. To discard a specific erroneous event, click **Discard** for the relevant event.
    
    - **Purge Events**: To periodically purge events, click **Purge**. This opens the **Purge Error Store** dialog box. In the **Retention Period (days)** field, enter the number of past days for which you want to retain the erroneous events in the store and then click **Purge**. As a result, all the events except the ones stored in the specified number of past days are removed from the error store.
    
    To understand how to save messages with errors in the error store, see [Handling Errors]({{base_path}}/use-cases/streaming-usecase/handling-errors).
    
    To try out an error handling tutorial, see [Handling Requests with Errors]({{base_path}}/use-cases/streaming-tutorials/handling-requests-with-errors).
      
- **Console**

    This is an output console that provides feedback on various user activities carried out on the Streaming Integration Tooling. It is accessible from the [Side Panel](#StreamProcessorStudioOverview-SidePanel).
    
- **Sample Event Generator**

    This opens the Sample Event Generator as follows.  
    ![Sample event generator]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/sample-event-generator.png)  
    Here, you can generate sample events for a selected stream within a selected Siddhi application in a specified format.  
      
- **On-Demand Query**

    This opens the **On-Demand Query** dialog box.
    
    ![Siddhi Store Query]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/on-demand-query.png)
    Here, you can select a Siddhi application, and then enter a query to
    manipulate the store in which that Siddhi Application saves data.
    You can enter queries that can update record, insert/update records,
    retrieve records and delete records. For more information about
    actions you can carry out for stores, see [Store APIs]({{base_path}}/develop/streaming-apps/store-apis).
      
- **Tour Guide**

    This opens a dialog box named **Welcome to the Streaming Integrator
    Tooling Tour Guide** which guides you to understand Streaming Integrator Tooling. When you start the Streaming Integrator Tooling and access it,
    this dialog box is open by default.

#### Deploy menu items

The **Deploy** menu has the following option to select one or more Siddhi applications and deploy them to one or more 
Streaming Integrator servers. For more information, see [Deploying Siddhi Applications]({{base_path}}/develop/streaming-apps/deploying-streaming-applications).

![Deploy menu]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/deploy-menu.png)

#### Export menu items

The **Export** menu has the following options that allow you to export Siddhi applications in a format that can be deployed in a containerized environment.

![Export menu]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/export-menu.png)

- **For Docker**
    This opens the **Export Siddhi Apps for Docker image** wizard. For more information, see [Running the Streaming Integrator with Docker]({{base_path}}/use-cases/streaming-tutorials/running-si-with-docker-and-kubernetes/#running-the-streaming-integrator-with-docker).

- **For Kubernetes**
    This opens the **Export Siddhi Apps For Kubernetes CRD** wizard. For more information, see [Running the Streaming Integrator with Kubernetes]({{base_path}}/use-cases/streaming-tutorials/running-si-with-docker-and-kubernetes/#running-the-streaming-integrator-with-kubernetes).

## Side Panel

**File Explorer**

![File Explorer menu]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/file-explorer.png)

This provides a view of all the files saved as shown in the example above.

### Event Simulator

![Event Simulator]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/event-simulator.png)

Simulation can be carried out in two ways:

-   Single Simulation
-   Feed Simulation

For detailed information about event simulation, see [Simulating Events](_Simulating_Events_).

### Output Console

![Output Console]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/output-console.png)

This provides feedback on various user activities carried out on the Streaming Integrator.

### Operator Finder

![Operator Finder]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/operator-finder.png)

Click the **Operator Finder** icon to search for the Siddhi extensions
that you want to use in your Siddhi applications.

-   For the complete list of Siddhi extensions that you can search for
    via the Operator Finder, see [Siddhi Extensions](http://siddhi-io.github.io/siddhi/extensions/).
-   For detailed instructions to find and use a Siddhi extension via the
    Operator Finder demonstrated with an example, see [Creating a Siddhi Application]({{base_path}}/develop/streaming-apps/creating-a-siddhi-application).

### Template Variables

 ![Template Variables]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/template_variables-icon.png)


Click this icon to open the **Templated Variables** side panel (shown below) where you can open the templated attributes in the currently saved Siddhi applications and provide variables to be applied when running the Siddhi applications.


 ![Templated Variables]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/templated-variables.png)

For more information about templated variables, see [Siddhi Documentation - Siddhi as a Local Microservice - Running with environmental/system variables](https://siddhi.io/en/v5.1/docs/siddhi-as-a-local-microservice/#running-with-environmentalsystem-variables).

## Toolbar

  ![Tool Bar menu]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/editor-toolbar.png)

-   **Run icon**  
    Click this to start a currently open Siddhi application in the Run
    mode. This icon is enabled only for saved Siddhi applications.  

-   **Stop icon**  
    Click this to stop a Siddhi application that is currently running.

-   **Revert icon**  
    Click this to revert the unsaved changes in the Siddhi application
    that is currently being created/edited.


