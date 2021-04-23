# Scenario 13 - Integrate with Services via Connectors

**RailCo is maintaining a Railway yard for their routine maintenance checkups for their trains. When a train comes into the yard, an entry file is created in CSV format. RailCo wants to generate an email out of this file, and they are planning to use Micro Integrator and its Email connector to achieve this.**

When you integrate the systems in your organization, it is also necessary to integrate with third-party 
systems and its capabilities to enhance your services. WSO2 Micro Integrator uses Connectors for the purpose of referring to the APIs of third-party systems.

<img src="{{base_path}}/assets/img/tutorials/scenarios/scenario_integrate_connectors.png" alt="Integrating with Connectors" title="Integrating with Connectors" width="60%" />

To develop the service we can use Integration Studio, where we can import and package the connector 
with the Composite application. To listen for a file, we can use an Inbound Endpoint which will be listening 
to a particular location which we provide. Once a file is added to  that location it will pick up the file 
and process it. Inbound Endpoints support various protocols such as HTTP, JMS, RabbitMQ, Websocket etc, 
While developing you can try it out in the Embedded Micro Integrator inside the Studio. Once the development 
is complete you can export it as a Compose Application and add it to the Micro Integrator runtime.

<img src="{{base_path}}/assets/img/tutorials/scenarios/integration_studio_connectors.png" alt="Integration Studio" title="Integration Studio" width="60%" />

Here, for simplicity, the service is already created and exported as a Composite Application along with 
the connector. Before adding the service to the system, you need to do the following.

1. Create a temporary directory in your machine and create three sub directories inside it called **in**, **out** & **error**.
2. Uncomment the volume section under _mi-runtime_  in docker-compose.yml and provide the temporary directory location replacing the &lt;SourceLocation> tag.

    ```
    # volumes:
    #   - <SourceLocation>:/home/wso2carbon/sample
    ```


3. To send the email, you need to have a SMTP server.

    Uncomment the following environment variables under _mi-runtime _and fill in the details.


    ```
         #   SMTP_HOST: <SMTP_Host>
         #   SMTP_PORT: <SMTP_Port>
         #   SMTP_USERNAME: <SMTP_Server_Username>
         #   SMTP_PASSWORD: <SMTP_Server_Password>
         #   EMAIL_TO: <To_Address>
         #   EMAIL_FROM: <From_Address>
    ```


4. After that, we need to add the EmailService CApp to the Micro Integrator in the setup. To do that uncomment the following line in the Dockerfile found inside _&lt;REPO_HOME>/dockerfiles/micro-integrator/._

    ```
    # # Uncomment when trying out Guaranteed Message Delivery Scenario
    # COPY carbonapps/RailCoFileEmailServiceCompositeExporter_1.0.0-SNAPSHOT.car ${WSO2_SERVER_HOME}/repository/deployment/server/carbonapps/
    ```


5. Now you can restart the Micro Integrator.

	`docker-compose up -d --build mi-runtime`

Once restarted, you can place the csv file into the `**in`** directory inside your temporary location. You can use the train-entry-sample.csv file found inside `_&lt;REPO_HOME>/resources`_ for this purpose. 

Once added, the file will be picked by Micro Integrator and sent as an Email to the address which is configured above. 
