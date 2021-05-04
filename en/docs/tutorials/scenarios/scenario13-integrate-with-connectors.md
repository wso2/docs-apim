# Scenario 13 - Integrate with Services via Connectors

This is a tutorial that is part of a series and can be used as a standalone tutorial on how to use connectors. For more details on the scenario and general prerequisites, please see [the scenario overview page]({{base_path}}/tutorials/scenarios/scenario-overview).

**_Time to Complete : 10 mins_**

## User story

RailCo is maintaining a Railway yard for their routine maintenance checkups for their trains. When a train comes into the yard, an entry file is created in CSV format. RailCo wants to generate an email out of this file, and they are planning to use Micro Integrator and its Email connector to achieve this.

When you integrate the systems in your organization, it is also necessary to integrate with third-party systems and its capabilities to enhance your services. WSO2 Micro Integrator uses Connectors for the purpose of referring to the APIs of third-party systems.

<img src="{{base_path}}/assets/img/tutorials/scenario-tutorials/scenario13.png" alt="Integrating with Connectors" title="Integrating with Connectors" width="60%" />

To develop the service you can use Integration Studio, where you can import and package the connector with the Composite application. To listen for a file, you can use an Inbound Endpoint, which will be listening to a particular location which you provide. Once a file is added to that location it will pick up the file and process it. Inbound Endpoints support various protocols such as HTTP, JMS, RabbitMQ, Websocket etc, 

While developing you can try it out in the Embedded Micro Integrator inside the Studio. Once the development is complete you can export it as a Compose Application and add it to the Micro Integrator runtime.

## Step 1: Create and setup the service

<img src="{{base_path}}/assets/img/tutorials/scenarios/integration_studio_connectors.png" alt="Integration Studio" title="Integration Studio" width="70%" />

Here, for simplicity, the service is already created and exported as a Composite Application along with the connector. Before adding the service to the system, you need to do the following.

1. Create a temporary directory in your machine and create three sub directories inside it called **in**, **out**, and **error**.
2. Uncomment the volume section under _mi-runtime_  in docker-compose.yml and provide the temporary directory location replacing the `<SourceLocation>` tag.

    ```
    # volumes:
    #   - <SourceLocation>:/home/wso2carbon/sample
    ```


3. To send the email, you need to have a SMTP server.

    Uncomment the following environment variables under `_mi-runtime_` and fill in the details.


    ```
         #   SMTP_HOST: <SMTP_Host>
         #   SMTP_PORT: <SMTP_Port>
         #   SMTP_USERNAME: <SMTP_Server_Username>
         #   SMTP_PASSWORD: <SMTP_Server_Password>
         #   EMAIL_TO: <To_Address>
         #   EMAIL_FROM: <From_Address>
    ```


4. After that, you need to add the `EmailService` CApp to the Micro Integrator in the setup. To do that uncomment the following line in the Dockerfile found inside `<REPO_HOME>/dockerfiles/micro-integrator/`.

    ```
    # # Uncomment when trying out Guaranteed Message Delivery Scenario
    # COPY carbonapps/RailCoFileEmailServiceCompositeExporter_1.0.0-SNAPSHOT.car ${WSO2_SERVER_HOME}/repository/deployment/server/carbonapps/
    ```


5. Now you can restart the Micro Integrator.

	`docker-compose up -d --build mi-runtime`

6. Once restarted, you can place the .csv file into the `**in`** directory inside your temporary location. You can use the `train-entry-sample.csv` file found inside `<REPO_HOME>/resources` directory for this purpose. 

    Once added, the file will be picked by Micro Integrator and sent as an Email to the address that is configured above. 

## What's next

Try out the next scenario in the series, [External Key Manager Support]({{base_path}}/tutorials/scenarios/scenario14-external-key-manager).