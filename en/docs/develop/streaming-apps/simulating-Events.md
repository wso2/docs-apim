# Simulating Events

Simulating events involves simulating predefined event streams. These
event stream definitions have stream attributes. You can use event
simulator to create events by assigning values to the defined stream
attributes and send them as events. This is useful for debugging and
monitoring the event receivers and publishers, execution plans and event
formatters.

<table>
<thead>
<tr class="header">
<th>Function</th>
<th>REST API</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Saving a simulation configuration</td>
<td><ul>
<li><strong>Single Event Simulation</strong> : <code>               POST               http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/single              </code></li>
<li><strong>Multiple Event Simulation:</strong> <code>               POST               http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/feed              </code><br />
</li>
</ul></td>
</tr>
<tr class="even">
<td>Editing a simulation configuration</td>
<td><ul>
<li><strong>Single Event Simulation</strong> : <code>               PUT               http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/single              </code></li>
<li><strong>Multiple Event Simulation:</strong> <code>               PUT               http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/feed              </code></li>
</ul></td>
</tr>
<tr class="odd">
<td>Deleting a simulation configuration</td>
<td><ul>
<li><strong>Single Event Simulation</strong> : <code>               DELETE               http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/single              </code></li>
<li><strong>Multiple Event Simulation:</strong> <code>               DELETE http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/feed              </code></li>
</ul></td>
</tr>
<tr class="even">
<td>Retrieving a simulation configuration</td>
<td><ul>
<li><strong>Single Event Simulation</strong> : <code>               GET               http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/single              </code></li>
<li><strong>Multiple Event Simulation:</strong> <code>               GET http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/feed              </code></li>
</ul></td>
</tr>
<tr class="odd">
<td>Uploading a CSV file</td>
<td><code>                           POST http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/feed             </code></td>
</tr>
<tr class="even">
<td>Editing and uploaded CSV file</td>
<td><code>                           PUT -F 'file=@/{path to csv file}' http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/files/{fileName}?fileName={fileName}             </code></td>
</tr>
<tr class="odd">
<td>Deleting an uploaded CSV file</td>
<td><code>             DELETE http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/files/{fileName}            </code></td>
</tr>
<tr class="even">
<td>Pausing an event simulation</td>
<td><code>             POST             http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/             simulation/feed/{simulationName}/?action=pause            </code></td>
</tr>
<tr class="odd">
<td>Resuming an event simulation</td>
<td><code>             POST             http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/             simulation/feed/{simulationName}/?action=resume            </code></td>
</tr>
<tr class="even">
<td>Stopping an event simulation</td>
<td><code>             DELETE http://&lt;SP_HOST&gt;:&lt;API_PORT&gt;/simulation/feed/{simulationName}            </code></td>
</tr>
</tbody>
</table>

  

The following sections cover how events can be simulated.

