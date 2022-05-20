# Migrating from WSO2 Stream Processor

WSO2 Streaming Integrator (WSO2 SI) performs all functions that are also performed by [WSO2 Stream Processor](https://docs.wso2.com/display/SP440/Stream+Processor+Documentation) (WSO2 SP). It also has additional features to trigger integration flows in order to take action in response to results derived after analyzing data.

If you are currently using WSO2 Stream Processor to carry out any streaming integration/stream processing activities and want to carry them out in the Streaming Integrator, you can migrate your setup as follows:

## Before you begin

The following prerequisites should be completed before upgrading.

- Make a backup of the SP 4.4.0 database and copy the <SP_HOME> directory in order to backup the product configurations.
- Download the Streaming Integrator from the [Enterprise Integrator Home](https://wso2.com/integration/)

!!! info "Migrating Custom Siddhi Extensions"
    Note the following when migrating custom Siddhi extensions from WSO2 Stream Processor(SP) to WSO2 Streaming Integrator(SI).
    SP 4.x uses Siddhi 4.x and SI uses Siddhi 5.x from 1.x onwards. Therefore, the group ID and package names should be **renamed** from `org.wso2.siddhi` to `io.siddhi`

## Step 1 - Migrate the databases

You need to connect the Streaming Integrator to the same databases as WSO2 SP 4.4.0 so that the persisted data can be accessed. Configure the data sources as follows:

1. Configure the data sources in the `<SI_HOME>/conf/server/deployment.yaml` file in the same way that you have configured them in the `<SP_HOME>/conf/wso2/worker/deployment.yaml` file.
2. Configure the data sources in the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file in the same way that you have configured them in the `<SP_HOME>/conf/wso2/editor/deployment.yaml` file.
3. Check the data source configured for Business Rules in the `<SP_HOME>/conf/wso2/dashboard/deployment.yaml` file, and configure that data source with the same parameter values in the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file. 

    !!!info
        The Business Rules feature which was a part of the `Dashboard` profile of the Stream Processor is now shipped with Streaming Integrator Tooling. Therefore, configurations related to this feature are added in the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file.

For a complete list of data sources configured for the Streaming Integrator, see [Configuring Data sources](https://ei.docs.wso2.com/en/latest/streaming-integrator/setup/configuring-data-sources/).

## Step 2 - Migrate the Siddhi applications

To migrate the Siddhi applications that you have deployed in WSO2 SP 4.4.0, follow the procedure below:

1. Copy all the Siddhi applications in the `<SP_HOME>/wso2/worker/deployment/siddhi-files` directory.

2. Add the Siddhi applications that you copied in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

!!! note
    Note that some extensions are not packed by default when migrating from SP to SI. You can find these extensions in the `<SP_HOME>/lib` directory, and copy them as required.

## Step 3 - Test the migration

Simulate a few events to the Siddhi applications deployed in the Streaming Integrator to test whether they are generating the expected results.
