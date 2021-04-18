# Creating an ETL Application via SI Tooling

## Introduction

ETL (Extract, Transform, Load) is a form of data processing that involves performing the following functions in the given order:

1. **Extract**: Obtaining input data from a specific source such as a file or a database.

2. **Transform**: Converting the data obtained to a different form.

3. **Load** Writing the data extracted and transformed into another destination.

Tutorials such as [Performing Real-time ETL with Files]({{base_path}}/use-cases/streaming-tutorials/performing-real-time-etl-with-files) and [Performing Real-time ETL with MySQL]({{base_path}}/use-cases/streaming-tutorials/performing-real-time-etl-with-mysql) show how the WSO2 Streaming Integrator can perform ETL for streaming data by writing and deploying Siddhi applications with ETL functionality. If you need to create such a Siddhi application without writing code, you can use the ETL Flow wizard in Streaming Integrator Tooling.

In this tutorial, let's create the same Siddhi application created in [Performing Real-time ETL with MySQL]({{base_path}}/use-cases/streaming-tutorials/performing-real-time-etl-with-mysql) using the Streaming Integrator Tooling.

## Before you begin

- You need to have access to a MySQL instance.

- Enable binary logging in the MySQL server. For detailed instructions, see [Debezium documentation - Enabling the binlog](https://debezium.io/docs/connectors/mysql/#enabling-the-binlog).

    !!! info
        If you are using MySQL 8.0, use the following query to check the binlog status.<br/>
        ```
        SELECT variable_value as "BINARY LOGGING STATUS (log-bin) ::"
        FROM performance_schema.global_variables WHERE variable_name='log_bin';
        ```
        
- Add the MySQL JDBC driver into the `<SI_HOME>/lib` directory as follows:

    1. Download the MySQL JDBC driver from [the MySQL site](https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz).
    
    2. Unzip the archive.
    
    3. Copy the `mysql-connector-java-5.1.45-bin.jar` to the `<SI_HOME>/lib` directory.
    
    4. Start the SI server by issuing the appropriate command based on your operating system.
    
          - For Windows: `server.bat --run`
          - For Linux:  `sh server.sh`

- Once you install MySQL and start the MySQL server, create the database and the database table you require as follows:

    1. Let's create a new database in the MySQL server which you are to use throughout this tutorial. To do this, execute the following query.
    
        ```
        CREATE SCHEMA production;
        ```
       
    2. Create a new user by executing the following SQL query.
    
        ```
        GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'wso2si' IDENTIFIED BY 'wso2';
        ```
       
    3. Switch to the `production` database and create a new table, by executing the following queries
    
        ```
        use production;
        ```
       
       ```
       CREATE TABLE SweetProductionTable (name VARCHAR(20),amount double(10,2));
       ```
        
- Download `productions.csv` file from [here](https://github.com/wso2/docs-ei/tree/master/en/streaming-integrator/docs/examples/resources/productions.csv) and save it in a location of your choice. (e.g., in `/Users/foo`).

- Download and install [Streaming Integrator Tooling](https://wso2.com/integration/streaming-integrator/#)
        
- Download and install the [siddhi-io-cdc](https://siddhi-io.github.io/siddhi-io-cdc/) extension. For instructions, see [Downloading and Instaling Siddhi Connectors]({{base_path}}/streaming/connectors/downloading-and-installing-siddhi-extensions).

## Step 1: Design the Siddhi application with ETL functionality

To design the Siddhi application with ETL functionality via the Streaming Integrator Tooling, follow the steps below:

1. Start the Streaming Integrator Tooling by navigating to the `<SI_TOOLING_HOME>/bin` directory and issuing one of the following commands as appropriate, based on your operating system:

    - For Windows: `tooling.bat`

    - For Linux: `./tooling.sh`
    
    Then Access the Streaming Integrator Tooling via the URL that appears in the start up log with the text `Editor Started on:`.
    
2. In the Welcome screen, click **New ETL Flow**.

    ![Open New ETL Flow]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/open-new-etl-flow.png)
    
    This opens the wizard to create ETL task flows as follows.
    
    ![ETL Task Flow Wizard]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/etl-task-flow.png)
    
3. Change the title of the ETL task flow from `UntitledETLTaskFlow` to `SweetFactoryETLTaskFlow`.

4. In **Step 1 Configure Source**, enter information relating to the data source as follows:

    1. Under **Transport Properties**, select **CDC** as the source. Then enter values for the properties relating to the CDC source as follows.
    
        ![Transport Properties]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/source-transport-properties.png)
    
        |**Property** |**Value**                                |
        |-------------|-----------------------------------------|
        |url          |`jdbc:mysql://localhost:3306/production` |
        |username     |`wso2si`                                 |
        |password     |`wso2`                                   |
        |table.name   |`SweetProductionTable`                   |
        |operation    |`insert`                                 |
        
        Then click **Next**.
        
    2. In the **Configure Schema** section, do the following to define the schema of the events you expect to receive as input data:
    
        1. Click the tick (**✓**) for the **Add log sink for testing** parameter.
        
        2. Under **Enter input stream name**, enter `InsertSweetProductionStream`. Then add two attributes as follows:
        
            ![Configure Schema]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/configure-schema.png)
        
            1. Move the cursor over the **+** sign next to **input stream attributes** and select **STRING**. As a result, a new row is created for the attribute. Enter `name` as the attribute name.
            
            2. Move the cursor over the **+** sign again, and then select **DOUBLE**. Then enter `amount` as the attribute name.
            
            3. Click **Next**. 
            
    3. In the **Configure Input Mapping** section, select **keyvalue** as the source mapper type.
        
        ![select-source-mapper-type]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/select-source-mapper-type.png)
        
        Then click **Next**.
            
