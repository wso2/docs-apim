# Configuring Geo Location Based Statistics

!!! note
    This documentation uses MySQL as an example for configuring the GEO_LOCATION_DATA database.

!!! info
    In order to generate Geolocation based statistics, you need to pass an `x-forwarded-for` header with the relevant IP in the API request.

1.  Use the Geo Location dataset that you created [here]({{base_path}}/learn/analytics/analyzing-apim-statistics-with-batch-analytics/using-geo-location-based-statistics/creating-geo-location-data-set/) when configuring geo location based statistics.
2.  Create a database with name `GEO_LOCATION_DATA` and create tables in it by executing one of the following scripts. 

    | [mysql.sql]({{base_path}}/assets/attachments/learn/analytics/geo-location/mysql.sql) | [mssql.sql]({{base_path}}/assets/attachments/learn/analytics/geo-location/mssql.sql) | [oracle.sql]({{base_path}}/assets/attachments/learn/analytics/geo-location/oracle.sql) | [postgresql.sql]({{base_path}}/assets/attachments/learn/analytics/geo-location/postgresql.sql) | [db2.sql]({{base_path}}/assets/attachments/learn/analytics/geo-location/db2.sql) |

    In this example, `mysql.sql` is executed.

    **Command to run in MySQL command line**
    ```sql
    mysql -h <hostname> -u <username> <database_name>  < <path_to_mysql_script> -p
    ```
    Example command:
    ```sql
    mysql -h localhost -u root GEO_LOCATION_DATA  < /mysql.sql -p
    ```
    
    !!! tip
        This also can be done using the [MySQL Workbench](https://dev.mysql.com/downloads/workbench/).
    
        For detailed instructions to run the database script, see [MySQL Documentation - The Workbench Scripting Shell](https://dev.mysql.com/doc/workbench/en/wb-scripting-shell.html).

3. Import the created `final.csv` file(created in the first step) into BLOCKS table. Use the command given below.

    ``` sql
    load data local infile '[PATH_TO_FINAL.CSV]/final.csv' into table BLOCKS
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    (network_cidr, network, broadcast, geoname_id, registered_country_geoname_id, represented_country_geoname_id, is_anonymous_proxy, is_satellite_provider, postal_code, latitude, longitude, network_blocks);
    ```

4. Import the `GeoLite2-City-Locations-en.csv` file located inside the extracted latest CSV zip directory (e.g GeoLite2-City-CSV\_20200310) into LOCATION table. Use the command given below.

    ``` sql
    load data local infile '[PATH_TO_GeoLite2-City-Locations-en]/GeoLite2-City-Locations-en.csv' into table LOCATION
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    (geoname_id, locale_code, continent_code, continent_name, country_iso_code, country_name, subdivision_1_iso_code, subdivision_1_name, subdivision_2_iso_code, subdivision_2_name, city_name, metro_code, time_zone);
    ```

    !!! tip
        If you get an error when importing data from `GeoLite2-City-Locations-en.csv` to `LOCATION` table in PostgreSQL(as `GeoLite2-City-Locations-en.csv` file may include additional columns like 'is_in_european_union' which are not required) you can alter the `LOCATION` table to include non required columns and continue with the importing. Once the importing is successful, you can drop those non required columns.      

5.  Check whether your imported dataset is working properly by executing following query in the MySQL Command Line.
    ``` sql
    SELECT loc.country_name,loc.subdivision_1_name
    FROM BLOCKS block , LOCATION loc
    WHERE block.network_blocks = '<Network_part_of_ipv4>'
    AND <Long_value_of_publilc_IP> BETWEEN block.network
    AND block.broadcast AND block.geoname_id=loc.geoname_id;
    ```

    **Example query** :

    ``` sql
    SELECT loc.country_name,loc.subdivision_1_name
    FROM BLOCKS block , LOCATION loc
    WHERE block.network_blocks = '221.192'
    AND 3720398641 BETWEEN block.network
    AND block.broadcast AND block.geoname_id=loc.geoname_id;
    ```

6.  Download a JDBC provider depending on the database you are using (MySQL, in this example), and copy it to the `<API-M_ANALYTICS_HOME>/repository/components/lib` directory.

    !!! info
        If the JDBC driver is not an OSGI bundle, then it should be converted to OSGI (using jartobundle.sh) before placing it in the
        `<API-M_ANALYTICS_HOME>/lib` directory. For detailed instructions, see [Adding Third Party Non OSGi Libraries]({{base_path}}/learn/analytics/adding-third-party-non-osgi-libraries/).

        e.g., `sh API-M_ANALYTICS_HOME/bin/jartobundle.sh ojdbc6.jar API-M_ANALYTICS_HOME/lib/`

7.  Configure the datasource for the `GEO_LOCATION_DATA` database.

    A default datasource for geo location based statistics is defined in the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file under data sources.
    You can edit that datasource to point it to your newly created `GEO_LOCATION_DATA` database.

    !!! info
        The database should be tuned to handle the total **maxPoolSize** (The maximum number of threads that should be reserved at any given time to handle events) that is defined in the configuration.

    ``` java
    - name: GEO_LOCATION_DATA
      description: "The data source used for geo location database"
      jndiConfig:
        name: jdbc/GEO_LOCATION_DATA
      definition:
        type: RDBMS
        configuration:
          jdbcUrl: 'jdbc:mysql://localhost:3306/GEO_LOCATION_DATA'
          username: 'root'
          password: '123'
          driverClassName: com.mysql.jdbc.Driver
          maxPoolSize: 50
          idleTimeout: 60000
          validationTimeout: 30000
          isAutoCommit: false
    ```
