# Capturing MySQL Inserts via CDC

## Purpose:
This sample demonstrates how to capture change data from MySQL using Siddhi. The change events that can be captured include `INSERT`, `UPDATE`, and `DELETE`.

!!!info "Before you begin:"
    1. Ensure that MySQL is installed on your computer.<br/>
    2. Add the MySQL JDBC driver to the `<SI_TOOLING_HOME>/lib` directory as follows:<br/>
        1. Download the JDBC driver from the [MySQL website](https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz).<br/>
        2. Unzip the archive.<br/>
        3. Copy the `mysql-connector-java-5.1.45-bin.jar` JAR and place it in the `<SI_TOOLING_HOME>/lib` directory.<br/>
    3. Enable binary logging in the MySQL server. For detailed instructions, see [Debezium documentation - Enabling the binlog](https://debezium.io/docs/connectors/mysql/#enabling-the-binlog).<br/>
        !!! info
            If you are using MySQL 8.0, use the following query to check the binlog status.<br/>
            ```
            SELECT variable_value as "BINARY LOGGING STATUS (log-bin) ::"
            FROM performance_schema.global_variables WHERE variable_name='log_bin';
            ```<br/>
    4. Enable state persistence in siddhi applications. To do this, open the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file and set the `state.persistence enabled=true` property.<br/>
    5. Create a database named `production` by issuing the following command.<br/>
        `create database production;`<br/>
    6. Create a user named `wso2sp` with `wso2` as the password, and with `SELECT`, `RELOAD`, `SHOW DATABASES`, `REPLICATION SLAVE`, `REPLICATION CLIENT` privileges. To do this, issue the following command.<br/>
        `GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'wso2sp' IDENTIFIED BY 'wso2';`<br/>
    7. Change the database by issuing the following command.<br/>
        `use production;`<br/>
    8. Create a table named `SweetProductionTable`.<br/>
        `CREATE TABLE SweetProductionTable (name VARCHAR(20),amount double(10,2));`<br/>
    9. Save the sample Siddhi application in Streaming Integrator Tooling.


## Executing the Sample

To execute the sample open the saved Siddhi application in Streaming Integrator Tooling, and start it by clicking the **Start** button (shown below) or by clicking **Run** => **Run**.

![Start button]({{base_path}}/assets/img/streaming/amazon-s3-sink-sample/start.png)

If the Siddhi application starts successfully, the following message appears in the console.

`CDCWithListeningMode.siddhi -  Started Successfully!`

!!!note
    If you want to edit the Siddhi application after you have started it, stop it first, make your edits, save it and then start it again.


## Testing the Sample

To test the sample Siddhi application, insert a record to the `SweetProductionTable` table you created by issuing the following command:

`insert into SweetProductionTable values('chocolate',100.0);`

## Viewing the results

This insert is logged in the Streaming Integrator console as follows.

![Insert Log]({{base_path}}/assets/img/streaming/cdc-with-listening-mode-sample/insert-log.png)

!!!info
    Optionally, you can use this sample to also capture `update` and `delete` operations.<br/>
    - delete operation events include `before_name` and `before amount` keys.<br/>
    - update operation events include the `before_name`, `name`, `before_amount`, `amount` keys.

???info "Click here to view the sample Siddhi application."
    ```sql
    @App:name('CDCWithListeningMode')
    @App:description('Capture MySQL Inserts using cdc source listening mode.')


    @source(type = 'cdc', url = 'jdbc:mysql://localhost:3306/production', username = 'wso2sp', password = 'wso2', table.name = 'SweetProductionTable', operation = 'insert',
        @map(type = 'keyvalue'))
    define stream insertSweetProductionStream (name string, amount double);

    @sink(type = 'log')
    define stream logStream (name string, amount double);

    @info(name = 'query')
    from insertSweetProductionStream
    select name, amount
    insert into logStream;
    ```