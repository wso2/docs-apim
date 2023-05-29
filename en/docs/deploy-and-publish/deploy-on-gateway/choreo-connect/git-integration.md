# Git Integration for Choreo Connect

The following section provides information on how to integrate Choreo Connect with Git for version controlling of API artifacts.

When Choreo Connect is used as a [standalone gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway), APIs can be deployed through the APICTL command-line tool. Once an API project is added/updated, it must be deployed/redeployed using APICTL. If the Adapter container restarts for any reason, the APIs deployed with APICTL will be lost. To address this requirement, Choreo Connect supports the use of Git for version controlling of API artifacts.

## How it works

The source watcher in the Adapter, is responsible for deploying the API artifacts, with the help of Git based to the following steps.

[![Git Integration]({{base_path}}/assets/img/deploy/mgw/git-integration.png)]({{base_path}}/assets/img/deploy/mgw/git-integration.png)

1. You need to have a repository with the API projects, hosted on a source control system (e.g., GitHub, Bitbucket). 

2. When the Adapter starts, the source watcher will clone the API project(s) from the given repository and will deploy the API artifacts. 

3. The source watcher will then start polling the repository for changes. 

4. If there are any updates in the repository, the source watcher will fetch the changes and will deploy the updated API artifacts.

## Configuring Git Integration for Choreo Connect

Follow the instructions below to configure Git Integration for Choreo Connect:

### Step 1 - Initialize Git repository

