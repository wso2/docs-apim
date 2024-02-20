#  Configuring Git Integration

**WSO2 API Controller (apictl)** natively supports identifying APIs or any other types of projects in a Git repository and seamlessly deploying the changes of the projects to a given WSO2 API Manager (WSO2 API-M) environment. This topic is regarding some of the configurations that you can use to optimize the Git integration functionality.

## Enabling project deletion via Git integration

By default, API/Application/API Product deletion is disabled in apictl. In order to enable it, use the below `apictl set` command.

```bash
apictl set --vcs-deletion-enabled=true
```

After the project deletion is enabled, any deleted API/Application or API Product project from the Git repository is detected from the `apictl vcs deploy -e <environment>` command and those projects will be deleted from the particular environment as well.


!!! example
    ```bash
    $ apictl vcs deploy -e dev
    Deploying Projects (1)...

    APIs (1) ...
    1: PizzaShackAPI-1.0.0: (PizzaShackAPI-1.0.0) awaiting deletion..

    Deleting projects ..
    Switched to a new branch 'tmp-42b69a8c'

    APIs (1) ...
    1: PizzaShackAPI-1.0.0: (PizzaShackAPI-1.0.0)
    API deleted successfully!. Status: 200
    Switched to branch 'master'
    ```

## Externalizing the VCS configuration

apictl's Git integration feature uses a dedicated configuration file which is located in `/home/<user>/.wso2apictl/vcs_config.yaml`. 

The structure of the file is as per below:


``` tab="Format"
repos:
  <repoId1>: # This is coming from the "vcs.yaml" file (created via "apictl vcs init") of the Git repository.
    environments:
      <environment1>:
        lastAttemptedRev: <lastAttemptedGitCommitId>
        lastSuccessfulRev:
        - <lastSuccessfulGitCommitId> # This is equal to the <lastAttemptedGitCommitId>
        - <previousSuccessfulGitCommitId>
        - <..>
        failedProjects: {}
  <repoId2>:
    environments:
      <environment1>:
        ..
  <repoId3>:
    ..
...
```

``` tab="Example"
repos:
  99f6338f-24e0-42da-a69e-78aba98d0380:
    environments:
      dev:
        lastAttemptedRev: 7ef7911f197640b82b0c7f36f62f8b23d40d3bc1
        lastSuccessfulRev:
        - 7ef7911f197640b82b0c7f36f62f8b23d40d3bc1
        - 81b5a5f3998c1e04f6e37357b6e6bb09a1fe8fe6
        failedProjects: {}
  6815a6fa-a63c-4ff4-b690-7d85661bb187:
    environments:
      dev:
        lastAttemptedRev: 72925a149a6afa954d5a94dd79480adc4f812542
        lastSuccessfulRev:
        - 72925a149a6afa954d5a94dd79480adc4f812542
        - e8d2d308c6140f63c4eb5c0765ab79e4eee9aeb9
        - b4fed92fdac370b62b38eafcbc23c40382c5c277
        failedProjects: {}
```

Unlike the other configuration files inside `.wso2apictl`, `vcs_config.yaml` maintains a state for each repository. So it is mandatory to persist it during each `apictl vcs` command execution during each build cycle. In some container-based build systems, it might be difficult to keep this file persisted and make it available for each build cycle as it is required to enable volume mounts etc. It is also not advisable to persist/share the full `.wso2apictl` folder as it might include credentials. In such cases, an alternative approach would be to externalize the `vcs_config.yaml` into a different location where volume mounts or some persistence mechanism can be enabled for  `vcs_config.yaml` only.

```bash
apictl set --vcs-config-path <full-path-to-store-vcs_config.yaml>
```

!!! example
    ```bash
    $ apictl set --vcs-config-path /home/wso2/api-manager/gitconfigs
    VCS config file path is set to : /home/wso2/api-manager/gitconfigs
    ```

By setting the above, `apictl vcs deploy` command will create the `vcs_config.yaml` if it is not available in the specified path and reuse it for the succeeding commands.

!!! info
    - To learn about using apictl to deploy API Projects using a Git repository to different environments, refer the section [CI/CD with WSO2 API Manager]({{base_path}}/install-and-setup/setup/api-controller/ci-cd-with-wso2-api-management/).
