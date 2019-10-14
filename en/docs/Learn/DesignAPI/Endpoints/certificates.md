# Certificates

If you have a backend with a self-signed certificate (or a certificate which is not signed by a CA) you need to import it to the client-truststore and restart the server. This feature enables you to upload the backend certificate through API Publisher while creating or editing your API. Follow the steps below to add a new certificate to any endpoint. Note that this feature supports only **HTTP/REST** and **HTTP/SOAP** endpoints.

### Prerequisites

1.  Ensure that you have downloaded the latest WUM update. For more details, see [Updating WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Updating+WSO2+Products) in the WSO2 Administration Guide.
2.  If you are an existing user, follow the instructions given below.
    1.  Run the scripts inside the `<API-M_HOME>/dbscripts/apimgt` directory, according to your preferred database. For instructions on configuring databases, see [Set up the database](https://docs.wso2.com/display/AM260/Changing+the+Default+API-M+Databases#ChangingtheDefaultAPI-MDatabases-Step1-Setupthedatabase) . Verify that the table `AM_CERTIFICATE_METADATA` has been created in your database.

    2.  The configurations for the `PassThroughHTTPSSLSender` parameter is available by default in the `<API-M_HOME>/repository/conf/axis2/axis2.xml` file as shown below.

        ``` java
                <transportSender name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpSSLSender">
                    ...
                      <!-- ============================================== -->
                      <!-- Configuration for Dynamic SSL Profile loading. -->
                      <!-- Configured for 10 mins. -->
                      <!-- ============================================== -->
                      <parameter name="dynamicSSLProfilesConfig">
                              <filePath>repository/resources/security/sslprofiles.xml</filePath>
                              <fileReadInterval>600000</fileReadInterval>
                      </parameter>
                </transportSender>
        ```

                !!! note
        The default time to apply the certificate is 10 minutes. You can configure this by changing the `<fileReadInterval>` parameter. Note that the time is given in milliseconds.


    3.  If you use a different Trust Store/ Keystore configuration in the `axis2.xml` or `carbon.xml` files ,modify the KeyStore and TrustStore location in `<API-M_HOME>/repository/resources/security/sslprofiles.xml` file accordingly. The `sslprofiles.xml` file is configured with the existing client-truststore.jks

!!! note
This feature currently supports only the following formats for keystores and certificates.

-   Keystore : `.jks          `
-   Certificate : `.crt          `

If you need to use a certificate in any other format, you can convert it using a standard tool before uploading.


!!! info
After configuring, the certificate will be added to the Gateway nodes which are defined under the Environments in `api-manager.xml` . In a clustered setup, as gateway configurations are identical, sync the `<API-M_HOME>/repository/resources/security/sslprofiles.xml` and `<API-M_HOME>/repository/resources/security/client-truststore.jks` among the gateway nodes. After the configured interval, the synapse transport will be reloaded in all the gateway nodes.


### 
Adding a certificate

1.  Log in to the API Publisher. [Create a new API](https://docs.wso2.com/display/AM300/Create+and+Publish+an+API) or edit an existing API.
2.  Go to the **Implement** tab. Click **Manage Certificates** and click **Add New Certificate**
    ![]({{base_path}}/assets/attachments/126560467/126560484.png)3.  Enter the following information and click **Upload** .
    ![]({{base_path}}/assets/attachments/126560467/126560485.png)
    | Name        | Description                                                                              |
    |-------------|------------------------------------------------------------------------------------------|
    | Alias       | Enter a name for your certificate.                                                       |
    | Endpoint    | Select an endpoint from the dropdown list                                                |
    | Certificate | Enter the location of your certificate file or click **Browse** to select through the UI |

4.  The uploaded certificate aliases will be displayed.
    ![]({{base_path}}/assets/attachments/126560467/126560486.png){height="250"}
5.  You can repeat from step 2 to add a certificate to the sandbox endpoint.
    ![]({{base_path}}/assets/attachments/126560467/126560487.png)
!!! note
You add only one certificate per endpoint. Make sure that your certificates have not expired.


### Deleting a certificate

To delete a certificate, click the icon adjacent to the certificate, as shown below.

![]({{base_path}}/assets/attachments/126560467/126560488.png)


