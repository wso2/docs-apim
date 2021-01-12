# Receiving Email Alerts

## Purpose:
This application demonstrates how to send a single event via Single Simulation, and to generate alerts using filters when the threshold value is exceeded. Furthermore, it shows how to configure WSO2 Streaming Integrator Tooling to publish an alerts via e-mail. An alert is generated as an email when a high value transaction (i.e., where the value is over 5000) takes place.

!!!info "Before you begin:"
    - Enable access to less  secure apps in the gmail account you are using for this example via the [Less SecureApps](https://myaccount.google.com/lesssecureapps) link.<br/>
    - In the sample application, change the values for the following parameters in the `@sink` annotation as follows.<br/>
        - `username` -> `business.rules.manager` (This is the sender's username.)<br/>
        - `password` -> `business-rules` (This is the sender's password.)<br/>
        - `address`-> `business.rules.manager@wso2.com` (This is the sender's address.)<br/>
        - `to` -> `template-manager@wso2.com` (This is the receiver's address.)<br/>
        - `subject` -> `Alert for large value transaction: cardNo:{{creditCardNo}}` (This is the subject of the email.)<br/>
        Once you update the values for the above parameters, save the sample Siddhib application.<br/>


## Executing the Sample

To execute the sample open the saved Siddhi application in Streaming Integrator Tooling, and start it by clicking the **Start** button (shown below) or by clicking **Run** => **Run**.

![Start button]({{base_path}}/assets/img/streaming/amazon-s3-sink-sample/start.png)

If the Siddhi application starts successfully, the following message appears in the console.

`AlertsAndThresholds.siddhi - Started Successfully!.`

## Testing the Sample

To test the sample Siddhi application, simulate a single event for it via the Streaming Integrator Tooling as follows:

1. To open the Event Simulator, click the **Event Simulator** icon.

    ![Event Simulator Icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/event-simulation-icon.png)

    This opens the event simulation panel.

2. To simulate events for the `TransactionStream` stream of the `AlertsAndThresholds`  Siddhi application, enter information in the **Single Simulation** tab of the event simulation panel as follows.

    ![Select Siddhi Application and Stream]({{base_path}}/assets/img/streaming/alerts-and-thresholds-sample/alerts-and-thresholds-siddhi-app-stream.png)

    | **Field**                   | **Value**                              |
    |-----------------------------|----------------------------------------|
    | **Siddhi App Name**         | `AlertsAndThresholds`                  |
    | **StreamName**              | `TransactionStream`                    |

    As a result, the attributes of the `Transactiontream` stream appear as marked in the image above.


3. Enter values for the attributes as follows:

    ![Enter Attribute Values]({{base_path}}/assets/img/streaming/alerts-and-thresholds-sample/alerts-and-thresholds-single-simulation.png)

    | **Attribute**     | **Value**          |
    |-------------------|--------------------|
    | **creditCardNo**  | `1234567898765432` |
    | **country**       | `SL`               |
    | **item**          | `mobile`           |
    | **quantity**      | `100`              |
    | **price**         | `5000`             |

    !!!info
        To generate an email alert, you need to simulate an event where the transaction value (i.e., `quantity` * `price`) exceeds `5000`. This is indicated by the `[quantity * price  > 5000]` filter connected to the `TransactionStream` input stream.

4. Click **Send**.


## Viewing the Results

To view the results, check the receiver gmail inbox (i.e., gmail specified via the `to` parameter in the sink configuration). The following is displayed.

```
Subject: Alert for large value transaction: cardNo:1234567898765432
Content:
creditCardNo:"1234567898765432",
country:"SL",
item:"mobile",
quantity:100,
price:5000
```

???info "Click here to view the sample Siddhi application."
    ```sql
    @App:name("AlertsAndThresholds")
    @App:description('Simulate a single event and receive alerts as e-mail when a predefined threshold value is exceeded')

    define stream TransactionStream(creditCardNo string, country string, item string, quantity int, price double);

    @sink(type='email',
          username ='business.rules.manager',
          address ='business.rules.manager@wso2.com',
          password= 'business-rules',
          subject='Alert for large value transaction: cardNo:{{creditCardNo}}',
          to='receive.alert.account1@gmail.com, receive.alert.account2@gmail.com',
          port = '465',
          host = 'smtp.gmail.com',
          ssl.enable = 'true',
          auth = 'true',
          @map(type='text'))
    define stream AlertStream(creditCardNo string, country string, item string, quantity int, price double);

    --Filter events when quantity * price > 5000 condition is satisfied
    @info(name='query1')
    from TransactionStream[quantity * price  > 5000]
    select *
    insert into AlertStream;
    ```