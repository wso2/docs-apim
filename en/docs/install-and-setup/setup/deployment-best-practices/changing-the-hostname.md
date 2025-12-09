# Changing the Hostname

By default, WSO2 products identify the hostname of the current machine through the Java API. However, it is recommended to configure the hostname by setting the hostname parameter in the `deployment.toml` file.

## Changing the API-M hostname

Follow the steps given below.

1. Update the `deployment.toml` file.

    1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file 
    
    2. Define the `hostname` attribute under server configurations as shown below.

        === "Format"
            ``` format
            [server]
            hostname = "{hostname}"
            ```
    
        === "Example"
            ``` example
            [server]
            hostname = "am.dev.wso2.com"
            ```
    
        Replace `{hostname}` with the  Hostname or IP address of the machine hosting this server. This becomes part of the **endpoint** reference of the services deployed on this server instance.
    
    3. Configure the Developer Portal URL, which is used to access the Developer Portal via the Publisher. 

        Uncomment the following configuration and define the `hostname`.

        ```toml
        [apim.devportal]
        url = "https://<hostname>:${mgt.transport.https.port}/devportal"
        ```

2.  Generate a key store, export the public certificate from the keystore, and import that certificate to the `client­-truststore.jks` file.
    
     For more information, see [Creating New Keystores]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/).

3.  Restart the server.

4.  Map the hostname alias to its IP address in the `/etc/hosts` file of your system as shown below.

    !!! Info
        You need this when the host is internal or not resolved by a DNS,

    ```java
    127.0.0.1       localhost
    <ip_address>    <hostname>
    ```
    
!!! Note
    For internal calls, APIM assumes the hostname to be localhost. If you need to change this, follow the steps below to configure the hostname:

    1. Modify the app.origin.host with the required custom hostname in settings.json files in portals.

        **Publisher path**: repository/deployment/server/webapps/publisher/site/public/conf/settings.json.</br>
        **Admin portal path**: repository/deployment/server/webapps/admin/site/public/conf/settings.json.</br>
        **Devportal path**: repository/deployment/server/webapps/devportal/site/public/theme/settings.json.
        
       ```json
       app: {
       ...,
        origin: {
           host: 'example.com',
        },
       ...
       ```
    2. Add following property with the required custom hostname in the deployment.toml file.
        ```toml
        [server]
        internal_hostname = "example.com"
        ```

!!! Warning

    After you change the hostname, if you encounter login failures when trying to access the API Publisher and API Developer Portal with the error `Registered callback does not match with the provided url`, see ['Registered callback does not match with the provided url' error]({{base_path}}/reference/troubleshooting/troubleshooting-invalid-callback-error) in the Troubleshooting guide.

!!! Note

    When changing the hostname in `deployment.toml` prior to the initial startup of the server, the URLs and endpoints will be read from the file system and subsequently persisted in the database. This is applicable to most configurations in the Resident Identity Provider (IDP). Therefore, any changes made before the initial server startup can be performed via the `deployment.toml` file.
    
    However, if changes are required after the initial server startup, the Resident IDP configuration must be updated via the Management Console(`https://<host>:<port>/carbon`) UI.
