# Setting up a MySQL Database

Follow the steps given below to set up the required MySQL databases for your Micro Integrator (MI) Dashboard.


## Setting up a MySQL server

To set up MySQL:

1. Download and install [MySQL Server](http://dev.mysql.com/downloads/).
2. Execute the following command in a terminal/command where the username is the username you want to use to access the server:

	 ```bash
	 mysql -u username -p
	 ```

3. When prompted, specify the password to access the server with the username you specified.

## Creating the databases

The required MySQL script is stored in the `<MI_DASHBOARD_HOME>/dbscripts/mysql` directory of your Micro Integrator (MI) Dashboard.

Create the database and then create the DB tables by pointing to the MySQL script in the `<MI_DASHBOARD_HOME>/dbscripts/mysql` directory.

```bash tab='Dashboard DB'
mysql> create database dashboarddb character set utf8;
mysql> use dashboarddb;
mysql> source <MI_DASHBOARD_HOME>/dbscripts/mysql/mysql.sql;
```

## Setting up the JDBC driver

1. Download the [MySQL JDBC driver](http://dev.mysql.com/downloads/connector/j/).
2. Unzip the downloaded MySQL driver and copy the JAR (mysql-connector-java-x.x.xx.jar) to the `<MI_DASHBOARD_HOME>/lib/` directory of your Micro Integrator (MI) Dashboard.

## Connecting the database to the server

Open the `deployment.toml` file in the `<MI_DASHBOARD_HOME>/conf` directory and add the following sections to create the connection between the Micro Integrator (MI) Dashboard and the database.

```toml tab='Dashboard DB Connection'
[datasource]
jdbcUrl = "jdbc:mysql://localhost:3306/dashdb"
username = "root"
password = "root"
driverClassName = "com.mysql.cj.jdbc.Driver"
maximumPoolSize = "100"
poolName = "dashboard-1"
connectionTimeout = "400000"
maxLifetime = "2000000"
```

See the descriptions of [database connection parameters]({{base_path}}/reference/config-catalog-mi-dashboard/#database-connection).
