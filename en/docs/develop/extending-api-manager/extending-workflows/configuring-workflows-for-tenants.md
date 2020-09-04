# Configuring Workflows for Tenants

Using the API Manager, you can configure custom workflows that get invoked at the event of a user signup, application creation, registration, subscription etc. You do these configurations in the `workflow-extensions.xml` as described in the previous sections.

However, in a multi-tenant API Manager setup, not all tenants have access to the file system and not all tenants want to use the same workflow that the super admin has configured in the `api-manager.xml` file. For example, different departments in an enterprise can act as different tenants using the same API Manager instance and they can have different workflows. Also, an enterprise can combine WSO2 API Manager and WSO2 EI (Enterprise Integrator) to provide API Management As a Service to the clients. In this case, each client is a separate enterprise represented by a separate tenant. In both cases, the authority to approve business operations (workflows) resides within a tenant's space.

To allow different tenants to define their own custom workflows without editing configuration files, the API Manager provides configuration in tenant-specific locations in the registry, which you can access through the UI.

The topics below explain how to deploy a BPEL/human task using WSO2 EI and how to point them to services deployed in the tenant spaces in the API Manager.

### **Deploying a BPEL and a HumanTask for a tenant**

In this guide, the API Manager and EI use the same user store and all the users present are visible to both EI and API Manager. This is depicted by the diagram below:
![]({{base_path}}/assets/attachments/103334719/103334720.png)**Figure** : API Manager and EI share the same user and permission store

!!! warning
    **If you are using WSO2 BPS3.2.0** , please copy the `<APIM_HOME>                  /repository/components/patches/patch0009` folder to the `<BPS_HOME>                  /repository/components/patches` folder and restart the BPS server for the patch to be applied. This patch has a fix to a bug that causes the workflow configurations to fail in multi-tenant environments.

    This patch is built into the BPS version 3.5.0 onwards.


Follow the steps below to deploy a BPEL and a human task for a tenant in the API Manager:

