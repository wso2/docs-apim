# Scenario 12 - Guaranteed Message Delivery

## User Story

**Railco wants to partner up with a Catering service to provide food to their first class passengers. 
For each registration they want to send an entry to the Catering service system. However, they have noticed that 
the Catering service system becomes unavailable from time to time. To make sure that the entries reach the 
Catering system, they are planning to implement a Guaranteed Message Delivery system.**

Store and forward messaging pattern is used to ensure guaranteed delivery of messages. Messages never get 
lost since they are stored in the message store and available for future reference.

This will be implemented with Message Store and Message Processor in Micro Integrator. Whenever the 
catering system is down, the messages will be stored in the Message Store. When the system becomes available again, the stored messages will be sent to the Catering system.

<img src="{{base_path}}/assets/img/tutorials/scenarios/scenario_guaranteed_message_delivery.png" alt="Guaranteed Message Delivery" title="Guaranteed Message Delivery" width="60%" />

If you look at the docker-compose.yml file, you can see that ``CATERING_SERVICE_EP`` is defined as 
‘<code>[http://www.urldoesnotexist.com](http://www.urldoesnotexist.com)</code>’ under mi-runtime service. 
If you send a request to this endpoint, it will fail and the message will be stored in the Message Store database.

To invoke the API, you can use the following curl.


```
curl -X POST 'http://localhost:8290/catering/register' \
--header 'Content-Type: application/json' \
--data-raw '{
 "passengerId": "241241d",
 "class": "first",
 "train": "RLC-5051",
 "departure": {
   "time": "2021-07-16 11:45",
   "station": "King Cross"
 },
 "arrival": {
   "time": "2021-07-16 16:40",
   "station": "Edinburgh"
 },
 "duration": "4h 55m",
 "food": [
   {
     "serving": "lunch",
     "type": "Asian",
     "comments": [
       "Not too spicy"
     ]
   },
   {
     "serving": "snacks",
     "type": "Normal",
     "comments": []
   }
 ]
}'

```


If you check the Micro Integrator logs, you can see that the Backend invocation has failed.

“Message processor [CateringServiceForwardingProcessor] failed to forward message 4 times. 
Moved failed message to fail-messages-store and continue”

After some time, the Micro Integrator will again try to send the message to the Backend. 
This process will continue until the message is successfully delivered to the backend.

To make the delivery successful, you can provide a working endpoint and restart the Micro Integrator. 
This will send the above message to that backend. 

To test this flow you can create a new endpoint in [https://hookbin.com/](https://hookbin.com/) and provide 
the endpoint in the docker-compose.yml file under _‘CATERING_SERVICE_EP_’. 

Restart Micro-Integrator runtime.

`docker-compose up -d --build mi-runtime`

Now if you check the Micro-Integrator logs, you can see that invocation has succeeded. 

`_Response = CateringServiceEP Reply Sequence Invoked, Payload: {"success":true}_`

You can refresh the hookbin site and see that the message has been captured now.