5. In this scenario, let's do a simple conversion where the names that are received in simple case are converted to upper case when they are published in the file. This is a mapping-related conversion. Therefore, in **Step 2 Process Input Data**, click **Next** without making any change.

6. In **Step 3 Configure Destination**, enter information on how you want the output to be published. In this scenario, let's publish the output in a CSV file named `productioninserts.csv`.

    1. Under **Transport Properties**, select **file** as the sink type. Then enter the path to the `productioninserts.csv` file which you saved as an empty CSV file (in this example, `/Users/foo/productioninserts.csv`).
    
        ![Transport Properties]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/sink-transport-properties.png)
        
        Then click **Next**.
    
    2. In the **Configure Schema** section, enter information as follows to create an output stream that defines the schema of the outgoing events.
    
        ![Configure output schema]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/configure-output-event-schema.png)
    
        1. Click the tick (**✓**) for the **Add log sink for testing** parameter in order to log the output events in the console.
        
        2. Under **Enter output stream name**, enter `ProductionUpdatesStream`.
        
        3. Move the cursor over the **+** sign next to **output stream attributes** and select **STRING**. As a result, a new row is created for the attribute. Enter `name` as the attribute name.
                       
        4. Move the cursor over the **+** sign again, and then select **DOUBLE**. Then enter `amount` as the attribute name.
        
        5. Click **Next**.
        
    3. In the **Configure Output Mapping** section, select **text** as the sink mapper type.
    
        ![Configure Output Mapping]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/configure-output-mapping.png)
        
        Then click **Next**.

4. In **Step 4 Process Output Data**, move the cursor over the **+** sign under **Group Output by Fields**, and then click **name**. This groups the output events by the name of the product.

    ![Group Events By]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/group-by.png)

    Then click **Next**.
    
