# WSO2 Admin Services

WSO2 products are managed internally using SOAP Web services known as **admin services**, and they come with a management console UI, which communicates with these admin services to facilitate administration capabilities through the UI.

A service in WSO2 products is defined by the following components:

-   **Service component**: provides the actual service
-   **UI component**: provides the web user interface to the service
-   **Service stub**: provides the interface to invoke the service generated from the service WSDL

There can be instances where you want to call back-end web services directly. For example, during test automation, to minimize the overhead of changing automation scripts whenever a UI change happens, developers prefer to call the underlying services in scripts. The topics below explain how to discover and invoke these services from your applications.

## Discovering the admin services

By default, the WSDLs of admin services are hidden from consumers. Follow the instructions below to discover the WSDLs of the admin services using the [OSGi](https://www.osgi.org/developer/) console.

1. Add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file.

    ``` toml
    [admin_service.wsdl]
    enable = true

    ```

2. Navigate to the `<API-M_HOME>/bin/` directory and start WSO2 API Manager as follows:

    ``` shell tab="Linux"
    sh api-manager.sh -DosgiConsole
    ```

    ``` shell tab="Windows"
    api-manager.bat -DosgiConsole
    ```

3.  When the server starts, press the Enter/Return key several times to get the OSGi shell in the console.

4. View the list of admin services of your product.

     Type `listAdminServices` in the OSGi shell and press `Enter`.

    ``` shell
    osgi> listAdminServices
    ```
    
     The list of admin services related to WSO2 API Manager product will appear as shown below. 
     
     ![Discover Admin Services]({{base_path}}/assets/img/develop/discover-admin-services.png)
    
5.  If required, view the service contract of an admin service.

     Select the admin service's URL, copy and paste it in your browser with **?wsdl** at the end. An example is given below.

     ``` shell
     https://localhost:9443/services/RemoteUserStoreManagerService?wsdl
     ```

    !!! tip
        In WSO2 API Manager, the port used is 8243 (assuming that the port offset is 0). However, you should be accessing the Admin Services via the management console port, which is 9443 when there is no port offset.

     The admin service's URL appears as follows in the previous list that you discovered:

     ``` shell
     RemoteUserStoreManagerService, RemoteUserStoreManagerService, https://<host IP>:9443/services/RemoteUserStoreManagerService/  
     ```

!!! note
    After discovering the admin service, you can restart the server without `-DosgiConsole`

## Invoking an admin service

For the purpose of preventing anonymous invocations, admin services are secured using common types of security protocols such as HTTP basic authentication, WS-Security username token, and session-based authentication. For example, the `UserAdmin` web service is secured using HTTP basic authentication.

Follow the instructions below to invoke a service:

1.  [Authenticate yourself and get the session cookie](#authenticating-the-user).
2.  [Generate the client stubs to access the back-end Web services](#generating-the-client-stubs).

!!! tip
        To generate the stubs, you can write your own client program using the Axis2 client API or use an existing tool like [SoapUI](http://www.soapui.org/) (4.5.1 or later) or wsdl2java.

The wsdl2java tool, which is shipped with WSO2 products by default, hides all the complexity and presents you with a proxy to the back-end service. The stub generation happens during the project build process within the Maven POM files. It uses the Apache Maven AntRun plugin to execute the wsdl2java tool.

You can also use the Java client program given [here](https://svn.wso2.org/repos/wso2/people/asela/user-mgt/remote-user-api/4.2.X/) to invoke admin services. All dependency JAR files required to run the Java client are available in the `<API-M_HOME>/lib` directory.


### Authenticating the user

The sample code given below authenticates the user and gets the session cookie:

``` java
import org.apache.axis2.AxisFault;  
import org.apache.axis2.transport.http.HTTPConstants;  
import org.wso2.carbon.authenticator.stub.AuthenticationAdminStub;  
import org.wso2.carbon.authenticator.stub.LoginAuthenticationExceptionException;  
import org.wso2.carbon.authenticator.stub.LogoutAuthenticationExceptionException;  
import org.apache.axis2.context.ServiceContext;  
import java.rmi.RemoteException;  

public class LoginAdminServiceClient {  
    private final String serviceName = "AuthenticationAdmin";  
    private AuthenticationAdminStub authenticationAdminStub;  
    private String endPoint;  

    public LoginAdminServiceClient(String backEndUrl) throws AxisFault {  
        this.endPoint = backEndUrl + "/services/" + serviceName;  
        authenticationAdminStub = new AuthenticationAdminStub(endPoint);  
    }  

    public String authenticate(String userName, String password) throws RemoteException,  
                                    LoginAuthenticationExceptionException {  
        String sessionCookie = null;  

        if (authenticationAdminStub.login(userName, password, "localhost")) {  
            System.out.println("Login Successful");  

            ServiceContext serviceContext = authenticationAdminStub.  
                _getServiceClient().getLastOperationContext().getServiceContext();  
            sessionCookie = (String) serviceContext.getProperty(HTTPConstants.COOKIE_STRING);  
            System.out.println(sessionCookie);  
        }  
        return sessionCookie;  
    }  

    public void logOut() throws RemoteException, LogoutAuthenticationExceptionException {  
        authenticationAdminStub.logout();  
    }  
}
```

### Generating the client stubs

After authenticating the user provide the retrieved admin cookie with the service endpoint URL as shown in the sample below. 

The Remote user management service name is `RemoteUserStoreManagerService`. You can find its URL (e.g., `https://localhost:9443/services/RemoteUserStoreManagerService`) in the `service.xml` file, within the `META-INF` folder, in the respective bundle that is in the `<API-M_HOME>/repository/components/plugins` directory.

``` java
import org.apache.axis2.AxisFault;
import org.apache.axis2.client.Options;
import org.apache.axis2.client.ServiceClient;
import org.wso2.carbon.um.ws.api.stub.RemoteUserStoreManagerServiceStub;
import org.wso2.carbon.um.ws.api.stub.RemoteUserStoreManagerServiceUserStoreExceptionException;
import java.rmi.RemoteException;

public class RemoteUserStoreServiceAdminClient {

    private final String serviceName = "RemoteUserStoreManagerService";
    private RemoteUserStoreManagerServiceStub remoteUserStoreManagerServiceStub;
    private String endPoint;

    public RemoteUserStoreServiceAdminClient(String backEndUrl, String sessionCookie) throws AxisFault {
        this.endPoint = backEndUrl + "/services/" + serviceName;
        remoteUserStoreManagerServiceStub = new RemoteUserStoreManagerServiceStub(endPoint);
        //Authenticate Your stub from sessionCooke
        ServiceClient serviceClient;
        Options option;

        serviceClient = remoteUserStoreManagerServiceStub._getServiceClient();
        option = serviceClient.getOptions();
        option.setManageSession(true);
        option.setProperty(org.apache.axis2.transport.http.HTTPConstants.COOKIE_STRING, sessionCookie);
    }

    public String[] listUsers()
            throws RemoteException, RemoteUserStoreManagerServiceUserStoreExceptionException {
        return remoteUserStoreManagerServiceStub.listUsers("*", 100);
    }
}
```

The following sample code lists the users in the API-M server:

``` java
import org.apache.axis2.AxisFault;
import org.wso2.carbon.authenticator.stub.LoginAuthenticationExceptionException;
import org.wso2.carbon.authenticator.stub.LogoutAuthenticationExceptionException;
import org.wso2.carbon.um.ws.api.stub.RemoteUserStoreManagerServiceUserStoreExceptionException;
import java.rmi.RemoteException;

public class AdminServiceClientManager {
    public static void main (String[] args) {

        System.setProperty("javax.net.ssl.trustStore",
                "<API-M_HOME>/repository/resources/security/client-truststore.jks");
        System.setProperty("javax.net.ssl.trustStorePassword", "wso2carbon");

        try {
            LoginAdminServiceClient loginAdminServiceClient =
                    new LoginAdminServiceClient("https://localhost:9443");
            String sessionId = loginAdminServiceClient.authenticate("admin", "admin");
            RemoteUserStoreServiceAdminClient remoteUserStoreServiceAdminClient = new
                    RemoteUserStoreServiceAdminClient("https://localhost:9443", sessionId);
            String[] users = remoteUserStoreServiceAdminClient.listUsers();

            if(users != null){
                System.out.println("Listing user names of Carbon server...... ");
                for(String user : users){
                    System.out.println("User Name : " + user);
                }
            }

            loginAdminServiceClient.logOut();

        } catch (AxisFault axisFault) {
            axisFault.printStackTrace();
            throw new RuntimeException(axisFault);
        } catch (RemoteException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } catch (LoginAuthenticationExceptionException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } catch (RemoteUserStoreManagerServiceUserStoreExceptionException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } catch (LogoutAuthenticationExceptionException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

    }
}
```

The complete Maven project can be found at: [org.wso2.carbon.sample.admin.service.invoker.zip]({{base_path}}/assets/attachments/develop/org.wso2.carbon.sample.admin.service.invoker.zip)
