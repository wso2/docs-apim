# Creating Docker Exporter

Create a Docker Exporter if you want to deploy your integration solutions inside a Docker environment. This project directory allows you to package multiple [integration modules]({{base_path}}/integrate/develop/create-integration-project) into a single Docker image and then build and push to the Docker registries.

## Creating the Docker exporter

Follow the steps given below.   

1. [Create a new integration project]({{base_path}}/integrate/develop/create-integration-project) and create a Docker Exporter by doing one of the following.

    1. As part of creating an integration project, you can select the **Docker Exporter** check box.

    2. You can right click on an existing integration project and select **New** -> **Docker Exporter**.

2. In the **New Docker Exporter** dialog box that opens, enter a name for the Docker exporter and other parameters as shown below.

    <img src="{{base_path}}/assets/img/integrate/new-project/docker-exporter.png" width="500">

    Enter the following information:

    <table>
        <tr>
            <th>
                Parameter
            </th>
            <th>
                Description
            </th>
        </tr>
        <tr>
            <td>
                Docker Exporter Name
            </td>
            <td>
                <b>Required</b>. Give a name for the Docker project.
            </td>
        </tr>
        <tr>
            <td>
                Base Image Repository
            </td>
            <td>
                <b>Required</b>. Select the base Micro Integrator Docker image for your solution. Use one of the following options:
                <ul>
                    <li>
                        <b>wso2/wso2mi</b>: This is the community version of the Micro Integrator Docker image, which is stored in the <a href="https://hub.docker.com/r/wso2/wso2mi">public WSO2 Docker registry</a>. This is selected by default.
                    </li>
                    <li>
                        <b>docker.wso2.com</b>: This is the Micro Integrator Docker image that includes <b>product updates</b>. This image is stored in the <a href="https://docker.wso2.com/tags.php?repo=wso2mi">private WSO2 Docker registry</a>.
                        Note that you need a valid <a href="https://wso2.com/subscription/free-trial">WSO2 subscription</a> to use the Docker image with updates.
                    </li>
                    <li>
                        You can also use a custom Docker image from a custom repository.
                    </li>
                </ul>
                If you specify a Docker image from a private repository, note that you need to log in to your repository from a terminal before you build the image (as explained below).
            </td>
        </tr>
            <td>
                Base Image Tag
            </td>
            <td>
                <b>Required</b>. Specify the tag of the base image that you are using.
            </td>
        <tr>
        </tr>
        <tr>
            <td>
                Target Image Repository
            </td>
            <td>
                <b>Required</b>. The Docker repository to which you will later push this Docker image. 
                <ul>
                    <li>
                        If your repository is in <b>Docker Hub</b>, use the <b>docker_user_name/repository_name</b> format.
                    </li>
                    <li>
                        If you are using any other repository, use the <b>repository_url/repository_user_name/repository_name</b> forrmat.
                    </li>
                </ul> 
                If required, you can update this information later when you build the Docker image or when you push the image to the relevant repository.
            </td>
        </tr>
        <tr>
            <td>
                Target Image Tag
            </td>
            <td>
                <b>Required</b>. Give a tag name for the Docker image.
            </td>
        </tr>
        <tr>
            <td>
                Environment Variables
            </td>
            <td>
                You can enter multiple environment variables as key-value pairs.
            </td>
        </tr>
    </table>

3.  Optionally, click **Next** and configure Maven details for the Docker exporter.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/new_docker_project_maven_info.png" width="500">

4.  Click **Finish**. The Docker exporter is created in the project explorer.
5.  This step is only required if you already have a Docker image (in your local Docker repository) with the same name as the base image specified above. 
    
    !!! Info
        In this scenario, WSO2 Integration Studio will first check if there is a difference in the two images before pulling the image specified in the **Base Image Repository** field. If the given base image is more updated, the existing image will be overwritten by this new image. Therefore, if you are currently using an older version, or if you have custom changes in your existing image, they will be replaced. 
        
    To avoid your existing custom/older images from being replaced, add the following property under **dockerfile-maven-plugin -> executions -> execution -> configurations** in the `pom.xml` file of your Docker Exporter project. This configuration will ensure that the base image will not be pulled when a Docker image already exists with the same name.
            
    ```xml
    <pullNewerImage>false</pullNewerImage>
    ```

## The Docker Exporter directory

Expand the **Docker Exporter** in the project explorer. See that the following folders and files are created:

<img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/proj_explorer_docker_project.png" width="400">

<table>
    <tr>
        <th>
            Directory
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            Libs
        </td>
        <td>
            This folder stores libraries that should be copied to the Docker image. During the build time, the libraries inside this directory will be copied to the image.
        </td>
    </tr>
    <tr>
        <td>
            Resources
        </td>
        <td>
            This folder stores additional files and resources that should be copied to the Docker image. During the build time, the resources inside this directory will be copied to the image.
        </td>
    </tr>
    <tr>
        <td>
            deployment.toml
        </td>
        <td>
            The <a href="{{base_path}}/reference/config-catalog">product configuration file</a>.
        </td>
    </tr>
    <tr>
        <td>
            Dockerfile
        </td>
        <td>
            The Dockerfile containing the build details.
        </td>
    </tr>
    <tr>
        <td>
            pom.xml
        </td>
        <td>
            The file for selecting the relevant composite exporters that should be included in the Docker image. This information is also used when you later build and push Docker images to the Docker registries.
        </td>
    </tr>
</table>
    
## Build and Push Docker images

Before you begin:

-   Create your integration artifacts in an [ESB Config sub project]({{base_path}}/integrate/develop/create-integration-project/#sub-projects) and package the artifacts in a [Composite Exporter]({{base_path}}/integrate/develop/packaging-artifacts/#sub-projects). For example, see the HelloWorld sample given below.

    <img alt="Integration artifacts for Docker" src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/integration-projects-for-docker.png" width="300">

-   Be sure to start your Docker instance before building the image. If Docker is not started, the build process will fail.

-   If you are using a Micro Integrator Docker image from a private registry as your base image:

    1.  Open a terminal and use the following command to log in to Docker:
        ```bash 
        docker login -u username -p password 
        ```
    2.  In the next step, specify the name of the private Docker registry.

To <b>build</b> and <b>push</b> the Docker image:

!!! Note
    As an alternative, you can skip the steps given below and manually build and push the Docker images using <b>maven</b>. Open a terminal, navigate to the Docker exporter and execute the following command:

    ```bash
    mvn clean install -Dmaven.test.skip=true -Ddockerfile.username={username} -Ddockerfile.password={password} 
    ```

    However, note that you need **Maven 3.5.2** or a later version when you build the Docker image manually (without using WSO2 Integration Studio).

1.  Open the **pom.xml** file inside the Docker project and click **Refresh** on the top-right. Your composite application project with integration artifacts will be listed under **Dependencies** as follows:

    <img alt="Docker Pom view" src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/docker-pom.png" width="700">
    
2.  Select the composite exporters that you want to package inside the Docker image.
3.  If required, you can update the **Target Repository** to which the image should be pushed and the **Target Tag**.
4.  Save the POM file and click **Build** to start the Docker image build.
5.  It will build the Docker image based on the Dockerfile and the Target details. When the image is created, the following message will display. 

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/build.png" alt="Docker Build Success">

6.  Click <b>Push</b> to push the Docker image to your Docker registry. 

    In the dialog box that opens, provide the details of your Docker registry as shown below.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/docker-registry-credentials.png">

    When the image is pushed to the registry, you will see the following message.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/push.png" alt="Docker Push Success">
