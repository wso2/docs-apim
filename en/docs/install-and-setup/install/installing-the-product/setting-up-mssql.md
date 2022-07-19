# Setting up a Microsoft SQL Database

Follow the steps given below to set up the required MSSQL databases for your Micro Integrator (MI) Dashboard.

## Creating the database

The required MsSQL script is stored in the `<MI_DASHBOARD_HOME>/dbscripts/mssql` directory of your Micro Integrator (MI) Dashboard.

Create the database and then create the DB tables by pointing to the MsSQL script in the 
`<MI_DASHBOARD_HOME>/dbscripts/mssql` directory.

```bash tab='Dashboard DB'
Connect to sqlcmd 

sqlcmd -S <host> -U <username> 

And then enter following
USE master ;  
GO
CREATE DATABASE dashboarddb;
GO

Change the <DB_NAME> in first line of mssql.sql script given in <MI_DASHBOARD_HOME>/dbscripts/mssql/mssql.sql to 
actual DB name 
ex: use dashboarddb;

:r <MI_DASHBOARD_HOME>/dbscripts/mssql/mssql.sql
```

## Setting up the JDBC driver
[Download](https://msdn.microsoft.com/en-us/data/aa937724.aspx) and copy the `mssql-jdbc-10.2.1.jre8.jar` Microsoft SQL JDBC driver file to the `MI_DASHBOARD_HOME/lib/` directory. Use `com.microsoft.sqlserver.jdbc.SQLServerDriver` as the <driverClassName> in your datasource configuration as explained below.

## Connecting the database to the server

Open the `deployment.toml` file in the `<MI_DASHBOARD_HOME>/conf` directory and add the following sections to create the connection between the Micro Integrator (MI) Dashboard and the database.

```toml tab='Dashboard DB Connection'
[datasource]
jdbcUrl = "jdbc:sqlserver://localhost:1433;databaseName=dashboarddb;encrypt=true;trustServerCertificate=true;"
username = "sa"
password = "xxxx"
driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
maximumPoolSize = "100"
poolName = "dashboard-1"
connectionTimeout = "30000"
maxLifetime = "1800000"
```

See the descriptions of [database connection parameters]({{base_path}}/reference/config-catalog-mi-dashboard/#database-connection).
