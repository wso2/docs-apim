# Correlating Data

The streaming integrator can correlate data in order to detect patterns and trends in streaming data. Correlating can be done via patterns as well as sequences.

![patterns-sequences-matrix](../images/correlating-events/patterns-sequences-matrix.png)

The difference between patterns and sequence is that sequences require all the matching events to arrive consecutively to
 match the sequence condition, whereas patterns identify events that match the pattern condition irrespective of the order in which they arrive.

## Correlating events to find a pattern

This section explains how you can use Siddhi patterns to detect trends and patterns. There are two types of Siddhi patterns as follows:

- Counting Patterns: These count the number of instances that match the given pattern condition.
- Logical Patterns: These identify logical relationships between events.

### Count and match multiple events for a given pattern condition

To understand how to count and match multiple events that match a specific condition, consider the example where a store 
wants to check the frequency with which a specific product needs to be repaired within two months after it is purchased. 
If the buyer brings back a specific product for repairs more than five times within two months, the manager of purchases needs 
to be notified via a mail. To do this, create a Siddhi application as follows.

1. Start creating a new Siddhi application. You can name it `DefectDetectionApp` For instructions, see [Creating a Siddhi Application](../develop/creating-a-Siddhi-Application.md).
    `@App:name("DefectDetectionApp")`
    
2. Define the input streams into which the events compared are received.
    1. To capture information about purchases, define a stream as follows.
        `define stream PurchasesStream (productName string, custID string);`
    2. To capture information about repairs, define a stream as follows.
        `define stream RepairsStream (productName string, custID string);`
        
3. To notify the purchase manager that the threshold is reached define an output sink with an email sink attached as follows:
    ```
    @sink(type='email', address='storemanager@abc.com', username='storemanager', password='secret_password', subject='Defective Product Alert', to='purchasemanager@headoffice.com', @map(type = 'text', @payload("Hello,The product {{productName}} is identified as defective.\n\nThis message was generated automatically.")))
    define stream DefectiveProductsStream (productName string);
    ```
    
