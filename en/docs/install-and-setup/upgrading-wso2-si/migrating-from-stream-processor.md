# Migrating from WSO2 Stream Processor

The Streaming Integrator performs all functions that are also performed by [WSO2 Stream Processor](https://docs.wso2.com/display/SP440/Stream+Processor+Documentation). It also has additional features to trigger integration flows in order to take action in response to results derived after analyzing data.

If you are currently using WSO2 Stream Processor to carry out any streaming integration/stream processing activities and want to carry them out in the Streaming Integrator, you can migrate your setup as follows:

## Preparing to upgrade

The following prerequisites should be completed before upgrading.

- Make a backup of the SP 4.4.0 database and copy the <SP_HOME> directory in order to backup the product configurations.
- Download the [Streaming Integrator](https://wso2.com/integration/).

## Migrating databases

To connect the Streaming Integrator to the same databases as WSO2 SP 4.4.0 so that the persisted data can be accessed, configure the data sources as follows:

- Configure the data sources in the `<SI_HOME>/conf/server/deployment.yaml` file the same way you have configured them in `<SP_HOME>/conf/wso2/worker/deployment.yaml` file.
- Configure the data sources in the `<SI__TOOLING_HOME>/conf/server/deployment.yaml` file the same way you have configured them in `<SP_HOME>/conf/wso2/editor/deployment.yaml` file.
- Check the data source configured for Business Rules  in the `<SP_HOME>/conf/wso2/dashboard/deployment.yaml` file, and configure that data source with the same parameter values in the `<SI__TOOLING_HOME>/conf/server/deployment.yaml` file.

    !!!info
        The Business Rules feature which was a part of the `Dashboard` profile of the Stream Processor is now shipped with Streaming Integrator Tooling. Therefore, configurations related to this feature are added in the `<SI__TOOLING_HOME>/conf/server/deployment.yaml` file.

For the complete list of data sources configured for the Streaming Integrator, see [Configuring Data sources]({{base_path}}/install-and-setup/setup/si-setup/configuring-data-sources).

## Migrating Siddhi applications

To migrate the Siddhi applications that you have deployed in WSO2 SP 4.4.0, follow the procedure below:

1. Copy all the Siddhi applications in the `<SP_HOME/wso2/worker/deployment/siddhi-files` directory.

2. Place the Siddhi applications you copied in the `<SI_HOME/wso2/server/deployment/siddhi-files` directory.

## Testing the migration

Simulate a few events to the Siddhi applications deployed in the Streaming Integrator to test whether they are generating the expected results.