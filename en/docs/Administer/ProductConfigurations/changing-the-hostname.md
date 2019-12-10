# Changing the Hostname

By default, WSO2 products identify the hostname of the current machine through the Java API. However, this value sometimes yields erroneous results on some environments. Therefore, users are recommended to configure the hostname. The following procedure explains how to change the hostname and management hostname of WSO2 API Manager (WSO2 API-M) as required for your production environment.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file and set the `hostname` atrribute under server configurations as shown below.

    ``` format tab="Format"
    [server]
    hostname = "{hostname}"
    ```
    
    ``` example tab="Example"
    [server]
    hostname = "am.dev.wso2.com"
    ```
    
    `{hostname}` - Hostname or IP address of the machine hosting this server. This is will become part of the End Point Reference of the services deployed on this server instance.

2.  Generate a key store, export the public certificate from the keystore, and import that certificate to the `client­-truststore.jks` file.
    For more information, see [Creating New Keystores](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) in the WSO2 Administration guide.

