# Quick Start Guide - Integration

Let's get started with WSO2 Micro Integrator by running a simple integration use case in your local environment. 

## Before you begin...

1. Install [Oracle Java SE Development Kit (JDK)](http://java.sun.com/javase/downloads/index.jsp) version 11 and set the `JAVA_HOME` environment variable.
   For more information on setting the `JAVA_HOME` environment variable for different operating systems, see [Setup and Install]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-runtime/).
2. Go to the [WSO2 Micro Integrator web page](https://wso2.com/integration/micro-integrator/#), click **Download**, and then click **Zip Archive** to download the Micro Integrator distribution as a ZIP file.
3. Optionally, navigate to the [API Manager Tooling web page](https://wso2.com/api-management/tooling/), and download WSO2 Integration Studio.

    !!! Info
        For more information, see the [installation instructions]({{base_path}}/install-and-setup/install-and-setup-overview/#installing_1).

4. Download the [sample files]({{base_path}}/assets/attachments/quick-start-guide/mi-qsg-home.zip). From this point onwards, let's refer to this directory as `<mi-qsg-home>`.
5. Download [curl](https://curl.haxx.se/) or a similar tool that can call an HTTP endpoint.
6. Optionally, go to the [WSO2 API Manager website](https://wso2.com/api-management/), click **TRY IT NOW**, and then click **Zip Archive** to download the API Manager distribution as a ZIP file.

## What you'll build

This is a simple service orchestration scenario. The scenario is about a basic healthcare system where the Micro Integrator is used to integrate two back-end hospital services to provide information to the client.

Most healthcare centers have a system that is used to make doctor appointments. To check the availability of the doctors for a particular time, users typically need to visit the hospitals or use each and every online system that is dedicated to a particular healthcare center. Here, we are making it easier for patients by orchestrating those isolated systems for each healthcare provider and exposing a single interface to the users.

<a href="{{base_path}}/assets/img/integrate/quick-start-guide/mi-quick-start-guide.png"><img src="{{base_path}}/assets/img/integrate/quick-start-guide/mi-quick-start-guide.png" width="1600" height="600"></a>


    !!! Tip
        You may export` <mi-qsg-home>/HealthcareIntegrationProject` to Integration Studio to view the project structure.

In the above scenario, the following takes place:

1. The client makes a call to the Healthcare API created using Micro Integrator.

2. The Healthcare API calls the Pine Valley Hospital back-end service and gets the queried information.

3. The Healthcare API calls the Grand Oak Hospital back-end service and gets the queried information.

4. The response is returned to the client with the required information.

Both Grand Oak Hospital and Pine Valley Hospital have services exposed over the HTTP protocol.

The Pine Valley Hospital service accepts a POST request in the following service endpoint URL.

```bash
http://<HOST_NAME>:<PORT>/pineValley/doctors
```

The Grand Oak Hospital service accepts a GET request in the following service endpoint URL.

```bash
http://<HOST_NAME>:<PORT>/grandOak/doctors/<DOCTOR_TYPE>
```

The expected payload should be in the following JSON format:

```bash
{
        "doctorType": "<DOCTOR_TYPE>"
}
```

Let’s implement a simple integration solution that can be used to query the availability of doctors for a particular category from all the available healthcare centers.

 
### Step 1 - Set up the workspace

To set up the integration workspace for this quick start guide, we will use an integration project that was built using WSO2 Integration Studio:

1. Extract the downloaded WSO2 Micro Integrator and sample files into the same directory location.

2. Navigate to the `<mi-qsg-home>` directory. 
The following project files and executable back-end services are available in the `<mi-qsg-home>`.

- **HealthcareIntegrationProject/HealthcareIntegrationProjectConfigs**: This is the ESB Config module with the integration artifacts for the healthcare service. This service consists of the following REST API:

      <img src="{{base_path}}/assets/img/integrate/quick-start-guide/qsg-api.png">

      <details>
                <summary>HealthcareAPI.xml</summary>
            ```xml
            <?xml version="1.0" encoding="UTF-8"?>
            <api context="/healthcare" name="HealthcareAPI" xmlns="http://ws.apache.org/ns/synapse">
                <resource methods="GET" uri-template="/doctor/{doctorType}">
                    <inSequence>
                        <clone>
                            <target>
                                <sequence>
                                    <call>
                                        <endpoint key="GrandOakEndpoint"/>
                                    </call>
                                </sequence>
                            </target>
                            <target>
                                <sequence>
                                    <payloadFactory media-type="json">
                                        <format>{
                                        "doctorType": "$1"
                                        }</format>
                                        <args>
                                            <arg evaluator="xml" expression="$ctx:uri.var.doctorType"/>
                                        </args>
                                    </payloadFactory>
                                    <call>
                                        <endpoint key="PineValleyEndpoint"/>
                                    </call>
                                </sequence>
                            </target>
                        </clone>
                        <aggregate>
                            <completeCondition>
                                <messageCount max="-1" min="-1"/>
                            </completeCondition>
                            <onComplete aggregateElementType="root" expression="json-eval($.doctors.doctor)">
                                <respond/>
                            </onComplete>
                        </aggregate>
                    </inSequence>
                    <outSequence/>
                    <faultSequence/>
                </resource>
            </api>
            ```    
      </details>
      
      
      It also contains the following two files in the metadata folder.
      
      
    !!! Tip
        This data is used later in this guide by the API management runtime to generate the managed API proxy.
  
      
      <table>
          <tr>
              <th>
                  HealthcareAPI_metadata.yaml
              </th>
              <td>
                  This file contains the metadata of the integration service. 
                  The default **serviceUrl** is configured as `http://localhost:8290/healthcare`.
                  If you are running Micro Integrator on a different host and port, you may have to change these values.
              </td>
          </tr>
          <tr>
              <th>
                  HealthcareAPI_swagger.yaml
              </th>
              <td>
                  This Swagger file contains the OpenAPI definition of the integration service.
              </td>
          </tr>
      </table>

- **HealthcareIntegrationProject/HealthcareIntegrationProjectCompositeExporter**: This is the Composite Application Project folder, which contains the packaged CAR file of the healthcare service.

- **Backend**: This contains an executable .jar file that contains mock back-end service implementations for the Pine Valley Hospital and Grand Oak Hospital.

- **bin**: This contains a script to copy artifacts and run the backend service.

### Step 2 - Running the integration artifacts

Follow the steps given below to run the integration artifacts we developed on a Micro Integrator instance that is installed on a VM.

1. Run `run.sh/run.bat` script in `<mi-qsg-home>/bin` based on your operating system to start up the workspace.
    1. Open a terminal and navigate to the `<mi-qsg-home>/bin` folder.
    2. Execute the relevant OS specific command:
 
        ```bash tab='On MacOS/Linux/CentOS'
        sh run.sh 
        ```
            
        ```bash tab='On Windows'
        run.bat 
        ```  
      
        !!! Tip
            The script assumes `MI_HOME` and `<mi-qsg-home>` are located in the same directory. It carries out the following steps.

            - Start the back-end services.

                Two mock hospital information services are available in the `DoctorInfo.jar` file located in the `<mi-qsg-home>/Backend/` directory. 
    
                To manually start the service, open a terminal window, navigate to the `<mi-qsg-home>/Backend/` folder, and use the following command to start the services:
    
                ```bash
                java -jar DoctorInfo.jar
                ```
   
            - Deploy the Healthcare service.

                Copy the CAR file of the Healthcare service (HealthcareIntegrationProjectCompositeExporter_1.0.0-SNAPSHOT.car) from the `<mi-qsg-home>/HealthcareIntegrationProject/HealthcareIntegrationProjectCompositeExporter/target/` directory to the `<MI_HOME>/repository/deployment/server/carbonapps` directory.
              
2. Start the Micro Integrator.

    1. Execute the relevant command in a terminal based on the OS:
 
      ```bash tab='On MacOS/Linux/CentOS'
      sh micro-integrator.sh
      ```
          
      ```bash tab='On Windows'
      micro-integrator.bat
      ```

4. (Optional) Start the Dashboard.

    If you want to view the integration artifacts deployed in the Micro Integrator, you can start the dashboard. The instructions on running the MI dashboard is given in the installation guide:

    1.  [Install]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi-dashboard) the MI dashboard.
    2.  [Start]({{base_path}}/install-and-setup/install/installing-the-product/running-the-mi-dashboard) the MI dashboard.
    
 You can now test the **HealthcareIntegrationService** that you just generated.
 
### Step 3 - Testing the integration service

1. Invoke the healthcare service.

    Open a terminal and execute the following curl command to invoke the service:

    ```bash
    curl -v http://localhost:8290/healthcare/doctor/Ophthalmologist
    ```

    Upon invocation, you should be able to observe the following response:

    ```bash
    [ 
       [ 
          { 
             "name":"John Mathew",
             "time":"03:30 PM",
             "hospital":"Grand Oak"
          },
          { 
             "name":"Allan Silvester",
             "time":"04:30 PM",
             "hospital":"Grand Oak"
          }
       ],
       [ 
          { 
             "name":"John Mathew",
             "time":"07:30 AM",
             "hospital":"pineValley"
          },
          { 
             "name":"Roma Katherine",
             "time":"04:30 PM",
             "hospital":"pineValley"
          }
       ]
    ]
    ```
    **Congratulations!**
    Now you have created your first integration service. Optionally, you can follow the steps given below to expose the service as a Managed API in API Manager.
    
## Exposing an Integration Service as a Managed API

The REST API you deployed in the Micro Integrator is an **integration service** for the API Manager. Now, let's look at how you can expose the integration service to the API Management layer and generate a managed API by using the service.

### Step 1 - Expose your integration as a service 

1. Start the API Manager runtime:

    1.  Extract the API Manager ZIP file.
    3.  Start WSO2 API Manager:
    
        Open a terminal, navigate to the `<API-M_HOME>/bin` directory, and execute the relevant command. 
   
        
        ```bash tab="On MacOS/Linux"
        ./api-manager.sh
        ```
        
        ```bash tab="On Windows"
        api-manager.bat --run
        ```

2. Update and start the Micro Integrator runtime:

    1. Stop the Micro Integrator.

    2. Uncomment the following configuration from the `<MI_HOME>/conf/deployment.toml` file of the Micro Integrator.

        !!! Tip
            The default username and password for connecting to the API gateway is `admin:admin`.


        ```toml
        [[service_catalog]]
        apim_host = "https://localhost:9443"
        enable = true
        username = "admin"
        password = "admin"
        ```
    
    3.  Start the Micro Integrator again.

        You will see the following in the server start-up log.

        ```bash
        Successfully updated the service catalog
        ```

3. Access the integration service from the **API Publisher**:

    1. Sign in to the **API Publisher**: `https://localhost:9443/publisher`

        !!! Tip
            Use `admin` as the user name and password.

    2. Select the **Services** from the menu.
    
        <img src="{{base_path}}/assets/img/integrate/quick-start-guide/select-services.png" width="500">
        
    3. See that the `HealthcareAPI` is listed as a service.
`   `
### Step 2 - Create a managed API using the Integration Service

1.  Click on the `HealthcareAPI` that is in the service catalog.

2.  Click **Create API**.

     This opens the **Create API** dialog box with the API details that are generated based on the service.

    <a href="{{base_path}}/assets/img/integrate/quick-start-guide/create-api-from-healthcare-service.png"><img src="{{base_path}}/assets/img/integrate/quick-start-guide/create-api-from-healthcare-service.png" width="800" alt="create api dialog box"></a>

3.  Update the API name, context, and version if required, and click **Create API**. 

    The overview page of the API that you just created appears. 

    <a href="{{base_path}}/assets/img/integrate/quick-start-guide/new-healthcareapi-view.png"><img src="{{base_path}}/assets/img/integrate/quick-start-guide/new-healthcareapi-view.png" alt="apis list"></a>

4.  Navigate to **Develop -> API Configurations -> Endpoints** from the left menu. You will see that **Service Endpoint** is already selected and the production endpoint is already provided.

     Select the `Sandbox Endpoint`, add the endpoint `http://localhost:8290/healthcare`, and **Save**.
     
5.  Update the portal configurations and API configurations as required.

     Now, you have successfully created an API using the service.

### Step 3 - Publish the managed API

1. Navigate  to **Deployments** and click **Deploy** to create a revision to deploy in the default Gateway environment. 

2. Navigate to **Lifecycle** and click **Publish** to publish the API in the Gateway environment.

    <a href="{{base_path}}/assets/img/integrate/quick-start-guide/healthcareapi-lifecycle.png"><img src="{{base_path}}/assets/img/integrate/quick-start-guide/healthcareapi-lifecycle.png"></a>
    
    If the API is published successfully, the lifecycle state will shift to **PUBLISHED**. 

### Step 4 - Invoke the Managed `HealthcareAPI` via Developer Portal

1. Navigate to  the **Developer Portal** by clicking on the `View In Dev Portal` at the top menu.

    <a href="{{base_path}}/assets/img/integrate/quick-start-guide/view-in-dev-portal.png"><img src="{{base_path}}/assets/img/integrate/quick-start-guide/view-in-dev-portal.png"></a>

2. Sign in using the default username/password `admin/admin`. You will be redirected to the **APIs**.

3. Under **APIs**, you will see the published `HealthcareAPI`. Click on it to navigate to the Overview of the API.

4. Click `Try Out`. This will create a subscription to the API using `Default Application`.

    <a href="{{base_path}}/assets/img/integrate/quick-start-guide/devportal-tryout.png"><img src="{{base_path}}/assets/img/integrate/quick-start-guide/devportal-tryout.png" size="800"></a>

5. Click `GET TEST KEY` to get a test token to invoke the API.

    <a href="{{base_path}}/assets/img/integrate/quick-start-guide/devportal-get-test-key.png"><img src="{{base_path}}/assets/img/integrate/quick-start-guide/devportal-get-test-key.png" size="800"></a>

6. Click **GET** resource `/doctor​/{doctorType}`. Click on **Try It Out**. Enter `Ophthalmologist` in the doctorType field and click **Execute**.

    <a href="{{base_path}}/assets/img/integrate/quick-start-guide/devportal-invoke.png"><img src="{{base_path}}/assets/img/integrate/quick-start-guide/devportal-invoke.png" size="800"></a>

   
## What's next?

- [Develop your first integration solution]({{base_path}}/integrate/develop/integration-development-kickstart).
- Try out the **examples** available in the [Integrate section of our documentation]({{base_path}}/integrate/integration-overview/).
- Try out the entire developer guide on [Exposing an Integration Service as a Managed API]({{base_path}}/tutorials/integration-tutorials/service-catalog-tutorial/).
- Try out the entire developer guide on [Exposing an Integration SOAP Service as a Managed API]({{base_path}}/tutorials/integration-tutorials/service-catalog-tutorial-for-proxy-services/).