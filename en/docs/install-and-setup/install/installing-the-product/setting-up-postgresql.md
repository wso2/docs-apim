# Setting up a PostgreSQL Database

Follow the steps given below to set up the required Postgre databases for your Micro Integrator (MI) Dashboard.

## Setting up the database and login role

The Postgre script is stored in the `<MI_DASHBOARD_HOME>/dbscripts/postgresql` directory of your Micro Integrator. First, select 
the scripts that are required for your deployment.

Create the database and then create the DB tables by pointing to the PostgreSql script in the 
`<MI_DASHBOARD_HOME>/dbscripts/postgresql` directory.

```bash tab='Dashboard DB'
Login to postgresql-client :

psql -h <host> -U <user>

CREATE DATABASE sample;

In Terminal run following command to source db script : 

psql -h <host> -U <user> -d sample -f <MI_DASHBOARD_HOME>/dbscripts/postgresql/postgresql.sql -a

```



## Setting up the drivers

1.  Download the [PostgreSQL JDBC4 driver](http://jdbc.postgresql.org/download.html).
2.  Copy the driver to the `MI_DASHBOARD_HOME/lib` directory.    

## Connecting the database to the server

Open the `deployment.toml` file in the `<MI_DASHBOARD_HOME>/conf` directory and add the following sections to create the connection between the Micro Integrator (MI) Dashboard and the database.

```toml tab='Dashboard DB Connection'
[datasource]
jdbcUrl = "jdbc:postgresql://localhost:5432/sample"  
username = "postgres"
password = "root"
driverClassName = "org.postgresql.Driver"
maximumPoolSize = "100"
poolName = "dashboard-1"
connectionTimeout = "400000"
maxLifetime = "2000000"
```

For more information, see the descriptions of [database connection parameters]({{base_path}}/reference/config-catalog-mi-dashboard/#database-connection).
