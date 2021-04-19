# Receiving Messages from a Google Pub/Sub Topic

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling using googlepubsub source in Siddhi to consume events. Events which are in TEXT format are consumed from a googlepubsub topic.

## Prerequisites:
1. Create a Google Cloud Platform account.
2. Sign in to Google Account and set up a GCP Console project and enable the API.
3. Create a service account and download a private key as JSON.
4. Place your json file in any system folder and provide the path for the credential.path.
5. Save the sample.
6. If there is no syntax error, the following message is shown on the console:
	        * -Siddhi App ReceiveGooglePubSubMesssage successfully deployed.


## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'
2. If the Siddhi application starts successfully, the following messages would be shown on the console,
* ReceiveGooglePubSubMesssage.siddhi - Started Successfully!

## Testing the Sample:
1. Receive events through the following,
You may listen to the events coming to a topic after the subscription is made.


## Viewing the Results:
See the output on the terminal:  
INFO {io.siddhi.core.stream.output.sink.LogSink} - ReceiveEvent : BarStream : Event{timestamp=1552548124599, data=[message:"Hello"], isExpired=false} (Encoded)

## Notes:
	Make sure the the credential file is correct and user have write access to make api calls.
Stop this Siddhi application

```sql
@App:name("ReceiveGooglePubSubMesssage")

@App:description('Consume messages from a googlepubsub Topic.')


@App:name("ReceiveEvent")
@App:description("Listen for messages received for a topic in Google Pub Sub Server.")


@source(type ='googlepubsub', 
                project.id = 'sp-path-1547649404768', 
                topic.id = 'topic75',
                credential.path = '/../sp.json',
                subscription.id = 'sub75', 
                @map(type = 'text'))

define stream FooStream (message string); 
                
@sink(type='log')
define stream BarStream(message string);

@info(name='EventsPassthroughQuery')
    from FooStream 
    select message 
    insert into BarStream;
```