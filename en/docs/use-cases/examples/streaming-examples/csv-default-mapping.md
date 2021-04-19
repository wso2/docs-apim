# CSV Default Mapping

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to Publish and receive data events processed within Siddhi to files in CSV default format.

## Prerequisites:
* Edit the uri '{WSO2SIHome}/samples/artifacts/CSVMappingWithFile/new/example.csv' by replacing {WSO2SIHome} with the absolute path of your WSO2SP home directory. You can also change the path for 'file.uri' in the sink, if you want to publish your event file to a different location.

* Save this sample. If there is no syntax error, the following messages would be shown on the console:
    - CSVDefaultMapping.siddhi successfully deployed.

## Executing & testing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages are shown on the console:
    * CSVDefaultMapping.siddhi - Started Successfully!

## Viewing the Results:
* Source takes input from the '{WSO2SP-HOME}/samples/artifacts/CSVMappingWithFile/new/example.csv' then produce the event.
example.csv has data in below format<br/>
        1,WSO2,23.5<br/>
        2,IBM,2.5<br/>
* Sink takes input from source output and produces the output to outputOfCustom.csv in CSV custom format.
    outputOfCustom.csv's data appear in below format<br/>
        1,WSO2,100.0<br/>
        2,IBM,2.5<br/>
			
???info "Click here to view the sample Siddhi application."

    ```sql
    @App:name("CSVDefaultMapping")
    @App:description('Publish and receive data events processed within Siddhi to files in CSV default format.')


    @source(type='file',
    dir.uri='file://{WSO2SIHome}/samples/artifacts/CSVMappingWithFile/new',
    action.after.process='NONE',
    @map(type='csv'))
    define stream InputStream (id int, name string, amount double);

    @sink(type='file', file.uri='/{WSO2SIHome}/samples/artifacts/CSVMappingWithFile/new/outputOfDefault.csv' , @map(type='csv'))
    define stream OutputStream (id int, name string, amount double);

    from InputStream
    select *
    insert into OutputStream;
    ```