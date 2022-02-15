# Git Integration for Choreo Connect

The following section provides information on how to integrate Choreo Connect with Git for version controlling of API artifacts.

## Overview

When Choreo Connect is used as a [standalone gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway), APIs can be deployed through the APICTL command-line tool. Once an API project is added/updated, it must be deployed/redeployed using APICTL. If the Adapter container restarts for any reason, the APIs deployed with APICTL will be lost. To address this requirement, Choreo Connect supports the use of Git for version controlling of API artifacts.

The source watcher in the Adapter, is responsible for deploying the API artifacts, with the help of Git. Initially, it is required to have a repository with the API projects, hosted on a source control system (E.g. GitHub, Bitbucket). When the Adapter starts, the source watcher will clone the API project(s) from the given repository and will deploy the API artifacts. The source watcher will then start polling the repository for changes. If there are any updates in the repository, the source watcher will fetch the changes and will deploy the updated API artifacts.

[![Git Integration]({{base_path}}/assets/img/deploy/mgw/git-integration.png)]({{base_path}}/assets/img/deploy/mgw/git-integration.png)
<!-- {: style="width:60%"} -->

## Configuring Git Integration for Choreo Connect
The following steps will describe how to configure Git Integration for Choreo Connect.

### Step 1 - Initialize Git repository
After initializing API project(s) as described in the [Choreo Connect Deployed on Docker with WSO2 API Controller Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-docker/#step-2-initialize-an-api-project), create a new repository on any of the following Git hosting services: <!--supported Git hosting service. -->

- [GitHub](https://github.com)
- [Bitbucket](https://bitbucket.org)
- [GitLab](https://gitlab.com)

!!! note
        Push the API project(s) to the repository in the following folder structure:

    ```java
    <api-project-1>
    ├── Client-certificates
    ├── Definitions
    │   └── swagger.yaml
    ├── Docs
    ├── Endpoint-certificates
    ├── Image
    ├── Interceptors
    ├── README.md
    ├── Sequences
    │   ├── fault-sequence
    │   ├── in-sequence
    │   └── out-sequence
    ├── api.yaml
    ├── api_meta.yaml
    └── libs
    <api-project-2>
    ├── Client-certificates
    ├── Definitions
    │   └── swagger.yaml
    ├── Docs
    ├── Endpoint-certificates
    ├── Image
    ├── Interceptors
    ├── README.md
    ├── Sequences
    │   ├── fault-sequence
    │   ├── in-sequence
    │   └── out-sequence
    ├── api.yaml
    ├── api_meta.yaml
    └── libs
    <api-project-3>.zip
    ```
### Step 2 - Configure Choreo Connect with Git

Add the following configuration under the Adapter section to the main configuration file of Choreo Connect (`config.toml` file).

```
[adapter]

artifactsDirectory = "/home/wso2/git-artifacts"

[adapter.sourceControl]
  enabled = true
  pollInterval = 30
  retryInterval = 5
  artifactsDirectory = "/home/wso2/git-artifacts"
  [adapter.sourceControl.repository]
    URL = "https://<hostname>/<username>/<repository-name>.git"
    branch = "main"
    username = "username"
    accessToken = $env{git_access_token}
    sshKeyFile = "/home/wso2/ssh-keys/<private_key_file>"
```

The following table describes the above configuration.

|<div style="width:100px">Property</div>| Description                                                                    |
|---------------------------------------|--------------------------------------------------------------------------------|
| `enabled`                             | Set this to `true` to enable Git integration for API Artifacts. |
| `pollInterval`                        | The time interval (in seconds) in which the the Adapter should fetch updates from the repository.|
| `retryInterval`                       | The time interval (in seconds) in which the the Adapter should retry fetching artifacts from the repository at startup (in case of failure).|
| `artifactsDirectory`                  | The directory path where the Git artifacts are stored.|
| `URL`                                 | The `URL` of the Git repository.|
| `branch`                              | The branch of the Git repository. If not specified, the default branch will be used.|
| `username`                            | The username of the Git repository. If this is set, then you need to also set `accessToken`.|
| `accessToken`                         | The password or personal access token of the Git repository.|
| `sshKeyFile`                          | sshKeyFile is the optional path to the private key used for authenticating the Git repository. If this is set, then you do not need to set `username` and `accessToken`.|

!!! note
        - Both `artifactsDirectory` configurations should be set to the same directory path.
        - If the `branch` is not specified, the default branch will be used.
        - If the repository is a public repository (in GitHub), then you do not need to set `username`, `accessToken` and `sshKeyFile`.
        - If the repository is a private repository, then you need to set either `username` and `accessToken` or `sshKeyFile`.

The source watcher needs to be authenticated with the Git repository to fetch the artifacts. Authenticating the Git repository can be done in the following ways:

- [Using Username and Access Token]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/git-integration/#using-username-and-access-token)
- [Using SSH Key file]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/git-integration/#using-ssh-key-file)

#### Using Username and Access Token

To authenticate the repository with basic HTTP authentication, the username and access token should be set in the `username` and `accessToken` fields. The password can also be set in the `accessToken` field. It is recommended to use the personal access token for authentication. For public repositories (in GitHub), the `username` and `accessToken` fields can be kept empty.

A personal access token can be generated in the following ways:

- [Creating a personal access token - GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [Creating a personal access token - Bitbucket](https://confluence.atlassian.com/bitbucketserver/personal-access-tokens-939515499.html)
- [Creating a personal access token - GitLab](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)

Then, the following configuration should be added to the main configuration file of Choreo Connect (`config.toml` file):

```
[adapter]

artifactsDirectory = "/home/wso2/git-artifacts"

[adapter.sourceControl]
  enabled = true
  pollInterval = 30
  retryInterval = 5
  artifactsDirectory = "/home/wso2/git-artifacts"
  [adapter.sourceControl.repository]
    URL = "https://<hostname>/<username>/<repository-name>.git"
    branch = ""
    username = "username"
    accessToken = $env{git_access_token}
    sshKeyFile = ""
```

#### Using SSH Key file

To authenticate the repository with SSH key, the SSH private key file path should be set in the `sshKeyFile` field. 

SSH Keys to be used for authentication can be generated in the following ways:

- [Generating SSH keys - GitHub](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Generating SSH keys - Bitbucket](https://support.atlassian.com/bitbucket-cloud/docs/set-up-an-ssh-key)
- [Generating SSH keys - GitLab](https://docs.gitlab.com/ee/ssh)

!!! Important
    Make sure to keep the passphrase of the SSH key empty.

Then, the following configuration should be added to the main configuration file of Choreo Connect (`config.toml` file):

```
[adapter]

artifactsDirectory = "/home/wso2/git-artifacts"

[adapter.sourceControl]
  enabled = true
  pollInterval = 30
  retryInterval = 5
  artifactsDirectory = "/home/wso2/git-artifacts"
  [adapter.sourceControl.repository]
    URL = "git@<hostname>:<username>/<repository-name>.git"
    branch = ""
    username = ""
    accessToken = ""
    sshKeyFile = "/home/wso2/ssh-keys/<private_key_file>"

```
The generated private key file needs to be copied to `docker-compose/resources/adapter/ssh-keys` directory.

Open the `docker-compose.yaml` file located in the `<CHOREO-CONNECT-HOME>/docker-compose/choreo-connect` directory. Find the `volumes` section under the `adapter` and add the following volume mapping:

``` yml
volumes:
    ...
    - ../resources/adapter/ssh-keys:/home/wso2/ssh-keys
```

When using authentication with SSH key file, you should create a custom Docker image of the Adapter. To create a custom Docker image, follow the steps below:

Create a Dockerfile as follows.

```dockerfile tab='Example'
FROM wso2/choreo-connect-adapter:1.1.0

USER root

RUN apk add openssh-client

RUN mkdir /home/wso2/.ssh && chown -R wso2:wso2 /home/wso2/.ssh \
    && ssh-keyscan -H github.com gitlab.com bitbucket.org >> /home/wso2/.ssh/known_hosts

USER wso2

CMD eval "$(ssh-agent -s)" ; ssh-add /home/wso2/ssh-keys/* ; ./adapter
```

Build the new image.

```bash tab='Format'
docker build -t <IMAGE_NAME> -f <DOCKER_FILE_PATH> <CONTEXT>
```

```bash tab='Example'
docker build -t myimages/choreo-connect-adapter-ssh:1.0.0 -f Dockerfile .
```

Update the `docker-compose.yaml` file with the new Adapter image.

### Step 3 - Start Choreo Connect

Start Choreo Connect on Docker by executing the Docker Compose script inside the `CHOREO-CONNECT_HOME`. Navigate to `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/` and execute the following command.

{!includes/deploy/cc-tryout-in-arm64-docker-note.md!}

``` java
docker-compose up -d
```

Once containers are up and running, we can monitor the status of the containers using the following command
    ``` java
    docker ps | grep choreo-connect-
    ```
### Step 4 - Invoke the sample API
{! ./includes/obtain-jwt.md !}
{! ./includes/invoke-api-with-jwt.md !}