1. Initialize the API project(s).
     
     For more information, see [Choreo Connect Deployed on Docker with WSO2 API Controller Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-docker/#step-2-initialize-an-api-project).
     
2. Create a new repository on any of the following Git hosting services.

     - [GitHub](https://github.com)
     - [Bitbucket](https://bitbucket.org)
     - [GitLab](https://gitlab.com)

    !!! note
        Maintain the following folder structure when pushing the API project(s) to the repository.

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

Git Integration in Choreo Connect works in the standalone mode.

#### Step 2.1 - Enable Git for version controlling of API artifacts

Add the following configuration under the Adapter section of the main configuration file of Choreo Connect (`config.toml` file) to enable Git for version controlling of API artifacts.

```toml tab="Format"
[adapter]

artifactsDirectory = "<path_to_the_artifacts_directory>"

[adapter.sourceControl]
  enabled = true
  pollInterval = 30
  retryInterval = 5
  maxRetryCount = 20
  artifactsDirectory = "<path_to_the_artifacts_directory>"
  [adapter.sourceControl.repository]
    URL = "https://<hostname>/<username_or_organization>/<repository-name>.git"
    branch = "<branch_name>"
    username = $env{git_username}
    accessToken = $env{git_access_token}
    sshKeyFile = "/home/wso2/ssh-keys/<private_key_file>"
```

```toml tab="Example"
[adapter]

artifactsDirectory = "/home/wso2/git-artifacts"

[adapter.sourceControl]
  enabled = true
  pollInterval = 30
  retryInterval = 5
  maxRetryCount = 20
  artifactsDirectory = "/home/wso2/git-artifacts"
  [adapter.sourceControl.repository]
    URL = "https://github.com/wso2/product-microgateway.git"
    branch = "main"
    username = $env{git_username}
    accessToken = $env{git_access_token}
    sshKeyFile = "/home/wso2/ssh-keys/id_ed25519"
```

The following table describes the above configuration.

<table>
<tr>
<th><b>Property</b></th>
<th><b>Description</b></th>
</tr>
<tr>
<td><code>enabled</code></td>
<td>Set this to <code>true</code> to enable Git integration for API Artifacts.</td>
<tr><td><code>pollInterval</code></td>
<td>The time interval (in seconds) in which the the Adapter should fetch updates from the repository.</td>
</tr>
<tr><td><code>retryInterval</code></td>                   
<td>The time interval (in seconds) in which the the Adapter should retry fetching artifacts from the repository at startup (in case of failure).
</td>
</tr>
<tr><td><code>maxRetryCount</code> </td>                      
<td>Maximum number of times the Adapter should retry fetching artifacts from the repository at startup (in case of failure).</td></tr>
<tr><td style="white-space: nowrap;">
<code>artifactsDirectory</code></td>                 
<td>The directory path where the Git artifacts are stored.</td></tr>
<tr><td><code>URL</code></td>                              
<td>The <code>URL</code> of the Git repository.</td></tr>
<tr><td><code>branch</code></td>                      
<td>The branch of the Git repository. If not specified, the default branch will be used.</td></tr>
<tr><td><code>username</code></td>                  
<td>The username of the Git repository. If this is set, then you need to also set the <code>accessToken</code>.</td></tr>
<tr><td><code>accessToken</code></td>                      
<td>The password or personal access token of the Git repository.</td></tr>
<tr><td><code>sshKeyFile</code></td>        
<td><code>sshKeyFile</code> is the optional path to the private key used for authenticating the Git repository. If this is set, then you do not need to set the <code>username</code> and <code>accessToken</code>.</td></tr>
</table>

!!! note
    - Both `artifactsDirectory` configurations should be set to the same directory path.
    - If the `branch` is not specified, the default branch will be used.
    - If the repository is a public repository (in GitHub), then you do not need to set `username`, `accessToken` and `sshKeyFile`.
    - If the repository is a private repository, then you need to set either the `username` and `accessToken` or `sshKeyFile`.

#### Step 2.2 - Authenticate the source watcher with the repository

The source watcher needs to be authenticated with the Git repository to fetch the artifacts. Authenticating the Git repository can be done in the following ways:

- [Using Username and Access Token]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/git-integration/#using-username-and-access-token)
- [Using SSH Key file]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/git-integration/#using-ssh-key-file)

__________________________________________

#### **Using the Username and Access Token**

To authenticate the repository with basic HTTP authentication, the username and access token should be set in the `username` and `accessToken` fields. The password can also be set in the `accessToken` field. It is recommended to use the personal access token for authentication. For public repositories (in GitHub), the `username` and `accessToken` fields can be kept empty.

1. Generate a personal access token.

     - [Creating a personal access token - GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
     - [Creating a personal access token - Bitbucket](https://confluence.atlassian.com/bitbucketserver/personal-access-tokens-939515499.html)
     - [Creating a personal access token - GitLab](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)

2. Configure Choreo Connect.

     Add the following configuration in the main configuration file of Choreo Connect (`config.toml` file).

    ```toml tab="Format"
      [adapter]

      artifactsDirectory = "<path_to_the_artifacts_directory>"

      [adapter.sourceControl]
        enabled = true
        pollInterval = 30
        retryInterval = 5
        maxRetryCount = 20
        artifactsDirectory = "<path_to_the_artifacts_directory>"
        [adapter.sourceControl.repository]
          URL = "https://<hostname>/<username_or_organization>/<repository-name>.git"
          branch = ""
          username = $env{git_username}
          accessToken = $env{git_access_token}
          sshKeyFile = ""
    ```

    ```toml tab="Example"
      [adapter]

      artifactsDirectory = "/home/wso2/git-artifacts"

      [adapter.sourceControl]
        enabled = true
        pollInterval = 30
        retryInterval = 5
        maxRetryCount = 20
        artifactsDirectory = "/home/wso2/git-artifacts"
        [adapter.sourceControl.repository]
          URL = "https://github.com/wso2/product-microgateway.git"
          branch = ""
          username = $env{git_username}
          accessToken = $env{git_access_token}
          sshKeyFile = ""
    ```

__________________________________________

#### **Using the SSH Key file**

To authenticate the repository with SSH key, the SSH private key file path should be set in the `sshKeyFile` field. 

1. Generate the SSH Keys that need to be used for authentication.

     - [Generating SSH keys - GitHub](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
     - [Generating SSH keys - Bitbucket](https://support.atlassian.com/bitbucket-cloud/docs/set-up-an-ssh-key)
     - [Generating SSH keys - GitLab](https://docs.gitlab.com/ee/ssh)

    !!! Important
        Make sure to keep the passphrase of the SSH key empty.

2. Configure Choreo Connect.

     Add the following configuration in the main configuration file of Choreo Connect (`config.toml` file).

    ```tab="Format"
      [adapter]

      artifactsDirectory = "<path_to_the_artifacts_directory>"

      [adapter.sourceControl]
      enabled = true
      pollInterval = 30
      retryInterval = 5
      maxRetryCount = 20
      artifactsDirectory = "<path_to_the_artifacts_directory>"
      [adapter.sourceControl.repository]
          URL = "git@<hostname>:<username>/<repository-name>.git"
          branch = ""
          username = ""
          accessToken = ""
          sshKeyFile = "/home/wso2/ssh-keys/<private_key_file>"
    ```

    ```tab="Example"
      [adapter]

      artifactsDirectory = "/home/wso2/git-artifacts"

      [adapter.sourceControl]
      enabled = true
      pollInterval = 30
      retryInterval = 5
      maxRetryCount = 20
      artifactsDirectory = "/home/wso2/git-artifacts"
      [adapter.sourceControl.repository]
          URL = "git@github.com:wso2/product-microgateway.git"
          branch = ""
          username = ""
          accessToken = ""
          sshKeyFile = "/home/wso2/ssh-keys/id_ed25519"
    ```

3. Copy the generated private key file to the `docker-compose/resources/adapter/ssh-keys` directory.

4. Add volume mapping.

     1. Open the `docker-compose.yaml` file located in the `<CHOREO-CONNECT-HOME>/docker-compose/choreo-connect` directory. 
     2. Find the `volumes` section under the `adapter` and add the following volume mapping:

         ``` yml
         volumes:
             ...
             - ../resources/adapter/ssh-keys:/home/wso2/ssh-keys
         ```

5. Create a Dockerfile.

     When using authentication with a SSH key file, you need to create a custom Docker image of the Adapter as mentioned below:

    ```dockerfile tab='Format'
      FROM wso2/choreo-connect-adapter:<tag>

      USER root

      RUN apk add openssh-client

      RUN mkdir /home/wso2/.ssh && chown -R wso2:wso2 /home/wso2/.ssh \
          && ssh-keyscan -H <hostname> >> /home/wso2/.ssh/known_hosts

      USER wso2

      CMD eval "$(ssh-agent -s)" ; ssh-add /home/wso2/ssh-keys/* ; ./adapter
    ```

    ```dockerfile tab='Example'
      FROM wso2/choreo-connect-adapter:{{choreo_connect.version}}

      USER root

      RUN apk add openssh-client

      RUN mkdir /home/wso2/.ssh && chown -R wso2:wso2 /home/wso2/.ssh \
          && ssh-keyscan -H github.com >> /home/wso2/.ssh/known_hosts

      USER wso2

      CMD eval "$(ssh-agent -s)" ; ssh-add /home/wso2/ssh-keys/* ; ./adapter
    ```

6. Build the new image.

    ```bash tab='Format'
    docker build -t <IMAGE_NAME> -f <DOCKER_FILE_PATH> <CONTEXT>
    ```

    ```bash tab='Example'
    docker build -t myimages/choreo-connect-adapter-ssh:1.0.0 -f Dockerfile .
    ```

7. Update the `docker-compose.yaml` file with the new Adapter image.

### Step 3 - Start Choreo Connect

Start Choreo Connect on Docker Compose by executing the Docker Compose script inside the `<CHOREO-CONNECT_HOME>` directory.

1. Navigate to `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/` directory.

2. Execute the following command.
   
    ``` java
     docker-compose up -d
    ```

After the containers are up and running, you can monitor the status of the containers by using the following command.

 ``` java
 docker ps | grep choreo-connect-
 ```

### Step 4 - Invoke the sample API

#### Step 4.1 - Obtain a token

After the APIs are exposed via WSO2 Choreo Connect, you can invoke an API with a valid token (JWT) or by using a test key.

Let's use WSO2 Choreo Connect's test key endpoint to obtain an test key in order to access the API. For more information, see [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt).

``` tab="Sample Token"
TOKEN=$(curl -X POST "https://localhost:9095/testkey" -d "scope=read:pets" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)
```

!!! info "More information"
    You can obtain a JWT token from any third-party secure token service or via the WSO2 API Manager.

#### Step 4.2 - Invoke the API

Execute the following command to invoke the API using the test key. You can now invoke the API running on the WSO2 Choreo Connect using the following cURL command.

``` tab="Format"
curl -X GET "https://<CHOREO-CONNECT_ROUTER_HOST>:<CHOREO-CONNECT_ROUTER_PORT>/<API-context>/<API-resource>" -H "accept:application/xml" -H "Authorization:Bearer $TOKEN" -k
```
 
``` tab="Example"
curl -X GET "https://localhost:9095/v2/pet/findByStatus?status=available" -H "accept: application/xml" -H "Authorization:Bearer $TOKEN" -k
```
