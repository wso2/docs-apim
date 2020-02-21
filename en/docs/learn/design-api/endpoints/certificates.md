# Managing Endpoint Certificates

If your API backend is secured with a self-signed certificate (or a certificate which is not signed by a CA) you need to import the backend certificate to the API manager (Gateway) client-truststore and restart the server. This feature enables you to upload the backend certificate through API Publisher while creating or editing your API **without restarting the server**. 
   
Follow the steps below to add a certificate to an endpoint: 
    
   <html>
        <div class="admonition note">
            <p class="admonition-title">Note</p>
            <p>Note that this feature supports only <b>HTTP/REST</b> and <b>HTTP/SOAP</b> endpoints.
            </p>
        </div> 
   </html>

## Configuration (Optional)

1.  Modify the configurations for the Endpoint Certificates by modifying the 
 `<API-M_HOME>/repository/conf/deployment.toml` file by adding the following config section as shown below. 

    ``` toml
        [transport.passthru_https.sender.ssl_profile]
        interval = 600000
    ```
    
    | Configuration Parameter        | Description|
    |-------------|---------------------------------------------------|
    | interval    | The time taken to load the newly added certificate in **milliseconds**. Default 10 mins. (600000ms) Minimum interval : 60000ms (1 min)|

2. If you use a different Trust Store/Keystore configuration and define it in the `[transport.passthru_https.sender]` section within the `deployment.toml` file, make sure to modify the KeyStore and TrustStore location in the `<API-M_HOME>/repository/resources/security/sslprofiles.xml` file as well accordingly.  The `sslprofiles.xml` file is configured with the default `client-truststore.jks`.
     <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>
            This feature currently supports only the following keystore and certificate types.
     </p>
     <ul>
      <li>Keystore : <code>.jks</code></li>
      <li>Certificate : <code>.crt</code></li>
     </ul>
      <p>
      If you need to use a certificate in any other format, you can convert it to `.crt/ .cert` using a standard
              tool before uploading.
     </p>
     </div> 
     <html>

  
    !!! Info

         The certificate will be added to the Gateway nodes which are defined under the `[[apim.gateway.environment]]` section in the `deployment.toml` file. 
         
         In a clustered setup, as the Gateway configurations are identical, sync the `<API-M_HOME>/repository/resources/security/sslprofiles.xml` file and the `<API-M_HOME>/repository/resources/security/client-truststore.jks` file among the Gateway nodes in the cluster. After the configured interval, the Synapse transport will be reloaded in all the Gateway nodes.


## Adding a Certificate for an Endpoint

1.  Sign in to the API Publisher. 

2. [Create a new API]({{base_path}}/Learn/DesignAPI/CreateAPI/create-a-rest-api/) or click on an existing API.

3.  Click **Endpoints** and click **General Endpoint Configuration** to expand that section. 
    [![Open General Endpoint Configuration]({{base_path}}/assets/img/Learn/open-general-endpoint-configuration.png)]({{base_path}}/assets/img/Learn/open-general-endpoint-configuration.png)
4.  Click **\+ Add Certificate** in the Certificates section.
   [![Click on Add Certificate]({{base_path}}/assets/img/Learn/click-add-certificate.png)]({{base_path}}/assets/img/Learn/click-add-certificate.png)
   
    The Upload Certificate dialog box appears.
    [![Upload Certificate Dialog]({{base_path}}/assets/img/Learn/upload-certificate-open.png)]({{base_path}}/assets/img/Learn/upload-certificate-open.png)

    *  Enter the following information and click **Save**.
    
        | Name        | Description                                                                              |
        |-------------|------------------------------------------------------------------------------------------|
        | Alias       | Enter a name for your certificate.                                                       |
        | Endpoint    | Select an endpoint from the dropdown list.                                                |
        | Certificate | Drag and drop the certificate file or click on the drop zone to select the certificate via the UI |

        [![]({{base_path}}/assets/img/Learn/certificate-inputs-provided.png)]({{base_path}}/assets/img/Learn/certificate-inputs-provided.png)

         The uploaded certificate will be displayed.

         [![]({{base_path}}/assets/img/Learn/certificate-added.png)]({{base_path}}/assets/img/Learn/certificate-added.png)

5.  If required, repeat step 3 onwards to add certificates to the other endpoints.

## Check Certificate Information

You can check the information of the certificate, (i.e., Status and subject DN).

Click on the info icon that corresponds to the respective certificate to view the certificate information.

[![Certificate info click]({{base_path}}/assets/img/Learn/certificate-info-click.jpg)]({{base_path}}/assets/img/Learn/certificate-info-click.jpg)

The selected certificate details appear.

[![Certificate details]({{base_path}}/assets/img/Learn/certificate-details.png)]({{base_path}}/assets/img/Learn/certificate-details.png)

## Deleting a certificate

Click on the delete icon that corresponds to the respective certificate to delete a certificate.

[![]({{base_path}}/assets/img/Learn/certificate-delete-btn-select.jpg)]({{base_path}}/assets/img/Learn/certificate-delete-btn-select.jpg)

