# Monitoring Integration Transactions Counts

A **Transaction** in WSO2 Micro Integrator is typically defined as an inbound request (a request coming to the server). That is, any inbound request to a [REST API]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api), [Proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service), or [Inbound Endpoint]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint) is considered as one transaction.

However, when the Micro Integrator is configured as both the message producer and consumer to handle **asynchronous** messaging scenarios, the two requests (listening request and sending request) are considered as a single transaction.

If you need to track the number of transactions in your Micro Integrator deployment, you can enable the transaction counter component in each Micro Integrator instance of your deployment. Currently, the transaction counter is responsible for counting all requests received via the [HTTP Passthru]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-httphttps-transport) and [JMS]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-jms-transport) transports and for persisting the summary of the transaction count in a database for future use.

Follow the instructions given below.

## Step 1 - Enabling the transaction counter

Configure a relational database to persist transaction count information and then enable the **Transaction Counter** component from the `deployment.toml` file (stored in the `<MI_HOME>/conf` folder).

1.  Select the preferred database type from the list given below and follow the relevant link to set up a database.

    - [Setting up a MySQL database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-MySQL)
    - [Setting up an MSSQL database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-MSSQL)
    - [Setting up an Oracle database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-Oracle)
    - [Setting up a Postgre database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-PostgreSQL)
    - [Setting up an IBM database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-IBM-DB2)

2.  Once you have set up the database, verify that the `deployment.toml` file of your Micro Integrator contains the relevant datasource configurations:

    ```toml tab='MySQL'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url= "jdbc:mysql://localhost:3306/transactiondb"
    username="root"
    password="root"
    driver="com.mysql.jdbc.Driver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

    ```toml tab='MSSQL'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url= "jdbc:sqlserver://<IP>:1433;databaseName=transactiondb;SendStringParametersAsUnicode=false"
    username="root"
    password="root"
    driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

    ```toml tab='Oracle'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url= "jdbc:oracle:thin:@SERVER_NAME:PORT/SID"
    username="root"
    password="root"
    driver="oracle.jdbc.OracleDriver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

    ```toml tab='PostgreSQL'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url= "jdbc:postgresql://localhost:5432/transactiondb"
    username="root"
    password="root"
    driver="org.postgresql.Driver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

    ```toml tab='IBM DB'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url="jdbc:db2://SERVER_NAME:PORT/transactiondb"
    username="root"
    password="root"
    driver="com.ibm.db2.jcc.DB2Driver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

3.  Add the parameters given below to the `deployment.toml` file and update the values.

    ```toml
    [transaction_counter]
    enable = true
    data_source = "WSO2_TRANSACTION_DB"
    update_interval = 2
    ```

    Parameters used above are explained below.

    <table>
    	<tr>
    		<th>Parameter</th>
    		<th>Description</th>
    	</tr>
    	<tr>
    		<td>
    			<code>enable</code>
    		</td>
    		<td>
    			This paramter is used for enabling the Transaction Counter. Default value if 'false'.
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<code>data_source</code>
    		</td>
    		<td>
    			The ID of the datasource. This refers the datasource ID configured under the datasource configuration.
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<code>update_interval</code>
    		</td>
    		<td>
    			The transaction count is stored in the database with an interval (specified by this parameter, which will be taken as the number of minutes) between the insert queries. The default update interval is one minute.
    		</td>
    	</tr>
    </table>

## Step 2 - Getting the transaction count

You can get the transaction count for a particular month or period. This data can be viewed or saved to a report. There are two ways to get transaction count data:

-  Start the [APICTL]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller) and use the [mi transaction]({{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl/#monitor-transactions) option.

-  Directly access the [Management API resources]({{bae_path}}/observe/mi-observe/working-with-management-api) and invoke the [/transaction/count]({{base_path}}/observe/mi-observe/working-with-management-api/#get-transaction-count) and [/transaction/report]({{base_path}}/observe/mi-observe/working-with-management-api/#get-transaction-report-data) resources.