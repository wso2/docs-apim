# WSO2 Admin Services

WSO2 products are managed internally using SOAP Web services known as **admin services** . WSO2 products come with a management console UI, which communicates with these admin services to facilitate administration capabilities through the UI.

A service in WSO2 products is defined by the following components:

-   Service component: provides the actual service
-   UI component: provides the Web user interface to the service
-   Service stub: provides the interface to invoke the service generated from the service WSDL

There can be instances where you want to call back-end Web services directly. For example, in test automation, to minimize the overhead of having to change automation scripts whenever a UI change happens, developers prefer to call the underlying services in scripts. The topics below explain how to discover and invoke these services from your applications.

### Discovering the admin services

By default, the WSDLs of admin services are hidden from consumers. Given below is how to discover them using the [OSGi](https://www.osgi.org/developer/) console.

1.  Set the `<HideAdminServiceWSDLs>` element to false in the `<PRODUCT_HOME>/repository/conf/carbon.xml` file.
2.  Go to `<PRODUCT_HOME>/bin/` folder and start the WSO2 product as follows,

    **In Linux Environment**

    ``` java
        sh wso2server.sh -DosgiConsole
    ```

    **In Windows Environment**

    ``` java
            wso2server.bat -DosgiConsole
    ```

3.  When the server is started, hit the enter/return key several times to get the OSGI shell in the console.
4.  In the OSGI shell, type: `osgi> listAdminServices`
5.  The list of admin services of your product are listed. For example:
    ![](/assets/attachments/103335243/103335245.png)6.  To see the service contract of an admin service, select the admin service's URL and then paste it in your browser with **?wsdl** at the end. For example:
`https://localhost:9443/services/RemoteUserStoreManagerService?wsdl`

        !!! tip
    In products like WSO2 ESB and WSO2 API Manager, the port is 8243 (assuming 0 port offset). However, you should be accessing the Admin Services via the management console port, which is 9443 when there is no port offset.


7.  Note that the admin service's URL appears as follows in the list you discovered in step 6:

    ``` java
        RemoteUserStoreManagerService, RemoteUserStoreManagerService, https://<host IP>:9443/services/RemoteUserStoreManagerService/  
    ```

        !!! note
    After discovering admin service you can restart the server without `-DosgiConsole`


### Invoking an admin service

Admin services are secured using common types of security protocols such as HTTP basic authentication, WS-Security username token, and session based authentication to prevent anonymous invocations. For example, the `UserAdmin` Web service is secured with the HTTP basic authentication. To invoke a service, you do the following:

1.  Authenticate yourself and get the session cookie.
2.  Generate the client stubs to access the back-end Web services.

!!! tip
To generate the stubs, you can write your own client program using the Axis2 client API or use an existing tool like [SoapUI](http://www.soapui.org/) (4.5.1 or later) or wsdl2java.

The wsdl2java tool, which comes with WSO2 products by default hides all the complexity and presents you with a proxy to the back-end service. The stub generation happens during the project build process within the Maven POM files. It uses the Maven ant run plug-in to execute the wsdl2java tool.

You can also use the Java client program given [here](https://svn.wso2.org/repos/wso2/people/asela/user-mgt/remote-user-api/4.2.X/) to invoke admin services. All dependency JAR files that you need to run this client are found in the `/lib` directory.


#### Authenticate the user

The example code below authenticates the user and gets the session cookie:

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

#### 
Generate the client stubs

After authenticating the user, give the retrieved admin cookie with the service endpoint URL as shown in the sample below. The Remote user management service name is RemoteUserStoreManagerService. You can find its URL (e.g., `https://localhost:9443/services/RemoteUserStoreManagerService` ) in the `service.xml` file in the `META-INF` folder in the respective bundle that you find in `<PRODUCT_HOME>/repository/components/plugins` .

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
The following sample code lists the users in the APIM server:

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
The complete maven project can be found at: [org.wso2.carbon.sample.admin.service.invoker.zip](/assets/attachments/103335243/103335244.zip)
