# Dynamic User Authentication

Dynamic user authentication allows you to authenticate database users
dynamically for each data service call. This is implemented using a
mapping between the server users and the database users. This mapping
can be either,

-   Static inside the data service configuration.
-   Provided at runtime through a Java class that implements the
    `org.wso2.micro.integrator.dataservices.core.auth.DynamicUserAuthenticator.` interface.

## Static configuration

You can specify a code as shown in the following example in the
datasource configuration section of the data service.

```xml
<data name="RDBMSSample" serviceGroup="RDBMS">                           
   <config id="default">                                                      
      <property name="driverClassName">org.h2.Driver</property>                                      
      <property name="url">jdbc:h2:file:./samples/database/DATA_SERV_SAMP</property>
      <property name="username">wso2ds</property>
      <property name="password">wso2ds</property>
      <property name="dynamicUserAuthMapping">
         <configuration>
            <entry request="admin">
               <username>wso2ds</username>
               <password>wso2ds</password>
            </entry>
            <entry request="user1">
               <username>dbuser1</username>
               <password>dbpass1</password>
            </entry>
            <entry request="*">                                                                                  
               <username>guest</username>                                                                     
               <password>guest</password>                                                               
            </entry>                                                                        
         </configuration>                                                
      </property>                            
   </config>  
....
```

The configuration above maps the two Carbon users to specific database
credentials and the rest of the users to a different username/password
pair. The `         dynamicUserAuthMapping        ` property in
`         /configuration/entry/@request        ` represents the incoming
Carbon user, and the username and password elements that follow
represent the mapped database credentials.

For dynamic user authentication to work, security must be enabled in the
data service through `         UsernameToken        ` for user
authentication. If user authentication is not available when a
`         dynamicUserAuthMapping        ` section is specified, it maps
to the request="\*" scenario by default.

## Runtime configuration

In the runtime mode, the property
`         dynamicUserAuthClass        ` must be specified instead of the
datasource configuration property
`         dynamicUserAuthMapping        ` . The
`         dynamicUserAuthClass        ` property's value must have the
fully-qualified class name of a Java class that implements the interface
`         org.wso2.micro.integrator.dataservices.core.auth.DynamicUserAuthenticator.        `
The interface is as follows:

```java
public interface DynamicUserAuthenticator {
     /**
     * This method is used to lookup a username/password pair given a source username.
     * @param user The source username
     * @return A two element String array containing the username and password respectively
     * @throws DataServiceFault
     */
     String[] lookupCredentials(String user) throws DataServiceFault;

}
```

The following example code snippet shows an implementation of a dynamic
user authenticator class.

```java
package samples;
import org.wso2.carbon.dataservices.core.DataServiceFault;
import org.wso2.carbon.dataservices.core.auth.DynamicUserAuthenticator;

public class MyDynAuthClass implements DynamicUserAuthenticator {
     @Override
     public String[] lookupCredentials(String user) throws DataServiceFault {
             if ("admin".equals(user)) {
                 return new String[] {"wso2ds", "wso2ds"};
             } else if ("user1".equals(user)) {
                 return new String[] {"dbuser1", "dbpass1"};
             } else if ("user2".equals(user)) {
                 return new String[] {"dbuser2", "dbpass2"};
             } else {
                 throw new DataServiceFault("The user '" + user + "' not supported in invoking the target data service");
             }
      }
}
```

The `         lookupCredentials        ` method takes in the request
user and returns the database username/password in a String array. The
dbs file configuration format is as follows:

```xml
<data name="RDBMSSample" serviceGroup="RDBMS">                           
   <config id="default">
      <property name="driverClassName">org.h2.Driver</property>
      <property name="url">jdbc:h2:file:./samples/database/DATA_SERV_SAMP</property>
      <property name="username">wso2ds</property>
      <property name="password">wso2ds</property>                                             
      <property name="dynamicUserAuthClass">samples.MyDynAuthClass</property>
....
```

## Dynamic user lookup order of precedence

In a single datasource configuration, both the static and the runtime
configurations can be available at once. The server processes them as
follows:

-   Higher precedence goes to the static mapping in initially looking up
    the credentials. The "\*" request setting is ignored in the first
    pass.
-   If a request user/database credential mapping cannot be found, the
    secondary runtime Java class implementation is used to look up the
    user.
-   If the previous option also fails, the program returns for the
    primary static mapping and processes the "\*" request mapping.
-   The data service request returns an error only if all of the above
    options fail.

## Use of external datasources

When using datasources that are not inline, the
datasources must be specified in a way that its connections can be
created for selected users. Specifically in Carbon datasources, enable
the `         alternateUsernameAllowed        ` setting for dynamic user
authentication to function.