# Setting up an Oracle Database

Follow the steps given below to set up the required Oracle databases for your Micro Integrator
(MI) Dashboard.

## Creating the databases

The required Oracle script is stored in the `<MI_DASHBOARD_HOME>/dbscripts/oracle` directory of your Micro Integrator 
(MI) Dashboard.

Create the database and then create the DB tables by pointing to the Oracle script in the 
`<MI_DASHBOARD_HOME>/dbscripts/oracle` directory.

```bash tab='Dashboard DB'
In SqlPlus terminal run following command to source the script
@/home/oracle/oracle.sql
```

## Setting up the JDBC driver

1. Download the [Oracle JDBC driver](https://download.oracle.com/otn-pub/otn_software/jdbc/1915/ojdbc8.jar).
2. Add the downloaded Oracle driver and copy the JAR (ojdbc8.jar) to the 
   `<MI_DASHBOARD_HOME>/lib/` directory of your Micro Integrator (MI) Dashboard.

## Connecting the database to the server

Open the `deployment.toml` file in the `<MI_DASHBOARD_HOME>/conf` directory and add the following sections to create the connection between the Micro Integrator (MI) Dashboard and the database.

```toml tab='Dashboard DB Connection'
[datasource]
jdbcUrl = "jdbc:oracle:thin:@localhost:1521/ORCLPDB1"
username = "SYSTEM"
password = "oracle"
driverClassName = "oracle.jdbc.OracleDriver"
maximumPoolSize = "100"
poolName = "dashboard-1"
connectionTimeout = "400000"
maxLifetime = "2000000"
```

For more information, see the descriptions of [database connection parameters]({{base_path}}/reference/config-catalog-mi-dashboard/#database-connection).
