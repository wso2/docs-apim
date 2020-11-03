
# Running WSO2 Micro Integrator on Containers

To run your Micro Integrator solutions on Docker or Kubernetes, you need
to first create an **immutable** docker image with the required synapse
artifacts, configurations, and third-party dependencies by using the
base Docker image of WSO2 Micro Integrator. You can then deploy and run
the immutable images on Docker or Kubernetes. One advantage of having an
immutable docker image is that you can easily implement a CI/CD pipeline
to systematically test the solution before deploying in production.

## Base Docker Images

Two types of base Docker images are available for the Micro Integrator:

-   The Micro Integrator Docker image (with the latest updates) is
    available in the [WSO2 Docker Registry](https://docker.wso2.com/).
    
    **Note** that you need a valid WSO2 subscription to use the Docker
    image with updates. Therefore, you need to provide your log in
    credentials when downloading the Docker image. If you do not already
    have a subscription, you can get a [free trial subscription](https://wso2.com/subscription/free-trial).

    **Micro Integrator Docker image (with updates)**

    ```bash
    docker.wso2.com/wso2mi:latest
    ```

    **Log in to WSO2 Docker Registry**

    ```bash
    docker login docker.wso2.com
    ```

-   The community version of WSO2 Micro Integrator's base Docker image is
    available on [DockerHub](https://hub.docker.com/r/wso2/wso2mi).
    
    **Base Docker Image and Tag (community version)**
    
    ```bash
    wso2/wso2mi:latest
    ```
    The **wso2mi:latest** tag points to the most lightweight version of the Micro Integrator, which includes the minimal Docker image based on **Alpine Linux**.
    
    Go to [DockerHub](https://hub.docker.com/r/wso2/wso2mi/tags) to find the Micro Integrator Docker images that are based on Ubuntu and CentOS platforms.

## Running the Micro Integrator on Docker

You can easily run your Micro Integrator solution in a Docker environment by using the <b>Docker Exporter</b> in [WSO2 Integration Studio](../../../develop/WSO2-Integration-Studio). 

### Create your integration solution

Once you have created your integration solution in WSO2 Integration Studio, you will have an integration project (maven multi module project) with all your integration artifacts. To run the solution on Docker, you need a <b>Docker Exporter</b> in the integration project.

Let's create a simple integration project with a Docker Exporter by running the <b>Hello Docker</b> sample template in WSO2 Integration Studio.

<img src="../../../assets/img/create_project/docker_k8s_project/hello-docker-template.png" width="700">

You will get the following integration project in the project explorer:

<img src="../../../assets/img/create_project/docker_k8s_project/hello-docker-proj-explorer.png" width="200">

### Build and Push the Docker image

Open the `pom.xml` file of your Docker Exporter module and update the details for your Docker image.

<img src="../../../assets/img/create_project/docker_k8s_project/hello-docker-pom.png" width="700">

-   The [base Docker image](#base-docker-images) to use.
-   The target Docker registry to which the Docker image should be published.

Click <b>Build</b> to first build the image, and then click <b>Push</b> to push the image to a Docker registry.

### Start Docker container

Start a container in your Docker environment. This command will pull the image from your Docker registry and start a container.

```bash
docker run -d -p 8290:8290 sample_docker_image
```

## Running the Micro Integrator on Kubernetes

Kubernetes is an open source container orchestration system for
automating, scaling, and managing your application deployments. 

You can easily run your Micro Integrator solution in a Kubernetes environment by using the <b>Kubernetes Exporter</b> in [WSO2 Integration Studio](../../../develop/WSO2-Integration-Studio) and the <b>EI Kubernetes Operator</b>.

See the [EI Kubernetes Operator samples](../../../setup/deployment/k8s-samples/hello-world) for instructions.

## Create Docker files manually

If you already have **packaged integration artifacts** in a CAR file, you can manually create the Docker files and deploy on Docker. Follow the steps given below.

!!! Tip
    **Before you begin**: Use WSO2 Integration Studio to create the integration artifacts and then [export the integration artifacts](../../develop/exporting-artifacts.md) into a CAR file.

1.  **Create the Dockerfile** as shown below. 

    This file contains instructions to download the base Docker image of WSO2 Micro Integrator from DockerHub (community version) or the WSO2 Docker Registry (includes updates), and to copy the integration artifacts
    to the Micro Integrator.  

    The **Dockerfile**:

    ```bash
    FROM <docker_image_name>:1.2.0
    COPY <directoy_path>/<capp_name> $WSO2_SERVER_HOME/repository/deployment/server/carbonapps
    ```
    The information specified in the Docker file is as follows:

    <table>
    <tbody>
    <tr>
        <th>Parameter</th>
        <th>Description</th>
    </tr>
    <tr class="odd">
    <td>FROM</td>
    <td><div class="content-wrapper">
    <p>The 'FROM' tag in the docker file specifies the WSO2 Micro Integrator version that should be downloaded. You can use the updated Docker image or the community version as shown below. The version is 1.2.0 of the WSO2 Micro Integrator. If required, you can use an earlier version by replacing 'latest' with the version number.</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
    <strong>Example 1: Docker image with updates</strong>
    </div>
    <div class="codeContent panelContent pdl">
    <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>FROM docker.<span class="fu">wso2</span>.<span class="fu">com</span>/wso2mi:<span class="fl">1.2.</span><span class="dv">0</span></span></code></pre></div>
    </div>
    </div>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
    <strong>Example 2: Docker image without updates (community version)</strong>
    </div>
    <div class="codeContent panelContent pdl">
    <div class="sourceCode" id="cb2" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb2-1"><a href="#cb2-1"></a>FROM wso2/wso2mi:<span class="fl">1.2.</span><span class="dv">0</span></span></code></pre></div>
    </div>
    </div>
    </div></td>
    </tr>
    <tr class="even">
    <td>COPY</td>
    <td><div class="content-wrapper">
    <p>The 'COPY' tag in the docker file specifies the directory path to your composite application, followed by the location in your Docker instance to which the composite application should be copied. 
    The location of MI_HOME can be referred to as 'WSO2_SERVER_HOME' since this is exposed as an environment variable from the base image.</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
    <strong>Example 1</strong>
    </div>
    <div class="codeContent panelContent pdl">
    <div class="sourceCode" id="cb3" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb3-1"><a href="#cb3-1"></a>COPY carbonapps $WSO2_SERVER_HOME/repository/deployment/server/carbonapps</span></code></pre></div>
    </div>
    </div>
    <p>If you have multiple composite application that you want to deploy in Docker using a single Docker image, add another entry to the Dockerfile. For example:</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
    <strong>Example 2</strong>
    </div>
    <div class="codeContent panelContent pdl">
    <div class="sourceCode" id="cb4" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb4-1"><a href="#cb4-1"></a>COPY carbonapps $WSO2_SERVER_HOME/repository/deployment/server/carbonapps</span>
    <span id="cb4-2"><a href="#cb4-2"></a>COPY &lt;sample_carbon_app&gt; $WSO2_SERVER_HOME/repository/deployment/server/carbonapps</span></code></pre></div>
    </div>
    </div>
    </div></td>
    </tr>
    </tbody>
    </table>

2.  **Create an immutable Docker image** for your integration artifacts on WSO2 Micro Integrator by executing the following command from the location of your Dockerfile.

    ```bash
    docker build -t sample_docker_image .
    ```

3.  **Start a Docker container** by running the Docker image as shown below.

    ```bash
    docker run -d -p 8290:8290 sample_docker_image
    ```