4. To count occurrences where a product is brought back for repairs withing two months following its purchase, and identify 
products where the treshold for such occurrences is reached, create a query as follows.

    1. To specify the input streams from which the input events to be analyzed for pattern detection are taken, add a `from` clause as follows.

        `from every (e1=PurchasesStream) -> e2=RepairsStream[e1.productName==e2.productName and e1.custID==e2.custID]<5:> within 2 months`

        !!!info
            Note the following about the above `from` clause:
            - The input is derived from two streams. Therefore, first, both streams considered are specified and a unique reference is assigned to each stream. The `PurchasesStream` is referred to as `e1` and the `RepairsStream` is referred to as `e2`.
            - The matching condition to be met is that both streams should have an event where the values for both `productName` and `custID` attributes are the same.
            - The event in the `PurchasesStream` stream need to arrive before the matching event in the `RepairsStream` stream.
            - The matching event in the `RepairsStream` stream should arrive within two months after the arrival of the event in the `PurchasesStream` stream.
            - `<5:>` indicates that an output is generated only when the matching condition is met five times.
            - A time window of `2 months` is added to consider only a period of two months in a sliding manner when counting the number of times the matching condition for the pattern is met. For more information about time windows, see [Summarizing Data - Calculate and store clock-time based aggregate values](summarizing-data.md#calculate-and-store-clock-time-based-aggregate-values)
       
    2. To specify how the value for each attribute in the `DefectiveProductsStream` output stream is defined, add the `select` clause as follows.
        `select e1.productName`
        
       The output should only consist of the product identified to be possibly defective. Therefore, only the `productName` attribute is selected.
       
    3. To specify that the output has to directed to the `DefectiveProductsStream `, add the `insert into` clause as follows.
        `insert into DefectiveProductsStream`
        
The completed Siddhi application is as follows.
```sql
@App:name("DefectDetectionApp")


define stream PurchasesStream (productName string, custID string);

define stream RepairsStream (productName string, custID string);

@sink(type='email', address='storemanager@abc.com', username='storemanager', password='secret_password', subject='Defective Product Alert', to='purchasemanager@headoffice.com', @map(type = 'text', @payload("Hello,The product {{productName}} is identified as defective.\n\nThis message was generated automatically.")))
define stream DefectiveProductsStream (productName string);

from every (e1=PurchasesStream) -> e2=RepairsStream[e1.productName==e2.productName and e1.custID==e2.custID]<5:> within 2 months
select e1.productName
insert into DefectiveProductsStream
```

!!!INFO
    For more information, see [Siddhi Query Guide - Counting Patterns](https://siddhi.io/en/v4.x/docs/query-guide/#counting-pattern).
    
### Combine several patterns logically and match events

To understand how to combine several patterns logically and match events, consider an example of a factory foreman who 
needs to observe the factory output, identify any production decreases and check whether those decreases have reached 
maximum threshold which requires him to take action. To do this, you can create a Siddhi application as follows:

1. Start creating a new Siddhi application. You can name it `ProductionDecreaseDetectionApp` For instructions, see [Creating a Siddhi Application](../develop/creating-a-Siddhi-Application.md).
    `@App:name("ProductionDecreaseDetectionApp")`

2. Define an input stream as follows to capture the factory output.
    `define stream ProductionStream(productName string, factoryBranch string, productionAmount long);`

3. Now define an output stream as follows to present the observed production trend after applying the logical pattern.
    ```
    @sink(type='log', prefix='Decrease in production detected:')
    define stream ProductionDecreaseAlertStream (productName string, originalAmount long, laterAmount long, factoryBranch string);
    ```
    The output directed to this stream is published via a sink of the `log` type. For more information about publishing data via sinks, see the [Publishing Data guide](publishing-data.md).

4. To apply the pattern so that the production trend can be observed, add the `from` clause as follows.
    ```
    from every (e1=ProductionStream) -> e2=ProductionStream[e1.productName == e2.productName and e1.productionAmount - e2.productionAmount > 10]
         within 10 min
    ```

    !!!info
        Note the following about the `from`clause:<br/>

        - Here, two events from the same stream are compared to identify whether the production has decreased. The unique reference for the first event is `e1`, and the unique reference for the second event is `e2`.<br/>

        - `e2` arrives after `e1`, but it is not necessarily the event that arrives immediately after `e1`.<br/>

        - The condition that should be met for `e1` and `e2` to be compared is `e1.productName == e2.productName and e1.productionAmount - e2.productionAmount > 10`.
        This means, both the events should report the production of the same product, and there should be a decrease in
        production that is greater than 10 between the `e1` and `e2` events.<br/>

        - A `10 min` time window is included to indicate that an output event is generated only if the decrease in production by 10 or more units takes place every ten minutes in a sliding manner. For more information about time windows, see [Calculate and store clock time-based aggregate values](summarizing-data.md#calculate-and-store-clock-time-based-aggregate-values).

5. To present the required output by deriving values for the attributes of the `ProductionDecreaseAlertStream` output stream you created, add the `select` clause as follows.
    `select e1.productName, e1.productionAmount as originalAmount, e2.productionAmount as laterAmount, e1.factoryBranch`
    
    Here, the production amount of the first event is presented as `originalAmount`, and the amount of the second event is presented as `laterAmount`.

6. To insert the output into the `ProductionDecreaseAlertStream` output stream, add the `insert into` clause as follows.
    `insert into ProductionDecreaseAlertStream;`
    
The completed Siddhi application is as follows.
```
@App:name("ProductionDecreaseDetectionApp")


define stream ProductionStream(productName string, factoryBranch string, productionAmount long);

@sink(type='log', prefix='Decrease in production detected:')
define stream ProductionDecreaseAlertStream (productName string, originalAmount long, laterAmount long, factoryBranch string);

from every (e1=ProductionStream) -> e2=ProductionStream[e1.productName == e2.productName and e1.productionAmount - e2.productionAmount > 10] within 10 min
select e1.productName, e1.productionAmount as originalAmount, e2.productionAmount as laterAmount, e1.factoryBranch
insert into ProductionDecreaseAlertStream;
```


## Find non-occurrence of events

This section explains how to analyze data by observing scenarios where events do not occur. To understand how this is 
done, consider a taxi service company that tracks the movements of the taxis it runs and wants to be notified of unexpected 
delays. Consider a specific scenario where the manager needs to contact the driver if the taxi has not reached either of 
two specified locations withi 15 minutes. For this, you can create a Siddhi application as follows:

1. Start creating a new Siddhi application. You can name it `DelayDetectionApp` For instructions, see [Creating a Siddhi Application](../develop/creating-a-Siddhi-Application.md).
    `@App:name("DelayDetectionApp")`
    
2. To receive information about the location of taxis, define an input stream as follows.
    `define stream LocationStream (taxiID string, driverID string, latitude double, longitude double);`

3. To publish delay notification as a message, define an output stream as follows.
    `
    @sink(type='http', publisher.url='http://headoffice:8080/endpoint', @map(type = 'json'))
    define stream AlertStream (taxiID string, driverID string, message string);
    `
    The output directed to this stream is published via a sink of the `http` type. For more information about publishing data via sinks, see the [Publishing Data guide](publishing-data.md).

4. To specify the pattern to be used to detect the delays, add the `from` clause as follows.
    `from not LocationStream[latitude == 44.0096 and longitude == 81.2735] for 15 minutes or not LocationStream[latitude == 43.0096 and longitude == 81.2737] for 15 minutes`
    
    !!!info
        Note the following about this `from` clause:<br/>
        
        - The `not` keyword is added to indicate that the SI should look for instances where an event has *not* occurred when the given conditions are met.<br/>
        
        - Two conditions are given. The alert is generated when either of the two conditions has not occured. To indicate this, the `or` keyword is used between the two conditions.<br/>
        
        - The given conditions indicate that the taxi should have reached either the `latitude == 44.0096 and longitude == 81.2735` 
        location or the `latitude == 43.0096 and longitude == 81.2737` location. Either of the locations should be 
        reached within 15 minutes. Therefore, each location is specified as a separate condition and a time window of 15 
        minutes is applied to each condition in a sliding manner. For more information about time windows, see the [Siddhi Query Guide - Calculate and store clock time-based aggregate values](https://ei.docs.wso2.com/en/next/streaming-integrator/guides/summarizing-data/#calculate-and-store-clock-time-based-aggregate-values).

5. To derive the information relating to the delay to be published as the output, add the `select` clause as follows.
    `select LocationStream.taxiID, LocationStream.driverID, 'Unexpected Delay' as message`
    
   The alert message is a standard message that is assigned as a static value to the `message` attribute.

6. To insert the results into the `AlertStream` so that the message about the delay can be published, add the `insert into` clause as follows.
    `insert into AlertStream;`
    
The completed Siddhi application is as follows.

```
@App:name("DelayDetectionApp")

define stream LocationStream (taxiID string, driverID string, latitude double, longitude double);

@sink(type='http', publisher.url='http://headoffice:8080/endpoint', @map(type = 'json'))
define stream AlertStream (taxiID string, driverID string, message string);

from not LocationStream[latitude == 44.0096 and longitude == 81.2735] for 15 minutes or not LocationStream[latitude == 43.0096 and longitude == 81.2737] for 15 minutes
select LocationStream.taxiID, LocationStream.driverID, 'Unexpected Delay' as message
insert into AlertStream;
```

For the complete list of methods in which you can apply Siddhi patterns to detect non occuring events, see [Siddhi Query Guide - Detecting Non-Occurring Events](https://siddhi.io/en/v4.x/docs/query-guide/#detecting-non-occurring-events).


##Correlating events to find a trend(sequence)

This section explains how you can use Siddhi sequences to detect trends in events that arrive in a specific order. There are two types of Siddhi sequences as follows:

- Counting Sequences: These count the number of instances that match the given sequence condition.
- Logical Sequences: These identify logical relationships between events.

### Count and match multiple events for a given trend

Counting and matching multiple events over a given period is done via sequences when you need to identify trends in events 
that occur in a specific order. To understand how this is done, consider a scenario where the temperature is read from a 
sensor and you need to identify the peaks in temperature. If an event (i.e., a single reading) is a peak, it should report 
a temperaature greater than that reported by the event that occured immediately before it as well as the event that occurred 
immediately after it. Therefore, to identify the peaks, follow the procedure below:

1. Start creating a new Siddhi application. You can name it `TemperaturePeaksApp` For instructions, see [Creating a Siddhi Application](../develop/creating-a-Siddhi-Application.md).
    `@App:name("TemperaturePeaksApp")`
    
2. To capture the temperature readings, define an input stream as follows.
    `define stream TempStream(deviceID long, roomNo int, temp double);`

3. To report the peaks once they are identified, define an output stream as follows.
    `
    @sink(type='log', prefix='TemperaturePeak]:')
    define stream PeakTempStream(initialTemp double, peakTemp double);
    `
   The output directed to this stream is published via a sink of the `log` type. For more information about publishing data via sinks, see the [Publishing Data guide](publishing-data.md).

4. To specify how to identify the peaks, add a `from` clause as follows.
    `from every e1=TempStream, e2=TempStream[e1.temp <= temp]+, e3=TempStream[e2[last].temp > temp]`
    
    !!!info
        Note the following about the `from` clause:<br/>
        
        - `every` indicates that all the events in the `TempStream` must be checked for the given conditions.<br/>
        
        - Here, `e2` is the reference for the event identified as the peak temperature. The `e2=TempStream[e1.temp <= temp]+` condition specifies that to be identified as an event reporting a peak temperature, an event should have one or more preceding events that reports a lower or an equal temperature.<br/>
        
        - The `e3=TempStream[e2[last].temp > temp]` condition specifies a condition for `e3` which is the event that follows `e2`. It indicates that `e2`, the peak temperature event should be the last event before `e3`, and that the temperature reported by `e2` must be greater than the temperature reported by `e3`.
        

5. To specify how to derive the values for the attributes in the `PeakTempStream` output stream are derived, add a `select` clause as follows. 
    `select e1.temp as initialTemp, e2[last].temp as peakTemp`
    
    Here, the temperature reported by `e2` event is selected to be output as `peakTemp` because it is greater than the temperatures reported by events occuring before and after `e2`. The temperature reported by the event immediately before `e2` is selected as `initialTemp`.

6. To insert the output generated into the `PeakTempStream` output stream, add an `insert into` clause as follows.
    `insert into PeakTempStream;`

The completed Siddhi application is as follows.
```
@App:name("TemperaturePeaksApp")

define stream TempStream(deviceID long, roomNo int, temp double);

@sink(type='log', prefix='TemperaturePeak]:')
define stream PeakTempStream(initialTemp double, peakTemp double);

from every e1=TempStream, e2=TempStream[e1.temp <= temp]+, e3=TempStream[e2[last].temp > temp]
select e1.temp as initialTemp, e2[last].temp as peakTemp
insert into PeakTempStream;
```

### Combine several trends logically and match events

Logical sequences are used to identify logical relationships between events that occur in a specific order. To understand 
this consider a scenario where an application is able to notify the state only when the event that notifies that the regulator 
is switched on is immediately followed by two other events to report the temperature and humidity. To create such a Siddhi 
application, follow the procedure below.

1. Start creating a new Siddhi application. You can name it `RoomStateApp` For instructions, see [Creating a Siddhi Application](../develop/creating-a-Siddhi-Application.md).
    `@App:name("RoomStateApp")`
    
2. You need three input streams to capture information about the state of the regulator, the temperature, and humidity.

    1. Define the inpt stream that captures the state of the regulator as follows.
        `define stream RegulatorStream(deviceID long, isOn bool);`
    
    2. Define the input stream that captures the temperature as follows.
        `define stream TempStream(deviceID long, temp double);`
    
    3. Define the input stream that captures the humidity as follows.
        `
        @sink(type='log', prefix='RoomState]:')
        define stream StateNotificationStream(temp double, humid double);
        `
       The output directed to this stream is published via a sink of the `log` type. For more information about publishing data via sinks, see the [Publishing Data guide](publishing-data.md).
       
3. Now let's define an output stream to publish the temperature and humidity.
    `define stream StateNotificationStream(temp double, humid double)`

4. To apply the logical sequence to derive the output, add the `from` clause as follows.
    `from every e1=RegulatorStream, e2=TempStream and e3=HumidStream`
    
    Here, the unique references `e1`, `e2`, and `e3` are assigned to the first, second, and thid events respectively. `e1` must arrive at the `RegulatorStream` stream, `e2` must arrive at the `TempStream` stream, and `e3` must arrive at the `HumidStream` stream in that order. The output event is generated only after all three of these input events have arrived.

5. To derive values for the attributes of the `StateNotificationStream` output stream, add a `select` clause as follows.
    `select e2.temp, e3.humid`
    
   To generate the output event, the value for the `temp` attribute must be taken from the `e2` (second) event, and the value for the `humid` attribute must be taken from the `e3` (third) event. 

6. To direct the output to the `StateNotificationStream` output stream so that it can be logged, add an `insert into` clause as follows.
    `insert into StateNotificationStream;`
    
The completed Siddhi application is as follows.

```
@App:name("RoomStateApp")

define stream TempStream(deviceID long, temp double);
define stream HumidStream(deviceID long, humid double);
define stream RegulatorStream(deviceID long, isOn bool);

@sink(type='log', prefix='RoomState]:')
define stream StateNotificationStream(temp double, humid double);

from every e1=RegulatorStream, e2=TempStream and e3=HumidStream
select e2.temp, e3.humid
insert into StateNotificationStream;
```

##Correlating two streams of data and unify

For a detailed explanation, see [Enriching Data - Enrich data by connecting with another stream of data](enriching-data.md#enrich-data-by-connecting-with-another-stream-of-data)

## Correlate a stream and a static datasource to enrich
For a detailed explanation, see [Enriching Data - Enrich data by connecting with a data store](enriching-data.md#enrich-data-by-connecting-with-a-data-store)