-   [Sharing the user/permission stores with the EI and API Manager](#ConfiguringWorkflowsforTenants-Sharingtheuser/permissionstoreswiththeEIandAPIManager)
-   [Sharing the data in the registry with the EI and API Manager](#ConfiguringWorkflowsforTenants-SharingthedataintheregistrywiththeEIandAPIManager)
-   [Creating a BPEL](#ConfiguringWorkflowsforTenants-CreatingaBPEL)
-   [Creating a Tenant for Authentication](#ConfiguringWorkflowsforTenants-CreatingaTenantforAuthentication)
-   [Creating a human task](#ConfiguringWorkflowsforTenants-Creatingahumantask)
-   [Testing the workflow](#ConfiguringWorkflowsforTenants-Testingtheworkflow)

#### Sharing the user/permission stores with the EI and API Manager

1. Identify the permission store used by API Manager by refering to the `<Configuration>` tag in `<APIM_HOME>/repository/conf/user-mgt.xml`. Below is an example of this configuration.

    ``` xml
            <Configuration>
                <AddAdmin>true</AddAdmin>
                <AdminRole>admin</AdminRole>
                    <AdminUser>
                        <UserName>admin</UserName>
                        <Password>admin</Password>
                    </AdminUser>
                <EveryOneRoleName>everyone</EveryOneRoleName> <!-- By default users in this role sees the registry root -->
                <Property name="dataSource">jdbc/SHARED_DB</Property>
            </Configuration>
    ```
Do the same configuration in `<EI_HOME>/wso2/business-process/conf/user-mgt.xml` so that both API Manager and EI are pointing to the same datasource.

2. Identify the user store used by by API Manager by refering to the `<UserStoreManager>` tag in `<APIM_HOME>/repository/conf/user-mgt.xml`. By default both API Manager and EI use a JDBC based Userstore manager, so no changes are required. But if API Manager uses a different user store such as LDAP or Active Directory, the same `<UserStoreManager>` configuration needs to be done in `<EI_HOME>/wso2/business-process/conf/user-mgt.xml`.

3. Do the same permission store JDBC configuration(mentioned in step 1) found in `<APIM_HOME>/repository/conf/datasources/master-datasources.xml`, in `<EI_HOME>/wso2/business-process/conf/datasources/master-datasources.xml`. Below is an example of this configuration.

	``` xml
            <datasource>
                <name>WSO2_SHARED_DB</name>
                <description>Shared Database for user and registry data</description>
                <jndiConfig>
                    <name>jdbc/SHARED_DB</name>
                </jndiConfig>
                <definition type="RDBMS">
                    <configuration>
                        <url>jdbc:mysql://localhost:3306/WSO2SHARED_DB</url>
                        <username>root</username>
                        <password>root</password>
                        <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                        <validationQuery>SELECT 1</validationQuery>
                        <testOnBorrow>true</testOnBorrow>
                        <maxWait>60000</maxWait>
                        <defaultAutoCommit>true</defaultAutoCommit>
                        <validationInterval>30000</validationInterval>
                        <maxActive>50</maxActive>
                    </configuration>
                </definition>
            </datasource>

    ```

    !!! tip
        Make sure you copy the database driver (in this case, mysql driver) to the /repository/components/lib folder before starting each server.

    !!! info
        In the case the default JDBC Userstore is being used, the above mentioned datasource will act as both the permission and user store.



#### Sharing the data in the registry with the EI and API Manager

To deploy BPELs in an API Manager tenant space, the tenant space should be accessible by both the EI and API Manager, and certain tenant-specific data such as key stores needs to be shared with both products. Follow the steps below to create a registry mount to share the data stored in the registry:

1.  The registry data of API Manager is stored in the above mentioned `jdbc/SHARED_DB` which has already been added to the EI master-datasources.xml in the previous steps. Add the following entries to `<EI_HOME>/wso2/business-process/conf/registry.xml` to share the same registry with EI:

    ``` xml
             <dbConfig name="sharedregistry">
                    <dataSource>jdbc/SHARED_DB</dataSource>
             </dbConfig>
             
             <remoteInstance url="https://localhost:9443/registry">
                    <id>mount</id>
                    <dbConfig>sharedregistry</dbConfig>
                    <readOnly>false</readOnly>
                    <enableCache>true</enableCache>
                    <registryRoot>/</registryRoot>
                </remoteInstance>
                <!-- This defines the mount configuration to be used with the remote instance and the target path for the mount -->
                <mount path="/_system/config" overwrite="true">
                    <instanceId>mount</instanceId>
                    <targetPath>/_system/nodes</targetPath>
                </mount>
              <mount path="/_system/governance" overwrite="true">
                    <instanceId>mount</instanceId>
                    <targetPath>/_system/governance</targetPath>
                </mount>
    ```


#### Creating a BPEL

In this section, you create a BPEL that has service endpoints pointing to services hosted in the tenant's space. This example uses the [Application Creation]({{base_path}}/learn/consume-api/manage-application/advanced-topics/adding-an-application-creation-workflow/) workflow.


2.  Log in to the API Manager's management console ( `https://localhost:9443/carbon` ) and create a tenant using the **Configure -&gt; Multitenancy** menu.
    ![]({{base_path}}/assets/attachments/103334719/103334732.png)

3.  Create a copy of the BPEL located in `<APIM_HOME>/business-processes/application-creation/BPEL` .

4.  Extract the contents of the new BPEL archive.

5.  Copy `ApplicationService.epr` and `ApplicationCallbackService.epr` from `<APIM_HOME>/business-processes/epr` folder to the folder extracted before. Then, rename the two files as `ApplicationService-Tenant.epr` and `ApplicationCallbackService-Tenant.epr` respectively.

6.  Open `ApplicationService-Tenant.epr` and change the `wsa:Address` to `http://localhost:9765/services/t/           domain>/ApplicationService` and add the tenant admin credentials.

    !!! info
        In a distributed setup, the ApplicationService-Tenant.epr's wsa:Address should point to the proxy/load balancer of Enterprise Integrator(EI cluster) `(                       http:///services/t/           domain>/ApplicationService` ). Also, the ApplicationCallbackService-Tenant.epr's wsa:Address should point to APIM cluster's Workflow Callback service endpoint. This is normally deployed at the gateway nodes. The wsa:Address should point to the gateway nodes. ( https:///services/WorkflowCallbackService ) and the user credentials which grant access to that service should be used.


7.  Point the `deploy.xml` file of the extracted folder to the new .epr files provided in the BPEL archive. For example,

    ``` xml
    <invoke partnerLink="AAPL">
        <service name="applications:ApplicationService" port="ApplicationPort">
            <endpoint xmlns="http://wso2.org/bps/bpel/endpoint/config" endpointReference="ApplicationService-Tenant.epr"></endpoint>
        </service>
        </invoke>
    <invoke partnerLink="CBPL">
    <service name="callback.workflow.apimgt.carbon.wso2.org:WorkflowCallbackService" port="WorkflowCallbackServiceHttpsSoap11Endpoint">
        <endpoint xmlns="http://wso2.org/bps/bpel/endpoint/config" endpointReference="ApplicationCallbackService-Tenant.epr"></endpoint>
    </service>
    </invoke>
    ```

8.  Zip the content and create a BPEL archive in the following format:

    ``` java
        ApplicationApprovalWorkFlowProcess_1.0.0-Tenant.zip
             |_ApplicationApprovalWorkFlowProcess.bpel 
             |_ApplicationApprovalWorkFlowProcessArtifacts.wsdl 
             |_ApplicationCallbackService-Tenant.epr
             |_ApplicationService-Tenant.epr
             |_ApplicationsApprovalTaskService.wsdl 
             |_SecuredService-service.xml
             |_WorkflowCallbackService.wsdl 
             |_deploy.xml   
    ```

9.  Log into the EI as the tenant admin and upload the BPEL.

    !!! warning
        If you are using Mac OS with High Sierra, you may encounter following warning when login into the Management console due to a compression issue exists in High Sierra SDK.

    ``` java
        WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)
    ```

    To avoid this issue open &lt;EI\_HOME&gt;/ repository/conf/tomcat/catalina-server.xml and change the compression="on" to compression="off" in Connector configuration and restart the EI.


    ![]({{base_path}}/assets/attachments/103334719/103334729.png)

#### Creating a Tenant for Authentication

###### Step 1: Create a registry resource in the tenant's configuration registry

1.  Start the EI server If it is not started already.
2.  Navigate to **Registry&gt;Browse** in the **Main** menu of the management console and click on `/_system/config.         `
``
3.  Click on **Entries&gt;Add Resourc** e and fill the form using the values listed below for guidance. See [Adding a Resource](https://docs.wso2.com/display/BPS351/Adding+a+Resource) for more information.

    | Method              | Name             | Media Type |
    |---------------------|------------------|------------|
    | Create Text Content | TaskCoordination | text/plain |

4.  Click **Add** to finish adding the resource.
    ![]({{base_path}}/assets/attachments/103334719/103334723.png)
###### Step 2: Create username and password registry properties and define credentials

1.  Click on the registry resource you created (Task Coordination) found under the **Entries** section.

    ![]({{base_path}}/assets/attachments/103334719/103334724.png)
2.  Add two new registry properties for the resource called "Username" and "Password", and define the tenant coordination user credentials. To do this, click **Properties&gt;Add New Property** and enter the following values. See [Managing Properties](https://docs.wso2.com/display/BPS351/Managing+Properties) for more information.

    | **Username Property**       | **Password Property**       |
    |-----------------------------|-----------------------------|
    | **Name:** username          | **Name:** password          |
    | **Value:** (username value) | **Value:** (password value) |

    ![]({{base_path}}/assets/attachments/103334719/103334725.png)
3.  Click **Add** to finish adding the property.

![]({{base_path}}/assets/attachments/103334719/103334726.png)
#### Creating a human task

Similar to creating a BPEL, create a HumaTask that has service endpoints pointing to services hosted in the tenant's space.

1.  Create a copy of the HumanTask archive in `<APIM_HOME>/business-processes/application-creation/HumanTask` and extract its contents.
2.  Edit the SOAP service port-bindings in `ApplicationApprovalTaskService.wsdl` . For example,

    ``` xml
        <wsdl:service name="ApplicationService">
                <wsdl:port name="ApplicationPort" binding="tns:ApplicationSoapBinding">
                    <soap:address location="http://localhost:9765/services/t/<tenant domain>/ApplicationService" />
                </wsdl:port>
            </wsdl:service>
            <wsdl:service name="ApplicationReminderService">
                <wsdl:port name="ApplicationReminderPort" binding="tns:ApplicationSoapBindingReminder">
                    <soap:address location="http://localhost:9765/services/t/<tenant domain>/ApplicationReminderService" />
                </wsdl:port>
            </wsdl:service>
            <wsdl:service name="ApplicationServiceCB">
                <wsdl:port name="ApplicationPortCB" binding="tns:ApplicationSoapBindingCB">
                    <soap:address location="http://localhost:9765/services/t/<tenant domain>/ApplicationServiceCB" />
                </wsdl:port>
            </wsdl:service>
           
    ```

    !!! info
        In a distributed setup, the above addresses should be changed to point to the EI proxy/loadbalancer. A sample is shown below.

`<soap:address location="                       http:///services/t//ApplicationServiceCB                      "/>          `


3.  Create the HumanTask archive by zipping all the extracted files. When creating the human task, make sure all the files are at the top level of the zip.

4.  Log into the EI as the tenant admin and upload the HumanTask.

5.  Log into the API Manager's management console as the tenant admin and select **Resources &gt; Browse** menu.

6.  Go to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` in the registry and change the **service endpoint** as a **tenant-aware service URL** (e.g., `http://localhost:9765/services/t//ApplicationApprovalWorkFlowProcess` ). Also set the **credentials** as the **tenant admin's credentials** of the `ApplicationCreationWSWorkflowExecutor` file. For example,
    ![]({{base_path}}/assets/attachments/103334719/103334728.png)
    
    !!! note
        Be sure to disable the `SimpleWorkflowExecutor` and enable the `ApplicationCreationWSWorkflowExecutor.          `


#### **Testing the workflow**

You have now completed configuring the Application Creation workflow for a tenant. Whenever a tenant user logs in to the tenant store and create an application, the workflow will be invoked. You log in to the Admin Portal ( `https://:9443/admin` ) as the tenant admin and browse **Application Creation** menu to see all approval tasks have been created for newly created applications.

![]({{base_path}}/assets/attachments/103334719/103334721.png)