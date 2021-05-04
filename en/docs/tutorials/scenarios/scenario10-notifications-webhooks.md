# Scenario 10 - Notifications Using Webhooks

This is a tutorial that is part of a series and can be used as a standalone tutorial on how to work with notifications using webhook. For more details on the scenario and general prerequisites, please see [the scenario overview page]({{base_path}}/tutorials/scenarios/scenario-overview).

**_Time to Complete : 5 mins_**

## User Story

From time to time GoGo transit provides notifications to the Train companies. (For e.g., platform unavailability, revised fees, etc.). GoGo transit is planning to provide this information as webhooks so that the Train companies can subscribe to these notifications without continuously polling.

WebHooks only allow one-way communication, from a caller web app to caller web app. The client who intends to receive the events from the server/web app/publisher has to register its URL against the interesting events in the publisher. When an event occurs, if a client is registered for that event, the publisher will make an HTTP POST request to the registered URL of the client to notify the event.

<img src="{{base_path}}/assets/img/tutorials/scenario-tutorials/scenario10.png" alt="Webhook notifications" title="Webhook notifications" width="60%" />

You can view the Webhook API created in WSO2 API Manager by going to the publisher (Super tenant - admin). [https://localhost:9443/publisher/apis](https://localhost:9443/publisher/apis) 

You can publish notifications under different topics.

<img src="{{base_path}}/assets/img/tutorials/scenarios/notification_api_topics.png" alt="Notification Topics" title="Notification Topics" width="60%" />

## Step 1: Subscribe to an API

To subscribe to the API, you need to go to the Developer Portal.

1. Go to [https://localhost:9443/devportal/](https://localhost:9443/devportal/) Developer Portal and select **Carbon.super** tenant domain. This will redirect you to the super tenant Developer Portal.
2. Sign in with a Super tenant, Developer Portal user. Use user as `peter` and password as `user123`.
3. Click on NotificationAPI and click subscribe using a policy and generate the access token.

## Step 2: Set up notifications

To receive notifications, you need to register a service that will be called for each event. 

1. You can use [https://webhook.site/](https://webhook.site/) for this purpose. You can use the webhook site unique URL to subscribe yourself to the **general** topic. 
2. Go to the **Try out** tab and enter the following details under **general** topic.

    <img src="{{base_path}}/assets/img/tutorials/scenarios/notification_subscribe_devportal.png" alt="Subscribing to Topic" title="Subscribing to Topic" width="60%" />
3. Click on **Generate Curl**, copy the Curl command, and run it on your terminal. This will subscribe your client (webhook site) to the API Manager. You can verify that the subscription was successful by checking the event that was received on the Webhook site.

## Step 3: Send notifications

To send a notification, you need to retrieve the callback URL for a topic from the publisher. 

1. Sign in to the publisher again with admin user credentials and select NotificationsAPI.
2. You can get the Callback URL by visiting the Topics tab and selecting the topic you require. Since you have subscribed to the **general** topic above, let’s get the URL for that topic.

    <img src="{{base_path}}/assets/img/tutorials/scenarios/notification_topic_configuration.png" alt="Topic Configuration" title="Topic Configuration" width="60%" />

3. Next you need to go to the **Subscription Configuration** section on the top and enable it. Click on the **Generate** button and generate a secret. You need this secret to calculate the hmac value that you can send in the request header.

    <img src="{{base_path}}/assets/img/tutorials/scenarios/notification_topic_secret.png" alt="Subscription Configuration" title=""Subscription Configuration" width="60%" />

4. Let’s say that we are going to send the below payload.

    ```
    {"Message" : "Platform 12 on Braybrooke station will be closed for 2 hours on 2021-09-07T-15:50+00"}
    ```

5. You need to calculate the hmac value for the above payload using the secret we have generated in the publisher. We can do this on the following website: [https://www.freeformatter.com/hmac-generator.html](https://www.freeformatter.com/hmac-generator.html) (Use SHA1).

6. With the hmac value derived above, you can invoke the below request that will send an event in the **general** topic. This event will be received on the webhook site.

    ```
    curl -X POST 'http://localhost:9021/notification/1.0.0/webhooks_events_receiver_resource?topic=/general' \
    --header 'Accept: application/json' \
    --header 'x-hub-signature: sha1=<hmac value>' \
    --header 'Content-Type: application/json' \
    --data-raw '{"Message" : "Platform 12 on Braybrooke station will be closed for 2 hours on 2021-09-07T-15:50+00"}'

    ```

## What's next

Try out the next scenario in the series, [GraphQL]({{base_path}}/tutorials/scenarios/scenario11-graphql).