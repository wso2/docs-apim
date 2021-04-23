# Scenario 14 - External Key Manager Support

## User Story

**RailCo has users in their internal identity management system. They do not want to have duplicate user information in two systems. RailCo wants to use this IDP to generate access tokens to consume their APIs without having to import their users to the GOGO train API platform.**

**_Time to Complete : 5 mins_**

WSO2 API Manager comes with out-of-the-box external key manager connectors to various Identity providers such as Okta, Auth0, Keycloak, etc. Additionally it has provided interfaces to write custom keymanager implementation to plug any external third party keymanager solution. 

For this scenario, we assume Railco has Keycloak IDP as their internal identity provider. Following are the steps to configure Keycloak idp as the external keymanager for RailCo.

![KM description]({{base_path}}/assets/img/tutorials/scenarios/km-desc.png)

Detailed steps on how to configure Keycloak can be found in [WSO2 Documentation](https://apim.docs.wso2.com/en/latest/administer/key-managers/configure-keycloak-connector/) . Additionally, you could refer to the screen cast done on this in [here](https://www.youtube.com/watch?v=xuZ6DPhXNX8). Following are the simplified steps for this setup.

1. Download Keycloak Server from [https://www.keycloak.org/downloads](https://www.keycloak.org/downloads). At the time of writing this tutorial, keycloak 12.0.4 was used for this.
2. Extract it to your local setup and navigate to `<keycloak>/bin` and run `./standalone.sh` to start the server.
3. Go To [http://localhost:8080/](http://localhost:8080/) . If this is the first time, create an initial admin user from the form given in this page.
4. Run the following command. Replace admin username and password. This will run a script on keycloak to generate application on keycloak.

```
docker run -e USER=<admin_username> -e PASSWORD=<admin_password> chamilaadhi/keycloak-apim-script:1.0.0
```

If execution is successful, you will be given a client Id and client secret to use with WSO2 API Manager

```

=====================================================

client id    :  apim-client
client secret:  221f10b7-d169-45e0-851e-e1b017052162

=====================================================

```

!!!Note
    Script used in this docker container to create the credentials can be found in `/resource/setup-keycloak.sh` file


Now let's configure the connection between API-M and Keycloak.

1. Login to admin portal [https://localhost:9443/admin/](https://localhost:9443/admin/) using railco admin user. Use admin@railco.com and _admin_ as the password.
2. Go to **Key Managers** and select **Add Keymanagers**
3. Provide a suitable name and display name.
4. Select **Key Manager Type** as **Keycloak** from the dropdown menu.
5. Use `http://host.docker.internal:8080/auth/realms/master/.well-known/openid-configuration` as the **Well-known URL** field and click **Import**. This will populate the other required fields.
6. Set `http://host.docker.internal:8080/auth/realms/master/protocol/openid-connect/revoke` as **Revoke Endpoint** if this field is empty.
7. Under the **Connector Configurations** section, provide the **client id** and **secret** we got from executing the script.

    ![Connector configuration]({{base_path}}/assets/img/tutorials/scenarios/connector-config.png)

Now Keymanager is configured. Let’s invoke an API using a token generated from Keycloak.

1. Login to Railco tenant domain’s Dev Portal [https://localhost:9443/devportal/]https://localhost:9443/devportal/() using tom@railco.com and password _user123_.
2. Go to the **Applications** page and select **KeyCloakAPP**. This application is already subscribed to the **RailCoTrainAPI**. 
3. Select **Production Keys → Oauth2 Tokens** . You will see a tab for **Keycloak**
    
    ![Keycloak application]({{base_path}}/assets/img/tutorials/scenarios/keycloak-app.png)

4. Click **Generate Keys** to generate a token. (Default values would be enough to generate an access token for this scenario)
5. Invoke API using this token. 



