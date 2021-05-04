# Scenario 6 - Integrating with Data Sources

This is a tutorial that is part of a series and can be used as a standalone tutorial on how to integrate with Data Sources. For more details on the scenario and general prerequisites, please see [the scenario overview page]({{base_path}}/tutorials/scenarios/scenario-overview).

**_Time to Complete : 5 mins_**

## User story

RailCo HR department is planning to develop an HR system dashboard. Therefore, Railco wants to create REST APIs to expose their Employee Database as a service where users can add, delete, update and view employee details.

With WSO2 Micro Integrator Data Services, users can integrate with different Data Sources and decouple the data from its infrastructure. In other words, when you create a data service in WSO2 Micro Integrator, the data that is stored in a storage system (such as the RDBMS) can be exposed in the form of a service. This allows users (that may be any application or system) to access the data without interacting with the original source of the data.

<img src="{{base_path}}/assets/img/tutorials/scenario-tutorials/scenario6.png" alt="Expose Datasource" title="Expose Datasource" width="60%" />

## Step 1: Develop a service in Micro Integrator

To develop a service in Micro Integrator, you can use WSO2 Integration Studio. 

<img src="{{base_path}}/assets/img/tutorials/scenarios/integration_studio_dataservice.png" alt="Integration Studio Dataservice View" title="Integration Studio Dataservice View" width="80%" />

## Step 2: Expose data via API Manager

Once developed, you can expose the data via API manager for secure access. For simplicity, the Dataservice is already developed and added in the API manager. A database has been created with dummy Employee Data that you can query and modify.

<img src="{{base_path}}/assets/img/tutorials/scenarios/employee_database.png" alt="Employee Database" title="Employee Database" width="60%" />

## Step 3: Invoke the API

To invoke the API from API Manager,

1. Go to [https://localhost:9443/devportal/](https://localhost:9443/devportal/) Developer Portal and select **RailCo** tenant domain. This will redirect you to RailCo’s Developer Portal.
2. Sign in with a RailCo tenant, Developer Portal user. Use user as `tom@railco.com` and password as `user123`.
3. Click on RailCoEmployeeAPI and click subscribe using a policy and generate the access token.
4. After that you can try out the CRUD operations on the EmployeeAPI.

    <img src="{{base_path}}/assets/img/tutorials/scenarios/employee_resources_apim.png" alt="Employee API resources" title="Employee API resources" width="60%" />
    
    For e.g., you can try out the following Curl request.
    
    ```
    curl -k -X GET 'https://localhost:8243/t/railco.com/operations/data/employees/1.0.0/employees/2' \
    --header 'Accept: application/json' \
    --header 'Authorization: Bearer <Access Token>'
    
    ```

## What's next

Try out the next scenario in the series, [Analytics]({{base_path}}/tutorials/scenarios/scenario7-analytics).