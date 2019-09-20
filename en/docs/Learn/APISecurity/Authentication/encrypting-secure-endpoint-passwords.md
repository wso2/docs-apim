# Encrypting Secure Endpoint Passwords

When creating an API using the API Publisher, you specify the endpoint of its backend implementation in the **Implement** tab. If you select the endpoint as secured, you are prompted to give credentials in plain-text.

![](/assets/attachments/103334881/103334882.png)
!!! tip
Cipher Tool

See [Encrypting Passwords with Cipher Tool](https://docs.wso2.com/display/ADMIN44x/Encrypting+Passwords+with+Cipher+Tool) to understand how cipher tool can be used encrypt plain text passwords


The steps below show how to secure the endpoint's password that is given in plain-text in the UI.

1.  Shut down the server if it is already running and set the element `<EnableSecureVault>` in the `<APIM_HOME>/repository/conf/api-manager.xml` file to true. By default, the system stores passwords in configuration files in plain text because this value is set to false.
2.  Run the cipher tool available in the `<APIM_HOME>/bin` directory. If you are running Windows, it is the `ciphertool.bat` file. If you are using the default keystore, give **wso2carbon** as the primary keystore password when prompted.

    ``` java
        sh ciphertool.sh -Dconfigure
    ```

3.  Restart the server (Publisher) after the above steps have been performend. From there onwards, the Basic Authentication header which is written to the API definition xml file will be encrypted. For APIs which were already created and published before this step was performed, an update to the particular API would trigger the encryption process of the credentials. For an example, see below for example of the same API when endpoint password is not encrypted and encrypted:

    -   [**Not Encrypted**](#d121c149c1af4202afc8a431b48e1e59)
    -   [**Encrypted**](#8d53c1dac3684a05bcc0d633e6e250b2)

    Here, the Basic authentication header is in bas464 encoded format and can be decoded to get the actual credentials of the endpoint.

    ``` java
            <property name="Authorization" expression="fn:concat('Basic ', 'dGVzdDp0ZXN0MTIz')" scope="transport"/>
    ```

    Here, the password is first looked up from the secret repository, and then set as a transport header.

    ``` java
            <property name="password" expression="wso2:vault-lookup('<api-identifier>')"/>
            <property name="unpw" expression="fn:concat('test',':',get-property('password'))"/>
            <property name="Authorization" expression="fn:concat('Basic ', base64Encode(get-property('unpw')))" scope="transport"/>
    ```


