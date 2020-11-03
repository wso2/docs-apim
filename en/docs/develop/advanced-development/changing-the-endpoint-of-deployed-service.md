# Changing the Endpoint of a Deployed Proxy Service

The below sections describe how you can change the endpoint reference of
a deployed proxy service without changing its own configuration. For
example, in this scenario, you have two endpoints to manage two
environments (i.e., Dev and QA). The endpoint URLs for the services
hosted in the Dev and QA environments respectively are as follows:

-   Dev environment:
    [http://localhost:8280/services/echo](https://www.google.com/url?q=http://localhost:8280/services/echo&sa=D&source=hangouts&ust=1533987796246000&usg=AFQjCNHGkW_-21LrrGTq7bZTCOqRn_23uw)

-   QA environment:
    [http://localhost:8281/services/echo](https://www.google.com/url?q=http://localhost:8280/services/echo&sa=D&source=hangouts&ust=1533987796246000&usg=AFQjCNHGkW_-21LrrGTq7bZTCOqRn_23uw)


## Creating the Endpoints

You need to create two Endpoint artifacts to represent the Dev and QA environments respectively. Follow the steps given below.

1.  Create two ESB config projects as given below.
    <table>
        <tr>
            <th>Project Name</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>HelloWorldDevResources</td>
            <td>The ESB config project will store the Endpoint artifact for the <b>Dev</b> environment.</td>
        </tr>
        <tr>
            <td>HelloWorldQAResources</td>
            <td>The ESB config project will store the Endpoint artifact for the <b>QA</b> environment.</td>
        </tr>
    </table>
2.  Create two Endpoint artifacts in two projects with the following configurations:

    -   HelloWorldDevResources project
        <table>
            <tr>
                <th>Endpoint Parameter</th>
                <th>Value</th>
            </tr>
            <tr>
                <td>Endpoint Name</td>
                <td>HelloWorldEP</td>
            </tr>
            <tr>
                <td>Endpoint Type</td>
                <td>Address Endpoint</td>
            </tr>
            <tr>
                <td>Address URL</td>
                <td>http://localhost:8280/services/ech</td>
            </tr>
        </table>

    -   HelloWorldQAResources project
        <table>
            <tr>
                <th>Endpoint Parameter</th>
                <th>Value</th>
            </tr>
            <tr>
                <td>Endpoint Name</td>
                <td>HelloWorldEP</td>
            </tr>
            <tr>
                <td>Endpoint Type</td>
                <td>Address Endpoint</td>
            </tr>
            <tr>
                <td>Address URL</td>
                <td>http://localhost:8281/services/ech0</td>
            </tr>
        </table>

## Creating the Proxy Service

1.  Create an ESB Config project named **HelloWorldServices**.
2.  Create a proxy service in the HelloWorldServices project with the following configurations:

    | Parameter             | Value                                                                                              |
    |--------------------|----------------------------------------------------------------------------------------------------|
    | Proxy Service Name | HelloWorldProxy                                                                                    |
    | Proxy Service Type | Select Pass Through Proxy                                                                          |
    | Endpoint           | Select HelloWorldEP (You need to select **Predefined Endpoint** from the endpoint options listed.) |

The projects setup is now complete. 

## Creating the composite application projects

Create two composite application projects to package the QA artifacts and Dev artifacts separately. The proxy service and the Dev endpoint must go in its own CApp, and the proxy service and the QA endpoint should be in another CApp as shown below.

See the instructions on packaging artifacts into CApps.

<table>
        <tr>
            <th>Environment</th>
            <th>CApp Name</th>
            <th>Artifacts Included</th>
        </tr>
        <tr>
            <td>Dev</td>
            <td>HelloWorldDevCApp</td>
            <td>
                HelloWorldServices project and the
                HelloWorldDevResources project.
            </td>
        </tr>
        <tr>
            <td>QA</td>
            <td>HelloWorldQACApp</td>
            <td>
                HelloWorldServices project and the
                HelloWorldQAResources project.
            </td>
        </tr>
</table>

Your CApp projects are now ready to be deployed to the Micro Integrator.

## Deploying the Dev composite application

If you have an instance of WSO2 Micro Integrator setup as your Dev environment, deploy the <b>HelloWorldDevCApp</b> CApp in the server.

## Testing the Dev environment

Use the following request to invoke the service:

``` 
<body>
        <p:echoInt xmlns:p="http://echo.services.core.carbon.wso2.org">
            <!--0 to 1 occurrence-->
            <in>50</in>
        </p:echoInt>
</body>
```

You view the response from the **HelloWorldProxy**.

## Changing the endpoint reference

Follow the steps below to change the endpoint reference of the **HelloWorldProxy** you deployed, to point it to the QA environment, without changing its configuration.

1.  Set a port offset by changing the following configuration in the `deployment.toml         ` file.

    ```toml
    offset=2
    ```
2.  Undeploy the **HelloWorldDevCApp,** deploy the **HelloWorldQACApp** and re-start the Micro Integrator.

## Testing the QA environment

Use the following request to invoke the service:

```xml 
<body>
    <p:echoInt xmlns:p="http://echo.services.core.carbon.wso2.org">
        <!--0 to 1 occurrence-->
        <in>100</in>
    </p:echoInt>
</body>
```

You view the response from the **HelloWorldProxy** as seen in the image below.

## Changing an endpoint reference

Once the endpoint has been created, you can update it using any one of the options listed below. The options below describe how you can update the endpoint value for QA environment.

### Option 1: Using WSO2 Integration Studio

1.  Open the `          HelloWorldEP.xml         ` file under
    **HelloWorldQAResources** project and replace the URL with the QA
    URL.
2.  Save all changes.

Your CApp can be deployed to your QA Micro Integrator.

### Option 2: From Command Line

1.  Open a Terminal window and navigate to
    `          <WORKSPACE>/HelloWorldQAResources/src/main/synapse_configendpoints/HelloWorldEP.xml         `
    file.
2.  Edit the HelloWorldEP.xml (e.g. using gedit or vi) under
    HelloWorldResources/QA and replace the URL with the QA one.

    ``` 
    ...
    <address uri="http://192.168.1.110:9773/services/HelloService/"/>
    ...
    ```

3.  Navigate to `<Workspace>/HelloWorldQAResources          ` and build the ESB Config project using the following command:

    ``` 
    mvn clean install
    ```

4.  Navigate to
    `           <ESB_TOOLING_WORKSPACE>/HelloWorldQACApp          ` and
    build the CApp project using the following command:

    ```
    mvn clean install
    ```

5.  The resulting CAR file can be deployed directly to the QA ESB
    server. For details, see [Running the ESB profile via WSO2
    Integration
    Studio](https://docs.wso2.com/display/EI650/Running+the+Product#RunningtheProduct-RunningtheESBprofileviaWSO2IntegrationStudio)
    .

!!! Note
    -   To build the projects using the above commands, you need an active network connection.
    -   Creating a Maven Multi Module project that contains the above projects, allows you to projects in one go by simply building the parent Maven Multi Module project.

### Option 3: Using a Script

Alternatively you can have a CAR file with dummy values for the endpoint URLs and use a customized shell script or batch script. The script
created would need to do the following:

1.  Extract the CAR file.
2.  Edit the URL values.
3.  Re-create the CAR file with new values.

The resulting CAR file can be deployed directly to the QA ESB server.