5. In **Step 5 Data Mapping**, follow the procedure below to do the required configurations for the data transformation to be done by your ETL Siddhi application.

    1. Click the following button to map all the attributes.
    
        ![Select all attributes]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/select-atributes.png)
        
        As a result, the attributes in the input stream and the output stream are joined together by lines as shown below.
        
        ![Matched attributes]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/matched-attributes.png)
        
        This indicates that the value for each input attribute is directed to the output stream without any further processing to be published. However, since you need to do a simple conversion for the `name` attribute. Therefore, remove the matching for that attribute by clicking the following icon for it under **Output Attributes**. Move the cursor to the right of the attribute to make this icon appear.
        
        ![Remove Matching]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/remove-matching.png)
    
    2. Click on **name** under **Output Attributes**.

        ![Select Name Attribute]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/select-name-attribute.png)
    
        This opens a dialog box named **Create expression for name of ProductionUpdatesStream**. 
    
    3. In the **Create expression for name of ProductionUpdatesStream** dialog box, click **Function**. Scroll to find the **str.upper()** function, and then click on it to select it.
    
        ![Select Function]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/select-function.png)
        
        Once select the function, it is displayed as follows. Click on the selected function again.
        
        ![Click Selected Function]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/click-selected-function.png)
        
    4. When the function is added as shown below, click on it again.
    
        ![Click Selected Expression]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/configure-function-parameters.png)
        
        Another bar appears below the selected function with the function expression in the clickable mode between the brackets.
        
    5. To specify the attribute to which the function should be applied, click on the dots between the brackets.
    
        ![Select Attribute for Function]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/select-attribute-for-function.png)
        
    6. Click on **name** attribute to select it as the attribute to which the function applies.
    
        ![Select Attribute for Function]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/select-attribute.png)
        
    7. Once the `name` attribute is selected and displayed, click the arrow pointing upwards to the right of the attribute. This adds the `name` attribute to the function expression.
    
        ![Add Attribute to function expression]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/add-attribute-to-function-expression.png)
        
    8. Once the function is displayed with both the expression and the attribute, click the arrow pointing upwards to the right of it. This completes the function configuration.
    
        ![Complete Function Configuration]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/complete-function-configuration.png)
        
    9. Click **Submit**.
    
        Now both the attributes appear matched again, and the function expression is displayed for the **name** attribute.
    
        ![Matched Attributes]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/joined-attributes.png)
        
    10. Click **Save**.
     
    
7. In **Step 6 Finalize**, deploy the Siddhi application you just completed by clicking **Deploy to Worker**.

    ![Complete ETL Application]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/deploy-etl-app-to-worker.png)
    
    This opens the **Deploy Siddhi Apps to Server** dialog box.
    
    1. In the **Add New Server** section, enter the host, port, user name and the password of your Streaming Integrator server as shown below.
    
        ![Adding a New Server]({{base_path}}/assets/img/streaming/-etl-application-via-tooling/add-a-new-server.png)
        
        Then click **Add**.
        
    2. In the **Siddhi Apps to Deploy** section, select the checkbox for the **SweetFactoryETLTaskFlow.siddhi** application. In the **Servers** section, select the check box for the server you added. Then click **Deploy**.
    
        ![Select Siddhi Application and Server]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/select-siddhi-app-and-server.png)
        
        The following message appears in the **Deploy Siddhi Apps to Server** dialog box.
        
        `SweetFactoryETLTaskFlow.siddhi was successfully deployed to 0.0.0.0:9444`
        
## Step 2: Test the Siddhi application

To test the Siddhi application, insert a record to the `SweetProductionTable` MySQL table by issuing the following command in your MySQL console.

`insert into SweetProductionTable values('chocolate',100.0);`

The following log appears in the Streaming Integrator console.

```
INFO {org.wso2.siddhi.core.stream.output.sink.LogSink} - CDCWithListeningMode : logStream : Event{timestamp=1563200225948, data=[chocolate, 100.0], isExpired=false}
```

If you open the `/Users/foo/productions.csv` file, the `Chocalate, 100.0` record is displayed as shown below.

![Updated File]({{base_path}}/assets/img/streaming/create-etl-application-via-tooling/updated-file.png)

!!! info "What's Next?"
    Once you develop an ETL application, you may need to carry out following tasks:<br/><br/>   
    - **Error Handling**: To understand how to handle errors that may occur when carrying out ETL operations, try the [Managing Streaming Data with Errors tutorial]({{base_path}}/use-cases/streaming-tutorials/handling-requests-with-errors).<br/><br/>     
    - **Monitoring ETL Statistics**: For instructions to set up pre-configured dashboards provided with WSO2 Streaming Integrator and visualize statistics related to your ETL flows, see [Monitoring ETL Statistics with Grafana]({{base_path}}/admin/viewing-dashboards).