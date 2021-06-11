# Writing Custom Siddhi Extensions

Custom extensions can be written in order to apply use case specific logic that is not available in Siddhi out of the 
box or as an existing extension.

There are five types of Siddhi extensions that you can write to cater your specific use cases. These extension 
archetypes are explained below with their related maven archetypes. You can use these archetypes to generate maven projects
for each extension type.

## siddhi-execution

Siddhi-execution provides following extension types:

- Function
- Aggregate Function
- Stream Function
- Stream Processor
- Window

You can use one or more from above mentioned extension types and
implement according to your requirement. For more information about
these extension types, see [Siddhi Query Guide -
Extensions](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#extensions).

To install and implement the siddhi-io extension archetype, follow the
procedure below:

1. Issue the following command from your CLI.
   ``` java
   mvn archetype:generate
       -DarchetypeGroupId=org.wso2.siddhi.extension.archetype
       -DarchetypeArtifactId=siddhi-archetype-execution
       -DarchetypeVersion=1.0.1
       -DgroupId=org.wso2.extension.siddhi.execution
       -Dversion=1.0.0-SNAPSHOT
   ```

2. Enter the required execution name in the message that pops up as shown in the example below.  
    `Define value for property 'executionType': ML`
3. To confirm that all property values are correct, type `Y` in the console. If not, press `N`.
4. Once you perform the above steps, a skeleton source code is created. You need to update this with the relevant 
   extension logic. Then build the source code and place the build extension jar in the `<SI_HOME>/lib` directory.

## siddhi-io

Siddhi-io provides following extension types:

- sink
- source

You can use one or more from above mentioned extension types and implement according to your requirement. siddhi-io is 
generally used to work with IO operations as follows:

- The Source extension type gets inputs to your Siddhi application.
- The Sink extension publishes outputs from your Siddhi application.

For more information about these extension types, see [Siddhi Query Guide - Extensions](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#extensions).

To implement the siddhi-io extension archetype, follow the procedure below:

1. Issue the following command from your CLI.

   ``` java
    mvn archetype:generate
      -DarchetypeGroupId=org.wso2.siddhi.extension.archetype
      -DarchetypeArtifactId=siddhi-archetype-io
      -DarchetypeVersion=1.0.1
      -DgroupId=org.wso2.extension.siddhi.io
      -Dversion=1.0.0-SNAPSHOT
   ```

2. Enter the required execution name in the message that pops up as shown in the example below.  
   `Define value for property 'typeOf_IO': http`

3. To confirm that all property values are correct, type `Y` in the console. If not, press `N`.

4. Once you perform the above steps, a skeleton source code is created. You need to update this with the relevant 
   extension logic. Then build the source code and place the build extension jar in the `<SI_HOME>/lib` directory.

## siddhi-map

Siddhi-map provides following extension types:

- Sink Mapper
- Source Mapper

You can use one or more from above mentioned extension types and implement according to your requirement as follows.

- The Source Mapper maps events to a predefined data format (such as XML, JSON, binary, etc), and publishes them to 
  external endpoints(such as E-mail, TCP, Kafka, HTTP, etc).
- The Sink Mapper also maps events to a predefined data format, but it does it at the time of publishing events from a 
  Siddhi application.

For more information about these extension types, see [Siddhi Query Guide - Extensions](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#extensions).

To implement the siddhi-map extension archetype, follow the procedure below:

1. Issue the following command from your CLI.
   ``` java
   mvn archetype:generate
       -DarchetypeGroupId=org.wso2.siddhi.extension.archetype
       -DarchetypeArtifactId=siddhi-archetype-map
       -DarchetypeVersion=1.0.1
       -DgroupId=org.wso2.extension.siddhi.map
       -Dversion=1.0.0-SNAPSHOT
   ```

2. Enter the required execution name in the message that pops up as shown in the example below.  
    `Define value for property 'typeOf_IO': http`

3. To confirm that all property values are correct, type `Y` in the console. If not, press `N`.

4. Once you perform the above steps, a skeleton source code is created. You need to update this with the relevant 
   extension logic. Then build the source code and place the build extension jar in the `<SI_HOME>/lib` directory.

## siddhi-script

Siddhi-script provides the `Script` extension type.

The script extension type allows you to write functions in other programming languages and execute them within Siddhi 
queries. Functions defined via scripts can be accessed in queries similar to any other inbuilt function.

For more information about these extension types, see [Siddhi Query Guide - Extensions](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#extensions).

To implement the siddhi-script extension archetype, follow the procedure below:

1. Issue the following command from your CLI.

   ``` java
   mvn archetype:generate
       -DarchetypeGroupId=org.wso2.siddhi.extension.archetype
       -DarchetypeArtifactId=siddhi-archetype-script
       -DarchetypeVersion=1.0.1
       -DgroupId=org.wso2.extension.siddhi.script
       -Dversion=1.0.0-SNAPSHOT
   ```

2. Enter the required execution name in the message that pops up as shown in the example below.  
   `Define value for property 'typeOfScript':`

3. To confirm that all property values are correct, type `Y ` in the console. If not, press `N`.

4. Once you perform the above steps, a skeleton source code is created. You need to update this with the relevant 
   extension logic. Then build the source code and place the build extension jar in the `<SI_HOME>/lib` directory.

## siddhi-store

Siddhi-store provides the `Store` extension type.

The Store extension type allows you to work with data/events stored in various data stores through the table abstraction.

For more information about these extension types, see [Siddhi Query Guide - Extensions](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#extensions).

To implement the siddhi-store extension archetype, follow the procedure below:

1. Issue the following command from your CLI.
   ``` java
   mvn archetype:generate
      -DarchetypeGroupId=org.wso2.siddhi.extension.archetype
      -DarchetypeArtifactId=siddhi-archetype-store
      -DarchetypeVersion=1.0.1
      -DgroupId=org.wso2.extension.siddhi.store
      -Dversion=1.0.0-SNAPSHOT
   ```

2. Enter the required execution name in the message that pops up as shown in the example below.  
   `Define value for property 'storeType': RDBMS`
3. To confirm that all property values are correct, type `Y` in the console. If not, press `N`.

4. Once you perform the above steps, a skeleton source code is created. You need to update this with the relevant 
   extension logic. Then build the source code and place the build extension jar in the `<SI_HOME>/lib` directory.
