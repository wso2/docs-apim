# Managing Configurations across Environments

When you have multiple environments (Dev, QA, UAT, Prod), you need the flexibility of dynamically updating the configurations in each environment without replacing artifacts and configuration files. This applies to server configurations, which are defined in the `deployment.toml` file (stored in the `<MI_HOME>/conf` directory) and to synapse configurations in your integration artifacts (such as proxy service, endpoint artifacts, etc.)

## Managing Server Configurations

All the server configurations of the Micro Integrator are specified in a single
[TOML-based configuration file]({{base_path}}/reference/config-catalog-mi) (`deployment.toml` file). To be able to dynamically inject values, define your server configurations as environment variables or system properties. You can then separately inject configuration values to each environment.

You can define the server configurations in one of three ways based on your preference:

-	As [system properties](#system-properties)
-	As [environment variables](#environment-variables)
-	As [variables resolved during runtime](#variables-resolved-during-runtime)

Let's assume you want to set the server offset of your Micro Integrator instance.

### System properties

Use the following syntax in the `deployment.toml` file to specify a configuration as a system property:

```toml
parameter="$sys{systemPropertyName}"
```

**Example**:

In the following example, the value for the server offset parameter is specified by the `offset` system property.

```toml
[server]
offset = "$sys{offset}"
```

You can set the value for the `offset` system property during server startup. That is, when you execute the server startup command on your terminal, pass the system property value as shown below.

```bash
./micro-integrator.sh -Doffset=19
```

### Environment variables

Use the following syntax in the `deployment.toml` file to specify a configuration as an environment variable:

```toml
parameter="$env{environmentVariableName}"
```

**Example**:

In the following example, the value for the server offset parameter is specified by the `offset` variable.

```toml
[server]
offset = "$env{offset}"
```

You can now set the environment variables you defined as follows before starting the server:

```bash
export offset=22
```

### Variables resolved during runtime

As opposed to defining the configuration parameter as `$sys{property}` or `$env{variable}`, if you use the following syntax in the deployment.toml file, you can pass configurations and resolve them during runtime. That is, you do not have to restart the server for the parameter values to become effective.

```toml
offset = "${VariableName}"
```

**Example**:

In the following example, the value for the server offset parameter is specified by the `offset` variable.

```toml
[server]
offset = "${offset}"
```

You can set a value for the `offset` variable as an environment variable or a system property and it will be resolved during runtime. If you have set the value as both a system property and an environmental variable, the system property will be effective.

*System property > Environment variable*

### Docker/Kubernetes environments

When you update product configurations for a container deployment (Docker or Kubernetes), you will update the `deployment.toml` file from your Docker Exporter project or Kubernetes Exporter project in WSO2 Integration Studio.

You can open the `deployment.toml` file from the project explorer and update the parameter values as [system properties](#system-properties) or [environment variables](#environment-variables).

<img src="{{base_path}}/assets/img/integrate/env-variable-support/k8s-project-deployment-file.img" width="500">

When you execute the `docker run` command to start the container, you can pass the system properties and environment variables. These values will be resolved dynamically during the runtime.

## Managing Synapse Configurations

You can dynamically inject parameters to synapse configurations either using environment variables or a file (containing parameter values).

Read [Injecting Synapse Parameters]({{base_path}}/integrate/develop/injecting-parameters) for details.
