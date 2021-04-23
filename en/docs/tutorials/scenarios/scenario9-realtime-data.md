# Scenario 9 - Realtime Data with WebSocket API

## User Story

**Quantis wants to provide real time location of their trains to their customers. The sensors in the train will 
be providing real time events and Quantis wants to convert it to websockets and expose it as a Streaming API 
so that the client mobile applications can subscribe to it and receive real time events.**

<img src="{{base_path}}/assets/img/tutorials/scenarios/scenario_real_time_notifications.png" alt="Realtime Notifications" title="Realtime Notifications" width="60%" />

WSO2 Streaming Integrator(SI) is a streaming data processing server that integrates streaming data and takes 
action based on streaming data. Quantis is planning to use Streaming Integrator to process the real time event data.

To develop a service in Streaming Integrator, you need to use Streaming Integrator tooling. Siddhi is the 
Event Processing Engine that is used inside the Streaming Integrator. To process the websockets you can write 
the service in SIddhi Query Language. You can test the service in the tooling itself. Once the development is 
complete you can export it as a Siddhi app and add it to the Streaming Integrator runtime.

<img src="{{base_path}}/assets/img/tutorials/scenarios/streaming_api_tooling.png" alt="Streaming Integrator Tooling" title="Streaming Integrator Tooling" width="60%" />

Here, for simplicity, the service is already created and exported as a SiddhiApp and added to the Streaming Integrator instance in the tutorial setup. You can test the Streaming Integrator service by invoking it directly. You will start receiving Realtime events by connecting a websocket client. (You can use [wscat](https://www.npmjs.com/package/wscat))

```
wscat -c ws://localhost:8025/ 

```

Once you expose the events via a Websocket Server, you can expose the websockets with API Manager as you do with other APIs where you can provide **secure access, Rate limiting, Throttling, Monetization, Analytics** etc. The API is already published to the portal. To invoke the API, you can follow the below steps.

1. To subscribe to the websocket API, go to [https://localhost:9443/devportal/](https://localhost:9443/devportal/) Dev portal and select **Quantis** tenant domain. (Logout from your previous tenant) This will redirect you to the Quantis developer portal.
2. Sign in with a Quantis, developer portal user. (bob@quantis.com)
3. Click on TrainRealLocationAPI and click subscribe using a policy and generate the access token.

<img src="{{base_path}}/assets/img/tutorials/scenarios/realtime_api_devportal.png" alt="Devportal View" title="Devportal View" width="60%" />

<img src="{{base_path}}/assets/img/tutorials/scenarios/realtime_api_subscriptions.png" alt="Subscription View" title="Subscription View" width="60%" />


4. You can use the above fetched access token to subscribe to the location of the train 456 (Topic : loc-train-qnt-456), using a websocket client. For example you can use wscat tool, subscribe as below.

```
wscat -c ws://localhost:9099/t/quantis.com/train/location/1.0.0/loc-train-qnt-456/ -H "Authorization: Bearer <Access Token>"

```