-   [Saving a simulation
    configuration](#SimulatingEvents-Savingasimulationconfiguration)
-   [Editing a simulation
    configuration](#SimulatingEvents-Editingasimulationconfiguration)
-   [Deleting a simulation
    configuration](#SimulatingEvents-Deletingasimulationconfiguration)
-   [Retrieving a simulation
    configuration](#SimulatingEvents-Retrievingasimulationconfiguration)
-   [Uploading a CSV file](#SimulatingEvents-UploadingaCSVfile)
-   [Editing an uploaded CSV
    file](#SimulatingEvents-EditinganuploadedCSVfile)
-   [Deleting an uploaded CSV
    file](#SimulatingEvents-DeletinganuploadedCSVfile)
-   [Pausing an event
    simulation](#SimulatingEvents-Pausinganeventsimulation)
-   [Resuming an event
    simulation](#SimulatingEvents-Resuminganeventsimulation)
-   [Stopping an event
    simulation](#SimulatingEvents-Stoppinganeventsimulation)

### Saving a simulation configuration

To simulate events for WSO2 SP, you should first save the event
simulator configuration in the
`         <SP_HOME>/deployment/simulator/simulationConfigs        `
directory by sending a POST request to a REST API as described below.

#### REST API

The REST API to be called depends on the type of event simulation you
are carrying out as shown in the table below.

| Event Simulation Type        | REST API                                                                                                           |
|------------------------------|--------------------------------------------------------------------------------------------------------------------|
| Simulating a single event    | `             POST             http://<SP_HOST>:<API_PORT>/simulation/single            `                          |
| Simulating a multiple events | `             POST             http://             <SP_HOST>:<API_PORT>             /simulation/feed/            ` |

#### Sample cURL command

``` java
    curl -X POST \
      http://localhost:9390/simulation/feed/ \
      -H 'content-type: text/plain' \
      -d '{
      "properties": {
        "simulationName": "simulationPrimitive",
        "startTimestamp": "",
        "endTimestamp": "",
        "noOfEvents": "",
        "description": "",
        "timeInterval": "1000"
      },
      "sources": [
        {
          "siddhiAppName": "TestExecutionPlan",
          "streamName": "FooStream",
          "timestampInterval": "1000",
          "simulationType": "RANDOM_DATA_SIMULATION",
          "attributeConfiguration": [
            {
              "type": "PRIMITIVE_BASED",
              "primitiveType": "STRING",
              "length": "5"
            },
            {
              "type": "PRIMITIVE_BASED",
              "primitiveType": "INT",
              "min": "0",
              "max": "999"
            }
          ]
        }
      ]
    }'
```

  

#### Sample output

    {
      "status": "CREATED",
      "message": "Successfully uploaded simulation configuration 'simulationPrimitive'"
    }

#### REST API response

-   200 if the simulation configuration is successfully saved.
-   409 if a simulation configuration with the specified name already
    exists.
-   400 if the configuration provided is not in a valid JSON format.

For descriptions of the HTTP status codes, see [HTTP Status
Codes](https://docs.wso2.com/display/DAS310/HTTP+Status+Codes) .

### Editing a simulation configuration

To edit a simulation configuration that is already saved, a PUT request
should be sent to a REST API as explained below.

#### REST API

The REST API to be called depends on the type of event simulation you
are carrying out as shown in the table below.

| Event Simulation Type        | REST API                                                                                                                        |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| Simulating a single event    | `             PUT             http://<SP_HOST>:<API_PORT>/simulation/single            `                                        |
| Simulating a multiple events | `             PUT             http://<SP_HOST>:                           <API_PORT>             ` /simulation/feed/{feed name} |

#### Sample cURL command

``` java
    curl -X PUT \
      http://localhost:9390/simulation/feed/simulationPrimitive \
      -H 'content-type: text/plain' \
      -d '{
      "properties": {
        "simulationName": "updatedSimulationPrimitive",
        "startTimestamp": "",
        "endTimestamp": "",
        "noOfEvents": "10",
        "description": "Updating the simulation configuration",
        "timeInterval": "1000"
      },
      "sources": [
        {
          "siddhiAppName": "TestExecutionPlan",
          "streamName": "FooStream",
          "timestampInterval": "1000",
          "simulationType": "RANDOM_DATA_SIMULATION",
          "attributeConfiguration": [
            {
              "type": "PRIMITIVE_BASED",
              "primitiveType": "STRING",
              "length": "5"
            },
            {
              "type": "PRIMITIVE_BASED",
              "primitiveType": "INT",
              "min": "0",
              "max": "999"
            }
          ]
        }
      ]
    
    }'
```

#### Sample output

    {
      "status": "OK",
      "message": "Successfully updated simulation configuration 'simulationPrimitive'."
    }

#### REST API response

-   200 if the simulation configuration is successfully updated.
-   404 if the file specified does not exist in the
    `          <SP_HOME>/wso2/editor/deployment/simulation-configs         `
    directory.
-   400 if the file specified is not a CSV file, or if the file does not
    exist in the path specified.
-   403 if the size of the file specified exceeds the maximum size
    allowed.

For descriptions of the HTTP status codes, see [HTTP Status
Codes](https://docs.wso2.com/display/DAS310/HTTP+Status+Codes) .

### Deleting a simulation configuration

To delete an event simulation file that is already saved in the
`         <SP_HOME>/wso2/editor/deployment/simulation-configs        `
directory, a DELETE request should be sent to a REST API as explained
below.

#### REST API

The REST API to be called depends on the type of event simulation you
are carrying out as shown in the table below.

| Event Simulation Type        | REST API                                                                                                                                               |
|------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| Simulating a single event    | `             DELETE             http://<SP_HOST>:<API_PORT>/simulation/single            `                                                            |
| Simulating a multiple events | `             DELETE             http://                           <SP_HOST>             ` : `              <API_PORT>             ` /simulation/feed/ |

#### Sample cURL command

``` java
    curl -X DELETE 'http://localhost:9390/simulation/feed/simulationPrimitive'
```

#### Sample output

    {
      "status": "OK",
      "message": "Successfully deleted simulation configuration 'simulationPrimitive'"
    }

#### REST API response

-   200 if the simulation configuration is successfully deleted.
-   404 if the file specified does not exist in the
    `          <SP_HOME>/wso2/editor/deployment/simulation-configs         `
    directory.

For descriptions of the HTTP status codes, see [HTTP Status
Codes](https://docs.wso2.com/display/DAS310/HTTP+Status+Codes) .

### Retrieving a simulation configuration

To view a simulation configuration saved in the
`         <SP_HOME>/wso2/editor/deployment/simulation-configs        `
directory via the CLI, a GET request should be sent to a REST API as
explained below.

#### REST API

The REST API to be called depends on the type of event simulation you
are carrying out as shown in the table below.

| Event Simulation Type        | REST API                                                                                                             |
|------------------------------|----------------------------------------------------------------------------------------------------------------------|
| Simulating a single event    | `             GET             http://<SP_HOST>:<API_PORT>/simulation/single            `                             |
| Simulating a multiple events | `             GET             http://                           <SP_HOST>:<API_PORT>             ` /simulation/feed/ |

#### Sample cURL command

``` java
    curl -X GET 'http://localhost:9390/simulation/feed/simulationPrimitive'
```

#### Sample output

    {
      "status": "OK",
      "message": "{\"Simulation configuration\":{\"sources\":[{\"timestampInterval\":\"1000\",\"simulationType\":\"RANDOM_DATA_SIMULATION\",\"attributeConfiguration\":[{\"length\":\"5\",\"type\":\"PRIMITIVE_BASED\",\"primitiveType\":\"STRING\"},{\"min\":\"0\",\"max\":\"999\",\"type\":\"PRIMITIVE_BASED\",\"primitiveType\":\"INT\"}],\"streamName\":\"FooStream\",\"siddhiAppName\":\"TestExecutionPlan\"}],\"properties\":{\"simulationName\":\"simulationPrimitive\",\"description\":\"Updating the simulation configuration\",\"timeInterval\":\"1000\",\"endTimestamp\":\"\",\"startTimestamp\":\"\",\"noOfEvents\":\"10\"}}}"
    }

#### REST API Response

-   200 if the simulation configuration is successfully retrieved.
-   404 if the file specified does not exist in the
    `          <SP_HOME>/wso2/editor/deployment/simulation-configs         `
    directory.

For descriptions of the HTTP status codes, see [HTTP Status
Codes](https://docs.wso2.com/display/DAS310/HTTP+Status+Codes) .

### Uploading a CSV file

To simulate events from a CSV file, the required CSV file needs to exist
in the \<SP\_HOME\>/wso2/editor/deployment/csv-files directory.

#### REST API

A POST request should be sent to the following API.

`         POST http://<SP_HOST>:<API_PORT>/simulation/feed        `

#### Sample cURL command

``` java
    curl -X POST \
      http://localhost:9390/simulation/feed/ \
      -H 'content-type: text/plain' \
      -d '{
      "properties": {
        "simulationName": "FeedSimulationTest",
        "startTimestamp": "",
        "endTimestamp": "",
        "noOfEvents": "",
        "description": "",
        "timeInterval": "1000"
      },
      "sources": [
        {
          "siddhiAppName": "TestExecutionPlan",
          "streamName": "FooStream",
          "timestampInterval": "1000",
          "simulationType": "CSV_SIMULATION",
          "fileName": "myEvents.csv",
          "delimiter": ",",
          "isOrdered": true,
          "indices": "0,1"
        }
      ]
    }'
```

#### Sample output

    {
      "status": "CREATED",
      "message": "Successfully uploaded simulation configuration 'FeedSimulationTest'"
    }

#### REST API response

-   200 if the CSV file is successfully uploaded.
-   409 if a CSV file with the file name specified already exists in the
    \<SP\_HOME\>/wso2/editor/deployment/csv-files directory.
-   400 if the specified file is not a CSV file or if the specified file
    path is not valid.
-   403 if the size of the file specified exceeds the maximum file size
    allowed.

For descriptions of the HTTP status codes, see [HTTP Status
Codes](https://docs.wso2.com/display/DAS310/HTTP+Status+Codes) .

### Editing an uploaded CSV file

This section explains how to edit a CSV file that is already uploaded to
the `         <SP_HOME>/wso2/editor/deployment/csv-files        `
directory.

#### REST API

A PUT request should be sent to the following API.

`         PUT -F 'file=@/{path to csv file}' http://<SP_HOST>:<API_PORT>/simulation/files/{fileName}?fileName={fileName}        `

#### Sample cURL command

``` java
    curl -X PUT -F 'file=@/home/nadeeka/Desktop/editedMyEvents.csv' http://localhost:9390/simulation/files/myEvents.csv?fileName=myEvents.csv
```

#### Sample output

    {
      "status": "OK",
      "message": "Successfully updated CSV file 'myEvents.csv' with file ' editedMyEvents.csv'."
    }

#### REST API response

-   200 if the CSV file is successfully updated.
-   404 if the specified CSV file does not exist in the
    `          <SP_HOME>/deployment/simulator/csvFiles         `
    directory.

For descriptions of the HTTP status codes, see [HTTP Status
Codes](https://docs.wso2.com/display/DAS310/HTTP+Status+Codes) .

### Deleting an uploaded CSV file

This section explains how to delete a CSV file that is already uploaded
to the `         <SP_HOME>/wso2/editor/deployment/csv-files        `
directory.

#### REST API

A DELETE request should be sent to the following API.

`         DELETE http://<SP_HOST>:<API_PORT>/simulation/files/{fileName}        `

#### Sample cURL command

``` java
    curl -X DELETE http://localhost:9390/simulation/files/myEvents.csv
```

#### Sample output

    {
      "status": "OK",
      "message": "Successfully deleted file 'myEvents.csv'"
    }

#### REST API response

-   200 if the CSV file is successfully deleted.
-   404 if the specified CSV file does not exist in the
    `          <SP_HOME>/wso2/editor/deployment/csv-files         `
    directory.

### Pausing an event simulation

This section explains how to pause an event simulation that has already
started.

#### REST API

A POST request should be sent to the following API.

`         POST http://<SP_HOST>:<API_PORT>/simulation/feed/{simulationName}/?action=pause        `

#### Sample cURL command

``` java
    curl -X POST http://localhost:9390/simulation/feed/simulationPrimitive/?action=pause
```

#### Sample output

    {
      "status": "OK",
      "message": "Successfully paused event simulation 'simulationPrimitive'."
    }

#### REST API response

-   200 if the event simulation is successfully paused.
-   409 if the event simulation is already paused.

### Resuming an event simulation

This section explains how to resume an event simulation that has already
paused.

#### REST API

A POST request should be sent to the following API

`         POST http://<SP_HOST>:<API_PORT>/simulation/feed/{                   simulationName         `
}/?action=resume

#### Sample cURL command

``` java
    curl -X POST http://localhost:9390/simulation/feed/simulationPrimitive/?action=resume
```

#### Sample output

    {
      "status": "OK",
      "message": "Successfully resumed event simulation 'simulationPrimitive'."
    }

#### REST API response

-   200 if the event simulation is successfully resumed.

### Stopping an event simulation

This section explains how to stop an event simulation.

#### REST API

A POST request should be sent to the following API

`         POST http://<SP_HOST>:<API_PORT>/simulation/feed/{                   simulationName         `
}/?action=stop

#### Sample cURL command

``` java
    curl -X POST http://localhost:9390/simulation/feed/simulationPrimitive/?action=stop
```

#### Sample output

    {
      "status": "OK",
      "message": "Successfully stopped event simulation 'simulationPrimitive'."
    }

#### REST API response

-   200 if the event simulation is successfully stoped.
