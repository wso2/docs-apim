# Consuming Messages from IBM Message Queues

## Purpose:
This application demonstrates how to consume events from IBM Message Queue and publish messages in to a IBM Queue
## Prerequisites:
1. Ensure that there is a running IBM MQ instance.
2. Create a queue manager named ESBQManager, Queue named  Queue1 and channel named Channel1
3. Download com.ibm.mq.allclient_9.0.5.0_1.0.0.jar and javax.jms-api-2.0.1.jar and copy to <SI_HOME>/lib directory.

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'
2. If the Siddhi application starts successfully, the following messages would be shown on the console
    * IBMMessageQueueSample.siddhi - Started Successfully!

## Testing the Sample:
1. Simulate single events. For this, click on 'Event Simulator' (double arrows on left tab) -> 'Single Simulation' -> Select 'IBMMessageQueueSample' as 'Siddhi App Name' -> Select 'SweetProductionSinkStream' as 'Stream Name' -> Provide attribute values -> Send

## Viewing the Results:
See the output on the console.


```sql
@App:name("IBMMessageQueueSample")

@App:description('Consume event from IBM Message Queue')




@source(type='ibmmq',
        destination.name='Queue1',
        host='192.168.56.3',
        port='1414',
        channel='Channel1',
        queue.manager = 'ESBQManager',
        username = 'mqm',
        password = '1920',
        @map(type='xml'))
define stream SweetProductionSourceStream(name string);

@sink(type='ibmmq',
      destination.name='Queue1',
      host='192.168.56.3',
      port='1414',
      channel='Channel1',
      queue.manager = 'ESBQManager',
      username = 'mqm',
      password = '1920',
      @map(type='xml'))
define stream SweetProductionSinkStream(name string);

@sink(type='log')
define stream logStream(name string);

from SweetProductionSourceStream
select *
insert into logStream;
```