# Changing the Hostname

By default, WSO2 products identify the hostname of the current machine through the Java API. However, this value sometimes yields erroneous results on some environments. Therefore, users are recommended to configure the hostname. The following procedure explains how to change the hostname and management hostname of WSO2 API Manager (WSO2 API-M) as required for your production environment.

1.  Open the `           <API-M_HOME>/repository/conf/carbon.xml          ` file and set the `           HostName          ` and `           MgtHostName          ` property as shown below.

    -   [**Format**](#Format-hostname)
    -   [**Example**](#example-hostname)

    ``` xml
        <HostName>{hostname}</HostName>
        <MgtHostName>{management-hostname}</MgtHostName>
    ```

    `              {hostname}             ` - Hostname or IP address of the machine hosting this server. This is will become part of the End Point Reference of the services deployed on this server instance.

    `              {management-hostname}             ` - Hostname to be used for the WSO2 API-M Management console.

    ``` xml
            <HostName>am.dev.wso2.com</HostName>
            <MgtHostName>am.dev.wso2.com</MgtHostName>
    ```

2.  Generate a key store, export the public certificate from the keystore, and import that certificate to the `           client­-truststore.jks          ` file.
    For more information, see [Creating New Keystores](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) in the WSO2 Administration guide.

## Whats Next?

!!! info
After changing your hostname and management hostname, make sure to [whitelist your hostname for the API Store](https://docs.wso2.com/display/AM220/Whitelisting+Hostnames+for+API+Store) .

