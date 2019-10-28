# Updating Geo Location Data Set

Follow the procedure below in order to update your existing Geo Location dataset to use in [Configuring Geolocation Based Statistics](../configuring-geolocation-based-statistics/).

1.  Download the latest CSV file from [here](http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip).
2.  Download the geoip-2-csv-converter from <https://github.com/maxmind/geoip2-csv-converter/releases> according to your operating system.

#### Prepare the database entries

1.  Unzip the latest CSV file and the geoip-2-csv-converter you have downloaded in the steps above.
2.  Run [update-geolocation-data.sh]({{base_path}}/assets/attachments/103335136/103335137.sh) file using the command below.

    ```shell
    sh update-geolocation-data.sh
    ```      

    -   Enter the path to the extracted GeoLite2-City-Blocks-IPv4 directory which you downloaded first, as the response for **Enter path to GeoLite2-City-Blocks-IPv4 directory:**

        E.g :   /&lt;PATH\_TO&gt;/GeoLite2-City-CSV_20171107

    -   Enter the path to geoip2-csv-converter directory as the response for **Enter path to geoip2-csv-converter home directory:**

        E.g :  /&lt;PATH\_TO&gt;/geoip2-csv-converter-v1.0.0

    -   After executing the script, you will find the `final.csv` file inside your current directory.

        ``` java
        ** get first column form original
        ** change column name to ‘network_cidr’
        ** Extract ip address data
        ** change column name to ‘network_blocks’
        ** extract entries from original cut: /home/chamalee/xxx/geoip2-csv-converter-v1.0.0/GeoLite2-City-Blocks-IPv4-converted.csv: No such file or directory
        ** change column name to ‘network’
        ** change column name to ‘broadcast’
        ** merge csv files
        ```

3.  Shut down both APIM and APIM-Analytics servers if you are running them already.
4.  Truncate BLOCKS and LOCATION tables from the GEO\_LOCATION\_DATA database.

!!! info
    Alternatively you can drop the tables in the GEO\_LOCATION\_DATA database and create new tables.


#### Importing Data

1.  Import the created `final.csv` file into BLOCKS table. Use the command given below.

    ``` java
    load data local infile '[PATH_TO_FINAL.CSV]/final.csv' into table BLOCKS
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    (network_cidr, network, broadcast, geoname_id, registered_country_geoname_id, represented_country_geoname_id, is_anonymous_proxy, is_satellite_provider, postal_code, latitude, longitude, network_blocks);
    ```

2.  Import the `GeoLite2-City-Locations-en.csv` file located inside the extracted geoip-2-csv-converter directory (e.g  geoip-2-csv-converterGeoLite2-City-CSV\_2017110) into LOCATION table. Use the command given below.

    ``` java
    load data local infile '[PATH_TO_GeoLite2-City-Locations-en]/GeoLite2-City-Locations-en.csv' into table LOCATION
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    (geoname_id, locale_code, continent_code, continent_name, country_iso_code, country_name, subdivision_1_iso_code, subdivision_1_name, subdivision_2_iso_code, subdivision_2_name, city_name, metro_code, time_zone);
    ```

3.  Restart WSO2 API Manager and WSO2 APIM-Analytics servers.

You have now updated the Geo Location Data Set.

